package services;

import core.*;
import java.util.Arrays;

public class Search {

    public int findTarget(int size, long target) {
        long[] arr = Common.create(size);
        int hits = 0;

        long startTime = System.nanoTime();
        for (int i = 0; i < arr.length; i++) {
            if (arr[i] == target)
                hits++;
        }
        long endTime = System.nanoTime();

        ReportModel model = new ReportModel();
        model.setAlgorythmName("Linear Search");
        model.setComplexity("O(n)");
        model.setDuration((((double) (endTime - startTime) / 1000000) / 1000));
        model.setSize(size);
        Report.create(model);

        return hits;
    }
}