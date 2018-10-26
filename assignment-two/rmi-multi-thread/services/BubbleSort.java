package services;

import java.util.Arrays;

// References:
// https://abitofcs.blogspot.com/2015/12/parallel-matrix-multiplication-in-java.html

import java.util.concurrent.*;
import core.*;

public class BubbleSort {

    private static final int MATRIX_SIZE = 1024, POOL_SIZE = Runtime.getRuntime().availableProcessors(),
            MINIMUM_THRESHOLD = 64;

    private final ExecutorService exec = Executors.newFixedThreadPool(POOL_SIZE);

    public double sort(int size) {
        long[] arr = Common.create(size);

        long startTime = System.nanoTime();
        Future f = exec.submit(new BubbleSortTask(arr));
        try {
            long[] c = (long[]) f.get();
            exec.shutdown();
            long endTime = System.nanoTime();

            return (((double) (endTime - startTime) / 1000000) / 1000);

        } catch (Exception e) {
            e.printStackTrace();
            return -1.0;
        }
    }

    class BubbleSortTask implements Callable {
        private int size = 0;
        private long arr[];
        private long sorted[];

        public long[] getSorted() {
            return this.sorted;
        }

        BubbleSortTask(long[] a) {
            this.arr = a;
            this.size = a.length;
        }

        public Object call() {
            System.out.println("Here 1: Size " + this.size);

            FutureTask[] futureTasks = new FutureTask[POOL_SIZE];
            int chunkSize = (int) Math.ceil(this.size / POOL_SIZE);

            for (int i = 0; i < POOL_SIZE; i++) {
                long[] subArr = Arrays.copyOfRange(this.arr, i * chunkSize, i * chunkSize + chunkSize);
                CallableSort callable = new CallableSort(subArr);

                // Create the FutureTask with Callable
                futureTasks[i] = new FutureTask(callable);

                // As it implements Runnable, create Thread
                // with FutureTask
                Thread t = new Thread(futureTasks[i]);
                t.start();
            }

            long[][] results = new long[POOL_SIZE][chunkSize];
            for (int i = 0; i < POOL_SIZE; i++) {
                // As it implements Future, we can call get()
                try {
                    long[] result = (long[]) futureTasks[i].get();
                    results[i] = result;

                    // Merge the sorted arrays...

                } catch (Exception e) {
                    e.printStackTrace();
                }
            }

            // Bring all of the arrays back together
            // or merge all of the arrays.
            long[] c = new long[this.size];
            for (int i = 0; i < POOL_SIZE; i++) {
                for (int j = 0; j < chunkSize; j++) {
                    c[i * j] = results[i][j];
                }
            }

            // n^2 operations done - mergesort now...
            this.sort(c, 0, c.length - 1);

            // for (int i = 0; i < c.length; i++) {
            //     System.out.println(c[i]);
            // }
            return c;
        }

        // Citation
        // https://www.geeksforgeeks.org/merge-sort/
        private void sort(long arr[], int l, int r) {
            if (l < r) {
                // Find the middle point
                int m = (l + r) / 2;

                // Sort first and second halves
                sort(arr, l, m);
                sort(arr, m + 1, r);

                // Merge the sorted halves
                merge(arr, l, m, r);
            }
        }

        // Citation
        // https://www.geeksforgeeks.org/merge-sort/
        private void merge(long arr[], int l, int m, int r) {
            // Find sizes of two subarrays to be merged
            int n1 = m - l + 1;
            int n2 = r - m;

            /* Create temp arrays */
            long L[] = new long[n1];
            long R[] = new long[n2];

            /* Copy data to temp arrays */
            for (int i = 0; i < n1; ++i)
                L[i] = arr[l + i];
            for (int j = 0; j < n2; ++j)
                R[j] = arr[m + 1 + j];

            /* Merge the temp arrays */

            // Initial indexes of first and second subarrays
            int i = 0, j = 0;

            // Initial index of merged subarry array
            int k = l;
            while (i < n1 && j < n2) {
                if (L[i] <= R[j]) {
                    arr[k] = L[i];
                    i++;
                } else {
                    arr[k] = R[j];
                    j++;
                }
                k++;
            }

            /* Copy remaining elements of L[] if any */
            while (i < n1) {
                arr[k] = L[i];
                i++;
                k++;
            }

            /* Copy remaining elements of R[] if any */
            while (j < n2) {
                arr[k] = R[j];
                j++;
                k++;
            }
        }

    }

    class CallableSort implements Callable {
        long[] arr;

        CallableSort(long[] arr) {
            this.arr = arr;
        }

        public Object call() throws Exception {
            long[] a = this.arr;

            // Citation: https://www.geeksforgeeks.org/bubble-sort/
            int n = a.length;
            for (int i = 0; i < n - 1; i++)
                for (int j = 0; j < n - i - 1; j++)
                    if (a[j] > a[j + 1]) {
                        long temp = a[j];
                        a[j] = a[j + 1];
                        a[j + 1] = temp;
                    }

            return a;
        }
    }

}