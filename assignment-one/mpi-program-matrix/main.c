/*********************************************************************************************
* Based HEAVILY on the work of Viraj Brian Wijesuriya - University of Colombo School of Computing, Sri Lanka.
* Citation and Credit: https://www.daniweb.com/programming/software-development/code/334470/matrix-multiplication-using-mpi-parallel-programming-approach
************************************************************************************************/

#include <stdio.h>
#include <stdlib.h>
#include <mpi.h>
#include "common.h"

#define MASTER_TO_SLAVE_TAG 1 //tag for messages sent from master to slaves
#define SLAVE_TO_MASTER_TAG 4 //tag for messages sent from slaves to master

void makeAB(int matrix_size, double mat_a[matrix_size][matrix_size], double mat_b[matrix_size][matrix_size]);

int rank;            //process rank
int size;            //number of processes
int i, j, k;         //helper variables
double start_time;   //hold start time
double end_time;     // hold end time
int low_bound;       //low bound of the number of rows of [A] allocated to a slave
int upper_bound;     //upper bound of the number of rows of [A] allocated to a slave
int portion;         //portion of the number of rows of [A] allocated to a slave
MPI_Status status;   // store status of a MPI_Recv
MPI_Request request; //capture request of a MPI_Isend
int main(int argc, char *argv[])
{
    MPI_Init(&argc, &argv);               //initialize MPI operations
    MPI_Comm_rank(MPI_COMM_WORLD, &rank); //get the rank
    MPI_Comm_size(MPI_COMM_WORLD, &size); //get number of processes

    // Grab the Requested Size from the Command Line Arguments.
    int matrix_size = atoi(argv[1]);
    double mat_a[matrix_size][matrix_size];      //declare input [A]
    double mat_b[matrix_size][matrix_size];      //declare input [B]
    double mat_result[matrix_size][matrix_size]; //declare output [C]

    /* master initializes work*/
    if (rank == 0)
    {
        makeAB(matrix_size, mat_a, mat_b);
        start_time = MPI_Wtime();
        for (i = 1; i < size; i++)
        {                                         //for each slave other than the master
            portion = (matrix_size / (size - 1)); // calculate portion without master
            low_bound = (i - 1) * portion;
            if (((i + 1) == size) && ((matrix_size % (size - 1)) != 0))
            {                              //if rows of [A] cannot be equally divided among slaves
                upper_bound = matrix_size; //last slave gets all the remaining rows
            }
            else
            {
                upper_bound = low_bound + portion; //rows of [A] are equally divisable among slaves
            }
            //send the low bound first without blocking, to the intended slave
            MPI_Isend(&low_bound, 1, MPI_INT, i, MASTER_TO_SLAVE_TAG, MPI_COMM_WORLD, &request);
            //next send the upper bound without blocking, to the intended slave
            MPI_Isend(&upper_bound, 1, MPI_INT, i, MASTER_TO_SLAVE_TAG + 1, MPI_COMM_WORLD, &request);
            //finally send the allocated row portion of [A] without blocking, to the intended slave
            MPI_Isend(&mat_a[low_bound][0], (upper_bound - low_bound) * matrix_size, MPI_DOUBLE, i, MASTER_TO_SLAVE_TAG + 2, MPI_COMM_WORLD, &request);
        }
    }
    //broadcast [B] to all the slaves
    MPI_Bcast(&mat_b, matrix_size * matrix_size, MPI_DOUBLE, 0, MPI_COMM_WORLD);
    /* work done by slaves*/
    if (rank > 0)
    {
        //receive low bound from the master
        MPI_Recv(&low_bound, 1, MPI_INT, 0, MASTER_TO_SLAVE_TAG, MPI_COMM_WORLD, &status);
        //next receive upper bound from the master
        MPI_Recv(&upper_bound, 1, MPI_INT, 0, MASTER_TO_SLAVE_TAG + 1, MPI_COMM_WORLD, &status);
        //finally receive row portion of [A] to be processed from the master
        MPI_Recv(&mat_a[low_bound][0], (upper_bound - low_bound) * matrix_size, MPI_DOUBLE, 0, MASTER_TO_SLAVE_TAG + 2, MPI_COMM_WORLD, &status);
        for (i = low_bound; i < upper_bound; i++)
        { //iterate through a given set of rows of [A]
            for (j = 0; j < matrix_size; j++)
            { //iterate through columns of [B]
                for (k = 0; k < matrix_size; k++)
                { //iterate through rows of [B]
                    mat_result[i][j] += (mat_a[i][k] * mat_b[k][j]);
                }
            }
        }
        //send back the low bound first without blocking, to the master
        MPI_Isend(&low_bound, 1, MPI_INT, 0, SLAVE_TO_MASTER_TAG, MPI_COMM_WORLD, &request);
        //send the upper bound next without blocking, to the master
        MPI_Isend(&upper_bound, 1, MPI_INT, 0, SLAVE_TO_MASTER_TAG + 1, MPI_COMM_WORLD, &request);
        //finally send the processed portion of data without blocking, to the master
        MPI_Isend(&mat_result[low_bound][0], (upper_bound - low_bound) * matrix_size, MPI_DOUBLE, 0, SLAVE_TO_MASTER_TAG + 2, MPI_COMM_WORLD, &request);
    }
    /* master gathers processed work*/
    if (rank == 0)
    {
        for (i = 1; i < size; i++)
        { // untill all slaves have handed back the processed data
            //receive low bound from a slave
            MPI_Recv(&low_bound, 1, MPI_INT, i, SLAVE_TO_MASTER_TAG, MPI_COMM_WORLD, &status);
            //receive upper bound from a slave
            MPI_Recv(&upper_bound, 1, MPI_INT, i, SLAVE_TO_MASTER_TAG + 1, MPI_COMM_WORLD, &status);
            //receive processed data from a slave
            MPI_Recv(&mat_result[low_bound][0], (upper_bound - low_bound) * matrix_size, MPI_DOUBLE, i, SLAVE_TO_MASTER_TAG + 2, MPI_COMM_WORLD, &status);
        }
        end_time = MPI_Wtime();
        double runtime = end_time - start_time;

        // Create the space the for the reports to get written to the output file! Bam!
        struct report *output_data = malloc(1 * sizeof(struct report));

        //Create the reports

        struct report mpi_liner_search_report;
        mpi_liner_search_report.size = matrix_size;
        mpi_liner_search_report.number_of_processess = size;
        mpi_liner_search_report.runtime = runtime;
        mpi_liner_search_report.process_name = "MPI Matrix Multiplication";
        mpi_liner_search_report.big_o = "O(n^3)";
        output_data[0] = mpi_liner_search_report;
        create_report(1, output_data);
    }
    MPI_Finalize(); //finalize MPI operations

    return 0;
}

void makeAB(int matrix_size, double mat_a[matrix_size][matrix_size], double mat_b[matrix_size][matrix_size])
{
    for (i = 0; i < matrix_size; i++)
    {
        for (j = 0; j < matrix_size; j++)
        {
            mat_a[i][j] = i + j;
            mat_b[i][j] = i * j - i;
        }
    }
}

void printReport()
{
}