#include <stdio.h>
#include <stdlib.h>
#include <ctime>
#include <ratio>
#include <chrono>
#include "main_cuda.cuh"

static const int BLOCK_SIZE = 256;

__global__ void quicksort_device(int arr[], int low, int high)
{ 
    cudaStream_t s1, s2;

    int pivot_index = low;

	if (low < high) 
	{ 
        int pivot_value = arr[pivot_index];
        int store_index = low;
    
        for (int i = low; i < high; i++)
            if (arr[i] <= pivot_value) {
            
                int temp = arr[i];
                arr[i] = arr[store_index];
                arr[store_index] = temp;

                ++store_index;
            }

            int temp = arr[store_index];
            arr[store_index] = arr[high];
            arr[low] = temp;

        cudaStreamCreateWithFlags(&s1, cudaStreamNonBlocking);
        quicksort_device<<<1, 64, 0, s1>>>(arr, low, store_index - 1);
        
        cudaStreamCreateWithFlags(&s2, cudaStreamNonBlocking);
        quicksort_device<<<1, 64, 0, s2>>>(arr, store_index + 1, high);
	} 
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
    gpuErrchk(cudaMemcpy(da, ha, sizeof(int) * size, cudaMemcpyHostToDevice));

    int grid = ceil(size * 1.0 / BLOCK_SIZE);
    quicksort_device<<<grid, BLOCK_SIZE>>>(da, 0, size - 1);
    gpuErrchk(cudaDeviceSynchronize());

    int *hc = (int *)malloc(sizeof(int) * size);
    gpuErrchk(cudaMemcpy(hc, da, sizeof(int) * size, cudaMemcpyDeviceToHost));

    // Testing that sort is working, keep commented out on large values of N (say N > 1000)
    for (int i = 0; i < size; i++)
    {
        printf("\t hc[ %d ] => %d\n", i, hc[i]);
    }
    
    gpuErrchk(cudaFree(da));
    free(ha);

    high_resolution_clock::time_point end = high_resolution_clock::now();
    return time_calc(start, end);
}
