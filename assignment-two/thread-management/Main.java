
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
            MatrixTools matrixTools = new MatrixTools();

            if (size < 100) {
                matrixTools.runTimedExperiment(size);
            } else {
                matrixTools.runTimedExperimentThreaded(size);
            }
        }
    }
}
