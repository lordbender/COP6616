#include <stdio.h>
#include <stdlib.h>

#include "main_cuda.h"

static const int BLOCK_SIZE = 256;
static const int N = 16;

// Device code
__global__ void vecSquare(int* a, int* c, int n)
{
	int id = blockIdx.x * blockDim.x + threadIdx.x;
    if (id < n)
        c[id] = a[id] * a[id];
}
            
// Host code
int main()
{
	int *ha, *hc, *da, *dc;
	printf("Starting on size %d!!!\n", N);

    ha = new int[N];
    hc = new int[N];

	for (int i = 0; i < N; i++)
    {
		ha[i] = i + i;
		hc[i] = 0;
	}

	gpuErrchk(cudaMalloc((void**) &da, sizeof(int) * N));
	gpuErrchk(cudaGetLastError());

	gpuErrchk(cudaMalloc((void**) &dc, sizeof(int) * N));
	gpuErrchk(cudaGetLastError());
   
    gpuErrchk(cudaMemcpy(da, ha,  sizeof(int) * N, cudaMemcpyHostToDevice));
	gpuErrchk(cudaGetLastError());

    int grid = ceil(N * 1.0 / BLOCK_SIZE);
    vecSquare<<<grid, BLOCK_SIZE>>>(da, dc, N);
	cudaDeviceSynchronize();
	gpuErrchk(cudaGetLastError());

	cudaMemcpy(ha, dc, sizeof(int) * N, cudaMemcpyDeviceToHost);

    cudaFree(da);
	cudaFree(dc);
	
 	for (int i = 0; i < N; i++) {
		printf("\tCool Story %d\n", hc[i]);
	}

	free(ha);
	free(hc);
	
	cudaDeviceReset();

	printf("Done!!!\n\n");
}