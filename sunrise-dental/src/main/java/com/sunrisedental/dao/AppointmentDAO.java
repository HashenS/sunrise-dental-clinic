package com.sunrisedental.dao;

import com.sunrisedental.model.Appointment;
import java.sql.Connection;
import java.sql.Date;
import java.sql.Time;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.LocalDate;
import java.time.LocalTime;

public class AppointmentDAO {

    public boolean save(Appointment appt) {
        String query = "INSERT INTO appointments (appointment_number, patient_name, address, contact_number, dentist_name, treatment_type, appointment_date, appointment_time) VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
        try {
            Connection conn = DBConnection.getInstance().getConnection();
            try (PreparedStatement ps = conn.prepareStatement(query)) {
                ps.setString(1, appt.getAppointmentNumber());
                ps.setString(2, appt.getPatientName());
                ps.setString(3, appt.getAddress());
                ps.setString(4, appt.getContactNumber());
                ps.setString(5, appt.getDentistName());
                ps.setString(6, appt.getTreatmentType());
                ps.setDate(7, Date.valueOf(appt.getAppointmentDate()));
                ps.setTime(8, Time.valueOf(appt.getAppointmentTime()));
                return ps.executeUpdate() > 0;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public Appointment findByNumber(String apptNum) {
        String query = "SELECT * FROM appointments WHERE appointment_number = ?";
        try {
            Connection conn = DBConnection.getInstance().getConnection();
            try (PreparedStatement ps = conn.prepareStatement(query)) {
                ps.setString(1, apptNum);
                try (ResultSet rs = ps.executeQuery()) {
                    if (rs.next()) {
                        Appointment appt = new Appointment();
                        appt.setId(rs.getInt("id"));
                        appt.setAppointmentNumber(rs.getString("appointment_number"));
                        appt.setPatientName(rs.getString("patient_name"));
                        appt.setAddress(rs.getString("address"));
                        appt.setContactNumber(rs.getString("contact_number"));
                        appt.setDentistName(rs.getString("dentist_name"));
                        appt.setTreatmentType(rs.getString("treatment_type"));
                        appt.setAppointmentDate(rs.getDate("appointment_date").toLocalDate());
                        appt.setAppointmentTime(rs.getTime("appointment_time").toLocalTime());
                        return appt;
                    }
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public boolean isDentistDoubleBooked(String dentistName, LocalDate date, LocalTime time) {
        String query = "SELECT COUNT(*) FROM appointments WHERE dentist_name = ? AND appointment_date = ? AND appointment_time = ?";
        try {
            Connection conn = DBConnection.getInstance().getConnection();
            try (PreparedStatement ps = conn.prepareStatement(query)) {
                ps.setString(1, dentistName);
                ps.setDate(2, Date.valueOf(date));
                ps.setTime(3, Time.valueOf(time));
                try (ResultSet rs = ps.executeQuery()) {
                    if (rs.next()) {
                        return rs.getInt(1) > 0;
                    }
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
}
