package com.sunrisedental.service;

public class ExtractionBilling implements BillingStrategy {
    @Override
    public double getCost() {
        return 12000.0;
    }
}
