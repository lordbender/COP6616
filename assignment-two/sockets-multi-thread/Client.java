// https://docs.oracle.com/javase/tutorial/networking/sockets/clientServer.html



import services.MatrixTools;

public class Main {
    public static void main(String[] args) {

        if (args.length < 2) {

            System.out.println("I require two arguments!");
            System.out.println("java -cp . Main test_size operation_to_perform");
            System.out.println("java -cp . Main 100000 [0 - 4]");
            return;
        }

        int size = Integer.parseInt(args[0]);
        int operation = Integer.parseInt(args[1]);

        if (operation == 4 || operation == 1) {
            System.out.println("WIP 1");
        }

        if (operation == 4 || operation == 2) {
            System.out.println("WIP 2");
        }

        if (operation == 4 || operation == 3) {
            String hostName = args[0];
            int portNumber = Integer.parseInt(args[1]);
            
            try (
                Socket kkSocket = new Socket(hostName, portNumber);
                PrintWriter out = new PrintWriter(kkSocket.getOutputStream(), true);
                BufferedReader in = new BufferedReader(
                    new InputStreamReader(kkSocket.getInputStream()));
            )
            
        }
    }
}
