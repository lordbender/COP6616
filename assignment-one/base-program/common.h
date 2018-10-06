#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <stdbool.h>

void printArray(int arr[], int size);

void print_two_d_array(int r, int c, int arr[r][c]);

int *create_one_d_matrix(int size, int *m_out, bool printOutput);

void create_two_d_array(int r, int c, int m_out[r][c]);

double time_calc(clock_t start, clock_t end);

int *bubbleSort(int numbers[], int count);

double run_linear_bubble(int array[], int size, bool printArray);

double time_calc(clock_t start, clock_t end);

void multiply(int size, int mat1[][size], int mat2[][size], int res[][size]);

double run_linear_matrix_multiply(int size, bool print);

double run_linear_search(int size, bool print);

double run_linear_big_o_of_one(int size, bool print);