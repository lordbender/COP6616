mpicc *.c
echo mpirun -np=$1 ./a.out $2
mpirun -np=$1 ./a.out $2
