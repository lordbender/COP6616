#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <stdbool.h>
#include "common.h"

void multiply(int size, double mat1[][size], double mat2[][size], double res[][size])
{
    int i, j, k;
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

double run_linear_matrix_multiply(int size, bool print)
{
    // Define the Arrays
    double left_a[size][size];
    double right_a[size][size];
    double result_a[size][size];

    // Fill the Arrays
    create_two_d_array(size, size, left_a);
    create_two_d_array(size, size, right_a);

    clock_t start = clock();
    multiply(size, left_a, right_a, result_a);
    clock_t end = clock();

    // Print the Array - If you want!
    if (print == true)
    {
        print_two_d_array(size, size, result_a);
    }

    return time_calc(start, end);
}