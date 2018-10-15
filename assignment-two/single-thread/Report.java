
public class Report {
    public static void create(double runtime) {
        double duration = Common.round(runtime, 2);
        System.out.println("Linear Bubble Sort Execution Time: " + duration);
    }
}