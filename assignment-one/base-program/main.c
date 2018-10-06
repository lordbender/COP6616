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

  // Bubble Sort Opperations
  int bubble_m_out[arg1];
  int *my_array = create_one_d_matrix(arg1, bubble_m_out, false);
  double cpu_time_used = run_linear_bubble(my_array, arg1, false);
  printf("Bubble Sort Linear on %d integers, took %f\n\n", arg1, cpu_time_used);

  return 0;
}

void marix(int r, int c, int m1[r][c], int m2[r][c], int mr[r][c])
{
  for (int i = 0; i < r; i++)
  {
    for (int j = 0; j < c; j++)
    {
      mr[i][j] = m1[i][j] + m2[i][j];
    }
  }
}
