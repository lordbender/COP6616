#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <stdbool.h>
#include <mpi.h>
#include "common.h"


long *fetch_array(int size)
{
    // Create the space in memory
    long *helper = malloc(sizeof(long) * size);

    // Pad that bad boy with 0s
    int i = 0;
    for (i = 0; i < size; i++)
    {
        helper[i] = 0;
    }

    return helper;
}


long *create_one_d_matrix(int size)
{
    long *helper = fetch_array(size);

    srand(time(0));

    int i;
    for (i = 0; i < size; i++)
    {
        long num = (rand() %
                    (UPPER - LOWER + 1)) +
                   LOWER;

        helper[i] = num;
    }

    return helper;
}


long get_first_number(long *sub_rand_nums)
{
    return sub_rand_nums[0];
}

void create_report(int size, struct report *r)
{
    FILE *report_file;
    int i = 0;
    report_file = fopen("report.mpi-order-one.txt", "a");

    printf("\nReport of MPI performance for %d as the specified size:\n\n", r[0].size);
    for (i = 0; i < size; i++)
    {
        struct report lr = r[i];
        printf("Algorithm: %s\n", lr.process_name);
        printf("\tBig O          : %s\n", lr.big_o);
        printf("\tExecution Time : %f\n", lr.runtime);
        printf("\tDataset Size   : %d\n", lr.size);
        printf("\tProcess Count  : %d\n", lr.number_of_processess);
        printf("\tTarget Located : %d times\n\n", lr.number_of_processess);

        // Write to the log for later analysis
        fprintf(report_file, "Algorithm: %s\n", lr.process_name);
        fprintf(report_file, "\tBig O          : %s\n", lr.big_o);
        fprintf(report_file, "\tExecution Time : %f\n", lr.runtime);
        fprintf(report_file, "\tDataset Size   : %d\n", lr.size);
        fprintf(report_file, "\tProcess Count  : %d\n\n\n", lr.number_of_processess);
        fprintf(report_file, "\tTarget Located : %d times\n\n", lr.number_of_processess);
    }

    fprintf(report_file, "\n----------------------------------------------------\n");
    printf("\n\nAlso see report generated in report.mpi-order-one.txt, append strategy.\n\n");

    fclose(report_file);
}