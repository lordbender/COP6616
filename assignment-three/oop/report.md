# Analysis of O(n*log(n)) Shared Memory

## Sequential
As expected, single threaded, or OS managed program optimization was ridiculously fast
for golang. Sequential execution of merge sort, even for very large sets was fast, efficient and 
had only a light to medium impact to the OS.

## Goroutine via Buffered Channels Threaded
Although this noticeably reduced the resource usage impact on the 
host machine, it did not speed up the execution speed of the program.
It appears to increased architecture efficiency on memory usage and core usage, while slightly increasing the overall 
execution time of the program.

## Speedup and Efficiency measured against Sequential Execution 
Operations: 1,000,000
S = 0.43 / 1.8 = 0.239
E = 0.239 / 64 = 0.003734375

Note:   I messed around with the semaphore extensively trying to get the performance up,
        but golang is pretty stubborn about throttling. in the end, for n*log(n) at least, I do not 
        think it is possible to beat sequential execution times by threading.

# Analysis of O(n^2) Shared Memory
Operations: 40,000
S = 12.521956485 / 14.21036863 = 0.88118449359
E = 0.88118449359 / 64 = 0.01376850771

Note:   Same thing here, I messed around with the semaphore extensively trying to get the performance up,
        but kept running into stubborn the throttling of Goroutines. in the end, for O(n^2) operations, I do not 
        think it is possible to beat sequential execution times by threading. On a more interesting note, I was able to
        get MUCH closer to sequential times by messing with the critical sections for n^2 operations than I was
        able to get for nlog(n) operations. Takeaways, the more operations, the greater the impact of threading.


------------------------------------ Begin Distributed Memory Analysis ---------------------------------------------------------

Note:   There was a LOT of trouble here. I adjusted the both the number of concurrent requests, and the critical 
        Lock/Semaphore throttling quite a bit, but in the end, there was way TOO much overhead from the thread managment 
        and the network latency to have a prayer in the world of matching sequential operation times. For O(nlog(n)) operations
        the fastest path an answer is almost certainly sticking with sequential programing.

Analysis:   Too much overhead, way too few operations to bother distributing. Distributed memory "might" 
            give us an advantage if we were in a much higher complexity space, such as a non-polynomial 
            one for example, O(2^n) or higher. but for polynomial operations, using golang, we are better
            off leveraging coroutines, channels and buffers.

# Analysis of O(n*log(n)) Distributed Memory
Beowulf:
    13 compute nodes
    4 Cores each

Operations: 1000
S = 0.0343.784 / .148.830743  = 0.0023098991
E =  0.0023098991 / (13 * 4) = 0.00004442113

Not advantageous to distribute.

# Analysis of O(n^2) Distributed Memory
Beowulf:
    13 compute nodes
    4 Cores each

Operations: 500
S = 0.002493186 / 155.598553768  = 0.00001602319
E =  0.00001602319 / (13 * 4) = 0.000000308138269

Not advantageous to distribute.

------------------------------------ End Distributed Memory Analysis ---------------------------------------------------------

# Measured Runs: Sequential Shared Memory
#Host environment: cisatlas.ccec.unf.edu#

## O(n*log(n)) Runs Outcomes

### 1,000
[n00599835@cisatlas oop]$ go run main.go --size=1000 --nlogn

Report for: Linear MergeSort
        Hostname          : cisatlas.ccec.unf.edu
        Complexity        : O(n*log(n))
        Duration of Run   : 343.784us
        Size of test set  : 1000

### 10,000
    Report for: Linear MergeSort
            Hostname          : cisatlas.ccec.unf.edu
            Complexity        : O(n*log(n))
            Duration of Run   : 4.261944ms
            Size of test set  : 10000

### 100,000
    Report for: Linear MergeSort
            Hostname          : cisatlas.ccec.unf.edu
            Complexity        : O(n*log(n))
            Duration of Run   : 40.692877ms
            Size of test set  : 100000


