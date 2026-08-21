package com.sunrisedental.service;

public class CleaningBilling implements BillingStrategy {
    @Override
    public double getCost() {
        return 5000.0;
    }
}
