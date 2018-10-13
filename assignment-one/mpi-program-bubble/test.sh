mpicc *.c
echo mpirun -np 64 ./a.out 150000
mpirun -np 64 ./a.out 150000
rm ../report.mpi-bubble.txt | true
cp report.mpi-bubble.txt ../report.mpi-bubble.txt