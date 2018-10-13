/*********************************************************************************************
* Based HEAVILY on other work
* Citation and Credit: http://site.sci.hkbu.edu.hk/tdgc/tutorial/ExpClusterComp/sorting/bubblesort.c 
************************************************************************************************/

#include <stdio.h>
#include <stdlib.h>
#include <mpi.h>

#include "common.h"

// #define N 1000000

void showVector(int *v, int n, int id);
int *merge(int *v1, int n1, int *v2, int n2);
void swap(int *v, int i, int j);
void sort(int *v, int n);

void showVector(int *v, int n, int id)
{
    int i;
    printf("%d: ", id);
    for (i = 0; i < n; i++)
        printf("%d ", v[i]);
    putchar('\n');
}

int *merge(int *v1, int n1, int *v2, int n2)
{
    int i, j, k;
    int *result;

    result = (int *)malloc((n1 + n2) * sizeof(int));

    /*
		i : pointer of v1
		j : pointer of v2
		k : pointer of k
	*/
    i = 0;
    j = 0;
    k = 0;
    while (i < n1 && j < n2)
        if (v1[i] < v2[j])
        {
            result[k] = v1[i];
            i++;
            k++;
        }
        else
        {
            result[k] = v2[j];
            j++;
            k++;
        }
    if (i == n1)
        while (j < n2)
        {
            result[k] = v2[j];
            j++;
            k++;
        }
    else
        while (i < n1)
        {
            result[k] = v1[i];
            i++;
            k++;
        }
    return result;
}

void swap(int *v, int i, int j)
{
    int t;
    t = v[i];
    v[i] = v[j];
    v[j] = t;
}

void sort(int *v, int n)
{
    int i, j;
    for (i = n - 2; i >= 0; i--)
        for (j = 0; j <= i; j++)
            if (v[j] > v[j + 1])
                swap(v, j, j + 1);
}

void main(int argc, char **argv)
{
    int *data;
    int *chunk;
    int *other;
    int id, p;
    int s;
    int i;
    int step;
    MPI_Status status;

    MPI_Init(&argc, &argv);
    MPI_Comm_rank(MPI_COMM_WORLD, &id);
    MPI_Comm_size(MPI_COMM_WORLD, &p);

    // Grab the Requested Size from the Command Line Arguments.
    int N = atoi(argv[1]);
    int m, n = N;

    if (id == 0)
    {
        int r;
        s = n / p;
        r = n % p;
        data = (int *)malloc((n + p - r) * sizeof(int));
        for (i = 0; i < n; i++)
            data[i] = random();
        if (r != 0)
        {
            for (i = n; i < n + p - r; i++)
                data[i] = 0;
            s = s + 1;
        }

        // startT = clock();

        MPI_Bcast(&s, 1, MPI_INT, 0, MPI_COMM_WORLD);
        chunk = (int *)malloc(s * sizeof(int));
        MPI_Scatter(data, s, MPI_INT, chunk, s, MPI_INT, 0, MPI_COMM_WORLD);

        sort(chunk, s);
    }
    else
    {
        MPI_Bcast(&s, 1, MPI_INT, 0, MPI_COMM_WORLD);
        chunk = (int *)malloc(s * sizeof(int));
        MPI_Scatter(data, s, MPI_INT, chunk, s, MPI_INT, 0, MPI_COMM_WORLD);

        sort(chunk, s);
    }

    step = 1;
    while (step < p)
    {
        if (id % (2 * step) == 0)
        {
            if (id + step < p)
            {
                MPI_Recv(&m, 1, MPI_INT, id + step, 0, MPI_COMM_WORLD, &status);
                other = (int *)malloc(m * sizeof(int));
                MPI_Recv(other, m, MPI_INT, id + step, 0, MPI_COMM_WORLD, &status);
                chunk = merge(chunk, s, other, m);
                s = s + m;
            }
        }
        else
        {
            int near = id - step;
            MPI_Send(&s, 1, MPI_INT, near, 0, MPI_COMM_WORLD);
            MPI_Send(chunk, s, MPI_INT, near, 0, MPI_COMM_WORLD);
            break;
        }
        step = step * 2;
    }
    if (id == 0)
    {

        // stopT = clock();
        printf("Time ");
    }
    MPI_Finalize();
}