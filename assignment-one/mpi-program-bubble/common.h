#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <stdbool.h>

struct report {
   double runtime;
   char* process_name;
   char* big_o;
   int size;
   int number_of_processess;
};

void create_report(int size, struct report *r);