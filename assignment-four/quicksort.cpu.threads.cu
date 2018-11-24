// #define _XOPEN_SOURCE 600
#include <stdio.h>
#include <stdlib.h>
#include <assert.h>
#include <pthread.h>

#include "main_cuda.cuh"

struct qsort_starter
{
	int *array;
	int left;
	int right;
	int depth;
};

// Macro for swapping two values.
#define SWAP(x,y) do {\
    __typeof__(x) tmp = x;\
    x = y;\
    y = tmp;\
} while(0)

void quicksort_serial(int *array, int left, int right)
{
     if (right > left)
     {
        int pivotIndex = left + (right - left)/2;
        pivotIndex = partition(array, left, right, pivotIndex);
        quicksort_serial(array, left, pivotIndex-1);
        quicksort_serial(array, pivotIndex+1, right);
     }
}


void parallel_quicksort(int *array, int left, int right, int depth);

void* quicksort_thread(void *init)
{
    struct qsort_starter *start = (qsort_starter*)init;
    parallel_quicksort(start->array, start->left, start->right, start->depth);
    return NULL;
}

void parallel_quicksort(int *array, int left, int right, int depth)
{
    if (right > left)
    {
        int pivotIndex = left + (right - left)/2;
        pivotIndex = partition(array, left, right, pivotIndex);
        // Either do the parallel or serial quicksort, depending on the depth
        // specified.
        if (depth-- > 0)
        {
            // Create the thread for the first recursive call
            struct qsort_starter arg = {array, left, pivotIndex-1, depth};
            pthread_t thread;
            int ret = pthread_create(&thread, NULL, quicksort_thread, &arg);
            assert((ret == 0) && "Thread creation failed");
            // Perform the second recursive call in this thread
            parallel_quicksort(array, pivotIndex+1, right, depth);
            // Wait for the first call to finish.
            pthread_join(thread, NULL);
        }
        else
        {
            quicksort_serial(array, left, pivotIndex-1);
            quicksort_serial(array, pivotIndex+1, right);
        }
    }
}


duration<double> quicksort_cpu_threads(int size)
{   
	int depth = 5;

    int *a = (int *)malloc(sizeof(int) * size);

    for (int i = 0; i < size; i++)
    {
        a[i] = rand();
    }
 
  	high_resolution_clock::time_point start = high_resolution_clock::now();
	parallel_quicksort(a, 0, size - 1, depth); 
    high_resolution_clock::time_point end = high_resolution_clock::now();
	
    // Testing that sort is working, keep commented out on large values of N (say N > 1000)
    for (int i = 0; i < size; i++)
    {
        printf("\t %d\n", a[i]);
    }

    return time_calc(start, end);
}
