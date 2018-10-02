#include <stdio.h>
#include <stdlib.h>

void printArray(int arr[], int size)
{
    int i;
    for (i = 0; i < size; i++)
        printf("\t%d\n ", arr[i]);
    printf("n");
}