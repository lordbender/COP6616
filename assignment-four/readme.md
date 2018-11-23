# Build Instructions
1. From the root directory run.
    - "nvcc -arch=compute_53 -rdc=true --default-stream per-thread -std=c++11 *.cu"

# Running the program Instructions
1. Build the Cuda Files
    - See Instructions Above.
2. Run "./a.out 1000"
    - Of the form "./a.out \[size of test set\]


nvcc -arch=compute_53 -rdc=true --default-stream per-thread -std=c++11 *.cu