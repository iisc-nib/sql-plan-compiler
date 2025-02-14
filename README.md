
v1_pseudocode.py: This generates a pseudo code in hyper style given a query. Useful for sketching the code to implement manually

v3.py: This generates actual cuda code.


type for the hash table
```
cuco::static_map_ref<
long, 
long, 
(cuda::std::__4::thread_scope)1, 
cuda::std::__4::equal_to<long>, 
cuco::linear_probing<1, cuco::detail::XXHash_32<long> >, 
cuco::bucket_storage_ref<cuco::pair<long, long>, 
1, 
cuco::bucket_extent<unsigned long, 18446744073709551615ul> >, 
cuco::op::insert_tag
>
```