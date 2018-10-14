[Back to Main Report](./discussion.md)

# Bubble Sort Outcomes
**Bubble Sort tests based on 100,000 Items**

**Good Ol' C**
	[n00599835@cisatlas base-program]$ ./a.out 100000

	Report of Linear performance for 100000 as the specified size:

	Algorithm: Bubble Sort
			Big O          : O(n^2)
			Execution Time : 86.770000
			Dataset Size   : 100000




**MPI 64 Cores**
	[n00599835@cisatlas base-program]$ mpirun -np 64 ../mpi-program-bubble/a.out 100000

	Report of MPI performance for 100000 as the specified size:

	Algorithm: MPI Bubble Sort
			Big O          : O(n^2)
			Execution Time : 0.136462
			Dataset Size   : 100000
			Process Count  : 64


#### O(n) Speed-Up and Efficiency Test Run 100,000,000 - Metrics based on Barlas 1.4

**64 Cores - Fairy typical run**
	S = s(1) / s(n) = 86.770000 / 0.136462 = 635.854670165 (Lot's of Operations, MPI Wins)
	E = S / N = 635.854670165 / 64.0 = 9.93522922133

	Thoughts: For O(n^2) on sets 100,000 (largest I can run without program running for hours on non parallel program) 
	There is fantastic speedup for parallelling operations via MPI. E > 1 means the complexity of MPI is worth investing
	in.

	I suspected that we would get speedup <= N (roughly at best linear speedup), but, again, I was a bit off in my thinking.

#### Bubble Sort - All Test Runs

**CIS Atlas Shingle Thread**
	[n00599835@cisatlas base-program]$ ./a.out 100000

	Report of Linear performance for 100000 as the specified size:

	Algorithm: Bubble Sort
			Big O          : O(n^2)
			Execution Time : 86.770000
			Dataset Size   : 100000

**CIS Atlas N Threads**
	[n00599835@cisatlas base-program]$ mpirun -np 64 ../mpi-program-bubble/a.out 100000

	Report of MPI performance for 100000 as the specified size:

	Algorithm: MPI Bubble Sort
			Big O          : O(n^2)
			Execution Time : 0.136462
			Dataset Size   : 100000
			Process Count  : 64

	[n00599835@cisatlas base-program]$ mpirun -np 32 ../mpi-program-bubble/a.out 100000

	Report of MPI performance for 100000 as the specified size:

	Algorithm: MPI Bubble Sort
			Big O          : O(n^2)
			Execution Time : 0.117827
			Dataset Size   : 100000
			Process Count  : 32

	[n00599835@cisatlas base-program]$ mpirun -np 1 ../mpi-program-bubble/a.out 100000

	Report of MPI performance for 100000 as the specified size:

	Algorithm: MPI Bubble Sort
			Big O          : O(n^2)
			Execution Time : 101.238085
			Dataset Size   : 100000
			Process Count  : 1

**Uranus Single Threads**

**Uranus N Threads**
	[n00599835@uranus mpi-program-bubble]$ mpirun -np 64 a.out 100000

	Report of MPI performance for 100000 as the specified size:

	Algorithm: MPI Bubble Sort
			Big O          : O(n^2)
			Execution Time : 0.457431
			Dataset Size   : 100000
			Process Count  : 64


	[n00599835@uranus mpi-program-bubble]$ mpirun -np 64 a.out 1000000

	Report of MPI performance for 1000000 as the specified size:

	Algorithm: MPI Bubble Sort
			Big O          : O(n^2)
			Execution Time : 24.584870
			Dataset Size   : 1000000
			Process Count  : 64
