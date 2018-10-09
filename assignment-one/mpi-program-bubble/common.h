#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <stdbool.h>

#define UPPER 10000
#define LOWER -10000

// Shared Functions
long *create_one_d_matrix(int size);
long *fetch_array(int size);
void swap(long *xp, long *yp);
long *bubbleSort(long numbers[], int count);
