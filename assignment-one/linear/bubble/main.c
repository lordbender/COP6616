#include <stdio.h>
#include "common.h"

int main(int argc, char *argv[])
{

  int arr[] = {64, 34, 25, 12, 22, 11, 90};
  int n = sizeof(arr) / sizeof(arr[0]);
  bubbleSort(arr, n);
  printf("Sorted array: \n");
  printArray(arr, n);
  printf("\n");
  return 0;
  return 0;
}

// https://jetcracker.wordpress.com/2012/03/01/how-to-install-mpi-in-ubuntu/
