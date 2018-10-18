package services;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collection;
import java.util.List;
import java.util.Random;
import java.util.Random;
import java.util.concurrent.Callable;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;
import java.util.concurrent.Future;
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

        // Pool size will be double the number of cores by default
        int poolSize = Runtime.getRuntime().availableProcessors() * 2;
        FutureTask[] completeablFutureTasks = new FutureTask[size];
        ExecutorService executor = Executors.newFixedThreadPool(poolSize);

        Collection<CallableExample> helper = new ArrayList<CallableExample>();
        List<Future<?>> futures = new ArrayList<>();
        for (int i = 0; i < size; i++) {
            long[] row = new long[size];
            for (int j = 0; j < size; j++) {
                row[j] = a[i][j];
            }

            // Get all the futures together!
            futures.add(executor.submit(new CallableExample(new MultModel(row, b, i))));
        }

        List<MatrixResultModel> results = new ArrayList<MatrixResultModel>();

        for (Future<?> future : futures) {
            try {
                results.add((MatrixResultModel) future.get());
            } catch (Exception ex) {
                ex.printStackTrace();
            }
        }
        for(MatrixResultModel m : results){
            System.out.println(m.rowIndex);
        }

        return c;
    }

    class MultModel {
        private long[] row;
        private long[][] b;
        private int rowIndex;

        MultModel(long[] row, long[][] b, int rowIndex) {
            this.row = row;
            this.b = b;
            this.rowIndex = rowIndex;
        }
    }

    class MatrixResultModel {
        private long[] result;
        private int rowIndex;

        MatrixResultModel(long[] result, int rowIndex) {
            this.result = result;
            this.rowIndex = rowIndex;
        }
    }

    class CallableExample implements Callable {
        private MultModel model;

        CallableExample(MultModel model) {
            this.model = model;
        }

        public Object call() throws Exception {
            int size = this.model.row.length;
            long[] result = new long[size];

            for (int i = 0; i < size; i++) {
                long helper = 0;
                for (int j = 0; j < size; j++) {
                    helper += this.model.row[j] * this.model.b[i][j];
                }
                result[i] = helper;
            }

            return new MatrixResultModel(result, this.model.rowIndex);
        }
    }
}