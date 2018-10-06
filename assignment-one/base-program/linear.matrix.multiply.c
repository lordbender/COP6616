#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <stdbool.h>
#include "common.h"
#define N 4 
  
// This function multiplies mat1[][] and mat2[][], 
// and stores the result in res[][] 
void multiply(int mat1[][N], int mat2[][N], int res[][N]) 
{ 
    int i, j, k; 
    for (i = 0; i < N; i++) 
    { 
        for (j = 0; j < N; j++) 
        { 
            res[i][j] = 0; 
            for (k = 0; k < N; k++) 
                res[i][j] += mat1[i][k]*mat2[k][j]; 
        } 
    } 
} 

// double run_matrix_mult(int array_one[][N],int array_two[], int size, bool print)
// {
//     clock_t start = clock();
//     // int *r = bubbleSort(array, size);
//     clock_t end = clock();

//     // Print the Array - If you want!
//     if (print == true)
//     {
//         printArray(array, size);
//     }

//     return time_calc(start, end);
// }