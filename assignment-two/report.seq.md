# Linear Test Cases
> Linear tests were performed on dedicated hardware, and osprey, cisatlas and uranus. 
> For reporting purposes, I am reporting the results from CISAtlas as that is where I 
> got the best outcomes.

## Return First
> Return first was performed on 1,000,000,000 and many other sizes, and always ran in the
> same time.

>nSequential   : Return First		<br/>
>	Complexity      : O(1)   		<br/>
>	Execution Time  : 6.18E-7		<br/>
>	Cores           : 64			<br/>
>	Size            : 1000000000	<br/>

## Linear Search
> Linear Search sequential testing was done on 1,000,000 and 1,000,000,000 numbers.

>nSequential   : Linear Search
>	Complexity      : O(n)
>	Execution Time  : 0.006066294
>	Cores           : 64
>	Size            : 1000000

>nSequential   : Linear Search
>	Complexity      : O(n)
>	Execution Time  : 2.696181591
>	Cores           : 64
>	Size            : 1000000000

## Bubble Sort
> Bubble sort sequential testing was done on 100,000 and 1,000,000 numbers.

>nSequential   : Bubble Sort
>	Complexity      : O(n^2)
>	Execution Time  : 32.485004863
>	Cores           : 64
>	Size            : 100000

## Matrix Multiplication
> Matrix Multiplication testing was performed for RMI and Sequential 
> on a set of N x N matrices, where N == 1000, and N == 2000.

>nSequential   : Matrix Multiplication
>	Complexity      : O(n^3)
>	Execution Time  : 4.897806538
>	Cores           : 64
>	Size            : 1000

>nSequential   : Matrix Multiplication
>	Complexity      : O(n^3)
>	Execution Time  : 82.996110144
>	Cores           : 64
>	Size            : 2000

