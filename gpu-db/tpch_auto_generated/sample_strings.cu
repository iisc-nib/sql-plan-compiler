#include <iostream>
#include <vector>
#include <string>
#include <cuda_runtime.h>
#include "cudautils.cuh"
#include "arrowutils.h"
#include <iomanip>
std::ostream& operator<<(std::ostream& o, const __int128& x) {
    if (x == std::numeric_limits<__int128>::min()) return o << "-170141183460469231731687303715884105728";
    if (x < 0) return o << "-" << -x;
    if (x < 10) return o << (char)(x + '0');
    return o << x / 10 << (char)(x % 10 + '0');
}

int main(int argc, const char**argv) {
    std::string dbDir = getDataDir(argv, argc);
    auto lineitem_table = getArrowTable(dbDir, "lineitem");
    PrintColumnTypes(lineitem_table);

    DBStringType* comments = readStringColumn(lineitem_table, "comments");
    for (auto i=0ull; i<lineitem_table->num_rows(); i++) {
        // std::cout << comments[i] << std::endl;
    }
    char* l_returnflag = readCharColumn(lineitem_table, "l_returnflag");
    DBDateType* l_shipdate = readDateColumn(lineitem_table, "l_shipdate");

    DBDecimalPrecisionType l_ep = readDecimalPrecisionColumn(lineitem_table, "l_extendedprice");
    DBDecimalType* l_epfloat = readDecimalColumn(lineitem_table, "l_extendedprice");

    std::cout << std::setprecision(12);
    for (auto i=0ull; i<lineitem_table->num_rows(); i++) {

        std::cout << (float)l_ep[i]/100.<< " " << l_epfloat[i] << std::endl;
    }
}
