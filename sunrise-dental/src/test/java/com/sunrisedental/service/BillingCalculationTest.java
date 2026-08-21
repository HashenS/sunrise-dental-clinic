package com.sunrisedental.service;

import org.junit.Test;
import static org.junit.Assert.*;

public class BillingCalculationTest {

    @Test
    public void testTeethCleaningCalculation() {
        double expectedTreatmentCost = 5000.0;
        double expectedConsultationFee = 2000.0;
        double expectedTotalCost = expectedTreatmentCost + expectedConsultationFee;
        
        assertEquals(expectedTreatmentCost, BillingService.getTreatmentCost("Teeth Cleaning"), 0.01);
        assertEquals(expectedTotalCost, BillingService.calculateTotalCost("Teeth Cleaning", expectedConsultationFee), 0.01);
    }

    @Test
    public void testDentalFillingCalculation() {
        double expectedTreatmentCost = 8000.0;
        double expectedConsultationFee = 2000.0;
        double expectedTotalCost = expectedTreatmentCost + expectedConsultationFee;
        
        assertEquals(expectedTreatmentCost, BillingService.getTreatmentCost("Dental Filling"), 0.01);
        assertEquals(expectedTotalCost, BillingService.calculateTotalCost("Dental Filling", expectedConsultationFee), 0.01);
    }

    @Test
    public void testToothExtractionCalculation() {
        double expectedTreatmentCost = 12000.0;
        double expectedConsultationFee = 2000.0;
        double expectedTotalCost = expectedTreatmentCost + expectedConsultationFee;
        
        assertEquals(expectedTreatmentCost, BillingService.getTreatmentCost("Tooth Extraction"), 0.01);
        assertEquals(expectedTotalCost, BillingService.calculateTotalCost("Tooth Extraction", expectedConsultationFee), 0.01);
    }

    @Test
    public void testUnknownTreatmentCalculation() {
        assertEquals(0.0, BillingService.getTreatmentCost("Unknown Treatment"), 0.01);
    }
}
