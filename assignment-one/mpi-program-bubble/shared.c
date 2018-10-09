#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <stdbool.h>
#include "common.h"


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