package core;

import java.io.BufferedWriter;
import java.io.FileWriter;
import java.io.IOException;
import java.io.PrintWriter;

public class Report {    
    public static void create(ReportModel model) {
        System.out.println("\n\n\tSequential    : " + model.getAlgorythmName());
        System.out.println("\t\tComplexity      : " + model.getComplexity());
        System.out.println("\t\tExecution Time  : " + model.getDuration());
        System.out.println("\t\tCores           : " + Runtime.getRuntime().availableProcessors());
        System.out.println("\t\tSize            : " + model.getSize());
        System.out.print("\n-----------------------------------------\n\n");

        try (FileWriter fw = new FileWriter("seq-report.txt", true);
                BufferedWriter bw = new BufferedWriter(fw);
                PrintWriter out = new PrintWriter(bw)) {
            out.println("\n\n\tnSequential   : " + model.getAlgorythmName());
            out.println("\t\tComplexity      : " + model.getComplexity());
            out.println("\t\tExecution Time  : " + model.getDuration());
            out.println("\t\tCores           : " + Runtime.getRuntime().availableProcessors());
            out.println("\t\tSize            : " + model.getSize());
            out.print("\n-----------------------------------------\n\n");
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

}