#pragma once
#include <arrow/array.h>
#include <arrow/io/api.h>
#include <arrow/record_batch.h>
#include <arrow/table.h>
#include <parquet/arrow/reader.h>
#include <iostream>
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

void PrintColumnTypes(const std::shared_ptr<arrow::Table>& table) {
    auto schema = table->schema();
    for (int i = 0; i < schema->num_fields(); ++i) {
        auto field = schema->field(i);
        std::cout << "Column " << i << ": " << field->name() 
                  << " -> " << field->type()->ToString() << std::endl;
    }
}