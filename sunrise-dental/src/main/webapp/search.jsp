<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.sunrisedental.model.Appointment"%>
<%@ page import="com.sunrisedental.model.Bill"%>
<%@ page import="java.util.List"%>
<%
    if (session.getAttribute("user") == null) {
        response.sendRedirect("login.jsp");
        return;
    }
    // If loaded directly (not via servlet), redirect through servlet to load history
    if (request.getAttribute("history") == null) {
        response.sendRedirect("search-appointment");
        return;
    }
    String user = (String) session.getAttribute("user");
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Search &amp; Billing - Sunrise Dental Clinic</title>
    <link rel="stylesheet" href="css/styles.css">
    <style>
        .search-tabs { display: flex; gap: 0; margin-bottom: 0; }
        .search-tab {
            padding: 10px 24px; cursor: pointer; border: 1px solid var(--border-color);
            background: var(--bg-surface); color: var(--text-secondary);
            font-size: 0.9rem; font-weight: 500; transition: all 0.2s;
        }
        .search-tab:first-child { border-radius: 10px 0 0 0; }
        .search-tab:last-child  { border-radius: 0 10px 0 0; }
        .search-tab.active { background: var(--accent-color); color: #fff; border-color: var(--accent-color); }
        .tab-panel { display: none; }
        .tab-panel.active { display: block; }
        .nic-list-table { width: 100%; border-collapse: collapse; font-size: 0.9rem; }
        .nic-list-table th, .nic-list-table td { padding: 12px 15px; text-align: left; border-bottom: 1px solid var(--border-color); }
        .nic-list-table th { background: rgba(99,102,241,0.1); color: var(--text-primary); font-weight: 600; }
        .nic-list-table tr:hover td { background: rgba(99,102,241,0.05); }
    </style>
</head>
<body>
    <nav class="navbar">
        <a href="dashboard.jsp" class="navbar-brand">Sunrise Dental</a>
        <ul class="navbar-nav">
            <li><a href="dashboard.jsp" class="navbar-link">Home</a></li>
            <li><a href="register.jsp" class="navbar-link">Register Appointment</a></li>
            <li><a href="search.jsp" class="navbar-link active">Search &amp; Billing</a></li>
            <li><a href="help.jsp" class="navbar-link">Help</a></li>
            <li><span style="color: var(--text-secondary); margin-left: 10px;">Hello, <%= user %></span></li>
            <li><a href="logout" class="btn btn-secondary" style="padding: 6px 14px; font-size: 0.85rem; width: auto;">Logout</a></li>
        </ul>
    </nav>

    <main class="main-content" style="max-width: 850px;">
        <div class="header-brand" style="text-align: left; margin-bottom: 30px;">
            <h1>Search &amp; Billing</h1>
            <p>Search appointments by appointment number or patient NIC to view details and process billing.</p>
        </div>

        <!-- Search Box with Tabs -->
        <div class="glass-container" style="max-width: 100%; padding: 0; margin-bottom: 30px; overflow: hidden;">
            <div class="search-tabs">
                <div class="search-tab active" id="tab-appt" onclick="switchTab('appt')">🔢 Appointment Number</div>
                <div class="search-tab" id="tab-nic" onclick="switchTab('nic')">🪪 NIC Number</div>
            </div>

            <!-- Tab 1: Search by Appointment Number -->
            <div class="tab-panel active" id="panel-appt" style="padding: 25px;">
                <form action="search-appointment" method="GET" style="display: flex; gap: 15px; align-items: flex-end; flex-wrap: wrap;">
                    <div class="form-group" style="flex: 1; min-width: 250px; margin-bottom: 0;">
                        <label for="appointmentNumber" style="margin-bottom: 6px;">Appointment Number</label>
                        <input type="text" id="appointmentNumber" name="appointmentNumber" class="form-input"
                               placeholder="e.g. APT-12345"
                               value="<%= request.getParameter("appointmentNumber") != null ? request.getParameter("appointmentNumber") : "" %>">
                    </div>
                    <button type="submit" class="btn btn-primary" style="width: auto; padding: 12px 30px;">Search</button>
                </form>
            </div>

            <!-- Tab 2: Search by NIC -->
            <div class="tab-panel" id="panel-nic" style="padding: 25px;">
                <form action="search-appointment" method="GET" style="display: flex; gap: 15px; align-items: flex-end; flex-wrap: wrap;">
                    <div class="form-group" style="flex: 1; min-width: 250px; margin-bottom: 0;">
                        <label for="nicNumber" style="margin-bottom: 6px;">Patient NIC Number</label>
                        <input type="text" id="nicNumber" name="nicNumber" class="form-input"
                               placeholder="e.g. 200012345678 or 991234567V"
                               value="<%= request.getParameter("nicNumber") != null ? request.getParameter("nicNumber") : "" %>">
                    </div>
                    <button type="submit" class="btn btn-primary" style="width: auto; padding: 12px 30px;">Search</button>
                </form>
            </div>
        </div>

        <!-- Error Message -->
        <%
            String errorMessage = (String) request.getAttribute("errorMessage");
            if (errorMessage != null) {
        %>
            <div class="alert alert-danger">
                <span>⚠️</span> <%= errorMessage %>
            </div>
        <%  } %>

        <!-- Result: Single Appointment (by Number) -->
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
                        <th>NIC Number</th>
                        <td><%= appt.getNicNumber() %></td>
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
                        <th>Date &amp; Time</th>
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
        <%  } %>

        <!-- Result: Multiple Appointments by NIC -->
        <%
            List<Appointment> apptList = (List<Appointment>) request.getAttribute("appointmentList");
            String searchedNic = (String) request.getAttribute("searchedNic");
            if (apptList != null && !apptList.isEmpty()) {
        %>
            <div class="table-container" style="padding: 30px; background: var(--bg-surface); border: 1px solid var(--border-color); border-radius: 16px;">
                <h3 style="margin-bottom: 6px;">Appointments for NIC: <span style="color: var(--accent-color);"><%= searchedNic %></span></h3>
                <p style="color: var(--text-secondary); font-size: 0.9rem; margin-bottom: 20px;"><%= apptList.size() %> appointment(s) found</p>
                <table class="nic-list-table">
                    <thead>
                        <tr>
                            <th>Appt No</th>
                            <th>Patient Name</th>
                            <th>Dentist</th>
                            <th>Treatment</th>
                            <th>Date</th>
                            <th>Action</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%  for (Appointment a : apptList) { %>
                        <tr>
                            <td><strong style="color: var(--accent-color);"><%= a.getAppointmentNumber() %></strong></td>
                            <td><%= a.getPatientName() %></td>
                            <td><%= a.getDentistName() %></td>
                            <td><%= a.getTreatmentType() %></td>
                            <td><%= a.getAppointmentDate() %></td>
                            <td>
                                <a href="search-appointment?appointmentNumber=<%= a.getAppointmentNumber() %>"
                                   class="btn btn-secondary" style="width: auto; padding: 6px 14px; font-size: 0.82rem;">
                                   View &amp; Bill
                                </a>
                            </td>
                        </tr>
                        <%  } %>
                    </tbody>
                </table>
            </div>
        <%  } %>

        <!-- ===== Appointment History Panel ===== -->
        <%
            List<Appointment> history = (List<Appointment>) request.getAttribute("history");
            if (history != null) {
        %>
        <div style="margin-top: 40px;">
            <div style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 16px;">
                <h2 style="font-size: 1.15rem; margin: 0;">📋 Appointment History</h2>
                <span style="font-size: 0.85rem; color: var(--text-secondary);"><%= history.size() %> total record<%= history.size() != 1 ? "s" : "" %> &nbsp;•&nbsp; Latest first</span>
            </div>

            <% if (history.isEmpty()) { %>
                <div class="glass-container" style="text-align: center; padding: 40px; color: var(--text-secondary);">
                    <p style="font-size: 1.3rem;">📭</p>
                    <p>No appointments registered yet.</p>
                </div>
            <% } else { %>
            <div style="background: var(--bg-surface); border: 1px solid var(--border-color); border-radius: 16px; overflow: hidden;">
                <table style="width: 100%; border-collapse: collapse; font-size: 0.875rem;">
                    <thead>
                        <tr style="background: rgba(99,102,241,0.12);">
                            <th style="padding: 12px 16px; text-align: left; font-weight: 600; color: var(--text-primary);">Appt No</th>
                            <th style="padding: 12px 16px; text-align: left; font-weight: 600; color: var(--text-primary);">Patient</th>
                            <th style="padding: 12px 16px; text-align: left; font-weight: 600; color: var(--text-primary);">NIC</th>
                            <th style="padding: 12px 16px; text-align: left; font-weight: 600; color: var(--text-primary);">Dentist</th>
                            <th style="padding: 12px 16px; text-align: left; font-weight: 600; color: var(--text-primary);">Treatment</th>
                            <th style="padding: 12px 16px; text-align: left; font-weight: 600; color: var(--text-primary);">Date</th>
                            <th style="padding: 12px 16px; text-align: left; font-weight: 600; color: var(--text-primary);">Time</th>
                            <th style="padding: 12px 16px; text-align: center; font-weight: 600; color: var(--text-primary);">Action</th>
                        </tr>
                    </thead>
                    <tbody>
                        <% for (Appointment h : history) { %>
                        <tr style="border-top: 1px solid var(--border-color); transition: background 0.15s;"
                            onmouseover="this.style.background='rgba(99,102,241,0.05)'"
                            onmouseout="this.style.background=''">>
                            <td style="padding: 11px 16px;"><strong style="color: var(--accent-color);"><%= h.getAppointmentNumber() %></strong></td>
                            <td style="padding: 11px 16px;"><%= h.getPatientName() %></td>
                            <td style="padding: 11px 16px; font-family: monospace; font-size: 0.82rem; color: var(--text-secondary);"><%= h.getNicNumber() %></td>
                            <td style="padding: 11px 16px;"><%= h.getDentistName() %></td>
                            <td style="padding: 11px 16px;"><%= h.getTreatmentType() %></td>
                            <td style="padding: 11px 16px;"><%= h.getAppointmentDate() %></td>
                            <td style="padding: 11px 16px;"><%= h.getAppointmentTime() %></td>
                            <td style="padding: 11px 16px; text-align: center;">
                                <a href="search-appointment?appointmentNumber=<%= h.getAppointmentNumber() %>"
                                   style="color: var(--accent-color); text-decoration: none; font-weight: 600; font-size: 0.82rem;">View</a>
                            </td>
                        </tr>
                        <% } %>
                    </tbody>
                </table>
            </div>
            <% } %>
        </div>
        <% } %>

    </main>

    <script>
        function switchTab(tab) {
            document.querySelectorAll('.search-tab').forEach(t => t.classList.remove('active'));
            document.querySelectorAll('.tab-panel').forEach(p => p.classList.remove('active'));
            document.getElementById('tab-' + tab).classList.add('active');
            document.getElementById('panel-' + tab).classList.add('active');
        }
        // Auto-activate NIC tab if nicNumber param is in URL
        if (new URLSearchParams(window.location.search).get('nicNumber')) {
            switchTab('nic');
        }
    </script>
</body>
</html>
