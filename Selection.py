from helper import RLN, Operator, hash_table_id, load_to_register, schema


from typing import Dict, List
class Selection(Operator):
    def __init__(self, child: Operator, attribute: str, predicate: str):
        self.predicate = predicate
        self.child = child
        child.parent = self
        self.attribute = attribute

    def produce(self, context):
        context.pipeline_params.append(self.attribute)
        self.child.produce(context)

    def consume(self, context):
        # lazily load the attributes into the register
        load_to_register(self.attribute, context)
        context.kernel_code += "if (!({reg_attr} {pred})) return;\n".format(
                reg_attr = context.attr_reg_dict[self.attribute],
                pred=self.predicate,
            )

        context.source = self
        self.parent.consume(context)