#pragma once



#include <iostream>
#include <map>
#include <vector>

#include <arrow/array.h>
#include <arrow/table.h>
#include "db_types.h"

#include <cuco/static_map.cuh>
#include <cuco/static_multimap.cuh>


template <typename T>
class HostBuffer {
  T* buffer;
  size_t length;
public:
  HostBuffer(size_t length) : length(length) {
    buffer = (T*)malloc(length * sizeof(T));
  }
  ~HostBuffer() {
    free(buffer);
  }
  T* getHostPtr() {
    return buffer;
  }
  void copyToDevice(T* d_buffer, size_t length) {
    cudaMemcpy(d_buffer, buffer, length * sizeof(T), cudaMemcpyHostToDevice);
  }
  void copyFromDevice(T* d_buffer, size_t length) {
    cudaMemcpy(buffer, d_buffer, sizeof(T) * length, cudaMemcpyDeviceToHost);
  }
  void clear() {
    memset(buffer, 0, sizeof(T) * length);
  }
};

__device__ void aggregate_sum(int64_t* a, int64_t v) {
  atomicAdd((int*)a, (int)v);
}
__device__ void aggregate_sum(int32_t* a, int32_t v) {
  atomicAdd((int*)a, (int)v);
}
__device__ void aggregate_sum(float* a, float v) {
  atomicAdd(a, v);
}
__device__ void aggregate_sum(double* a, double v) {
  atomicAdd(a, v);
}
__device__ void aggregate_any(int32_t* a, int32_t v) {
  *a = v;
}
__device__ void aggregate_any(char** a, char* v) {
  *a = v;
}
__device__ void aggregate_any(double* a, double v) {
  *a = v;
}
__device__ void aggregate_count(int64_t* a, float v) {
  atomicAdd((int*)a, 1);
}

template<typename HT>
__global__ void insertKeys(int64_t* keys, HT ht, size_t size) {
  size_t tid = blockDim.x * blockIdx.x + threadIdx.x;
  if (tid >= size) return;

  ht.insert(cuco::pair{keys[tid], tid});
}
template<typename HASHTABLE_INSERT>
__device__ int64_t get_aggregation_slot(int64_t key, HASHTABLE_INSERT HT_0, int* idx) {
  auto [slot, is_new_key] = HT_0.insert_and_find(cuco::pair{key, -2});
  // are there any concurrency issues in below code? please answer in comments
  auto ref = cuda::atomic_ref<int64_t, cuda::thread_scope_device>{slot->second};
  if (is_new_key) {
      ref.store(atomicAdd(idx, 1), cuda::memory_order_relaxed);
  } else {
      while(ref.load(cuda::memory_order_relaxed) == -2) {
          // spin
      }
  }
  return ref.load(cuda::memory_order_relaxed);
}
// TODO(avinash): right now only implemented the extract year 
__device__ static inline DBI64Type ExtractFromDate(const char* attr, DBDateType date) {
  DBI64Type result = 1970;
  int days[] = {365, 730, 1096, 1461, 1826, 2191, 2557, 2922, 3287, 3652, 4018, 4383, 4748, 5113, 5479, 5844, 6209, 6574, 6940, 7305, 7670, 8035, 8401, 8766, 9131, 9496, 9862, 10227, 10592, 10957, 11323, 11688, 12053, 12418, 12784, 13149, 13514, 13879, 14245, 14610, 14975, 15340, 15706, 16071, 16436, 16801, 17167, 17532, 17897, 18262, 18628, 18993, 19358, 19723, 20089, 20454, 20819, 21184, 21550, 21915};

  for (int i=0; i<60; i++) {
    if (date < days[i]) return result+i;
  }
  return -1;
}


enum class Predicate {
  eq, like, lt, gt, lte, gte, neq
};



__device__ static inline bool evaluatePredicate(const DBStringType str1, const DBStringType str2, Predicate pred) {
  int i = 0, j = 0;
  switch (pred) {
    case Predicate::eq:
    {
      while(str1[i]!='\0' && str2[j]!='\0') {
        if (str1[i++] != str2[j++]) return false;
      }
      return str1[i] == str2[j];
    }
    break;
    case Predicate::like:
    {
      //TODO(avinash, p2): handle the like operator 
      printf("%s\n", str2);
      return true;
    }
    case Predicate::lte: {
      while(str1[i]!='\0' && str2[j]!='\0') {
        if (str1[i] < str2[j]) return true;
        else if (str1[i] > str2[j]) return false;
        i++;
        j++;
      }
      return str1[i] == '\0' && str2[j] == '\0';
    }
    break;
    case Predicate::gte: {
      while(str1[i]!='\0' && str2[j]!='\0') {
        if (str1[i] > str2[j]) return true;
        else if (str1[i] < str2[j]) return false;
        i++;
        j++;
      }
      return str1[i] == '\0' && str2[j] == '\0';
    }
    break;
    default:
    break;
  }
  return false;
}



