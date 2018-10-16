package services;
// References:
// https://abitofcs.blogspot.com/2015/12/parallel-matrix-multiplication-in-java.html

import java.util.concurrent.*;
import core.*;

public class ReturnFirst {

    private static final int MATRIX_SIZE = 1024, POOL_SIZE = Runtime.getRuntime().availableProcessors(),
            MINIMUM_THRESHOLD = 64;

    private final ExecutorService exec = Executors.newFixedThreadPool(POOL_SIZE);

    public double getFirst(int size) {
        long[] arr = Common.create(size);

        long startTime = System.nanoTime();
        Future f = exec.submit(new ReturnFirstTask(arr));
        try {
            f.get();
            exec.shutdown();
            long endTime = System.nanoTime();

            return (((double) (endTime - startTime) / 1000000) / 1000);

        } catch (Exception e) {
            return -1.0;
        }
    }

    class ReturnFirstTask implements Runnable {
        private int size = 0;
        private long arr[];

        ReturnFirstTask(long[] a) {
            this.arr = a;
            this.size = a.length;
        }

        public void run() {
            System.out.println(this.arr[0]);
        }
    }

}