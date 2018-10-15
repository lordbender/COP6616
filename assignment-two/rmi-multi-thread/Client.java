import java.rmi.registry.LocateRegistry;
import java.rmi.registry.Registry;

public class Client {

    private Client() {
    }

    public static void main(String[] args) {

        String host = null; // Needs to be host IP
        int size = Integer.parseInt(args[0]);
        int operation = Integer.parseInt(args[1]);

        try {
            Registry registry = LocateRegistry.getRegistry(host);
            Operations stub = (Operations) registry.lookup("Operations");

            if (operation == 4 || operation == 0) {
                double response = stub.returnFirst(size);
                System.out.println("response: " + response);
            }

            if (operation == 4 || operation == 1) {
                double response = stub.search(size);
                System.out.println("response: " + response);
            }

            if (operation == 4 || operation == 2) {
                double response = stub.bubble(size);
                System.out.println("response: " + response);
            }

            if (operation == 4 || operation == 3) {
                double response = stub.multiply(size);
                System.out.println("response: " + response);
            }

        } catch (Exception e) {
            System.err.println("Client exception: " + e.toString());
            e.printStackTrace();
        }
    }
}