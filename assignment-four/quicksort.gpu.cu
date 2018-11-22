#include <stdio.h>
#include <stdlib.h>
#include <time.h>

#include "main_cuda.cuh"

static const int BLOCK_SIZE = 256;

#define swap(A, B)    \
    {                 \
        int temp = A; \
        A = B;        \
        B = temp;     \
    }

typedef struct vars
{
    int l;
    int r;
    int leq;
} vars;

// Portions of this code were based on / modeled after
// https://github.com/khaman1/GPU-QuickSort-Algorithm/blob/master/GPU_quicksort.cu

// Device Portion of Quick Sort
__global__ void gpuPartitionSwap(int *input, int *output, vars *endpts,
                                 int pivot, int l, int r,
                                 int d_leq[],
                                 int d_gt[], int *d_leq_val, int *d_gt_val,
                                 int nBlocks)
{
    __shared__ int bInput[BLOCK_SIZE];
    __syncthreads();
    int idx = l + blockIdx.x * BLOCK_SIZE + threadIdx.x;
    __shared__ int lThisBlock, rThisBlock;
    __shared__ int lOffset, rOffset;

    if (threadIdx.x == 0)
    {
        d_leq[blockIdx.x] = 0;
        d_gt[blockIdx.x] = 0;
        *d_leq_val = 0;
        *d_gt_val = 0;
    }
    __syncthreads();

    if (idx <= (r - 1))
    {
        bInput[threadIdx.x] = input[idx];
        if (bInput[threadIdx.x] <= pivot)
        {
            atomicAdd(&(d_leq[blockIdx.x]), 1);
        }
        else
        {
            atomicAdd(&(d_gt[blockIdx.x]), 1);
        }
    }
    __syncthreads();

    if (threadIdx.x == 0)
    {
        lThisBlock = d_leq[blockIdx.x];
        lOffset = l + atomicAdd(d_leq_val, lThisBlock);
    }
    if (threadIdx.x == 1)
    {
        rThisBlock = d_gt[blockIdx.x];
        rOffset = r - atomicAdd(d_gt_val, rThisBlock);
    }

    __syncthreads();

    if (threadIdx.x == 0)
    {

        int m = 0;
        int n = 0;
        for (int j = 0; j < BLOCK_SIZE; j++)
        {
            int chk = l + blockIdx.x * BLOCK_SIZE + j;
            if (chk <= (r - 1))
            {
                if (bInput[j] <= pivot)
                {
                    output[lOffset + m] = bInput[j];
                    ++m;
                }
                else
                {
                    output[rOffset - n] = bInput[j];
                    ++n;
                }
            }
        }
    }

    __syncthreads();

    if ((blockIdx.x == 0) && (threadIdx.x == 0))
    {
        int pOffset = l;
        for (int k = 0; k < nBlocks; k++)
            pOffset += d_leq[k];

        output[pOffset] = pivot;
        endpts->l = (pOffset - 1);
        endpts->r = (pOffset + 1);
    }

    return;
}

// Host Portion of Quick Sort

void quicksort(int *ls, int l, int r, int length)
{
    if ((r - l) >= 1)
    {
        int pivot = ls[r];

        int numBlocks = (r - l) / BLOCK_SIZE;
        if ((numBlocks * BLOCK_SIZE) < (r - l))
            numBlocks++;

        int *d_ls;
        int *d_ls2;
        vars endpts;
        endpts.l = l;
        endpts.r = r;

        vars *d_endpts;
        int *d_leq, *d_gt, *d_leq_val, *d_gt_val;
        int size = sizeof(int);
		cudaMalloc(&(d_ls), size * length);
		gpuErrchk(cudaGetLastError());

		cudaMalloc(&(d_ls2), size * length);
		gpuErrchk(cudaGetLastError());

		cudaMalloc(&(d_endpts), sizeof(vars));
		gpuErrchk(cudaGetLastError());

		cudaMalloc(&(d_leq), 4 * numBlocks);
		gpuErrchk(cudaGetLastError());

		cudaMalloc(&(d_gt), 4 * numBlocks);
		gpuErrchk(cudaGetLastError());

		cudaMalloc(&d_leq_val, 4);
		gpuErrchk(cudaGetLastError());

		cudaMalloc(&d_gt_val, 4);
		gpuErrchk(cudaGetLastError());
				
		cudaMemcpy(d_ls, ls, size * length, cudaMemcpyHostToDevice);
		gpuErrchk(cudaGetLastError());

        cudaMemcpy(d_ls2, ls, size * length, cudaMemcpyHostToDevice);
		gpuErrchk(cudaGetLastError());

        gpuPartitionSwap<<<numBlocks, BLOCK_SIZE>>>(d_ls, d_ls2, d_endpts, pivot, l, r, d_leq, d_gt, d_leq_val, d_gt_val, numBlocks);
		gpuErrchk(cudaGetLastError());

		cudaMemcpy(ls, d_ls2, size * length, cudaMemcpyDeviceToHost);
		gpuErrchk(cudaGetLastError());

		cudaMemcpy(&(endpts), d_endpts, sizeof(vars), cudaMemcpyDeviceToHost);
		gpuErrchk(cudaGetLastError());
		
        cudaThreadSynchronize();

        cudaFree(d_ls);
        cudaFree(d_ls2);
        cudaFree(d_endpts);
        cudaFree(d_leq);
        cudaFree(d_gt);

        if (endpts.l >= l)
			quicksort(ls, l, endpts.l, length);
        if (endpts.r <= r)
			quicksort(ls, endpts.r, r, length);
    }

    return;
}

double quicksort_gpu(int size)
{
    int *ha = (int *)malloc(sizeof(int) * size);

    clock_t start = clock();
    quicksort(ha, 0, size - 1, size);
    clock_t end = clock();

    return time_calc(start, end);
}