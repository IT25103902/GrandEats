<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.reservation.model.Reservation" %>
<%@ page import="com.reservation.service.ReservationService" %>
<%@ page import="java.util.List" %>
<%
    // Security Check
    String role = (String) session.getAttribute("role");
    if (role == null || !role.equals("admin")) {
        response.sendRedirect("login.jsp");
        return;
    }
%>
<html>
<head>
    <title>Admin Dashboard - GrandEats</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">

    <!-- 🔴 DataTables CSS -->
    <link rel="stylesheet" href="https://cdn.datatables.net/1.13.6/css/jquery.dataTables.min.css">

    <!-- 🔴 SweetAlert2 -->
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>

    <style>
        body { font-family: 'Poppins', sans-serif; background-color: #f4f7f6; margin: 0; }
        .admin-header { background: #1a1a1a; color: white; padding: 20px 40px; display: flex; justify-content: space-between; align-items: center; box-shadow: 0 4px 10px rgba(0,0,0,0.1); }
        .admin-header h2 { margin: 0; color: #f39c12; }
        .admin-header a { color: white; text-decoration: none; font-weight: bold; background: #dc3545; padding: 8px 15px; border-radius: 5px; transition: 0.3s; }
        .admin-header a:hover { background: #c82333; }

        .admin-content { padding: 40px; max-width: 1200px; margin: 0 auto; }
        .stat-cards { display: grid; grid-template-columns: repeat(auto-fit, minmax(250px, 1fr)); gap: 20px; margin-bottom: 30px; }
        .card { background: white; padding: 25px; border-radius: 10px; box-shadow: 0 4px 15px rgba(0,0,0,0.05); border-left: 5px solid #f39c12; }
        .card h3 { margin: 0 0 10px 0; color: #888; font-size: 14px; text-transform: uppercase; }
        .card p { margin: 0; font-size: 28px; font-weight: bold; color: #1a1a1a; }

        /* Table Styling */
        .table-container { background: #fff; border-radius: 10px; box-shadow: 0 4px 15px rgba(0,0,0,0.05); overflow: hidden; padding: 20px; }
        .table-custom { width: 100%; border-collapse: collapse; text-align: left; }
        .table-custom th { background-color: #f8f9fa; color: #555; padding: 15px; font-weight: 600; text-transform: uppercase; font-size: 13px; border-bottom: 2px solid #eee; }
        .table-custom td { padding: 15px; border-bottom: 1px solid #f1f1f1; color: #444; font-size: 14px; }
        .table-custom tr:hover { background-color: #fcfcfc; }

        .badge { padding: 6px 12px; border-radius: 20px; font-size: 12px; font-weight: 600; display: inline-block; }
        .customer-email { color: #0056b3; font-weight: bold; text-decoration: none; }
        .customer-email:hover { text-decoration: underline; }

        /* Action Buttons */
        .btn-action { color: white; border: none; padding: 8px 12px; border-radius: 4px; cursor: pointer; font-weight: bold; font-size: 12px; transition: 0.3s; text-decoration: none; display: inline-block; }
        .btn-approve { background: #28a745; }
        .btn-approve:hover { background: #218838; transform: translateY(-2px); }
        .btn-reject { background: #dc3545; }
        .btn-reject:hover { background: #c82333; transform: translateY(-2px); }

        /* DataTables Custom Styling Fixes */
        .dataTables_wrapper .dataTables_filter input { padding: 6px; border-radius: 4px; border: 1px solid #ccc; margin-left: 10px; }
        .dataTables_wrapper .dataTables_length select { padding: 4px; border-radius: 4px; border: 1px solid #ccc; }
    </style>
</head>
<body>

    <div class="admin-header">
        <h2><i class="fa-solid fa-utensils"></i> GrandEats Admin Portal</h2>
        <div>
            <span style="margin-right: 20px;"><i class="fa-solid fa-user-shield"></i> Welcome, Manager</span>
            <a href="LogoutServlet"><i class="fa-solid fa-right-from-bracket"></i> Logout</a>
        </div>
    </div>

    <div style="background: #333; padding: 15px 40px; display: flex; gap: 25px; box-shadow: 0 4px 6px rgba(0,0,0,0.1);">
        <a href="admin_dashboard.jsp" style="color: #f39c12; text-decoration: none; font-weight: bold;"><i class="fa-solid fa-house"></i> Dashboard</a>
        <a href="admin_users.jsp" style="color: #ddd; text-decoration: none; font-weight: bold;"><i class="fa-solid fa-users"></i> User Management</a>
        <a href="admin_menu.jsp" style="color: #ddd; text-decoration: none; font-weight: bold;"><i class="fa-solid fa-burger"></i> Menu</a>
        <a href="admin_messages.jsp" style="color: #ddd; text-decoration: none; font-weight: bold;"><i class="fa-solid fa-envelope"></i> Messages</a>
        <a href="admin_reports.jsp" style="color: #ddd; text-decoration: none; font-weight: bold;"><i class="fa-solid fa-chart-pie"></i> Reports</a>
    </div>

    <div class="admin-content">
        <h2 style="margin-top: 0; color: #1a1a1a;"><i class="fa-solid fa-chart-line" style="color: #f39c12;"></i> Dashboard Overview</h2>

        <%
            ReservationService rs = new ReservationService();
            List<Reservation> allBookings = rs.getAllReservations();

            int totalBookings = allBookings.size();
            int totalGuests = 0;
            for(Reservation r : allBookings) {
                if(!"Cancelled".equalsIgnoreCase(r.getStatus())) {
                    totalGuests += r.getGuests();
                }
            }
        %>

        <div class="stat-cards">
            <div class="card">
                <h3>Total Bookings (All Time)</h3>
                <p><i class="fa-solid fa-calendar-check" style="color: #f39c12;"></i> <%= totalBookings %></p>
            </div>
            <div class="card">
                <h3>Total Guests Expected</h3>
                <p><i class="fa-solid fa-users" style="color: #17a2b8;"></i> <%= totalGuests %></p>
            </div>
        </div>

        <h3 style="margin-top: 40px; color: #1a1a1a;"><i class="fa-solid fa-list" style="color: #f39c12;"></i> All Customer Reservations</h3>

        <div class="table-container">

            <table id="bookingsTable" class="table-custom">
                <thead>
                    <tr>
                        <th>Customer Email</th>
                        <th>Date</th>
                        <th>Time</th>
                        <th>Guests</th>
                        <th>Table Type</th>
                        <th>Status</th>
                        <th>Actions</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        if(!allBookings.isEmpty()) {
                            for(Reservation r : allBookings) {
                    %>
                        <tr>
                            <td><a href="mailto:<%= r.getUserEmail() %>" class="customer-email"><i class="fa-solid fa-envelope" style="color: #888;"></i> <%= r.getUserEmail() %></a></td>
                            <td><strong><i class="fa-regular fa-calendar" style="color: #888; margin-right: 5px;"></i> <%= r.getDate() %></strong></td>
                            <td><i class="fa-regular fa-clock" style="color: #888; margin-right: 5px;"></i> <%= r.getTime() %></td>
                            <td><i class="fa-solid fa-user-group" style="color: #888; margin-right: 5px;"></i> <%= r.getGuests() %> Persons</td>
                            <td><%= r.getTableType() %></td>

                            <td>
                                <% if("Pending".equalsIgnoreCase(r.getStatus())) { %>
                                    <span class="badge" style="background: #fff3cd; color: #856404; border: 1px solid #ffeeba;"><i class="fa-solid fa-clock"></i> Pending</span>
                                <% } else if("Cancelled".equalsIgnoreCase(r.getStatus())) { %>
                                    <span class="badge" style="background: #f8d7da; color: #721c24; border: 1px solid #f5c6cb;"><i class="fa-solid fa-ban"></i> Cancelled</span>
                                <% } else { %>
                                    <span class="badge" style="background: #d4edda; color: #155724; border: 1px solid #c3e6cb;"><i class="fa-solid fa-check-double"></i> Confirmed</span>
                                <% } %>
                            </td>

                            <td>
                                <% if("Pending".equalsIgnoreCase(r.getStatus())) { %>
                                    <div style="display: flex; gap: 5px;">
                                        <a href="ApproveReservationServlet?id=<%= r.getId() %>" class="btn-action btn-approve"><i class="fa-solid fa-check"></i> Approve</a>

                                        <a href="#" onclick="confirmReject(<%= r.getId() %>)" class="btn-action btn-reject"><i class="fa-solid fa-xmark"></i> Reject</a>
                                    </div>
                                <% } else if("Cancelled".equalsIgnoreCase(r.getStatus())) { %>
                                    <span style="color: #dc3545; font-weight: bold; font-size: 13px;"><i class="fa-solid fa-ban"></i> Rejected</span>
                                <% } else { %>
                                    <span style="color: #28a745; font-weight: bold; font-size: 13px;"><i class="fa-solid fa-check-circle"></i> Approved</span>
                                <% } %>
                            </td>
                        </tr>
                    <%      }
                        }
                    %>
                </tbody>
            </table>
        </div>

    </div>


    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://cdn.datatables.net/1.13.6/js/jquery.dataTables.min.js"></script>

    <script>

        $(document).ready(function() {
            $('#bookingsTable').DataTable({
                "pageLength": 5,
                "lengthMenu": [5, 10, 25, 50],
                "order": [[ 1, "desc" ]],
                "language": {
                    "emptyTable": "No reservations found in the system."
                }
            });
        });


        const urlParams = new URLSearchParams(window.location.search);
        if (urlParams.has('msg')) {
            const msg = urlParams.get('msg');
            if (msg === 'approved') {
                Swal.fire({
                    icon: 'success',
                    title: 'Approved!',
                    text: 'Reservation successfully approved!',
                    confirmButtonColor: '#28a745'
                });
            } else if (msg === 'cancelled') {
                Swal.fire({
                    icon: 'success',
                    title: 'Rejected!',
                    text: 'Reservation successfully rejected and cancelled!',
                    confirmButtonColor: '#dc3545'
                });
            }
        }


        function confirmReject(id) {
            Swal.fire({
                title: 'Are you sure?',
                text: "You are about to reject this booking!",
                icon: 'warning',
                showCancelButton: true,
                confirmButtonColor: '#dc3545',
                cancelButtonColor: '#6c757d',
                confirmButtonText: 'Yes, reject it!'
            }).then((result) => {
                if (result.isConfirmed) {

                    window.location.href = 'CancelReservationServlet?id=' + id;
                }
            })
        }
    </script>

</body>
</html>