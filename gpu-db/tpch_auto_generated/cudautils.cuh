#pragma once



#include <iostream>
#include <map>
#include <vector>

#include <arrow/array.h>
#include <arrow/table.h>
__device__ void aggregate_sum(int64_t* a, int64_t v) {
    atomicAdd((int*)a, (int)v);
  }
  __device__ void aggregate_sum(int32_t* a, int32_t v) {
    atomicAdd((int*)a, (int)v);
  }
  __device__ void aggregate_sum(float* a, float v) {
    atomicAdd(a, v);
  }
  __device__ void aggregate_any(int32_t* a, int32_t v) {
    *a = v;
  }



template<int Radix>
struct DBDecimalColumn {
  __int128* buffer;
  size_t radix = Radix;
  __int128_t operator[](unsigned long long i) {
    return buffer[i];  
  }
};

typedef DBDecimalColumn<2> DBDecimalPrecisionType;

typedef char* DBStringType;
typedef int32_t DBDateType;
typedef double DBDecimalType;

DBStringType* readStringColumn(std::shared_ptr<arrow::Table>& table, const std::string& column) {
  auto arrowCol = table->GetColumnByName(column);
  DBStringType* res;
  auto resSize = 0ull;
  for (auto chunk: arrowCol->chunks()) {
    auto stringArr = std::static_pointer_cast<arrow::LargeStringArray>(chunk);
    for (auto i=0ull; i < stringArr->length(); i++) {
      std::string str = stringArr->GetString(i);
      resSize += (str.size() + 1); // null terminated string
    }
  }
  char* CStringBuffer = (char*)malloc(sizeof(char) * resSize);
  memset(CStringBuffer, '\0', sizeof(char) * resSize);
  
  res = (DBStringType*)malloc(sizeof(DBStringType) * table->num_rows());
  resSize = 0ull;
  auto resIdx = 0ull;
  for (auto chunk: arrowCol->chunks()) {
    auto stringArr = std::static_pointer_cast<arrow::LargeStringArray>(chunk);
    for (auto i=0ull; i < stringArr->length(); i++) {
      res[resIdx] = CStringBuffer + resSize;

      std::string str = stringArr->GetString(i);
      for (auto i=0ull; i<str.size(); i++) {
        CStringBuffer[resSize + i] = str[i];
      }
      resSize += (str.size() + 1);
      resIdx++;
    }
  }
  return res;
}

char* readCharColumn(std::shared_ptr<arrow::Table>& table, const std::string &column) {
  auto res = (char*)malloc(sizeof(char) * table->num_rows());
  auto arrowCol = table->GetColumnByName(column);
  auto idx = 0ull;
  for (auto chunk:arrowCol->chunks()) {
    auto strArr = std::static_pointer_cast<arrow::LargeStringArray>(chunk);
    for (auto i=0ull; i<strArr->length(); i++)
    {
      res[idx++] = strArr->GetString(i)[0];
    }
  }
  return res;
}

DBDateType* readDateColumn(std::shared_ptr<arrow::Table>& table, const std::string &column) {
  auto res = (DBDateType*)malloc(sizeof(DBDateType) * table->num_rows());
  auto arrowCol = table->GetColumnByName(column);
  auto idx = 0ull;
  for (auto chunk:arrowCol->chunks()) {
    auto dateArr = std::static_pointer_cast<arrow::Date32Array>(chunk);
    for (auto i=0ull; i<dateArr->length(); i++)
    {
      res[idx++] = (DBDateType)dateArr->Value(i);
    }
  }
  return res;
}

DBDecimalType* readDecimalColumn(std::shared_ptr<arrow::Table>& table, const std::string &column) {
  auto res = (DBDecimalType*)malloc(sizeof(DBDecimalType) * table->num_rows());
  auto arrowCol = table->GetColumnByName(column);
  auto idx = 0ull;
  for (auto chunk: arrowCol->chunks()) {
    auto arr = std::static_pointer_cast<arrow::DoubleArray>(chunk);
    for (auto i=0ull; i<arr->length(); i++) {
      res[idx++] = (DBDecimalType)arr->Value(i);
    }
  }
  return res;
}
__int128_t double_to_int128(double x, int radix) {
  // Union to access raw IEEE 754 bits
  union {
      double d;
      uint64_t u;
  } value = { x * (std::pow(10, radix)) };

  // Extract sign, exponent, and mantissa
  uint64_t sign = value.u >> 63;
  int64_t exponent = ((value.u >> 52) & 0x7FF) - 1023;
  uint64_t mantissa = (value.u & 0xFFFFFFFFFFFFF) | (1ULL << 52); // Add implicit leading 1

  // Convert to 128-bit integer
  __int128_t result = mantissa;
  
  if (exponent > 52) {
      result <<= (exponent - 52);  // Left shift if exponent is large
  } else if (exponent < 52) {
      result >>= (52 - exponent);  // Right shift if exponent is small
  }

  // Apply sign
  return sign ? -result : result;
}
DBDecimalPrecisionType readDecimalPrecisionColumn(std::shared_ptr<arrow::Table>& table, const std::string &column) {
  auto res = (__int128_t*)malloc(sizeof(__int128_t) * table->num_rows());
  auto arrowCol = table->GetColumnByName(column);
  auto idx = 0ull;
  for (auto chunk: arrowCol->chunks()) {
    auto arr = std::static_pointer_cast<arrow::DoubleArray>(chunk);
    for (auto i=0ull; i<arr->length(); i++) {
      res[idx++] = double_to_int128((double)arr->Value(i), 2);
    }
  }
  DBDecimalPrecisionType returnRes;
  returnRes.buffer = res;
  return returnRes;
}
