# This is the foundational program

## It does:
- Create an Array(s) of Random Integers.
- Uses a Command Line Argument to determine the size of that Array.
- Prints the Array to the Console if required.
- Prints a report of the outcomes

# Building the Application
- mpicc *.c

# Running the Application
- mpirun -np 8 a.out
    - Where 8 is is the number of processess spawned.