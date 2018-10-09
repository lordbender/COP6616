#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <stdbool.h>
#include "common.h"

int main(int argc, char *argv[])
{
  srand(time(0));

  if (argc <= 1)
  {
    printf("You did not feed me arguments, I will die now :( ...");
    exit(1);
  }

  // Grab the Requested Size from the Command Line Arguments.
  int size = atoi(argv[1]);

  // Linear -> O(1) -> Linear Search Opperations
  double cpu_time_used_o_of_one = run_linear_big_o_of_one(size, false);
  printf("Linear -> O(1) -> Return 1st number on %d integers, took %f\n\n", size, cpu_time_used_o_of_one);

  // Linear -> O(n) -> Linear Search Opperations
  double cpu_time_used_linear_search = run_linear_search(size, false);
  printf("Linear -> O(n) -> Linear Search on %d integers, took %f\n\n", size, cpu_time_used_linear_search);

  // Linear -> O(n^2) -> Bubble Sort Opperations
  int bubble_m_out[size];
  int *bubble_sort_a = create_one_d_matrix(size, bubble_m_out, false);
  double cpu_time_used_bubble_sort = run_linear_bubble(bubble_sort_a, size, false);
  printf("Linear -> O(n^2) -> Bubble Sort on %d integers, took %f\n\n", size, cpu_time_used_bubble_sort);

  // Linear -> O(n^3) -> Matrix Multipication
  double cpu_time_used_multiply_array = run_linear_matrix_multiply(size, false);
  printf("Linear -> O(n^3) -> Multiply Matrix on %d X %d integers, took %f\n\n", size, size, cpu_time_used_multiply_array);

  // Create Report Here!
  printf("\n\n\nReport of Linear performance for %d as the specified size:\n\n", size);
  printf("\t\tO(1)   ran in: %f seconds!\n", cpu_time_used_o_of_one);
  printf("\t\tO(n)   ran in: %f seconds!\n", cpu_time_used_linear_search);
  printf("\t\tO(n^2) ran in: %f seconds!\n", cpu_time_used_bubble_sort);
  printf("\t\tO(n^3) ran in: %f seconds!\n", cpu_time_used_multiply_array);

  return 0;
}
