[Back to Main Report](./discussion.md)

# Linear Search Outcomes
**Linear Search tests based on 100,000,000 Items**

**Good Ol' C**
	[n00599835@cisatlas base-program]$ ./a.out 100000000

	Report of Linear performance for 100000000 as the specified size:

	Algorithm: Linear Search
			Big O          : O(n)
			Execution Time : 0.540000
			Dataset Size   : 100000000

**MPI 64 Cores**
	[n00599835@cisatlas mpi-program-search]$ mpirun -np 64 a.out 100000000
	Random Numbers Created: 100000000
	Number of Processes:    64
	Elements Per Process:   1562501

	Searching for:          9


	Report of MPI performance for 100000000 as the specified size:

	Algorithm: MPI Linear Search
			Big O          : O(n)
			Execution Time : 1.276714
			Dataset Size   : 100000000
			Process Count  : 64
			Target Located : 64 times

#### O(n) Speed-Up and Efficiency Test Run 100,000,000 - Metrics based on Barlas 1.4

**64 Cores - Fairy typical run**
	S = 0.540000 / 1.276714 = 0.42296082 (Too much MPI Overhead, MPI looses)
	E = S / N = 0.42296082 / 64.0 = 0.00660876281

	Thoughts: For O(n) on sets 100,000,000 (largest I can run without seg faults) There is negitive speedup 
	for parallelling operations via MPI. E < 1 means don't bother with the complexity, we would be throwing 
	good money after bad.

	I suspected that we would get speedup = N (linear speedup), but I was way off in my thinking.

#### Linear Search - All Test Runs

**CIS Atlas Single Thread**
	[n00599835@cisatlas base-program]$ ./a.out 100000000

	Report of Linear performance for 100000000 as the specified size:

	Algorithm: Linear Search
			Big O          : O(n)
			Execution Time : 0.540000
			Dataset Size   : 100000000



**CIS Atlas N Threads**
	Also see report generated in report.linear.txt, append strategy.

	[n00599835@cisatlas base-program]$ mpirun -np 32 ../mpi-program-search/a.out 100000000
	Random Numbers Created: 100000000
	Number of Processes:    32
	Elements Per Process:   3125001

	Searching for:          9


	Report of MPI performance for 100000000 as the specified size:

	Algorithm: MPI Linear Search
			Big O          : O(n)
			Execution Time : 1.069065
			Dataset Size   : 100000000
			Process Count  : 32
			Target Located : 32 times



	Also see report generated in report.mpi-search.txt, append strategy.

	[n00599835@cisatlas base-program]$ mpirun -np 8 ../mpi-program-search/a.out 100000000
	Random Numbers Created: 100000000
	Number of Processes:    8
	Elements Per Process:   12500001

	Searching for:          9


	Report of MPI performance for 100000000 as the specified size:

	Algorithm: MPI Linear Search
			Big O          : O(n)
			Execution Time : 1.486993
			Dataset Size   : 100000000
			Process Count  : 8
			Target Located : 8 times



	Also see report generated in report.mpi-search.txt, append strategy.

	[n00599835@cisatlas base-program]$ mpirun -np 128 ../mpi-program-search/a.out 100000000
	Random Numbers Created: 100000000
	Number of Processes:    128
	Elements Per Process:   781251

	Searching for:          9


	Report of MPI performance for 100000000 as the specified size:

	Algorithm: MPI Linear Search
			Big O          : O(n)
			Execution Time : 5.736386
			Dataset Size   : 100000000
			Process Count  : 128
			Target Located : 128 times



	Also see report generated in report.mpi-search.txt, append strategy.

	[n00599835@cisatlas base-program]$ mpirun -np 1 ../mpi-program-search/a.out 100000000
	Random Numbers Created: 100000000
	Number of Processes:    1
	Elements Per Process:   100000001

	Searching for:          9


	Report of MPI performance for 100000000 as the specified size:

	Algorithm: MPI Linear Search
			Big O          : O(n)
			Execution Time : 3.013254
			Dataset Size   : 100000000
			Process Count  : 1
			Target Located : 1 times



	Also see report generated in report.mpi-search.txt, append strategy.

	[n00599835@cisatlas base-program]$ mpirun -np 20 ../mpi-program-search/a.out 100000000
	Random Numbers Created: 100000000
	Number of Processes:    20
	Elements Per Process:   5000001

	Searching for:          9


	Report of MPI performance for 100000000 as the specified size:

	Algorithm: MPI Linear Search
			Big O          : O(n)
			Execution Time : 1.086641
			Dataset Size   : 100000000
			Process Count  : 20
			Target Located : 20 times

