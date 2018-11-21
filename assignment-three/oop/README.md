# See the Execution Log for a history of all runs in all Environments.
[Execution Log](./execution.log)

# GOLANG Coroutines, Channels and Socket Examples

# Build
    In order to build this code, you MUST put it in the correct location. GOLANG requires that 
    code be placed in one of two specific locations in order to leverage the sub packages features,
    which I have used heavily. On Uranus at least, for me, GOPATH was not set at all. I had to edit my .bash_profile
    to export it before I could run my code.

## Steps to build

0. YOU MUST put folder oop at where the environment var GOPATH is pointing to
    1. set | grep GOPATH
        1. [n00599835@cisatlas oop]$ set | grep GOPATH
            1. GOPATH=/home/n00599835/go/src
    2. This can be tricky, for example i have to put oop in /home/n00599835/go/src/src/oop for go to find my packages...
    3. If you build, and it fails, move the files to where GOPATH is reporting from the build, not the set command...
        1. main.go:5:2: cannot find package "oop/core" in any of:
            2. /opt/go/src/pkg/oop/core (from $GOROOT)
            3. /home/n00599835/go/src/src/oop/core (from $GOPATH)
        2. Based on the compiler output, we can see go wants the program in /home/n00599835/go/src/src/, not /home/n00599835/go/src/ as indicated by set | grep GOPATH
        3. This is different between Uranus, and Atlas. so you will have to play around with the directory structure to get it to work.
1. unshar turnin compression somewhere
2. If go is installed on your system, you "should" already have a directory at ~/go/src/
    1. This might be the root for all go programs for your profile, see step 0 for help.
3. cp the oop directory in the shar to the following path 
    1. ~/go/src/oop
    2. Such that the main.go is at ~/go/src/oop/main.go
4. cd ~/go/src/oop
5. go build main.go

# Flags
    --size
    --all
    --nlogn
    --nsquared
    --rocks => if set, will attempt to distribute to the rocks cluster

# Test

## Test Execution
    $ chmod 777 test.sh
    $ ./test.sh
## Expected Test Output
    2018/11/10 13:47:21 Sequential Merge Sort took 997.3µs
    2018/11/10 13:47:21 Parallel Merge Sort took 3.0005ms

# Run Sequential and Shared Memory Multi Threaded (Goroutines and Buffered Channels))

0. ssh cisatlas.ccec.unf.edu

## Shared Memory Flag Permutations

1. go run main.go --size=10000 --all
2. go run main.go --size=10000 --nsquared
3. go run main.go --size=10000 --nlogn

## Distributed Memory Flag Permutations

# Running Distributed Memory
#NOTE: Server must be started seperatly to run these commands see Below Section on Running Distributed Memory Server#

0. ssh uranus.ccec.unf.edu
    1. go run main.go --size=10000 --all --rocks
    2. go run main.go --size=10000 --nsquared --rocks
    3. go run main.go --size=10000 --nlogn --rocks 
    4. go run main.go --size=10000 --all --rocks --hostsfile
    5. go run main.go --size=10000 --nsquared --rocks --hostsfile
    6. go run main.go --size=10000 --nlogn --rocks --hostsfile

1. go run server.go
2. go run main.go --size=10000 --nlogn --rocks1

# Setup and Clean-Up for the Beowulf Cluster Cluster

## if a server goes down, use the correct command to get it running again
 #Note: staring the server on any one compute node "should" start it on all iof the others... Should...#
1. go run build to create the server executable.
2. rocks run host compute-0-0 "~/go/src/oop/server" &
    1. It should be runnin on all clusters now, but if you get errors.
        1. run the command to start the server on the compute node having issues.
        2. rocks run host compute-0-[0-12] "~/go/src/oop/server" &

## if a port is in use, use lsof to find and kill it.
1. at Root: 
    1. lsof -i -P -n | grep LISTEN
2. rocks iterate host "lsof -i -P -n | grep LISTEN"
    2. rocks run host compute-0-0 "kill PID_FROM_ABOVE_COMMAND"
    3. The PIDS will be repeating, and killing it on 0-0 should kill it everywhere.

## To Test whether or not a specific compute cluster us up and running the server.
curl http://localhost:8080/api/v1/running
curl http://compute-0-0:8080/api/v1/running
curl http://compute-0-[0-12]:8080/api/v1/running

# Project Definition
    Project 3 Parallel Computing --- Due 11/20/18 

    For this project you are to implement comparison of performance of
    parallel applications.

    Using your chosen language, implement O(nlgn), O(n^2)
    algorithms.  On atlas projects should use threading and 
    uranus utilizing socket communication or a communication provided
    by the language. 

    GO - Sean Willison            -------------- 11/20/18

    Documentation and source code should be submitted 
    by the end of class on 12/1.

    turnin to reepar3