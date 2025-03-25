build-runtime:
	mkdir -p build
	nvcc -g -I$(SPACE)/tools/arrow/include/ -L$(SPACE)/tools/arrow/lib dbruntime.cu -lparquet -larrow -DGPUMEMINFO -DTIMER -o build/dbruntime \
	"--generate-code=arch=compute_86,code=[compute_86,sm_86]"

QUERY_NUM = $(Q)

query:
	 nvcc -g q$(Q).codegen.cu -I/media/ajayakar/space/tools/arrow/include -DTHRUST_IGNORE_CUB_VERSION_CHECK -DTHRUST_DEVICE_SYSTEM=THRUST_DEVICE_SYSTEM_CUDA -DTHRUST_DISABLE_ABI_NAMESPACE -DTHRUST_HOST_SYSTEM=THRUST_HOST_SYSTEM_CPP -DTHRUST_IGNORE_ABI_NAMESPACE_ERROR -I/media/ajayakar/space/src/sql-plan-compiler/gpu-db/build2/_deps/cccl-src/lib/cmake/cub/../../../cub \
           -I/media/ajayakar/space/src/sql-plan-compiler/gpu-db \
           -I/media/ajayakar/space/src/sql-plan-compiler/gpu-db/build2/_deps/cuco-src/include \
           -I/media/ajayakar/space/src/sql-plan-compiler/gpu-db/build2/_deps/cccl-src/lib/cmake/thrust/../../../thrust \
           -I/media/ajayakar/space/src/sql-plan-compiler/gpu-db/build2/_deps/cccl-src/lib/cmake/libcudacxx/../../../libcudacxx/include \
           --expt-extended-lambda \
           "--generate-code=arch=compute_86,code=[compute_86,sm_86]"   \
           -shared \
           -Xcompiler -fPIC -o build/q$(Q).codegen.so \
          -Xcompiler --no-gnu-unique

run:
	./build/dbruntime --data_dir $(SPACE)/src/tpch/data/tables/scale-1.0/

clean:
	rm -rf build