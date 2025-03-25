#pragma once
#include <cstdint>

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

typedef char* DBStringType;
typedef int32_t DBDateType;
typedef double DBDecimalType;
typedef int32_t DBI32Type;
typedef int64_t DBI64Type;
typedef char DBCharType;
