<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.sunrisedental.model.Appointment"%>
<%@ page import="com.sunrisedental.model.Bill"%>
<%
    if (session.getAttribute("user") == null) {
        response.sendRedirect("login.jsp");
        return;
    }
    String user = (String) session.getAttribute("user");
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Search & Billing - Sunrise Dental Clinic</title>
    <link rel="stylesheet" href="css/styles.css">
</head>
<body>
    <nav class="navbar">
        <a href="dashboard.jsp" class="navbar-brand">Sunrise Dental</a>
        <ul class="navbar-nav">
            <li><a href="dashboard.jsp" class="navbar-link">Home</a></li>
            <li><a href="register.jsp" class="navbar-link">Register Appointment</a></li>
            <li><a href="search.jsp" class="navbar-link active">Search & Billing</a></li>
            <li><a href="help.jsp" class="navbar-link">Help</a></li>
            <li><span style="color: var(--text-secondary); margin-left: 10px;">Hello, <%= user %></span></li>
            <li><a href="logout" class="btn btn-secondary" style="padding: 6px 14px; font-size: 0.85rem; width: auto;">Logout</a></li>
        </ul>
    </nav>

    <main class="main-content" style="max-width: 800px;">
        <div class="header-brand" style="text-align: left; margin-bottom: 30px;">
            <h1>Search & Billing</h1>
            <p>Retrieve client appointments by their unique appointment number to view booking details or process billing transactions.</p>
        </div>

        <!-- Search Bar -->
        <div class="glass-container" style="max-width: 100%; padding: 25px; margin-bottom: 30px;">
            <form action="search-appointment" method="GET" style="display: flex; gap: 15px; align-items: flex-end; flex-wrap: wrap;">
                <div class="form-group" style="flex: 1; min-width: 250px; margin-bottom: 0;">
                    <label for="appointmentNumber" style="margin-bottom: 6px;">Appointment Number</label>
                    <input type="text" id="appointmentNumber" name="appointmentNumber" class="form-input" placeholder="e.g. APT-12345" required value="<%= request.getParameter("appointmentNumber") != null ? request.getParameter("appointmentNumber") : "" %>">
                </div>
                <button type="submit" class="btn btn-primary" style="width: auto; padding: 12px 30px;">Search</button>
            </form>
        </div>

        <%
            String errorMessage = (String) request.getAttribute("errorMessage");
            if (errorMessage != null) {
        %>
            <div class="alert alert-danger">
                <span>⚠️</span> <%= errorMessage %>
            </div>
        <%
            }
        %>

        <%
            Appointment appt = (Appointment) request.getAttribute("appointment");
            if (appt != null) {
                Bill bill = (Bill) request.getAttribute("bill");
        %>
            <div class="table-container" style="padding: 30px; background: var(--bg-surface); border: 1px solid var(--border-color); border-radius: 16px;">
                <h3 style="margin-bottom: 20px; border-bottom: 1px solid var(--border-color); padding-bottom: 10px;">Appointment Details</h3>
                
                <table class="data-table" style="margin-bottom: 30px;">
                    <tr>
                        <th style="width: 30%;">Appointment No</th>
                        <td><strong style="color: var(--accent-color);"><%= appt.getAppointmentNumber() %></strong></td>
                    </tr>
                    <tr>
                        <th>Patient Name</th>
                        <td><%= appt.getPatientName() %></td>
                    </tr>
                    <tr>
                        <th>Contact Number</th>
                        <td><%= appt.getContactNumber() %></td>
                    </tr>
                    <tr>
                        <th>Patient Address</th>
                        <td><%= appt.getAddress() %></td>
                    </tr>
                    <tr>
                        <th>Dentist</th>
                        <td><%= appt.getDentistName() %></td>
                    </tr>
                    <tr>
                        <th>Treatment</th>
                        <td><%= appt.getTreatmentType() %></td>
                    </tr>
                    <tr>
                        <th>Date & Time</th>
                        <td><%= appt.getAppointmentDate() %> at <%= appt.getAppointmentTime() %></td>
                    </tr>
                </table>

                <%
                    if (bill != null) {
                %>
                    <div style="border-top: 1px solid var(--border-color); padding-top: 20px; display: flex; justify-content: space-between; align-items: center; flex-wrap: wrap; gap: 20px;">
                        <div>
                            <p style="font-size: 0.9rem; color: var(--text-secondary);">Billing Status:</p>
                            <p style="font-size: 1.25rem; font-weight: 700; color: <%= "PAID".equals(bill.getPaymentStatus()) ? "var(--success-color)" : "var(--danger-color)" %>;">
                                <%= bill.getPaymentStatus() %> (Total: LKR <%= String.format("%,.2f", bill.getTotalCost()) %>)
                            </p>
                        </div>
                        <div style="display: flex; gap: 15px;">
                            <% if (!"PAID".equals(bill.getPaymentStatus())) { %>
                                <a href="bill?appointmentNumber=<%= appt.getAppointmentNumber() %>&action=pay" class="btn btn-primary" style="width: auto;">Mark as Paid</a>
                            <% } %>
                            <a href="bill?appointmentNumber=<%= appt.getAppointmentNumber() %>" class="btn btn-secondary" style="width: auto;">View Invoice</a>
                        </div>
                    </div>
                <%
                    } else {
                %>
                    <div style="border-top: 1px solid var(--border-color); padding-top: 25px;">
                        <h4 style="margin-bottom: 15px;">Process Billing Invoice</h4>
                        <form action="bill" method="POST" style="display: flex; gap: 15px; align-items: flex-end; flex-wrap: wrap;">
                            <input type="hidden" name="appointmentNumber" value="<%= appt.getAppointmentNumber() %>">
                            
                            <div class="form-group" style="width: 250px; margin-bottom: 0;">
                                <label for="consultationFee">Consultation Fee (LKR)</label>
                                <input type="number" id="consultationFee" name="consultationFee" class="form-input" value="2000" min="0" required>
                            </div>
                            
                            <button type="submit" class="btn btn-primary" style="width: auto; padding: 12px 30px;">Generate Invoice</button>
                        </form>
                    </div>
                <%
                    }
                %>
            </div>
        <%
            }
        %>
    </main>
</body>
</html>
