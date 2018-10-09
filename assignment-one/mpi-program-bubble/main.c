#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <stdbool.h>
#include <math.h>
#include <mpi.h>
#include "common.h"

int main(int argc, char *argv[])
{
    int number_of_processess;
    int my_process_id;

    long *rand_nums = NULL;
    long *sub_rand_nums = NULL;

    double t1, t2;

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

        printf("Random Numbers Created: %d\n", size);
        printf("Number of Processes:    %d\n", number_of_processess);
        printf("Elements Per Process:   %d\n\n", elements_per_proc);
    }

    int size_helper = size * size / number_of_processess;
    sub_rand_nums = fetch_array(elements_per_proc);

    t1 = MPI_Wtime();

    MPI_Scatter(rand_nums, elements_per_proc, MPI_LONG, sub_rand_nums,
                elements_per_proc, MPI_LONG, 0, MPI_COMM_WORLD);

    MPI_Barrier(MPI_COMM_WORLD);

    // Perform sort on the smaller bits
    long *sorted_subset = bubbleSort(sub_rand_nums, elements_per_proc);

    if (my_process_id == 2)
        print_array(sub_rand_nums, elements_per_proc);

    // Create space for the partial averages on the root process.
    long **sub_avgs = NULL;
    if (my_process_id == 0)
    {
        sub_avgs = (long **)malloc(size * sizeof(long *));
    }

    MPI_Gather(&sorted_subset, 1, MPI_LONG, sub_avgs, 1, MPI_LONG, 0, MPI_COMM_WORLD);

    t2 = MPI_Wtime();

    // Wrap up by averaging the averages. :)
    if (my_process_id == 0)
    {
        double time_to_run = ((double)(t2 - t1)) / CLOCKS_PER_SEC;
        printf("Elapsed time is %f\n", time_to_run);
    }

    // Close out MPI and free up resources.
    MPI_Finalize();
    return 0;
}

void swap(long *xp, long *yp)
{
    long temp = *xp;
    *xp = *yp;
    *yp = temp;
}

long *bubbleSort(long numbers[], int count)
{
    int i = 0;
    int j = 0;
    int c = 0;

    for (i = 0; i < count - 1; i++)
    {
        for (j = 0; j < count - 1 - 1; j++)
        {
            if (numbers[j] > numbers[j + 1])
            {
                c = numbers[j];
                numbers[j] = numbers[j + 1];
                numbers[j + 1] = c;
            }
        }
    }

    return numbers;
}