#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <stdbool.h>
#include "common.h"

double run_linear_big_o_of_one(int size, bool print)
{
    // scaffolding
    int search_m_out[size];
    int *linear_search_a = create_one_d_matrix(size, search_m_out, false);

    clock_t start = clock();
    int hit = linear_search_a[0];
    clock_t end = clock();

    // Print the Array - If you want!
    if (print == true)
    {
        printArray(linear_search_a, size);
    }

    return time_calc(start, end);
}