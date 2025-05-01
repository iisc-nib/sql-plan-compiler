# make ARROW_INCL_PATH=$SPACE/tools/arrow/include/ ARROW_LIB_PATH=$SPACE/tools/arrow/lib CUCO_SRC_PATH=$SPACE/src/cuCollections build-runtime

for i in 11 12 13 21 22 23 31 32 33 34 41 42 43 11m 12m 13m 21m 22m 23m 31m 32m 33m 34m 41m 42m 43m
do 
    make ARROW_INCL_PATH=$SPACE/tools/arrow/include/ ARROW_LIB_PATH=$SPACE/tools/arrow/lib CUCO_SRC_PATH=$SPACE/src/cuCollections query Q=$i
done
