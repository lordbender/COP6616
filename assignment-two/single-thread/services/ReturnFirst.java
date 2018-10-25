package services;

import core.*;
import java.util.Arrays;

public class ReturnFirst {

    public long doIt(int size) {
        long[] arr = Common.create(size);

        long startTime = System.nanoTime();
        long first = arr[0];
        long endTime = System.nanoTime();

        ReportModel model = new ReportModel();
        model.setAlgorythmName("Return First");
        model.setComplexity("O(1)");
        model.setDuration((((double) (endTime - startTime) / 1000000) / 1000));
        model.setSize(size);
        Report.create(model);

        return first;
    }
}