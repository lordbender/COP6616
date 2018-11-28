pushd cpp
echo g++ -std=c++14 *.cpp -lpthread -o cpu.out
g++ -std=c++14 *.cpp -lpthread -o cpu.out
./cpu.out 256
popd


pushd cuda
echo nvcc -arch=compute_53 -rdc=true --default-stream per-thread *.cu -o gpu.out
nvcc -arch=compute_53 -rdc=true --default-stream per-thread *.cu -o gpu.out
./gpu.out
popd

