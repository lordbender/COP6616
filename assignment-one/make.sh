pushd base-program
chmod 777 run.sh
./run.sh
popd

pushd mpi-program-bubble
chmod 777 run.sh
./run.sh
popd

pushd mpi-program-matrix
chmod 777 run.sh
./run.sh
popd