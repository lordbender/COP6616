#include <stdio.h>
#include <stdlib.h>

#define arrayLength(array) (sizeof((array)) / sizeof((array)[0]))

void printArray(int arr[], int size);
void bubbleSort(int numbers[], int count);
int *genRandom(int count);