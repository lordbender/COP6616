// #include <stdio.h>
// #include <stdlib.h>
// #include <time.h>

// #include "main_cuda.cuh"

// static const int BLOCK_SIZE = 256;

// __device__ void swap_device(int *a, int *b)
// {
//     int t = *a;
//     *a = *b;
//     *b = t;
// }

// __device__ int partition_device(int *arr, int low, int high)
// {
//     int pivot = arr[high];
//     int i = (low - 1);

//     for (int j = low; j <= high - 1; j++)
//     {
//         if (arr[j] <= pivot)
//         {
//             i++;
//             swap_device(&arr[i], &arr[j]);
//         }
//     }
//     swap_device(&arr[i + 1], &arr[high]);
//     return (i + 1);
// }

// __global__ void quicksort_device(int *data, int left, int right)
// {
//     cudaStream_t s1, s2;

//     int pi = partition_device(data, left, right);

//     int nright = pi - 1;
//     int nleft = pi + 1;

//     if (left < nright)
//     {
//         cudaStreamCreateWithFlags(&s1, cudaStreamNonBlocking);
//         quicksort_device<<<1, 64, 0, s1>>>(data, left, nright);
//     }

//     if (nleft < right)
//     {
//         cudaStreamCreateWithFlags(&s2, cudaStreamNonBlocking);
//         quicksort_device<<<1, 64, 0, s2>>>(data, nleft, right);
//     }

//     return;
// }

// double quicksort_gpu_streams(int size)
// {
//     int *ha, *da;

//     ha = (int *)malloc(sizeof(int) * size);

//     for (int i = 0; i < size; i++)
//     {
//         ha[i] = rand();
//     }

//     clock_t start = clock();

//     gpuErrchk(cudaMalloc((void **)&da, sizeof(int) * size));
//     gpuErrchk(cudaGetLastError());

//     gpuErrchk(cudaMemcpy(da, ha, sizeof(int) * size, cudaMemcpyHostToDevice));
//     gpuErrchk(cudaGetLastError());

//     int grid = ceil(size * 1.0 / BLOCK_SIZE);

//     quicksort_device<<<grid, BLOCK_SIZE>>>(da, 0, size - 1);

// 	cudaStreamSynchronize(0);
//     gpuErrchk(cudaGetLastError());

//     cudaMemcpy(ha, da, sizeof(int) * size, cudaMemcpyDeviceToHost);

//     cudaFree(da);
//     cudaDeviceReset();

//     free(ha);

//     clock_t end = clock();
//     return time_calc(start, end);
// }