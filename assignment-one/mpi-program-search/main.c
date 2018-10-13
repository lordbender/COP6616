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
    long *rand_nums = NULL;
    long *sub_rand_nums = NULL;
    double start_time, end_time;

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
        printf("Searching for:          %ld\n\n", target);
        start_time = MPI_Wtime();
    }

    // Create a buffer that will hold a subset of the random numbers
    sub_rand_nums = fetch_array(elements_per_proc);

    // Scatter the random numbers to all processes
    MPI_Scatter(rand_nums, elements_per_proc, MPI_LONG, sub_rand_nums,
                elements_per_proc, MPI_LONG, 0, MPI_COMM_WORLD);

    // search for hits in the subsets.
    long hits = search(sub_rand_nums, elements_per_proc, target);

    // Create space for the partial averages on the root process.
    long *sub_avgs = NULL;
    if (my_process_id == 0)
    {
        sub_avgs = fetch_array(size);
    }

    MPI_Gather(&hits, 1, MPI_LONG, sub_avgs, 1, MPI_LONG, 0, MPI_COMM_WORLD);

    // Wrap up by averaging the averages. :)
    if (my_process_id == 0)
    {
        end_time = MPI_Wtime();
        long total_hits = 0;
        int i = 0;
        for (i = 0; i < elements_per_proc; i++)
        {
            // printf("sub_avgs[%d] == %ld\n", i, sub_avgs[i]);
            total_hits += (long)sub_avgs[i];
        }

        // Create the space the for the reports to get written to the output file! Bam!
        struct report *output_data = malloc(1 * sizeof(struct report));

        //Create the report
        double runtime = end_time - start_time;
        struct report mpi_liner_search_report;
        mpi_liner_search_report.size = size;
        mpi_liner_search_report.number_of_processess = number_of_processess;
        mpi_liner_search_report.runtime = runtime;
        mpi_liner_search_report.process_name = "MPI Linear Search";
        mpi_liner_search_report.big_o = "O(n)";
        mpi_liner_search_report.total_hits = total_hits;
        output_data[0] = mpi_liner_search_report;
        create_report(1, output_data);
    }

    // Close out MPI and free up resources.
    MPI_Finalize();
    return 0;
}
