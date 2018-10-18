package services;

import java.util.ArrayList;
import java.util.Random;

public class MatrixTools {

    public void runTimedExperiment(int size) {
        long[][] a = getTestArray(size);
        long[][] b = getTestArray(size);

        long startTime = System.nanoTime();
        long[][] c = this.multiply(a, b);
        long endTime = System.nanoTime();

        System.out.println("Timed Run: " + endTime - start);
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
        long c[][] = new long[a.length][a.length];

        // Citation:
        // https://www.sanfoundry.com/java-program-perform-matrix-multiplication/
        for (int i = 0; i < size; i++)
            for (int j = 0; j < size; j++)
                for (int k = 0; k < size; k++) {
                    c[i][j] = c[i][j] + a[i][k] * b[k][j];
                }

        return c;
    }

}