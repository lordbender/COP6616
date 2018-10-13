mpicc *.c
echo mpirun -np 32 a.out 550
mpirun -np 32 a.out 550
rm ../report.mpi-matrix.txt | true
cp report.mpi-matrix.txt ../report.mpi-matrix.txt
