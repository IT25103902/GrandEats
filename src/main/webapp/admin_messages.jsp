<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.reservation.model.Message" %>
<%@ page import="com.reservation.service.MessageService" %>
<%@ page import="java.util.List" %>
<%
    // Security Check: Restrict dashboard access to authorized admin accounts only
    String role = (String) session.getAttribute("role");
    if (role == null || !role.equals("admin")) {
        response.sendRedirect("login.jsp");
        return;
    }
%>
<html>
<head>
    <title>Messages - Admin</title>
    <!-- FontAwesome & SweetAlert2 Libraries -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>

    <style>
        body { font-family: 'Poppins', sans-serif; background-color: #f4f7f6; margin: 0; }
        .admin-header { background: #1a1a1a; color: white; padding: 20px 40px; display: flex; justify-content: space-between; align-items: center; }
        .admin-header h2 { margin: 0; color: #f39c12; }
        .admin-header a { color: white; text-decoration: none; font-weight: bold; background: #dc3545; padding: 8px 15px; border-radius: 5px; }
        .admin-content { padding: 40px; max-width: 1200px; margin: 0 auto; }

        .msg-card { background: white; padding: 20px; border-radius: 8px; box-shadow: 0 2px 10px rgba(0,0,0,0.05); margin-bottom: 15px; border-left: 5px solid #17a2b8; transition: 0.3s;}
        .msg-header { display: flex; justify-content: space-between; margin-bottom: 10px; color: #555; font-size: 14px; align-items: center;}

        .btn-action { padding:6px 15px; border-radius:4px; font-size:13px; font-weight:bold; cursor: pointer; border: none; text-decoration: none; display: inline-block;}
        .btn-email { background:#6c757d; color:white; }
        .btn-reply { background:#28a745; color:white; }
        .btn-delete { background:#dc3545; color:white; }

        /* Status Badges Styling */
        .badge { padding: 4px 10px; border-radius: 12px; font-size: 12px; font-weight: bold; margin-left: 10px; color: white; }
        .badge-pending { background-color: #f39c12; }
        .badge-replied { background-color: #28a745; }
    </style>
</head>
<body>
    <!-- Main Top Navigation Header -->
    <div class="admin-header">
        <h2><i class="fa-solid fa-utensils"></i> GrandEats Admin Portal</h2>
        <div><span style="margin-right: 20px;"><i class="fa-solid fa-user-shield"></i> Manager</span><a href="LogoutServlet">Logout</a></div>
    </div>

    <!-- Secondary Portal Tab Links -->
    <div style="background: #333; padding: 15px 40px; display: flex; gap: 25px; box-shadow: 0 4px 6px rgba(0,0,0,0.1);">
        <a href="admin_dashboard.jsp" style="color: #ddd; text-decoration: none; font-weight: bold;"><i class="fa-solid fa-house"></i> Dashboard</a>
        <a href="admin_users.jsp" style="color: #ddd; text-decoration: none; font-weight: bold;"><i class="fa-solid fa-users"></i> User Management</a>
        <a href="admin_menu.jsp" style="color: #ddd; text-decoration: none; font-weight: bold;"><i class="fa-solid fa-burger"></i> Menu</a>
        <a href="admin_messages.jsp" style="color: #f39c12; text-decoration: none; font-weight: bold;"><i class="fa-solid fa-envelope"></i> Messages</a>
        <a href="admin_reports.jsp" style="color: #ddd; text-decoration: none; font-weight: bold;"><i class="fa-solid fa-chart-pie"></i> Reports</a>
    </div>

    <div class="admin-content">
        <h2 style="margin-top: 0; color: #1a1a1a;"><i class="fa-solid fa-envelope-open-text" style="color: #f39c12;"></i> Customer Feedback & Inquiries</h2>
        <p style="color: #666; margin-bottom: 30px;">Read, manage and reply to messages from your website visitors.</p>

        <%
            // Read Operations: Instantiating service to fetch database entries
            MessageService ms = new MessageService();
            List<Message> allMessages = ms.getAllMessages();

            if(allMessages.isEmpty()) {
        %>
            <!-- Fallback Empty State Content Display -->
            <div style="text-align: center; padding: 40px; color: #777;"><i class="fa-regular fa-folder-open" style="font-size: 40px; margin-bottom: 15px; display: block; color: #ddd;"></i>No new messages found.</div>
        <%  } else {
                for(Message m : allMessages) {
                    // UI Configuration: Assign conditional layouts based on item resolution state
                    boolean isPending = "Pending".equals(m.getStatus());
                    String borderColor = isPending ? "#f39c12" : "#28a745";
                    String badgeClass = isPending ? "badge-pending" : "badge-replied";
        %>
            <!-- Dynamic Data Message Record Card -->
            <div class="msg-card" style="border-left-color: <%= borderColor %>;">
                <div class="msg-header">
                    <strong><i class="fa-solid fa-user"></i> <%= m.getName() %> (<a href="mailto:<%= m.getEmail() %>"><%= m.getEmail() %></a>)
                        <!-- Dynamic Resolution State Badge Component -->
                        <span class="badge <%= badgeClass %>"><%= m.getStatus() %></span>
                    </strong>
                    <span><i class="fa-solid fa-calendar-day"></i> <%= m.getDate() %></span>
                </div>
                <p style="margin: 0 0 15px 0; color: #333;"><%= m.getContent() %></p>

                <div style="display: flex; gap: 10px;">
                    <!-- Action Link: Launch internal mail utility -->
                    <a href="mailto:<%= m.getEmail() %>" class="btn-action btn-email"><i class="fa-solid fa-envelope"></i> Email Customer</a>

                    <!-- Update Operation: Trigger response status mutations -->
                    <% if (isPending) { %>
                    <form action="ReplyMessageServlet" method="POST" style="margin: 0;">
                        <input type="hidden" name="messageId" value="<%= m.getId() %>">
                        <button type="submit" class="btn-action btn-reply"><i class="fa-solid fa-check-double"></i> Mark as Replied</button>
                    </form>
                    <% } %>

                    <!-- Delete Operation: Trigger permanent data clearing -->
                    <form action="DeleteMessageServlet" method="POST" style="margin: 0;">
                        <input type="hidden" name="id" value="<%= m.getId() %>">
                        <button type="submit" class="btn-action btn-delete" onclick="return confirm('Are you sure you want to permanently delete this message?');">
                            <i class="fa-solid fa-trash-can"></i> Delete
                        </button>
                    </form>
                </div>
            </div>
        <%      }
            }
        %>
    </div>

    <!-- Client-Side Scripting: Intercepting query feedback parameters via SweetAlert2 -->
    <script>
        document.addEventListener("DOMContentLoaded", function() {
            const urlParams = new URLSearchParams(window.location.search);

            // Notification: Successfully removed record data states
            if (urlParams.has('deleted')) {
                Swal.fire({ icon: 'success', title: 'Deleted!', text: 'Message deleted successfully.', confirmButtonColor: '#d33' })
                .then(() => { window.history.replaceState(null, null, window.location.pathname); });
            }
            // Notification: Successfully modified message resolution attributes
            else if (urlParams.has('replySuccess')) {
                Swal.fire({ icon: 'success', title: 'Updated!', text: 'Message marked as replied.', confirmButtonColor: '#28a745' })
                .then(() => { window.history.replaceState(null, null, window.location.pathname); });
            }
            // Notification: Runtime errors or database connection drops
            else if (urlParams.has('error')) {
                Swal.fire({ icon: 'error', title: 'Oops...', text: 'Something went wrong!', confirmButtonColor: '#3085d6' })
                .then(() => { window.history.replaceState(null, null, window.location.pathname); });
            }
        });
    </script>
</body>
</html>