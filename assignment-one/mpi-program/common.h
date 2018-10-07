#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include <time.h>
#include <stdbool.h>
#include <mpi.h>

// Shared Functions
float *create_one_d_matrix(int size, bool printOutput);
void printArray(float arr[], int size);
float compute_avg(float *sub_rand_nums, int elements_per_proc, int id);
float *fetch_array(int size);
