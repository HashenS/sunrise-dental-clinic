<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login - Sunrise Dental Clinic</title>
    <link rel="stylesheet" href="css/styles.css">
</head>
<body>
    <div style="display: flex; min-height: 100vh; align-items: center; justify-content: center; padding: 20px;">
        <div class="glass-container">
            <div class="header-brand">
                <h1>Sunrise Dental</h1>
                <p>Clinic Management System Login</p>
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

            <form action="login" method="POST">
                <div class="form-group">
                    <label for="username">Username</label>
                    <input type="text" id="username" name="username" class="form-input" placeholder="Enter username" required autocomplete="username">
                </div>
                
                <div class="form-group">
                    <label for="password">Password</label>
                    <input type="password" id="password" name="password" class="form-input" placeholder="Enter password" required autocomplete="current-password">
                </div>

                <button type="submit" class="btn btn-primary" style="margin-top: 10px;">Sign In</button>
            </form>
            
            <div style="text-align: center; margin-top: 20px; font-size: 0.85rem; color: var(--text-secondary);">
                Only authorized clinic staff can access this portal.
            </div>
        </div>
    </div>
</body>
</html>
