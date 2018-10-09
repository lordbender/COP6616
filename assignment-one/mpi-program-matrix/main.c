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
    long a[size][size];
    long b[size][size];
    long c[size][size];
    long aa[size], cc[size];

    // TODO: this needs some more thought, but good enough to move on.
    int elements_per_proc = size < number_of_processess ? 1 : (int)((size / number_of_processess) + 1);

    //Define process 0 behavior
    if (my_process_id == 0)
    {
        // Fill the Arrays
        create_two_d_array(size, size, a);
        create_two_d_array(size, size, b);
        // target = get_random_target();

        printf("Random Numbers Created: %d\n", size);
        printf("Number of Processes:    %d\n", number_of_processess);
        printf("Elements Per Process:   %d\n\n", elements_per_proc);
    }

    int size_helper = size * size / number_of_processess;

    t1 = MPI_Wtime();
    //scatter rows of first matrix to different processes
    MPI_Scatter(a, size_helper, MPI_LONG, aa, size_helper, MPI_LONG, 0, MPI_COMM_WORLD);

    //broadcast second matrix to all processes
    MPI_Bcast(b, size * size, MPI_LONG, 0, MPI_COMM_WORLD);

    MPI_Barrier(MPI_COMM_WORLD);
    //perform vector multiplication by all processes
    int i = 0;
    int j = 0;
    for (i = 0; i < size; i++)
    {
        int sum = 0;
        for (j = 0; j < size; j++)
        {
            sum = sum + aa[j] * b[j][i];
        }
        cc[i] = sum;
    }
    MPI_Gather(cc, size_helper, MPI_LONG, c, size_helper, MPI_LONG, 0, MPI_COMM_WORLD);

    t2 = MPI_Wtime();
    MPI_Barrier(MPI_COMM_WORLD);

    // Wrap up by averaging the averages. :)
    if (my_process_id == 0)
    {
        // print_two_d_array(size, size, c);
        double time_to_run = ((double)(t2 - t1)) / CLOCKS_PER_SEC;
        printf("Elapsed time is %f\n", time_to_run);
    }

    // Close out MPI and free up resources.
    MPI_Finalize();
    return 0;
}
