#include <stdio.h>
#include <stdlib.h>
#include <ctime>
#include <ratio>
#include <chrono>
#include "main_cuda.cuh"

static const int BLOCK_SIZE = 256;

#define MAX_DEPTH       16
#define INSERTION_SORT  32

__global__ void cdp_simple_quicksort(int *data, int left, int right, int depth)
{
    int *lptr = data+left;
    int *rptr = data+right;
    int  pivot = data[(left+right)/2];

    while (lptr <= rptr)
    {
        int lval = *lptr;
        int rval = *rptr;

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

// __device__ void swap_device(int *a, int *b)
// {
//     int t = *a;
//     *a = *b;
//     *b = t;
// }

// __device__ int partition_device(int *arr, int low, int high)
// {
//     int pivot = arr[high];
//     int i = (low - 1);

//     for (int j = low; j <= high - 1; j++)
//     {
//         if (arr[j] <= pivot)
//         {
//             i++;
//             swap_device(&arr[i], &arr[j]);
//         }
//     }
//     swap_device(&arr[i + 1], &arr[high]);
//     return (i + 1);
// }

// // Based on CUDA Examples - But Optimized
// __global__ void quicksort_device(int *data, int left, int right)
// { 
//     cudaStream_t s1, s2;
//     int pi = partition_device(data, left, right);

//     int nright = pi - 1;
//     int nleft = pi + 1;

//     if (left < nright)
//     {
//         // cudaStreamCreateWithFlags(&s1, cudaStreamNonBlocking);
//         // quicksort_device<<<1, 32, 0, s1>>>(data, left, nright);
//     }

//     if (nleft < right)
//     {
//         // cudaStreamCreateWithFlags(&s2, cudaStreamNonBlocking);
//         // quicksort_device<<<1, 32, 0, s2>>>(data, nleft, right);
//     }
// }

void quicksort_host(int *da, int *hc, int size)
{
    // Call the device.
    int grid = ceil(size * 1.0 / BLOCK_SIZE);
    cdp_simple_quicksort<<<grid, BLOCK_SIZE>>>(da, 0, size - 1, MAX_DEPTH);
    gpuErrchk(cudaGetLastError());

    // Ensure the Device is in sync, before we copy the data back!
    gpuErrchk(cudaDeviceSynchronize());
    gpuErrchk(cudaGetLastError());

    // Copy the results back from the device.
    gpuErrchk(cudaMemcpy(hc, da, sizeof(int) * size, cudaMemcpyDeviceToHost));
    gpuErrchk(cudaGetLastError());

    // Testing that sort is working, keep commented out on large values of N (say N > 1000)
    for (int i = 0; i < size; i++)
    {
        printf("\t %d\n", hc[i]);
    }
}

duration<double> quicksort_gpu_streams(int size)
{
    int* ha = (int *)malloc(sizeof(int) * size);
    int* hc = (int *)malloc(sizeof(int) * size);

    for (int i = 0; i < size; i++)
    {
        ha[i] = rand();
        hc[i] = 0;
    }

    high_resolution_clock::time_point start = high_resolution_clock::now();

    int *da;
    gpuErrchk(cudaMalloc((void **)&da, sizeof(int) * size));
    gpuErrchk(cudaMemcpy(da, ha, sizeof(int) * size, cudaMemcpyHostToDevice));
    gpuErrchk(cudaGetLastError());

    // Kick off the sort!
    quicksort_host(da, hc, size);

    gpuErrchk(cudaFree(da));
    free(ha);
    free(hc);
    
    high_resolution_clock::time_point end = high_resolution_clock::now();
    return time_calc(start, end);
}