### 1,00,0000
    Report for: Linear MergeSort
            Hostname          : cisatlas.ccec.unf.edu
            Complexity        : O(n*log(n))
            Duration of Run   : 429.373408ms
            Size of test set  : 1000000

## O(n^2) Run Outcomes

### 500
[n00599835@cisatlas oop]$ go run main.go --size=500 --nsquared

Report for: Sequential Square Matrix
        Hostname          : cisatlas.ccec.unf.edu
        Complexity        : O(n^2)
        Duration of Run   : 2.493186ms
        Size of test set  : 500

### 10,000
Report for: Sequential Square Matrix
        Hostname          : cisatlas.ccec.unf.edu
        Complexity        : O(n^2)
        Duration of Run   : 781.520774ms
        Size of test set  : 10000
### 20,000
Report for: Sequential Square Matrix
        Hostname          : cisatlas.ccec.unf.edu
        Complexity        : O(n^2)
        Duration of Run   : 3.010648463s
        Size of test set  : 20000
### 40,000
Report for: Sequential Square Matrix
        Hostname          : cisatlas.ccec.unf.edu
        Complexity        : O(n^2)
        Duration of Run   : 12.521956485s
        Size of test set  : 40000

# Goroutines with Channels, Threaded Shared Memory Runs
#Host environment: cisatlas.ccec.unf.edu#

## O(n*log(n)) Run Outcomes

### 10,000
    Report for: Shared Memory, Threaded Parallel MergeSort
            Hostname          : cisatlas.ccec.unf.edu
            Complexity        : O(n*log(n))
            Duration of Run   : 18.741988ms
            Size of test set  : 10000

### 100,000
    Report for: Shared Memory, Threaded Parallel MergeSort
            Hostname          : cisatlas.ccec.unf.edu
            Complexity        : O(n*log(n))
            Duration of Run   : 162.636596ms
            Size of test set  : 100000

### 1,000,000
    Report for: Shared Memory, Threaded Parallel MergeSort
            Hostname          : cisatlas.ccec.unf.edu
            Complexity        : O(n*log(n))
            Duration of Run   : 1.760324075s
            Size of test set  : 1000000

## O(n^2) Run Outcomes

### 10,000
Report for: Shared Memory, Threaded Parallel Square Matrix
        Hostname          : cisatlas.ccec.unf.edu
        Complexity        : O(n^2)
        Duration of Run   : 1.050560723s
        Size of test set  : 10000

### 20,000
Report for: Shared Memory, Threaded Parallel Square Matrix
        Hostname          : cisatlas.ccec.unf.edu
        Complexity        : O(n^2)
        Duration of Run   : 4.572166647s
        Size of test set  : 20000

### 40,000
Report for: Shared Memory, Threaded Parallel Square Matrix
        Hostname          : cisatlas.ccec.unf.edu
        Complexity        : O(n^2)
        Duration of Run   : 14.21036863s
        Size of test set  : 40000

# Client Server, HTTP Distributed Memory Runs
#Host environment: uranus.ccec.unf.edu Beowulf Cluster compute-0-[0-12] and root -> 127.0.0.1#

## O(n*log(n)) Run Outcomes

### 1,000
[n00599835@uranus oop]$ go run main.go --size=1000 --nlogn --rocks --hostsfile

Report for: Non-Shared Memory, Distributed Parallel Merge Sort
        Hostname          : uranus.ccec.unf.edu
        Complexity        : O(n*log(n))
        Duration of Run   : 148.830743ms
        Size of test set  : 1000

### 2,500
[n00599835@uranus oop]$ go run main.go --size=2500 --nlogn --rocks --hostsfile

Report for: Non-Shared Memory, Distributed Parallel Merge Sort
        Hostname          : uranus.ccec.unf.edu
        Complexity        : O(n*log(n))
        Duration of Run   : 461.430255ms
        Size of test set  : 2500

### 5,000
[n00599835@uranus oop]$ go run main.go --size=5000 --nlogn --rocks --hostsfile

