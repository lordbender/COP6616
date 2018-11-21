// Device code
__global__ void VecAdd(long* A, long* B, long* C, int N)
{
    int i = blockDim.x * blockIdx.x + threadIdx.x;
    if (i < N)
        C[i] = A[i] + B[i];
}
            
// Host code
int main()
{
    int N = 1000;
    size_t size = N * sizeof(long);

    // Allocate input vectors h_A and h_B in host memory
    long* h_A = (long*)malloc(size);
    long* h_B = (long*)malloc(size);
    long* h_C = (long*)malloc(size);

	for (int i = 0; i < size; ++i)
    {
		h_A[i] = i + i;
		h_B[i] = i - i;
		h_C[i] = 0;
	}

    // Allocate vectors in device memory
    long* d_A;
    cudaMalloc(&d_A, size);
    long* d_B;
    cudaMalloc(&d_B, size);
    long* d_C;
    cudaMalloc(&d_C, size);

    // Copy vectors from host memory to device memory
    cudaMemcpy(d_A, h_A, size, cudaMemcpyHostToDevice);
    cudaMemcpy(d_B, h_B, size, cudaMemcpyHostToDevice);

    // Invoke kernel
    int threadsPerBlock = 256;
    int blocksPerGrid =
            (N + threadsPerBlock - 1) / threadsPerBlock;
    VecAdd<<<blocksPerGrid, threadsPerBlock>>>(d_A, d_B, d_C, N);

    // Copy result from device memory to host memory
    // h_C contains the result in host memory
    cudaMemcpy(h_C, d_C, size, cudaMemcpyDeviceToHost);

    // Free device memory
    cudaFree(d_A);
    cudaFree(d_B);
    cudaFree(d_C);
 
}