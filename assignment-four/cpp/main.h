#include <stdio.h>
#include <ctime>
#include <ratio>
#include <chrono>

using namespace std::chrono;

// Actual Benchmarking Functions
duration<double> quicksort_cpu(int size);
duration<double> quicksort_cpu_threads(int size);
duration<double> radixsort_cpu(int size);

// Shared Functions
duration<double> time_calc(high_resolution_clock::time_point start, high_resolution_clock::time_point end);
void swap(int array[], int left, int right);
int partition(int array[], int left, int right, int pivot_index);
void quicksort(int arr[], int low, int high); 
int getMax(int *arr, int n);
