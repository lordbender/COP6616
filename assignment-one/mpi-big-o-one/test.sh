rm *.out
mpicc *.c
echo mpirun -np 64 a.out 50000000
mpirun -np 64 a.out 50000000
rm ../report.mpi-order-one.txt | true
cp report.mpi-order-one.txt ../report.mpi-order-one.txt
