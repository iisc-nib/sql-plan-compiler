#pragma once



#include <iostream>
#include <map>
#include <vector>

#include <arrow/array.h>
#include <arrow/table.h>
#include "db_types.h"
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
__device__ void aggregate_count(int64_t* a, float v) {
  atomicAdd((int*)a, 1);
}





enum class Predicate {
  eq, like, lt, gt, lte, gte, neq
};



__device__ static inline bool evaluatePredicate(DBStringType str1, DBStringType str2, Predicate pred) {
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
    default:
    break;
  }
  return false;
}



__device__ static inline bool evaluatePredicate(DBCharType l, DBCharType r, Predicate pred) {
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
__device__ static inline bool evaluatePredicate(DBDecimalType l, DBDecimalType r, Predicate pred) {
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
__device__ static inline bool evaluatePredicate(DBI64Type l, DBI64Type r, Predicate pred) {
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
__device__ static inline bool evaluatePredicate(DBI32Type l, DBI32Type r, Predicate pred) {
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