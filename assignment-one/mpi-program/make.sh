pwd

cd bubble
mpicc *.c -o bubble.out
mv bubble.out ../
cd ../


# build matrix.c
mpicc matrix.c -o matrix.out


## Run Everything ##
mpirun -np=$1 ./bubble.out $2
mpirun -np=$1 ./matrix.out $2

