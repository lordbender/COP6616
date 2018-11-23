
#include <stdio.h>
#include <stdlib.h>
#include <time.h>

#include "main_cuda.cuh"

double time_calc(clock_t start, clock_t end)
{
    return ((double)(end - start)) / CLOCKS_PER_SEC;
}

void swap(int array[], int left, int right)
{
	int temp;
	temp = array[left];
	array[left] = array[right];
	array[right] = temp;
}

int partition(int array[], int left, int right, int pivot_index)
{
	int pivot_value = array[pivot_index];
	int store_index = left;
	int i;

	swap(array, pivot_index, right);
	for (i = left; i < right; i++)
		if (array[i] <= pivot_value) {
			swap(array, i, store_index);
			++store_index;
		}
	swap(array, store_index, right);
	return store_index;
}

