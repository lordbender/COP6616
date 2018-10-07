#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include <time.h>
#include <stdbool.h>
#include <mpi.h>

// Shared Functions
float *create_one_d_matrix(int size, bool printOutput);
void printArray(float arr[], int size);
float *fetch_array(int size);
int *fetch_array_int(int size);

// Test  Operation
float compute_avg(float *sub_rand_nums, int elements_per_proc, int id, bool print);
int search(float *sub_rand_nums, int elements_per_proc, float target);
float get_random_target();
