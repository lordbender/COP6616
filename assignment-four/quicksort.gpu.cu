// #include <stdio.h>
// #include <stdlib.h>
// #include <time.h>

// #include "main_cuda.cuh"

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
