<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    if (session.getAttribute("user") == null) {
        response.sendRedirect("login.jsp");
        return;
    }
    String user     = (String) session.getAttribute("user");
    String userRole = (String) session.getAttribute("userRole");
    boolean isAdmin = "ADMIN".equals(userRole);
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Dashboard - Sunrise Dental Clinic</title>
    <link rel="stylesheet" href="css/styles.css">
</head>
<body>
    <nav class="navbar">
        <a href="dashboard.jsp" class="navbar-brand">Sunrise Dental</a>
        <ul class="navbar-nav">
            <li><a href="dashboard.jsp" class="navbar-link active">Home</a></li>
            <li><a href="register.jsp" class="navbar-link">Register Appointment</a></li>
            <li><a href="search-appointment" class="navbar-link">Search &amp; Billing</a></li>
            <% if (isAdmin) { %>
            <li><a href="manage-staff" class="navbar-link">Manage Staff</a></li>
            <% } %>
            <li><a href="help.jsp" class="navbar-link">Help</a></li>
            <% if (isAdmin) { %>
            <li><span style="color: #f87171; margin-left: 10px; font-size: 0.8rem; font-weight:600;">● ADMIN</span></li>
            <% } %>
            <li><span style="color: var(--text-secondary); margin-left: 6px;">Hello, <%= user %></span></li>
            <li><a href="logout" class="btn btn-secondary" style="padding: 6px 14px; font-size: 0.85rem; width: auto;">Logout</a></li>
        </ul>
    </nav>

    <main class="main-content">
        <div class="header-brand" style="text-align: left; margin-bottom: 40px;">
            <h1>Clinic Dashboard</h1>
            <p>Welcome back, <%= user %><% if (isAdmin) { %> <span style="color:#f87171; font-size:0.85rem;">(Administrator)</span><% } %>. Access patient appointment registrations, lookups, and invoices below.</p>
        </div>

        <%
            String successMessage = request.getParameter("successMessage");
            if (successMessage != null) {
        %>
            <div class="alert alert-success" style="max-width: 100%; margin-bottom: 30px;">
                <span>✓</span> <%= successMessage %>
            </div>
        <%
            }
        %>

        <div class="grid-container">
            <a href="register.jsp" class="menu-card">
                <span class="menu-card-icon">📅</span>
                <h3>Register Appointment</h3>
                <p>Add new patients to the schedule, assign dentist schedules, and perform conflict checks.</p>
            </a>

            <a href="search-appointment" class="menu-card">
                <span class="menu-card-icon">🔍</span>
                <h3>Search &amp; Billing</h3>
                <p>Search patient appointments by number or NIC, calculate costs, and print professional invoices.</p>
            </a>

            <% if (isAdmin) { %>
            <a href="manage-staff" class="menu-card" style="border-color: rgba(239,68,68,0.3);">
                <span class="menu-card-icon">👥</span>
                <h3>Manage Staff</h3>
                <p>Add new clinic staff members, view all accounts, or remove access permissions.</p>
            </a>
            <% } %>

            <a href="help.jsp" class="menu-card">
                <span class="menu-card-icon">📘</span>
                <h3>Help &amp; Guide</h3>
                <p>View step-by-step instructions on operating the appointment scheduler and billing console.</p>
            </a>
        </div>
    </main>
</body>
</html>
