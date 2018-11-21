package main

import (
	"flag"
	"oop/core"
	"oop/distributed"
	"oop/services"
	"time"
)

func main() {
	size := flag.Int("size", 1000, "Size of the test set.")
	all := flag.Bool("all", false, "If true, all reports will run")
	hostsfile := flag.Bool("hostsfile", false, "If true, all hosts will be used, else only root will be used")
	mergeSortReports := flag.Bool("nlogn", false, "If true, all merge sort actions are triggered, report run.")
	squaredReports := flag.Bool("nsquared", false, "If true, all merge sort actions are triggered, report run.")
	rocks := flag.Bool("rocks", false, "If true, run distributed memory programs.")

	flag.Parse()

	if (*all || *mergeSortReports) && !*rocks {
		a := core.GetArray(*size)
		start := time.Now()
		services.MergeSort(a)
		elapsed := time.Since(start)
		m := core.ReportModel{
			elapsed,
			"Linear MergeSort",
			"O(n*log(n))",
			*size,
		}
		core.RunReport(m)
	}

	if (*all || *mergeSortReports) && !*rocks {
		b := core.GetArray(*size)
		parallelMergeSortStart := time.Now()
		services.MergeSortParallel(b, 50)
		parallelMergeSortElapsed := time.Since(parallelMergeSortStart)
		m := core.ReportModel{
			parallelMergeSortElapsed,
			"Shared Memory, Threaded Parallel MergeSort",
			"O(n*log(n))",
			*size,
		}
		core.RunReport(m)
	}

	if (*all || *squaredReports) && !*rocks {
		c := core.GetMatrix(*size, *size, true)
		squareMatrixStart := time.Now()
		services.SquareMatrix(c)
		squareMatrixEnd := time.Since(squareMatrixStart)
		m := core.ReportModel{
			squareMatrixEnd,
			"Sequential Square Matrix",
			"O(n^2)",
			*size,
		}
		core.RunReport(m)
	}

	if (*all || *squaredReports) && !*rocks {
		d := core.GetMatrix(*size, *size, true)
		squareMatrixParStart := time.Now()
		services.SquareMatrixParallel(d)
		squareMatrixParEnd := time.Since(squareMatrixParStart)
		m := core.ReportModel{
			squareMatrixParEnd,
			"Shared Memory, Threaded Parallel Square Matrix",
			"O(n^2)",
			*size,
		}
		core.RunReport(m)
	}

	if (*all || *mergeSortReports) && *rocks {
		b := core.GetArray(*size)
		rocksMergeSortStart := time.Now()
		distributed.MergeSortDistributed(b, 13, *hostsfile)
		rocksMergeSortElapsed := time.Since(rocksMergeSortStart)
		m := core.ReportModel{
			rocksMergeSortElapsed,
			"Non-Shared Memory, Distributed Parallel Merge Sort",
			"O(n*log(n))",
			*size,
		}
		core.RunReport(m)
	}

	if (*all || *squaredReports) && *rocks {
		m1 := core.GetMatrix(*size, *size, true)
		rocksMatrixSquareStart := time.Now()
		distributed.SquareMatrix(m1, *hostsfile)
		rocksMatrixSquareElapsed := time.Since(rocksMatrixSquareStart)
		m := core.ReportModel{
			rocksMatrixSquareElapsed,
			"Non-Shared Memory, Distributed Parallel Square Matrix",
			"O(n^2)",
			*size,
		}
		core.RunReport(m)
	}
}
