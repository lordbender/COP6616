#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <stdbool.h>
#include "common.h"

void print_two_d_array(int r, int c, long arr[r][c])
{
    int i, j;
    for (i = 0; i <= r - 1; i++)
    {
        {
            for (j = 0; j <= c - 1; j++)
                printf("\t%ld", arr[i][j]);
        }
        printf("\n");
    }
}

double randfrom(double min, double max)
{
    double range = (max - min);
    double div = RAND_MAX / range;
    return min + (rand() / div);
}

void create_two_d_array(int r, int c, long m_out[r][c])
{
    srand(time(0));

    int i, j = 0;
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