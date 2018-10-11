#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <stdbool.h>

struct report {
   double runtime;
   char* process_name;
   char* big_o;
   int size;
};

// Shared Functions
double time_calc(clock_t start, clock_t end);
int *create_one_d_matrix(int size, int *m_out, bool printOutput);
void create_two_d_array(int r, int c, long m_out[r][c]);
void multiply(int size, long **mat1, long **mat2, long **res);
void printArray(int arr[], int size);
void print_two_d_array(int r, int c, long arr[r][c]);

// Actual Programs
double run_linear_matrix_multiply(int size, bool print);
double run_linear_search(int size, bool print);
double run_linear_big_o_of_one(int size, bool print);
double run_linear_bubble(int array[], int size, bool printArray);

// Supporting Stuffs
int *bubbleSort(int numbers[], int count);
long randfrom(long min, long max);
void create_report(int size, struct report *r);