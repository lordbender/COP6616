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

[n00599835@cis-gpu1 cpp]$ ./cpu.out 1000000
        CPU O(n*log(n)) Sequential Radix: Completed 1000000 numbers in 0.327945 seconds!!!
        CPU O(n*log(n)) Sequential Quicksort: Completed 1000000 numbers in 0.204192 seconds!!!
        CPU O(n*log(n)) Threaded Quicksort: Completed 1000000 numbers in 0.115369 seconds!!!    

[n00599835@cis-gpu1 cuda]$ ./gpu.out 1000000
        GPU O(n*log(n)) GPU Quicksort: Completed 1000000 numbers in 3.160000 seconds!!!
        GPU Processing Time, Minus Date Copies: 2.180000 seconds!!!
```

### CPU vs GPU Sequential
```text
    Note: I was unable to beat the sequential execution times by distributing to the GPU. 

    S = 0.204192 / 3.160000 = 0.06461772151 
    E = 0.06461772151 / 3072 = 0.00002103441
```

### CPU PThreads vs GPU - Shared Memory CPU Treaded vs GPU Streams

```text
    Note: I was unable to beat the threaded, shared memory execution times by distributing to the GPU. 
    Note: Host has 12 Cores for Threaded Operations.
          
          n00599835@cislocal-GPU0:~/COP6616/assignment-four$ nproc
          12

    S = 0.115369 / 3.160000 = 0.03650917721 
    E = 0.03650917721  / (3072 - 12) = 0.0000119311
```

# Outcomes - All Test Runs

## GPU Runs
```text
        [n00599835@cis-gpu1 cuda]$ ./gpu.out 10000
                GPU O(n*log(n)) GPU Quicksort: Completed 10000 numbers in 0.920000 seconds!!!
                GPU Processing Time, Minus Date Copies: 0.020000 seconds!!!

        [n00599835@cis-gpu1 cuda]$ ./gpu.out 100000
                GPU O(n*log(n)) GPU Quicksort: Completed 100000 numbers in 1.070000 seconds!!!
                GPU Processing Time, Minus Date Copies: 0.220000 seconds!!!

        [n00599835@cis-gpu1 cuda]$ ./gpu.out 1000000
                GPU O(n*log(n)) GPU Quicksort: Completed 1000000 numbers in 3.160000 seconds!!!
                GPU Processing Time, Minus Date Copies: 2.180000 seconds!!!

        [n00599835@cis-gpu1 cuda]$ ./gpu.out 10000000
                GPU O(n*log(n)) GPU Quicksort: Completed 10000000 numbers in 21.390000 seconds!!!
                GPU Processing Time, Minus Date Copies: 20.480000 seconds!!!
```

## CPU Runs
```text
        [n00599835@cis-gpu1 cpp]$ ./cpu.out 10000
                CPU O(n*log(n)) Sequential Radix: Completed 10000 numbers in 0.007665 seconds!!!
                CPU O(n*log(n)) Sequential Quicksort: Completed 10000 numbers in 0.003552 seconds!!!
                CPU O(n*log(n)) Threaded Quicksort: Completed 10000 numbers in 0.010592 seconds!!!

        [n00599835@cis-gpu1 cpp]$ ./cpu.out 100000
                CPU O(n*log(n)) Sequential Radix: Completed 100000 numbers in 0.061416 seconds!!!
                CPU O(n*log(n)) Sequential Quicksort: Completed 100000 numbers in 0.029553 seconds!!!
                CPU O(n*log(n)) Threaded Quicksort: Completed 100000 numbers in 0.016147 seconds!!!

        [n00599835@cis-gpu1 cpp]$ ./cpu.out 1000000
                CPU O(n*log(n)) Sequential Radix: Completed 1000000 numbers in 0.327945 seconds!!!
                CPU O(n*log(n)) Sequential Quicksort: Completed 1000000 numbers in 0.204192 seconds!!!
                CPU O(n*log(n)) Threaded Quicksort: Completed 1000000 numbers in 0.115369 seconds!!!

        [n00599835@cis-gpu1 cpp]$ ./cpu.out 10000000
                CPU O(n*log(n)) Sequential Radix: Completed 10000000 numbers in 2.498553 seconds!!!
                CPU O(n*log(n)) Sequential Quicksort: Completed 10000000 numbers in 2.158141 seconds!!!
                CPU O(n*log(n)) Threaded Quicksort: Completed 10000000 numbers in 0.820638 seconds!!!

        [n00599835@cis-gpu1 cpp]$ ./cpu.out 100000000
                CPU O(n*log(n)) Sequential Radix: Completed 100000000 numbers in 24.509212 seconds!!!
                CPU O(n*log(n)) Sequential Quicksort: Completed 100000000 numbers in 25.069645 seconds!!!
                CPU O(n*log(n)) Threaded Quicksort: Completed 100000000 numbers in 6.301989 seconds!!!
```

# Compiler Flags
```text
        There are a lot of permutations of flags. These flags seem to have fantastic consequences on the outcomes.

        My final Combination of Flags:
        nvcc -arch=compute_35 -rdc=true -maxrregcount=0  --machine 64 -cudart static *.cu -o gpu.out
```

# Top
```text
        top - 14:49:26 up 30 days,  4:20,  2 users,  load average: 0.47, 0.22, 0.31
        Tasks: 223 total,   1 running, 222 sleeping,   0 stopped,   0 zombie
        %Cpu(s):  0.0 us,  0.5 sy,  0.0 ni, 99.5 id,  0.0 wa,  0.0 hi,  0.0 si,  0.0 st
        KiB Mem : 32767692 total, 17077236 free,   882316 used, 14808140 buff/cache
        KiB Swap: 16449532 total, 16449532 free,        0 used. 31168680 avail Mem

        PID USER      PR  NI    VIRT    RES    SHR S  %CPU %MEM     TIME+ COMMAND
        19405 n005998+  20   0  157864   2252   1500 R   6.2  0.0   0:00.01 top
        1 root      20   0  191708   4720   2520 S   0.0  0.0   1:20.89 systemd
        2 root      20   0       0      0      0 S   0.0  0.0   0:00.41 kthreadd
        3 root      20   0       0      0      0 S   0.0  0.0   0:00.91 ksoftirqd/0
        5 root       0 -20       0      0      0 S   0.0  0.0   0:00.00 kworker/0:0H
        7 root      rt   0       0      0      0 S   0.0  0.0   0:01.86 migration/0
        8 root      20   0       0      0      0 S   0.0  0.0   0:00.00 rcu_bh
        9 root      20   0       0      0      0 S   0.0  0.0   1:41.54 rcu_sched
        10 root      rt   0       0      0      0 S   0.0  0.0   0:07.79 watchdog/0
        11 root      rt   0       0      0      0 S   0.0  0.0   0:07.60 watchdog/1
        12 root      rt   0       0      0      0 S   0.0  0.0   0:01.32 migration/1
        13 root      20   0       0      0      0 S   0.0  0.0   0:00.04 ksoftirqd/1
        15 root       0 -20       0      0      0 S   0.0  0.0   0:00.00 kworker/1:0H
```