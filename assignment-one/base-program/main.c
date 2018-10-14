#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <stdbool.h>
#include "common.h"

int main(int argc, char *argv[])
{
  srand(time(0));

  if (argc <= 2)
  {
    printf("You did not feed me enough arguments, I will die now :( ...\n\n");
    printf("Please do this for me to run!\n\n");
    printf("Available Opporations \n");
    printf("./a.out 50000 1 (where 50000 is the size of the test set and 1 is the opperation to perform) ) \n");
    printf("\t0) Return First Number    O(1).\n");
    printf("\t1) Linear Search          O(n).\n");
    printf("\t2) Bubble Sort            O(n^2).\n");
    printf("\t3) Matrix Multiplication  O(n^3).\n");
    printf("\t4) Run All                O(1) -> O(n^3).\n");
    exit(1);
  }

  // Grab the Requested Size from the Command Line Arguments.
  int size = atoi(argv[1]);
  int operation_to_preform = atoi(argv[2]);
  if (operation_to_preform > 4)
  {
    printf("\tYou chose an operation that does not exist. Please choose 0-4 for argument #2\n\n");
    return -1;
  }

  // Create the space the for the reports to get written to the output file! Bam!
  struct report *output_data = malloc((operation_to_preform == 4 ? 4 : 1) * sizeof(struct report));

  struct report return_first_number_report;
  if (operation_to_preform == 4 || operation_to_preform == 0)
  {
    double cpu_time_used_o_of_one = run_linear_big_o_of_one(size);
    return_first_number_report.size = size;
    return_first_number_report.runtime = cpu_time_used_o_of_one;
    return_first_number_report.process_name = "Return First Number";
    return_first_number_report.big_o = "O(1)";
    output_data[0] = return_first_number_report;
  }

  struct report linear_report;
  if (operation_to_preform == 4 || operation_to_preform == 1)
  {
    double cpu_time_used_linear_search = run_linear_search(size);
    linear_report.size = size;
    linear_report.runtime = cpu_time_used_linear_search;
    linear_report.process_name = "Linear Search";
    linear_report.big_o = "O(n)";
    output_data[(operation_to_preform == 4 ? 1 : 0)] = linear_report;
  }

  struct report bubble_report;
  if (operation_to_preform == 4 || operation_to_preform == 2)
  {
    double cpu_time_used_bubble_sort = run_linear_bubble(size);
    bubble_report.size = size;
    bubble_report.runtime = cpu_time_used_bubble_sort;
    bubble_report.process_name = "Bubble Sort";
    bubble_report.big_o = "O(n^2)";
    output_data[(operation_to_preform == 4 ? 2 : 0)] = bubble_report;
  }

  struct report matrix_report;
  if (operation_to_preform == 3 || operation_to_preform == 3)
  {
    double cpu_time_used_multiply_array = run_linear_matrix_multiply(size);
    matrix_report.size = size;
    matrix_report.runtime = cpu_time_used_multiply_array;
    matrix_report.process_name = "Matrix Multiplication";
    matrix_report.big_o = "O(n^3)";
    output_data[(operation_to_preform == 4 ? 3 : 0)] = matrix_report;
  }

  create_report((operation_to_preform == 4 ? 4 : 1), output_data);
  return 0;
}
