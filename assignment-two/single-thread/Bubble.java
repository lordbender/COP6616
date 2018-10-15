import java.util.Random;
import java.util.Arrays;

public class Bubble {
    // Citation:
    // https://stackoverflow.com/questions/2808535/round-a-double-to-2-decimal-places
    private static double round(double value, int places) {
        if (places < 0)
            throw new IllegalArgumentException();

        long factor = (long) Math.pow(10, places);
        value = value * factor;
        long tmp = Math.round(value);
        return (double) tmp / factor;
    }

    private static long[] create(int size) {
        Random rand = new Random();
        long[] arr = new long[size];

        for (int i = 0; i < size; i++) {
            arr[i] = rand.nextLong();
        }

        return arr;
    }

    // Citation: https://www.geeksforgeeks.org/bubble-sort/
    public long[] sort(int size) {
        return sort(size, false);
    }

    // Citation: https://www.geeksforgeeks.org/bubble-sort/
    public long[] sort(int size, Boolean print) {
        long[] arr = create(size);
        long startTime = System.nanoTime();
        int n = arr.length;
        for (int i = 0; i < n - 1; i++)
            for (int j = 0; j < n - i - 1; j++)
                if (arr[j] > arr[j + 1]) {
                    long temp = arr[j];
                    arr[j] = arr[j + 1];
                    arr[j + 1] = temp;
                }
        long endTime = System.nanoTime();
        double duration = round((((double) (endTime - startTime) / 1000000.0) / 1000), 2);
        System.out.println("Linear Bubble Sort Execution Time: " + duration);

        if (print == true)
            for (int i = 0; i < size; i++) {
                System.out.println(arr[i]);
            }

        return arr;
    }
}