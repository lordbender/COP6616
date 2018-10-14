#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <stdbool.h>
#include "common.h"

void printArray(int arr[], int size)
{
    int i = 0;
    for (i = 0; i < size - 1; i++)
        printf("\t%d\n ", arr[i]);
}

void print_two_d_array(int r, int c, long arr[r][c])
{
    int i = 0;
    int j = 0;
    for (i = 0; i <= r - 1; i++)
    {
        {
            for (j = 0; j <= c - 1; j++)
                printf("\t%ld", arr[i][j]);
        }
        printf("\n");
    }
}

double time_calc(clock_t start, clock_t end)
{
    return ((double)(end - start)) / CLOCKS_PER_SEC;
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

void create_two_d_array(int r, int c, long m_out[r][c])
{
    srand(time(0));

    int i = 0;
    int j = 0;
    for (i = 0; i < r; i++)
    {
        for (j = 0; j < c; j++)
        {
            long num = (rand() %
                        (UPPER - LOWER + 1)) +
                       LOWER;

            m_out[i][j] = num;
        }
    }
}

void create_report(int size, struct report *r)
{
    FILE *report_file;
    int i = 0;
    report_file = fopen("report.linear.txt", "a");

    printf("\nReport of Linear performance for %d as the specified size:\n\n", r[0].size);
    for (i = 0; i < size; i++)
    {
        struct report lr = r[i];
        printf("Algorithm: %s\n", lr.process_name);
        printf("\tBig O          : %s\n", lr.big_o);
        printf("\tExecution Time : %f\n", lr.runtime);
        printf("\tDataset Size   : %d\n\n\n", lr.size);

        // Write to the log for later analysis
        fprintf(report_file, "Algorithm: %s\n", lr.process_name);
        fprintf(report_file, "\tBig O          : %s\n", lr.big_o);
        fprintf(report_file, "\tExecution Time : %f\n", lr.runtime);
        fprintf(report_file, "\tDataset Size   : %d\n\n\n", lr.size);
    }

    fprintf(report_file, "\n----------------------------------------------------\n");
    printf("\n\nAlso see report generated in report.linear.txt, append strategy.\n\n");

    fclose(report_file);
}