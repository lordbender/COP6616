# Load at test time

    There were no other users on the server(s) at the time of my testing.

## Top Output

> top - 18:26:25 up 407 days,  8:03,  1 user,  load average: 0.41, 0.97, 0.60
> Tasks: 1399 total,  16 running, 1378 sleeping,   5 stopped,   0 zombie
> Cpu(s):  0.6%us,  3.4%sy,  0.0%ni, 96.0%id,  0.0%wa,  0.0%hi,  0.0%si,  0.0%st
> Mem:  132281152k total,  4708276k used, 127572876k free,   324608k buffers
> Swap:  4194300k total,        0k used,  4194300k free,  1477968k cached
> 
>   PID USER      PR  NI  VIRT  RES  SHR S %CPU %MEM    TIME+  COMMAND
> 36130 n0087198  20   0  134m 2968 2140 S  6.6  0.0 596:40.25 master
> 36203 n0087198  20   0  134m 2972 2140 S  5.6  0.0 598:34.72 master

# Linear vs RMI with Futures 
See [Linear Report](./report.seq.md) for details on sequential Executions.
See [RMI/Futures Report](./report.rmi.md) for details on distributed Executions.

## Complexity O(1)
S = S(s) / S(p) = 6.18E-7 / 9.33146E-4 = 0.00066

#No Speedup#

## Complexity O(n)
S = S(s) / S(p) = 2.696181591 / 16.200298623000002 = 0.1664

#No Speedup#

## Complexity O(n^2)
S = S(s) / S(p) = 32.485004863 / 0.062451097 = 520.167

Fantastic speedup achieved by pre-sorting chunks, then  merging those chunks into a sorted array.

## Complexity O(n^3)
S = S(s) / S(p) = 82.002710229 / 82.996110144 = 0.988
