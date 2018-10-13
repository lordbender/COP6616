rm *.out
mpicc *.c
mpirun -np 64 -hostfile hosts a.out 50000000

