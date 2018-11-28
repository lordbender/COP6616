#include <iostream>
#include <cstdio>
#include <ctime>

#define gpuErrchk(ans) { gpuAssert((ans), __FILE__, __LINE__); }
inline void gpuAssert(cudaError_t code, const char *file, int line, bool abort=true)
{
   if (code != cudaSuccess) 
   {
      fprintf(stderr,"GPUassert: %s %s %d\n", cudaGetErrorString(code), file, line);
      if (abort) exit(code);
   }
}

__global__ void quicksort_gpu(unsigned int *data, int left, int right)
{
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
        quicksort_gpu<<< 1, 1, 0, s >>>(data, left, nright);
        cudaStreamDestroy(s);
    }

    if ((lptr-data) < right)
    {
        cudaStream_t s1;
        cudaStreamCreateWithFlags(&s1, cudaStreamNonBlocking);
        quicksort_gpu<<< 1, 1, 0, s1 >>>(data, nleft, right);
        cudaStreamDestroy(s1);
    }
}

int main(int argc, char **argv)
{
    srand(time(0));
    int size = atoi(argv[1]);

    unsigned int *ha =(unsigned int *)malloc(size*sizeof(unsigned int));
    unsigned int *da = 0;

    for (unsigned i = 0 ; i < size ; i++)
        ha[i] = rand() % size;

    std::clock_t start = std::clock();  

    cudaMalloc((void **)&da, size * sizeof(unsigned int));
    cudaMemcpy(da, ha, size * sizeof(unsigned int), cudaMemcpyHostToDevice);

    int left = 0;
    int right = size-1;

    quicksort_gpu<<< 1, 32 >>>(da, left, right);
    gpuErrchk(cudaGetLastError());
    cudaDeviceSynchronize();

    unsigned int *results = new unsigned[size];
    cudaMemcpy(results, da, size*sizeof(unsigned), cudaMemcpyDeviceToHost);
        
    double duration = ( std::clock() - start ) / (double) CLOCKS_PER_SEC;

    // printf("\n");
    // for (int i = 1 ; i < size ; ++i)
    //     printf("\t%d", results[i]);
    // printf("\n");
    
    cudaFree(da);
    cudaDeviceReset();
    free(ha);
    delete[] results;
    
    printf("\tGPU O(n*log(n)) GPU Quicksort: Completed %d numbers in %f seconds!!!\n", size, duration);

    exit(EXIT_SUCCESS);
}

