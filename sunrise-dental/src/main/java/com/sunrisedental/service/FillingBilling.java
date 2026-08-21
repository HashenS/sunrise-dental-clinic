package com.sunrisedental.service;

public class FillingBilling implements BillingStrategy {
    @Override
    public double getCost() {
        return 8000.0;
    }
}
