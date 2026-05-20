<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.reservation.model.Reservation" %>
<%@ page import="com.reservation.service.ReservationService" %>
<%@ page import="java.util.List" %>
<%
    String role = (String) session.getAttribute("role");
    if (role == null || !role.equals("admin")) {
        response.sendRedirect("login.jsp");
        return;
    }


    ReservationService rs = new ReservationService();
    List<Reservation> allBookings = rs.getAllReservations();

    int total = allBookings.size();
    int confirmed = 0;
    int pending = 0;
    int cancelled = 0;

    for(Reservation r : allBookings) {
        if("Approved".equalsIgnoreCase(r.getStatus())) confirmed++;
        else if("Pending".equalsIgnoreCase(r.getStatus())) pending++;
        else if("Cancelled".equalsIgnoreCase(r.getStatus())) cancelled++;
    }
%>
<html>
<head>
    <title>Reports - Admin Portal</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">

    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <style>
        body { font-family: 'Poppins', sans-serif; background-color: #f4f7f6; margin: 0; }
        .admin-header { background: #1a1a1a; color: white; padding: 20px 40px; display: flex; justify-content: space-between; align-items: center; }
        .admin-header h2 { margin: 0; color: #f39c12; }
        .admin-header a { color: white; text-decoration: none; font-weight: bold; background: #dc3545; padding: 8px 15px; border-radius: 5px; }

        .admin-content { padding: 40px; max-width: 1200px; margin: 0 auto; }

        .stat-grid { display: grid; grid-template-columns: repeat(4, 1fr); gap: 20px; margin-bottom: 40px; }
        .stat-box { background: white; padding: 20px; border-radius: 8px; text-align: center; box-shadow: 0 4px 10px rgba(0,0,0,0.05); }
        .stat-box h4 { margin: 0; color: #888; font-size: 14px; text-transform: uppercase; }
        .stat-box p { margin: 10px 0 0 0; font-size: 30px; font-weight: bold; color: #1a1a1a; }

        /* Charts Section */
        .charts-container { display: grid; grid-template-columns: 1fr 1fr; gap: 30px; margin-bottom: 40px; }
        .chart-card { background: white; padding: 25px; border-radius: 10px; box-shadow: 0 4px 15px rgba(0,0,0,0.05); }
        .chart-card h3 { margin-top: 0; color: #333; text-align: center; margin-bottom: 20px; }


        .chart-wrapper { position: relative; height: 300px; width: 100%; }

        .report-card { background: white; padding: 40px; border-radius: 10px; box-shadow: 0 4px 15px rgba(0,0,0,0.05); text-align: center; border-top: 5px solid #28a745;}
        .report-card i { font-size: 50px; color: #28a745; margin-bottom: 15px; }
        .report-card h3 { margin: 0 0 10px 0; color: #333; font-size: 24px;}
        .report-card p { color: #666; margin-bottom: 25px; }
        .btn-download { background: #28a745; color: white; padding: 12px 25px; border-radius: 5px; text-decoration: none; font-weight: bold; font-size: 16px; display: inline-block; transition: 0.3s; }
        .btn-download:hover { background: #218838; transform: translateY(-2px); }
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
        <a href="admin_users.jsp" style="color: #ddd; text-decoration: none; font-weight: bold;"><i class="fa-solid fa-users"></i> User Management</a>
        <a href="admin_menu.jsp" style="color: #ddd; text-decoration: none; font-weight: bold;"><i class="fa-solid fa-burger"></i> Menu</a>
        <a href="admin_messages.jsp" style="color: #ddd; text-decoration: none; font-weight: bold;"><i class="fa-solid fa-envelope"></i> Messages</a>
        <a href="admin_reports.jsp" style="color: #f39c12; text-decoration: none; font-weight: bold;"><i class="fa-solid fa-chart-pie"></i> Reports</a>
    </div>

    <div class="admin-content">
        <h2 style="margin-top: 0; color: #1a1a1a; margin-bottom: 30px;"><i class="fa-solid fa-chart-pie" style="color: #f39c12;"></i> System Reports & Analytics</h2>

        <div class="stat-grid">
            <div class="stat-box" style="border-bottom: 4px solid #17a2b8;">
                <h4>Total Bookings</h4>
                <p><%= total %></p>
            </div>
            <div class="stat-box" style="border-bottom: 4px solid #28a745;">
                <h4>Approved</h4>
                <p><%= confirmed %></p>
            </div>
            <div class="stat-box" style="border-bottom: 4px solid #ffc107;">
                <h4>Pending</h4>
                <p><%= pending %></p>
            </div>
            <div class="stat-box" style="border-bottom: 4px solid #dc3545;">
                <h4>Cancelled</h4>
                <p><%= cancelled %></p>
            </div>
        </div>


        <div class="charts-container">
            <!-- Pie Chart -->
            <div class="chart-card">
                <h3>Reservation Status Breakdown</h3>

                <div class="chart-wrapper">
                    <canvas id="statusPieChart"></canvas>
                </div>
            </div>
            <!-- Bar Chart -->
            <div class="chart-card">
                <h3>Bookings Overview</h3>

                <div class="chart-wrapper">
                    <canvas id="statusBarChart"></canvas>
                </div>
            </div>
        </div>

        <div class="report-card">
            <i class="fa-solid fa-file-pdf"></i>
            <h3>Reservation Data Report</h3>
            <p>Download a complete list of all customer reservations, including pre-ordered food and special notes in PDF format.</p>
            <a href="DownloadReportServlet" class="btn-download"><i class="fa-solid fa-download"></i> Download Full Report (PDF)</a>
        </div>

    </div>


    <script>

        const confirmedData = <%= confirmed %>;
        const pendingData = <%= pending %>;
        const cancelledData = <%= cancelled %>;

        // 1. Pie Chart
        const pieCtx = document.getElementById('statusPieChart').getContext('2d');
        new Chart(pieCtx, {
            type: 'pie',
            data: {
                labels: ['Approved', 'Pending', 'Cancelled'],
                datasets: [{
                    data: [confirmedData, pendingData, cancelledData],
                    backgroundColor: ['#28a745', '#ffc107', '#dc3545'], // Green, Yellow, Red
                    borderWidth: 1
                }]
            },
            options: { responsive: true, maintainAspectRatio: false }
        });

        // 2. Bar Chart
        const barCtx = document.getElementById('statusBarChart').getContext('2d');
        new Chart(barCtx, {
            type: 'bar',
            data: {
                labels: ['Approved', 'Pending', 'Cancelled'],
                datasets: [{
                    label: 'Number of Reservations',
                    data: [confirmedData, pendingData, cancelledData],
                    backgroundColor: ['#28a745', '#ffc107', '#dc3545'],
                    borderRadius: 5
                }]
            },
            options: {
                responsive: true,
                maintainAspectRatio: false,
                scales: { y: { beginAtZero: true, ticks: { stepSize: 1 } } },
                plugins: { legend: { display: false } }
            }
        });
    </script>

</body>
</html>