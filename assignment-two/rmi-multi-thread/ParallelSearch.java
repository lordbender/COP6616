
// References:
// https://www.geeksforgeeks.org/callable-future-java/

import java.util.concurrent.*;
import java.util.Arrays;

public class ParallelSearch {

    private static final int MATRIX_SIZE = 1024, POOL_SIZE = Runtime.getRuntime().availableProcessors(),
            MINIMUM_THRESHOLD = 64;

    private final ExecutorService exec = Executors.newFixedThreadPool(POOL_SIZE);

    public double search(int size) {
        long[] arr = Common.create(size);

        long startTime = System.nanoTime();
        SearchTask searchTask = new SearchTask(arr, 10000);
        Future f = exec.submit(searchTask);
        try {
            f.get();
            exec.shutdown();
            long endTime = System.nanoTime();

            System.out.println("Total Hits on Target =>" + searchTask.hits);

            return (((double) (endTime - startTime) / 1000000) / 1000);

        } catch (Exception e) {
            return -1.0;
        }
    }

    class SearchTask implements Runnable {
        int size;
        long arr[];
        long target;
        int hits = 0;

        SearchTask(long[] a, long target) {
            this.arr = a;
            this.size = arr.length;
            this.target = target;
        }

        public void run() {

            if (size <= MINIMUM_THRESHOLD) {

                for (int i = 0; i < this.arr.length; ++i) {
                    if (this.arr[i] == this.target)
                        this.hits++;
                }
            } else {
                int chunkSize = (int) Math.ceil(this.size / POOL_SIZE);

                // Just for simpicitys sake, create one future for each core...
                FutureTask[] futureTasks = new FutureTask[POOL_SIZE];
                for (int i = 0; i < POOL_SIZE; i++) {
                    long[] subArr = Arrays.copyOfRange(this.arr, i * chunkSize, i * chunkSize + chunkSize);
                    CallableSearch callable = new CallableSearch(subArr, this.target);

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
                        int result = (int) futureTasks[i].get();
                        System.out.println("Hits from sub process: " + result);
                        this.hits += result;
                    } catch (Exception e) {
                    }

                }
            }
        }

    }

    class CallableSearch implements Callable {

        long[] arr;
        long target;

        CallableSearch(long[] arr, long target) {
            this.arr = arr;
            this.target = target;
        }

        public Object call() throws Exception {
            int hits = 0;
            for (int i = 0; i < this.arr.length; ++i) {
                if (this.arr[i] == this.target)
                    hits++;
            }

            return hits;
        }
    }
}