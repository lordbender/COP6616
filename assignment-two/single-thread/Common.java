import java.util.Random;
import java.util.Arrays;

public class Common {
    // Citation:
    // https://stackoverflow.com/questions/2808535/round-a-double-to-2-decimal-places
    public static double round(double value, int places) {
        if (places < 0)
            throw new IllegalArgumentException();

        long factor = (long) Math.pow(10, places);
        value = value * factor;
        long tmp = Math.round(value);
        return (double) tmp / factor;
    }

    public static long[] create(int size) {
        Random rand = new Random();
        long[] arr = new long[size];

        for (int i = 0; i < size; i++) {
            arr[i] = rand.nextLong();
        }

        return arr;
    }
}