#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include <time.h>
#include <stdbool.h>
#include <mpi.h>

#define UPPER 50000000
#define LOWER -50000000

struct report
{
    double runtime;
    char *process_name;
    char *big_o;
    int size;
    int number_of_processess;
    int total_hits;
};

long *fetch_array(int size);
long *create_one_d_matrix(int size);
void create_report(int size, struct report *r);
long get_first_number(long *sub_rand_nums);
