#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <stdbool.h>

void printArray(int arr[], int size);

int *create_one_d_matrix(int size, int *m_out, bool printOutput);

double time_calc(clock_t start, clock_t end);

int* bubbleSort(int numbers[], int count);

double run_linear_bubble(int array[], int size, bool printArray);

double time_calc(clock_t start, clock_t end);
