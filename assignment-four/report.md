# Outcomes
```text
n00599835@cislocal-GPU0:~/COP6616/assignment-four$ nvcc -arch=compute_53 -rdc=true --default-stream per-thread -std=c++11 *.cu
n00599835@cislocal-GPU0:~/COP6616/assignment-four$ ./a.out 1000


        CPU O(n*log(n)) Sequential Radix: Completed 1000 numbers in 0.000772 seconds!!!
        CPU O(n*log(n)) Sequential Quicksort: Completed 1000 numbers in 0.000297 seconds!!!
        CPU O(n*log(n)) Threaded Quicksort: Completed 1000 numbers in 0.001797 seconds!!!
        GPU O(n*log(n)) Streamed: Completed 1000 numbers in 0.155566 seconds!!!

n00599835@cislocal-GPU0:~/COP6616/assignment-four$ ./a.out 10000000


        CPU O(n*log(n)) Sequential Radix: Completed 10000000 numbers in 2.590751 seconds!!!
        CPU O(n*log(n)) Sequential Quicksort: Completed 10000000 numbers in 2.201237 seconds!!!
        CPU O(n*log(n)) Threaded Quicksort: Completed 10000000 numbers in 1.203184 seconds!!!
        GPU O(n*log(n)) Streamed: Completed 10000000 numbers in 0.167194 seconds!!!
```