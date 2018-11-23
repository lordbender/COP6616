# Build Instructions
1. For 7.5 (UNF Machines), run the command below from the root directory run.
    - "nvcc -rdc=true --default-stream per-thread -std=c++11 *.cu"
2. if you have a cuda 8 capable device, switch out all 7.5 files for 8.0 files.
    - "nvcc -arch=compute_53 -rdc=true --default-stream per-thread -std=c++11 *.cu"

# Running the program Instructions
1. Build the Cuda Files
    - See Instructions Above.
2. Run "./a.out 1000"
    - Of the form "./a.out \[size of test set\]


nvcc -rdc=true --default-stream per-thread -std=c++11 *.cu