echo g++ -std=c++14 *.cpp -lpthread -o cpu.out
g++ -std=c++14 *.cpp -lpthread -o cpu.out

pushd nvcc
echo nvcc -arch=compute_72 -rdc=true --default-stream per-thread  *.cu -o gpu.out
nvcc --gpu-code=compute_72 -arch=compute_72 -rdc=true -std=c++14 --default-stream per-thread  *.cu
cp gpu.out ../
popd
