#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <stdbool.h>
#include "common.h"
#include <mpi.h>

void printArray(float arr[], int size)
{
    int i;
    for (i = 0; i < size - 1; i++)
        printf("\t%f\n ", arr[i]);
}

double time_calc(clock_t start, clock_t end)
{
    return ((double)(end - start)) / CLOCKS_PER_SEC;
}

float *create_one_d_matrix(int size, bool printOutput)
{
    float *helper = fetch_array(size);
    srand(time(0));

    if (printOutput == true)
    {
        printf("Creating an array of size  %d \n", size);
    }

    int i;
    for (i = 0; i < size; i++)
    {
        // To avoid overflows, use casted ints, instead of random floats.
        float num = (float)rand();
        helper[i] = num;
    }

    if (printOutput == true)
    {
        printf("Created an array of size  %d \n", size);
    }

    return helper;
}

float *fetch_array(int size)
{
    // Create the space in memory
    float *helper = malloc(sizeof(float) * size);

    // Pad that bad boy with 0s
    int i = 0;
    for (i = 0; i < size; i++)
    {
        helper[i] = 0;
    }

    return helper;
}

float compute_avg(float *sub_rand_nums, int elements_per_proc, int my_process_id, bool print)
{
    if (my_process_id == 1 && print == true)
    {
        printArray(sub_rand_nums, elements_per_proc);
    }
    int i = 0;
    float sum_of_local_set = 0.0;
    for (i = 0; i < elements_per_proc; i++)
    {
        sum_of_local_set += sub_rand_nums[i];
    }

    return sum_of_local_set / elements_per_proc;
}