#include <stdio.h>
#include <stdlib.h>
#include <ctime>
#include <ratio>
#include <chrono>
#include "main_cuda.cuh"

static const int BLOCK_SIZE = 256;

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
__global__ void quicksort_device(int *data, int left, int right)
{ 
    cudaStream_t s1, s2;
    int pi = partition_device(data, left, right);

    int nright = pi - 1;
    int nleft = pi + 1;

    if (left < nright)
    {
        cudaStreamCreateWithFlags(&s1, cudaStreamNonBlocking);
        quicksort_device<<<1, 32, 0, s1>>>(data, left, nright);
    }

    if (nleft < right)
    {
        cudaStreamCreateWithFlags(&s2, cudaStreamNonBlocking);
        quicksort_device<<<1, 32, 0, s2>>>(data, nleft, right);
    }
}

duration<double> quicksort_gpu_streams(int size)
{
    int* ha = (int *)malloc(sizeof(int) * size);
    for (int i = 0; i < size; i++)
    {
        ha[i] = rand();
    }

    high_resolution_clock::time_point start = high_resolution_clock::now();

    int *da;
    gpuErrchk(cudaMalloc((void **)&da, sizeof(int) * size));
    gpuErrchk(cudaMemcpy(da, ha, sizeof(int) * size, cudaMemcpyHostToDevice));

    int grid = ceil(size * 1.0 / BLOCK_SIZE);
    quicksort_device<<<grid, BLOCK_SIZE>>>(da, 0, size - 1);
    gpuErrchk(cudaDeviceSynchronize());

    int *hc = (int *)malloc(sizeof(int) * size);
    gpuErrchk(cudaMemcpy(hc, da, sizeof(int) * size, cudaMemcpyDeviceToHost));

    // Testing that sort is working, keep commented out on large values of N (say N > 1000)
    // for (int i = 0; i < size; i++)
    // {
    //     printf("\t hc[ %d ] => %d\n", i, hc[i]);
    // }
    
    gpuErrchk(cudaFree(da));
    free(ha);
    free(hc);

    high_resolution_clock::time_point end = high_resolution_clock::now();
    return time_calc(start, end);
}
