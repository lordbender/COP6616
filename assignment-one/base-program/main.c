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
  int arg1 = atoi(argv[1]);

  // Linear -> O(n^2) -> Bubble Sort Opperations
  int bubble_m_out[arg1];
  int *my_array = create_one_d_matrix(arg1, bubble_m_out, false);
  double cpu_time_used = run_linear_bubble(my_array, arg1, false);
  printf("Linear -> O(n^2) -> Bubble Sort Linear on %d integers, took %f\n\n", arg1, cpu_time_used);

  // Linear -> O(n^3) -> Matrix Multipication
  double cpu_time_used_multiply_array = run_linear_matrix_multiply(arg1, false);
  printf("Linear -> O(n^3) -> Multiply Matrix Linear on %d X %d integers, took %f\n\n", arg1, arg1, cpu_time_used_multiply_array);
  
  return 0;
}
