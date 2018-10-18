
# Multi-threaded Distributed Program Overview

On the higher complexity algorithms there was a nice and measurable 
speedup when adding in the additional compute clusters.

# Localhost and Rocks Hosts

## Note 
        It is perfectly legal to include localhost (127.0.0.1) in the hosts list, this allows us
        to include the rocks host and all of the rocks clusters in the distribution model. I tried 
        it both ways and saw a massive advantage to keeping localhost in the hosts.

## Hosts List
- 127.0.0.1
- compute-0-0
- compute-0-1
- compute-0-3
- compute-0-4
- compute-0-5
- compute-0-6
- compute-0-7
- compute-0-8
- compute-0-9
- compute-0-10
- compute-0-11
- compute-0-12

# Analysis

## Machine Load at Time of Test Runs

top - 19:26:07 up 54 days,  5:03,  2 users,  load average: 11.33, 6.80, 3.70
Tasks: 255 total,   1 running, 254 sleeping,   0 stopped,   0 zombie
Cpu(s):  0.0%us,  0.2%sy,  0.0%ni, 99.8%id,  0.0%wa,  0.0%hi,  0.0%si,  0.0%st
Mem:   8057848k total,  2402360k used,  5655488k free,   268124k buffers
Swap:  1023996k total,   146288k used,   877708k free,  1767220k cached

  PID USER      PR  NI  VIRT  RES  SHR S %CPU %MEM    TIME+  COMMAND
11591 n0059983  20   0 15172 1352  924 R  0.3  0.0   0:00.04 top
    1 root      20   0 19356  556  328 S  0.0  0.0   0:00.88 init
    2 root      20   0     0    0    0 S  0.0  0.0   0:00.00 kthreadd
    3 root      RT   0     0    0    0 S  0.0  0.0   0:01.57 migration/0
    4 root      20   0     0    0    0 S  0.0  0.0   0:06.88 ksoftirqd/0

## O(1) Return First Number

### Discussion
Barely worth discussing a O(1), I included this 
for completeness only.

*Speedup when using hosts file* 
S = 2.229637 / 3.425819 = 0.6508

Speedup less than 1...

#mpirun -np 64 a.out 50000000#
Random Numbers Created: 50000000
Number of Processes:    64
Elements Per Process:   781251

Algorithm: MPI Return First Number
        Big O          : O(1)
        Execution Time : 2.229637
        Dataset Size   : 50000000
        Process Count  : 64
        Target Located : 64 times

#mpirun -np 64 -hostfile hosts a.out 50000000#
Random Numbers Created: 50000000
Number of Processes:    64
Elements Per Process:   781251

Algorithm: MPI Return First Number
        Big O          : O(1)
        Execution Time : 3.425819
        Dataset Size   : 50000000
        Process Count  : 64
        Target Located : 64 times

## O(n) Linear Search
### Discussion
There was a massive slowdown when distributing the work across the rocks hosts in the O(n) case.

*Speedup when using hosts file* 
S = 1.500193 / 3.376781 = 0.44426

So adding on additional hosts and distributing the work 
gives us a negative benefit in the O(n) case. I was so surprised by this
that I ran cat on my hosts file to make sure I had it set up correctly! 

Speedup less than 1...

#### Best MPI without rocks case:
#mpirun -np 32 a.out 50000000#
Algorithm: MPI Linear Search
        Execution Time : 1.500193
        Dataset Size   : 50000000

#### Best MPI with rocks case:
#mpirun -np 32 -hostfile hosts a.out 50000000#
Algorithm: MPI Linear Search
        Big O          : O(n)
        Execution Time : 3.376781

#### MPI without host file:

#mpirun -np 64 a.out 50000000#
Random Numbers Created: 50000000
Number of Processes:    64
Elements Per Process:   781251

Searching for:          9

Algorithm: MPI Linear Search
        Big O          : O(n)
        Execution Time : 2.045766
        Dataset Size   : 50000000
        Process Count  : 64
        Target Located : 64 times

#mpirun -np 100 a.out 50000000#
Random Numbers Created: 50000000
Number of Processes:    100
Elements Per Process:   500001

Searching for:          9

Algorithm: MPI Linear Search
        Big O          : O(n)
        Execution Time : 3.070954
        Dataset Size   : 50000000
        Process Count  : 100
        Target Located : 100 times


#mpirun -np 32 a.out 50000000#
Random Numbers Created: 50000000
Number of Processes:    32
Elements Per Process:   1562501

Searching for:          9

Algorithm: MPI Linear Search
        Big O          : O(n)
        Execution Time : 1.500193
        Dataset Size   : 50000000
        Process Count  : 32
        Target Located : 32 times

#### MPI wit host file:

#mpirun -np 32 -hostfile hosts a.out 50000000#
Random Numbers Created: 50000000
Number of Processes:    32
Elements Per Process:   1562501

Searching for:          9


Algorithm: MPI Linear Search
        Big O          : O(n)
        Execution Time : 3.376781
        Dataset Size   : 50000000
        Process Count  : 32
        Target Located : 32 times

