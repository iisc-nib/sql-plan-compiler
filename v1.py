import copy
from dataclasses import dataclass
from typing import Dict, List

schema = {
    "nation": {"n_nationkey", "n_name", "n_regionkey", "n_comment"},
    "supplier": {
        "s_suppkey",
        "s_nationkey",
        "s_name",
        "s_address",
        "s_phone",
        "s_acctbal",
        "s_comment",
    },
    "partsupplier": {
        "ps_suppkey",
        "ps_partkey",
        "ps_avialqty",
        "ps_supplycost",
        "ps_comment",
    },
    "part": {
        "p_partkey",
        "p_name",
        "p_mfgr",
        "p_brand",
        "p_type",
        "p_size",
        "p_container",
        "p_retailprice",
        "p_comment",
    },
    "lineitem": {
        "l_orderkey",
        "l_partkey",
        "l_suppkey",
        "l_linenumber",
        "l_quantity",
        "l_extendedprice",
        "l_discount",
        "l_tax",
        "l_returnflag",
        "l_linestatus",
        "l_shipdate",
        "l_commitdate",
        "l_receiptdate",
        "l_shipinstruct",
        "l_shipmode",
        "l_comment",
    },
    "orders": {
        "o_orderkey",
        "o_orderstatus",
        "o_custkey",
        "o_totalprice",
        "o_orderdate",
        "o_orderpriority",
        "o_clerk",
        "o_shippriority",
        "o_comment",
    },
    "customer": {
        "c_custkey",
        "c_name",
        "c_address",
        "c_nationkey",
        "c_phone",
        "c_acctbal",
        "c_mktsegment",
        "c_comment",
    },
    "region": {
        "r_regionkey",
        "r_name",
        "r_comment",
    }
}

def RLN(attr: str):
    global schema
    for k, v in schema.items():
        if attr in v:
            return k 
    return "NO RELN FOUND"

pipeline_id = 0
hash_table_id = 0


@dataclass
class Context:
    relations: set[str]
    rid_dict: Dict[str, str]
    source: any
    pipeline_params: List[str]

class Operator:
    def produce(self, context: Context):
        """Method to produce data."""
        raise NotImplementedError("Subclasses should implement this method.")

    def consume(self, context: Context):
        """Method to consume data."""
        raise NotImplementedError("Subclasses should implement this method.")


class Scan(Operator):
    def __init__(self, relation: str):
        self.relation = relation 
    def produce(self, context):
        context.relations.add(self.relation)
        rid_identifier = "tid"
        context.rid_dict[self.relation] = rid_identifier
        global pipeline_id
        print("pipeline_{pid} ({pargs})".format(pid=pipeline_id, pargs = ", ".join(context.pipeline_params)))
        pipeline_id+=1
        print("{")
        context.source = self
        self.parent.consume(context)
        print("}")
    def consume(self, context):
        return

class HashJoin(Operator):
    def __init__(self, left: Operator, right: Operator, left_attrs: List[str], right_attrs: List[str]):
        left.parent = self
        right.parent = self
        self.left = left 
        self.right = right 
        self.left_attrs = left_attrs
        self.right_attrs = right_attrs
        self.relations: set[str] = set()
        global hash_table_id
        self.hash_table_id = hash_table_id
        hash_table_id+=1
        
    def produce(self, context):
        self.left_context = copy.deepcopy(context) 
        # since build is a pipeline breaker, only send in the hash table and left attributes
        self.left_context.pipeline_params = [*self.left_attrs, "HT{}".format(self.hash_table_id)]
        self.left.produce(self.left_context)
        context.pipeline_params = [*self.right_attrs, "HT{}".format(self.hash_table_id), *context.pipeline_params]
        self.right.produce(context)
        
    def consume(self, context: Context):
        if context.source == self.left:
            print("HT{id}.insert(<{key}, B{id}_idx>)".format(
				id = self.hash_table_id, 
    			key = " ".join(["{attr}[{tid}]".format(attr=attr, tid=context.rid_dict[RLN(attr)]) for attr in self.left_attrs])
			))
            for rln in context.rid_dict:
                print("B{id}[B{id}_idx][{r}] = {identifier}".format(id = self.hash_table_id,
                      r = rln,
                      identifier = context.rid_dict[rln]))
                self.relations.add(rln)
        if context.source == self.right:
            print("lookup_{id} = HT{id}.find({key})".format(
				id = self.hash_table_id,
				key = " ".join(["{attr}[{rid}]".format(attr = attr, rid = context.rid_dict[RLN(attr)]) for attr in self.right_attrs])
			))
            for rln in self.relations:
                context.rid_dict[rln] = "B{id}[lookup_{id}->second][{r}]".format(id = self.hash_table_id, r = rln)
            context.source = self
            self.parent.consume(context)

