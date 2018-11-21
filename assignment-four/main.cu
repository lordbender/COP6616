#include <stdio.h>
#include <stdlib.h>
#include <time.h>

#include "main_cuda.h"

static const int BLOCK_SIZE = 256;

// Device code
__global__ void vecSquare(int* a, int* c, int n)
{
	int id = blockIdx.x * blockDim.x + threadIdx.x;
    if (id < n)
        c[id] = a[id] * a[id];
}
            
// Host code
double time_calc(clock_t start, clock_t end)
{
    return ((double)(end - start)) / CLOCKS_PER_SEC;
}
int main(int argc, char *argv[])
{
  	srand(time(0));

 	int size = atoi(argv[1]);

	int *ha, *hc, *da, *dc;
	printf("Starting on size %d!!!\n", size);

    ha = new int[size];
    hc = new int[size];

	for (int i = 0; i < size; i++)
    {
		ha[i] = i + i;
		hc[i] = 0;
	}

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

 	for (int i = 0; i < size; i++) {
		printf("\tCool Story %d\n", hc[i]);
	}

	free(ha);
	free(hc);
	
	cudaDeviceReset();

	printf("Completed in %f seconds!!!\n\n", time_calc(start, end));
}