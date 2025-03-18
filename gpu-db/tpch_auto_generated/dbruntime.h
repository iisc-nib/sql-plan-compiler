#pragma once

#include "cudautils.cuh"
#include "arrowutils.h"
#include "db_types.h"
#include <iostream>

DBI32Type* d_nation__n_nationkey;
DBStringType* d_nation__n_name;
DBI32Type* d_nation__n_regionkey;
DBStringType* d_nation__n_comment;
size_t nation_size;
DBI32Type* d_supplier__s_suppkey;
DBI32Type* d_supplier__s_nationkey;
DBStringType* d_supplier__s_name;
DBStringType* d_supplier__s_address;
DBStringType* d_supplier__s_phone;
DBDecimalType* d_supplier__s_acctbal;
DBStringType* d_supplier__s_comment;
size_t supplier_size;
DBI32Type* d_partsupp__ps_suppkey;
DBI32Type* d_partsupp__ps_partkey;
DBI32Type* d_partsupp__ps_availqty;
DBDecimalType* d_partsupp__ps_supplycost;
DBStringType* d_partsupp__ps_comment;
size_t partsupp_size;
DBI32Type* d_part__p_partkey;
DBStringType* d_part__p_name;
DBStringType* d_part__p_mfgr;
DBStringType* d_part__p_brand;
DBStringType* d_part__p_type;
DBI32Type* d_part__p_size;
DBStringType* d_part__p_container;
DBDecimalType* d_part__p_retailprice;
DBStringType* d_part__p_comment;
size_t part_size;
DBI32Type* d_lineitem__l_orderkey;
DBI32Type* d_lineitem__l_partkey;
DBI32Type* d_lineitem__l_suppkey;
DBI64Type* d_lineitem__l_linenumber;
DBDecimalType* d_lineitem__l_quantity;
DBDecimalType* d_lineitem__l_extendedprice;
DBDecimalType* d_lineitem__l_discount;
DBDecimalType* d_lineitem__l_tax;
DBCharType* d_lineitem__l_returnflag;
DBCharType* d_lineitem__l_linestatus;
DBI32Type* d_lineitem__l_shipdate;
DBI32Type* d_lineitem__l_commitdate;
DBI32Type* d_lineitem__l_receiptdate;
DBStringType* d_lineitem__l_shipinstruct;
DBStringType* d_lineitem__l_shipmode;
DBStringType* d_lineitem__comments;
size_t lineitem_size;
DBI32Type* d_orders__o_orderkey;
DBStringType* d_orders__o_orderstatus;
DBI32Type* d_orders__o_custkey;
DBDecimalType* d_orders__o_totalprice;
DBI32Type* d_orders__o_orderdate;
DBStringType* d_orders__o_orderpriority;
DBStringType* d_orders__o_clerk;
DBI32Type* d_orders__o_shippriority;
DBStringType* d_orders__o_comment;
size_t orders_size;
DBI32Type* d_customer__c_custkey;
DBStringType* d_customer__c_name;
DBStringType* d_customer__c_address;
DBI32Type* d_customer__c_nationkey;
DBStringType* d_customer__c_phone;
DBDecimalType* d_customer__c_acctbal;
DBStringType* d_customer__c_mktsegment;
DBStringType* d_customer__c_comment;
size_t customer_size;
DBI32Type* d_region__r_regionkey;
DBStringType* d_region__r_name;
DBStringType* d_region__r_comment;
size_t region_size;


#ifdef TIMER
#include <chrono>
#endif
extern "C" void checkGpuMem()
{ float free_m,total_m,used_m; size_t free_t,total_t; cudaMemGetInfo(&free_t,&total_t); free_m =(uint)free_t/1048576.0 ; total_m=(uint)total_t/1048576.0; used_m=total_m-free_m;
printf ( "  mem free %lu` .... %f MB mem total %lu....%f MB mem used %f MB\n",free_t,free_m,total_t,total_m,used_m);
}

