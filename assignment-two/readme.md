Project 2 Parallel Computing --- Due 10/30/18 at 23:59

For this project you are to take advantage of java's  capabilities
offered by RMI or socket programs. Following the examples provided,
construct 2 programs, one using RMI or one using sockets to determine
relative efficiency and as second sequential program. 

You should select O(1),(return first number),  O(n)(linear search), 
O(n^2)(bubble sort) and O(n^3) (matrix multiplication) applications 
as the work to be done, generate random integers of varying 
number of numbers.  The number of numbers should be a 
command line argument. You should not time the
generation of the numbers, but time all RMI/socket activity. 

You should include a discussion of the relative efficiency and
comment on the relative speed up of your implementation. Run your
application on uranus and atlas, be sure you monitor the machine 
load when collecting your data. Document relative speedups
and benefits of parallel over sequential.

shar you project and upload the shar file to osprey then turn it in
with turnin usings reepar2 as the turnin code.