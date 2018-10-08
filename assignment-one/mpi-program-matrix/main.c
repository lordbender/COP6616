#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <stdbool.h>
#include <math.h>
#include <mpi.h>
#include "common.h"

int main(int argc, char *argv[])
{
    int number_of_processess, my_process_id;
    const long target = 9;
    long *sub_rand_nums = NULL;

    // MPI Stuff
    if (argc != 2)
    {
        fprintf(stderr, "Usage: mpirun -np <num_procs> %s <random_array_size>\n", argv[0]);
        printf("You did not feed me arguments, I will die now :( ...\n");
        exit(1);
    }

    MPI_Init(&argc, &argv);
    MPI_Comm_size(MPI_COMM_WORLD, &number_of_processess);
    MPI_Comm_rank(MPI_COMM_WORLD, &my_process_id);

    // Grab the Requested Size from the Command Line Arguments.
    int size = atoi(argv[1]);
    long rand_array_a[size][size] = NULL;
    long rand_array_b[size][size] = NULL;
    long result_array_c[size][size] = NULL;

    // TODO: this needs some more thought, but good enough to move on.
    int elements_per_proc = size < number_of_processess ? 1 : (int)((size / number_of_processess) + 1);

    //Define process 0 behavior
    if (my_process_id == 0)
    {

        // Fill the Arrays
        create_two_d_array(size, size, rand_array_a);
        create_two_d_array(size, size, rand_array_b);
        // target = get_random_target();

        printf("Random Numbers Created: %d\n", size);
        printf("Number of Processes:    %d\n", number_of_processess);
        printf("Elements Per Process:   %d\n\n", elements_per_proc);
    }

    // Scatter the random numbers to all processes
    // MPI_Scatter(rand_nums, elements_per_proc, MPI_LONG, sub_rand_nums,
    //             elements_per_proc, MPI_LONG, 0, MPI_COMM_WORLD);

    // Gather up the averages from the sub processess.
    // MPI_Gather(&hits, 1, MPI_LONG, sub_avgs, 1, MPI_LONG, 0, MPI_COMM_WORLD);

    // Wrap up by averaging the averages. :)
    if (my_process_id == 0)
    {
        print_two_d_array(size, size, rand_array_a);
        print_two_d_array(size, size, rand_array_b);

        printf("Wrap up the Results.\n\n");
    }

    // Close out MPI and free up resources.
    MPI_Finalize();
    return 0;
}
