[Back to Main Report](./discussion.md)

# Return First Number Outcomes
**Return First Number tests based on 100,000,000 Items**

**Good Ol' C**
	[n00599835@cisatlas base-program]$ ./a.out 100000000 0

	Report of Linear performance for 100000000 as the specified size:

	Algorithm: Return First Number
			Big O          : O(1)
			Execution Time : 0.000000
			Dataset Size   : 100000000

**MPI 64 Cores**
	[n00599835@cisatlas mpi-big-o-one]$ mpirun -np 64 a.out 100000000
	Random Numbers Created: 100000000
	Number of Processes:    64
	Elements Per Process:   1562501


	Report of MPI performance for 100000000 as the specified size:

	Algorithm: MPI Return First Number
			Big O          : O(1)
			Execution Time : 2.450333
			Dataset Size   : 100000000
			Process Count  : 64
			Target Located : 64 times

#### O(n) Speed-Up and Efficiency Test Run 100,000,000 - Metrics based on Barlas 1.4

**64 Cores - Fairy typical run**
	S = 0.0 / 2.450333 = 0.0 (Too much MPI Overhead, MPI looses)
	E = S / N = 0.0 / 64.0 = 0.0

	Thoughts: For O(1) on sets 100,000,000, or any other size for that matter
	(100,000,000 is the largest I can run without seg faults) There is negative effect on speedup 
	for parallelling operations via MPI. E < 1 (or S == 0 => E == 0) means don't bother with the complexity
	of MPI.

	I suspected that we would get speedup = 0, and my suspicions were confirmed.

#### Return First Number- All Test Runs
	
##### Linear All Benchmarks

**CIS Atlas**
	[n00599835@cisatlas base-program]$ ./a.out 100000000 0

	Report of Linear performance for 100000000 as the specified size:

	Algorithm: Return First Number
			Big O          : O(1)
			Execution Time : 0.000000
        Dataset Size   : 100000000

**Uranus**

[n00599835@uranus base-program]$ ./a.out 1000000 0

Report of Linear performance for 1000000 as the specified size:

Algorithm: Return First Number
        Big O          : O(1)
        Execution Time : 0.000000
        Dataset Size   : 1000000

##### MPI All Benchmarks

**CIS Atlas**
	[n00599835@cisatlas mpi-big-o-one]$ mpirun -np 64 a.out 100
	Random Numbers Created: 100
	Number of Processes:    64
	Elements Per Process:   2


	Report of MPI performance for 100 as the specified size:

	Algorithm: MPI Return First Number
			Big O          : O(1)
			Execution Time : 0.005829
			Dataset Size   : 100
			Process Count  : 64
			Target Located : 64 times



	Also see report generated in report.mpi-order-one.txt, append strategy.

	[n00599835@cisatlas mpi-big-o-one]$ mpirun -np 64 a.out 100000000
	Random Numbers Created: 100000000
	Number of Processes:    64
	Elements Per Process:   1562501


	Report of MPI performance for 100000000 as the specified size:

	Algorithm: MPI Return First Number
			Big O          : O(1)
			Execution Time : 2.450333
			Dataset Size   : 100000000
			Process Count  : 64
			Target Located : 64 times

**Uranus**

	[n00599835@uranus mpi-big-o-one]$ mpirun -np 32 a.out 50000000
	Random Numbers Created: 50000000
	Number of Processes:    32
	Elements Per Process:   1562501


	Report of MPI performance for 50000000 as the specified size:

	Algorithm: MPI Return First Number
			Big O          : O(1)
			Execution Time : 1.354466
			Dataset Size   : 50000000
			Process Count  : 32
			Target Located : 32 times



	Also see report generated in report.mpi-order-one.txt, append strategy.

	[n00599835@uranus mpi-big-o-one]$ mpirun -np 16 a.out 50000000
	Random Numbers Created: 50000000
	Number of Processes:    16
	Elements Per Process:   3125001


	Report of MPI performance for 50000000 as the specified size:

	Algorithm: MPI Return First Number
			Big O          : O(1)
			Execution Time : 0.878954
			Dataset Size   : 50000000
			Process Count  : 16
			Target Located : 16 times



	Also see report generated in report.mpi-order-one.txt, append strategy.

	[n00599835@uranus mpi-big-o-one]$ mpirun -np 8 a.out 50000000
	Random Numbers Created: 50000000
	Number of Processes:    8
	Elements Per Process:   6250001


	Report of MPI performance for 50000000 as the specified size:

	Algorithm: MPI Return First Number
			Big O          : O(1)
			Execution Time : 0.680622
			Dataset Size   : 50000000
			Process Count  : 8
			Target Located : 8 times



	Also see report generated in report.mpi-order-one.txt, append strategy.