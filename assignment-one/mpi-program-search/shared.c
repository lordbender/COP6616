#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <stdbool.h>
#include "common.h"
#include <mpi.h>

void printArray(long arr[], int size)
{
    int i;
    for (i = 0; i < size - 1; i++)
        printf("\t%ld\n ", arr[i]);
}

double time_calc(clock_t start, clock_t end)
{
    return ((double)(end - start)) / CLOCKS_PER_SEC;
}

long *create_one_d_matrix(int size, bool printOutput)
{
    long *helper = fetch_array(size);

    srand(time(0));

    if (printOutput == true)
    {
        printf("Creating an array of size  %d \n", size);
    }

    int i;
    for (i = 0; i < size; i++)
    {
        long num = (rand() %
                    (UPPER - LOWER + 1)) +
                   LOWER;

        helper[i] = num;
    }

    if (printOutput == true)
    {
        printf("Created an array of size  %d \n", size);
    }

    return helper;
}

long get_random_target()
{
    srand(time(0));
    long num = (rand() % (UPPER - LOWER + 1)) + LOWER;

    return (long)num;
}

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

long search(long *sub_rand_nums, int elements_per_proc, long target)
{
    long hits = 0;
    int i = 0;

    for (i = 0; i < elements_per_proc; i++)
    {
        // printf("%f == %f\n", sub_rand_nums[i], target);
        if (sub_rand_nums[i] == target)
        {
            // printf("hit: %ld == %ld\n", sub_rand_nums[i], target);
            hits++;
        }
    }
    // printf("hits == %ld\n", hits);
    return hits;
}

void create_report(int size, struct report *r)
{
    FILE *report_file;
    int i = 0;
    report_file = fopen("report.mpi-search.txt", "a");

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
    printf("\n\nAlso see report generated in report.mpi-search.txt, append strategy.\n\n");

    fclose(report_file);
}