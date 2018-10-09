#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <stdbool.h>
#include "common.h"

void print_2D(int size, long **arr)
{
    int i, j;
    for (i = 0; i < size; i++)
        for (j = 0; j < size; j++)
            printf("\t%ld", arr[i][j]);
    printf("\n", arr[i][j]);
}

void print_array(long arr[], int size)
{
    int i;
    for (i = 0; i < size - 1; i++)
        printf("\t%ld\n ", arr[i]);
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