class Aggregation(Operator):
    '''
    Expecting alias map to have all the alias names for keys as well as aggregate columns
    since these must be unique the alias names must not match the original names
    '''
    def __init__(self, agg_table_name: str, child: Operator, agg_keys: List[str], aggregation_map: Dict[str, str], alias_map: Dict[str, str]):
        self.child = child
        self.agg_keys = agg_keys
        self.aggregation_map = aggregation_map
        self.alias_map = alias_map
        global hash_table_id
        self.hash_table_id = hash_table_id
        self.agg_table_name = agg_table_name
        hash_table_id += 1
        child.parent = self 
    def produce(self, context):
        for k in self.alias_map:
            context.pipeline_params.append(k)
        self.child.produce(context)
        schema[self.agg_table_name] = set()
        for k in self.alias_map:
            schema[self.agg_table_name].add(self.alias_map[k])
    def consume(self, context):
        '''
        Assume the following
         number of keys is known
         a buffer for aggregation is already created
        an example Aggregation(Scan(r1), [r1.k1], {"r1.k2": "sum", "r1.k3": max}, {"r1.k2": "sum_r1_k2", "r1.k3": "max_r1_k3"}) should produce the following:
        
        for tid of r1:
            buf_idx = hash_table_agg.find(r1[tid].k1)
            if buf_idx == empty:
                buf_idx = atomicAdd(global_buf_idx, 1) -- create space for the new key
                hash_table_agg.insert(k = r1[tid].k1, v = buf_idx)
                new_r1.k1[buf_idx] = r1[tid].k
            -- perform aggregations in the given buffer idx
            atomic_aggregate(sum_r1_k2[buf_idx], r1[tid].k2, sum)
            atomic_aggregate(max_r1_k3[buf_idx], r1[tid].k3, max)
        
        this is a pipeline breaker operation, therefore need to generate a new kernel if there is a parent operator
        otherwise this is the end of production
        
        for tid of aggregation_result:
            parent.consume
        '''
        print("agg_buf_idx_{id} = hash_table_{id}.find({key})".format(
            id = self.hash_table_id,
            key = " ".join(["{attr}[{rid}]".format(attr = attr, rid = context.rid_dict[RLN(attr)]) for attr in self.agg_keys])))
        print("if (agg_buf_idx_{id} == empty)".format(id = self.hash_table_id), "{")
        print("new_buf_idx_{id} = atomicAdd(AB{id}_idx, 1)".format(id = self.hash_table_id))
        print("hash_table_{id}.insert(<{key}, new_buf_idx_{id}>)".format(
            id = self.hash_table_id,
            key = " ".join(["{attr}[{tid}]".format(attr=attr, tid=context.rid_dict[RLN(attr)]) for attr in self.agg_keys])
        ))
        for attr, alias in self.alias_map.items():
            print("{alias}[new_buf_idx_{id}] = {attr}[{attr_tid}]".format(
                alias = alias,
                id = self.hash_table_id,
                attr = attr,
                attr_tid = context.rid_dict[RLN(attr)]
            ))
        print("}")
        print("else {")
        for k in self.aggregation_map:
            if self.aggregation_map[k] != "any":
                print("atomic_aggregate({alias}[agg_buf_idx_{id}->second], {attr}[{attr_tid}], {aggr})".format(
                    id = self.hash_table_id,
                    alias = self.alias_map[k],
                    attr = k,
                    attr_tid = context.rid_dict[RLN(k)],
                    aggr = self.aggregation_map[k]
                ))
        print("}")
        # TODO: based on parent generate materialization or a new kernel
    

