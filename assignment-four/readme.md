# Assignment Definition
```text
    Project 4 Parallel Computing --- Due 12/1/18 at 23:59

    For this project you are to take advantage of GPU's  
    capabilities offered.

    Implement Listing 2.8 of parallel quicksort. Determine speed
    up realized.
```

# Build Instructions
2. Requires a Cuda 8 or higher capable device, Device Side Recursion needs to be supported.
    - "g++ -std=c++14 *.cpp -lpthread -o cpu.out"
    - "nvcc -arch=compute_72 -rdc=true -std=c++11 --default-stream per-thread --resource-usage  *.cu"

# Running the program Instructions
1. Build the Cuda Files
    - See Instructions Above.
    - There is a Makefile if you prefer.
        - chmod 777 Makefile
        - ./Makefile
2. Run "./a.out 1000"
    - Of the form "./a.out \[size of test set\]
