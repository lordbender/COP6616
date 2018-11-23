#include <stdio.h>
#include <stdlib.h>
#include <iostream> 
using namespace std; 

#include "main_cuda.cuh"

const int N = 1 << 20;

__global__ void kernel(float *x, int n)
{
    int tid = threadIdx.x + blockIdx.x * blockDim.x;
    for (int i = tid; i < n; i += blockDim.x * gridDim.x) {
        x[i] = sqrt(pow(3.14159,i));
    }
}

int stream_support_test()
{
    const int num_streams = 8;

    cudaStream_t streams[num_streams];
    float *data[num_streams];

    for (int i = 0; i < num_streams; i++) {
        gpuErrchk(cudaStreamCreate(&streams[i]));
        gpuErrchk(cudaGetLastError());

        gpuErrchk(cudaMalloc(&data[i], N * sizeof(float)));
        gpuErrchk(cudaGetLastError());

        // launch one worker kernel per stream
        kernel<<<1, 64, 0, streams[i]>>>(data[i], N);
        gpuErrchk(cudaGetLastError());

        // launch a dummy kernel on the default stream
        kernel<<<1, 1>>>(0, 0);
    }

    cudaDeviceReset();

    for (int i = 0; i < num_streams; i++) {
        cout << data[i] << endl; 
    }

    return 0;
}