<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.reservation.model.MenuItem" %>
<%@ page import="com.reservation.service.MenuService" %>
<%@ page import="java.util.List" %>
<%
    String currentURL = request.getRequestURI();
    String user = (String) session.getAttribute("userEmail");
    if (user == null) {
        response.sendRedirect("login.jsp");
        return;
    }
%>
<html>
<head>
    <title>Book a Table - GrandEats</title>
    <style>
        .page-header { margin-bottom: 25px; border-bottom: 2px solid var(--border-color, #f4f7f6); padding-bottom: 15px; transition: 0.3s;}
        .page-header h2 { margin: 0; color: var(--text-main, #1a1a1a); display: flex; align-items: center; gap: 10px; transition: 0.3s;}
        .form-container { max-width: 750px; margin: 0 auto; background: var(--card-bg, #fafafa); padding: 30px; border-radius: 8px; border: 1px solid var(--border-color, #eee); transition: 0.3s;}


        .food-section { background: var(--bg-color, white); padding: 20px; border-radius: 8px; border: 1px solid var(--border-color, #ddd); margin-top: 15px; margin-bottom: 20px; transition: 0.3s;}
        .food-section h4 { margin-top: 0; color: #f39c12; margin-bottom: 15px; border-bottom: 1px dashed var(--border-color, #ccc); padding-bottom: 10px;}
        .food-grid { display: grid; grid-template-columns: 1fr 1fr; gap: 15px; }
        .food-item { display: flex; align-items: center; gap: 10px; font-size: 14px; color: var(--text-main, #444); transition: 0.3s;}
        .food-item input[type="checkbox"] { width: 18px; height: 18px; cursor: pointer; accent-color: #f39c12; }
        textarea.form-control { resize: vertical; min-height: 80px; }


        .floor-plan-container { background: var(--bg-color, #fff); border: 2px dashed var(--border-color, #ccc); border-radius: 10px; padding: 30px; margin-top: 15px; margin-bottom: 20px; text-align: center; transition: 0.3s;}
        .floor-plan { display: flex; justify-content: center; gap: 30px; flex-wrap: wrap; margin-top: 20px; }

        .table-btn { width: 100px; height: 100px; display: flex; flex-direction: column; align-items: center; justify-content: center; cursor: pointer; transition: all 0.3s ease; color: white; font-weight: bold; font-size: 13px; position: relative; border: 4px solid transparent; box-shadow: 0 5px 15px rgba(0,0,0,0.1); }
        .table-btn i { font-size: 30px; margin-bottom: 8px; }


        .tbl-standard { background: #7f8c8d; border-radius: 15px; }
        .tbl-window { background: #3498db; border-radius: 50%; }
        .tbl-vip { background: #e67e22; clip-path: polygon(50% 0%, 100% 25%, 100% 75%, 50% 100%, 0% 75%, 0% 25%); }

        .table-btn:hover { transform: translateY(-5px) scale(1.05); box-shadow: 0 10px 20px rgba(0,0,0,0.2); }


        .table-btn.selected { border-color: #2ecc71; transform: scale(1.1); box-shadow: 0 0 20px rgba(46, 204, 113, 0.6); z-index: 10; }
        .table-btn.selected::after { content: '\f058'; font-family: 'FontAwesome'; position: absolute; top: -10px; right: -10px; background: #fff; color: #2ecc71; border-radius: 50%; padding: 2px; font-size: 20px; }
    </style>
</head>
<body>
    <jsp:include page="includes/header.jsp" />

    <div class="dashboard-wrapper">
        <jsp:include page="includes/sidebar.jsp" />

        <div class="main-content">
            <div class="page-header">
                <h2><i class="fa-solid fa-calendar-plus" style="color: #f39c12;"></i> Book a Table</h2>
                <p style="color: var(--text-muted); margin-top: 5px;">Reserve your spot and pre-order your favorite meals.</p>
            </div>

            <% if(request.getParameter("error") != null) { %>
                <div style="background: #f8d7da; color: #721c24; padding: 15px; border-radius: 5px; margin-bottom: 20px; border-left: 5px solid #dc3545; font-weight: bold;">
                    <% if(request.getParameter("error").equals("table_booked")) { %>
                        <i class="fa-solid fa-triangle-exclamation"></i> Sorry! The selected table type is already booked for this date and time. Please choose another time.
                    <% } else { %>
                        <i class="fa-solid fa-circle-xmark"></i> Booking failed! Please try again.
                    <% } %>
                </div>
            <% } %>

            <div class="form-container animate-up">
                <form action="ReservationServlet" method="POST">

                    <div class="profile-grid">
                        <div class="form-group">
                            <label>Reservation Date</label>
                            <input type="date" name="date" class="form-control" required min="<%= java.time.LocalDate.now() %>">
                        </div>
                        <div class="form-group">
                            <label>Reservation Time</label>
                            <input type="time" name="time" class="form-control" required>
                        </div>
                    </div>

                    <div class="form-group">
                        <label>Number of Guests</label>
                        <input type="number" name="guests" class="form-control" min="1" max="20" required style="max-width: 50%;">
                    </div>

                    <div class="form-group" style="grid-column: 1 / -1;">
                        <label style="font-size: 16px;"><i class="fa-solid fa-map-location-dot" style="color: #f39c12;"></i> Select Table Preference</label>

                        <input type="hidden" name="tableType" id="selectedTableType" value="Standard">

                        <div class="floor-plan-container">
                            <p style="color: var(--text-muted); margin-top: 0; font-size: 14px;">Click on a table type from our interactive floor plan below.</p>

                            <div class="floor-plan">
                                <div class="table-btn tbl-standard selected" id="btn-standard" onclick="selectTable('Standard', 'btn-standard')">
                                    <i class="fa-solid fa-chair"></i>
                                    <span>Standard</span>
                                </div>

                                <div class="table-btn tbl-window" id="btn-window" onclick="selectTable('Window', 'btn-window')">
                                    <i class="fa-solid fa-cloud-sun"></i>
                                    <span>Window</span>
                                </div>

                                <div class="table-btn tbl-vip" id="btn-vip" onclick="selectTable('VIP', 'btn-vip')">
                                    <i class="fa-solid fa-crown"></i>
                                    <span>VIP Room</span>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="food-section">
                        <h4><i class="fa-solid fa-bell-concierge"></i> Pre-order Food (Optional)</h4>
                        <div class="food-grid">
                            <%
                                MenuService ms = new MenuService();
                                List<MenuItem> menuItems = ms.getAllMenuItems();
                                boolean hasItems = false;

                                for(MenuItem m : menuItems) {
                                    if("Available".equals(m.getStatus())) {
                                        hasItems = true;
                            %>
                                    <label class="food-item">
                                        <input type="checkbox" name="foodItems" value="<%= m.getName() %>">
                                        <%= m.getName() %> (Rs.<%= m.getPrice() %>)
                                    </label>
                            <%      }
                                }
                                if(!hasItems) {
                            %>
                                <div style="grid-column: 1 / -1; color: #888; font-style: italic;">No food items available for pre-order at the moment.</div>
                            <%  } %>
                        </div>
                    </div>

                    <div class="form-group">
                        <label><i class="fa-regular fa-comment-dots"></i> Special Instructions (Optional)</label>
                        <textarea name="specialNote" class="form-control" placeholder="E.g., Less spicy, Need a birthday cake, Anniversary setup..."></textarea>
                    </div>

                    <button type="submit" class="btn-submit" style="margin-top: 15px; width: 100%; font-size: 16px;"><i class="fa-solid fa-check-circle"></i> Confirm Reservation</button>
                </form>
            </div>
        </div>
    </div>

    <script>
        function selectTable(type, btnId) {

            document.getElementById('selectedTableType').value = type;


            var buttons = document.getElementsByClassName('table-btn');
            for (var i = 0; i < buttons.length; i++) {
                buttons[i].classList.remove('selected');
            }


            document.getElementById(btnId).classList.add('selected');
        }
    </script>
</body>
</html>