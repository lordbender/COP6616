import java.util.Arrays;

public class MatrixMultiplication {

    public void multiply(int size) {
        long[][] a = Common.createTwoDimensional(size);
        long[][] b = Common.createTwoDimensional(size);

        long[][] c = new long[size][size];

        int hits = 0;
        long startTime = System.nanoTime();
        // Citation:
        // https://www.sanfoundry.com/java-program-perform-matrix-multiplication/
        for (int i = 0; i < size; i++)
            for (int j = 0; j < size; j++)
                for (int k = 0; k < size; k++) {
                    c[i][j] = c[i][j] + a[i][k] * b[k][j];
                }
        long endTime = System.nanoTime();

        ReportModel model = new ReportModel();
        model.setAlgorythmName("Matrix Multiplication");
        model.setComplexity("O(n^3)");
        model.setDuration((double) (endTime - startTime));
        Report.create(model);
    }
}