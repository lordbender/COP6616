import java.util.Arrays;

public class Bubble {

    public long[] sort(int size) {
        return sort(size, false);
    }

    public long[] sort(int size, Boolean print) {
        long[] arr = Common.create(size);
        long startTime = System.nanoTime();

        // Citation: https://www.geeksforgeeks.org/bubble-sort/
        int n = arr.length;
        for (int i = 0; i < n - 1; i++)
            for (int j = 0; j < n - i - 1; j++)
                if (arr[j] > arr[j + 1]) {
                    long temp = arr[j];
                    arr[j] = arr[j + 1];
                    arr[j + 1] = temp;
                }

        long endTime = System.nanoTime();
        Report.create((double) (endTime - startTime));
        if (print == true)
            for (int i = 0; i < size; i++) {
                System.out.println(arr[i]);
            }

        return arr;
    }
}