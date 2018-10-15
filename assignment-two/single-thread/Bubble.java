import java.util.Arrays;

public class Bubble {

    public long[] sort(int size) {
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

        ReportModel model = new ReportModel();
        model.setAlgorythmName("Bubble Sort");
        model.setComplexity("O(n^2)");
        model.setDuration((double) (endTime - startTime));
        Report.create(model);

        return arr;
    }
}