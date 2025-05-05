#pragma once

#include "cudautils.cuh"
#include "arrowutils.h"
#include "db_types.h"
#include <unordered_map>
#include <iostream>

DBI32Type *d_supplier__s_suppkey;
DBStringType *d_supplier__s_name;
DBStringType *d_supplier__s_address;
DBStringType *d_supplier__s_city;
DBI16Type *d_supplier__s_city_encoded;
std::unordered_map<DBI16Type, std::string> supplier__s_city_map;
DBStringType *d_supplier__s_nation;
DBI16Type *d_supplier__s_nation_encoded;
std::unordered_map<DBI16Type, std::string> supplier__s_nation_map;
DBStringType *d_supplier__s_region;
DBStringType *d_supplier__s_phone;
size_t supplier_size;
DBI32Type *d_part__p_partkey;
DBStringType *d_part__p_name;
DBStringType *d_part__p_mfgr;
DBStringType *d_part__p_category;
DBI16Type *d_part__p_category_encoded;
std::unordered_map<DBI16Type, std::string> part__p_category_map;
DBStringType *d_part__p_brand1;
DBI16Type *d_part__p_brand1_encoded;
std::unordered_map<DBI16Type, std::string> part__p_brand1_map;
DBStringType *d_part__p_color;
DBStringType *d_part__p_type;
DBI32Type *d_part__p_size;
DBStringType *d_part__p_container;
size_t part_size;
DBI32Type *d_lineorder__lo_orderkey;
DBI32Type *d_lineorder__lo_linenumber;
DBI32Type *d_lineorder__lo_custkey;
DBI32Type *d_lineorder__lo_partkey;
DBI32Type *d_lineorder__lo_suppkey;
DBDateType *d_lineorder__lo_orderdate;
DBDateType *d_lineorder__lo_commitdate;
DBStringType *d_lineorder__lo_orderpriority;
DBCharType *d_lineorder__lo_shippriority;
DBI32Type *d_lineorder__lo_quantity;
DBDecimalType *d_lineorder__lo_extendedprice;
DBDecimalType *d_lineorder__lo_ordtotalprice;
DBDecimalType *d_lineorder__lo_revenue;
DBDecimalType *d_lineorder__lo_supplycost;
DBI32Type *d_lineorder__lo_discount;
DBI32Type *d_lineorder__lo_tax;
DBStringType *d_lineorder__lo_shipmode;
size_t lineorder_size;
DBI32Type *d_date__d_datekey;
DBStringType *d_date__d_date;
DBStringType *d_date__d_dayofweek;
DBStringType *d_date__d_month;
DBI32Type *d_date__d_year;
DBI32Type *d_date__d_yearmonthnum;
DBStringType *d_date__d_yearmonth;
DBI32Type *d_date__d_daynuminweek;
DBI32Type *d_date__d_daynuminmonth;
DBI32Type *d_date__d_daynuminyear;
DBI32Type *d_date__d_monthnuminyear;
DBI32Type *d_date__d_weeknuminyear;
DBStringType *d_date__d_sellingseason;
DBI32Type *d_date__d_lastdayinweekfl;
DBI32Type *d_date__d_lastdayinmonthfl;
DBI32Type *d_date__d_holidayfl;
DBI32Type *d_date__d_weekdayfl;
size_t date_size;
DBI32Type *d_customer__c_custkey;
DBStringType *d_customer__c_name;
DBStringType *d_customer__c_address;
DBStringType *d_customer__c_city;
DBI16Type *d_customer__c_city_encoded;
std::unordered_map<DBI16Type, std::string> customer__c_city_map;
DBStringType *d_customer__c_nation;
DBI16Type *d_customer__c_nation_encoded;
std::unordered_map<DBI16Type, std::string> customer__c_nation_map;
DBStringType *d_customer__c_region;
DBStringType *d_customer__c_phone;
DBStringType *d_customer__c_mktsegment;
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
    fprintf(stderr, "mem free %lu` .... %f MB mem total %lu....%f MB mem used %f MB\n", free_t, free_m, total_t, total_m, used_m);
}

