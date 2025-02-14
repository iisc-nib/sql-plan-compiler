
cmake_minimum_required(VERSION 3.23.1 FATAL_ERROR)

project(GPUDB VERSION 0.0.1 LANGUAGES CXX CUDA)


###################################################################################################
# - compiler function -----------------------------------------------------------------------------

# Optionally specify paths to custom builds
option(ARROW_USE_CUSTOM_PATH "Use a custom Arrow build" OFF)
option(PARQUET_USE_CUSTOM_PATH "Use a custom Parquet build" OFF)

# If the user wants to specify custom paths, provide CMake options for them
if(ARROW_USE_CUSTOM_PATH)
    set(ARROW_ROOT "" CACHE PATH "Path to custom Arrow build")
endif()

if(PARQUET_USE_CUSTOM_PATH)
    set(PARQUET_ROOT "" CACHE PATH "Path to custom Parquet build")
endif()

# Try to find Arrow and Parquet packages (global/system installation)
if(NOT ARROW_USE_CUSTOM_PATH)
    find_package(Arrow CONFIG REQUIRED)
endif()

if(NOT PARQUET_USE_CUSTOM_PATH)
    find_package(Parquet CONFIG REQUIRED)
endif()

# If custom paths are specified, manually set the include and library directories
if(ARROW_USE_CUSTOM_PATH AND ARROW_ROOT)
    message(STATUS "Using custom Arrow build at ${ARROW_ROOT}")
    include_directories(${ARROW_ROOT}/include)
    link_directories(${ARROW_ROOT}/lib)
    set(ARROW_LIBS ${ARROW_ROOT}/lib/libarrow.so)
else()
    message(STATUS "Using system-installed Arrow")
    set(ARROW_LIBS libarrow.so)  # Automatically found by find_package
endif()

if(PARQUET_USE_CUSTOM_PATH AND PARQUET_ROOT)
    message(STATUS "Using custom Parquet build at ${PARQUET_ROOT}")
    include_directories(${PARQUET_ROOT}/include)
    link_directories(${PARQUET_ROOT}/lib)
    set(PARQUET_LIBS ${PARQUET_ROOT}/lib/libparquet.so)
else()
    message(STATUS "Using system-installed Parquet")
    set(PARQUET_LIBS libparquet.so)  # Automatically found by find_package
endif()
include(CMakePrintHelpers)
message("parqut libs")
cmake_print_variables(PARQUET_LIBS)
message("arrow libs")
cmake_print_variables(ARROW_LIBS)

include(/media/ajayakar/space/src/CPM.cmake/cmake/CPM.cmake)
CPMAddPackage(
    NAME CCCL
    GITHUB_REPOSITORY nvidia/cccl
    GIT_TAG main # Fetches the latest commit on the main branch
)
CPMAddPackage(
  NAME cuco
  GITHUB_REPOSITORY NVIDIA/cuCollections
  GIT_TAG dev
  OPTIONS
     "BUILD_TESTS OFF"
     "BUILD_BENCHMARKS OFF"
     "BUILD_EXAMPLES OFF"
)


function(ConfigureExample EXAMPLE_NAME EXAMPLE_SRC)
    add_executable(${EXAMPLE_NAME} "${EXAMPLE_SRC}")
    set_target_properties(${EXAMPLE_NAME} PROPERTIES
                                          RUNTIME_OUTPUT_DIRECTORY "${CMAKE_BINARY_DIR}")
    target_include_directories(${EXAMPLE_NAME} PRIVATE
                                             "${CMAKE_CURRENT_SOURCE_DIR}"
                                              ${arrow_BINARY_DIR}/cpp/src
                                              )
    set_property(TARGET ${EXAMPLE_NAME} PROPERTY CUDA_ARCHITECTURES 80)
    target_compile_options(${EXAMPLE_NAME} PRIVATE --compiler-options=-Wall --compiler-options=-Wextra
      --expt-extended-lambda -Xcompiler -Wno-subobject-linkage -lineinfo -g -fdump-tree-original)
    target_link_libraries(${EXAMPLE_NAME} cuco ${ARROW_LIBS} ${PARQUET_LIBS})
endfunction(ConfigureExample)


ConfigureExample(Q1_AUTO "${CMAKE_CURRENT_SOURCE_DIR}/tpch_auto_generated/q1.cu") 

