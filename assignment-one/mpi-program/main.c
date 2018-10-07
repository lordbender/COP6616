#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <stdbool.h>
#include <math.h>
#include <mpi.h>
#include "common.h"

int main(int argc, char *argv[])
{
    int p, id;

    float *test_array;

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

    // TODO: this needs some more thought, but good enough to move on.
    int elements_per_proc = size < p ? 1 : (int)((size / p) - 1);
    
    //Define process 0 behavior
    if (id == 0)
    {
        printf("Size => %d, created by %d\n", size, id);
        printf("P ==  %d\n", p);

        float m_out[size];
        test_array = create_one_d_matrix(size, m_out, true);
        printArray(test_array, size);
    }

    // Create a buffer that will hold a subset of the random numbers
    float *sub_rand_nums = malloc(sizeof(float) * elements_per_proc);

    printf("Echo ID => %d\n", id);

    MPI_Finalize();
    return 0;
}
