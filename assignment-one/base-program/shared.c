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

int *create_one_d_matrix(int size, int *m_out, bool printOutput)
{
    srand(time(0));

    if (printOutput == true)
    {
        printf("Creating an array of size  %d \n", size);
    }

    int i;
    for (i = 0; i < size; i++)
    {
        int num = rand();
        m_out[i] = num;
    }

    if (printOutput == true)
    {
        printf("Created an array of size  %d \n", size);
    }

    return m_out;
}

long randfrom(long min, long max)
{
    double range = ((double)max - (double)min);
    double div = RAND_MAX / range;
    return (long)(min + (rand() / div));
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
            m_out[i][j] = randfrom(-10000, 10000);
        }
    }
}

void create_report(int size, struct report *r)
{
    FILE *pFile;
    int i = 0;

    printf("\n\n\nReport of Linear performance for %d as the specified size:\n\n", r[0].size);
    for (i = 0; i < size; i++)
    {
        struct report lr = r[i];
        printf("\t\t%s, of magnitude %s, ran in: %f seconds against %d size!\n", lr.process_name, lr.big_o, lr.runtime, lr.size);
    }
}