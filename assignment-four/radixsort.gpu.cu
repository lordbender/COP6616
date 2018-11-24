// http://on-demand.gputechconf.com/gtc/2014/presentations/S4158-cuda-streams-best-practices-common-pitfalls.pdf
#include <stdio.h>
#include <stdlib.h>
#include <ctime>
#include <vector>
#include <ratio>
#include <chrono>

#include "main_cuda.cuh"

using namespace std::chrono;

static const int BLOCK_SIZE = 256;

__global__ void countsort_device(int *arr, int *output, int n, int exp)
{
    // int id = blockIdx.x * blockDim.x + threadIdx.x;
    // if (id < n)
    //     c[id] = a[id] * a[id];

    int i, count[10] = {0};

    for (i = 0; i < n; i++)
        count[(arr[i] / exp) % 10]++;

    for (i = 1; i < 10; i++)
        count[i] += count[i - 1];

    // Build the output array
    for (i = n - 1; i >= 0; i--)
    {
        output[count[(arr[i] / exp) % 10] - 1] = arr[i];
        count[(arr[i] / exp) % 10]--;
    }
}

void radixsort_host(int *ha, int *hc, int n)
{
    int *da, *dc;

    gpuErrchk(cudaMalloc((void **)&da, sizeof(int) * n));
    gpuErrchk(cudaGetLastError());

    gpuErrchk(cudaMalloc((void **)&dc, sizeof(int) * n));
    gpuErrchk(cudaGetLastError());

    gpuErrchk(cudaMemcpy(da, ha, sizeof(int) * n, cudaMemcpyHostToDevice));
    gpuErrchk(cudaGetLastError());

    int m = getMax(ha, n);
    int grid = ceil(n * 1.0 / BLOCK_SIZE);

    for (int exp = 1; m / exp > 0; exp *= 10)
    {
        countsort_device<<<grid, BLOCK_SIZE>>>(da, dc, n, exp);
    }

    gpuErrchk(cudaDeviceSynchronize());
    gpuErrchk(cudaGetLastError());

    gpuErrchk(cudaMemcpy(hc, dc, sizeof(int) * n, cudaMemcpyDeviceToHost));
    gpuErrchk(cudaGetLastError());

    cudaFree(da);
    cudaFree(dc);

    cudaDeviceReset();
}

duration<double> radixsort_gpu(int size)
{
    int *ha = (int *)malloc(sizeof(int) * size);
    int *hc = (int *)malloc(sizeof(int) * size);

    for (int i = 0; i < size; i++)
    {
        ha[i] = rand();
        hc[i] = 0;
    }

    high_resolution_clock::time_point start = high_resolution_clock::now();
    radixsort_host(ha, hc, size);
    high_resolution_clock::time_point end = high_resolution_clock::now();

    // Testing that sort is working, keep commented out on large values of N (say N > 1000)
    for (int i = 0; i < size; i++)
    {
        printf("\t %d\n", hc[i]);
    }

    free(ha);
    free(hc);

    return time_calc(start, end);
}
