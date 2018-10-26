# Based on RMI and Futures/Threads:
https://docs.oracle.com/javase/7/docs/technotes/guides/rmi/hello/hello-world.html
https://www.baeldung.com/java-future


# Run this first

- rmiregistry 5150 &
    - If the server fails to start, see cleanup, and retry starting the server.

# Run the Server(s) on Machine A

java Server &

# Run the Client(s) on Machine B

java Client (n) (operation [0-3])

See (report.md)[./report.md] for assignment discussion.

# Cleanup
1. type fg
2. hit control c to kill rmiregistry if it is running.
