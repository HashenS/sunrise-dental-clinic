<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    if (session.getAttribute("user") == null) {
        response.sendRedirect("login.jsp");
        return;
    }
    String user     = (String) session.getAttribute("user");
    boolean isAdmin = "ADMIN".equals(session.getAttribute("userRole"));
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Help & Instructions - Sunrise Dental Clinic</title>
    <link rel="stylesheet" href="css/styles.css">
</head>
<body>
    <nav class="navbar">
        <a href="dashboard.jsp" class="navbar-brand">Sunrise Dental</a>
        <ul class="navbar-nav">
            <li><a href="dashboard.jsp" class="navbar-link">Home</a></li>
            <li><a href="register.jsp" class="navbar-link">Register Appointment</a></li>
            <li><a href="search.jsp" class="navbar-link">Search & Billing</a></li>
            <% if (isAdmin) { %><li><a href="manage-staff" class="navbar-link">Manage Staff</a></li><% } %>
            <li><a href="help.jsp" class="navbar-link active">Help</a></li>
            <li><span style="color: var(--text-secondary); margin-left: 10px;">Hello, <%= user %></span></li>
            <li><a href="logout" class="btn btn-secondary" style="padding: 6px 14px; font-size: 0.85rem; width: auto;">Logout</a></li>
        </ul>
    </nav>

    <main class="main-content" style="max-width: 800px;">
        <div class="header-brand" style="text-align: left; margin-bottom: 35px;">
            <h1>System Help & Instructions</h1>
            <p>Learn how to operate the Sunrise Dental Clinic Appointment and Patient Management System.</p>
        </div>

        <div class="glass-container" style="max-width: 100%; padding: 35px; margin-bottom: 30px; text-align: left;">
            
            <h3 style="color: var(--accent-color); margin-bottom: 15px; border-bottom: 1px solid var(--border-color); padding-bottom: 8px;">1. User Authentication</h3>
            <p style="color: var(--text-secondary); font-size: 0.95rem; line-height: 1.6; margin-bottom: 25px;">
                Secure access is restricted to authorized clinic reception staff. Log in with your registered username and password. The system will automatically establish a secure session. To exit the session securely, click the <strong>Logout</strong> button in the top right navigation bar.
            </p>

            <h3 style="color: var(--accent-color); margin-bottom: 15px; border-bottom: 1px solid var(--border-color); padding-bottom: 8px;">2. Registering an Appointment</h3>
            <p style="color: var(--text-secondary); font-size: 0.95rem; line-height: 1.6; margin-bottom: 25px;">
                To register a new patient visit, navigate to the <strong>Register Appointment</strong> page. Input the patient's full name, address, contact number (exactly 10 digits), and select the assigned dentist and treatment type. Provide the desired appointment date and time.
                <br><br>
                <em>Double-Booking Check:</em> Upon clicking <strong>Schedule Booking</strong>, the system checks whether the selected dentist is already booked at that date and time. If a conflict exists, registration will fail with a warning, prompting you to select a different slot.
            </p>

            <h3 style="color: var(--accent-color); margin-bottom: 15px; border-bottom: 1px solid var(--border-color); padding-bottom: 8px;">3. Lookups and Searching</h3>
            <p style="color: var(--text-secondary); font-size: 0.95rem; line-height: 1.6; margin-bottom: 25px;">
                Access the <strong>Search & Billing</strong> portal. Enter the unique appointment number (e.g., <code>APT-12345</code>) to fetch patient details, dentist scheduling, and invoice status.
            </p>

            <h3 style="color: var(--accent-color); margin-bottom: 15px; border-bottom: 1px solid var(--border-color); padding-bottom: 8px;">4. Invoicing and Payments</h3>
            <p style="color: var(--text-secondary); font-size: 0.95rem; line-height: 1.6; margin-bottom: 15px;">
                Once an appointment is located:
            </p>
            <ul style="color: var(--text-secondary); font-size: 0.95rem; line-height: 1.6; padding-left: 20px; margin-bottom: 25px;">
                <li>If an invoice hasn't been generated, enter the consultation fee (default is LKR 2,000) and click <strong>Generate Invoice</strong>.</li>
                <li>The system will dynamically calculate the total cost based on the assigned treatment billing strategy (Singleton and Factory pattern logic).</li>
                <li>To print the invoice, click the <strong>Print Invoice</strong> button. The stylesheet is optimized for print, omitting navigation items.</li>
                <li>After collecting the cash, click <strong>Mark as Paid</strong> to update the invoice status in the database.</li>
            </ul>

            <div style="text-align: center; margin-top: 30px; border-top: 1px solid var(--border-color); padding-top: 20px;">
                <a href="dashboard.jsp" class="btn btn-primary" style="width: auto; padding: 12px 40px;">Return to Dashboard</a>
            </div>
        </div>
    </main>
</body>
</html>
