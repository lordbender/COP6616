# Threaded / RMI Test Cases
> RMI tests were performed on dedicated hardware, and osprey, cisatlas and uranus. 
> For reporting purposes, I am reporting the results from CISAtlas as that is where I 
> got the best outcomes. Moreover, the para

## Return First
> Return first was performed on 1,000,000,000 and many other sizes, and always ran in the
> same time.

 >RMI: Return First Number
 >        Complexity      : O(1)
 >        Execution Time  : 9.33146E-4
 >        Cores           : 64
 >        Size           : 1000

## Linear Search
> Linear Search threaded testing was done on 1,000,000 and 1,000,000,000 numbers.

> RMI: Linear Search
>         Complexity      : O(n)
>         Execution Time  : 0.27531235800000003
>         Cores           : 64
>         Size           : 1000000

>RMI: Linear Search
>        Complexity      : O(n)
>        Execution Time  : 16.200298623000002
>        Cores           : 64
>        Size           : 1000000000

## Bubble Sort
> Bubble sort threaded testing was done on 100,000 and 500,000 numbers.

>RMI: Bubble Sort
>        Complexity      : O(n^2)
>        Execution Time  : 0.062451097
>        Cores           : 64
>        Size           : 100000

>RMI: Bubble Sort
>        Complexity      : O(n^2)
>        Execution Time  : 0.41642341299999996
>        Cores           : 64
>        Size           : 500000

>RMI: Bubble Sort
>        Complexity      : O(n^2)
>        Execution Time  : 104.611297396
>        Cores           : 64
>        Size           : 10000000

## Matrix Multiplication
> Matrix Multiplication testing was performed for RMI and Sequential 
> on a set of N x N matrices, where N == 1000, and N == 2000.

>RMI: Matrix Multiplication
>        Complexity      : O(n^3)
>        Execution Time  : 4.980966829
>        Cores           : 64
>        Size           : 1000

>RMI: Matrix Multiplication
>        Complexity      : O(n^3)
>        Execution Time  : 79.85027253
>        Cores           : 64
>        Size           : 2000