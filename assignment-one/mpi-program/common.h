#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include <time.h>
#include <stdbool.h>
#include <mpi.h>

#define UPPER 10
#define LOWER -10

// Shared Functions
long *create_one_d_matrix(int size, bool printOutput);
void printArray(long arr[], int size);
long *fetch_array(int size);

// Test  Operation
// long compute_avg(long *sub_rand_nums, int elements_per_proc, int id, bool print);
long search(long *sub_rand_nums, int elements_per_proc, long target);
long get_random_target();
