#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <stdbool.h>
#include <mpi.h>

// Shared Functions
double time_calc(clock_t start, clock_t end);
int *create_one_d_matrix(int size, int* m_out, bool printOutput);
void printArray(int arr[], int size);

// Actual Programs
double run_mpi_bubble(int p, int id, int size, bool print);

// Supporting Stuffs
void bubblesort(int *v, int n);
int *merge(int *v1, int n1, int *v2, int n2);