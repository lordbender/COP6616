#include <stdio.h>
#include <stdlib.h>

#define arrayLength(array) (sizeof((array)) / sizeof((array)[0]))

void printArray(int arr[], int size);
int *genRandom(int count);