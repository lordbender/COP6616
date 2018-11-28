#include <stdio.h>
#include <stdlib.h>
#include <ctime>
#include <ratio>
#include <chrono>

#include "main.h"

using namespace std::chrono;
 
int main(int argc, char *argv[])
{
  	srand(time(0));

 	int size = atoi(argv[1]);

	duration<double> cpu_radix_runtime = radixsort_cpu(size);
	printf("\n\n\tCPU O(n*log(n)) Sequential Radix: Completed %d numbers in %f seconds!!!\n", size, cpu_radix_runtime.count());
	   
	duration<double> cpu_runtime = quicksort_cpu(size);
	printf("\tCPU O(n*log(n)) Sequential Quicksort: Completed %d numbers in %f seconds!!!\n", size, cpu_runtime.count());

	duration<double> cpu_threads_runtime = quicksort_cpu_threads(size);
	printf("\tCPU O(n*log(n)) Threaded Quicksort: Completed %d numbers in %f seconds!!!\n", size, cpu_threads_runtime.count());
}