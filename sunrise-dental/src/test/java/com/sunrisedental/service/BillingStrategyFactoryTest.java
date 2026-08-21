package com.sunrisedental.service;

import org.junit.Test;
import static org.junit.Assert.*;

/**
 * Test class for BillingStrategyFactory.
 * Verifies that the Factory pattern correctly resolves the right
 * billing strategy implementation for each treatment type.
 */
public class BillingStrategyFactoryTest {

    @Test
    public void testTeethCleaningStrategyReturnsCorrectCost() {
        BillingStrategy strategy = BillingStrategyFactory.getStrategy("Teeth Cleaning");
        assertNotNull("Strategy should not be null", strategy);
        assertEquals("Teeth Cleaning should cost 5000.0", 5000.0, strategy.getCost(), 0.01);
    }

    @Test
    public void testDentalFillingStrategyReturnsCorrectCost() {
        BillingStrategy strategy = BillingStrategyFactory.getStrategy("Dental Filling");
        assertNotNull("Strategy should not be null", strategy);
        assertEquals("Dental Filling should cost 8000.0", 8000.0, strategy.getCost(), 0.01);
    }

    @Test
    public void testToothExtractionStrategyReturnsCorrectCost() {
        BillingStrategy strategy = BillingStrategyFactory.getStrategy("Tooth Extraction");
        assertNotNull("Strategy should not be null", strategy);
        assertEquals("Tooth Extraction should cost 12000.0", 12000.0, strategy.getCost(), 0.01);
    }

    @Test
    public void testNullTreatmentTypeReturnsUnknownStrategy() {
        BillingStrategy strategy = BillingStrategyFactory.getStrategy(null);
        assertNotNull("Strategy should not be null even for null input", strategy);
        assertEquals("Unknown treatment should return 0.0 cost", 0.0, strategy.getCost(), 0.01);
    }

    @Test
    public void testUnrecognisedTreatmentReturnsUnknownStrategy() {
        BillingStrategy strategy = BillingStrategyFactory.getStrategy("Root Canal");
        assertNotNull("Strategy should not be null for unrecognised treatment", strategy);
        assertEquals("Unrecognised treatment should return 0.0 cost", 0.0, strategy.getCost(), 0.01);
    }

    @Test
    public void testStrategyTypeForTeethCleaning() {
        BillingStrategy strategy = BillingStrategyFactory.getStrategy("Teeth Cleaning");
        assertTrue("Should return a CleaningBilling instance",
                strategy instanceof CleaningBilling);
    }

    @Test
    public void testStrategyTypeForDentalFilling() {
        BillingStrategy strategy = BillingStrategyFactory.getStrategy("Dental Filling");
        assertTrue("Should return a FillingBilling instance",
                strategy instanceof FillingBilling);
    }

    @Test
    public void testStrategyTypeForToothExtraction() {
        BillingStrategy strategy = BillingStrategyFactory.getStrategy("Tooth Extraction");
        assertTrue("Should return an ExtractionBilling instance",
                strategy instanceof ExtractionBilling);
    }
}
