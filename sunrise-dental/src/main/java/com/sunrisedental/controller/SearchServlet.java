package com.sunrisedental.controller;

import com.sunrisedental.dao.AppointmentDAO;
import com.sunrisedental.dao.BillDAO;
import com.sunrisedental.model.Appointment;
import com.sunrisedental.model.Bill;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet("/search-appointment")
public class SearchServlet extends HttpServlet {
    private final AppointmentDAO appointmentDAO = new AppointmentDAO();
    private final BillDAO billDAO = new BillDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        if (request.getSession().getAttribute("user") == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        String appointmentNumber = request.getParameter("appointmentNumber");
        String nicNumber         = request.getParameter("nicNumber");

        // Always load appointment history for the bottom panel
        request.setAttribute("history", appointmentDAO.findAll());

        // --- Search by Appointment Number ---
        if (appointmentNumber != null && !appointmentNumber.trim().isEmpty()) {
            Appointment appt = appointmentDAO.findByNumber(appointmentNumber.trim());
            if (appt != null) {
                request.setAttribute("appointment", appt);
                Bill bill = billDAO.findByAppointmentNumber(appointmentNumber.trim());
                if (bill != null) {
                    request.setAttribute("bill", bill);
                }
            } else {
                request.setAttribute("errorMessage", "No appointment found with number: " + appointmentNumber);
            }

        // --- Search by NIC Number ---
        } else if (nicNumber != null && !nicNumber.trim().isEmpty()) {
            List<Appointment> apptList = appointmentDAO.findByNic(nicNumber.trim());
            if (!apptList.isEmpty()) {
                request.setAttribute("appointmentList", apptList);
                request.setAttribute("searchedNic", nicNumber.trim());
            } else {
                request.setAttribute("errorMessage", "No appointments found for NIC: " + nicNumber);
            }
        }

        request.getRequestDispatcher("search.jsp").forward(request, response);
    }
}
