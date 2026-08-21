package com.sunrisedental.service;

public class UnknownBilling implements BillingStrategy {
    @Override
    public double getCost() {
        return 0.0;
    }
}
