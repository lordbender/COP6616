#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <stdbool.h>
#include "common.h"

int main(int argc, char *argv[])
{
  int p, id;

  // MPI Stuff
  if (argc != 2)
  {
    fprintf(stderr, "Usage: mpirun -np <num_procs> %s <random_array_size>\n", argv[0]);
    printf("You did not feed me arguments, I will die now :( ...\n");
    exit(1);
  }

  MPI_Init(&argc, &argv);
  MPI_Comm_size(MPI_COMM_WORLD, &p);
  MPI_Comm_rank(MPI_COMM_WORLD, &id);

  // Grab the Requested Size from the Command Line Arguments.
  int size = atoi(argv[1]);
  if (p == 0)
  {
    printf("Size => %d\n", size);
  }

  // Linear -> O(1) -> Linear Search Opperations

  // Linear -> O(n) -> Linear Search Opperations

  // Linear -> O(n^2) -> Bubble Sort Opperations

  // Linear -> O(n^3) -> Matrix Multipication

  // Create Report Here!
  // printf("\n\n\nReport of Linear performance for %d as the specified size:\n\n", size);
  // printf("\t\tO(1)   ran in: %f!\n", cpu_time_used_o_of_one);
  // printf("\t\tO(n)   ran in: %f!\n", cpu_time_used_linear_search);
  // printf("\t\tO(n^2) ran in: %f!\n", cpu_time_used_bubble_sort);
  // printf("\t\tO(n^3) ran in: %f!\n", cpu_time_used_multiply_array);

  MPI_Finalize();
  return 0;
}
