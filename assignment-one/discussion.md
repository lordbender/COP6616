
# Assignment Discussion Requirements
	- You should include a discussion of the improved efficiency
	- Comment on the relative speed up of your implementation. 
	- Run your application on uranus and atlas, 
		- Be sure you monitor the machine load when collecting your data. 

# Linear Program Overview

[n00599835@cisatlas base-program]$ ./a.out 100000

Report of Linear performance for 100000 as the specified size:

Algorithm: Return First Number
        Big O          : O(1)
        Execution Time : 0.000000
        Dataset Size   : 100000


Algorithm: Linear Search
        Big O          : O(n)
        Execution Time : 0.000000
        Dataset Size   : 100000


Algorithm: Bubble Sort
        Big O          : O(n^2)
        Execution Time : 85.440000
        Dataset Size   : 100000


Algorithm: Matrix Multiplication
        Big O          : O(n^3)
        Execution Time : 5.310000
        Dataset Size   : 700

# MPI Program Overview

## Linear Search

### Speed-Up / Efficiency Reports CISAtlas and Uranus

#### Linear Search O(n)
[See Linear Search Results](./discussion.first.number.results.md)

#### Linear Search O(n)
[See Linear Search Results](./discussion.search.results.md)

#### Linear Search O(n^2)
[See Linear Search Results](./discussion.bubble.results.md)

#### Linear Search O(n^3)
[See Linear Search Results](./discussion.matrix.results.md)

# Description of Experiments

# Analysis of Speed-Up

# Analysis of Efficiency

# Outcomes and Observations

# Machine Load at Time of Testing

#  Environmental Conditions

**Everything Below this line is solely related to the runtime conditions at runtime**
---------------------------------------------------------------------------------------------------------------

## CISAtlas Environment Report

### lscpu
[n00599835@cisatlas ~]$ lscpu
CPU(s):                64
On-line CPU(s) list:   0-63
Thread(s) per core:    2
Core(s) per socket:    8
Socket(s):             4
Model name:            Intel(R) Xeon(R) CPU           X7550  @ 2.00GHz
CPU MHz:               1995.015
L1d cache:             32K
L1i cache:             32K
L2 cache:              256K
L3 cache:              18432K

### dmidecode (Some students "should" be considered for sudo'er roles...)
[n00599835@cisatlas ~]$ dmidecode
dmidecode 2.12
/dev/mem: Permission denied

Poor mans Memory Report...
[n00599835@cisatlas ~]$ awk '/MemTotal/ {print $2}' /proc/meminfo
132281152

[n00599835@cisatlas ~]$ cat /proc/meminfo
MemTotal:       132281152 kB
MemFree:        129197700 kB

### Notes

There was a *slight* load on atlas the first test cycle, so I reran a second time to 
ensure that the results were not effected.

### Uptime Run One (NO Other Non-Root Users)

#### uptime
 15:49:42 up 395 days,  5:26,  1 user,  load average: 0.00, 0.09, 0.25

#### cat /proc/loadavg
0.00 0.04 0.19 6/1758 59750

#### Load Average: 0.06, 0.04, 0.16
top - 15:55:27 up 395 days,  5:32,  1 user,  load average: 0.06, 0.04, 0.16
Tasks: 1396 total,   9 running, 1383 sleeping,   4 stopped,   0 zombie
Cpu(s):  0.6%us,  3.4%sy,  0.0%ni, 96.0%id,  0.0%wa,  0.0%hi,  0.0%si,  0.0%st
Mem:  132281152k total,  3055188k used, 129225964k free,   318284k buffers
Swap:  4194300k total,        0k used,  4194300k free,   976292k cached

  PID USER      PR  NI  VIRT  RES  SHR S %CPU %MEM    TIME+  COMMAND
36339 n0087198  20   0  134m 2980 2140 S  5.9  0.0 282:40.77 master
36162 n0087198  20   0  134m 2972 2140 S  5.6  0.0 282:25.30 master
36400 n0087198  20   0  134m 2980 2140 S  5.6  0.0 281:03.94 master
36270 n0087198  20   0  134m 2976 2140 S  5.3  0.0 283:17.41 master
36330 n0087198  20   0  134m 5020 2140 S  5.3  0.0 283:39.87 master
36538 n0087198  20   0  134m 2972 2140 S  5.3  0.0 280:03.89 master
36312 n0087198  20   0  134m 2968 2140 S  4.9  0.0 281:19.58 master
36182 n0087198  20   0  134m 2976 2140 S  4.6  0.0 283:28.44 master           


### Uptime Run Two (NO Other Non-Root Users)
#### uptime 
[n00599835@cisatlas ~]$ uptime
 10:58:25 up 396 days, 35 min,  2 users,  load average: 0.00, 0.00, 0.00

#### cat /proc/loadavg
[n00599835@cisatlas ~]$ cat /proc/loadavg
0.00 0.00 0.00 20/1758 78079

#### Load Average: 0.00, 0.00, 0.00
top - 10:54:52 up 396 days, 31 min,  2 users,  load average: 0.00, 0.00, 0.00
Tasks: 1398 total,  16 running, 1378 sleeping,   4 stopped,   0 zombie
Cpu(s):  0.6%us,  3.5%sy,  0.0%ni, 96.0%id,  0.0%wa,  0.0%hi,  0.0%si,  0.0%st
Mem:  132281152k total,  3077992k used, 129203160k free,   319056k buffers
Swap:  4194300k total,        0k used,  4194300k free,   977968k cached

  PID USER      PR  NI  VIRT  RES  SHR S %CPU %MEM    TIME+  COMMAND
36221 n0087198  20   0  134m 2972 2140 R  5.9  0.0 302:33.98 master
36404 n0087198  20   0  134m 2972 2140 S  5.6  0.0 305:25.17 master
36496 n0087198  20   0  134m 5016 2140 S  5.6  0.0 303:39.83 master
36130 n0087198  20   0  134m 2968 2140 S  5.3  0.0 302:12.78 master
36219 n0087198  20   0  134m 2972 2140 R  5.3  0.0 304:15.81 master
36245 n0087198  20   0  134m 2976 2140 S  5.3  0.0 303:11.69 master
36114 n0087198  20   0  134m 2972 2140 S  4.9  0.0 302:45.23 master
36303 n0087198  20   0  134m 2972 2140 S  4.9  0.0 302:52.07 master
36338 n0087198  20   0  134m 2972 2140 S  4.6  0.0 302:38.91 master
36454 n0087198  20   0  134m 2976 2140 S  4.6  0.0 302:44.07 master


## Uranus

