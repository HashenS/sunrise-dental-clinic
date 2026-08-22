<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.sunrisedental.model.User"%>
<%@ page import="java.util.List"%>
<%
    if (session.getAttribute("user") == null) {
        response.sendRedirect("login.jsp");
        return;
    }
    if (!"ADMIN".equals(session.getAttribute("userRole"))) {
        response.sendRedirect("dashboard.jsp");
        return;
    }
    String currentUser = (String) session.getAttribute("user");
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Manage Staff - Sunrise Dental Clinic</title>
    <link rel="stylesheet" href="css/styles.css">
    <style>
        .role-badge {
            display: inline-block;
            padding: 3px 10px;
            border-radius: 20px;
            font-size: 0.75rem;
            font-weight: 600;
            letter-spacing: 0.04em;
        }
        .role-admin       { background: rgba(239,68,68,0.15); color: #f87171; }
        .role-receptionist{ background: rgba(99,102,241,0.15); color: #818cf8; }
        .btn-danger-sm {
            background: rgba(239,68,68,0.15);
            color: #f87171;
            border: 1px solid rgba(239,68,68,0.3);
            padding: 5px 14px;
            border-radius: 8px;
            font-size: 0.8rem;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.2s;
        }
        .btn-danger-sm:hover { background: rgba(239,68,68,0.35); }
    </style>
</head>
<body>
    <nav class="navbar">
        <a href="dashboard.jsp" class="navbar-brand">Sunrise Dental</a>
        <ul class="navbar-nav">
            <li><a href="dashboard.jsp" class="navbar-link">Home</a></li>
            <li><a href="register.jsp" class="navbar-link">Register Appointment</a></li>
            <li><a href="search-appointment" class="navbar-link">Search &amp; Billing</a></li>
            <li><a href="manage-staff" class="navbar-link active">Manage Staff</a></li>
            <li><a href="help.jsp" class="navbar-link">Help</a></li>
            <li><span style="color: #f87171; margin-left: 10px; font-size: 0.8rem; font-weight:600;">● ADMIN</span></li>
            <li><span style="color: var(--text-secondary); margin-left: 6px;">Hello, <%= currentUser %></span></li>
            <li><a href="logout" class="btn btn-secondary" style="padding: 6px 14px; font-size: 0.85rem; width: auto;">Logout</a></li>
        </ul>
    </nav>

    <main class="main-content" style="max-width: 800px;">
        <div class="header-brand" style="text-align: left; margin-bottom: 30px;">
            <h1>Manage Staff</h1>
            <p>Add new clinic staff members, view all accounts, or remove access. The admin account cannot be deleted.</p>
        </div>

        <!-- Messages -->
        <%
            String error   = (String) request.getAttribute("errorMessage");
            String success = (String) request.getAttribute("successMessage");
            if (error != null) {
        %>
            <div class="alert alert-danger" style="margin-bottom: 20px;">⚠️ <%= error %></div>
        <% } if (success != null) { %>
            <div class="alert" style="background: rgba(34,197,94,0.1); border: 1px solid rgba(34,197,94,0.3); color: #4ade80; padding: 14px 20px; border-radius: 10px; margin-bottom: 20px;">
                ✅ <%= success %>
            </div>
        <% } %>

        <!-- Add Staff Form -->
        <div class="glass-container" style="max-width: 100%; padding: 28px; margin-bottom: 35px;">
            <h3 style="margin-bottom: 20px; font-size: 1rem;">➕ Add New Staff Member</h3>
            <form action="manage-staff" method="POST">
                <input type="hidden" name="action" value="add">
                <div style="display: grid; grid-template-columns: 1fr 1fr 1fr; gap: 16px; align-items: end;">
                    <div class="form-group" style="margin-bottom: 0;">
                        <label for="username">Username</label>
                        <input type="text" id="username" name="username" class="form-input"
                               placeholder="e.g. nurse01" required>
                    </div>
                    <div class="form-group" style="margin-bottom: 0;">
                        <label for="password">Password</label>
                        <input type="password" id="password" name="password" class="form-input"
                               placeholder="Enter password" required>
                    </div>
                    <div class="form-group" style="margin-bottom: 0;">
                        <label for="role">Role</label>
                        <select id="role" name="role" class="form-input form-select">
                            <option value="RECEPTIONIST">Receptionist (Staff)</option>
                            <option value="ADMIN">Admin</option>
                        </select>
                    </div>
                </div>
                <button type="submit" class="btn btn-primary" style="margin-top: 20px; width: auto; padding: 11px 30px;">
                    Add Staff Member
                </button>
            </form>
        </div>

        <!-- Staff List -->
        <%
            List<User> staffList = (List<User>) request.getAttribute("staffList");
        %>
        <div style="background: var(--bg-surface); border: 1px solid var(--border-color); border-radius: 16px; overflow: hidden;">
            <div style="padding: 20px 24px; border-bottom: 1px solid var(--border-color); display: flex; justify-content: space-between; align-items: center;">
                <h3 style="margin: 0; font-size: 1rem;">👥 All Staff Members</h3>
                <span style="font-size: 0.85rem; color: var(--text-secondary);"><%= staffList != null ? staffList.size() : 0 %> account(s)</span>
            </div>
            <table style="width: 100%; border-collapse: collapse; font-size: 0.88rem;">
                <thead>
                    <tr style="background: rgba(99,102,241,0.1);">
                        <th style="padding: 12px 20px; text-align: left; font-weight: 600;">#</th>
                        <th style="padding: 12px 20px; text-align: left; font-weight: 600;">Username</th>
                        <th style="padding: 12px 20px; text-align: left; font-weight: 600;">Role</th>
                        <th style="padding: 12px 20px; text-align: center; font-weight: 600;">Action</th>
                    </tr>
                </thead>
                <tbody>
                    <% if (staffList != null) { for (User u : staffList) { %>
                    <tr style="border-top: 1px solid var(--border-color);">
                        <td style="padding: 13px 20px; color: var(--text-secondary);"><%= u.getId() %></td>
                        <td style="padding: 13px 20px; font-weight: 500;">
                            <%= u.getUsername() %>
                            <% if (u.getUsername().equals(currentUser)) { %>
                                <span style="font-size:0.75rem; color: var(--text-secondary);"> (you)</span>
                            <% } %>
                        </td>
                        <td style="padding: 13px 20px;">
                            <span class="role-badge <%= "ADMIN".equals(u.getRole()) ? "role-admin" : "role-receptionist" %>">
                                <%= u.getRole() %>
                            </span>
                        </td>
                        <td style="padding: 13px 20px; text-align: center;">
                            <% if (!"admin".equals(u.getUsername())) { %>
                            <form action="manage-staff" method="POST" style="display:inline;"
                                  onsubmit="return confirm('Delete staff member \'<%= u.getUsername() %>\'?');">
                                <input type="hidden" name="action"         value="delete">
                                <input type="hidden" name="userId"         value="<%= u.getId() %>">
                                <input type="hidden" name="targetUsername" value="<%= u.getUsername() %>">
                                <button type="submit" class="btn-danger-sm">Delete</button>
                            </form>
                            <% } else { %>
                            <span style="font-size: 0.78rem; color: var(--text-secondary);">Protected</span>
                            <% } %>
                        </td>
                    </tr>
                    <% } } %>
                </tbody>
            </table>
        </div>
    </main>
</body>
</html>
