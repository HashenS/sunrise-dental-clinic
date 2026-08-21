package com.sunrisedental.model;

public class Bill {
    private int id;
    private String appointmentNumber;
    private String patientName;
    private String treatmentType;
    private double consultationFee;
    private double treatmentCost;
    private double totalCost;
    private String paymentStatus;

    public Bill() {}

    public Bill(String appointmentNumber, String patientName, String treatmentType, 
                double consultationFee, double treatmentCost, double totalCost, String paymentStatus) {
        this.appointmentNumber = appointmentNumber;
        this.patientName = patientName;
        this.treatmentType = treatmentType;
        this.consultationFee = consultationFee;
        this.treatmentCost = treatmentCost;
        this.totalCost = totalCost;
        this.paymentStatus = paymentStatus;
    }

    // Getters and Setters
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getAppointmentNumber() {
        return appointmentNumber;
    }

    public void setAppointmentNumber(String appointmentNumber) {
        this.appointmentNumber = appointmentNumber;
    }

    public String getPatientName() {
        return patientName;
    }

    public void setPatientName(String patientName) {
        this.patientName = patientName;
    }

    public String getTreatmentType() {
        return treatmentType;
    }

    public void setTreatmentType(String treatmentType) {
        this.treatmentType = treatmentType;
    }

    public double getConsultationFee() {
        return consultationFee;
    }

    public void setConsultationFee(double consultationFee) {
        this.consultationFee = consultationFee;
    }

    public double getTreatmentCost() {
        return treatmentCost;
    }

    public void setTreatmentCost(double treatmentCost) {
        this.treatmentCost = treatmentCost;
    }

    public double getTotalCost() {
        return totalCost;
    }

    public void setTotalCost(double totalCost) {
        this.totalCost = totalCost;
    }

    public String getPaymentStatus() {
        return paymentStatus;
    }

    public void setPaymentStatus(String paymentStatus) {
        this.paymentStatus = paymentStatus;
    }
}
