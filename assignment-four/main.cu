#include <stdio.h>
#include <stdlib.h>
#include <time.h>

#include "main_cuda.cuh"
           
int main(int argc, char *argv[])
{
  	srand(time(0));

 	int size = atoi(argv[1]);

    /* ------------------------ End CPU Sequential Benchmarking ------------------------ */
	
	double cpu_runtime = quickSort_cpu(size);
	printf("\n\tCPU: Completed %d numbers in %f seconds!!!\n", size, cpu_runtime);

	/* ------------------------ End CPU Sequential Benchmarking ------------------------ */

	/* ------------------------ Begin GPU Parallel Benchmarking ------------------------ */

	double gpu_runtime = quickSort_gpu(size);
	printf("\tGPU: Completed %d numbers in %f seconds!!!\n\n", size, gpu_runtime);
	
	/* ------------------------ END GPU Parallel Benchmarking ------------------------ */
}