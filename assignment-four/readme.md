# Assignment Definition
```text
    Project 4 Parallel Computing --- Due 12/1/18 at 23:59

    For this project you are to take advantage of GPU's  
    capabilities offered.

    Implement Listing 2.8 of parallel quicksort. Determine speed
    up realized.
```

# Build Instructions
1. Requires a Cuda 8 or higher capable device, Device Side Recursion needs to be supported.
    - Build c++ code for benchmarking
        - "cd cpp"
        - "g++ -std=c++14 *.cpp -lpthread -o cpu.out"
    - Build Cuda Code:
        - "cd cuda"
        - "nvcc -arch=compute_35 -rdc=true -maxrregcount=40  --machine 64 -cudart static *.cu -o gpu.out"

# Running the program Instructions
1. Build the Cuda Files
    - See Instructions Above.
    - There is a test suite if you prefer, that will build and execute the benchmarks at a size of 100000.
        - chmod 777 test.sh
        - ./test.sh
2. Run c++ Code
    - cd cpp
    - "g++ -std=c++11 *.cpp -lpthread -o cpu.out"
    - "./cpu.out \[size of test set\]"
        - ./cpu.out 100000
3. Run Cuda Code
    - cd cuda
    - "nvcc -arch=compute_35 -rdc=true -maxrregcount=40  --machine 64 -cudart static *.cu -o gpu.out"
    - "./gpu.out \[size of test set\]"
        - ./gpu.out 100000
