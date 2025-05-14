#pragma once

#include "cudautils.cuh"
#include "arrowutils.h"
#include "db_types.h"
#include <iostream>
#include <map>

DBI32Type *d_nation__n_nationkey;
DBStringType *d_nation__n_name;
DBI16Type *d_nation__n_name_encoded;
std::unordered_map<DBI16Type, std::string> nation__n_name_map;
DBI32Type *d_nation__n_regionkey;
DBStringType *d_nation__n_comment;
size_t nation_size;
DBI32Type *d_supplier__s_suppkey;
DBI32Type *d_supplier__s_nationkey;
DBStringType *d_supplier__s_name;
DBI16Type *d_supplier__s_name_encoded;
std::unordered_map<DBI16Type, std::string> supplier__s_name_map;
DBStringType *d_supplier__s_address;
DBStringType *d_supplier__s_phone;
DBDecimalType *d_supplier__s_acctbal;
DBStringType *d_supplier__s_comment;
size_t supplier_size;
DBI32Type *d_partsupp__ps_suppkey;
DBI32Type *d_partsupp__ps_partkey;
DBI32Type *d_partsupp__ps_availqty;
DBDecimalType *d_partsupp__ps_supplycost;
DBStringType *d_partsupp__ps_comment;
size_t partsupp_size;
DBI32Type *d_part__p_partkey;
DBStringType *d_part__p_name;
DBStringType *d_part__p_mfgr;
DBStringType *d_part__p_brand;
DBI16Type *d_part__p_brand_encoded;
std::unordered_map<DBI16Type, std::string> part__p_brand_map;
DBStringType *d_part__p_type;
DBI16Type *d_part__p_type_encoded;
std::unordered_map<DBI16Type, std::string> part__p_type_map;
DBI32Type *d_part__p_size;
DBStringType *d_part__p_container;
DBDecimalType *d_part__p_retailprice;
DBStringType *d_part__p_comment;
size_t part_size;
DBI32Type *d_lineitem__l_orderkey;
DBI32Type *d_lineitem__l_partkey;
DBI32Type *d_lineitem__l_suppkey;
DBI64Type *d_lineitem__l_linenumber;
DBDecimalType *d_lineitem__l_quantity;
DBDecimalType *d_lineitem__l_extendedprice;
DBDecimalType *d_lineitem__l_discount;
DBDecimalType *d_lineitem__l_tax;
DBCharType *d_lineitem__l_returnflag;
DBCharType *d_lineitem__l_linestatus;
DBI32Type *d_lineitem__l_shipdate;
DBI32Type *d_lineitem__l_commitdate;
DBI32Type *d_lineitem__l_receiptdate;
DBStringType *d_lineitem__l_shipinstruct;
DBStringType *d_lineitem__l_shipmode;
DBStringType *d_lineitem__comments;
size_t lineitem_size;
DBI32Type *d_orders__o_orderkey;
DBCharType *d_orders__o_orderstatus;
DBI32Type *d_orders__o_custkey;
DBDecimalType *d_orders__o_totalprice;
DBDateType *d_orders__o_orderdate;
DBStringType *d_orders__o_orderpriority;
DBI16Type *d_orders__o_orderpriority_encoded;
std::unordered_map<DBI16Type, std::string> orders__o_orderpriority_map;
DBStringType *d_orders__o_clerk;
DBI32Type *d_orders__o_shippriority;
DBStringType *d_orders__o_comment;
size_t orders_size;
DBI32Type *d_customer__c_custkey;
DBStringType *d_customer__c_name;
DBI16Type *d_customer__c_name_encoded;
std::unordered_map<DBI16Type, std::string> customer__c_name_map;
DBStringType *d_customer__c_address;
DBI16Type *d_customer__c_address_encoded;
std::unordered_map<DBI16Type, std::string> customer__c_address_map;
DBI32Type *d_customer__c_nationkey;
DBStringType *d_customer__c_phone;
DBI16Type *d_customer__c_phone_encoded;
std::unordered_map<DBI16Type, std::string> customer__c_phone_map;
DBDecimalType *d_customer__c_acctbal;
DBStringType *d_customer__c_mktsegment;
DBStringType *d_customer__c_comment;
DBI16Type *d_customer__c_comment_encoded;
std::unordered_map<DBI16Type, std::string> customer__c_comment_map;
size_t customer_size;
DBI32Type *d_region__r_regionkey;
DBStringType *d_region__r_name;
DBStringType *d_region__r_comment;
size_t region_size;

