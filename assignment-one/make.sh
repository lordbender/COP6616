clear

PROCS=32
SIZE=50000

echo Running Linear All
pushd base-program
chmod 777 run.sh
./run.sh $SIZE 
cp report.linear.txt ../report.linear.txt
popd

echo Running MPI Bubble
pushd mpi-program-bubble
chmod 777 run.sh
./run.sh $PROCS $SIZE
popd

echo Running MPI Matrix
pushd mpi-program-matrix
chmod 777 run.sh
./run.sh
cp report.mpi-matrix.txt ../report.mpi-matrix.txt
popd
