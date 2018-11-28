echo g++ -std=c++14 *.cpp -lpthread -o cpu.out 
g++ -std=c++14 *.cpp -lpthread -o cpu.out 

pushd nvcc
echo nvcc -arch=compute_53 -rdc=true --default-stream per-thread *.cu -o gpu.out 
nvcc -arch=compute_53 -rdc=true --default-stream per-thread *.cu -o gpu.out 
cp gpu.out ../
popd
