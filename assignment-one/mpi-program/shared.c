#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <stdbool.h>

void printArray(int arr[], int size)
{
    int i;
    for (i = 0; i < size - 1; i++)
        printf("\t%d\n ", arr[i]);
}

void print_two_d_array(int r, int c, double arr[r][c])
{
    int i, j;
    for (i = 0; i <= r - 1; i++)
    {
        {
            for (j = 0; j <= c - 1; j++)
                printf("\t%f", arr[i][j]);
        }
        printf("\n");
    }
}

double time_calc(clock_t start, clock_t end)
{
    return ((double)(end - start)) / CLOCKS_PER_SEC;
}

int *create_one_d_matrix(int size, int *m_out, bool printOutput)
{
    srand(time(0));

    if (printOutput == true)
    {
        printf("Creating an array of size  %d \n", size);
    }

    int i;
    for (i = 0; i < size; i++)
    {
        int num = rand();
        m_out[i] = num;
    }

    if (printOutput == true)
    {
        printf("Created an array of size  %d \n", size);
    }

    return m_out;
}

double randfrom(double min, double max)
{
    double range = (max - min);
    double div = RAND_MAX / range;
    return min + (rand() / div);
}

void create_two_d_array(int r, int c, double m_out[r][c])
{
    srand(time(0));

    int i, j = 0;
    for (i = 0; i < r; i++)
    {
        for (j = 0; j < c; j++)
        {
            m_out[i][j] = randfrom(0, 1000000);
        }
    }
}