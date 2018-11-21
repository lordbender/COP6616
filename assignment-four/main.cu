#include <stdio.h>
#include <stdlib.h>

#include "main_cuda.h"

static const int BLOCK_SIZE = 256;
static const int N = 10;

// Device code
__global__ void vecSquare(float* a, float* c, int n)
{
	int id = blockIdx.x * blockDim.x + threadIdx.x;
    if (id < n)
        c[id] = a[id] * a[id];
}
            
// Host code
int main()
{
	printf("Starting on size %d!!!\n", N);

    float* host_A = (float*)malloc(N * sizeof(float*));
    float* host_C = (float*)malloc(N* sizeof(float*));

	for (int i = 0; i < N; i++)
    {
		host_A[i] = (float)(i + i);
		host_C[i] = 0.0;
	}

	printf("Working Arrays Created\n");

    float* device_A;
	gpuErrchk(cudaMalloc((void**) &device_A, sizeof(float) * N));
	printf("Cuda device_A Memory Allocated\n");

	gpuErrchk(cudaGetLastError());

	float* device_C;
	gpuErrchk(cudaMalloc((void**) &device_C, sizeof(float) * N));
	printf("Cuda device_C Memory Allocated\n");

	gpuErrchk(cudaGetLastError());

	printf("Cuda Memory Allocated\n");

    // Copy vector from host memory to device memory
    gpuErrchk(cudaMemcpy(device_A, host_A, N, cudaMemcpyHostToDevice));

	printf("Cuda Data Copy Completed\n");

    // Invoke kernel
    int grid = ceil(N * 1.0 / BLOCK_SIZE);
    vecSquare<<<grid, BLOCK_SIZE>>>(device_A, device_C, N);

	cudaDeviceSynchronize();

	gpuErrchk(cudaGetLastError());

	// Copy the result back from the device to the host.
	cudaMemcpy(host_C, device_C, sizeof(float) * N, cudaMemcpyDeviceToHost);
	
    // Free device memory
    cudaFree(device_A);
	cudaFree(device_C);
	
 	for (int i = 0; i < N; i++) {
		printf("\tCool Story %f\n", host_C[i]);
	}

	free(host_A);
	free(host_C);
	
	cudaDeviceReset();

	printf("Done!!!\n\n");
}