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

    float *rand_nums;

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

    printf("elements_per_proc = %d\n\n", elements_per_proc);

    //Define process 0 behavior
    if (my_process_id == 0)
    {
        printf("Size => %d, created by %d\n", size, my_process_id);
        printf("number_of_processess ==  %d\n", number_of_processess);

        rand_nums = create_one_d_matrix(size, false);
        printArray(rand_nums, size);
    }

    // Create a buffer that will hold a subset of the random numbers
    float *sub_rand_nums = fetch_array(elements_per_proc);

    // Scatter the random numbers to all processes
    MPI_Scatter(rand_nums, elements_per_proc, MPI_FLOAT, sub_rand_nums,
                elements_per_proc, MPI_FLOAT, 0, MPI_COMM_WORLD);

    // Compute the average of your subset
    float sub_avg = compute_avg(sub_rand_nums, elements_per_proc, my_process_id);

    // Gather all partial averages down to the root process
    float *sub_avgs = NULL;
    if (my_process_id == 0)
    {
        sub_avgs = fetch_array(size);
    }

    MPI_Gather(&sub_avg, 1, MPI_FLOAT, sub_avgs, 1, MPI_FLOAT, 0,
               MPI_COMM_WORLD);

    // // Compute the total average of all numbers.
    if (my_process_id == 0)
    {
        float avg = compute_avg(sub_avgs, size, my_process_id);
        printf("Entire Array Average: %f\n\n", avg);
    }

    // free(rand_nums);
    // free(sub_rand_nums);
    // free(sub_avgs);
    MPI_Finalize();
    return 0;
}

float compute_avg(float *sub_rand_nums, int elements_per_proc, int my_process_id)
{
    if (my_process_id == 1)
    {
        printArray(sub_rand_nums, elements_per_proc);
    }
    int i = 0;
    float sum_of_local_set = 0.0;
    for (i = 0; i < elements_per_proc; i++)
    {
        //  printf("Echo TEST => %f\n", sub_rand_nums[i]);
        sum_of_local_set += sub_rand_nums[i];
    }
    // printf("Average for process #%d: %f\n", my_process_id, result);

    return sum_of_local_set / elements_per_proc;
}
