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
    printf("You did not feed me arguments, I will die now :( ...\n\n");
    exit(1);
  }

  // Grab the Requested Size from the Command Line Arguments.
  int size = atoi(argv[1]);

  // Linear -> O(1) -> Linear Search Opperations
  //  double cpu_time_used_o_of_one = run_linear_big_o_of_one(size, false);
  // printf("Linear -> O(1) -> Return 1st number on %d integers, took %f\n\n", size, cpu_time_used_o_of_one);

  // Linear -> O(n) -> Linear Search Opperations
  double cpu_time_used_linear_search = run_linear_search(size);
  // printf("Linear -> O(n) -> Linear Search on %d integers, took %f\n\n", size, cpu_time_used_linear_search);

  // Linear -> O(n^2) -> Bubble Sort Opperations
  // int bubble_m_out[size];
  // int *bubble_sort_a = create_one_d_matrix(size, bubble_m_out, false);
  // double cpu_time_used_bubble_sort = run_linear_bubble(bubble_sort_a, size, false);
  // printf("Linear -> O(n^2) -> Bubble Sort on %d integers, took %f\n\n", size, cpu_time_used_bubble_sort);

  // Linear -> O(n^3) -> Matrix Multipication Hard coded to 700, this is a good bound for testing.
  // double cpu_time_used_multiply_array = run_linear_matrix_multiply(700, false);
  // printf("Linear -> O(n^3) -> Multiply Matrix on %d X %d integers, took %f\n\n", 700, 700, cpu_time_used_multiply_array);

  // Create the space the for the reports to get written to the output file! Bam!
  struct report *output_data = malloc(1 * sizeof(struct report));

  //Create the reports

  // struct report return_first_number_report;
  // return_first_number_report.size = size;
  // return_first_number_report.runtime = cpu_time_used_o_of_one;
  // return_first_number_report.process_name = "Return First Number";
  // return_first_number_report.big_o = "O(1)";
  // output_data[0] = return_first_number_report;

  struct report linear_report;
  linear_report.size = size;
  linear_report.runtime = cpu_time_used_linear_search;
  linear_report.process_name = "Linear Search";
  linear_report.big_o = "O(n)";
  output_data[0] = linear_report;

 // struct report bubble_report;
 // bubble_report.size = size;
 // bubble_report.runtime = cpu_time_used_bubble_sort;
 // bubble_report.process_name = "Bubble Sort";
 // bubble_report.big_o = "O(n^2)";
 // output_data[2] = bubble_report;

 // struct report matrix_report;
 // matrix_report.size = 700;
 // matrix_report.runtime = cpu_time_used_multiply_array;
 // matrix_report.process_name = "Matrix Multiplication";
 // matrix_report.big_o = "O(n^3)";
 // output_data[3] = matrix_report;

  create_report(1, output_data);
  return 0;
}
