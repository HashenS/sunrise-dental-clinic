package com.sunrisedental.service;

import com.sunrisedental.dao.AppointmentDAO;
import com.sunrisedental.model.Appointment;

public class AppointmentService {
    private final AppointmentDAO appointmentDAO = new AppointmentDAO();

    public static boolean validateContactNumber(String contactNumber) {
        if (contactNumber == null) {
            return false;
        }
        return contactNumber.matches("^\\d{10}$");
    }

    public boolean registerAppointment(Appointment appt) throws Exception {
        if (appt == null) {
            throw new IllegalArgumentException("Appointment cannot be null");
        }
        if (appt.getPatientName() == null || appt.getPatientName().trim().isEmpty()) {
            throw new Exception("Patient Name is required");
        }
        if (!validateContactNumber(appt.getContactNumber())) {
            throw new Exception("Contact number must be exactly 10 digits");
        }
        if (appointmentDAO.isDentistDoubleBooked(appt.getDentistName(), appt.getAppointmentDate(), appt.getAppointmentTime())) {
            throw new Exception("Dentist " + appt.getDentistName() + " is already booked at this date and time");
        }
        return appointmentDAO.save(appt);
    }
}
