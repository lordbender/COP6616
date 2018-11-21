#include <stdio.h>
#include "main_cuda.h"

#define N 16

// Device code
__global__ void VecSquare(float* A, float* C, int size)
{
    int i = blockDim.x * blockIdx.x + threadIdx.x;
    if (i < size)
        C[i] = A[i] * A[i];
}
            
// Host code
int main()
{
	size_t size = N;

	printf("Starting on size %d!!!\n", N);

    float* host_A = (float*)malloc(N);
    float* host_C = (float*)malloc(N);

	for (int i = 0; i < N; i++)
    {
		host_A[i] = (float)(i + i);
		host_C[i] = 0.0;
	}

	printf("Working Arrays Created\n");

    float* device_A;
	cudaError_t cudaMalloc(void** &device_A, size);
	printf("Cuda device_A Memory Allocated\n");

	// float* device_C;
	// cudaMalloc((void**)&device_C, N);
	// printf("Cuda device_C Memory Allocated\n");

	// printf("Cuda Memory Allocated\n");

    // // Copy vector from host memory to device memory
    // cudaMemcpy(device_A, host_A, N, cudaMemcpyHostToDevice);

	// printf("Cuda Data Copy Completed\n");

    // // Invoke kernel
    // int threadsPerBlock = 256;
    // int blocksPerGrid =
	// 		(N + threadsPerBlock - 1) / threadsPerBlock;
			
    // VecSquare<<<blocksPerGrid, threadsPerBlock>>>(device_A, device_C, N);

	// cudaPeekAtLastError();
	// cudaDeviceSynchronize();

	// cudaMemcpy(host_C, device_C, N, cudaMemcpyDeviceToHost);
	
    // Free device memory
    cudaFree(device_A);
	// cudaFree(device_C);
	
 	// for (int i = 0; i < N; i++){
	// 	printf("\tCool Story %f\n", host_C[i]);
	// }

	free(host_A);
	free(host_C);
	
	printf("Done!!!\n");
}