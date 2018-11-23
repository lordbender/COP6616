#include <stdio.h>
#include <stdlib.h>
#include <time.h>

#include "main_cuda.cuh"

static const int BLOCK_SIZE = 256;

__global__ void swap(int* a, int* b) 
{ 
	int t = *a; 
	*a = *b; 
	*b = t; 
} 

__global__ int partition (int arr[], int low, int high) 
{ 
	int pivot = arr[high];
	int i = (low - 1);

	for (int j = low; j <= high- 1; j++) 
	{ 
		if (arr[j] <= pivot) 
		{ 
			i++;
			swap(&arr[i], &arr[j]); 
		} 
	} 
	swap(&arr[i + 1], &arr[high]); 
	return (i + 1); 
} 

__global__ void quicksort_device(int *data, int left, int right)
{
	int nleft, nright;
	cudaStream_t s1, s2;	

	partition(data, nleft, nright);

	if (left < right){
		cudaStreamCreateWithFlags(&s1, cudaStreamNonBlocking);
		quicksort_device<<< ..., s1 >>> (data, left, right);
	}

	if (nleft < right){
		cudaStreamCreateWithFlags(&s2, cudaStreamNonBlocking);
		quicksort_device<<< ..., s2 >>> (data, nleft, right);
	}

    return;
}

double quicksort_gpu(int size)
{
	int *ha, *da;

    ha = (int *)malloc(sizeof(int) * size);

    for (int i = 0; i < size; i++)
    {
        ha[i] = rand();
    }

    clock_t start = clock();

    gpuErrchk(cudaMalloc((void **)&da, sizeof(int) * size));
    gpuErrchk(cudaGetLastError());

    gpuErrchk(cudaMemcpy(da, ha, sizeof(int) * size, cudaMemcpyHostToDevice));
    gpuErrchk(cudaGetLastError());

	int grid = ceil(size * 1.0 / BLOCK_SIZE);
	
    quicksort_device<<<grid, BLOCK_SIZE>>>(da, 0, size - 1);
    cudaDeviceSynchronize();
    gpuErrchk(cudaGetLastError());

    cudaMemcpy(ha, da, sizeof(int) * size, cudaMemcpyDeviceToHost);

    cudaFree(da);
    cudaDeviceReset();

    free(ha);

    clock_t end = clock();
    return time_calc(start, end);
}