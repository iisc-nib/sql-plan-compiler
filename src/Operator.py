from io import StringIO
import sys
from helper import RLN, Context, typeof


class Operator:
    id: int

    def produce(self, context: Context):
        raise NotImplementedError("")

    def consume(self, context: Context):
        raise NotImplementedError("")

    def print(self):
        raise NotImplementedError("")

    def print_control(self, allocated_attrs: set):
        raise NotImplementedError("")

def print_plan(plan: Operator):
    context = Context()
    plan.produce(context)
    print("""#include "utils.h"

#include <cuco/static_map.cuh>

#include <thrust/copy.h>
#include <thrust/device_vector.h>
#include <thrust/host_vector.h>
namespace cg = cooperative_groups;
""")
    plan.print()
    allocated_attrs = set()
    old_stdout = sys.stdout
    result = StringIO()
    sys.stdout = result
    plan.print_control(allocated_attrs)
    sys.stdout = old_stdout
    print("void control(")
    srted_params = []
    for attr in allocated_attrs:
        srted_params.append(attr)
    srted_params.sort()
    for attr in srted_params:
        print("{ty} *{at},".format(ty = attr.ty, at = attr.val))

    srted_rlns = [] 
    for rln in context.pipeline.joined_relations:
        srted_rlns.append(rln)
    srted_rlns.sort()
    for idx, rln in enumerate(srted_rlns):
        text = ("size_t {}_size".format(rln))
        if idx + 1 != len(context.pipeline.joined_relations):
            text += (",")
        print(text)
    print(") {{\n{code}}}".format(code = result.getvalue()))
    
    # printing the main function, reading all the attributes needed for the control function
    
    print("int main(int argc, const char **argv) {")
    print("std::string dbDir = getDataDir(argv, argc);")
    for rln in srted_rlns:
        print("std::string {rln}_file = dbDir + \"{rln}.parquet\";".format(rln = rln))
        print("auto {rln}_table = getArrowTable({rln}_file);".format(rln = rln))
        print("size_t {rln}_size = {rln}_table->num_rows();".format(rln = rln))
        
    control_args = []
    for attr in srted_params:
        if attr.ty == "StringColumn":
            print("auto {attr} = read_string_column({rln}_table, \"{attr}\");"
                  .format(rln = RLN(attr.val), attr = attr.val)) 
            control_args.append(attr.val)
        elif attr.ty == "int8_t":
            print("StringDictEncodedColumn *{attr} = read_string_dict_encoded_column({rln}_table, \"{attr}\");"
                .format(attr = attr.val, rln = RLN(attr.val)))
            control_args.append("{attr}->column".format(attr = attr.val))
        elif attr.ty == "int32_t" and "key" in attr.val: # hardcoded to assume key
            print("auto {attr} = read_column_typecasted<int32_t>({rln}_table, \"{attr}\");".format(attr = attr.val, rln = RLN(attr.val)))
            control_args.append("{attr}.data()".format(attr = attr.val))
        else:            # for the date columns
            print("auto {attr} = read_column<{ty}>({rln}_table, \"{attr}\");".format(attr = attr.val, ty = typeof(attr.val), rln = RLN(attr.val)))
            control_args.append("{attr}.data()".format(attr = attr.val))
    for rln in srted_rlns:
        control_args.append(rln + "_size")        
    print("control({});".format(",".join(control_args)))
    print("}")
    
        