void initTpchDb(std::string dbDir) {

    #ifdef TIMER
    auto start = std::chrono::high_resolution_clock::now();
    #endif
    auto lineitem_table = getArrowTable(dbDir, "lineitem");

    #ifdef PRINTSCHEMA
    PrintColumnTypes(lineitem_table);
    #endif

     lineitem_size = lineitem_table->num_rows();

    DBI32Type* l_orderkey = readIntegerColumn<DBI32Type>(lineitem_table, "l_orderkey");
    d_lineitem__l_orderkey = allocateAndTransfer<DBI32Type>(l_orderkey, lineitem_size); 
    free(l_orderkey);

    DBI32Type* l_partkey = readIntegerColumn<DBI32Type>(lineitem_table, "l_partkey");
    d_lineitem__l_partkey = allocateAndTransfer<DBI32Type>(l_partkey, lineitem_size); 
    free(l_partkey);

    DBI32Type* l_suppkey = readIntegerColumn<DBI32Type>(lineitem_table, "l_suppkey");
     d_lineitem__l_suppkey = allocateAndTransfer<DBI32Type>(l_suppkey, lineitem_size); 
    free(l_suppkey);


    DBI64Type* l_linenumber = readIntegerColumn<DBI64Type>(lineitem_table, "l_linenumber");
     d_lineitem__l_linenumber = allocateAndTransfer<DBI64Type>(l_linenumber, lineitem_size); 
    free(l_linenumber);

    DBDecimalType* l_quantity = readIntegerColumn<DBDecimalType>(lineitem_table, "l_quantity");
     d_lineitem__l_quantity = allocateAndTransfer<DBDecimalType>(l_quantity, lineitem_size); 
    free(l_quantity);

    DBDecimalType* l_extendedprice = readIntegerColumn<DBDecimalType>(lineitem_table, "l_extendedprice");
     d_lineitem__l_extendedprice = allocateAndTransfer<DBDecimalType>(l_extendedprice, lineitem_size); 
    free(l_extendedprice);

    DBDecimalType* l_discount = readIntegerColumn<DBDecimalType>(lineitem_table, "l_discount");
     d_lineitem__l_discount = allocateAndTransfer<DBDecimalType>(l_discount, lineitem_size); 
    free(l_discount);
    
    DBDecimalType* l_tax = readIntegerColumn<DBDecimalType>(lineitem_table, "l_tax");
     d_lineitem__l_tax = allocateAndTransfer<DBDecimalType>(l_tax, lineitem_size); 
    free(l_tax);

    DBCharType* l_returnflag = readCharColumn(lineitem_table, "l_returnflag");
     d_lineitem__l_returnflag = allocateAndTransfer<DBCharType>(l_returnflag, lineitem_size); 
    free(l_returnflag);

    DBCharType* l_linestatus = readCharColumn(lineitem_table, "l_linestatus");
     d_lineitem__l_linestatus = allocateAndTransfer<DBCharType>(l_linestatus, lineitem_size); 
    free(l_linestatus);

    DBDateType* l_shipdate = readDateColumn(lineitem_table, "l_shipdate");
     d_lineitem__l_shipdate = allocateAndTransfer<DBDateType>(l_shipdate, lineitem_size); 
    free(l_shipdate);

    DBDateType* l_commitdate = readDateColumn(lineitem_table, "l_commitdate");
     d_lineitem__l_commitdate = allocateAndTransfer<DBDateType>(l_commitdate, lineitem_size); 
    free(l_commitdate);

    DBDateType* l_receiptdate = readDateColumn(lineitem_table, "l_receiptdate");
     d_lineitem__l_receiptdate = allocateAndTransfer<DBDateType>(l_receiptdate, lineitem_size); 
    free(l_receiptdate);

    DBStringType* comments = readStringColumn(lineitem_table, "comments");
     d_lineitem__comments = allocateAndTransferStrings(comments, lineitem_size);
    free(comments);

    DBStringType* l_shipinstruct = readStringColumn(lineitem_table, "l_shipinstruct");
     d_lineitem__l_shipinstruct = allocateAndTransferStrings(l_shipinstruct, lineitem_size);
    free(l_shipinstruct);

    DBStringType* l_shipmode = readStringColumn(lineitem_table, "l_shipmode");
     d_lineitem__l_shipmode = allocateAndTransferStrings(l_shipmode, lineitem_size);
    free(l_shipmode);

    #ifdef TIMER
    auto end = std::chrono::high_resolution_clock::now();
    auto duration = std::chrono::duration_cast<std::chrono::microseconds>(end - start);
    std::clog << "Reading and transferring data time for lineitem table: " << duration.count() / 1000. << " milliseconds." << std::endl;
    #endif

    #ifdef GPUMEMINFO
    checkGpuMem();
    #endif
}