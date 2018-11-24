#include <stdio.h>
#include <stdlib.h>
#include <ctime>
#include <ratio>
#include <chrono>
#include <vector>

#include "main_cuda.cuh"

using namespace std::chrono;

int getMax(int *arr, int n) 
{ 
    int mx = arr[0]; 
    for (int i = 1; i < n; i++) 
        if (arr[i] > mx) 
            mx = arr[i]; 
    return mx; 
} 
  
// A function to do counting sort of arr[] according to 
// the digit represented by exp. 
void countSort(int *arr, int n, int exp) 
{ 
    int *output = (int *)malloc(sizeof(int) * n); 
    int i, count[10] = {0}; 
  
    for (i = 0; i < n; i++) 
        count[ (arr[i]/exp)%10 ]++; 

    for (i = 1; i < 10; i++) 
        count[i] += count[i - 1]; 
  
    // Build the output array 
    for (i = n - 1; i >= 0; i--) 
    { 
        output[count[ (arr[i]/exp)%10 ] - 1] = arr[i]; 
        count[ (arr[i]/exp)%10 ]--; 
    } 

    for (i = 0; i < n; i++) 
        arr[i] = output[i]; 
} 
  
void radixsort(int *arr, int n) 
{ 
    int m = getMax(arr, n); 
  
    for (int exp = 1; m/exp > 0; exp *= 10) 
        countSort(arr, n, exp); 
}


duration<double> radixsort_cpu(int size)
{   
    int *a = (int *)malloc(sizeof(int) * size);

    for (int i = 0; i < size; i++)
    {
        a[i] = rand();
    }
 
  	high_resolution_clock::time_point start = high_resolution_clock::now();
    radixsort(a, size); 
    high_resolution_clock::time_point end = high_resolution_clock::now();
	
    // Testing that sort is working, keep commented out on large values of N (say N > 1000)
    // for (int i = 0; i < size; i++)
    // {
    //     printf("\t %d\n", a[i]);
    // }

    return time_calc(start, end);
}