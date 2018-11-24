// http://on-demand.gputechconf.com/gtc/2014/presentations/S4158-cuda-streams-best-practices-common-pitfalls.pdf
#include <stdio.h>
#include <stdlib.h>
#include <ctime>
#include <ratio>
#include <chrono>

#include "main_cuda.cuh"

using namespace std::chrono;

static const int BLOCK_SIZE = 256;

__global__ void radixsort_device(int *array, int left, int right) {
    // do the work!!!

    return;
}

void radixsort_host(int *arr, int n) 
{ 
    int m = getMax(arr, n); 
  
    for (int exp = 1; m/exp > 0; exp *= 10) 
     {
         // Do work
     }
}

duration<double> radixsort_gpu(int size)
{
    int *ha  = (int *)malloc(sizeof(int) * size);

    for (int i = 0; i < size; i++)
    {
        ha[i] = rand();
    }

    high_resolution_clock::time_point start = high_resolution_clock::now();
    radixsort_host(ha, size);    
    high_resolution_clock::time_point end = high_resolution_clock::now();

    free(ha);

    // Testing that sort is working, keep commented out on large values of N (say N > 1000)
    // for (int i = 0; i < size; i++)
    // {
    //     printf("\t %d\n", ha[i]);
    // }

    return time_calc(start, end);
}