#mpirun -np 64 -hostfile hosts a.out 50000000#
Random Numbers Created: 50000000
Number of Processes:    64
Elements Per Process:   781251

Searching for:          9

Algorithm: MPI Linear Search
        Big O          : O(n)
        Execution Time : 3.485926
        Dataset Size   : 50000000
        Process Count  : 64
        Target Located : 64 times

#mpirun -np 100 -hostfile hosts a.out 50000000#
Random Numbers Created: 50000000
Number of Processes:    100
Elements Per Process:   500001

Searching for:          9

Algorithm: MPI Linear Search
        Big O          : O(n)
        Execution Time : 3.439782
        Dataset Size   : 50000000
        Process Count  : 100
        Target Located : 100 times

#mpirun -np 120 -hostfile hosts a.out 50000000#
Random Numbers Created: 50000000
Number of Processes:    120
Elements Per Process:   416667

Searching for:          9

Algorithm: MPI Linear Search
        Big O          : O(n)
        Execution Time : 3.433538
        Dataset Size   : 50000000
        Process Count  : 120
        Target Located : 120 times

#cat hosts#
127.0.0.1
compute-0-0
compute-0-1
compute-0-3
compute-0-4
compute-0-5
compute-0-6
compute-0-7
compute-0-8
compute-0-9
compute-0-10
compute-0-11

## O(n^2) Bubble Sort
### Discussion
There was a massive speedup when distributing the work across the rocks hosts in the O(n^2) case.

*Speedup when using hosts file* 
S = 14.749020 / 1.292437 = 11.41

So adding on additional hosts and distributing the work 
gives us about an 11 times faster processing rate on the 
n^2 case.

#### Best MPI without rocks case:
#mpirun -np 100 ./a.out 1000000#

Algorithm: MPI Bubble Sort
        Big O          : O(n^2)
        Execution Time : 14.749020

#### Best MPI with rocks case:
#mpirun -np 100 -hostfile hosts ./a.out 1000000#

Algorithm: MPI Bubble Sort
        Big O          : O(n^2)
        Execution Time : 1.292437

### MPI Without hosts file

#mpirun -np 64 ./a.out 1000000#

Algorithm: MPI Bubble Sort
        Big O          : O(n^2)
        Execution Time : 21.661800
        Dataset Size   : 1000000
        Process Count  : 64

#mpirun -np 100 ./a.out 1000000#

Algorithm: MPI Bubble Sort
        Big O          : O(n^2)
        Execution Time : 14.749020
        Dataset Size   : 1000000
        Process Count  : 100

### MPI With hosts file

#mpirun -np 64 -hostfile hosts ./a.out 1000000#

Algorithm: MPI Bubble Sort
        Big O          : O(n^2)
        Execution Time : 2.244834
        Dataset Size   : 1000000
        Process Count  : 64

#mpirun -np 32 -hostfile hosts ./a.out 1000000#

Algorithm: MPI Bubble Sort
        Big O          : O(n^2)
        Execution Time : 5.311577
        Dataset Size   : 1000000
        Process Count  : 32

#mpirun -np 100 -hostfile hosts ./a.out 1000000#

Algorithm: MPI Bubble Sort
        Big O          : O(n^2)
        Execution Time : 1.292437
        Dataset Size   : 1000000
        Process Count  : 100

## O(n^3) Matrix Multiplication

### Discussion
There was a massive speedup when distributing the work across the rocks hosts in the O(n^3) case.

*Speedup when using hosts file* 
S = 18.951020 / 2.147575 = 8.82

So adding on additional hosts and distributing the work 
gives us about an 9 times faster processing rate on the 
n^3 case. Interesting as our exponent increases our 
speedup decreases. This is not unexpected, but it is 
interesting to see it illustrated so clearly.

#### Best MPI without rocks case:
#mpirun -np 32 a.out 550#
        Big O          : O(n^3)
        Execution Time : 18.951020

#### Best MPI with rocks case:
#mpirun -np 32 -hostfile hosts a.out 550#
        Big O          : O(n^3)
        Execution Time : 2.147575

### Without the Rocks Cluster Hosts
#mpirun -np 32 a.out 550#

Algorithm: MPI Matrix Multiplication
        Big O          : O(n^3)
        Execution Time : 18.951020
        Dataset Size   : 550
        Process Count  : 32

### With the Rocks Cluster Hosts

#mpirun -np 100 -hostfile hosts a.out 550#

Algorithm: MPI Matrix Multiplication
        Big O          : O(n^3)
        Execution Time : 3.358870
        Dataset Size   : 550
        Process Count  : 100

#mpirun -np 64 -hostfile hosts a.out 550#

Algorithm: MPI Matrix Multiplication
        Big O          : O(n^3)
        Execution Time : 2.229849
        Dataset Size   : 550
        Process Count  : 64

#mpirun -np 32 -hostfile hosts a.out 550#

Algorithm: MPI Matrix Multiplication
        Big O          : O(n^3)
        Execution Time : 2.147575
        Dataset Size   : 550
        Process Count  : 32
