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

double quicksort_cpu(int size);
int stream_support_test();
double quicksort_gpu(int size);
double square_vector_gpu(int size);
double time_calc(clock_t start, clock_t end);