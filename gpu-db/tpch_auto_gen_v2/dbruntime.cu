#include <iostream>
#include <string>
#include <cuda_runtime.h>
#include "cudautils.cuh"
#include <dirent.h>
#include <dlfcn.h>
#include <iomanip>

#include "dbruntime.h"

__global__ void sample(DBStringType *s1, DBStringType *s2, int *res)
{
    if (evaluatePredicate(s1[0], s2[0], Predicate::eq))
        atomicAdd(res, 1);
}

int main(int argc, const char **argv)
{
    std::string dbDir = getDataDir(argv, argc);
    // std::cout << "Arg len: " << argc << std::endl;
    // assert(argc >= 4 && "Need 3 arguments, --data-dir <path to dir> <shared object query>");
    // const char *soFile = argv[3];
    initTpchDb(dbDir);

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
        void *lib = dlopen(libPath.c_str(), RTLD_NOW);
        if (!lib)
        {
            fprintf(stderr, "%s\n", dlerror());
        }
        else
        {
            std::cout << "Opening the shared lib was successful!" << std::endl;

            auto control = reinterpret_cast<void (*)(
                DBI32Type *,
                DBStringType *,
                DBI32Type *,
                DBStringType *,
                size_t,
                DBI32Type *,
                DBI32Type *,
                DBStringType *,
                DBStringType *,
                DBStringType *,
                DBDecimalType *,
                DBStringType *,
                size_t,
                DBI32Type *,
                DBI32Type *,
                DBI32Type *,
                DBDecimalType *,
                DBStringType *,
                size_t,
                DBI32Type *,
                DBStringType *,
                DBStringType *,
                DBStringType *,
                DBStringType *,
                DBI32Type *,
                DBStringType *,
                DBDecimalType *,
                DBStringType *,
                size_t,
                DBI32Type *,
                DBI32Type *,
                DBI32Type *,
                DBI64Type *,
                DBDecimalType *,
                DBDecimalType *,
                DBDecimalType *,
                DBDecimalType *,
                DBCharType *,
                DBCharType *,
                DBI32Type *,
                DBI32Type *,
                DBI32Type *,
                DBStringType *,
                DBStringType *,
                DBStringType *,
                size_t,
                DBI32Type *,
                DBCharType *,
                DBI32Type *,
                DBDecimalType *,
                DBI32Type *,
                DBStringType *,
                DBStringType *,
                DBI32Type *,
                DBStringType *,
                size_t,
                DBI32Type *,
                DBStringType *,
                DBStringType *,
                DBI32Type *,
                DBStringType *,
                DBDecimalType *,
                DBStringType *,
                DBStringType *,
                size_t,
                DBI32Type *,
                DBStringType *,
                DBStringType *,
                size_t)>(dlsym(lib, "control"));
            control(
                d_nation__n_nationkey,
                d_nation__n_name,
                d_nation__n_regionkey,
                d_nation__n_comment,
                nation_size,
                d_supplier__s_suppkey,
                d_supplier__s_nationkey,
                d_supplier__s_name,
                d_supplier__s_address,
                d_supplier__s_phone,
                d_supplier__s_acctbal,
                d_supplier__s_comment,
                supplier_size,
                d_partsupp__ps_suppkey,
                d_partsupp__ps_partkey,
                d_partsupp__ps_availqty,
                d_partsupp__ps_supplycost,
                d_partsupp__ps_comment,
                partsupp_size,
                d_part__p_partkey,
                d_part__p_name,
                d_part__p_mfgr,
                d_part__p_brand,
                d_part__p_type,
                d_part__p_size,
                d_part__p_container,
                d_part__p_retailprice,
                d_part__p_comment,
                part_size,
                d_lineitem__l_orderkey,
                d_lineitem__l_partkey,
                d_lineitem__l_suppkey,
                d_lineitem__l_linenumber,
                d_lineitem__l_quantity,
                d_lineitem__l_extendedprice,
                d_lineitem__l_discount,
                d_lineitem__l_tax,
                d_lineitem__l_returnflag,
                d_lineitem__l_linestatus,
                d_lineitem__l_shipdate,
                d_lineitem__l_commitdate,
                d_lineitem__l_receiptdate,
                d_lineitem__l_shipinstruct,
                d_lineitem__l_shipmode,
                d_lineitem__comments,
                lineitem_size,
                d_orders__o_orderkey,
                d_orders__o_orderstatus,
                d_orders__o_custkey,
                d_orders__o_totalprice,
                d_orders__o_orderdate,
                d_orders__o_orderpriority,
                d_orders__o_clerk,
                d_orders__o_shippriority,
                d_orders__o_comment,
                orders_size,
                d_customer__c_custkey,
                d_customer__c_name,
                d_customer__c_address,
                d_customer__c_nationkey,
                d_customer__c_phone,
                d_customer__c_acctbal,
                d_customer__c_mktsegment,
                d_customer__c_comment,
                customer_size,
                d_region__r_regionkey,
                d_region__r_name,
                d_region__r_comment,
                region_size);
        }
        dlclose(lib);
    }
}
