package models;

import core.Common;

public class ReportModel {

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
     * @return the duration
     */
    public double getDuration() {
        return duration;
    }

    /**
     * @param duration the duration to set
     */
    public void setDuration(double duration) {
        double helper = ((duration / 1000000) / 1000);
        this.duration = Common.round(helper, 6);
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