class Selection(Operator):
    # TODO: make the predicate schema aware
    def __init__(self, child: Operator, attribute: str, predicate: str):
        self.predicate = predicate 
        self.child = child
        child.parent = self
        self.attribute = attribute
    def produce(self, context):
        self.child.produce(context)
    def consume(self, context):
        print(self.attribute)
        print("if ({attr}[{attr_tid}] {pred})".format(attr = self.attribute, attr_tid = context.rid_dict[RLN(self.attribute)], pred=self.predicate), "{")
        context.source = self
        self.parent.consume(context)
        print("}")
        
class Materialize(Operator):
    parent: Operator = None
    def __init__(self, table_name: str, child: Operator, attributes: List[str]):
        self.child = child 
        self.table_name = table_name
        self.attributes = attributes
        child.parent = self 
    def produce(self, context):
        context.pipeline_params = [*context.pipeline_params, *self.attributes]
        self.child.produce(context)
    def consume(self, context):
        cols = " ".join(["{attr}[{tid}]".format(attr=attr, tid = context.rid_dict[RLN(attr)]) for attr in self.attributes])
        print("Materialize: <{}>".format(cols))
        

def tpch_q2():
    reg = Selection(Scan("region"), "r_name", "=EUROPE")
    reg_nat = HashJoin(reg, Scan("nation"), ["r_regionkey"], ["n_regionkey"])
    reg_nat_supp = HashJoin(reg_nat, Scan("supplier"), ["n_nationkey"], ["s_nationkey"])
    reg_nat_supp_ps = HashJoin(reg_nat_supp, Scan("partsupplier"), ["s_suppkey"], ["ps_suppkey"])
    part = Selection(Selection(Scan("part"), "p_size", "=15"), "p_type",  "like %BRASS")
    part_reg_nat_supp_ps = HashJoin(part, reg_nat_supp_ps, ["p_partkey"], ["ps_partkey"])
    agg1 = Aggregation("agg_table_1", part_reg_nat_supp_ps,["ps_partkey"], {"ps_supplycost": "min", "p_partkey": "any", "p_mfgr": "any"},
                       {"ps_supplycost": "min_ps_supplycost", "p_partkey": "any_p_partkey", "p_mfgr": "any_p_mfgr", "ps_partkey": "aggr0_ps_partkey"})
    agg1.produce(Context(set(), {}, None, []))
    r = HashJoin(Scan("agg_table_1"), Scan("partsupplier"), ["min_ps_supplycost", "any_p_partkey"], ["ps_supplycost", "ps_partkey"])
    r1 = HashJoin(Scan("supplier"), r, ["s_suppkey"], ["ps_suppkey"])
    op = Materialize("final_res", HashJoin(reg_nat, r1, ["n_nationkey"], ["s_nationkey"]), ["s_acctbal", "s_name", "n_name", "any_p_partkey", "any_p_mfgr", "s_address", "s_phone", "s_comment"])
    op.produce(Context(set(), {}, None, []))

if __name__ == "__main__":
    '''
    select * from 
    part join lineitem on p_partkey = l_partkey
    where l_orderdate > 1995
    '''
    j1 = HashJoin(
			Scan("part"), Selection(Scan("lineitem"), "l_receiptdate",  "> 1995"), ["p_partkey"], ["l_partkey"]
		)
    op = Materialize("res", j1, ["l_orderkey"]
	)
    op.produce(Context(set(), {}, None, []))
    # tpch_q2()
            
      
