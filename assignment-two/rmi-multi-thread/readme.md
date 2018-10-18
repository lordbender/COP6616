https://docs.oracle.com/javase/7/docs/technotes/guides/rmi/hello/hello-world.html

# Run this first
rmiregistry &


# Run the Server(s) on Machine A
java -cp . Server

# Run the Client(s) on Machine B
java -cp . Client

