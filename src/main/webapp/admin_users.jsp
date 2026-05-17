<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.reservation.model.User" %>
<%@ page import="com.reservation.service.UserService" %>
<%@ page import="java.util.List" %>
<%
    String role = (String) session.getAttribute("role");
    if (role == null || !role.equals("admin")) {
        response.sendRedirect("login.jsp");
        return;
    }
%>
<html>
<head>
    <title>User Management - Admin Portal</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        body { font-family: 'Poppins', sans-serif; background-color: #f4f7f6; margin: 0; }
        .admin-header { background: #1a1a1a; color: white; padding: 20px 40px; display: flex; justify-content: space-between; align-items: center; }
        .admin-header h2 { margin: 0; color: #f39c12; }
        .admin-header a { color: white; text-decoration: none; font-weight: bold; background: #dc3545; padding: 8px 15px; border-radius: 5px; }

        .admin-content { padding: 40px; max-width: 1200px; margin: 0 auto; }
        .table-container { background: #fff; border-radius: 10px; box-shadow: 0 4px 15px rgba(0,0,0,0.05); overflow: hidden; }
        .table-custom { width: 100%; border-collapse: collapse; text-align: left; }
        .table-custom th { background-color: #f8f9fa; color: #555; padding: 18px 20px; font-weight: 600; text-transform: uppercase; font-size: 13px; border-bottom: 2px solid #eee; }
        .table-custom td { padding: 18px 20px; border-bottom: 1px solid #f1f1f1; color: #444; font-size: 14px; }
        .btn-danger { background: #dc3545; color: white; border: none; padding: 6px 12px; border-radius: 4px; cursor: pointer; font-weight: bold; font-size: 12px; }
    </style>
</head>
<body>

<div class="admin-header">
    <h2><i class="fa-solid fa-utensils"></i> GrandEats Admin Portal</h2>
    <div>
        <span style="margin-right: 20px;"><i class="fa-solid fa-user-shield"></i> Manager</span>
        <a href="LogoutServlet">Logout</a>
    </div>
</div>

<div style="background: #333; padding: 15px 40px; display: flex; gap: 25px; box-shadow: 0 4px 6px rgba(0,0,0,0.1);">
    <a href="admin_dashboard.jsp" style="color: #ddd; text-decoration: none; font-weight: bold;"><i class="fa-solid fa-house"></i> Dashboard</a>
    <a href="admin_users.jsp" style="color: #f39c12; text-decoration: none; font-weight: bold;"><i class="fa-solid fa-users"></i> User Management</a>
    <a href="admin_menu.jsp" style="color: #ddd; text-decoration: none; font-weight: bold;"><i class="fa-solid fa-burger"></i> Menu</a>
    <a href="admin_messages.jsp" style="color: #ddd; text-decoration: none; font-weight: bold;"><i class="fa-solid fa-envelope"></i> Messages</a>
    <a href="admin_reports.jsp" style="color: #ddd; text-decoration: none; font-weight: bold;"><i class="fa-solid fa-chart-pie"></i> Reports</a>
</div>

<div class="admin-content">
    <h2 style="margin-top: 0; color: #1a1a1a;"><i class="fa-solid fa-users-gear" style="color: #f39c12;"></i> User Management</h2>
    <p style="color: #666; margin-bottom: 30px;">View and manage all registered customers in the system.</p>

    <% if(request.getParameter("msg") != null && request.getParameter("msg").equals("user_deleted")) { %>
    <div style="background: #d4edda; color: #155724; padding: 15px; border-radius: 8px; margin-bottom: 20px; font-weight: bold; border-left: 5px solid #28a745;">
        <i class="fa-solid fa-trash-can"></i> User account permanently deleted!
    </div>
    <% } %>

    <div class="table-container">
        <table class="table-custom">
            <thead>
            <tr>
                <th><i class="fa-regular fa-user"></i> Full Name</th>
                <th><i class="fa-regular fa-envelope"></i> Email Address</th>
                <th><i class="fa-solid fa-phone"></i> Phone Number</th>
                <th>Actions</th>
            </tr>
            </thead>
            <tbody>
            <%
                UserService us = new UserService();
                List<User> allUsers = us.getAllUsers();

                if(allUsers.isEmpty()) {
            %>
            <tr><td colspan="4" style="text-align: center; padding: 30px;">No registered users found.</td></tr>
            <%  } else {
                for(User u : allUsers) {
            %>
            <tr>
                <td><strong><%= u.getFullName() != null ? u.getFullName() : "User" %></strong></td>
                <td style="color: #0056b3;"><%= u.getEmail() %></td>
                <td><%= u.getPhoneNumber() != null ? u.getPhoneNumber() : "N/A" %></td>
                <td>
                    <form action="DeleteUserServlet" method="POST" style="margin: 0;">
                        <input type="hidden" name="userEmail" value="<%= u.getEmail() %>">
                        <button type="submit" class="btn-danger" onclick="return confirm('Are you sure you want to completely remove this user from the system?');">
                            <i class="fa-solid fa-trash-can"></i> Delete
                        </button>
                    </form>
                </td>
            </tr>
            <%      }
            }
            %>
            </tbody>
        </table>
    </div>
</div>
</body>
</html>test