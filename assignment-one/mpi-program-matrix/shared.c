#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <stdbool.h>
#include "common.h"

void create_report(int size, struct report *r)
{
    FILE *report_file;
    int i = 0;
    report_file = fopen("report.mpi-matrix.txt", "a");

    printf("\nReport of Linear performance for %d as the specified size:\n\n", r[0].size);
    for (i = 0; i < size; i++)
    {
        struct report lr = r[i];
        printf("Algorithm: %s\n", lr.process_name);
        printf("\tBig O          : %s\n", lr.big_o);
        printf("\tExecution Time : %f\n", lr.runtime);
        printf("\tDataset Size   : %d\n\n\n", lr.size);
        printf("\tProcess Count  : %d\n\n\n", lr.number_of_processess);

        // Write to the log for later analysis
        fprintf(report_file, "Algorithm: %s\n", lr.process_name);
        fprintf(report_file, "\tBig O          : %s\n", lr.big_o);
        fprintf(report_file, "\tExecution Time : %f\n", lr.runtime);
        fprintf(report_file, "\tDataset Size   : %d\n\n\n", lr.size);
        fprintf(report_file, "\tProcess Count  : %d\n\n\n", lr.number_of_processess);
    }

    fprintf(report_file, "\n----------------------------------------------------\n");
    printf("\n\nAlso see report generated in report.mpi-matrix.txt, append strategy.\n\n");

    fclose(report_file);
}