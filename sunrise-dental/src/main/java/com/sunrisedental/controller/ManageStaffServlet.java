package com.sunrisedental.controller;

import com.sunrisedental.dao.UserDAO;
import com.sunrisedental.model.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet("/manage-staff")
public class ManageStaffServlet extends HttpServlet {
    private final UserDAO userDAO = new UserDAO();

    private boolean isAdmin(HttpServletRequest request) {
        return "ADMIN".equals(request.getSession().getAttribute("userRole"));
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        if (request.getSession().getAttribute("user") == null) {
            response.sendRedirect("login.jsp");
            return;
        }
        if (!isAdmin(request)) {
            response.sendRedirect("dashboard.jsp");
            return;
        }

        List<User> users = userDAO.findAll();
        request.setAttribute("staffList", users);
        request.getRequestDispatcher("staff-management.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        if (request.getSession().getAttribute("user") == null) {
            response.sendRedirect("login.jsp");
            return;
        }
        if (!isAdmin(request)) {
            response.sendRedirect("dashboard.jsp");
            return;
        }

        String action = request.getParameter("action");

        if ("add".equals(action)) {
            String username = request.getParameter("username");
            String password = request.getParameter("password");
            String role     = request.getParameter("role");

            if (username == null || username.trim().isEmpty() ||
                password == null || password.trim().isEmpty()) {
                request.setAttribute("errorMessage", "Username and password are required.");
            } else {
                boolean added = userDAO.addUser(username.trim(), password.trim(),
                        role != null ? role : "RECEPTIONIST");
                if (added) {
                    request.setAttribute("successMessage",
                            "Staff member '" + username.trim() + "' added successfully.");
                } else {
                    request.setAttribute("errorMessage",
                            "Failed to add staff member. Username may already exist.");
                }
            }

        } else if ("delete".equals(action)) {
            String idStr        = request.getParameter("userId");
            String targetUser   = request.getParameter("targetUsername");

            // Protect the admin account from self-deletion
            if ("admin".equals(targetUser)) {
                request.setAttribute("errorMessage", "The admin account cannot be deleted.");
            } else {
                try {
                    int id = Integer.parseInt(idStr);
                    if (userDAO.deleteUser(id)) {
                        request.setAttribute("successMessage",
                                "Staff member '" + targetUser + "' deleted.");
                    } else {
                        request.setAttribute("errorMessage", "Failed to delete staff member.");
                    }
                } catch (NumberFormatException e) {
                    request.setAttribute("errorMessage", "Invalid user ID.");
                }
            }
        }

        // Reload list and forward back to the page
        request.setAttribute("staffList", userDAO.findAll());
        request.getRequestDispatcher("staff-management.jsp").forward(request, response);
    }
}
