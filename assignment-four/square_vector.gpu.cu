// // This is a good place to start looking to 
// // grasp teh basics.

// #include <stdio.h>
// #include <stdlib.h>
// #include <time.h>

// #include "main_cuda.cuh"

// static const int BLOCK_SIZE = 256;

// // Device Portion of Quick Sort
// __global__ void vecSquare(int *a, int *c, int n)
// {
//     int id = blockIdx.x * blockDim.x + threadIdx.x;
//     if (id < n)
//         c[id] = a[id] * a[id];
// }

// // Device Portion of Quick Sort
// double square_vector_gpu(int size)
// {
//     int *ha, *hc, *da, *dc;

//     ha = (int *)malloc(sizeof(int) * size);
//     hc = (int *)malloc(sizeof(int) * size);

//     for (int i = 0; i < size; i++)
//     {
//         ha[i] = rand();
//         hc[i] = 0;
//     }

//     clock_t start = clock();

//     gpuErrchk(cudaMalloc((void **)&da, sizeof(int) * size));
//     gpuErrchk(cudaGetLastError());

//     gpuErrchk(cudaMalloc((void **)&dc, sizeof(int) * size));
//     gpuErrchk(cudaGetLastError());

//     gpuErrchk(cudaMemcpy(da, ha, sizeof(int) * size, cudaMemcpyHostToDevice));
//     gpuErrchk(cudaGetLastError());

//     int grid = ceil(size * 1.0 / BLOCK_SIZE);
//     vecSquare<<<grid, BLOCK_SIZE>>>(da, dc, size);
//     cudaDeviceSynchronize();
//     gpuErrchk(cudaGetLastError());

//     cudaMemcpy(hc, dc, sizeof(int) * size, cudaMemcpyDeviceToHost);

//     cudaFree(da);
//     cudaFree(dc);
//     cudaDeviceReset();

//     free(ha);
//     free(hc);

//     clock_t end = clock();

//     // Testing that sort is working, keep commented out on large values of N (say N > 1000)
//     // for (int i = 0; i < size; i++) {
//     // 	printf("\t %d\n", hc[i]);
//     // }

//     return time_calc(start, end);
// }
