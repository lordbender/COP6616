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
__global__ void quicksort_device(int *da, int *dc, int left, int right, int size)
{ 
    cudaStream_t s1, s2;
    int pi = partition_device(da, left, right);

    int nright = pi - 1;
    int nleft = pi + 1;

    if (left < nright)
    {
        cudaStreamCreateWithFlags(&s1, cudaStreamNonBlocking);
        quicksort_device<<<1, 1, 0, s1>>>(da, dc, left, nright, size);
    }

    if (nleft < right)
    {
        cudaStreamCreateWithFlags(&s2, cudaStreamNonBlocking);
        quicksort_device<<<1, 1, 0, s2>>>(da, dc, nleft, right, size);
    }

    int tid = threadIdx.x;
    if(tid == 0)
        for (int i = 0; i <= size - 1; i++)
            dc[i] = da[i];
}

duration<double> quicksort_gpu_streams(int size)
{
    cudaError_t cudaStatus;

    int *ha, *da, *dc;

    ha = (int *)malloc(sizeof(int) * size);

    for (int i = 0; i < size; i++)
    {
        ha[i] = rand();
    }

    high_resolution_clock::time_point start = high_resolution_clock::now();

    cudaStatus = cudaMalloc((void **)&da, sizeof(int) * size);
    cudaStatus = cudaMalloc((void **)&dc, sizeof(int) * size);

    cudaStatus = cudaMemcpy(da, ha, sizeof(int) * size, cudaMemcpyHostToDevice);
    if (cudaStatus != cudaSuccess) {
        fprintf(stderr, "cudaMemcpy failed!  Do you have a CUDA-capable GPU installed?");
        if (abort)
            exit(cudaStatus);
	}

    // cudaDeviceSetLimit(cudaLimitDevRuntimeSyncDepth, 16);
    int grid = ceil(size * 1.0 / BLOCK_SIZE);
    quicksort_device<<<grid, BLOCK_SIZE>>>(da, dc, 0, size - 1, size);

    cudaStatus = cudaDeviceSynchronize();
	if (cudaStatus != cudaSuccess) {
        fprintf(stderr, "cudaDeviceSynchronize failed!  Do you have a CUDA-capable GPU installed?");
        if (abort)
            exit(cudaStatus);
    }

    cudaStatus = cudaDeviceSynchronize();
	if (cudaStatus != cudaSuccess) {
        fprintf(stderr, "cudaDeviceSynchronize failed!  Do you have a CUDA-capable GPU installed?");
        if (abort)
            exit(cudaStatus);
    }

    cudaStatus = cudaStreamSynchronize(0);
	if (cudaStatus != cudaSuccess) {
        fprintf(stderr, "cudaDeviceSynchronize failed!  Do you have a CUDA-capable GPU installed?");
        if (abort)
            exit(cudaStatus);
    }

    int *hc = (int *)malloc(sizeof(int) * size);

    cudaStatus = cudaMemcpy(hc, dc, sizeof(int) * size, cudaMemcpyDeviceToHost);
	if (cudaStatus != cudaSuccess) {
        fprintf(stderr, "cudaMemcpy failed!  Do you have a CUDA-capable GPU installed?");
        if (abort)
            exit(cudaStatus);
	}

    // Testing that sort is working, keep commented out on large values of N (say N > 1000)
    for (int i = 0; i < size; i++)
    {
        printf("\t ha[ %d ] => %d\n", i, ha[i]);
        printf("\t hc[ %d ] => %d\n", i, hc[i]);
    }
    
    cudaFree(da);
    cudaDeviceReset();
    free(ha);

    high_resolution_clock::time_point end = high_resolution_clock::now();
    return time_calc(start, end);
}
