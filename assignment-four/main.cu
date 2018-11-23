#include <stdio.h>
#include <stdlib.h>
#include <time.h>

#include "main_cuda.cuh"
 
// See: https://devblogs.nvidia.com/gpu-pro-tip-cuda-7-streams-simplify-concurrency/
int main(int argc, char *argv[])
{
  	srand(time(0));

 	int size = atoi(argv[1]);

    /* ------------------------ Begin CPU Sequential Benchmarking ------------------------ */
	
	double cpu_runtime = quicksort_cpu(size);
	printf("\n\tCPU O(n*log(n)) Sequential: Completed %d numbers in %f seconds!!!\n", size, cpu_runtime);

	/* ------------------------ End CPU Sequential Benchmarking ------------------------ */


	/* ------------------------ Begin CPU Parallel Benchmarking ------------------------ */

	double cpu_threads_runtime = quicksort_cpu_threads(size);
	printf("\tCPU O(n*log(n)) Threaded: Completed %d numbers in %f seconds!!!\n\n", size, cpu_threads_runtime);
	
	/* ------------------------ END GPU Parallel Benchmarking ------------------------ */

	
	/* ------------------------ Begin GPU Parallel Benchmarking ------------------------ */

	double gpu_streams_runtime = quicksort_gpu_streams(size);
	printf("\tGPU O(n*log(n)) Streamed: Completed %d numbers in %f seconds!!!\n\n", size, gpu_streams_runtime);
	
	/* ------------------------ END GPU Parallel Benchmarking ------------------------ */
}