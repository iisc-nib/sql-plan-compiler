## Generating CUDA Code for TPC-H Benchmark Queries

## Generating Data for TPC-H Benchmark Queries
* Generate the data files using the tools in the lingo-db fork (TODO make this more detailed).
* Convert the generated data files from arrow to parquet using the following command:
	```bash
	cd <repo_root>/gpu-db/tpch_auto_gen_v2/utils/arrow_to_parquet
	python arrow_to_parquet.py --data_dir <data_dir>
	```
The same folder also contains a `requirements.txt` file with the dependencies to install. You can use `pip install -r requirements.txt` to install them.

## Building and Running Generated Hyper Style Code
* Make sure you have CUDA 12.4 or later installed.
* Get a copy of the CUDA Collections (cuco) library which is predominantly header-only.
	```bash
	git clone https://github.com/NVIDIA/cuCollections.git
	```
* Copy the generated CUDA query to `<repo_root>/gpu-db/tpch_auto_gen_v2/q[1-22].codegen.cu`. The current generated code is checked in. Replace it if you change the code generator.
* Build the generated code.
	```bash
	cd gpu-db/tpch_auto_gen_v2
	mkdir build
	make query Q=1 CUCO_SRC_PATH=<path_to_cuCollections>
	```
* Build the runtime
	```bash
	make build-runtime CUCO_SRC_PATH=<path_to_cuCollections>
	```
* To run queries, run the runtime executable which then loads a shared library containing the query code based on keyboard input.
	```bash
	make run DATA_PATH=<path_to_data>
	```
	
## Notes
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