from Operator import Operator
from helper import RLN, Attribute, Context, load_attr_to_register,schema, typeof


from typing import Dict, List
from dataclasses import dataclass


class Print(Operator):
    def __init__(self, attrs: List[str], child: Operator):
        self.attrs = attrs 
        self.child = child 
        self.relation: str = ""
        child.parent = self 

    def produce(self, context: Context):
        self.child.produce(context)

    def consume(self, context: Context):
        tables = set()
        for attr in self.attrs:
            # at = Attribute(ty = typeof(attr), val=attr)
            tables.add(RLN(attr))
        if len(tables) != 1:
            if not (len(tables) == 2 and "additional" in tables):
                raise Exception("All attributes to print should belong to the same table")
        if len(self.attrs) == 0:
            raise Exception("Provide atleast one attribute to print")
        self.relation += RLN(self.attrs[0])
            
            
    def print(self):
        self.child.print()
    def print_control(self, allocated_attrs):
        self.child.print_control(allocated_attrs)
        # copy back all the buffers to host
        for attr in self.attrs:
            print("{ty}* p_{at} = ({ty}*)malloc(sizeof({ty}) * {rln}_size);".format(
                ty = typeof(attr),
                at = attr, 
                rln = self.relation
            ))
            print("cudaMemcpy(p_{at}, d_{at}, sizeof({ty}) * {rln}_size, cudaMemcpyDeviceToHost);".format(
                at = attr, ty = typeof(attr), rln = self.relation
            ))
        print("for (int i=0; i<{rln}_size; i++) {{".format(rln = self.relation))
        for attr in self.attrs:
            at = Attribute(ty = typeof(attr), val=attr)
            # TODO: handle things for int8_t
            if (at.ty == "int8_t"):
                print("std::cout << (int)p_{attr}[i] << \"\\t\";".format(attr = at.val))
            else:
                print("std::cout << p_{attr}[i] << \"\\t\";".format(attr = at.val))
        print("std::cout << std::endl;")
        print("}")
