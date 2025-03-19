#pragma once
#include <arrow/array.h>
#include <arrow/io/api.h>
#include <arrow/record_batch.h>
#include <arrow/table.h>
#include <parquet/arrow/reader.h>
#include <iostream>
#include "db_types.h"
inline std::string getDataDir(const char** argv, int32_t argc)
{
  std::string dataDir;
  for (int32_t i = 0; i < argc; i++) {
    if (std::string(argv[i]) == "--data_dir") {
      if (i + 1 < argc) { dataDir = std::string(argv[i + 1]); }
      break;
    }
  }
  if (dataDir.empty()) {
    std::cerr << "Required input \"--data_dir <data_dir>\" not specified!" << std::endl;
    throw std::runtime_error("Required input \"--data_dir <data_dir>\" not specified!");
  }

  // assert dbDir is a valid directory and ends with '/'
  assert(dataDir.size() != 0 &&
         dataDir.back() == '/');  // && fs::is_directory(dbDir)); // This needs C++ 17. Skip for now

  std::cout << "Data directory: " << dataDir << std::endl;

  return dataDir;
}
arrow::Status read_parquet(std::string path_to_file, std::shared_ptr<arrow::Table>& table)
{
  arrow::MemoryPool* pool = arrow::default_memory_pool();
  // open file
  std::shared_ptr<arrow::io::RandomAccessFile> input;
  ARROW_ASSIGN_OR_RAISE(input, arrow::io::ReadableFile::Open(path_to_file));
  // initialize file reader
  std::unique_ptr<parquet::arrow::FileReader> arrow_reader;
  ARROW_RETURN_NOT_OK(parquet::arrow::OpenFile(input, pool, &arrow_reader));

  ARROW_RETURN_NOT_OK(arrow_reader->ReadTable(&table));

  return arrow::Status::OK();
}
std::shared_ptr<arrow::Table> getArrowTable(std::string dbDir, std::string parquetFile) {
  std::shared_ptr<arrow::Table> res;
  std::cout << "File name: " << dbDir + parquetFile + ".parquet" << std::endl;
  arrow::Status st = read_parquet(dbDir + parquetFile + ".parquet", res);
  if (st != arrow::Status::OK()) {
    std::cerr << st.ToString();
    return nullptr;
  }
  return res;
}



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

DBCharType* readCharColumn(std::shared_ptr<arrow::Table>& table, const std::string &column) {
  auto res = (DBCharType*)malloc(sizeof(DBCharType) * table->num_rows());
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

template<typename T>
T* readIntegerColumn(std::shared_ptr<arrow::Table> &table, const std::string &column) {
    auto res = (T*)malloc(sizeof(T) * table->num_rows());
    auto arrowCol = table->GetColumnByName(column);
    auto idx = 0ull;
    for (auto chunk: arrowCol->chunks()) {
        auto arr = std::static_pointer_cast<arrow::Int64Array>(chunk);
        for (auto i=0ull; i<arr->length(); i++) {
        res[idx++] = (T)arr->Value(i);
        }
    }
    return res;
}

#ifdef PRINTSCHEMA
void PrintColumnTypes(const std::shared_ptr<arrow::Table>& table) {
    auto schema = table->schema();
    for (int i = 0; i < schema->num_fields(); ++i) {
        auto field = schema->field(i);
        std::cout << "Column " << i << ": " << field->name() 
                  << " -> " << field->type()->ToString() << std::endl;
    }
}
#endif

#ifdef DECIMAL_PRECISION
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
#endif