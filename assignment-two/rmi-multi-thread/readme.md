# Based on:
https://docs.oracle.com/javase/7/docs/technotes/guides/rmi/hello/hello-world.html

# Run this first

- rmiregistry &
    - If the server fails to start, see cleanup, and retry starting the server.

# Run the Server(s) on Machine A

java -cp . Server

# Run the Client(s) on Machine B

java -cp . Client (n) (operation [0-3])

See (report.md)[./report.md] for assignment discussion.

# Cleanup
1. type fg
2. hit control c to kill rmiregistry if it is running.
