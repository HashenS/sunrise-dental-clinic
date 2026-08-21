package com.sunrisedental.dao;

import com.sunrisedental.model.Bill;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class BillDAO {

    public boolean save(Bill bill) {
        String query = "INSERT INTO bills (appointment_number, patient_name, treatment_type, consultation_fee, treatment_cost, total_cost, payment_status) VALUES (?, ?, ?, ?, ?, ?, ?)"
                     + " ON DUPLICATE KEY UPDATE patient_name=?, treatment_type=?, consultation_fee=?, treatment_cost=?, total_cost=?, payment_status=?";
        try {
            Connection conn = DBConnection.getInstance().getConnection();
            try (PreparedStatement ps = conn.prepareStatement(query)) {
                ps.setString(1, bill.getAppointmentNumber());
                ps.setString(2, bill.getPatientName());
                ps.setString(3, bill.getTreatmentType());
                ps.setDouble(4, bill.getConsultationFee());
                ps.setDouble(5, bill.getTreatmentCost());
                ps.setDouble(6, bill.getTotalCost());
                ps.setString(7, bill.getPaymentStatus());
                
                // For duplicate updates
                ps.setString(8, bill.getPatientName());
                ps.setString(9, bill.getTreatmentType());
                ps.setDouble(10, bill.getConsultationFee());
                ps.setDouble(11, bill.getTreatmentCost());
                ps.setDouble(12, bill.getTotalCost());
                ps.setString(13, bill.getPaymentStatus());
                
                return ps.executeUpdate() > 0;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public Bill findByAppointmentNumber(String apptNum) {
        String query = "SELECT * FROM bills WHERE appointment_number = ?";
        try {
            Connection conn = DBConnection.getInstance().getConnection();
            try (PreparedStatement ps = conn.prepareStatement(query)) {
                ps.setString(1, apptNum);
                try (ResultSet rs = ps.executeQuery()) {
                    if (rs.next()) {
                        Bill bill = new Bill();
                        bill.setId(rs.getInt("id"));
                        bill.setAppointmentNumber(rs.getString("appointment_number"));
                        bill.setPatientName(rs.getString("patient_name"));
                        bill.setTreatmentType(rs.getString("treatment_type"));
                        bill.setConsultationFee(rs.getDouble("consultation_fee"));
                        bill.setTreatmentCost(rs.getDouble("treatment_cost"));
                        bill.setTotalCost(rs.getDouble("total_cost"));
                        bill.setPaymentStatus(rs.getString("payment_status"));
                        return bill;
                    }
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }
}
