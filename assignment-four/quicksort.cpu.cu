#include <stdio.h>
#include <stdlib.h>
#include <time.h>

#include "main_cuda.cuh"
 
void swap(int* a, int* b) 
{ 
	int t = *a; 
	*a = *b; 
	*b = t; 
} 

int partition (int arr[], int low, int high) 
{ 
	int pivot = arr[high]; // pivot 
	int i = (low - 1); // Index of smaller element 

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

void quicksort(int arr[], int low, int high) 
{ 
	if (low < high) 
	{ 
		int pi = partition(arr, low, high); 

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