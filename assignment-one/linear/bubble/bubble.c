#include <stdio.h>
#include <stdlib.h>

void swap(int *xp, int *yp)
{
    int temp = *xp;
    *xp = *yp;
    *yp = temp;
}

// A function to implement bubble sort
void bubbleSort(int numbers[], int count)
{
    int input, i, j, c;

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
}