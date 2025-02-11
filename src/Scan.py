from Operator import Operator
from helper import Attribute, Context, Pipeline, pipeline_id


class Scan(Operator):
    parent: Operator

    def __init__(self, relation: str):
        self.relation = relation

    def produce(self, context: Context):
        global pipeline_id
        new_pipeline = Pipeline(next(pipeline_id), self.relation)
        new_pipeline.kernel_code += "int64_t tid = blockDim.x * blockIdx.x + threadIdx.x;\nif (tid >= {}_size) return;\n".format(
            self.relation
        )
        new_pipeline.rid_dict[self.relation] = "tid"
        context.pipeline = new_pipeline
        context.pipeline.other_vars.add(
            Attribute("size_t", "{}_size".format(self.relation))
        )
        context.source = self
        self.parent.consume(context)

    def print(self):
        return

    def print_control(self):
        return