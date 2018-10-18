package services;

import java.util.ArrayList;
import java.util.Random;
import java.util.Random;
import java.util.concurrent.Callable;
import java.util.concurrent.FutureTask;

public class MatrixTools {

    public void runTimedExperiment(int size) {
        long[][] a = getTestArray(size);
        long[][] b = getTestArray(size);

        long startTime = System.nanoTime();
        long[][] c = this.multiply(a, b);
        long endTime = System.nanoTime();

        System.out.println("Timed Run: " + (endTime - startTime));
    }

    public void runTimedExperimentThreaded(int size) {
        long[][] a = getTestArray(size);
        long[][] b = getTestArray(size);

        long startTime = System.nanoTime();
        long[][] c = this.multiplyThreaded(a, b);
        long endTime = System.nanoTime();

        System.out.println("Timed Run: " + (endTime - startTime));
    }

    public void test() {
        long[][] arr = getTestArray(5);
        for (int i = 0; i < 5; i++) {
            for (int j = 0; j < 5; j++)
                System.out.print(arr[i][j] + "\t");

            System.out.print("\n");

        }
    }

    private long[][] getTestArray(int size) {
        Random r = new Random();

        long outter[][] = new long[size][size];
        for (int i = 0; i < size; i++) {
            for (int j = 0; j < size; j++)
                outter[i][j] = r.nextLong();
        }

        return outter;
    }

    private long[][] multiply(long[][] a, long[][] b) {
        int size = a.length;
        long c[][] = new long[size][size];

        // Citation:
        // https://www.sanfoundry.com/java-program-perform-matrix-multiplication/
        for (int i = 0; i < size; i++)
            for (int j = 0; j < size; j++)
                for (int k = 0; k < size; k++) {
                    c[i][j] = c[i][j] + a[i][k] * b[k][j];
                }

        return c;
    }

    private long[][] multiplyThreaded(long[][] a, long[][] b) {
        int size = a.length;
        long c[][] = new long[size][size];

        int poosSize = Runtime.getRuntime().availableProcessors();
        int threshhold = 64;

        if (size <= threshhold)
            return this.multiply(a, b);

        FutureTask[] randomNumberTasks = new FutureTask[5];

        for (int i = 0; i < 5; i++) {
            Callable callable = new CallableExample();

            // Create the FutureTask with Callable
            randomNumberTasks[i] = new FutureTask(callable);

            // As it implements Runnable, create Thread
            // with FutureTask
            Thread t = new Thread(randomNumberTasks[i]);
            t.start();
        }

        for (int i = 0; i < 5; i++) {
            try {
                System.out.println(randomNumberTasks[i].get());
            } catch (Exception e) {
                System.err.println(e.toString());
            }
        }

        return c;
    }

    class CallableExample implements Callable {

        public Object call() throws Exception {
            // Create random number generator
            Random generator = new Random();

            Integer randomNumber = generator.nextInt(5);

            // To simulate a heavy computation,
            // we delay the thread for some random time
            Thread.sleep(randomNumber * 1000);

            return randomNumber;
        }
    }
}