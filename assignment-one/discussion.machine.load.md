[Back to Main Report](./discussion.md)

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


## Uranus Environment Report

### Note
	Uranus is idle at the time of my runs

### Memory Total and Available 
[n00599835@uranus ~]$ cat /proc/meminfo
MemTotal:        8057848 kB
MemFree:         6190188 kB

### uptime 
[n00599835@uranus ~]$ uptime
 14:02:58 up 50 days, 23:40,  1 user,  load average: 0.01, 0.01, 0.00

### Load Average: 0.04, 0.02, 0.01
top - 14:01:29 up 50 days, 23:38,  1 user,  load average: 0.04, 0.02, 0.01
Tasks: 251 total,   1 running, 250 sleeping,   0 stopped,   0 zombie
Cpu(s):  0.0%us,  0.1%sy,  0.0%ni, 99.9%id,  0.0%wa,  0.0%hi,  0.0%si,  0.0%st
Mem:   8057848k total,  1867800k used,  6190048k free,   339136k buffers
Swap:  1023996k total,   187376k used,   836620k free,  1147816k cached

  PID USER      PR  NI  VIRT  RES  SHR S %CPU %MEM    TIME+  COMMAND
 6504 n0059983  20   0 15172 1356  928 R  0.3  0.0   0:00.01 top
    1 root      20   0 19356  736  508 S  0.0  0.0   0:00.85 init
    2 root      20   0     0    0    0 S  0.0  0.0   0:00.00 kthreadd
    3 root      RT   0     0    0    0 S  0.0  0.0   0:01.48 migration/0
    4 root      20   0     0    0    0 S  0.0  0.0   0:06.45 ksoftirqd/0
    5 root      RT   0     0    0    0 S  0.0  0.0   0:00.00 stopper/0
    6 root      RT   0     0    0    0 S  0.0  0.0   0:01.90 watchdog/0
    7 root      RT   0     0    0    0 S  0.0  0.0   0:11.50 migration/1
    8 root      RT   0     0    0    0 S  0.0  0.0   0:00.00 stopper/1
    9 root      20   0     0    0    0 S  0.0  0.0   0:03.22 ksoftirqd/1
   10 root      RT   0     0    0    0 S  0.0  0.0   0:01.33 watchdog/1
   11 root      RT   0     0    0    0 S  0.0  0.0   0:01.15 migration/2
   12 root      RT   0     0    0    0 S  0.0  0.0   0:00.00 stopper/2
   13 root      20   0     0    0    0 S  0.0  0.0   0:07.30 ksoftirqd/2