package core;

import models.ReportModel;

public class Report {
    public static void create(ReportModel model) {
        System.out.println("\n\n\tRMI: " + model.getAlgorythmName());
        System.out.println("\t\tComplexity      : " + model.getComplexity());
        System.out.println("\t\tExecution Time  : " + model.getDuration());
        System.out.print("\n-----------------------------------------\n\n");
    }
}