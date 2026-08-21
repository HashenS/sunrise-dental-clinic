package com.sunrisedental.service;

import org.junit.Test;
import static org.junit.Assert.*;

public class AppointmentValidationTest {

    @Test
    public void testValidContactNumber() {
        assertTrue(AppointmentService.validateContactNumber("0771234567"));
        assertTrue(AppointmentService.validateContactNumber("0112345678"));
    }

    @Test
    public void testInvalidContactNumber() {
        assertFalse(AppointmentService.validateContactNumber("12345"));
        assertFalse(AppointmentService.validateContactNumber("abcdefghij"));
        assertFalse(AppointmentService.validateContactNumber("07712345678")); // 11 digits
        assertFalse(AppointmentService.validateContactNumber("")); // empty
        assertFalse(AppointmentService.validateContactNumber(null)); // null
    }
}
