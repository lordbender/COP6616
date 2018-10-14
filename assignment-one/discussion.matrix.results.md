# Matrix Multiplication Outcomes

**Matrix Multiplication tests based on 700 Items**

**Good Ol' C**
	[n00599835@cisatlas base-program]$ ./a.out 700 3

	Report of Linear performance for 700 as the specified size:

	Algorithm: Matrix Multiplication
			Big O          : O(n^3)
			Execution Time : 5.340000
			Dataset Size   : 700


**MPI 16 Processes (In this case, 16 procs was optimal, see all runs section below)**
	[n00599835@cisatlas base-program]$  mpirun -np 16 ../mpi-program-matrix/a.out 700

	Report of MPI performance for 700 as the specified size:

	Algorithm: MPI Matrix Multiplication
			Big O          : O(n^3)
			Execution Time : 0.398663
			Dataset Size   : 700
			Process Count  : 16


#### O(n) Speed-Up and Efficiency Test Run 100,000,000 - Metrics based on Barlas 1.4

**16 Cores - MPI Best Run vs Single Process**
	S = s(1) / s(n) = 5.340000 / 0.398663 = 13.3947720255 (Lot's and Lot's of Operations, MPI will always win!)
	E = S / N = 13.3947720255 / 16.0 = 0.83717325159

    Thoughts: For O(n^3) on sets 700 (largest I can run without MPI program pushing out of memory due to 2d array size constraints)
    There is fantastic speedup for parallelling operations via MPI. E near 1 means the complexity of MPI is worth investing
    in.

    I suspected that we would get speedup much greater than N, but, again, I was a bit off in my thinking. Still, it appears to be worth the effort to run n^3 operation sets in parallel. 

#### Bubble Sort - All Test Runs

##### Linear Benchmarks

	[n00599835@cisatlas base-program]$ ./a.out 1000 3

	Report of Linear performance for 1000 as the specified size:

	Algorithm: Matrix Multiplication
			Big O          : O(n^3)
			Execution Time : 17.250000
			Dataset Size   : 1000

	Also see report generated in report.linear.txt, append strategy.

	[n00599835@cisatlas base-program]$ ./a.out 1200 3
	^C
	[n00599835@cisatlas base-program]$ ./a.out 1200 3

	Report of Linear performance for 1200 as the specified size:

	Algorithm: Matrix Multiplication
			Big O          : O(n^3)
			Execution Time : 30.000000
			Dataset Size   : 1200

	Also see report generated in report.linear.txt, append strategy.

	[n00599835@cisatlas base-program]$ ./a.out 1400 3

	Report of Linear performance for 1400 as the specified size:

	Algorithm: Matrix Multiplication
			Big O          : O(n^3)
			Execution Time : 58.800000
			Dataset Size   : 1400

	Also see report generated in report.linear.txt, append strategy.

##### MPI Benchmarks

	[n00599835@cisatlas base-program]$  mpirun -np 64 ../mpi-program-matrix/a.out 700

	Report of MPI performance for 700 as the specified size:

	Algorithm: MPI Matrix Multiplication
			Big O          : O(n^3)
			Execution Time : 0.758272
			Dataset Size   : 700
			Process Count  : 64

	Also see report generated in report.mpi-matrix.txt, append strategy.

	[n00599835@cisatlas base-program]$  mpirun -np 32 ../mpi-program-matrix/a.out 700

	Report of MPI performance for 700 as the specified size:

	Algorithm: MPI Matrix Multiplication
			Big O          : O(n^3)
			Execution Time : 0.421306
			Dataset Size   : 700
			Process Count  : 32

	Also see report generated in report.mpi-matrix.txt, append strategy.

	[n00599835@cisatlas base-program]$  mpirun -np 16 ../mpi-program-matrix/a.out 700

	Report of MPI performance for 700 as the specified size:

	Algorithm: MPI Matrix Multiplication
			Big O          : O(n^3)
			Execution Time : 0.398663
			Dataset Size   : 700
			Process Count  : 16

