#include <stdio.h>
#include <stdlib.h>

#include "main_cuda.cuh"

const int N = 1 << 20;

__global__ void kernel(int *x, int n)
{
    int tid = threadIdx.x + blockIdx.x * blockDim.x;
    for (int i = tid; i < n; i += blockDim.x * gridDim.x) {
        x[i] = sqrt(pow(3.14159,i));
    }
}

int stream_support_test()
{
    const int size = 8;

    cudaStream_t streams[size];
    int *da = (int*) malloc(sizeof(int) * size);

    for (int i = 0; i < size; i++) {
        gpuErrchk(cudaStreamCreate(&streams[i]));
        gpuErrchk(cudaGetLastError());

        gpuErrchk(cudaMalloc((void **)&da, sizeof(int) * size));
        gpuErrchk(cudaGetLastError());

        // launch one worker kernel per stream
        kernel<<<1, 64, 0, streams[i]>>>(da, N);
        gpuErrchk(cudaGetLastError());

        // launch a dummy kernel on the default stream
        kernel<<<1, 1>>>(0, 0);
        gpuErrchk(cudaGetLastError());
    }

    cudaDeviceReset();

    for (int i = 0; i < size; i++){
        printf("data point %d", da[i]);
    }

    return 0;
}