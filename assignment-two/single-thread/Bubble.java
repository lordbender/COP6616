import java.util.Random;
import java.util.Arrays;

public class Bubble {

    public long[] sort(int size) {
        Random rand = new Random();
        long[] arr = new long[size];

        for (int i = 0; i < size; i++) {
            arr[i] = rand.nextLong();
        }

        for (long a : arr) {
            System.out.println(a);
        }
        
        return arr;
    }
}