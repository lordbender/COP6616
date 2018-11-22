
#include <stdio.h>
#include <stdlib.h>
#include <time.h>

#include "main_cuda.cuh"

double time_calc(clock_t start, clock_t end)
{
    return ((double)(end - start)) / CLOCKS_PER_SEC;
}
