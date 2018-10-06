#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <stdbool.h>
#include <mpi.h>
#include "common.h"

double run_mpi_bubble(int p, int id, int size, bool print)
{
    int *bubble_sort_a = NULL;
    if (id == 0)
    {
        int bubble_m_out[size];
        bubble_sort_a = create_one_d_matrix(size, bubble_m_out, print);
    }

    double time_to_run = run_sort(p, id, size, bubble_sort_a, print);

    return time_to_run;
}

static inline void swap(int *v, int i, int j)
{
    int t = v[i];
    v[i] = v[j];
    v[j] = t;
}

void bubblesort(int *v, int n)
{
    int i, j;
    for (i = n - 2; i >= 0; i--)
        for (j = 0; j <= i; j++)
            if (v[j] > v[j + 1])
                swap(v, j, j + 1);
}

int *merge(int *v1, int n1, int *v2, int n2)
{
    int *result = (int *)malloc((n1 + n2) * sizeof(int));
    int i = 0;
    int j = 0;
    int k;
    for (k = 0; k < n1 + n2; k++)
    {
        if (i >= n1)
        {
            result[k] = v2[j];
            j++;
        }
        else if (j >= n2)
        {
            result[k] = v1[i];
            i++;
        }
        else if (v1[i] < v2[j])
        {
            result[k] = v1[i];
            i++;
        }
        else
        {
            result[k] = v2[j];
            j++;
        }
    }
    return result;
}

double run_sort(int p, int id, int size, int *data, bool print)
{
    int n;
    int c, s;
    int *chunk;
    int o;
    int *other;
    int step;
    MPI_Status status;
    double elapsed_time;
    FILE *file = NULL;
    int i;

    if (id == 0)
    {
        c = n / p;
        if (n % p)
            c++;
    }

    // start the timer
    MPI_Barrier(MPI_COMM_WORLD);
    elapsed_time = -MPI_Wtime();

    // broadcast size
    MPI_Bcast(&n, 1, MPI_INT, 0, MPI_COMM_WORLD);

    // compute chunk size
    c = n / p;
    if (n % p)
        c++;

    // scatter data
    chunk = (int *)malloc(c * sizeof(int));
    MPI_Scatter(data, c, MPI_INT, chunk, c, MPI_INT, 0, MPI_COMM_WORLD);

    // compute size of own chunk and sort it
    s = (n >= c * (id + 1)) ? c : n - c * id;
    bubblesort(chunk, s);

    // up to log_2 p merge steps
    for (step = 1; step < p; step = 2 * step)
    {
        if (id % (2 * step) != 0)
        {
            // id is no multiple of 2*step: send chunk to id-step and exit loop
            MPI_Send(chunk, s, MPI_INT, id - step, 0, MPI_COMM_WORLD);
            break;
        }
        // id is multiple of 2*step: merge in chunk from id+step (if it exists)
        if (id + step < p)
        {
            // compute size of chunk to be received
            o = (n >= c * (id + 2 * step)) ? c * step : n - c * (id + step);
            // receive other chunk
            other = (int *)malloc(o * sizeof(int));
            MPI_Recv(other, o, MPI_INT, id + step, 0, MPI_COMM_WORLD, &status);
            // merge and free memory
            data = merge(chunk, s, other, o);
            free(chunk);
            free(other);
            chunk = data;
            s = s + o;
        }
    }

    // stop the timer
    elapsed_time += MPI_Wtime();

    // write sorted data to out file and print out timer
    if (id == 0)
    {
    }

    // Print the Array - If you want!
    if (id == 0 && print == true)
    {
        printf("Bubblesort %d ints on %d procs: %f secs\n", n, p, elapsed_time);
        printArray(data, size);
    }

    return elapsed_time;
}