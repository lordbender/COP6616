#include <stdio.h>
#include <stdlib.h>
#include <time.h>

void printArray(int arr[], int size)
{
    int i;
    for (i = 0; i < size - 1; i++)
        printf("\t%d\n ", arr[i]);
    printf("n");
}

double time_calc(clock_t start, clock_t end)
{
    return ((double)(end - start)) / CLOCKS_PER_SEC;
}