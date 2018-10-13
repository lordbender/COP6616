#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include <time.h>
#include <stdbool.h>
#include <mpi.h>

#define UPPER 50000000
#define LOWER -50000000

struct report {
   double runtime;
   char* process_name;
   char* big_o;
   int size;
   int number_of_processess;
   int total_hits;
};


// Programs
void run_search(int my_process_id, int number_of_processess, int size);

// Shared Functions
long *create_one_d_matrix(int size, bool printOutput);
void printArray(long arr[], int size);
long *fetch_array(int size);
void create_report(int size, struct report *r);

// Test  Operation
long search(long *sub_rand_nums, int elements_per_proc, long target);
long get_random_target();