**Uranus Single Thread**

	[n00599835@uranus base-program]$ ./a.out 100000000 1

	Report of Linear performance for 100000000 as the specified size:

	Algorithm: Linear Search
			Big O          : O(n)
			Execution Time : 0.380000
			Dataset Size   : 100000000

	Also see report generated in report.linear.txt, append strategy.

	[n00599835@uranus base-program]$ ./a.out 110000000 1

	Report of Linear performance for 110000000 as the specified size:

	Algorithm: Linear Search
			Big O          : O(n)
			Execution Time : 0.410000
			Dataset Size   : 110000000

	Also see report generated in report.linear.txt, append strategy.

	[n00599835@uranus base-program]$ ./a.out 1000000 1

	Report of Linear performance for 1000000 as the specified size:

	Algorithm: Linear Search
			Big O          : O(n)
			Execution Time : 0.000000
			Dataset Size   : 1000000

	Also see report generated in report.linear.txt, append strategy.

	[n00599835@uranus base-program]$ ./a.out 100000 1

	Report of Linear performance for 100000 as the specified size:

	Algorithm: Linear Search
			Big O          : O(n)
			Execution Time : 0.000000
			Dataset Size   : 100000

**Uranus N Threads**

	[n00599835@uranus mpi-program-search]$ mpirun -np 64 a.out 100000000
	Random Numbers Created: 100000000
	Number of Processes:    64
	Elements Per Process:   1562501

	Searching for:          9


	Report of MPI performance for 100000000 as the specified size:

	Algorithm: MPI Linear Search
			Big O          : O(n)
			Execution Time : 4.127373
			Dataset Size   : 100000000
			Process Count  : 64
			Target Located : 64 times



	Also see report generated in report.mpi-search.txt, append strategy.

	[n00599835@uranus mpi-program-search]$ mpirun -np 32 a.out 100000000
	Random Numbers Created: 100000000
	Number of Processes:    32
	Elements Per Process:   3125001

	Searching for:          9


	Report of MPI performance for 100000000 as the specified size:

	Algorithm: MPI Linear Search
			Big O          : O(n)
			Execution Time : 2.748969
			Dataset Size   : 100000000
			Process Count  : 32
			Target Located : 32 times



	Also see report generated in report.mpi-search.txt, append strategy.

	[n00599835@uranus mpi-program-search]$ mpirun -np 16 a.out 100000000
	Random Numbers Created: 100000000
	Number of Processes:    16
	Elements Per Process:   6250001

	Searching for:          9


	Report of MPI performance for 100000000 as the specified size:

	Algorithm: MPI Linear Search
			Big O          : O(n)
			Execution Time : 2.038216
			Dataset Size   : 100000000
			Process Count  : 16
			Target Located : 16 times



	Also see report generated in report.mpi-search.txt, append strategy.

	[n00599835@uranus mpi-program-search]$ mpirun -np 8 a.out 100000000
	Random Numbers Created: 100000000
	Number of Processes:    8
	Elements Per Process:   12500001

	Searching for:          9


	Report of MPI performance for 100000000 as the specified size:

	Algorithm: MPI Linear Search
			Big O          : O(n)
			Execution Time : 1.469213
			Dataset Size   : 100000000
			Process Count  : 8
			Target Located : 8 times



	Also see report generated in report.mpi-search.txt, append strategy.