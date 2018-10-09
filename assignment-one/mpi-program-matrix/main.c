#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <stdbool.h>
#include <math.h>
#include <mpi.h>
#include "common.h"

int main(int argc, char *argv[])
{
    int i = 0;
    int j = 0;
    int count = 0;
    int number_of_processess;
    int my_process_id;
    double t1 = 0.0, t2 = 0.0;

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
    // Define the Arrays
    long **a = (long **)malloc(size * sizeof(long *));
    long **b = (long **)malloc(size * sizeof(long *));
    long **c = (long **)malloc(size * sizeof(long *));

    long *aa = (long *)malloc(size * sizeof(long));
    long *cc = (long *)malloc(size * sizeof(long));

    for (i = 0; i < size; i++)
    {
        a[i] = (long *)malloc(size * sizeof(long));
        b[i] = (long *)malloc(size * sizeof(long));
        c[i] = (long *)malloc(size * sizeof(long));
    }

    // TODO: this needs some more thought, but good enough to move on.
    int elements_per_proc = size < number_of_processess ? 1 : (int)((size / number_of_processess) + 1);

    //Define process 0 behavior
    if (my_process_id == 0)
    {
        for (i = 0; i < size; i++)
        {
            a[i] = (long *)malloc(size * sizeof(long));
            b[i] = (long *)malloc(size * sizeof(long));
            c[i] = (long *)malloc(size * sizeof(long));
        }

        // Fill the Arrays
        for (i = 0; i < size; i++)
        {
            aa[i] = 0;
            aa[i] = 0;
            for (j = 0; j < size; j++)
            {
                a[i][j] = ++count + 50;
                b[i][j] = ++count - 50;

                // Just Zero out the result array for now!
                c[i][j] = 0;
            }
        }

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
