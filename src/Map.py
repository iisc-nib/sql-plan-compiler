from Operator import Operator
from helper import RLN, Attribute, Context, load_attr_to_register,schema, typeof


from typing import Dict, List
from dataclasses import dataclass


@dataclass
class Var:
    ty: str
    val: str


class Expression:
    def text(self, res: str, context: Context):
        raise NotImplementedError("Subclasses should implement this method.")

    def add_params(self, context: Context):
        raise NotImplementedError("Subclasses should implement this method.")


def add_var(var: Var, context: Context):
    if var.ty == "const":
        return var.val
    elif var.ty == "attr":
        return load_attr_to_register(var.val, context.pipeline)
    else:
        return ""


class BinOp(Expression):
    def __init__(self, lhs: Expression, rhs: Expression, leaf_var: Var, op: str):
        self.lhs = lhs
        self.rhs = rhs
        self.leaf_var = leaf_var
        self.op = op

    def text(self, context: Context):
        res = "("
        if self.lhs == None and self.rhs == None:
            return add_var(self.leaf_var, context)
        res += self.lhs.text(context)
        res += self.op
        res += self.rhs.text(context)
        res += ")"
        return res

    def add_params(self, context: Context):
        if self.lhs == None and self.rhs == None:
            if self.leaf_var.ty == "attr":
                context.pipeline.input_attributes.add(Attribute(typeof(self.leaf_var.val), self.leaf_var.val))
            return
        self.lhs.add_params(context)
        self.rhs.add_params(context)


class Map(Operator):
    def __init__(self, new_attr: str, expr: Expression, child: Operator, ty: str):
        self.new_attr = new_attr
        self.expr = expr
        self.child = child
        child.parent = self
        self.expr_text = ""
        self.ty = ty
        if "additional" not in schema.keys():
            schema["additional"] = dict()
        schema["additional"][self.new_attr] = self.ty

    def produce(self, context: Context):
        self.child.produce(context)

    def consume(self, context: Context):
        self.expr.add_params(context)
        self.expr_text = self.expr.text(context)
        context.pipeline.kernel_code += "{ty} reg_{lhs} = {rhs};\n".format(
            ty=typeof(self.new_attr),
            lhs=self.new_attr,
            rhs=self.expr_text,
        )
        context.pipeline.register_attrs[self.new_attr] = "reg_" + self.new_attr
        context.source = self
        self.parent.consume(context)
    def print(self):
        self.child.print()
    def print_control(self, allocated_attrs):
        self.child.print_control(allocated_attrs)
