package services;

import java.util.ArrayList;
import java.util.Random;

public class MatrixTools {

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

    public long[][] multiply(long[][] a, long[][] b) {
        long c[][] = new long[a.length][a.length];
    }

}