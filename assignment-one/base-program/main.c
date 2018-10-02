#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include "common.h"

int main(int argc, char *argv[])
{
  clock_t start = clock();
  srand(time(0));

  if (argc <= 1)
  {
    printf("You did not feed me arguments, I will die now :( ...");
    exit(1);
  }
  int arg1 = atoi(argv[1]);

  int my_array[arg1];

  printf("Creating an array of size  %d \n", arg1);
  int i;
  for (i = 0; i < 100; i++)
  {
    int num = rand();
    my_array[i] = num;
  }

  // Sort the Array
  int *r = bubbleSort(my_array, arg1);

  // Print the Array
  printArray(my_array, arg1);

  return 0;
}
