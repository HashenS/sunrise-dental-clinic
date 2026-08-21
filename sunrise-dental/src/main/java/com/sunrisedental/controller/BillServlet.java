package com.sunrisedental.controller;

import com.sunrisedental.dao.AppointmentDAO;
import com.sunrisedental.dao.BillDAO;
import com.sunrisedental.model.Appointment;
import com.sunrisedental.model.Bill;
import com.sunrisedental.service.BillingService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/bill")
public class BillServlet extends HttpServlet {
    private final AppointmentDAO appointmentDAO = new AppointmentDAO();
    private final BillingService billingService = new BillingService();
    private final BillDAO billDAO = new BillDAO();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        if (request.getSession().getAttribute("user") == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        String appointmentNumber = request.getParameter("appointmentNumber");
        String feeStr = request.getParameter("consultationFee");

        try {
            double consultationFee = 2000.0; // Default
            if (feeStr != null && !feeStr.trim().isEmpty()) {
                consultationFee = Double.parseDouble(feeStr.trim());
            }

            Appointment appt = appointmentDAO.findByNumber(appointmentNumber);
            if (appt == null) {
                throw new Exception("Appointment not found!");
            }

            Bill bill = billingService.createAndSaveBill(appt, consultationFee);
            request.setAttribute("bill", bill);
            request.setAttribute("appointment", appt);
            request.getRequestDispatcher("bill.jsp").forward(request, response);

        } catch (Exception e) {
            request.setAttribute("errorMessage", e.getMessage());
            request.getRequestDispatcher("search.jsp").forward(request, response);
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        if (request.getSession().getAttribute("user") == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        String appointmentNumber = request.getParameter("appointmentNumber");
        String action = request.getParameter("action");

        if (appointmentNumber != null) {
            Bill bill = billDAO.findByAppointmentNumber(appointmentNumber);
            Appointment appt = appointmentDAO.findByNumber(appointmentNumber);
            
            if (bill != null && "pay".equals(action)) {
                bill.setPaymentStatus("PAID");
                billDAO.save(bill); // Saves the updated state (updates on duplicate key)
            }
            
            request.setAttribute("bill", bill);
            request.setAttribute("appointment", appt);
            request.getRequestDispatcher("bill.jsp").forward(request, response);
        } else {
            response.sendRedirect("search.jsp");
        }
    }
}
