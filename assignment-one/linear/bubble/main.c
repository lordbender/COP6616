#include <stdio.h>
#include <stdlib.h>
#include "common.h"

int main(int argc, char *argv[])
{
  int CONST_SIZE = 15;

  int *p = genRandom(CONST_SIZE);

  printf("Created array of size  %d \n", CONST_SIZE);

  bubbleSort(p, CONST_SIZE);

  printArray(p, CONST_SIZE);

  return 0;
}

// https://jetcracker.wordpress.com/2012/03/01/how-to-install-mpi-in-ubuntu/
