#include <stdio.h>
#include <stdlib.h>

#include "main_cuda.h"

static const int BLOCK_SIZE = 256;
static const int N = 10;

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
	printf("Starting on size %d!!!\n", N);

    int* host_A = (int*)malloc(N * sizeof(int*));
    int* host_C = (int*)malloc(N* sizeof(int*));

	for (int i = 0; i < N; i++)
    {
		host_A[i] = i + i;
		host_C[i] = 0.0;
	}

    int* device_A;
	gpuErrchk(cudaMalloc((void**) &device_A, sizeof(int) * N));
	gpuErrchk(cudaGetLastError());

	int* device_C;
	gpuErrchk(cudaMalloc((void**) &device_C, sizeof(int) * N));
	gpuErrchk(cudaGetLastError());
   
    gpuErrchk(cudaMemcpy(device_A, host_A, N, cudaMemcpyHostToDevice));
	gpuErrchk(cudaGetLastError());

    int grid = ceil(N * 1.0 / BLOCK_SIZE);
    vecSquare<<<grid, BLOCK_SIZE>>>(device_A, device_C, N);
	cudaDeviceSynchronize();
	gpuErrchk(cudaGetLastError());

	cudaMemcpy(host_C, device_C, sizeof(int) * N, cudaMemcpyDeviceToHost);

    cudaFree(device_A);
	cudaFree(device_C);
	
 	for (int i = 0; i < N; i++) {
		printf("\tCool Story %d\n", host_C[i]);
	}

	free(host_A);
	free(host_C);
	
	cudaDeviceReset();

	printf("Done!!!\n\n");
}