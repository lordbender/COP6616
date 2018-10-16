package core;

public class Report {
    public static void create(ReportModel model) {
        System.out.println("\tLinear: " + model.getAlgorythmName());
        System.out.println("\t\tComplexity      : " + model.getComplexity());
        System.out.println("\t\tExecution Time  : " + model.getDuration());
        System.out.print("\n-----------------------------------------\n");
    }
}