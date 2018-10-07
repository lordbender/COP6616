#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include <time.h>
#include <stdbool.h>
#include <mpi.h>

// Shared Functions
float *create_one_d_matrix(int size, float *m_out, bool printOutput);
void printArray(float arr[], int size);