Report for: Non-Shared Memory, Distributed Parallel Merge Sort
        Hostname          : uranus.ccec.unf.edu
        Complexity        : O(n*log(n))
        Duration of Run   : 871.664603ms
        Size of test set  : 5000

## O(n^2) Run Outcomes

### 100
[n00599835@uranus oop]$ go run main.go --size=100 --nsquared --rocks --hostsfile

Report for: Non-Shared Memory, Distributed Parallel Square Matrix
        Hostname          : uranus.ccec.unf.edu
        Complexity        : O(n^2)
        Duration of Run   : 1.891475186s
        Size of test set  : 100

### 500
[n00599835@uranus oop]$ go run main.go --size=500 --nsquared --rocks --hostsfile

Report for: Non-Shared Memory, Distributed Parallel Square Matrix
        Hostname          : uranus.ccec.unf.edu
        Complexity        : O(n^2)
        Duration of Run   : 2m35.598553768s
        Size of test set  : 500

# Atlas Environment Load at Test time
There was another user on during my testing, but they were consistently idle.

[n00599835@cisatlas oop]$ top
top - 11:55:55 up 431 days,  2:32,  1 user,  load average: 0.00, 0.00, 0.00
Tasks: 1400 total,   4 running, 1392 sleeping,   4 stopped,   0 zombie
Cpu(s):  0.6%us,  3.3%sy,  0.0%ni, 96.1%id,  0.0%wa,  0.0%hi,  0.0%si,  0.0%st
Mem:  132281152k total,  8094148k used, 124187004k free,   335656k buffers
Swap:  4194300k total,        0k used,  4194300k free,  3323276k cached

  PID USER      PR  NI  VIRT  RES  SHR S %CPU %MEM    TIME+  COMMAND
36221 n0087198  20   0  134m 2972 2140 S  5.2  0.0   1212:53 master
36259 n0087198  20   0  134m 2976 2140 S  5.2  0.0   1213:48 master
36333 n0087198  20   0  134m 2976 2140 S  5.2  0.0   1215:21 master

# Uranus Environment Load at Test time
top - 13:38:07 up 86 days, 15 min, 16 users,  load average: 0.01, 0.08, 0.18
Tasks: 316 total,   1 running, 315 sleeping,   0 stopped,   0 zombie
Cpu(s):  0.2%us,  0.1%sy,  0.0%ni, 99.5%id,  0.1%wa,  0.0%hi,  0.0%si,  0.0%st
Mem:   8057848k total,  5700444k used,  2357404k free,   321452k buffers
Swap:  1023996k total,   106536k used,   917460k free,  4428400k cached

  PID USER      PR  NI  VIRT  RES  SHR S %CPU %MEM    TIME+  COMMAND
  302 root      20   0     0    0    0 S  2.0  0.0  11:31.35 scsi_eh_1
    1 root      20   0 19356  556  328 S  0.0  0.0   0:00.96 init
    2 root      20   0     0    0    0 S  0.0  0.0   0:00.00 kthreadd
    3 root      RT   0     0    0    0 S  0.0  0.0   0:02.64 migration/0

# Conclusions

## About GOLANG
    Golang goes its own direction, choosing not to leverage the paradigms 
    that most modern languages share. Java, JavaScript, C# and many others 
    follow many common grammar strictures, making it easy for developers to
    go between them. Golang. chose not follow many of those strictures, and that
    makes getting used to it a little harder, but still achievable. In the end,
    while interesting, I'll stick with Java and Javascript for my projects, as
    they support SOLID, Functional, Aspect and Object oriented programming more 
    fluidly and have all of the same features.

## About Concurrency in GOLANG
    Concurrent is where GOLANG really shines! With first class coroutine support,
    and a simple means of managing the deferment and parallelization of those routines 
    by using channels and buffers, golang makes managing shared memory distributed 
    programming as simple as it can be. From a grammar perspective, this is probably it's
    strongest feature.