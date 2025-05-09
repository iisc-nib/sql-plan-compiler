## Query 11

* Single join on order date (lineorder and date tables)
* Probe kernel (main_3) takes almost 100% of the time
* Significant divergence in the probe kernel -- 4.81 threads active per warp on average

## Query 12
* Single join on order date (lineorder and date tables)
	* Different predicates probably change selectivity
* Probe kernel (main_3) takes almost 100% of the time
* Significant divergence in the probe kernel -- 5.41 threads active per warp on average

## Query 13
* Single join on order date (lineorder and date tables)
	* Different predicates probably change selectivity
* Probe kernel (main_3) takes almost 100% of the time
* Significant divergence in the probe kernel -- 6.41 threads active per warp on average

## Query 21
* Three joins and all probes are fused into the same kernel (main_7)
	* Probe kernel (main_7) takes almost 100% of the time
* 7.13 threads active per warp on average
* The profiler says that memory access patterns are the major problem
	* _The memory access pattern for local loads from L1TEX might not be optimal. On average, only 1.7 of the 32 bytes transmitted per sector are utilized by each thread. This could possibly be caused by a stride between threads. Check the  Source Counters section for uncoalesced local loads._

## Query 22
* Similar to query 21
* 8.43 threads active per warp on average
* The profiler says that memory access patterns are the major problem
	* _The memory access pattern for local loads from L1TEX might not be optimal. On average, only 1.7 of the 32 bytes transmitted per sector are utilized by each thread. This could possibly be caused by a stride between threads. Check the  Source Counters section for uncoalesced local loads._

## Query 23
* Similar to query 21 (main_5)
* 9.93 threads active per warp on average
* Profiler says divergence is a major problem