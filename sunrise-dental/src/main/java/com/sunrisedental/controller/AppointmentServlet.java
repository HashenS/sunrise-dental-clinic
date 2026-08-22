package com.sunrisedental.controller;

import com.sunrisedental.model.Appointment;
import com.sunrisedental.service.AppointmentService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.time.LocalDate;
import java.time.LocalTime;

@WebServlet("/register-appointment")
public class AppointmentServlet extends HttpServlet {
    private final AppointmentService appointmentService = new AppointmentService();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        if (request.getSession().getAttribute("user") == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        String patientName = request.getParameter("patientName");
        String address = request.getParameter("address");
        String contactNumber = request.getParameter("contactNumber");
        String nicNumber = request.getParameter("nicNumber");
        String dentistName = request.getParameter("dentistName");
        String treatmentType = request.getParameter("treatmentType");
        String dateStr = request.getParameter("appointmentDate");
        String timeStr = request.getParameter("appointmentTime");

        try {
            if (dateStr == null || dateStr.trim().isEmpty() || timeStr == null || timeStr.trim().isEmpty()) {
                throw new Exception("Appointment Date and Time are required!");
            }
            LocalDate appointmentDate = LocalDate.parse(dateStr);
            LocalTime appointmentTime = LocalTime.parse(timeStr);

            // Generate unique appointment number (e.g., APT-12345)
            String appointmentNumber = "APT-" + (int)(Math.random() * 90000 + 10000);

            Appointment appt = new Appointment(
                appointmentNumber,
                patientName,
                address,
                contactNumber,
                nicNumber != null ? nicNumber.trim() : "",
                dentistName,
                treatmentType,
                appointmentDate,
                appointmentTime
            );

            if (appointmentService.registerAppointment(appt)) {
                response.sendRedirect("dashboard.jsp?successMessage=Appointment " + appointmentNumber + " registered successfully!");
            } else {
                throw new Exception("Failed to register appointment. Try again.");
            }
        } catch (Exception e) {
            request.setAttribute("errorMessage", e.getMessage());
            request.getRequestDispatcher("register.jsp").forward(request, response);
        }
    }
}
