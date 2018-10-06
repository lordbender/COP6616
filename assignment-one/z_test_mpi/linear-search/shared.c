#include <stdio.h>
#include <stdlib.h>

int *genRandom(int count)
{
    int *ret = malloc(count);
    if (!ret)
        return NULL;

    for (int i = 0; i < count; ++i)
        ret[i] = i;

    return ret;
}

void printArray(int arr[], int size)
{
    int i;
    for (i = 0; i < size; i++)
        printf("\t%d\n ", arr[i]);
    printf("n");
}