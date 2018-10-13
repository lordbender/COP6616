rm *.out
mpicc *.c
mpirun -np 64 ./a.out 50000000
rm ../report.mpi-search.txt | true
cp report.mpi-search.txt ../report.mpi-search.txt