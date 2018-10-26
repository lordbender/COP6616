package services;

import java.util.Scanner;
import core.Common;

// Citation https://stackoverflow.com/questions/32371662/matrix-multiplication-with-threads-java
class MatrixProduct extends Thread {
    private long[][] A;
    private long[][] B;
    private long[][] C;
    private int rig, col;
    private int dim;

    public MatrixProduct(long[][] A, long[][] B, long[][] C, int rig, int col, int dim_com) {
        this.A = A;
        this.B = B;
        this.C = C;
        this.rig = rig;
        this.col = col;
        this.dim = dim_com;
    }

    public void run() {
        for (int i = 0; i < dim; i++) {
            C[rig][col] += A[rig][i] * B[i][col];
        }
    }
}

public class ParallelMatrixMultiplication {
    public double runTimedExperiment(int size) {
        long[][] A = Common.createTwoDimensional(size);
        long[][] B = Common.createTwoDimensional(size);
        long[][] C = new long[size][size];

        long startTime = System.nanoTime();
        MatrixProduct[][] thrd = new MatrixProduct[size][size];

        for (int i = 0; i < size; i++) {
            for (int j = 0; j < size; j++) {
                thrd[i][j] = new MatrixProduct(A, B, C, i, j, size);
                thrd[i][j].start();
            }
        }

        for (int i = 0; i < size; i++) {
            for (int j = 0; j < size; j++) {
                try {
                    thrd[i][j].join();
                } catch (InterruptedException e) {
                }
            }
        }

        long endTime = System.nanoTime();
        return (((double) (endTime - startTime) / 1000000) / 1000);
    }
}