#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <stdbool.h>

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

int *create_one_d_matrix(int size, int *m_out, bool printOutput)
{
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