__device__ static inline bool evaluatePredicate(const DBCharType l, const DBCharType r, Predicate pred) {
  switch(pred) {
    case Predicate::eq: {
      return l == r;
    }
    break;
    case Predicate::lt: {

      return l < r;
    }
    break;
    case Predicate::gt: {
      return l > r;
    }
    break;
    case Predicate::lte: {
      return l <= r;
    }
    break;
    case Predicate::gte: {
      return l >= r;
    }
    case Predicate::neq: {
      return l != r;
    }
    break;
    default:
    break;
  }
  return false;
}
__device__ static inline bool evaluatePredicate(const DBDecimalType l, const DBDecimalType r, Predicate pred) {
  switch(pred) {
    case Predicate::eq: {
      return l == r;
    }
    break;
    case Predicate::lt: {

      return l < r;
    }
    break;
    case Predicate::gt: {
      return l > r;
    }
    break;
    case Predicate::lte: {
      return l <= r;
    }
    break;
    case Predicate::gte: {
      return l >= r;
    }
    case Predicate::neq: {
      return l != r;
    }
    break;
    default:
    break;
  }
  return false;
}
__device__ static inline bool evaluatePredicate(const DBI64Type l, const DBI64Type r, Predicate pred) {
  switch(pred) {
    case Predicate::eq: {
      return l == r;
    }
    break;
    case Predicate::lt: {

      return l < r;
    }
    break;
    case Predicate::gt: {
      return l > r;
    }
    break;
    case Predicate::lte: {
      return l <= r;
    }
    break;
    case Predicate::gte: {
      return l >= r;
    }
    case Predicate::neq: {
      return l != r;
    }
    break;
    default:
    break;
  }
  return false;
}
__device__ static inline bool evaluatePredicate(const DBI32Type l, const DBI32Type r, Predicate pred) {
  switch(pred) {
    case Predicate::eq: {
      return l == r;
    }
    break;
    case Predicate::lt: {

      return l < r;
    }
    break;
    case Predicate::gt: {
      return l > r;
    }
    break;
    case Predicate::lte: {
      return l <= r;
    }
    break;
    case Predicate::gte: {
      return l >= r;
    }
    case Predicate::neq: {
      return l != r;
    }
    break;
    default:
    break;
  }
  return false;
}


DBStringType* allocateAndTransferStrings(DBStringType* h_strings, size_t table_size) {
  char* d_buffer;
  auto buf_size = 0ull;
  for (auto i=0ull; i<table_size-1; i++) {
    buf_size += (size_t)h_strings[i+1] - (size_t)h_strings[i];
  }
  // count last string separately
  for (auto i=0ull; h_strings[table_size-1][i] != '\0'; i++) {
    buf_size++;
  }

  cudaMalloc(&d_buffer, sizeof(char)*buf_size);
  cudaMemcpy(d_buffer, h_strings[0], sizeof(char)*buf_size, cudaMemcpyHostToDevice);

  DBStringType* d_strings; 
  DBStringType* hd_strings;
  hd_strings = (DBStringType*)malloc(sizeof(DBStringType) * table_size);
  hd_strings[0] = d_buffer;
  for (auto i=1ull; i<table_size; i++) {
    hd_strings[i] = (DBStringType)((size_t)hd_strings[i-1] + ((size_t)h_strings[i] - (size_t)h_strings[i-1]));
  }
  cudaMalloc(&d_strings, sizeof(DBStringType)*table_size);
  cudaMemcpy(d_strings, hd_strings, sizeof(DBStringType)*table_size, cudaMemcpyHostToDevice);
  free(hd_strings);

  return d_strings;
}

template<typename T>
T* allocateAndTransfer(T* h_data, size_t table_size) {
  T* d_data;
  cudaMalloc(&d_data, sizeof(T)*table_size);
  cudaMemcpy(d_data, h_data, sizeof(T)*table_size, cudaMemcpyHostToDevice);
  return d_data;
}

// --- [Start] Pyper Shuffle Constructs --- //

typedef size_t idx_type_t;
#define USE_STRUCT_OF_ARRAYS 0

struct shuffle_buffer_type_aos {
  idx_type_t row_idx; // row_idx of the row that was being processed by this thread
  idx_type_t buf_idx; // value of the hash table slot. Points to tuples of row_ids for join
  idx_type_t second_buf_idx;
};

