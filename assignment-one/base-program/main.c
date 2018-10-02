#include <stdio.h>
#include <stdlib.h>
#include "common.h"

int main(int argc, char *argv[])
{
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
    my_array[i] = rand();
  }

  printArray(my_array, arg1);

  return 0;
}