void initSsbDb(std::string dbDir)
{

#ifdef TIMER
    auto start = std::chrono::high_resolution_clock::now();
#endif
    auto lineorder_table = getArrowTable(dbDir, "lineorder");

#ifdef PRINTSCHEMA
    PrintColumnTypes(lineorder_table);
#endif

    lineorder_size = lineorder_table->num_rows();

    DBI32Type *lo_orderkey = readIntegerColumn<DBI32Type, 1>(lineorder_table, "lo_orderkey");
    d_lineorder__lo_orderkey = allocateAndTransfer<DBI32Type>(lo_orderkey, lineorder_size);
    free(lo_orderkey);
    DBI32Type *lo_linenumber = readIntegerColumn<DBI32Type, 1>(lineorder_table, "lo_linenumber");
    d_lineorder__lo_linenumber = allocateAndTransfer<DBI32Type>(lo_linenumber, lineorder_size);
    free(lo_linenumber);
    DBI32Type *lo_custkey = readIntegerColumn<DBI32Type, 1>(lineorder_table, "lo_custkey");
    d_lineorder__lo_custkey = allocateAndTransfer<DBI32Type>(lo_custkey, lineorder_size);
    free(lo_custkey);
    DBI32Type *lo_partkey = readIntegerColumn<DBI32Type, 1>(lineorder_table, "lo_partkey");
    d_lineorder__lo_partkey = allocateAndTransfer<DBI32Type>(lo_partkey, lineorder_size);
    free(lo_partkey);
    DBI32Type *lo_suppkey = readIntegerColumn<DBI32Type, 1>(lineorder_table, "lo_suppkey");
    d_lineorder__lo_suppkey = allocateAndTransfer<DBI32Type>(lo_suppkey, lineorder_size);
    free(lo_suppkey);
    DBDateType *lo_orderdate = readDateColumn(lineorder_table, "lo_orderdate");
    d_lineorder__lo_orderdate = allocateAndTransfer<DBDateType>(lo_orderdate, lineorder_size);
    free(lo_orderdate);
    DBDateType *lo_commitdate = readDateColumn(lineorder_table, "lo_commitdate");
    d_lineorder__lo_commitdate = allocateAndTransfer<DBDateType>(lo_commitdate, lineorder_size);
    free(lo_commitdate);
    DBStringType *lo_orderpriority = readStringColumn<1>(lineorder_table, "lo_orderpriority");
    d_lineorder__lo_orderpriority = allocateAndTransferStrings(lo_orderpriority, lineorder_size);
    free(lo_orderpriority);
    DBCharType *lo_shippriority = readFixedSizeBinary(lineorder_table, "lo_shippriority");
    d_lineorder__lo_shippriority = allocateAndTransfer<DBCharType>(lo_shippriority, lineorder_size);
    free(lo_shippriority);
    DBI32Type *lo_quantity = readIntegerColumn<DBI32Type, 1>(lineorder_table, "lo_quantity");
    d_lineorder__lo_quantity = allocateAndTransfer<DBI32Type>(lo_quantity, lineorder_size);
    free(lo_quantity);
    DBDecimalType *lo_extendedprice = readDecimalColumn<1>(lineorder_table, "lo_extendedprice");
    d_lineorder__lo_extendedprice = allocateAndTransfer<DBDecimalType>(lo_extendedprice, lineorder_size);
    free(lo_extendedprice);
    DBDecimalType *lo_ordtotalprice = readDecimalColumn<1>(lineorder_table, "lo_ordtotalprice");
    d_lineorder__lo_ordtotalprice = allocateAndTransfer<DBDecimalType>(lo_ordtotalprice, lineorder_size);
    free(lo_ordtotalprice);
    DBDecimalType *lo_revenue = readDecimalColumn<1>(lineorder_table, "lo_revenue");
    d_lineorder__lo_revenue = allocateAndTransfer<DBDecimalType>(lo_revenue, lineorder_size);
    free(lo_revenue);
    DBDecimalType *lo_supplycost = readDecimalColumn<1>(lineorder_table, "lo_supplycost");
    d_lineorder__lo_supplycost = allocateAndTransfer<DBDecimalType>(lo_supplycost, lineorder_size);
    free(lo_supplycost);
    DBI32Type *lo_discount = readIntegerColumn<DBI32Type, 1>(lineorder_table, "lo_discount");
    d_lineorder__lo_discount = allocateAndTransfer<DBI32Type>(lo_discount, lineorder_size);
    free(lo_discount);
    DBI32Type *lo_tax = readIntegerColumn<DBI32Type, 1>(lineorder_table, "lo_tax");
    d_lineorder__lo_tax = allocateAndTransfer<DBI32Type>(lo_tax, lineorder_size);
    free(lo_tax);
    DBStringType *lo_shipmode = readStringColumn<1>(lineorder_table, "lo_shipmode");
    d_lineorder__lo_shipmode = allocateAndTransferStrings(lo_shipmode, lineorder_size);
    free(lo_shipmode);

    // orders table
    auto supplier_table = getArrowTable(dbDir, "supplier");
    supplier_size = supplier_table->num_rows();

#ifdef PRINTSCHEMA
    PrintColumnTypes(supplier_table);
#endif

    DBI32Type *s_suppkey = readIntegerColumn<DBI32Type, 1>(supplier_table, "s_suppkey");
    d_supplier__s_suppkey = allocateAndTransfer<DBI32Type>(s_suppkey, supplier_size);
    free(s_suppkey);
    DBStringType *s_name = readStringColumn<1>(supplier_table, "s_name");
    d_supplier__s_name = allocateAndTransferStrings(s_name, supplier_size);
    free(s_name);
    DBStringType *s_address = readStringColumn<1>(supplier_table, "s_address");
    d_supplier__s_address = allocateAndTransferStrings(s_address, supplier_size);
    free(s_address);
    DBStringType *s_city = readStringColumn<1>(supplier_table, "s_city");
    d_supplier__s_city = allocateAndTransferStrings(s_city, supplier_size);
    free(s_city);
    DBStringEncodedType *s_city_enc = readStringEncodedColumn<1>(supplier_table, "s_city");
    d_supplier__s_city_encoded = allocateAndTransfer<DBI16Type>(s_city_enc->buffer, supplier_size);
    supplier__s_city_map = s_city_enc->rev_dict;
    free(s_city_enc->buffer);
    free(s_city_enc);

    DBStringType *s_nation = readStringColumn<1>(supplier_table, "s_nation");
    d_supplier__s_nation = allocateAndTransferStrings(s_nation, supplier_size);
    free(s_nation);
    DBStringEncodedType *s_nation_enc = readStringEncodedColumn<1>(supplier_table, "s_nation");
    d_supplier__s_nation_encoded = allocateAndTransfer<DBI16Type>(s_nation_enc->buffer, supplier_size);
    supplier__s_nation_map = s_nation_enc->rev_dict;
    free(s_nation_enc->buffer);
    free(s_nation_enc);

    DBStringType *s_region = readStringColumn<1>(supplier_table, "s_region");
    d_supplier__s_region = allocateAndTransferStrings(s_region, supplier_size);
    free(s_region);
    DBStringType *s_phone = readStringColumn<1>(supplier_table, "s_phone");
    d_supplier__s_phone = allocateAndTransferStrings(s_phone, supplier_size);
    free(s_phone);

    // date
    auto date_table = getArrowTable(dbDir, "date");
    date_size = date_table->num_rows();

#ifdef PRINTSCHEMA
    PrintColumnTypes(date_table);
#endif

    DBI32Type *d_datekey = readIntegerColumn<DBI32Type, 1>(date_table, "d_datekey");
    d_date__d_datekey = allocateAndTransfer<DBI32Type>(d_datekey, date_size);
    free(d_datekey);
    DBStringType *d_date = readStringColumn<1>(date_table, "d_date");
    d_date__d_date = allocateAndTransferStrings(d_date, date_size);
    free(d_date);
    DBStringType *d_dayofweek = readStringColumn<1>(date_table, "d_dayofweek");
    d_date__d_dayofweek = allocateAndTransferStrings(d_dayofweek, date_size);
    free(d_dayofweek);
    DBStringType *d_month = readStringColumn<1>(date_table, "d_month");
    d_date__d_month = allocateAndTransferStrings(d_month, date_size);
    free(d_month);
    DBI32Type *d_year = readIntegerColumn<DBI32Type, 1>(date_table, "d_year");
    d_date__d_year = allocateAndTransfer<DBI32Type>(d_year, date_size);
    free(d_year);
    DBI32Type *d_yearmonthnum = readIntegerColumn<DBI32Type, 1>(date_table, "d_yearmonthnum");
    d_date__d_yearmonthnum = allocateAndTransfer<DBI32Type>(d_yearmonthnum, date_size);
    free(d_yearmonthnum);
    // TODO(avinash)
    DBStringType *d_yearmonth = readFixedSizeBinaryToString<7>(date_table, "d_yearmonth");
    d_date__d_yearmonth = allocateAndTransferStrings(d_yearmonth, date_size);
    free(d_yearmonth);
    DBI32Type *d_daynuminweek = readIntegerColumn<DBI32Type, 1>(date_table, "d_daynuminweek");
    d_date__d_daynuminweek = allocateAndTransfer<DBI32Type>(d_daynuminweek, date_size);
    free(d_daynuminweek);
    DBI32Type *d_daynuminmonth = readIntegerColumn<DBI32Type, 1>(date_table, "d_daynuminmonth");
    d_date__d_daynuminmonth = allocateAndTransfer<DBI32Type>(d_daynuminmonth, date_size);
    free(d_daynuminmonth);
    DBI32Type *d_daynuminyear = readIntegerColumn<DBI32Type, 1>(date_table, "d_daynuminyear");
    d_date__d_daynuminyear = allocateAndTransfer<DBI32Type>(d_daynuminyear, date_size);
    free(d_daynuminyear);
    DBI32Type *d_monthnuminyear = readIntegerColumn<DBI32Type, 1>(date_table, "d_monthnuminyear");
    d_date__d_monthnuminyear = allocateAndTransfer<DBI32Type>(d_monthnuminyear, date_size);
    free(d_monthnuminyear);
    DBI32Type *d_weeknuminyear = readIntegerColumn<DBI32Type, 1>(date_table, "d_weeknuminyear");
    d_date__d_weeknuminyear = allocateAndTransfer<DBI32Type>(d_weeknuminyear, date_size);
    free(d_weeknuminyear);
    DBStringType *d_sellingseason = readStringColumn<1>(date_table, "d_sellingseason");
    d_date__d_sellingseason = allocateAndTransferStrings(d_sellingseason, date_size);
    free(d_sellingseason);
    DBI32Type *d_lastdayinweekfl = readIntegerColumn<DBI32Type, 1>(date_table, "d_lastdayinweekfl");
    d_date__d_lastdayinweekfl = allocateAndTransfer<DBI32Type>(d_lastdayinweekfl, date_size);
    free(d_lastdayinweekfl);
    DBI32Type *d_lastdayinmonthfl = readIntegerColumn<DBI32Type, 1>(date_table, "d_lastdayinmonthfl");
    d_date__d_lastdayinmonthfl = allocateAndTransfer<DBI32Type>(d_lastdayinmonthfl, date_size);
    free(d_lastdayinmonthfl);
    DBI32Type *d_holidayfl = readIntegerColumn<DBI32Type, 1>(date_table, "d_holidayfl");
    d_date__d_holidayfl = allocateAndTransfer<DBI32Type>(d_holidayfl, date_size);
    free(d_holidayfl);
    DBI32Type *d_weekdayfl = readIntegerColumn<DBI32Type, 1>(date_table, "d_weekdayfl");
    d_date__d_weekdayfl = allocateAndTransfer<DBI32Type>(d_weekdayfl, date_size);
    free(d_weekdayfl);

    // part
    auto part_table = getArrowTable(dbDir, "part");
    part_size = part_table->num_rows();

#ifdef PRINTSCHEMA
    PrintColumnTypes(part_table);
#endif
    DBStringType *p_category = readFixedSizeBinaryToString<7>(part_table, "p_category");
    d_part__p_category = allocateAndTransferStrings(p_category, part_size);
    DBStringEncodedType *p_category_enc = stringTypeToEncoded(p_category, part_size);
    d_part__p_category_encoded = allocateAndTransfer<DBI16Type>(p_category_enc->buffer, part_size);
    part__p_category_map = p_category_enc->rev_dict;
    free(p_category_enc->buffer);
    free(p_category);

    DBStringType *p_mfgr = readFixedSizeBinaryToString<6>(part_table, "p_mfgr");
    d_part__p_mfgr = allocateAndTransferStrings(p_mfgr, part_size);
    free(p_mfgr);

    DBI32Type *p_partkey = readIntegerColumn<DBI32Type, 1>(part_table, "p_partkey");
    d_part__p_partkey = allocateAndTransfer<DBI32Type>(p_partkey, part_size);
    free(p_partkey);

    DBStringEncodedType *p_brand1 = readStringEncodedColumn<1>(part_table, "p_brand1");
    d_part__p_brand1_encoded = allocateAndTransfer<DBI16Type>(p_brand1->buffer, part_size);
    part__p_brand1_map = p_brand1->rev_dict;
    free(p_brand1->buffer);
    free(p_brand1);

    DBStringType *p_brand1_s = readStringColumn<1>(part_table, "p_brand1");
    d_part__p_brand1 = allocateAndTransferStrings(p_brand1_s, part_size);
    free(p_brand1_s);

    // customer
    auto customer_table = getArrowTable(dbDir, "customer");
    customer_size = customer_table->num_rows();

#ifdef PRINTSCHEMA
    PrintColumnTypes(customer_table);
#endif
    DBI32Type *c_custkey = readIntegerColumn<DBI32Type, 1>(customer_table, "c_custkey");
    d_customer__c_custkey = allocateAndTransfer<DBI32Type>(c_custkey, customer_size);
    free(c_custkey);

    DBStringType *c_city = readStringColumn<1>(customer_table, "c_city");
    d_customer__c_city = allocateAndTransferStrings(c_city, customer_size);
    free(c_city);
    DBStringEncodedType *c_city_enc = readStringEncodedColumn<1>(customer_table, "c_city");
    d_customer__c_city_encoded = allocateAndTransfer<DBI16Type>(c_city_enc->buffer, customer_size);
    customer__c_city_map = c_city_enc->rev_dict;
    free(c_city_enc->buffer);
    free(c_city_enc);

    DBStringType *c_nation = readStringColumn<1>(customer_table, "c_nation");
    d_customer__c_nation = allocateAndTransferStrings(c_nation, customer_size);
    free(c_nation);
    DBStringEncodedType *c_nation_enc = readStringEncodedColumn<1>(customer_table, "c_nation");
    d_customer__c_nation_encoded = allocateAndTransfer<DBI16Type>(c_nation_enc->buffer, customer_size);
    customer__c_nation_map = c_nation_enc->rev_dict;
    free(c_nation_enc->buffer);
    free(c_nation_enc);

    DBStringType *c_region = readStringColumn<1>(customer_table, "c_region");
    d_customer__c_region = allocateAndTransferStrings(c_region, customer_size);
    free(c_region);

#ifdef TIMER
    auto end = std::chrono::high_resolution_clock::now();
    auto duration = std::chrono::duration_cast<std::chrono::microseconds>(end - start);
    std::clog << "Reading and transferring data time for all tables: " << duration.count() / 1000. << " milliseconds." << std::endl;
#endif

#ifdef GPUMEMINFO
    checkGpuMem();
#endif
}