struct shuffle_buffer_type_soa {
  idx_type_t row_idx[128]; // row_idx of the row that was being processed by this thread
  idx_type_t buf_idx[128]; // value of the hash table slot. Points to tuples of row_ids for join  
};

#if USE_STRUCT_OF_ARRAYS

#define SHUFFLE_BUFFER_INIT(buffer_size) \
        __shared__ uint32_t shuffle_buf_idx; \
        __shared__ shuffle_buffer_type_soa shuffle_buf; \
        bool threadActive = true; \
        if (threadIdx.x == 0) { \
            shuffle_buf_idx = 0; \
        } \
        __syncthreads();

// struct of arrays version
__device__ void save_to_shuffle_buffer(idx_type_t row_idx, idx_type_t slot_buf_idx, uint32_t* shuffle_buf_idx, shuffle_buffer_type_soa* shuffle_buf) {
  auto old_shuffle_buf_idx = atomicAdd_block(shuffle_buf_idx, 1);
  shuffle_buf->row_idx[old_shuffle_buf_idx] = row_idx;
  shuffle_buf->buf_idx[old_shuffle_buf_idx] = slot_buf_idx;
}

__device__ void retrieve_from_shuffle_buffer(uint32_t shuffle_buf_idx, idx_type_t *row_idx, idx_type_t *slot_buf_idx, shuffle_buffer_type_soa* shuffle_buf) {
  *row_idx = shuffle_buf->row_idx[shuffle_buf_idx];
  *slot_buf_idx = shuffle_buf->buf_idx[shuffle_buf_idx];
}

#else

#define SHUFFLE_BUFFER_INIT(buffer_size) \
        __shared__ uint32_t shuffle_buf_idx; \
        __shared__ shuffle_buffer_type_aos shuffle_buf[buffer_size]; \
        bool threadActive = true; \
        if (threadIdx.x == 0) { \
            shuffle_buf_idx = 0; \
        } \
        __syncthreads();

#define RESET_SHUFFLE_BUF_IDX() \
        if (threadIdx.x == 0) \
          shuffle_buf_idx = 0; \
        __syncthreads();
        
// array of structs version
__device__ void save_to_shuffle_buffer(idx_type_t row_idx, idx_type_t slot_buf_idx, uint32_t* shuffle_buf_idx, shuffle_buffer_type_aos* shuffle_buf) {
  auto old_shuffle_buf_idx = atomicAdd_block(shuffle_buf_idx, 1);
  shuffle_buf[old_shuffle_buf_idx].row_idx = row_idx;
  shuffle_buf[old_shuffle_buf_idx].buf_idx = slot_buf_idx;
}

__device__ void retrieve_from_shuffle_buffer(uint32_t shuffle_buf_idx, idx_type_t *row_idx, idx_type_t *slot_buf_idx, shuffle_buffer_type_aos* shuffle_buf) {
  *row_idx = shuffle_buf[shuffle_buf_idx].row_idx;
  *slot_buf_idx = shuffle_buf[shuffle_buf_idx].buf_idx;
}

// array of structs version
__device__ void save_to_shuffle_buffer(idx_type_t row_idx, idx_type_t slot_buf_idx, idx_type_t second_buf_idx, uint32_t* shuffle_buf_idx, shuffle_buffer_type_aos* shuffle_buf) {
  auto old_shuffle_buf_idx = atomicAdd_block(shuffle_buf_idx, 1);
  shuffle_buf[old_shuffle_buf_idx].row_idx = row_idx;
  shuffle_buf[old_shuffle_buf_idx].buf_idx = slot_buf_idx;
  shuffle_buf[old_shuffle_buf_idx].second_buf_idx = second_buf_idx;
}

__device__ void retrieve_from_shuffle_buffer(uint32_t shuffle_buf_idx, idx_type_t *row_idx, idx_type_t *slot_buf_idx, idx_type_t *second_buf_idx, shuffle_buffer_type_aos* shuffle_buf) {
  *row_idx = shuffle_buf[shuffle_buf_idx].row_idx;
  *slot_buf_idx = shuffle_buf[shuffle_buf_idx].buf_idx;
  *second_buf_idx = shuffle_buf[shuffle_buf_idx].second_buf_idx;
}

#endif

#define RETURN_IF_THREAD_BEYOND_SHUFFLE() if (threadIdx.x >= shuffle_buf_idx) return;
#define INVALIDATE_IF_THREAD_BEYOND_SHUFFLE() if (threadIdx.x >= shuffle_buf_idx) threadActive = false;

#define PRINT_SHUFFLE_MAX() \
        if (threadIdx.x == 0) { \
            printf("Max shuffle buffer size: %d\n", shuffle_buf_idx); \
        }

// --- [End] Pyper Shuffle Constructs --- //