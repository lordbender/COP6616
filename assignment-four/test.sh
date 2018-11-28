pushd cpp
g++ -std=c++11 *.cpp -lpthread -o cpu.out
./cpu.out 100000
popd


pushd cuda
 nvcc -arch=compute_35 -rdc=true -maxrregcount=50  --machine 64 -cudart static --default-stream legacy *.cu -o gpu.out
./gpu.out 100000
popd

