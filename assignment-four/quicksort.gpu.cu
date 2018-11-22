#include <stdio.h>
#include <stdlib.h>
#include <time.h>

#include "main_cuda.cuh"

static const int BLOCK_SIZE = 256;

// Device code
__global__ void vecSquare(int* a, int* c, int n)
{
	int id = blockIdx.x * blockDim.x + threadIdx.x;
    if (id < n)
        c[id] = a[id] * a[id];
}

double quickSort_gpu(int size) {
	int *ha, *hc, *da, *dc;

    ha = (int*)malloc(sizeof(int) * size);
	hc = (int*)malloc(sizeof(int) * size);
	
	for (int i = 0; i < size; i++)
	{
		ha[i] = rand();
		hc[i] = 0;
	}

	clock_t start = clock();

	gpuErrchk(cudaMalloc((void**) &da, sizeof(int) * size));
	gpuErrchk(cudaGetLastError());

	gpuErrchk(cudaMalloc((void**) &dc, sizeof(int) * size));
	gpuErrchk(cudaGetLastError());

	gpuErrchk(cudaMemcpy(da, ha,  sizeof(int) * size, cudaMemcpyHostToDevice));
	gpuErrchk(cudaGetLastError());

	int grid = ceil(size * 1.0 / BLOCK_SIZE);
	vecSquare<<<grid, BLOCK_SIZE>>>(da, dc, size);
	cudaDeviceSynchronize();
	gpuErrchk(cudaGetLastError());

	cudaMemcpy(hc, dc, sizeof(int) * size, cudaMemcpyDeviceToHost);

	cudaFree(da);
	cudaFree(dc);
	cudaDeviceReset();

	free(ha);
	free(hc);
	
	clock_t end = clock();

	// Testing that sort is working, keep commented out on large values of N (say N > 1000)
	// for (int i = 0; i < size; i++) {
    // 	printf("\t %d\n", hc[i]);
	// }

	return time_calc(start, end);
}

// // A utility function to swap two elements 
// void swap(int* a, int* b) 
// { 
// 	int t = *a; 
// 	*a = *b; 
// 	*b = t; 
// } 

// /* This function takes last element as pivot, places 
// the pivot element at its correct position in sorted 
// 	array, and places all smaller (smaller than pivot) 
// to left of pivot and all greater elements to right 
// of pivot */
// int partition (int arr[], int low, int high) 
// { 
// 	int pivot = arr[high]; // pivot 
// 	int i = (low - 1); // Index of smaller element 

// 	for (int j = low; j <= high- 1; j++) 
// 	{ 
// 		// If current element is smaller than or 
// 		// equal to pivot 
// 		if (arr[j] <= pivot) 
// 		{ 
// 			i++; // increment index of smaller element 
// 			swap(&arr[i], &arr[j]); 
// 		} 
// 	} 
// 	swap(&arr[i + 1], &arr[high]); 
// 	return (i + 1); 
// } 

// void quickSort_gpu(int arr[], int low, int high) 
// { 
// 	if (low < high) 
// 	{ 
// 		int pi = partition(arr, low, high); 

// 		quickSort(arr, low, pi - 1); 
// 		quickSort(arr, pi + 1, high); 
// 	} 
// } 



// // Driver program to test above functions 
// // int main() 
// // { 

// // 	quickSort(arr, 0, n-1); 
// // 	printf("Sorted array: n"); 
// // 	printArray(arr, n); 
// // 	return 0; 
// // } 
