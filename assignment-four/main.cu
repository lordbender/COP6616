#include <stdio.h>
#include "main_cuda.h"

#define N 1000

#define gpuErrchk(ans) { gpuAssert((ans), __FILE__, __LINE__); }
inline void gpuAssert(cudaError_t code, const char *file, int line, bool abort=true)
{
   if (code != cudaSuccess) 
   {
      fprintf(stderr,"GPUassert: %s %s %d\n", cudaGetErrorString(code), file, line);
      if (abort) exit(code);
   }
}

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

	printf("Starting on size %d!!!\n", N);

    float* h_A = (float*)malloc(N);
    float* h_C = (float*)malloc(N);

	for (int i = 0; i < N; i++)
    {
		h_A[i] = (float)(i + i);
		h_C[i] = 0.0;
	}
	printf("Working Arrays Created\n");

    float* d_A;
	gpuErrchk(cudaMalloc(&d_A, N));
	
	float* d_C;
	gpuErrchk(cudaMalloc(&d_C, N));

	printf("Cuda Memory Allocated\n");

    // Copy vector from host memory to device memory
    gpuErrchk(cudaMemcpy(d_A, h_A, N, cudaMemcpyHostToDevice));

	printf("Cuda Data Copy Completed\n");

    // Invoke kernel
    int threadsPerBlock = 256;
    int blocksPerGrid =
			(N + threadsPerBlock - 1) / threadsPerBlock;
			
    VecSquare<<<blocksPerGrid, threadsPerBlock>>>(d_A, d_C, N);

	gpuErrchk( cudaPeekAtLastError() );
	gpuErrchk( cudaDeviceSynchronize() );

	cudaMemcpy(h_C, d_C, N, cudaMemcpyDeviceToHost);
	


    // Free device memory
    cudaFree(d_A);
	cudaFree(d_C);
	
 	for (int i = 0; i < N; i++){
		printf("\tCool Story %f\n", h_C[i]);
	}

	free(h_A);
	free(h_C);
	
	printf("Done!!!\n");
}