#ifdef TIMER
#include <chrono>
#endif
extern "C" void checkGpuMem()
{
    float free_m, total_m, used_m;
    size_t free_t, total_t;
    cudaMemGetInfo(&free_t, &total_t);
    free_m = (uint)free_t / 1048576.0;
    total_m = (uint)total_t / 1048576.0;
    used_m = total_m - free_m;
    fprintf(stderr, "  mem free %lu` .... %f MB mem total %lu....%f MB mem used %f MB\n",
            free_t, free_m, total_t, total_m, used_m);
}

void initTpchDb(std::string dbDir)
{

#ifdef TIMER
    auto start = std::chrono::high_resolution_clock::now();
#endif
    auto lineitem_table = getArrowTable(dbDir, "lineitem");

#ifdef PRINTSCHEMA
    PrintColumnTypes(lineitem_table);
#endif

    lineitem_size = lineitem_table->num_rows();

    DBI32Type *l_orderkey = readIntegerColumn<DBI32Type, 1>(lineitem_table, "l_orderkey");
    d_lineitem__l_orderkey = allocateAndTransfer<DBI32Type>(l_orderkey, lineitem_size);
    free(l_orderkey);

    DBI32Type *l_partkey = readIntegerColumn<DBI32Type, 1>(lineitem_table, "l_partkey");
    d_lineitem__l_partkey = allocateAndTransfer<DBI32Type>(l_partkey, lineitem_size);
    free(l_partkey);

    DBI32Type *l_suppkey = readIntegerColumn<DBI32Type, 1>(lineitem_table, "l_suppkey");
    d_lineitem__l_suppkey = allocateAndTransfer<DBI32Type>(l_suppkey, lineitem_size);
    free(l_suppkey);

    // DBI64Type* l_linenumber = readIntegerColumn<DBI64Type>(lineitem_table, "l_linenumber");
    //  d_lineitem__l_linenumber = allocateAndTransfer<DBI64Type>(l_linenumber, lineitem_size);
    // free(l_linenumber);

    DBDecimalType *l_quantity = readDecimalColumn<1>(lineitem_table, "l_quantity");
    d_lineitem__l_quantity = allocateAndTransfer<DBDecimalType>(l_quantity, lineitem_size);
    free(l_quantity);

    DBDecimalType *l_extendedprice = readDecimalColumn<1>(lineitem_table, "l_extendedprice");
    d_lineitem__l_extendedprice = allocateAndTransfer<DBDecimalType>(l_extendedprice, lineitem_size);
    free(l_extendedprice);

    DBDecimalType *l_discount = readDecimalColumn<1>(lineitem_table, "l_discount");
    d_lineitem__l_discount = allocateAndTransfer<DBDecimalType>(l_discount, lineitem_size);
    free(l_discount);

    DBDecimalType *l_tax = readDecimalColumn<1>(lineitem_table, "l_tax");
    d_lineitem__l_tax = allocateAndTransfer<DBDecimalType>(l_tax, lineitem_size);
    free(l_tax);

    DBCharType *l_returnflag = readFixedSizeBinary(lineitem_table, "l_returnflag");
    d_lineitem__l_returnflag = allocateAndTransfer<DBCharType>(l_returnflag, lineitem_size);
    free(l_returnflag);

    DBCharType *l_linestatus = readFixedSizeBinary(lineitem_table, "l_linestatus");
    d_lineitem__l_linestatus = allocateAndTransfer<DBCharType>(l_linestatus, lineitem_size);
    free(l_linestatus);

    DBDateType *l_shipdate = readDateColumn(lineitem_table, "l_shipdate");
    d_lineitem__l_shipdate = allocateAndTransfer<DBDateType>(l_shipdate, lineitem_size);
    free(l_shipdate);

    DBDateType *l_commitdate = readDateColumn(lineitem_table, "l_commitdate");
    d_lineitem__l_commitdate = allocateAndTransfer<DBDateType>(l_commitdate, lineitem_size);
    free(l_commitdate);

    DBDateType *l_receiptdate = readDateColumn(lineitem_table, "l_receiptdate");
    d_lineitem__l_receiptdate = allocateAndTransfer<DBDateType>(l_receiptdate, lineitem_size);
    free(l_receiptdate);

    DBStringType *comments = readStringColumn<1>(lineitem_table, "l_comment");
    d_lineitem__comments = allocateAndTransferStrings(comments, lineitem_size);
    free(comments);

    DBStringType *l_shipinstruct = readStringColumn<1>(lineitem_table, "l_shipinstruct");
    d_lineitem__l_shipinstruct = allocateAndTransferStrings(l_shipinstruct, lineitem_size);
    free(l_shipinstruct);

    DBStringType *l_shipmode = readStringColumn<1>(lineitem_table, "l_shipmode");
    d_lineitem__l_shipmode = allocateAndTransferStrings(l_shipmode, lineitem_size);
    free(l_shipmode);

    // orders table
    auto orders_table = getArrowTable(dbDir, "orders");
    orders_size = orders_table->num_rows();

#ifdef PRINTSCHEMA
    PrintColumnTypes(orders_table);
#endif

    DBI32Type *o_orderkey = readIntegerColumn<DBI32Type, 1>(orders_table, "o_orderkey");
    d_orders__o_orderkey = allocateAndTransfer<DBI32Type>(o_orderkey, orders_size);
    free(o_orderkey);

    DBCharType *o_orderstatus = readFixedSizeBinary(orders_table, "o_orderstatus");
    d_orders__o_orderstatus = allocateAndTransfer<DBCharType>(o_orderstatus, orders_size);
    free(o_orderstatus);

    DBI32Type *o_custkey = readIntegerColumn<DBI32Type, 1>(orders_table, "o_custkey");
    d_orders__o_custkey = allocateAndTransfer<DBI32Type>(o_custkey, orders_size);
    free(o_custkey);

    DBDecimalType *o_totalprice = readDecimalColumn<1>(orders_table, "o_totalprice");
    d_orders__o_totalprice = allocateAndTransfer<DBDecimalType>(o_totalprice, orders_size);
    free(o_totalprice);

    DBDateType *o_orderdate = readDateColumn(orders_table, "o_orderdate");
    d_orders__o_orderdate = allocateAndTransfer<DBDateType>(o_orderdate, orders_size);
    free(o_orderdate);

    DBStringType *o_orderpriority = readStringColumn<1>(orders_table, "o_orderpriority");
    d_orders__o_orderpriority = allocateAndTransferStrings(o_orderpriority, orders_size);
    free(o_orderpriority);

    DBStringEncodedType *d_orders__o_orderpriority_enc = readStringEncodedColumn<1>(orders_table, "o_orderpriority");
    d_orders__o_orderpriority_encoded = allocateAndTransfer<DBI16Type>(d_orders__o_orderpriority_enc->buffer, orders_size);
    orders__o_orderpriority_map = d_orders__o_orderpriority_enc->rev_dict;
    free(d_orders__o_orderpriority_enc->buffer);
    free(d_orders__o_orderpriority_enc);

    DBStringType *o_clerk = readStringColumn<1>(orders_table, "o_clerk");
    d_orders__o_clerk = allocateAndTransferStrings(o_clerk, orders_size);
    free(o_clerk);

    DBI32Type *o_shippriority = readIntegerColumn<DBI32Type, 1>(orders_table, "o_shippriority");
    d_orders__o_shippriority = allocateAndTransfer<DBI32Type>(o_shippriority, orders_size);
    free(o_shippriority);

    DBStringType *o_comment = readStringColumn<1>(orders_table, "o_comment");
    d_orders__o_comment = allocateAndTransferStrings(o_comment, orders_size);
    free(o_comment);

    // customer table
    auto customer_table = getArrowTable(dbDir, "customer");
    customer_size = customer_table->num_rows();
#ifdef PRINTSCHEMA
    PrintColumnTypes(customer_table);
#endif

    DBStringType *c_mktsegment = readStringColumn<1>(customer_table, "c_mktsegment");
    d_customer__c_mktsegment = allocateAndTransferStrings(c_mktsegment, customer_size);
    free(c_mktsegment);

    DBI32Type *c_custkey = readIntegerColumn<DBI32Type, 1>(customer_table, "c_custkey");
    d_customer__c_custkey = allocateAndTransfer<DBI32Type>(c_custkey, customer_size);
    free(c_custkey);

    DBStringType *c_name = readStringColumn<1>(customer_table, "c_name");
    d_customer__c_name = allocateAndTransferStrings(c_name, customer_size);
    free(c_name);

    DBStringEncodedType *d_customer__c_name_enc = readStringEncodedColumn<1>(customer_table, "c_name");
    d_customer__c_name_encoded = allocateAndTransfer<DBI16Type>(d_customer__c_name_enc->buffer, customer_size);
    customer__c_name_map = d_customer__c_name_enc->rev_dict;
    free(d_customer__c_name_enc->buffer);
    free(d_customer__c_name_enc);

    DBStringEncodedType *d_customer__c_comment_enc = readStringEncodedColumn<1>(customer_table, "c_comment");
    d_customer__c_comment_encoded = allocateAndTransfer<DBI16Type>(d_customer__c_comment_enc->buffer, customer_size);
    customer__c_comment_map = d_customer__c_comment_enc->rev_dict;
    free(d_customer__c_comment_enc->buffer);
    free(d_customer__c_comment_enc);

    DBStringEncodedType *d_customer__c_phone_enc = readStringEncodedColumn<1>(customer_table, "c_phone");
    d_customer__c_phone_encoded = allocateAndTransfer<DBI16Type>(d_customer__c_phone_enc->buffer, customer_size);
    customer__c_phone_map = d_customer__c_phone_enc->rev_dict;
    free(d_customer__c_phone_enc->buffer);
    free(d_customer__c_phone_enc);

    DBStringEncodedType *d_customer__c_address_enc = readStringEncodedColumn<1>(customer_table, "c_address");
    d_customer__c_address_encoded = allocateAndTransfer<DBI16Type>(d_customer__c_address_enc->buffer, customer_size);
    customer__c_address_map = d_customer__c_address_enc->rev_dict;
    free(d_customer__c_address_enc->buffer);
    free(d_customer__c_address_enc);

    DBStringType *c_address = readStringColumn<1>(customer_table, "c_address");
    d_customer__c_address = allocateAndTransferStrings(c_address, customer_size);
    free(c_address);

    DBI32Type *c_nationkey = readIntegerColumn<DBI32Type, 1>(customer_table, "c_nationkey");
    d_customer__c_nationkey = allocateAndTransfer<DBI32Type>(c_nationkey, customer_size);
    free(c_nationkey);

    DBStringType *c_phone = readStringColumn<1>(customer_table, "c_phone");
    d_customer__c_phone = allocateAndTransferStrings(c_phone, customer_size);
    free(c_phone);

    DBDecimalType *c_acctbal = readDecimalColumn<1>(customer_table, "c_acctbal");
    d_customer__c_acctbal = allocateAndTransfer<DBDecimalType>(c_acctbal, customer_size);
    free(c_acctbal);

    DBStringType *c_comment = readStringColumn<1>(customer_table, "c_comment");
    d_customer__c_comment = allocateAndTransferStrings(c_comment, customer_size);
    free(c_comment);

    auto region_table = getArrowTable(dbDir, "region");
    region_size = region_table->num_rows();
#ifdef PRINTSCHEMA
    PrintColumnTypes(region_table);
#endif

    DBI32Type *r_regionkey = readIntegerColumn<DBI32Type, 1>(region_table, "r_regionkey");
    d_region__r_regionkey = allocateAndTransfer<DBI32Type>(r_regionkey, region_size);
    free(r_regionkey);

    DBStringType *r_name = readStringColumn<1>(region_table, "r_name");
    d_region__r_name = allocateAndTransferStrings(r_name, region_size);
    free(r_name);

    DBStringType *r_comment = readStringColumn<1>(region_table, "r_comment");
    d_region__r_comment = allocateAndTransferStrings(r_comment, region_size);
    free(r_comment);

    auto nation_table = getArrowTable(dbDir, "nation");
    nation_size = nation_table->num_rows();
#ifdef PRINTSCHEMA
    PrintColumnTypes(nation_table);
#endif

    DBI32Type *n_nationkey = readIntegerColumn<DBI32Type, 1>(nation_table, "n_nationkey");
    d_nation__n_nationkey = allocateAndTransfer<DBI32Type>(n_nationkey, nation_size);
    free(n_nationkey);

    DBStringType *n_name = readStringColumn<1>(nation_table, "n_name");
    d_nation__n_name = allocateAndTransferStrings(n_name, nation_size);
    free(n_name);

    DBStringEncodedType *n_name_enc = readStringEncodedColumn<1>(nation_table, "n_name");
    for (auto it : n_name_enc->rev_dict)
    {
        nation__n_name_map[it.first] = it.second;
    }
    for (auto it : nation__n_name_map)
    {
        std::clog << it.first << ": " << it.second << std::endl;
    }
    d_nation__n_name_encoded = allocateAndTransfer<DBI16Type>(n_name_enc->buffer, nation_size);
    free(n_name_enc->buffer);
    free(n_name_enc);

    DBI32Type *n_regionkey = readIntegerColumn<DBI32Type, 1>(nation_table, "n_regionkey");
    d_nation__n_regionkey = allocateAndTransfer<DBI32Type>(n_regionkey, nation_size);
    free(n_regionkey);

    DBStringType *n_comment = readStringColumn<1>(nation_table, "n_comment");
    d_nation__n_comment = allocateAndTransferStrings(n_comment, nation_size);
    free(n_comment);

    auto supplier_table = getArrowTable(dbDir, "supplier");
    supplier_size = supplier_table->num_rows();
#ifdef PRINTSCHEMA
    PrintColumnTypes(supplier_table);
#endif

    DBI32Type *s_suppkey = readIntegerColumn<DBI32Type, 1>(supplier_table, "s_suppkey");
    d_supplier__s_suppkey = allocateAndTransfer<DBI32Type>(s_suppkey, supplier_size);
    free(s_suppkey);

    DBI32Type *s_nationkey = readIntegerColumn<DBI32Type, 1>(supplier_table, "s_nationkey");
    d_supplier__s_nationkey = allocateAndTransfer<DBI32Type>(s_nationkey, supplier_size);
    free(s_nationkey);

    DBStringType *s_name = readStringColumn<1>(supplier_table, "s_name");
    d_supplier__s_name = allocateAndTransferStrings(s_name, supplier_size);
    free(s_name);

    DBStringEncodedType *d_supplier__s_name_enc = readStringEncodedColumn<1>(supplier_table, "s_name");
    d_supplier__s_name_encoded = allocateAndTransfer<DBI16Type>(d_supplier__s_name_enc->buffer, supplier_size);
    supplier__s_name_map = d_supplier__s_name_enc->rev_dict;
    free(d_supplier__s_name_enc->buffer);
    free(d_supplier__s_name_enc);


    DBStringType *s_address = readStringColumn<1>(supplier_table, "s_address");
    d_supplier__s_address = allocateAndTransferStrings(s_address, supplier_size);
    free(s_address);

    DBStringType *s_phone = readStringColumn<1>(supplier_table, "s_phone");
    d_supplier__s_phone = allocateAndTransferStrings(s_phone, supplier_size);
    free(s_phone);

    DBDecimalType *s_acctbal = readDecimalColumn<1>(supplier_table, "s_acctbal");
    d_supplier__s_acctbal = allocateAndTransfer<DBDecimalType>(s_acctbal, supplier_size);
    free(s_acctbal);

    DBStringType *s_comment = readStringColumn<1>(supplier_table, "s_comment");
    d_supplier__s_comment = allocateAndTransferStrings(s_comment, supplier_size);
    free(s_comment);

    auto partsupp_table = getArrowTable(dbDir, "partsupp");
    partsupp_size = partsupp_table->num_rows();
#ifdef PRINTSCHEMA
    PrintColumnTypes(partsupp_table);
#endif

    DBI32Type *ps_suppkey = readIntegerColumn<DBI32Type, 1>(partsupp_table, "ps_suppkey");
    d_partsupp__ps_suppkey = allocateAndTransfer<DBI32Type>(ps_suppkey, partsupp_size);
    free(ps_suppkey);

    DBI32Type *ps_partkey = readIntegerColumn<DBI32Type, 1>(partsupp_table, "ps_partkey");
    d_partsupp__ps_partkey = allocateAndTransfer<DBI32Type>(ps_partkey, partsupp_size);
    free(ps_partkey);

    DBI32Type *ps_availqty = readIntegerColumn<DBI32Type, 1>(partsupp_table, "ps_availqty");
    d_partsupp__ps_availqty = allocateAndTransfer<DBI32Type>(ps_availqty, partsupp_size);
    free(ps_availqty);

    DBDecimalType *ps_supplycost = readDecimalColumn<1>(partsupp_table, "ps_supplycost");
    d_partsupp__ps_supplycost = allocateAndTransfer<DBDecimalType>(ps_supplycost, partsupp_size);
    free(ps_supplycost);

    DBStringType *ps_comment = readStringColumn<1>(partsupp_table, "ps_comment");
    d_partsupp__ps_comment = allocateAndTransferStrings(ps_comment, partsupp_size);
    free(ps_comment);

    auto part_table = getArrowTable(dbDir, "part");
    part_size = part_table->num_rows();
#ifdef PRINTSCHEMA
    PrintColumnTypes(part_table);
#endif

    DBI32Type *p_partkey = readIntegerColumn<DBI32Type, 1>(part_table, "p_partkey");
    d_part__p_partkey = allocateAndTransfer<DBI32Type>(p_partkey, part_size);
    free(p_partkey);

    DBStringType *p_name = readStringColumn<1>(part_table, "p_name");
    d_part__p_name = allocateAndTransferStrings(p_name, part_size);
    free(p_name);

    DBStringType *p_mfgr = readStringColumn<1>(part_table, "p_mfgr");
    d_part__p_mfgr = allocateAndTransferStrings(p_mfgr, part_size);
    free(p_mfgr);

    DBStringType *p_brand = readStringColumn<1>(part_table, "p_brand");
    d_part__p_brand = allocateAndTransferStrings(p_brand, part_size);
    free(p_brand);

    DBStringEncodedType *d_part__p_brand_enc = readStringEncodedColumn<1>(part_table, "p_brand");
    d_part__p_brand_encoded = allocateAndTransfer<DBI16Type>(d_part__p_brand_enc->buffer, part_size);
    part__p_brand_map = d_part__p_brand_enc->rev_dict;
    free(d_part__p_brand_enc->buffer);
    free(d_part__p_brand_enc);

    DBStringType *p_type = readStringColumn<1>(part_table, "p_type");
    d_part__p_type = allocateAndTransferStrings(p_type, part_size);
    free(p_type);

    DBStringEncodedType *d_part__p_type_enc = readStringEncodedColumn<1>(part_table, "p_type");
    d_part__p_type_encoded = allocateAndTransfer<DBI16Type>(d_part__p_type_enc->buffer, part_size);
    part__p_type_map = d_part__p_type_enc->rev_dict;
    free(d_part__p_type_enc->buffer);
    free(d_part__p_type_enc);

    DBI32Type *p_size = readIntegerColumn<DBI32Type, 1>(part_table, "p_size");
    d_part__p_size = allocateAndTransfer<DBI32Type>(p_size, part_size);
    free(p_size);

    DBStringType *p_container = readStringColumn<1>(part_table, "p_container");
    d_part__p_container = allocateAndTransferStrings(p_container, part_size);
    free(p_container);

    DBDecimalType *p_retailprice = readDecimalColumn<1>(part_table, "p_retailprice");
    d_part__p_retailprice = allocateAndTransfer<DBDecimalType>(p_retailprice, part_size);
    free(p_retailprice);

    DBStringType *p_comment = readStringColumn<1>(part_table, "p_comment");
    d_part__p_comment = allocateAndTransferStrings(p_comment, part_size);
    free(p_comment);

#ifdef TIMER
    auto end = std::chrono::high_resolution_clock::now();
    auto duration = std::chrono::duration_cast<std::chrono::microseconds>(end - start);
    std::clog << "Reading and transferring data time for lineitem table: " << duration.count() / 1000. << " milliseconds." << std::endl;
#endif

#ifdef GPUMEMINFO
    checkGpuMem();
#endif
}