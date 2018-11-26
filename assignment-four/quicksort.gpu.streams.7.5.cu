// // http://on-demand.gputechconf.com/gtc/2014/presentations/S4158-cuda-streams-best-practices-common-pitfalls.pdf
// #include <stdio.h>
// #include <stdlib.h>
// #include <ctime>
// #include <ratio>
// #include <chrono>
// #include <vector>

// #include "main_cuda.cuh"

// using namespace std::chrono;

// static const int BLOCK_SIZE = 256;

// __global__ void quicksort_device(int *array, int left, int right) {
//     // do the work!!!

//     return;
// }

// void quicksort_host(int *ha, int left, int right, int size, int depth)
// {
//     if (right > left)
//     {
//         int pivotIndex = left + (right - left)/2;
//         pivotIndex = partition(ha, left, right, pivotIndex);

//         int new_right = pivotIndex - 1;
//         int new_left = pivotIndex + 1;
        
//         if (depth-- > 0)
//         {
//             int *da;

//             gpuErrchk(cudaMalloc((void **)&da, sizeof(int) * size));
//             gpuErrchk(cudaGetLastError());
        
//             gpuErrchk(cudaMemcpy(da, ha, sizeof(int) * size, cudaMemcpyHostToDevice));
//             gpuErrchk(cudaGetLastError());

//             int grid = ceil(size * 1.0 / BLOCK_SIZE);

//             quicksort_device<<<grid, BLOCK_SIZE>>>(da, left, new_right);
//             quicksort_device<<<grid, BLOCK_SIZE>>>(da, new_left, right);

//             cudaDeviceSynchronize();
//             gpuErrchk(cudaGetLastError());

//             cudaMemcpy(ha, da, sizeof(int) * size, cudaMemcpyDeviceToHost);

//             cudaFree(da);
//             cudaDeviceReset();
//         }
//         else
//         {
//             quicksort(ha, left, new_right);
//             quicksort(ha, new_left, right);
//         }
//     }
// }

// duration<double> quicksort_gpu_streams(int size)
// {
//     int *ha  = (int *)malloc(sizeof(int) * size);

//     for (int i = 0; i < size; i++)
//     {
//         ha[i] = rand();
//     }

//     high_resolution_clock::time_point start = high_resolution_clock::now();
//     quicksort_host(ha, 0, size - 1, size, 5);    
//     high_resolution_clock::time_point end = high_resolution_clock::now();

//     free(ha);

//     // Testing that sort is working, keep commented out on large values of N (say N > 1000)
//     // for (int i = 0; i < size; i++)
//     // {
//     //     printf("\t %d\n", ha[i]);
//     // }

//     return time_calc(start, end);
// }

// // void quicksort_host(int *da, int left, int right, int size)
// // {
// // 	// int pivot_index = left;
// //     // int pivot_new_index = partition(da, left, right, pivot_index);
    
// //     // int new_right = pivot_new_index - 1;
// //     // int new_left = pivot_new_index + 1;

// //     // Create a thread pool on the GPU
// //     // Use Streams to Parallelize on the GPU tobreduce copy footprint.
// //     cudaStream_t s1, s2;
// //     cudaStreamCreateWithFlags(&s1, cudaStreamNonBlocking);
// //     cudaStreamCreateWithFlags(&s2, cudaStreamNonBlocking);

// //     // split up the work so we can thread it!!!
// //     int *db = (int*)malloc(sizeof(int) * 1);
// //     int *dc = (int*)malloc(sizeof(int) * 1);

// //     // partition based on the pivot;
// //     int grid = ceil(size * 1.0 / BLOCK_SIZE);
// //     quicksort_device<<<grid, BLOCK_SIZE, 0, s1>>>(db);
// //     quicksort_device<<<grid, BLOCK_SIZE, 0, s2>>>(dc);

// // 	cudaStreamSynchronize(0);
// //     gpuErrchk(cudaGetLastError());

// //     // Clean up the thread pool.
// //     cudaStreamDestroy(s1);
// //     cudaStreamDestroy(s2);
// // }