import java.rmi.registry.LocateRegistry;
import java.rmi.registry.Registry;

import core.Report;
import models.ReportModel;

public class Client {

    private Client() {
    }

    private static void createReport(double duration, String algorythm, String complexity, int size) {
        ReportModel report = new ReportModel();
        report.setDuration(duration);
        report.setAlgorythmName(algorythm);
        report.setComplexity(complexity);
        report.setSize(size);
        report.setCores(Runtime.getRuntime().availableProcessors());
        Report.create(report);
    }

    public static void main(String[] args) {

        if (args == null || args.length < 2) {
            System.out.println("Requires two arguments.");
            System.out.println("Example: java Client 1000 [0-4]");
            System.out.println(
                    "\t0) Return First.\n\t1) linear Search\n\t2) Bubble Sort\n\t3) Matrix Multiplication\n\t4) Run All");
            return;
        }

        String host = null; // Needs to be host IP
        int size = Integer.parseInt(args[0]);
        int operation = Integer.parseInt(args[1]);

        try {
            Registry registry = LocateRegistry.getRegistry(host);
            IOperations stub = (IOperations) registry.lookup("IOperations");

            if (operation == 4 || operation == 0) {
                createReport(stub.returnFirst(size), "Return First Number", "O(1)", size);
            }

            if (operation == 4 || operation == 1) {
                createReport(stub.search(size), "Linear Search", "O(n)");
            }

            if (operation == 4 || operation == 2) {
                createReport(stub.bubble(size), "Bubble Sort", "O(n^2)");
            }

            if (operation == 4 || operation == 3) {
                createReport(stub.multiply(size), "Matrix Multiplication", "O(n^3)");
            }

        } catch (Exception e) {
            System.err.println("Client exception: " + e.toString());
            e.printStackTrace();
        }
    }
}