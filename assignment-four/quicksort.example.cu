#include <stdio.h>
#include <stdlib.h>
#include <ctime>
#include <ratio>
#include <chrono>
#include <iostream>
#include <cstdio>

#include "main_cuda.cuh"

#define MAX_DEPTH       16
#define INSERTION_SORT  32

__device__ void selection_sort(unsigned int *data, int left, int right)
{
    for (int i = left ; i <= right ; ++i)
    {
        unsigned min_val = data[i];
        int min_idx = i;

        // Find the smallest value in the range [left, right].
        for (int j = i+1 ; j <= right ; ++j)
        {
            unsigned val_j = data[j];

            if (val_j < min_val)
            {
                min_idx = j;
                min_val = val_j;
            }
        }

        // Swap the values.
        if (i != min_idx)
        {
            data[min_idx] = data[i];
            data[i] = min_val;
        }
    }
}

__global__ void cdp_simple_quicksort(unsigned int *data, int left, int right, int depth)
{
    if (depth >= MAX_DEPTH || right-left <= INSERTION_SORT)
    {
        selection_sort(data, left, right);
        return;
    }

    unsigned int *lptr = data+left;
    unsigned int *rptr = data+right;
    unsigned int  pivot = data[(left+right)/2];

    while (lptr <= rptr)
    {
        unsigned int lval = *lptr;
        unsigned int rval = *rptr;

        while (lval < pivot)
        {
            lptr++;
            lval = *lptr;
        }

        // Move the right pointer as long as the pointed element is larger than the pivot.
        while (rval > pivot)
        {
            rptr--;
            rval = *rptr;
        }

        // If the swap points are valid, do the swap!
        if (lptr <= rptr)
        {
            *lptr++ = rval;
            *rptr-- = lval;
        }
    }

    // Now the recursive part
    int nright = rptr - data;
    int nleft  = lptr - data;

    // Launch a new block to sort the left part.
    if (left < (rptr-data))
    {
        cudaStream_t s;
        cudaStreamCreateWithFlags(&s, cudaStreamNonBlocking);
        cdp_simple_quicksort<<< 1, 1, 0, s >>>(data, left, nright, depth+1);
        cudaStreamDestroy(s);
    }

    // Launch a new block to sort the right part.
    if ((lptr-data) < right)
    {
        cudaStream_t s1;
        cudaStreamCreateWithFlags(&s1, cudaStreamNonBlocking);
        cdp_simple_quicksort<<< 1, 1, 0, s1 >>>(data, nleft, right, depth+1);
        cudaStreamDestroy(s1);
    }
}

////////////////////////////////////////////////////////////////////////////////
// Call the quicksort kernel from the host.
////////////////////////////////////////////////////////////////////////////////
void run_qsort(unsigned int *data, unsigned int nitems)
{
    // Prepare CDP for the max depth 'MAX_DEPTH'.
    cudaDeviceSetLimit(cudaLimitDevRuntimeSyncDepth, MAX_DEPTH);

    // Launch on device
    int left = 0;
    int right = nitems-1;
    std::cout << "Launching kernel on the GPU" << std::endl;
    cdp_simple_quicksort<<< 1, 1 >>>(data, left, right, 0);
    cudaDeviceSynchronize();
}

////////////////////////////////////////////////////////////////////////////////
// Initialize data on the host.
////////////////////////////////////////////////////////////////////////////////
void initialize_data(unsigned int *dst, unsigned int nitems)
{
    // Fixed seed for illustration
    srand(2047);

    // Fill dst with random values
    for (unsigned i = 0 ; i < nitems ; i++)
        dst[i] = rand() % nitems ;
}


void check_results(int n, unsigned int *results_d)
{
    unsigned int *results_h = new unsigned[n];
    cudaMemcpy(results_h, results_d, n*sizeof(unsigned), cudaMemcpyDeviceToHost);


    delete[] results_h;
}

duration<double> quicksort_gpu_streams(int size)
{
    unsigned int *h_data = 0;
    unsigned int *d_data = 0;

    h_data =(unsigned int *)malloc(size*sizeof(unsigned int));
    initialize_data(h_data, size);

    high_resolution_clock::time_point start = high_resolution_clock::now();
    cudaMalloc((void **)&d_data, size * sizeof(unsigned int));
    cudaMemcpy(d_data, h_data, size * sizeof(unsigned int), cudaMemcpyHostToDevice);

    run_qsort(d_data, size);

    check_results(size, d_data);

    for (int i = 0; i < size; i++)
    {
        printf("\t d_data[ %d ] => %d\n", i, d_data[i]);
    }

    free(h_data);
    cudaFree(d_data);
    high_resolution_clock::time_point end = high_resolution_clock::now();

    return time_calc(start, end);
}

