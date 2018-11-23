#include <stdio.h>

#define gpuErrchk(ans)                    \
  {                                       \
    gpuAssert((ans), __FILE__, __LINE__); \
  }
inline void gpuAssert(cudaError_t code, const char *file, int line, bool abort = true)
{
  if (code != cudaSuccess)
  {
    fprintf(stderr, "GPUassert: %s %s %d\n", cudaGetErrorString(code), file, line);
    if (abort)
      exit(code);
  }
}

// Sandboxes and proof of support on device!
double square_vector_gpu(int size);

// Actual Benchmarking Functions
double quicksort_cpu(int size);
double quicksort_cpu_threads(int size);
double quicksort_gpu_streams(int size);

// Shared Functions
double time_calc(clock_t start, clock_t end);
void swap(int array[], int left, int right);
int partition(int array[], int left, int right, int pivot_index);
