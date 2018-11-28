pushd cpp
echo g++ -std=c++14 *.cpp -lpthread -o cpu.out
g++ -std=c++11 *.cpp -lpthread -o cpu.out
./cpu.out 1000000
popd


pushd cuda
echo nvcc -arch=compute_35 --default-stream per-thread -rdc=true *.cu -o gpu.out
nvcc -arch=compute_35 -rdc=true --default-stream per-thread --resource-usage  *.cu
./gpu.out 1000000
popd

