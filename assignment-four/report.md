# Analysis Based on Specs Provided
```text
Model: GeForce GTX TITAN X
Video BIOS:    84.00.45.00.90
```
[Specs for GPU: GTX TITAN X](https://www.geforce.com/hardware/desktop-gpus/geforce-gtx-titan-x/specifications)
[Concurrency Model Based On](https://devblogs.nvidia.com/gpu-pro-tip-cuda-7-streams-simplify-concurrency/)

## Speedup and Efficiency
```text
    Note 1: Speedup will be measured against Sequential and Shared Memory Threaded. 

    Note 2: Speedup Measured at 100,000,000 Signed Integers.
```

### Measured Run
```text
Note: All runs posted in Outcomes Section Below.

n00599835@cislocal-GPU0:~/COP6616/assignment-four$ ./a.out 100000000


        CPU O(n*log(n)) Sequential Radix: Completed 100000000 numbers in 25.906587 seconds!!!
        CPU O(n*log(n)) Sequential Quicksort: Completed 100000000 numbers in 25.195350 seconds!!!
        CPU O(n*log(n)) Threaded Quicksort: Completed 100000000 numbers in 6.308422 seconds!!!
        GPU O(n*log(n)) Streamed: Completed 100000000 numbers in 0.320615 seconds!!!
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

```text
n00599835@cislocal-GPU0:~/COP6616/assignment-four$ nvcc -arch=compute_53 -rdc=true --default-stream per-thread -std=c++11 *.cu
n00599835@cislocal-GPU0:~/COP6616/assignment-four$ ./a.out 1000


        CPU O(n*log(n)) Sequential Radix: Completed 1000 numbers in 0.000750 seconds!!!
        CPU O(n*log(n)) Sequential Quicksort: Completed 1000 numbers in 0.000316 seconds!!!
        CPU O(n*log(n)) Threaded Quicksort: Completed 1000 numbers in 0.001797 seconds!!!
        GPU O(n*log(n)) Streamed: Completed 1000 numbers in 0.191406 seconds!!!

n00599835@cislocal-GPU0:~/COP6616/assignment-four$ ./a.out 10000


        CPU O(n*log(n)) Sequential Radix: Completed 10000 numbers in 0.011103 seconds!!!
        CPU O(n*log(n)) Sequential Quicksort: Completed 10000 numbers in 0.001936 seconds!!!
        CPU O(n*log(n)) Threaded Quicksort: Completed 10000 numbers in 0.003024 seconds!!!
        GPU O(n*log(n)) Streamed: Completed 10000 numbers in 0.155209 seconds!!!

n00599835@cislocal-GPU0:~/COP6616/assignment-four$ ./a.out 100000


        CPU O(n*log(n)) Sequential Radix: Completed 100000 numbers in 0.033775 seconds!!!
        CPU O(n*log(n)) Sequential Quicksort: Completed 100000 numbers in 0.017509 seconds!!!
        CPU O(n*log(n)) Threaded Quicksort: Completed 100000 numbers in 0.010942 seconds!!!
        GPU O(n*log(n)) Streamed: Completed 100000 numbers in 0.185900 seconds!!!

n00599835@cislocal-GPU0:~/COP6616/assignment-four$ ./a.out 1000000


        CPU O(n*log(n)) Sequential Radix: Completed 1000000 numbers in 0.271512 seconds!!!
        CPU O(n*log(n)) Sequential Quicksort: Completed 1000000 numbers in 0.187281 seconds!!!
        CPU O(n*log(n)) Threaded Quicksort: Completed 1000000 numbers in 0.076339 seconds!!!
        GPU O(n*log(n)) Streamed: Completed 1000000 numbers in 0.152570 seconds!!!

n00599835@cislocal-GPU0:~/COP6616/assignment-four$ ./a.out 10000000


        CPU O(n*log(n)) Sequential Radix: Completed 10000000 numbers in 2.617365 seconds!!!
        CPU O(n*log(n)) Sequential Quicksort: Completed 10000000 numbers in 2.166389 seconds!!!
        CPU O(n*log(n)) Threaded Quicksort: Completed 10000000 numbers in 0.525630 seconds!!!
        GPU O(n*log(n)) Streamed: Completed 10000000 numbers in 0.163671 seconds!!!

n00599835@cislocal-GPU0:~/COP6616/assignment-four$ ./a.out 100000000


        CPU O(n*log(n)) Sequential Radix: Completed 100000000 numbers in 25.906587 seconds!!!
        CPU O(n*log(n)) Sequential Quicksort: Completed 100000000 numbers in 25.195350 seconds!!!
        CPU O(n*log(n)) Threaded Quicksort: Completed 100000000 numbers in 6.308422 seconds!!!
        GPU O(n*log(n)) Streamed: Completed 100000000 numbers in 0.320615 seconds!!!

n00599835@cislocal-GPU0:~/COP6616/assignment-four$ ./a.out 200000000


        CPU O(n*log(n)) Sequential Radix: Completed 200000000 numbers in 51.674903 seconds!!!
        CPU O(n*log(n)) Sequential Quicksort: Completed 200000000 numbers in 52.997838 seconds!!!
        CPU O(n*log(n)) Threaded Quicksort: Completed 200000000 numbers in 11.551333 seconds!!!
        GPU O(n*log(n)) Streamed: Completed 200000000 numbers in 0.521155 seconds!!!
```

# TOP at time of Testing
```text
    top - 09:59:21 up 26 days, 19:52,  3 users,  load average: 0.47, 0.43, 0.30
    Tasks: 805 total,   1 running, 711 sleeping,   3 stopped,   0 zombie
    %Cpu(s):  1.2 us,  0.6 sy,  0.0 ni, 98.2 id,  0.0 wa,  0.0 hi,  0.0 si,  0.0 st
    KiB Mem : 32775588 total,  6586644 free, 14722612 used, 11466332 buff/cache
    KiB Swap:  2097148 total,  2096380 free,      768 used. 16887580 avail Mem

    %Cpu(s):  4.3 us,  4.3 sy,  0.0 ni, 91.3 id,  0.0 wa,  0.0 hi,  0.0 si,  0.0 st
    19723 n009768+  20   0 2096772   8328   6752 S   5.6  0.0   2365:12 pulseaudio
    19212 n014231+  20   0 2807020 793372 126432 S   4.3  2.4 426:45.20 Web Content
    20222 n014231+  20   0 2069132 387320 122208 S   3.3  1.2 479:08.67 Web Content


    25555 n014231+  20   0   17336   4768   1992 S   1.7  0.0 335:04.61 nvidia-smi
    21162 n014231+  20   0   17336   4840   2064 S   1.3  0.0 464:13.09 nvidia-smi
    21131 n011702+  20   0 2256696 402244 165972 S   1.0  1.2 241:55.38 firefox
    21386 n011702+  20   0 1734416 235416 138404 S   1.0  0.7 241:05.89 Web Content
    25878 n005998+  20   0   51976   5016   3572 R   1.0  0.0   0:00.18 top
```