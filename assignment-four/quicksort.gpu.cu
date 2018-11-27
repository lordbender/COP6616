#include <stdio.h>
#include <stdlib.h>
#include <ctime>
#include <ratio>
#include <chrono>
#include "main_cuda.cuh"

#define MAX_DEPTH       16

static const int BLOCK_SIZE = 256;

__device__ void selection_sort(int *data, int left, int right)
{
    for (int i = left ; i <= right ; ++i)
    {
        int min_val = data[i];
        int min_idx = i;

        // Find the smallest value in the range [left, right].
        for (int j = i+1 ; j <= right ; ++j)
        {
            int val_j = data[j];

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

__device__ void swap_device(int *a, int *b)
{
    int t = *a;
    *a = *b;
    *b = t;
}

__device__ int partition_device(int *arr, int low, int high)
{
    int pivot = arr[high];
    int i = (low - 1);

    for (int j = low; j <= high - 1; j++)
    {
        if (arr[j] <= pivot)
        {
            i++;
            swap_device(&arr[i], &arr[j]);
        }
    }
    swap_device(&arr[i + 1], &arr[high]);
    return (i + 1);
}

// Based on CUDA Examples - But Optimized
__global__ void quicksort_device(int *data, int left, int right, int depth)
{
    // If we're too deep or there are few elements left, we use an insertion sort...
    if (depth >= MAX_DEPTH || right-left <= 32)
    {
        selection_sort(data, left, right);
        return;
    }

    int *lptr = data+left;
    int *rptr = data+right;
    int  pivot = data[(left+right)/2];

    // Do the partitioning.
    while (lptr <= rptr)
    {
        // Find the next left- and right-hand values to swap
        int lval = *lptr;
        int rval = *rptr;

        // Move the left pointer as long as the pointed element is smaller than the pivot.
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
        quicksort_device<<< 1, 1, 0, s >>>(data, left, nright, depth+1);
        cudaStreamDestroy(s);
    }

    // Launch a new block to sort the right part.
    if ((lptr-data) < right)
    {
        cudaStream_t s1;
        cudaStreamCreateWithFlags(&s1, cudaStreamNonBlocking);
        quicksort_device<<< 1, 1, 0, s1 >>>(data, nleft, right, depth+1);
        cudaStreamDestroy(s1);
    }
}

duration<double> quicksort_gpu_streams(int size)
{
    cudaError_t cudaStatus;

    int *ha, *da, *hc;

    ha = (int *)malloc(sizeof(int) * size);
    hc = (int *)malloc(sizeof(int) * size);

    for (int i = 0; i < size; i++)
    {
        ha[i] = rand();
        hc[i] = 0;
    }

    high_resolution_clock::time_point start = high_resolution_clock::now();

    cudaStatus = cudaMalloc((void **)&da, sizeof(int) * size);
	if (cudaStatus != cudaSuccess) {
        fprintf(stderr, "cudaMalloc failed!  Do you have a CUDA-capable GPU installed?");
        if (abort)
            exit(cudaStatus);
	}

    cudaStatus = cudaMemcpy(da, ha, sizeof(int) * size, cudaMemcpyHostToDevice);
    if (cudaStatus != cudaSuccess) {
        fprintf(stderr, "cudaMemcpy failed!  Do you have a CUDA-capable GPU installed?");
        if (abort)
            exit(cudaStatus);
	}

    cudaDeviceSetLimit(cudaLimitDevRuntimeSyncDepth, MAX_DEPTH);
    int grid = ceil(size * 1.0 / BLOCK_SIZE);
    quicksort_device<<<grid, BLOCK_SIZE>>>(da, 0, size - 1, 0);
    cudaDeviceSynchronize();

    cudaStatus = cudaMemcpy(hc, da, sizeof(int) * size, cudaMemcpyDeviceToHost);
	if (cudaStatus != cudaSuccess) {
        fprintf(stderr, "cudaMemcpy failed!  Do you have a CUDA-capable GPU installed?");
        if (abort)
            exit(cudaStatus);
	}

	cudaFree(da);
    cudaDeviceReset();
    // Testing that sort is working, keep commented out on large values of N (say N > 1000)
    for (int i = 0; i < size; i++)
    {
        printf("\t %d\n", hc[i]);
    }

    free(ha);

    high_resolution_clock::time_point end = high_resolution_clock::now();
    return time_calc(start, end);
}