import services.*;

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

        if (operation == 4 || operation == 0) {
            ReturnFirst returnFirst = new ReturnFirst();
            returnFirst.doIt(size);
        }

        if (operation == 4 || operation == 1) {
            Search search = new Search();
            search.findTarget(size, 5000);
        }

        if (operation == 4 || operation == 2) {
            Bubble bubble = new Bubble();
            bubble.sort(size);
        }

        if (operation == 4 || operation == 3) {
            MatrixMultiplication matrix = new MatrixMultiplication();
            matrix.multiply(size);
        }
    }
}