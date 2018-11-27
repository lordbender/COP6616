#include <stdio.h>
#include <stdlib.h>
#include <ctime>
#include <ratio>
#include <chrono>
#include "main_cuda.cuh"

static const int BLOCK_SIZE = 256;

__device__ void swap_device(unsigned int *a, unsigned int *b)
{
    unsigned int t = *a;
    *a = *b;
    *b = t;
}

__device__ unsigned int partition_device(unsigned int *arr, int low, int high)
{
    unsigned int pivot = arr[high];
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
__global__ void quicksort_device(unsigned int *data, int left, int right)
{
    int pi = partition_device(data, left, right);

    int nright = pi - 1;
    int nleft = pi + 1;

    if (left < nright)
    {
        cudaStream_t s1;
        cudaStreamCreateWithFlags(&s1, cudaStreamNonBlocking);
        quicksort_device<<<1, 1, 0, s1>>>(data, left, nright);
        cudaStreamDestroy(s1);
    }

    if (nleft < right)
    {
        cudaStream_t s2;
        cudaStreamCreateWithFlags(&s2, cudaStreamNonBlocking);
        quicksort_device<<<1, 1, 0, s2>>>(data, nleft, right);
        cudaStreamDestroy(s2);
    }
}

duration<double> quicksort_gpu_streams(int size)
{
    cudaError_t cudaStatus;

    unsigned int *ha, *da;

    ha = (unsigned int *)malloc(sizeof(unsigned int) * size);

    for (int i = 0; i < size; i++)
    {
        ha[i] = rand() % size;
    }

    high_resolution_clock::time_point start = high_resolution_clock::now();

    cudaStatus = cudaMalloc((void **)&da, sizeof(unsigned int) * size);
	if (cudaStatus != cudaSuccess) {
        fprintf(stderr, "cudaMalloc failed!  Do you have a CUDA-capable GPU installed?");
        if (abort)
            exit(cudaStatus);
	}

    cudaStatus = cudaMemcpy(da, ha, sizeof(unsigned int) * size, cudaMemcpyHostToDevice);
    if (cudaStatus != cudaSuccess) {
        fprintf(stderr, "cudaMemcpy failed!  Do you have a CUDA-capable GPU installed?");
        if (abort)
            exit(cudaStatus);
	}

    // cudaDeviceSetLimit(cudaLimitDevRuntimeSyncDepth, 16);
    int grid = ceil(size * 1.0 / BLOCK_SIZE);
    quicksort_device<<<grid, BLOCK_SIZE>>>(da, 0, size - 1);
    cudaStatus = cudaDeviceSynchronize();
	if (cudaStatus != cudaSuccess) {
        fprintf(stderr, "cudaDeviceSynchronize failed!  Do you have a CUDA-capable GPU installed?");
        if (abort)
            exit(cudaStatus);
    }

    unsigned int *hc = (unsigned int *)malloc(sizeof(unsigned int) * size);
    cudaStatus = cudaMemcpy(hc, da, sizeof(unsigned int) * size, cudaMemcpyDeviceToHost);
	if (cudaStatus != cudaSuccess) {
        fprintf(stderr, "cudaMemcpy failed!  Do you have a CUDA-capable GPU installed?");
        if (abort)
            exit(cudaStatus);
	}

    // Testing that sort is working, keep commented out on large values of N (say N > 1000)
    for (int i = 0; i < size; i++)
    {
        printf("\t hc[ %d ] => %d\n", i, hc[i]);
    }
    
    cudaFree(da);
    cudaDeviceReset();
    free(ha);

    high_resolution_clock::time_point end = high_resolution_clock::now();
    return time_calc(start, end);
}
