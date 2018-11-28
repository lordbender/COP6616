// #include <stdio.h>

// #define gpuErrchk(ans) { gpuAssert((ans), __FILE__, __LINE__); }
// inline void gpuAssert(cudaError_t code, const char *file, int line, bool abort=true)
// {
//    if (code != cudaSuccess) 
//    {
//       fprintf(stderr,"GPUassert: %s %s %d\n", cudaGetErrorString(code), file, line);
//       if (abort) exit(code);
//    }
// }

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

// // Based on CUDA Examples - But Optimized
// __global__ void quicksort_device(int *data, int left, int right)
// { 
//     cudaStream_t s1, s2;
//     int pi = partition_device(data, left, right);

//     int nright = pi - 1;
//     int nleft = pi + 1;

//     if (left < nright)
//     {
//         cudaStreamCreateWithFlags(&s1, cudaStreamNonBlocking);
//         quicksort_device<<<1, 32, 0, s1>>>(data, left, nright);
//     }

//     if (nleft < right)
//     {
//         cudaStreamCreateWithFlags(&s2, cudaStreamNonBlocking);
//         quicksort_device<<<1, 32, 0, s2>>>(data, nleft, right);
//     }
// }

// void quicksort_host(int *da, int *hc, int size)
// {
//     // Call the device.
//     int grid = ceil(size * 1.0 / BLOCK_SIZE);
//     quicksort_device<<<grid, BLOCK_SIZE>>>(da, 0, size - 1);
//     gpuErrchk(cudaGetLastError());

//     // Ensure the Device is in sync, before we copy the data back!
//     gpuErrchk(cudaDeviceSynchronize());
//     gpuErrchk(cudaGetLastError());

//     // Copy the results back from the device.
//     gpuErrchk(cudaMemcpy(hc, da, sizeof(int) * size, cudaMemcpyDeviceToHost));
//     gpuErrchk(cudaGetLastError());

//     // Testing that sort is working, keep commented out on large values of N (say N > 1000)
//     // for (int i = 0; i < size; i++)
//     // {
//     //     printf("\t %d\n", hc[i]);
//     // }
// }

// int main(int argc, char *argv[])
// {
//     cudaEvent_t start, stop;
//     cudaEventCreate(&start);
//     cudaEventCreate(&stop);

//   	srand(time(0));

//  	int size = atoi(argv[1]);

//     int* ha = (int *)malloc(sizeof(int) * size);
//     int* hc = (int *)malloc(sizeof(int) * size);

//     for (int i = 0; i < size; i++)
//     {
//         ha[i] = rand();
//         hc[i] = 0;
//     }

//     int *da;
//     gpuErrchk(cudaMalloc((void **)&da, sizeof(int) * size));
//     gpuErrchk(cudaMemcpy(da, ha, sizeof(int) * size, cudaMemcpyHostToDevice));
//     gpuErrchk(cudaGetLastError());

//     // Kick off the sort!
//     quicksort_host(da, hc, size);

//     gpuErrchk(cudaFree(da));
//     free(ha);
//     free(hc);
    
//     cudaEventSynchronize(stop);
//     float milliseconds = 0;
//     cudaEventElapsedTime(&milliseconds, start, stop);

// 	printf("\tGPU O(n*log(n)) Streamed: Completed %d numbers in %f seconds!!!\n\n", size, milliseconds);
// }
