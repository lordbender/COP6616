// http://on-demand.gputechconf.com/gtc/2014/presentations/S4158-cuda-streams-best-practices-common-pitfalls.pdf
#include <stdio.h>
#include <stdlib.h>
#include <ctime>
#include <ratio>
#include <chrono>

#include "main_cuda.cuh"

using namespace std::chrono;

static const int BLOCK_SIZE = 256;

__device__ void partition_by_bit(int *values, int bit);

__global__ void radix_sort(int *values)
{
    int  bit;
    for( bit = 0; bit < 32; ++bit )
    {
        partition_by_bit(values, bit);
        __syncthreads();
    }
}

template<class T>
__device__ T plus_scan(T *x)
{
    int i = threadIdx.x; // id of thread executing this instance
    int n = blockDim.x;  // total number of threads in this block
    int offset;          // distance between elements to be added

    for( offset = 1; offset < n; offset *= 2) {
        T t;

        if ( i >= offset ) 
            t = x[i-offset];
        
        __syncthreads();

        if ( i >= offset ) 
            x[i] = t + x[i];   

        __syncthreads();
    }
    return x[i];
}


__device__ void partition_by_bit(int *values, int bit)
{
    int i = threadIdx.x;
    int size = blockDim.x;
    int x_i = values[i];          // value of integer at position i
    int p_i = (x_i >> bit) & 1;   // value of bit at position bit

    values[i] = p_i;  

    __syncthreads();

    int T_before = plus_scan(values);

    int T_total  = values[size-1];

    int F_total  = size - T_total;

    __syncthreads();

    if ( p_i )
        values[T_before-1 + F_total] = x_i;
    else
        values[i - T_before] = x_i;
}

duration<double> radixsort_gpu(int size)
{
    int *ha, *hc, *da, *dc;

    ha = (int *)malloc(sizeof(int) * size);
    hc = (int *)malloc(sizeof(int) * size);

    for (int i = 0; i < size; i++)
    {
        ha[i] = rand();
        hc[i] = 0;
    }

    high_resolution_clock::time_point start = high_resolution_clock::now();

    gpuErrchk(cudaMalloc((void **)&da, sizeof(int) * size));
    gpuErrchk(cudaGetLastError());

    gpuErrchk(cudaMalloc((void **)&dc, sizeof(int) * size));
    gpuErrchk(cudaGetLastError());

    gpuErrchk(cudaMemcpy(da, ha, sizeof(int) * size, cudaMemcpyHostToDevice));
    gpuErrchk(cudaGetLastError());

    int grid = ceil(size * 1.0 / BLOCK_SIZE);
    radix_sort<<<grid, BLOCK_SIZE>>>(da);

    cudaDeviceSynchronize();
    gpuErrchk(cudaGetLastError());

    cudaMemcpy(hc, dc, sizeof(int) * size, cudaMemcpyDeviceToHost);

    cudaFree(da);
    cudaFree(dc);
    cudaDeviceReset();

    free(ha);
    free(hc);
 
    high_resolution_clock::time_point end = high_resolution_clock::now();

    free(ha);

    // Testing that sort is working, keep commented out on large values of N (say N > 1000)
    for (int i = 0; i < size; i++)
    {
        printf("\t %d\n", hc[i]);
    }

    return time_calc(start, end);
}
