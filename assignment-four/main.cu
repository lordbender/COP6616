#include <stdio.h>
#include <stdlib.h>
#include <time.h>

#include "main_cuda.cuh"

static const int BLOCK_SIZE = 256;

// Device code
__global__ void vecSquare(int* a, int* c, int n)
{
	int id = blockIdx.x * blockDim.x + threadIdx.x;
    if (id < n)
        c[id] = a[id] * a[id];
}
            
int main(int argc, char *argv[])
{
  	srand(time(0));

 	int size = atoi(argv[1]);

	int *ha, *ha_seq, *hc, *da, *dc;
	printf("Starting on size %d!!!\n", size);

    ha = (int*)malloc(sizeof(int) * size);
    hc = (int*)malloc(sizeof(int) * size);
    ha_seq = (int*)malloc(sizeof(int) * size);

	// Fill the tet arrays
	for (int i = 0; i < size; i++)
    {
		int rand_num = rand();
		ha[i] = rand_num;
		ha_seq[i] = rand_num;
		hc[i] = 0;
	}

	/* ------------------------ Begin CPU Sequential Benchmarking ------------------------ */

	// Sequential For Benchmarking
	clock_t start_seq = clock();
	quickSort(ha_seq, 0, size - 1);
	clock_t end_seq = clock();

	// Testing that sort is working, keep commented out on large values of N (say N > 1000)
	// for (int i = 0; i < size; i++) {
    // 	printf("\t %d\n", ha_seq[i]);
	// }
	
	printf("CPU: Completed %d numbers in %f seconds!!!\n\n", size, time_calc(start_seq, end_seq));

	/* ------------------------ End CPU Sequential Benchmarking ------------------------ */

	/* ------------------------ Begin GPU Parallel Benchmarking ------------------------ */
	clock_t start = clock();

	gpuErrchk(cudaMalloc((void**) &da, sizeof(int) * size));
	gpuErrchk(cudaGetLastError());

	gpuErrchk(cudaMalloc((void**) &dc, sizeof(int) * size));
	gpuErrchk(cudaGetLastError());
   
    gpuErrchk(cudaMemcpy(da, ha,  sizeof(int) * size, cudaMemcpyHostToDevice));
	gpuErrchk(cudaGetLastError());

    int grid = ceil(size * 1.0 / BLOCK_SIZE);
    vecSquare<<<grid, BLOCK_SIZE>>>(da, dc, size);
	cudaDeviceSynchronize();
	gpuErrchk(cudaGetLastError());

	cudaMemcpy(hc, dc, sizeof(int) * size, cudaMemcpyDeviceToHost);

    cudaFree(da);
	cudaFree(dc);
	
	clock_t end = clock();

	free(ha);
	free(hc);
	
	cudaDeviceReset();

	// Testing that sort is working, keep commented out on large values of N (say N > 1000)
	// for (int i = 0; i < size; i++) {
    // 	printf("\t %d\n", hc[i]);
	// }
	
	printf("GPU: Completed %d numbers in %f seconds!!!\n\n", size, time_calc(start, end));
	
	/* ------------------------ END GPU Parallel Benchmarking ------------------------ */
}