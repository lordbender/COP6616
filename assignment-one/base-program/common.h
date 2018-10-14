#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <stdbool.h>

#define UPPER 50000000
#define LOWER -50000000

struct report
{
    double runtime;
    char *process_name;
    char *big_o;
    int size;
};

// Shared Functions
long *create_one_d_matrix(int size);
long *fetch_array(int size);

// Actual Programs
double run_linear_matrix_multiply(int size);
double run_linear_search(int size);
double run_linear_big_o_of_one(int size);
double run_linear_bubble(int size);

// Supporting Stuffs
double time_calc(clock_t start, clock_t end);
void create_report(int size, struct report *r);