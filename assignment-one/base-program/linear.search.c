#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <stdbool.h>
#include "common.h"

// This linear search will continue, and find all posible hits
// We could break after the first hit, and see if that changes the
// overall performance.
int liner_search(int size, long *arr, long target)
{
    int i = 0;
    int hits = 0;
    for (i = 0; i < size; i++)
    {
        int current = arr[i];
        if (current == target)
            hits++;
    }

    return hits;
}

double run_linear_search(int size)
{
    // scaffolding
    long *linear_search_a = create_one_d_matrix(size);
    long target = rand();

    clock_t start = clock();
    int hits = liner_search(size, linear_search_a, target);
    clock_t end = clock();

    return time_calc(start, end);
}
