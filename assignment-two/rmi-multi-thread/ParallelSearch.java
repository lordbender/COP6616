
// References:
// https://abitofcs.blogspot.com/2015/12/parallel-matrix-multiplication-in-java.html

import java.util.concurrent.*;

public class ParallelSearch {

    private static final int MATRIX_SIZE = 1024, POOL_SIZE = Runtime.getRuntime().availableProcessors(),
            MINIMUM_THRESHOLD = 64;

    private final ExecutorService exec = Executors.newFixedThreadPool(POOL_SIZE);

    public double search(int size) {
        long[] arr = Common.create(size);

        long startTime = System.nanoTime();
        Future f = exec.submit(new SearchTask(arr, 10000));
        try {
            f.get();
            exec.shutdown();
            long endTime = System.nanoTime();

            return (((double) (endTime - startTime) / 1000000) / 1000);

        } catch (Exception e) {
            return -1.0;
        }
    }

    class SearchTask implements Runnable {
        private int size = 0;
        private long arr[];
        private long target;

        SearchTask(long[] a, long target) {
            this.arr = a;
            this.size = a.length;
            this.target = target;
        }

        public void run() {

            if (size <= MINIMUM_THRESHOLD) {
                int hits = 0;
                for (int i = 0; i < this.a.length; ++i) {
                    if (this.arr[i] == this.target)
                        hits++;
                }
            } else {
                SearchTask[] tasks = new SearchTask[POOL_SIZE];
                int chunkSize = Math.ceil(this.size / POOL_SIZE);

                for (int tp = 0; tp < POOL_SIZE; tp++) {
                    int[] newArray = Arrays.copyOfRange(this.arr, tp * chunkSize, tp * chunkSize + chunkSize);
                    tasks[tp] = new SearchTask(newArray, this.target);
                }

                FutureTask[] fs = new FutureTask[POOL_SIZE];
                for (int i = 0; i < fs.length; ++i) {
                    fs[i] = new FutureTask(new Sequentializer(tasks[i]));
                }
                for (int i = 0; i < fs.length; ++i) {
                    fs[i].run();
                }
                try {
                    for (int i = 0; i < fs.length; ++i) {
                        fs[i].get();
                    }
                } catch (Exception e) {

                }
            }
        }
    }

    class Sequentializer implements Runnable {
        private long arr[];
        private long target;

        Sequentializer(long arr[], long target) {
            this.arr = arr;
            this.target = target;
        }

        public void run() {
            int hits = 0;
            for (int i = 0; i < this.a.length; ++i) {
                if (this.arr[i] == this.target)
                    hits++;
            }

            // Doesn't matter if we return the hits, we are just looking for execution time!
        }

    }

}