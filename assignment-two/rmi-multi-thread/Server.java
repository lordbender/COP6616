import java.rmi.registry.Registry;
import java.rmi.registry.LocateRegistry;
import java.rmi.RemoteException;
import java.rmi.server.UnicastRemoteObject;

// Citation:
// https://docs.oracle.com/javase/7/docs/technotes/guides/rmi/hello/hello-world.html
public class Server implements Operations {

    public Server() {
    }

    public double returnFirst(int size) {
        return 0.0;
    }

    public double search(int size) {
        ParallelSearch search = new ParallelSearch();
        return search.search(size);
    }

    public double bubble(int size) {
        return 0.0;
    }

    public double multiply(int size) {
        ParallelMatrixMultiplication matMult = new ParallelMatrixMultiplication();

        return matMult.multiply();
    }

    public static void main(String args[]) {

        try {
            Server obj = new Server();
            Operations stub = (Operations) UnicastRemoteObject.exportObject(obj, 0);

            // Bind the remote object's stub in the registry
            Registry registry = LocateRegistry.getRegistry();
            registry.bind("Operations", stub);

            System.err.println("Server ready");
        } catch (Exception e) {
            System.err.println("Server exception: " + e.toString());
            e.printStackTrace();
        }
    }
}