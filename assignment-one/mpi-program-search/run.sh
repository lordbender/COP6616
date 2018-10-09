rm *.out
mpicc *.c
mpirun -np=8 ./a.out 50000000
