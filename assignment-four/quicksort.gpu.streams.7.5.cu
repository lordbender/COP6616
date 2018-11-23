// http://on-demand.gputechconf.com/gtc/2014/presentations/S4158-cuda-streams-best-practices-common-pitfalls.pdf
#include <stdio.h>
#include <stdlib.h>
#include <ctime>
#include <ratio>
#include <chrono>
#include <vector>

#include "main_cuda.cuh"

using namespace std::chrono;

static const int BLOCK_SIZE = 256;

__global__ void quicksort_device(int *a) {
    // do the work!!!

    return;
}

void quicksort_host(int *da, int left, int right, int size)
{
	int pivot_index = left;
    int pivot_new_index = partition(da, left, right, pivot_index);
    
    // int new_right = pivot_new_index - 1;
    // int new_left = pivot_new_index + 1;

    // Create a thread pool on the GPU
    // Use Streams to Parallelize on the GPU tobreduce copy footprint.
    cudaStream_t s1, s2;
    cudaStreamCreateWithFlags(&s1, cudaStreamNonBlocking);
    cudaStreamCreateWithFlags(&s2, cudaStreamNonBlocking);

    // split up the work so we can thread it!!!
    int *db = (int*)malloc(sizeof(int) * 1);
    int *dc = (int*)malloc(sizeof(int) * 1);

    // partition based on the pivot;
    int grid = ceil(size * 1.0 / BLOCK_SIZE);
    quicksort_device<<<grid, BLOCK_SIZE, 0, s1>>>(db);
    quicksort_device<<<grid, BLOCK_SIZE, 0, s2>>>(dc);

	cudaStreamSynchronize(0);
    gpuErrchk(cudaGetLastError());

    // Clean up the thread pool.
    cudaStreamDestroy(s1);
    cudaStreamDestroy(s2);
}

duration<double> quicksort_gpu_streams(int size)
{
    int *ha, *da;

    ha = (int *)malloc(sizeof(int) * size);

    for (int i = 0; i < size; i++)
    {
        ha[i] = rand();
    }

    high_resolution_clock::time_point start = high_resolution_clock::now();

    gpuErrchk(cudaMalloc((void **)&da, sizeof(int) * size));
    gpuErrchk(cudaGetLastError());

    gpuErrchk(cudaMemcpy(da, ha, sizeof(int) * size, cudaMemcpyHostToDevice));
    gpuErrchk(cudaGetLastError());

    quicksort_host(da, 0, size - 1, size);

    cudaMemcpy(ha, da, sizeof(int) * size, cudaMemcpyDeviceToHost);

    cudaFree(da);
    cudaDeviceReset();

    free(ha);

    high_resolution_clock::time_point end = high_resolution_clock::now();

    return time_calc(start, end);
}