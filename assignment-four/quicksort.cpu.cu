#include <stdio.h>
#include <stdlib.h>
#include <time.h>

#include "main_cuda.cuh"

void quicksort(int arr[], int low, int high) 
{ 
	int pivot_index = low;

	if (low < high) 
	{ 
		int pi = partition(arr, low, high, pivot_index); 

		quicksort(arr, low, pi - 1); 
		quicksort(arr, pi + 1, high); 
	} 
} 

double quicksort_cpu(int size) {
	int *ha = (int*)malloc(sizeof(int) * size);
  
	for (int i = 0; i < size; i++)
	{
		ha[i] = rand();
	}

	clock_t start = clock();
	quicksort(ha, 0, size - 1);
	clock_t end= clock();

	// Testing that sort is working, keep commented out on large values of N (say N > 1000)
	// for (int i = 0; i < size; i++) {
    // 	printf("\t %d\n", ha_seq[i]);
	// }

	return time_calc(start, end);
}