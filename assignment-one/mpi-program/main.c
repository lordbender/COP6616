#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <stdbool.h>
#include <mpi.h>

int main(int argc, char *argv[])
{
    int p, id;

    // MPI Stuff
    if (argc != 2)
    {
        fprintf(stderr, "Usage: mpirun -np <num_procs> %s <random_array_size>\n", argv[0]);
        printf("You did not feed me arguments, I will die now :( ...\n");
        exit(1);
    }

    MPI_Init(&argc, &argv);
    MPI_Comm_size(MPI_COMM_WORLD, &p);
    MPI_Comm_rank(MPI_COMM_WORLD, &id);

    // Grab the Requested Size from the Command Line Arguments.
    int size = atoi(argv[1]);

    //Define process 0 behavior
    if (id == 0)
    {
        printf("Size => %d, created by %d\n", size, id);
    }

    printf("Echo ID => %d\n", id);

    MPI_Finalize();
    return 0;
}
