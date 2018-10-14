
# Assignment Discussion Requirements
- You should include a discussion of the improved efficiency
- Comment on the relative speed up of your implementation. 
- Run your application on uranus and atlas, 
 - Be sure you monitor the machine load when collecting your data. 

# Issues
        There were issues with distributed hosts. Uranus has MPI 1.6 as a permanent value in the path as seen from cisatlas. 
        This issue caused errors that prevented distribution.

# Linear Program Overview

        [n00599835@cisatlas base-program]$ ./a.out 100000

        Report of Linear performance for 100000 as the specified size:

        Algorithm: Return First Number
                Big O          : O(1)
                Execution Time : 0.000000
                Dataset Size   : 100000


        Algorithm: Linear Search
                Big O          : O(n)
                Execution Time : 0.000000
                Dataset Size   : 100000


        Algorithm: Bubble Sort
                Big O          : O(n^2)
                Execution Time : 85.440000
                Dataset Size   : 100000


        Algorithm: Matrix Multiplication
                Big O          : O(n^3)
                Execution Time : 5.310000
                Dataset Size   : 700


#### Linear Search O(n)
[See Linear Search Results](./discussion.first.number.results.md)

#### Linear Search O(n)
[See Linear Search Results](./discussion.search.results.md)

#### Linear Search O(n^2)
[See Linear Search Results](./discussion.bubble.results.md)

#### Linear Search O(n^3)
[See Linear Search Results](./discussion.matrix.results.md)

# Description of Experiments

For each case of increased complexity, we look at the maximum N, such that a meaningful runtime completion can be 
achieved on the single threaded C program. 

- We then record the run results for the Single Thread at size N.
- We then record the run results for the M Threads at data set size N.
 - M = 64
 - M = 32
 - M = 16
 - M = 8
 - M = 1
- Where we record the speedup for each value of M at N, and report he best case for each.

# Outcomes and Observations

As expected there is a negative benefit to multi-threading when the complexity is less than O(n^2) or O(m*n)
where m is approaching n. We see a dramatic speedup in those cases of complexity where O(n^2) or greater complexity.

Although we did not test on Hard Problems O(m^n), that is where massively parallel processing will show the most 
speedup and efficiency gains.

# Machine Load at Time of Testing

The machines were both at minimal load at the times of testing.

#  Environmental Conditions

**Everything Below this line is solely related to the runtime conditions at runtime**
---------------------------------------------------------------------------------------------------------------

[Server Load Information](./discussion.machine.load.md)