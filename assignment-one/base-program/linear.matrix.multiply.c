#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <stdbool.h>
#include "common.h"

void multiply(int size, long **mat1, long **mat2, long **res)
{
    int i = 0, j = 0, k = 0;
    for (i = 0; i < size; i++)
    {
        for (j = 0; j < size; j++)
        {
            res[i][j] = 0;
            for (k = 0; k < size; k++)
                res[i][j] += mat1[i][k] * mat2[k][j];
        }
    }
}

double run_linear_matrix_multiply(int size)
{
    int i = 0;
    int j = 0;
    int count = 0;
    // Define the Arrays
    long **left_a = (long **)malloc(size * sizeof(long *));
    long **right_a = (long **)malloc(size * sizeof(long *));
    long **result_a = (long **)malloc(size * sizeof(long *));
    for (i = 0; i < size; i++)
    {
        left_a[i] = (long *)malloc(size * sizeof(long));
        right_a[i] = (long *)malloc(size * sizeof(long));
        result_a[i] = (long *)malloc(size * sizeof(long));
    }

    // Fill the Arrays
    for (i = 0; i < size; i++)
    {
        for (j = 0; j < size; j++)
        {
            left_a[i][j] = ++count + 50;
            right_a[i][j] = ++count - 50;

            // Just Zero out the result array for now!
            result_a[i][j] = 0;
        }
    }

    clock_t start = clock();
    multiply(size, left_a, right_a, result_a);
    clock_t end = clock();

    return time_calc(start, end);
}
