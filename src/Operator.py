from io import StringIO
import sys
from helper import Context


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