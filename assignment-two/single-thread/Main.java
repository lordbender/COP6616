public class Main {
    public static void main(String[] args) {

        // for (String a : args) {
        // System.out.print(a);
        // }

        if (args.length < 2) {

            System.out.println("I require two arguments!");
            System.out.println("java -cp . Main test_size operation_to_perform");
            System.out.println("java -cp . Main 100000 [0 - 4]");
            return;
        }

        int size = Integer.parseInt(args[0]);
        int operation = Integer.parseInt(args[1]);

        if (operation == 4 || operation == 2) {
            Bubble bubble = new Bubble();
            bubble.sort(size);
        }

    }
}