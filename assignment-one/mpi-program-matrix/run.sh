mpicc *.c
echo mpirun -np 64 ./a.out 550
mpirun -np 64 ./a.out 550
