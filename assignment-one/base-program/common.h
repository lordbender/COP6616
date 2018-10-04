#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <stdbool.h>

void printArray(int arr[], int size);

double time_calc(clock_t start, clock_t end);

int* bubbleSort(int numbers[], int count);

double run_linear(int array[], int size, bool printArray);

double time_calc(clock_t start, clock_t end);
