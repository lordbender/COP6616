#include <stdio.h>
#include <stdlib.h>
#include <time.h>

#include "main_cuda.cuh"
           
int main(int argc, char *argv[])
{
  	srand(time(0));

 	int size = atoi(argv[1]);

    /* ------------------------ End CPU Sequential Benchmarking ------------------------ */
	
	double cpu_runtime = quicksort_cpu(size);
	printf("\n\tCPU O(n*log(n)): Completed %d numbers in %f seconds!!!\n", size, cpu_runtime);

	/* ------------------------ End CPU Sequential Benchmarking ------------------------ */

	
	/* ------------------------ Begin GPU Parallel Benchmarking Test Case ------------------------ */

	double gpu_runtime_n_operations = square_vector_gpu(size);
	printf("\tGPU O(n): Completed %d numbers in %f seconds!!!\n\n", size, gpu_runtime_n_operations);
	
	/* ------------------------ END GPU Parallel Benchmarking ------------------------ */

	/* ------------------------ Begin GPU Parallel Benchmarking ------------------------ */

	double gpu_runtime = quicksort_gpu(size);
	printf("\tGPU O(n*log(n)): Completed %d numbers in %f seconds!!!\n\n", size, gpu_runtime);
	
	/* ------------------------ END GPU Parallel Benchmarking ------------------------ */
}