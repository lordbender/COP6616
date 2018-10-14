#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <stdbool.h>
#include "common.h"

double run_linear_big_o_of_one(int size)
{
    // scaffolding
    long *linear_search_a = create_one_d_matrix(size);

    clock_t start = clock();
    long hit = linear_search_a[0];
    clock_t end = clock();

    return time_calc(start, end);
}