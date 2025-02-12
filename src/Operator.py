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