
#include <stdio.h>
#include <stdlib.h>
#include <ctime>
#include <ratio>
#include <chrono>
#include "main_cuda.cuh"

using namespace std::chrono;

duration<double> time_calc(high_resolution_clock::time_point start, high_resolution_clock::time_point end)
{
    return duration_cast<duration<double>>(end - start);
}

int getMax(int *arr, int n) 
{ 
    int mx = arr[0]; 
    for (int i = 1; i < n; i++) 
        if (arr[i] > mx) 
            mx = arr[i]; 
    return mx; 
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

