clear

PROCS=32
SIZE=50000

echo Running Linear All
pushd base-program
chmod 777 test.sh
./test.sh
popd

echo Running MPI Search
pushd mpi-program-search
chmod 777 test.sh
./test.sh
popd

echo Running MPI Bubble
pushd mpi-program-bubble
chmod 777 test.sh
./test.sh
popd

echo Running MPI Matrix
pushd mpi-program-matrix
chmod 777 test.sh
./test.sh
popd
