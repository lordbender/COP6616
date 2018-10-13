
# Assignment Discussion Requirements
	- You should include a discussion of the improved efficiency
	- Comment on the relative speed up of your implementation. 
	- Run your application on uranus and atlas, 
		- Be sure you monitor the machine load when collecting your data. 

# Linear Program Overview

# MPI Program Overview

# Description of Experiments

# Analysis of Speed-Up

# Analysis of Efficiency

# Outcomes and Observations

# Machine Load at Time of Testing

## CISAtlas

### Uptime

uptime
 15:49:42 up 395 days,  5:26,  1 user,  load average: 0.00, 0.09, 0.25

cat /proc/loadavg
0.00 0.04 0.19 6/1758 59750

top

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
36436 n0087198  20   0  134m 2972 2140 S  4.6  0.0 283:30.21 master
36341 n0087198  20   0  134m 2980 2140 S  3.9  0.0 283:04.61 master
36177 n0087198  20   0  134m 2972 2136 S  3.0  0.0 282:41.71 master
36217 n0087198  20   0  134m 2976 2140 S  3.0  0.0 282:28.15 master
36245 n0087198  20   0  134m 2976 2140 S  2.6  0.0 282:34.50 master
36433 n0087198  20   0  134m 2972 2140 S  2.6  0.0 283:05.88 master
36464 n0087198  20   0  134m 2976 2140 S  2.6  0.0 281:41.10 master
36166 n0087198  20   0  134m 2968 2140 S  2.3  0.0 282:04.72 master
36180 n0087198  20   0  134m 2976 2140 S  2.3  0.0 283:44.81 master
36242 n0087198  20   0  134m 2976 2140 S  2.3  0.0 283:22.61 master
36287 n0087198  20   0  134m 2976 2140 S  2.3  0.0 284:20.64 master
36334 n0087198  20   0  134m 2972 2140 S  2.3  0.0 282:40.97 master
36396 n0087198  20   0  134m 2976 2140 S  2.3  0.0 282:17.96 master
36416 n0087198  20   0  134m 2972 2140 S  2.3  0.0 284:43.50 master
36422 n0087198  20   0  134m 2980 2140 S  2.3  0.0 281:31.09 master
36484 n0087198  20   0  134m 2980 2140 S  2.3  0.0 283:37.62 master
36091 n0087198  20   0  134m 2972 2140 S  2.0  0.0 282:33.27 master
36106 n0087198  20   0  134m 2968 2140 S  2.0  0.0 283:07.60 master
36112 n0087198  20   0  134m 2976 2140 S  2.0  0.0 283:53.69 master
36116 n0087198  20   0  134m 2976 2140 S  2.0  0.0 283:41.78 master
36168 n0087198  20   0  134m 2976 2140 S  2.0  0.0 281:10.48 master
36173 n0087198  20   0  134m 2972 2140 S  2.0  0.0 283:54.39 master
36268 n0087198  20   0  134m 2972 2140 S  2.0  0.0 282:24.89 master
36272 n0087198  20   0  134m 2976 2140 S  2.0  0.0 281:58.64 master
36354 n0087198  20   0  134m 2976 2140 S  2.0  0.0 282:17.77 master
36356 n0087198  20   0  134m 2980 2140 S  2.0  0.0 281:50.20 master
36364 n0087198  20   0  134m 2980 2140 S  2.0  0.0 283:55.53 master
36379 n0087198  20   0  134m 2972 2140 S  2.0  0.0 282:46.48 master
36392 n0087198  20   0  134m 2972 2140 S  2.0  0.0 281:06.99 master
36410 n0087198  20   0  134m 2972 2140 S  2.0  0.0 281:43.36 master
36442 n0087198  20   0  134m 2976 2140 S  2.0  0.0 282:43.12 master            

## Uranus

