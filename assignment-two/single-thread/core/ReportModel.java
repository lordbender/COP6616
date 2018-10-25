package core;

public class ReportModel {
    private int size;
    private String complexity;
    private String algorythmName;
    private double duration;

    /**
     * @return the complexity
     */
    public String getComplexity() {
        return complexity;
    }

    /**
     * @return the size
     */
    public int getSize() {
        return size;
    }

    /**
     * @param size the size to set
     */
    public void setSize(int size) {
        this.size = size;
    }

    /**
     * @return the duration
     */
    public double getDuration() {
        return duration;
    }

    /**
     * @param duration the duration to set
     */
    public void setDuration(double duration) {
        this.duration = duration;
    }

    /**
     * @return the algorythmName
     */
    public String getAlgorythmName() {
        return algorythmName;
    }

    /**
     * @param algorythmName the algorythmName to set
     */
    public void setAlgorythmName(String algorythmName) {
        this.algorythmName = algorythmName;
    }

    /**
     * @param complexity the complexity to set
     */
    public void setComplexity(String complexity) {
        this.complexity = complexity;
    }
}