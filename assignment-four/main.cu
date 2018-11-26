#include <stdio.h>
#include <stdlib.h>
#include <ctime>
#include <ratio>
#include <chrono>

#include "main_cuda.cuh"

using namespace std::chrono;
 
int main(int argc, char *argv[])
{
  	srand(time(0));

 	int size = atoi(argv[1]);

	duration<double> cpu_radix_runtime = radixsort_cpu(size);
	printf("\n\n\tCPU O(n*log(n)) Sequential Radix: Completed %d numbers in %f seconds!!!\n", size, cpu_radix_runtime.count());
	   
	// duration<double> gpu_radix_runtime = radixsort_gpu(size);
	// printf("\tGPU O(n*log(n)) Streamed Radix: Completed %d numbers in %f seconds!!!\n\n", size, gpu_radix_runtime.count());

	duration<double> cpu_runtime = quicksort_cpu(size);
	printf("\tCPU O(n*log(n)) Sequential Quicksort: Completed %d numbers in %f seconds!!!\n", size, cpu_runtime.count());

	duration<double> cpu_threads_runtime = quicksort_cpu_threads(size);
	printf("\tCPU O(n*log(n)) Threaded Quicksort: Completed %d numbers in %f seconds!!!\n", size, cpu_threads_runtime.count());
	
	duration<double> gpu_streams_runtime = quicksort_gpu_streams(size);
	printf("\tGPU O(n*log(n)) Streamed: Completed %d numbers in %f seconds!!!\n\n", size, gpu_streams_runtime.count());
}