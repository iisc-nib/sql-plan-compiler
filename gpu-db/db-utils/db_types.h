#pragma once
#include <cstdint>
#include <unordered_map>
#include <string>

#ifdef DECIMAL_PRECISION
template<int Radix>
struct DBDecimalColumn {
  __int128* buffer;
  size_t radix = Radix;
  __int128_t operator[](unsigned long long i) {
    return buffer[i];  
  }
};

typedef DBDecimalColumn<2> DBDecimalPrecisionType;
#endif

typedef const char* DBStringType;
typedef int32_t DBDateType;
typedef double DBDecimalType;
typedef int16_t DBI16Type;
typedef int32_t DBI32Type;
typedef int64_t DBI64Type;
typedef char DBCharType;

struct DBStringEncodedType {
  DBI16Type* buffer;
  std::unordered_map<std::string, DBI16Type> dict;
  std::unordered_map<DBI16Type, std::string> rev_dict;
  int8_t operator[](unsigned long long i) {
    return buffer[i];  
  }
};
