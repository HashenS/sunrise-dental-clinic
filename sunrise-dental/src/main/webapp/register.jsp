<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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
    <title>Register Appointment - Sunrise Dental Clinic</title>
    <link rel="stylesheet" href="css/styles.css">
</head>
<body>
    <nav class="navbar">
        <a href="dashboard.jsp" class="navbar-brand">Sunrise Dental</a>
        <ul class="navbar-nav">
            <li><a href="dashboard.jsp" class="navbar-link">Home</a></li>
            <li><a href="register.jsp" class="navbar-link active">Register Appointment</a></li>
            <li><a href="search.jsp" class="navbar-link">Search & Billing</a></li>
            <li><a href="help.jsp" class="navbar-link">Help</a></li>
            <li><span style="color: var(--text-secondary); margin-left: 10px;">Hello, <%= user %></span></li>
            <li><a href="logout" class="btn btn-secondary" style="padding: 6px 14px; font-size: 0.85rem; width: auto;">Logout</a></li>
        </ul>
    </nav>

    <main class="main-content" style="max-width: 600px;">
        <div class="header-brand" style="text-align: left; margin-bottom: 30px;">
            <h1>Register Appointment</h1>
            <p>Fill out the patient details below to schedule an appointment. Dentist bookings are automatically checked for conflicts.</p>
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

        <div class="glass-container" style="max-width: 100%; padding: 30px;">
            <form action="register-appointment" method="POST">
                <div class="form-group">
                    <label for="patientName">Patient Full Name</label>
                    <input type="text" id="patientName" name="patientName" class="form-input" placeholder="e.g. Hashen Shehara" required>
                </div>

                <div class="form-group">
                    <label for="address">Address</label>
                    <input type="text" id="address" name="address" class="form-input" placeholder="e.g. 123 Main St, Colombo" required>
                </div>

                <div class="form-group">
                    <label for="contactNumber">Contact Number (10 digits)</label>
                    <input type="text" id="contactNumber" name="contactNumber" class="form-input" placeholder="e.g. 0771234567" pattern="\d{10}" title="Must be exactly 10 digits" required>
                </div>

                <div class="form-group">
                    <label for="nicNumber">NIC Number</label>
                    <input type="text" id="nicNumber" name="nicNumber" class="form-input" placeholder="e.g. 200012345678 or 991234567V" pattern="(\d{12}|\d{9}[VvXx])" title="Enter 12-digit NIC or old 9-digit NIC ending with V/X" required>
                </div>

                <div style="display: grid; grid-template-columns: 1fr 1fr; gap: 20px;">
                    <div class="form-group">
                        <label for="dentistName">Assigned Dentist</label>
                        <select id="dentistName" name="dentistName" class="form-input form-select" required>
                            <option value="Dr. Kasun Perera">Dr. Kasun Perera</option>
                            <option value="Dr. Dilini Silva">Dr. Dilini Silva</option>
                            <option value="Dr. Aruni Jayasekara">Dr. Aruni Jayasekara</option>
                        </select>
                    </div>

                    <div class="form-group">
                        <label for="treatmentType">Treatment Type</label>
                        <select id="treatmentType" name="treatmentType" class="form-input form-select" required>
                            <option value="Teeth Cleaning">Teeth Cleaning (LKR 5,000)</option>
                            <option value="Dental Filling">Dental Filling (LKR 8,000)</option>
                            <option value="Tooth Extraction">Tooth Extraction (LKR 12,000)</option>
                        </select>
                    </div>
                </div>

                <div style="display: grid; grid-template-columns: 1fr 1fr; gap: 20px;">
                    <div class="form-group">
                        <label for="appointmentDate">Appointment Date</label>
                        <input type="date" id="appointmentDate" name="appointmentDate" class="form-input" required>
                    </div>

                    <div class="form-group">
                        <label for="appointmentTime">Appointment Time</label>
                        <input type="time" id="appointmentTime" name="appointmentTime" class="form-input" required>
                    </div>
                </div>

                <div style="display: flex; gap: 15px; margin-top: 10px;">
                    <a href="dashboard.jsp" class="btn btn-secondary">Cancel</a>
                    <button type="submit" class="btn btn-primary">Schedule Booking</button>
                </div>
            </form>
        </div>
    </main>
</body>
</html>
