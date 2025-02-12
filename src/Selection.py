from Operator import Operator
from helper import Aggregate, Attribute, Context, Pipeline, get_pipeline_kernel_code, load_attr_to_register, operator_id, pipeline_id, prepare_keys, prepare_params, prepare_signature, prepare_template, schema, sizeof, typeof

from typing import Dict, List
class Selection(Operator):
    def __init__(self, child: Operator, attribute: str, predicate: str):
        self.predicate = predicate
        self.child = child
        child.parent = self
        self.attribute = attribute

    def produce(self, context):
        self.child.produce(context)

    def consume(self, context):
        # lazily load the attributes into the register
        context.pipeline.input_attributes.add(Attribute(val=self.attribute, ty=typeof(self.attribute)))
        load_attr_to_register(self.attribute, context.pipeline)
        context.pipeline.kernel_code += "if (!({reg_attr} {pred})) return;\n".format(
                reg_attr = load_attr_to_register(self.attribute, context.pipeline),
                pred=self.predicate,
            )
        context.source = self
        self.parent.consume(context)
    def print(self):
        self.child.print()
    def print_control(self, allocated_attrs):
        self.child.print_control(allocated_attrs)