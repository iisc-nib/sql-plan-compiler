
#include <iostream>
#include <string>
#include <cuda_runtime.h>
#include <dirent.h>
#include <dlfcn.h>
#include <iomanip>
#include <chrono>
#include "dbruntime.h"

int main(int argc, const char **argv)
{
    std::string dbDir = getDataDir(argv, argc);
    // std::cout << "Arg len: " << argc << std::endl;
    // assert(argc >= 4 && "Need 3 arguments, --data-dir <path to dir> <shared object query>");
    // const char *soFile = argv[3];
    initSsbDb(dbDir);

    std::cout << std::setprecision(12);

    // TODO(avinash): the runtime should listen for sql queries,
    //  compile it with the lingodb toolchain
    //  look for output.cu
    //  compile it with nvcc
    //  link it using dlopen, and execute the control function.

    // void *lib = dlopen("/media/ajayakar/space/src/sql-plan-compiler/gpu-db/tpch_auto_generated/"+ soFile, RTLD_LAZY);
    while (true)
    {

        std::string libPath;
        std::cout << "> ";
        std::cin >> libPath;
        libPath = "build/q" + libPath + ".codegen.so"; // input as integer now for convinience
        void *lib = dlopen(libPath.c_str(), RTLD_NOW);
        if (!lib)
        {
            fprintf(stderr, "%s\n", dlerror());
        }
        else
        {
            std::cout << "Opening the shared lib " << libPath << " was successful!" << std::endl;

            auto control = reinterpret_cast<void (*)(
DBI32Type*,
DBStringType*,
DBStringType*,
DBStringType*,
DBStringType*,
DBStringType*,
DBStringType*,
size_t,
DBI32Type*,
DBStringType*,
DBStringType*,
DBStringType*,
DBStringType*,
DBStringType*,
DBStringType*,
DBI32Type*,
DBStringType*,
size_t,
DBI32Type*,
DBI32Type*,
DBI32Type*,
DBI32Type*,
DBI32Type*,
DBDateType*,
DBDateType*,
DBStringType*,
DBCharType*,
DBI32Type*,
DBDecimalType*,
DBDecimalType*,
DBDecimalType*,
DBDecimalType*,
DBI32Type*,
DBI32Type*,
DBStringType*,
size_t,
DBI32Type*,
DBStringType*,
DBStringType*,
DBStringType*,
DBI32Type*,
DBI32Type*,
DBStringType*,
DBI32Type*,
DBI32Type*,
DBI32Type*,
DBI32Type*,
DBI32Type*,
DBStringType*,
DBI32Type*,
DBI32Type*,
DBI32Type*,
DBI32Type*,
size_t,
DBI32Type*,
DBStringType*,
DBStringType*,
DBStringType*,
DBStringType*,
DBStringType*,
DBStringType*,
DBStringType*,
size_t,
DBI32Type*,
DBStringType*,
DBStringType*,
size_t
               )>(dlsym(lib, "control"));
            auto start = std::chrono::high_resolution_clock::now();
            control(
 d_supplier__s_suppkey,
 d_supplier__s_name,
 d_supplier__s_address,
 d_supplier__s_city,
 d_supplier__s_nation,
 d_supplier__s_region,
 d_supplier__s_phone,
 supplier_size,
 d_part__p_partkey,
 d_part__p_name,
 d_part__p_mfgr,
 d_part__p_category,
 d_part__p_brand1,
 d_part__p_color,
 d_part__p_type,
 d_part__p_size,
 d_part__p_container,
 part_size,
 d_lineorder__lo_orderkey,
 d_lineorder__lo_linenumber,
 d_lineorder__lo_custkey,
 d_lineorder__lo_partkey,
 d_lineorder__lo_suppkey,
 d_lineorder__lo_orderdate,
 d_lineorder__lo_commitdate,
 d_lineorder__lo_orderpriority,
 d_lineorder__lo_shippriority,
 d_lineorder__lo_quantity,
 d_lineorder__lo_extendedprice,
 d_lineorder__lo_ordtotalprice,
 d_lineorder__lo_revenue,
 d_lineorder__lo_supplycost,
 d_lineorder__lo_discount,
 d_lineorder__lo_tax,
 d_lineorder__lo_shipmode,
 lineorder_size,
 d_date__d_datekey,
 d_date__d_date,
 d_date__d_dayofweek,
 d_date__d_month,
 d_date__d_year,
 d_date__d_yearmonthnum,
 d_date__d_yearmonth,
 d_date__d_daynuminweek,
 d_date__d_daynuminmonth,
 d_date__d_daynuminyear,
 d_date__d_monthnuminyear,
 d_date__d_weeknuminyear,
 d_date__d_sellingseason,
 d_date__d_lastdayinweekfl,
 d_date__d_lastdayinmonthfl,
 d_date__d_holidayfl,
 d_date__d_weekdayfl,
 date_size,
 d_customer__c_custkey,
 d_customer__c_name,
 d_customer__c_address,
 d_customer__c_city,
 d_customer__c_nation,
 d_customer__c_region,
 d_customer__c_phone,
 d_customer__c_mktsegment,
 customer_size,
 d_region__r_regionkey,
 d_region__r_name,
 d_region__r_comment,
 region_size
                );
            auto stop = std::chrono::high_resolution_clock::now();
            auto duration = std::chrono::duration_cast<std::chrono::microseconds>(stop-start);
            std::clog << "Query execution time: " << duration.count() / 1000. << "milliseconds.\n";
            dlclose(lib);
        }
    }
}
