# Analysis Based on Specs Provided
```text
Model: GeForce GTX TITAN X
Video BIOS:    84.00.45.00.90
```
[Specs for GPU: GTX TITAN X](https://www.geforce.com/hardware/desktop-gpus/geforce-gtx-titan-x/specifications)
[Concurrency Model Based On](https://devblogs.nvidia.com/gpu-pro-tip-cuda-7-streams-simplify-concurrency/)
[Dynamic Parallelizm](https://devblogs.nvidia.com/cuda-dynamic-parallelism-api-principles/)

## Speedup and Efficiency
```text
    Note 1: Speedup will be measured against Sequential and Shared Memory Threaded. 
    Note 2: Speedup Measured at 100,000 Signed Integers.

    Issue: Once again, we are trying to beat an algorithm that has fantastic efficiency, and loosing to latency and bandwidth.
           The portion of the program that cannot be parallized is the issue. Single threaded, and multi-threaded shared memory 
           are way out in front here. I suspect, that given an algorithm that has more operation per data item, we can see marked 
           improvement from GPU.

    Related Work: 
        http://www.cse.chalmers.se/~tsigas/papers/GPU-Quicksort-jea.pdf

        There are means to potentially beat shared memory sorting times, especially in the case of non-numerical sets. But I am
        not able to re-produce the results given my current knowledge level, nor within the time alloted.
```

### Measured Run
```text
Note: All runs posted in Outcomes Section Below.

CPU O(n*log(n)) Sequential Radix: Completed 1000000 numbers in 0.303327 seconds!!!
CPU O(n*log(n)) Sequential Quicksort: Completed 1000000 numbers in 0.201159 seconds!!!
CPU O(n*log(n)) Threaded Quicksort: Completed 1000000 numbers in 0.125402 seconds!!!

GPU O(n*log(n)) GPU Quicksort: Completed 1000000 numbers in 80.430000 seconds!!!

```

### CPU vs GPU Sequential
```text
    S = 25.195350 / 0.320615 = 78.5844392808 
    E = 78.5844392808 / 3072 = 0.0255794270833333
```

### CPU PThreads vs GPU - Shared Memory CPU Treaded vs GPU Streams


```text
    Note: Host has 12 Cores for Threaded Operations.
    n00599835@cislocal-GPU0:~/COP6616/assignment-four$ nproc
    12

    S = 6.308422 / 0.320615 = 19.6760039299 
    E = 19.6760039299  / (3072 - 12) = 0.00643006664
```

# Outcomes - All Test Runs

## GPU Runs
```text
[n00599835@cis-gpu1 cuda]$ ./gpu.out 10000
        GPU O(n*log(n)) GPU Quicksort: Completed 10000 numbers in 0.840000 seconds!!!
[n00599835@cis-gpu1 cuda]$ ./gpu.out 100000
        GPU O(n*log(n)) GPU Quicksort: Completed 100000 numbers in 7.740000 seconds!!!
[n00599835@cis-gpu1 cuda]$ ./gpu.out 1000000
        GPU O(n*log(n)) GPU Quicksort: Completed 1000000 numbers in 81.270000 seconds!!!
```

## CPU Runs
```text
[n00599835@cis-gpu1 cpp]$ ./cpu.out 10000
        CPU O(n*log(n)) Sequential Radix: Completed 10000 numbers in 0.007596 seconds!!!
        CPU O(n*log(n)) Sequential Quicksort: Completed 10000 numbers in 0.003559 seconds!!!
        CPU O(n*log(n)) Threaded Quicksort: Completed 10000 numbers in 0.006769 seconds!!!
[n00599835@cis-gpu1 cpp]$ ./cpu.out 100000
        CPU O(n*log(n)) Sequential Radix: Completed 100000 numbers in 0.046407 seconds!!!
        CPU O(n*log(n)) Sequential Quicksort: Completed 100000 numbers in 0.022111 seconds!!!
        CPU O(n*log(n)) Threaded Quicksort: Completed 100000 numbers in 0.011876 seconds!!!
[n00599835@cis-gpu1 cpp]$ ./cpu.out 1000000
        CPU O(n*log(n)) Sequential Radix: Completed 1000000 numbers in 0.268029 seconds!!!
        CPU O(n*log(n)) Sequential Quicksort: Completed 1000000 numbers in 0.200867 seconds!!!
        CPU O(n*log(n)) Threaded Quicksort: Completed 1000000 numbers in 0.122772 seconds!!!
```

# Compiler Flags
```text
        There are a lot of permutations of flags. These flags seem to have fantastic consequences on the outcomes.

        My final Combination of Flags:
        nvcc -arch=compute_35 -rdc=true -maxrregcount=0  --machine 64 -cudart static *.cu -o gpu.out
```