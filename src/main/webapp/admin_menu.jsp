<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.reservation.model.MenuItem" %>
<%@ page import="com.reservation.service.MenuService" %>
<%@ page import="java.util.List" %>
<%
    String role = (String) session.getAttribute("role");
    if (role == null || !role.equals("admin")) { response.sendRedirect("login.jsp"); return; }
%>
<html>
<head>
    <title>Menu Management - Admin</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        body { font-family: 'Poppins', sans-serif; background-color: #f4f7f6; margin: 0; }
        .admin-header { background: #1a1a1a; color: white; padding: 20px 40px; display: flex; justify-content: space-between; align-items: center; }
        .admin-header h2 { margin: 0; color: #f39c12; }
        .admin-header a { color: white; text-decoration: none; font-weight: bold; background: #dc3545; padding: 8px 15px; border-radius: 5px; }
        .admin-content { padding: 40px; max-width: 1200px; margin: 0 auto; }
        .table-container { background: #fff; border-radius: 10px; box-shadow: 0 4px 15px rgba(0,0,0,0.05); overflow: hidden; margin-top: 20px;}
        .table-custom { width: 100%; border-collapse: collapse; text-align: left; }
        .table-custom th { background-color: #f8f9fa; color: #555; padding: 18px 20px; font-weight: 600; text-transform: uppercase; font-size: 13px; border-bottom: 2px solid #eee; }
        .table-custom td { padding: 18px 20px; border-bottom: 1px solid #f1f1f1; color: #444; font-size: 14px; vertical-align: middle;}
        .btn-add { background: #28a745; color: white; padding: 10px 20px; border: none; border-radius: 5px; font-weight: bold; cursor: pointer; float: right; text-decoration: none;}
        .action-buttons { display: flex; gap: 10px; }
    </style>
</head>
<body>
    <div class="admin-header">
        <h2><i class="fa-solid fa-utensils"></i> GrandEats Admin Portal</h2>
        <div><span style="margin-right: 20px;"><i class="fa-solid fa-user-shield"></i> Manager</span><a href="LogoutServlet">Logout</a></div>
    </div>

    <div style="background: #333; padding: 15px 40px; display: flex; gap: 25px; box-shadow: 0 4px 6px rgba(0,0,0,0.1);">
        <a href="admin_dashboard.jsp" style="color: #ddd; text-decoration: none; font-weight: bold;"><i class="fa-solid fa-house"></i> Dashboard</a>
        <a href="admin_users.jsp" style="color: #ddd; text-decoration: none; font-weight: bold;"><i class="fa-solid fa-users"></i> User Management</a>
        <a href="admin_menu.jsp" style="color: #f39c12; text-decoration: none; font-weight: bold;"><i class="fa-solid fa-burger"></i> Menu</a>
        <a href="admin_messages.jsp" style="color: #ddd; text-decoration: none; font-weight: bold;"><i class="fa-solid fa-envelope"></i> Messages</a>
        <a href="admin_reports.jsp" style="color: #ddd; text-decoration: none; font-weight: bold;"><i class="fa-solid fa-chart-pie"></i> Reports</a>
    </div>

    <div class="admin-content">
        <a href="add_menu_item.jsp" class="btn-add"><i class="fa-solid fa-plus"></i> Add New Item</a>

        <h2 style="margin-top: 0; color: #1a1a1a;"><i class="fa-solid fa-burger" style="color: #f39c12;"></i> Restaurant Menu</h2>
        <p style="color: #666;">Manage your food and beverage offerings here.</p>

        <% if(request.getParameter("msg") != null) {
            if(request.getParameter("msg").equals("item_added")) { %>
                <div style="background: #d4edda; color: #155724; padding: 15px; border-radius: 8px; margin-bottom: 20px; font-weight: bold; border-left: 5px solid #28a745;">
                    <i class="fa-solid fa-circle-check"></i> New Menu Item added successfully!
                </div>
        <%  } else if(request.getParameter("msg").equals("item_updated")) { %>
                <div style="background: #cce5ff; color: #004085; padding: 15px; border-radius: 8px; margin-bottom: 20px; font-weight: bold; border-left: 5px solid #007bff;">
                    <i class="fa-solid fa-pen-to-square"></i> Menu Item updated successfully!
                </div>
        <%  } else if(request.getParameter("msg").equals("item_deleted")) { %>
                <div style="background: #f8d7da; color: #721c24; padding: 15px; border-radius: 8px; margin-bottom: 20px; font-weight: bold; border-left: 5px solid #dc3545;">
                    <i class="fa-solid fa-trash-can"></i> Menu Item deleted successfully!
                </div>
        <%  }
        } %>

        <div class="table-container">
            <table class="table-custom">
                <thead><tr><th>Item Image</th><th>Item Name</th><th>Category</th><th>Price (Rs.)</th><th>Status</th><th>Actions</th></tr></thead>
                <tbody>
                    <%
                        MenuService ms = new MenuService();
                        List<MenuItem> menuItems = ms.getAllMenuItems();

                        if(menuItems.isEmpty()) {
                    %>
                        <tr><td colspan="6" style="text-align: center; padding: 40px; color: #777;">No menu items found. Please add a new item.</td></tr>
                    <%  } else {
                            for(MenuItem m : menuItems) {
                    %>
                        <tr>
                            <td><img src="<%= m.getImageUrl() %>" width="40" height="40" style="border-radius: 5px; object-fit: cover;"></td>
                            <td><strong><%= m.getName() %></strong></td>
                            <td><%= m.getCategory() %></td>
                            <td><%= m.getPrice() %></td>
                            <td>
                                <% if("Available".equals(m.getStatus())) { %>
                                    <span style="color: #28a745; font-weight: bold;"><i class="fa-solid fa-check-circle"></i> Available</span>
                                <% } else { %>
                                    <span style="color: #dc3545; font-weight: bold;"><i class="fa-solid fa-times-circle"></i> Out of Stock</span>
                                <% } %>
                            </td>
                            <td>
                                <div class="action-buttons">
                                    <a href="edit_menu_item.jsp?id=<%= m.getId() %>" style="background: #f39c12; text-decoration: none; padding: 6px 12px; color:white; border-radius:4px; font-weight: bold; cursor:pointer; display: inline-block;">
                                        <i class="fa-solid fa-pen-to-square"></i> Edit
                                    </a>

                                    <a href="DeleteMenuItemServlet?id=<%= m.getId() %>" onclick="return confirm('Are you sure you want to delete this item?');" style="background: #dc3545; text-decoration: none; padding: 6px 12px; color:white; border-radius:4px; font-weight: bold; cursor:pointer; display: inline-block;">
                                        <i class="fa-solid fa-trash"></i> Delete
                                    </a>
                                </div>
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
</html>