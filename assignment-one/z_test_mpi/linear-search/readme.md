
# Building the Application
- cd ~/dirlocation
- mpicc *.c

# Running the Application
- cd ~/dirlocation 
- mpirun -np 8 a.out
    - Where 8 is is the number of processess spawned.