#include <iostream>
#include <cstdio>
#define gpuErrchk(ans) { gpuAssert((ans), __FILE__, __LINE__); }
inline void gpuAssert(cudaError_t code, const char *file, int line, bool abort=true)
{
   if (code != cudaSuccess) 
   {
      fprintf(stderr,"GPUassert: %s %s %d\n", cudaGetErrorString(code), file, line);
      if (abort) exit(code);
   }
}

#define MAX_DEPTH       32
#define INSERTION_SORT  64

__device__ void selection_sort(unsigned int *data, int left, int right)
{
    for (int i = left ; i <= right ; ++i)
    {
        unsigned min_val = data[i];
        int min_idx = i;

        for (int j = i+1 ; j <= right ; ++j)
        {
            unsigned val_j = data[j];

            if (val_j < min_val)
            {
                min_idx = j;
                min_val = val_j;
            }
        }

        if (i != min_idx)
        {
            data[min_idx] = data[i];
            data[i] = min_val;
        }
    }
}

__global__ void quicksort_gpu(unsigned int *data, int left, int right, int depth)
{
    if (depth >= MAX_DEPTH || right-left <= INSERTION_SORT)
    {
        selection_sort(data, left, right);
        return;
    }

    unsigned int *lptr = data+left;
    unsigned int *rptr = data+right;
    unsigned int  pivot = data[(left+right)/2];

    // Do the partitioning.
    while (lptr <= rptr)
    {
        unsigned int lval = *lptr;
        unsigned int rval = *rptr;

        while (lval < pivot)
        {
            lptr++;
            lval = *lptr;
        }

        while (rval > pivot)
        {
            rptr--;
            rval = *rptr;
        }

        if (lptr <= rptr)
        {
            *lptr++ = rval;
            *rptr-- = lval;
        }
    }

    int nright = rptr - data;
    int nleft  = lptr - data;

    if (left < (rptr-data))
    {
        cudaStream_t s;
        cudaStreamCreateWithFlags(&s, cudaStreamNonBlocking);
        quicksort_gpu<<< 1, 1, 0, s >>>(data, left, nright, depth+1);
        cudaStreamDestroy(s);
    }

    if ((lptr-data) < right)
    {
        cudaStream_t s1;
        cudaStreamCreateWithFlags(&s1, cudaStreamNonBlocking);
        quicksort_gpu<<< 1, 1, 0, s1 >>>(data, nleft, right, depth+1);
        cudaStreamDestroy(s1);
    }
}

double run_sort(unsigned int *data, unsigned int size)
{
    cudaEvent_t start, stop;
    cudaEventCreate(&start);
    cudaEventCreate(&stop);

    int left = 0;
    int right = size-1;
    cudaEventRecord(start);
    int grid = ceil(size * 1.0 / 256);
    quicksort_gpu<<< grid, 256 >>>(data, left, right, 0);
    cudaEventRecord(stop);
    // gpuErrchk(cudaGetLastError());

    cudaDeviceSynchronize();
    
    cudaEventSynchronize(stop);
    float milliseconds = 0;
    cudaEventElapsedTime(&milliseconds, start, stop);

    return milliseconds;
}

int main(int argc, char **argv)
{
    srand(time(0));

    int size = atoi(argv[1]);

    unsigned int *da = 0;

    unsigned int *ha =(unsigned int *)malloc(size*sizeof(unsigned int));
    for (unsigned i = 0 ; i < size ; i++)
        ha[i] = rand() % size;
       
    cudaMalloc((void **)&da, size * sizeof(unsigned int));
    cudaMemcpy(da, ha, size * sizeof(unsigned int), cudaMemcpyHostToDevice);

    double time = run_sort(da, size);

    unsigned int *results = new unsigned[size];
    cudaMemcpy(results, da, size*sizeof(unsigned), cudaMemcpyDeviceToHost);
        
    // printf("\n");
    // for (int i = 1 ; i < size ; ++i)
    //     printf("\t%d", results[i]);
    // printf("\n");
    
    cudaFree(da);
    cudaDeviceReset();
    free(ha);
    delete[] results;
    
    printf("\tCPU O(n*log(n)) GPU Quicksort: Completed %d numbers in %f seconds!!!\n", size, (time / 1000.0));

    exit(EXIT_SUCCESS);
}

