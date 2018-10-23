package core;

import java.io.BufferedWriter;
import java.io.FileWriter;
import java.io.IOException;
import java.io.PrintWriter;

import models.ReportModel;

public class Report {
    public static void create(ReportModel model) {
        System.out.println("\n\n\tRMI: " + model.getAlgorythmName());
        System.out.println("\t\tComplexity      : " + model.getComplexity());
        System.out.println("\t\tExecution Time  : " + model.getDuration());
        System.out.print("\n-----------------------------------------\n\n");

        try (FileWriter fw = new FileWriter("rmi-report.txt", true);
                BufferedWriter bw = new BufferedWriter(fw);
                PrintWriter out = new PrintWriter(bw)) {
            out.println("\n\n\tRMI: " + model.getAlgorythmName());
            out.println("\t\tComplexity      : " + model.getComplexity());
            out.println("\t\tExecution Time  : " + model.getDuration());
            out.print("\n-----------------------------------------\n\n");
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

}