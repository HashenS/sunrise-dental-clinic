package com.sunrisedental.service;

public class BillingStrategyFactory {
    public static BillingStrategy getStrategy(String treatmentType) {
        if (treatmentType == null) {
            return new UnknownBilling();
        }
        switch (treatmentType) {
            case "Teeth Cleaning":
                return new CleaningBilling();
            case "Dental Filling":
                return new FillingBilling();
            case "Tooth Extraction":
                return new ExtractionBilling();
            default:
                return new UnknownBilling();
        }
    }
}
