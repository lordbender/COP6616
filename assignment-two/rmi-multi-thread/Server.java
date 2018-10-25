import java.rmi.registry.Registry;
import java.rmi.registry.LocateRegistry;
import java.rmi.RemoteException;
import java.rmi.server.UnicastRemoteObject;
import services.*;

// Citation:
// https://docs.oracle.com/javase/7/docs/technotes/guides/rmi/hello/hello-world.html
public class Server implements IOperations {

    public Server() {
    }

    public double returnFirst(int size) {
        ReturnFirst first = new ReturnFirst();
        return first.getFirst(size);
    }

    public double search(int size) {
        ParallelSearch search = new ParallelSearch();
        return search.search(size);
    }

    public double bubble(int size) {
        BubbleSort bubble = new BubbleSort();
        return bubble.sort(size);
    }

    public double multiply(int size) {
        ParallelMatrixMultiplication matMult = new ParallelMatrixMultiplication();
        return matMult.runTimedExperiment(size);
    }

    public static void main(String args[]) {

        try {
            Server obj = new Server();
            IOperations stub = (IOperations) UnicastRemoteObject.exportObject(obj, 0);

            // Bind the remote object's stub in the registry
            Registry registry = LocateRegistry.getRegistry();
            registry.bind("IOperations", stub);

            System.err.println("Server ready");
        } catch (Exception e) {
            System.err.println("Server exception: " + e.toString());
            e.printStackTrace();
        }
    }
}
