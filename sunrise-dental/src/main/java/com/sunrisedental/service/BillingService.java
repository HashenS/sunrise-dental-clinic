package com.sunrisedental.service;

import com.sunrisedental.dao.BillDAO;
import com.sunrisedental.model.Appointment;
import com.sunrisedental.model.Bill;

public class BillingService {
    private final BillDAO billDAO = new BillDAO();

    public static double getTreatmentCost(String treatmentType) {
        return BillingStrategyFactory.getStrategy(treatmentType).getCost();
    }

    public static double calculateTotalCost(String treatmentType, double consultationFee) {
        return getTreatmentCost(treatmentType) + consultationFee;
    }

    public Bill createAndSaveBill(Appointment appt, double consultationFee) {
        double treatmentCost = getTreatmentCost(appt.getTreatmentType());
        double totalCost = treatmentCost + consultationFee;
        Bill bill = new Bill(
            appt.getAppointmentNumber(),
            appt.getPatientName(),
            appt.getTreatmentType(),
            consultationFee,
            treatmentCost,
            totalCost,
            "UNPAID"
        );
        billDAO.save(bill);
        return bill;
    }
}
