QUERY_NUM = $(Q)
CUCO_SRC_PATH ?= /media/ajayakar/space/src/sql-plan-compiler/gpu-db/build2/_deps/cuco-src
ARROW_INCL_PATH ?= $(SPACE)/tools/arrow/include/
ARROW_LIB_PATH ?= $(SPACE)/tools/arrow/lib 
DATA_PATH ?= $(SPACE)/src/tpch/data/tables/scale-1.0/

build-runtime:
	mkdir -p build
	nvcc -g -I$(ARROW_INCL_PATH) -I../db-utils -L$(ARROW_LIB_PATH) dbruntime.cu \
                -lparquet -larrow -DGPUMEMINFO -DTIMER -DPRINTSCHEMA -o build/dbruntime \
                -I$(CUCO_SRC_PATH)/include \
                --expt-extended-lambda \
                "--generate-code=arch=compute_86,code=[compute_86,sm_86]"
    
QUERY_NUM = $(Q)

query:
	nvcc -g q$(Q).codegen.cu -O3 \
                -I/media/ajayakar/space/tools/arrow/include \
                -I../db-utils \
                -DTHRUST_IGNORE_CUB_VERSION_CHECK -DTHRUST_DEVICE_SYSTEM=THRUST_DEVICE_SYSTEM_CUDA -DTHRUST_DISABLE_ABI_NAMESPACE -DTHRUST_HOST_SYSTEM=THRUST_HOST_SYSTEM_CPP -DTHRUST_IGNORE_ABI_NAMESPACE_ERROR \
                -I$(CUCO_SRC_PATH)/include \
                --expt-extended-lambda \
                "--generate-code=arch=compute_86,code=[compute_86,sm_86]"   \
                -shared \
                -Xcompiler -fPIC -o build/q$(Q).codegen.so \
                -Xcompiler --no-gnu-unique \
                -lineinfo

run:
	./build/dbruntime --data_dir $(DATA_PATH)
clean:
	rm -rf build
