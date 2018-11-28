pushd cpp
echo g++ -std=c++14 *.cpp -lpthread -o cpu.out
g++ -std=c++11 *.cpp -lpthread -o cpu.out
./cpu.out 1000000
popd


pushd cuda
echo nvcc -arch=compute_35 -rdc=true -maxrregcount=0  --machine 64 -cudart static *.cu -o gpu.out
nvcc -arch=compute_35 -rdc=true -maxrregcount=0  --machine 64 -cudart static *.cu -o gpu.out
./gpu.out 1000000
popd

