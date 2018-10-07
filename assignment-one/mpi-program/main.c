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
    int target = 0;
    float *rand_nums = NULL;
    float *sub_rand_nums = NULL;
    int hits = 0;

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

    // TODO: this needs some more thought, but good enough to move on.
    int elements_per_proc = size < number_of_processess ? 1 : (int)((size / number_of_processess) + 1);

    //Define process 0 behavior
    if (my_process_id == 0)
    {
        rand_nums = create_one_d_matrix(size, false);
        target = get_random_target();

        printf("Random Numbers Created: %d\n", size);
        printf("Number of Processes:    %d\n", number_of_processess);
        printf("Elements Per Process:   %d\n\n", elements_per_proc);
        printf("Searching for:          %d\n\n", target);
    }

    // Create a buffer that will hold a subset of the random numbers
    sub_rand_nums = fetch_array(elements_per_proc);

    // Scatter the random numbers to all processes
    MPI_Scatter(rand_nums, elements_per_proc, MPI_FLOAT, sub_rand_nums,
                elements_per_proc, MPI_FLOAT, 0, MPI_COMM_WORLD);
    if (my_process_id != 0)
    {
        // search for hits in the subsets.
        hits = search(sub_rand_nums, elements_per_proc, target);

        printf("pid: %d had %d positives.\n\n", my_process_id, hits);
    }

    // Create space for the partial averages on the root process.
    int *sub_avgs = NULL;
    if (my_process_id == 0)
    {
        sub_avgs = fetch_array_int(size);
    }

    // Gather up the averages from the sub processess.
    MPI_Gather(&hits, 1, MPI_FLOAT, sub_avgs, 1, MPI_FLOAT, 0, MPI_COMM_WORLD);

    // Wrap up by averaging the averages. :)
    if (my_process_id == 0)
    {
        int total_hits, i = 0;
        for (i = 0; i < elements_per_proc; i++)
        {
            total_hits += sub_avgs[i];
        }

        printf("Target was located %d times.\n\n", total_hits);
    }

    // Close out MPI and free up resources.
    MPI_Finalize();
    return 0;
}
