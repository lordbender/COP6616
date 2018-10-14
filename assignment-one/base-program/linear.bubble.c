#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <stdbool.h>
#include "common.h"

long *bubbleSort(long *numbers, int count);
void swap(long *xp, long *yp);

void swap(long *xp, long *yp)
{
    int temp = *xp;
    *xp = *yp;
    *yp = temp;
}

// A function to implement bubble sort
long *bubbleSort(long *numbers, int count)
{
    int i, j, c;

    for (i = 0; i < count - 1; i++)
    {
        for (j = 0; j < count - 1 - 1; j++)
        {
            if (numbers[j] > numbers[j + 1])
            {
                c = numbers[j];
                numbers[j] = numbers[j + 1];
                numbers[j + 1] = c;
            }
        }
    }

    return numbers;
}

double run_linear_bubble(int size)
{
    long *bubble_sort_a = create_one_d_matrix(size);

    clock_t start = clock();
    long *r = bubbleSort(bubble_sort_a, size);
    clock_t end = clock();

    return time_calc(start, end);
}