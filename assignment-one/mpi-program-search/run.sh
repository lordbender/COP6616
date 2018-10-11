rm *.out
mpicc *.c
mpirun -np 64 a.out 50000000

