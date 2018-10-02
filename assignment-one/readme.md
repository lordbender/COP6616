# Project 1 Parallel Computing --- due 10/16/18 at 23:59

For this project you are to take advantage of capabilities offered by C and FORTRAN languages. 

Following the examples provided, construct 2 programs, one using MPI and one not to determine when MPI improves efficiency. It may always improve efficiency, but your are to verify that is the case. 

**You should select the following:**
- O(1)
- (return first number)
- O(n)(linear search)
- O(n^2)(bubble sort) 
- O(n^3) (matrix multiplication) 

applications as the work to be done, generate random integers of varying number of numbers.  

The number of numbers should be a command line argument. 

You should not time the generation of the numbers, but time all MPI activity. 

You should include a discussion of the improved efficiency and comment on the relative speed up of your implementation. 

Run your application on uranus and atlas, be sure you monitor the machine load when collecting your data. 

shar you project and upload the shar file to osprey then turn it in with turnin using reepar1 as the turnin code.