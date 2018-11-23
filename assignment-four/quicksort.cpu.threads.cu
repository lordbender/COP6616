// https://www.geeksforgeeks.org/multithreading-in-cpp/
// https://github.com/markwkm/quicksort/blob/master/recursive/quicksort-parallel.c

#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <sys/types.h>
#include <sys/wait.h>
#include <sys/ipc.h>
#include <sys/shm.h>

#include "main_cuda.cuh"

using namespace std; 

void quicksort_threaded(int *array, int left, int right)
{
	int pivot_index = left;
	int pivot_new_index;

	/*
	 * Use -1 to initialize because fork() uses 0 to identify a process as a
	 * child.
	 */
	int lchild = -1;
	int rchild = -1;

	if (right > left) {
		int status; /* For waitpid() only. */

		pivot_new_index = partition(array, left, right, pivot_index);

		/*
		 * Parallize by processing the left and right partion siultaneously.
		 * Start by spawning the 'left' child.
		 */
		lchild = fork();
		if (lchild < 0) {
			perror("fork");
			exit(1);
		}
		if (lchild == 0) {
			/* The 'left' child starts processing. */
			quicksort_threaded(array, left, pivot_new_index - 1);
			exit(0);
		} else {
			/* The parent spawns the 'right' child. */
			rchild = fork();
			if (rchild < 0) {
				perror("fork");
				exit(1);
			}
			if (rchild == 0) {
				/* The 'right' child starts processing. */
				quicksort_threaded(array, pivot_new_index + 1, right);
				exit(0);
			}
		}
		/* Parent waits for children to finish. */
		waitpid(lchild, &status, 0);
		waitpid(rchild, &status, 0);
	}
}

double quicksort_cpu_threads(int size)
{   
	size = size < 5000 ? size : 5000;
	
    int *a = (int *)malloc(sizeof(int) * size);

    for (int i = 0; i < size; i++)
    {
        a[i] = rand();
    }

    clock_t start = clock();

    quicksort_threaded(a, 0, size - 1); 
    
    clock_t end = clock();

    // Testing that sort is working, keep commented out on large values of N (say N > 1000)
    // for (int i = 0; i < size; i++)
    // {
    //     printf("\t %d\n", a[i]);
    // }

    return time_calc(start, end);
}
