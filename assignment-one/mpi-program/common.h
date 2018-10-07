#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <stdbool.h>
#include <mpi.h>

// Shared Functions
int *create_one_d_matrix(int size, int *m_out, bool printOutput);
void printArray(int arr[], int size);
