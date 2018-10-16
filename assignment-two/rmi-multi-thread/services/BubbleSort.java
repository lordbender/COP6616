package services;

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
            FutureTask[] fs = new FutureTask[this.size];

            for (int i = 0; i < this.size; i++) {
                System.out.println("a[" + i + "] =>" + this.arr[i]);
            }
        }
    }

}