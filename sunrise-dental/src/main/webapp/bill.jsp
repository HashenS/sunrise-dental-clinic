<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.sunrisedental.model.Appointment"%>
<%@ page import="com.sunrisedental.model.Bill"%>
<%
    if (session.getAttribute("user") == null) {
        response.sendRedirect("login.jsp");
        return;
    }
    String user = (String) session.getAttribute("user");
    Bill bill = (Bill) request.getAttribute("bill");
    Appointment appt = (Appointment) request.getAttribute("appointment");

    if (bill == null || appt == null) {
        response.sendRedirect("search.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Invoice - <%= bill.getAppointmentNumber() %></title>
    <link rel="stylesheet" href="css/styles.css">
</head>
<body>
    <nav class="navbar">
        <a href="dashboard.jsp" class="navbar-brand">Sunrise Dental</a>
        <ul class="navbar-nav">
            <li><a href="dashboard.jsp" class="navbar-link">Home</a></li>
            <li><a href="register.jsp" class="navbar-link">Register Appointment</a></li>
            <li><a href="search.jsp" class="navbar-link">Search & Billing</a></li>
            <li><a href="help.jsp" class="navbar-link">Help</a></li>
            <li><span style="color: var(--text-secondary); margin-left: 10px;">Hello, <%= user %></span></li>
            <li><a href="logout" class="btn btn-secondary" style="padding: 6px 14px; font-size: 0.85rem; width: auto;">Logout</a></li>
        </ul>
    </nav>

    <main class="main-content">
        <div class="invoice-card">
            <div class="invoice-header">
                <div class="invoice-title">
                    <h2>SUNRISE DENTAL CLINIC</h2>
                    <p style="color: #6b7280; font-size: 0.85rem; margin-top: 4px;">123 Galle Road, Colombo 03, Sri Lanka</p>
                    <p style="color: #6b7280; font-size: 0.85rem;">Tel: +94 11 234 5678 | email: info@sunrisedental.lk</p>
                </div>
                <div style="text-align: right;">
                    <h3 style="color: #4b5563; font-size: 1.1rem; font-weight: 600;">INVOICE</h3>
                    <p style="font-size: 0.85rem; color: #9ca3af; margin-top: 4px;">Invoice No: INV-<%= bill.getAppointmentNumber().substring(4) %></p>
                    <p style="font-size: 0.85rem; color: #9ca3af;">Date: <%= java.time.LocalDate.now() %></p>
                </div>
            </div>

            <div class="invoice-details">
                <div class="invoice-detail-block">
                    <h4>Billed To (Patient)</h4>
                    <p><%= appt.getPatientName() %></p>
                    <p style="font-weight: 400; color: #6b7280; font-size: 0.9rem; margin-top: 4px;">Address: <%= appt.getAddress() %></p>
                    <p style="font-weight: 400; color: #6b7280; font-size: 0.9rem;">Contact: <%= appt.getContactNumber() %></p>
                    <p style="font-weight: 400; color: #6b7280; font-size: 0.9rem;">NIC: <%= appt.getNicNumber() %></p>
                </div>
                <div class="invoice-detail-block" style="text-align: right;">
                    <h4>Booking Info</h4>
                    <p>Appt No: <span style="color: #3b82f6;"><%= bill.getAppointmentNumber() %></span></p>
                    <p style="font-weight: 400; color: #6b7280; font-size: 0.9rem; margin-top: 4px;">Dentist: <%= appt.getDentistName() %></p>
                    <p style="font-weight: 400; color: #6b7280; font-size: 0.9rem;">Schedule: <%= appt.getAppointmentDate() %> at <%= appt.getAppointmentTime() %></p>
                </div>
            </div>

            <table class="invoice-table">
                <thead>
                    <tr>
                        <th style="width: 70%; border-bottom: 2px solid #e5e7eb;">Description</th>
                        <th style="text-align: right; border-bottom: 2px solid #e5e7eb;">Amount (LKR)</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td style="padding: 15px 12px; color: #4b5563;">General Dental Consultation Fee</td>
                        <td style="text-align: right; padding: 15px 12px; font-weight: 500;"><%= String.format("%,.2f", bill.getConsultationFee()) %></td>
                    </tr>
                    <tr>
                        <td style="padding: 15px 12px; color: #4b5563;">Treatment Charges: <%= bill.getTreatmentType() %></td>
                        <td style="text-align: right; padding: 15px 12px; font-weight: 500;"><%= String.format("%,.2f", bill.getTreatmentCost()) %></td>
                    </tr>
                    <tr style="background-color: #f9fafb; font-weight: bold;">
                        <td style="padding: 15px 12px; color: #111827; border-top: 2px solid #e5e7eb;">Total Amount Due</td>
                        <td style="text-align: right; padding: 15px 12px; color: #111827; border-top: 2px solid #e5e7eb; font-size: 1.2rem;">LKR <%= String.format("%,.2f", bill.getTotalCost()) %></td>
                    </tr>
                </tbody>
            </table>

            <div style="display: flex; justify-content: space-between; align-items: center; border-top: 1px solid #f3f4f6; padding-top: 20px;">
                <div>
                    <span style="font-size: 0.85rem; color: #6b7280; text-transform: uppercase; font-weight: 600;">Payment Status</span>
                    <div style="font-size: 1.2rem; font-weight: 700; color: <%= "PAID".equals(bill.getPaymentStatus()) ? "var(--success-color)" : "var(--danger-color)" %>; margin-top: 4px;">
                        <%= bill.getPaymentStatus() %>
                    </div>
                </div>
                <div style="text-align: right; color: #9ca3af; font-size: 0.8rem;">
                    Thank you for choosing Sunrise Dental Clinic!
                </div>
            </div>
        </div>

        <div class="print-btn-container">
            <a href="search-appointment?appointmentNumber=<%= bill.getAppointmentNumber() %>" class="btn btn-secondary" style="width: auto;">Back to Search</a>
            <% if (!"PAID".equals(bill.getPaymentStatus())) { %>
                <a href="bill?appointmentNumber=<%= bill.getAppointmentNumber() %>&action=pay" class="btn btn-primary" style="width: auto; background: var(--success-color); color: #fff;">Mark as Paid</a>
            <% } %>
            <button onclick="window.print();" class="btn btn-primary" style="width: auto;">Print Invoice</button>
        </div>
    </main>
</body>
</html>
