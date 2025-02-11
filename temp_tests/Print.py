from helper import Operator


from typing import List


class Print(Operator):
    def __init__(self, table: str, attrs: List[str], child: Operator):
        self.child = child
        child.parent = self
        self.table = table
        self.attrs = attrs

    def produce(self, context):
        self.child.produce(context)

    def consume(self, context):
        # TODO: handle dictionary encoded string types, they are not correct for now
        text = """for (size_t i=0; i<{table}_size; i++) {{
{print}
std::cout << std::endl;
}}\n""".format(
            table=self.table,
            print="\n".join(
                [
                    "std::cout << {attr}[i] << \"\\t\";".format(attr=attr)
                    for attr in self.attrs
                ] 
            ),
        )
        context.control_code += text
        context.global_control_code += text
