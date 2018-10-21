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
            f.get();
            exec.shutdown();
            long endTime = System.nanoTime();

            return (((double) (endTime - startTime) / 1000000) / 1000);

        } catch (Exception e) {
            return -1.0;
        }
    }

    class BubbleSortTask implements Runnable {
        private int size = 0;
        private long arr[];

        BubbleSortTask(long[] a) {
            this.arr = a;
            this.size = a.length;
        }

        public void run() {
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

            for (int i = 0; i < POOL_SIZE; i++) {
                // As it implements Future, we can call get()
                try {
                    long[] result = (long[]) futureTasks[i].get();

                    // Merge the sorted arrays...

                } catch (Exception e) {
                }

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