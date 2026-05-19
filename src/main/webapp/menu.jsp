<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.reservation.model.MenuItem" %>
<%@ page import="com.reservation.service.MenuService" %>
<%@ page import="java.util.List" %>
<%
    // Are you logged in (Customer)
    String userEmail = (String) session.getAttribute("userEmail");
    if(userEmail == null) { response.sendRedirect("login.jsp"); return; }
%>
<html>
<head>
    <title>Food Menu - GrandEats</title>
    <style>
        /* ---------------------------------------------------
           🌞 DEFAULT (LIGHT MODE) STYLES
           --------------------------------------------------- */
        .page-header { margin-bottom: 25px; border-bottom: 2px solid #f4f7f6; padding-bottom: 15px; transition: 0.3s; }
        .page-header h2 { margin: 0; color: #1a1a1a; display: flex; align-items: center; gap: 10px; transition: 0.3s; }
        .page-header p { color: #666; transition: 0.3s; }

        /* Menu Cards */
        .menu-grid { display: grid; grid-template-columns: repeat(auto-fill, minmax(280px, 1fr)); gap: 25px; margin-top: 20px;}
        .menu-card { background: white; border-radius: 12px; box-shadow: 0 4px 15px rgba(0,0,0,0.05); overflow: hidden; transition: 0.3s; text-align: center; padding-bottom: 20px; border: 1px solid transparent; }
        .menu-card:hover { transform: translateY(-5px); box-shadow: 0 8px 25px rgba(0,0,0,0.1); }
        .menu-img { width: 100%; height: 200px; object-fit: contain; background: #f8f9fa; padding: 20px; box-sizing: border-box; border-bottom: 1px solid #eee; transition: 0.3s; }
        .menu-title { font-size: 18px; font-weight: bold; color: #333; margin: 15px 0 5px 0; transition: 0.3s; }
        .menu-category { color: #888; font-size: 13px; text-transform: uppercase; letter-spacing: 1px; margin-bottom: 15px; transition: 0.3s; }
        .menu-price { font-size: 22px; font-weight: bold; color: #f39c12; margin-bottom: 15px;}

        /* Empty State Card (The part that shows when there is no food) */
        .empty-state-card { grid-column: 1 / -1; text-align: center; padding: 50px; background: white; border-radius: 10px; box-shadow: 0 4px 15px rgba(0,0,0,0.05); transition: 0.3s; border: 1px solid transparent; }
        .empty-state-card i { font-size: 40px; margin-bottom: 15px; color: #ddd; transition: 0.3s; }
        .empty-state-card h3 { color: #333; margin: 0 0 10px 0; transition: 0.3s; }
        .empty-state-card p { color: #777; margin: 0; transition: 0.3s; }

        /* Badges */
        .badge { padding: 5px 12px; border-radius: 20px; font-size: 12px; font-weight: 600; display: inline-block; transition: 0.3s; }
        .badge-available { background: #e0f8e9; color: #198754; border: 1px solid #c3e6cb; }
        .badge-out { background: #f8d7da; color: #dc3545; border: 1px solid #f5c6cb; }

        /* ---------------------------------------------------
           🌙 DARK MODE STYLES (Activated by body class)
           --------------------------------------------------- */
        body.dark-mode .page-header { border-bottom-color: #333333; }
        body.dark-mode .page-header h2 { color: #f8f9fa; }
        body.dark-mode .page-header p { color: #aaaaaa; }

        /* Dark Menu Cards */
        body.dark-mode .menu-card { background: #1e1e1e; border-color: #333333; box-shadow: 0 4px 15px rgba(0,0,0,0.4); }
        body.dark-mode .menu-card:hover { box-shadow: 0 8px 25px rgba(0,0,0,0.6); }
        body.dark-mode .menu-img { background: #2a2a2a; border-bottom-color: #444444; }
        body.dark-mode .menu-title { color: #f8f9fa; }
        body.dark-mode .menu-category { color: #aaaaaa; }

        /* Dark Empty State Card */
        body.dark-mode .empty-state-card { background: #1e1e1e; border-color: #333333; box-shadow: 0 4px 15px rgba(0,0,0,0.4); }
        body.dark-mode .empty-state-card i { color: #444444; }
        body.dark-mode .empty-state-card h3 { color: #f8f9fa; }
        body.dark-mode .empty-state-card p { color: #aaaaaa; }

        /* Dark Badges */
        body.dark-mode .badge-available { background: #1b4332; color: #d4edda; border-color: #28a745; }
        body.dark-mode .badge-out { background: #58151c; color: #f8d7da; border-color: #dc3545; }
    </style>
</head>
<body>
    <jsp:include page="includes/header.jsp" />

    <div class="dashboard-wrapper">
        <jsp:include page="includes/sidebar.jsp" />

        <div class="main-content">
            <div class="page-header">
                <h2><i class="fa-solid fa-burger" style="color: #f39c12;"></i> Our Menu</h2>
                <p>Discover our delicious food and beverages. Book a table to enjoy!</p>
            </div>

            <div class="menu-grid">
                <%
                    MenuService ms = new MenuService();
                    List<MenuItem> menuItems = ms.getAllMenuItems();

                    if(menuItems.isEmpty()) {
                %>
                    <div class="empty-state-card">
                        <i class="fa-solid fa-plate-wheat"></i>
                        <h3>Menu is currently being updated!</h3>
                        <p>Please check back later.</p>
                    </div>
                <%  } else {
                        for(MenuItem m : menuItems) {
                %>
                    <div class="menu-card">
                        <img src="<%= m.getImageUrl() %>" class="menu-img" alt="<%= m.getName() %>">
                        <div class="menu-title"><%= m.getName() %></div>
                        <div class="menu-category"><%= m.getCategory() %></div>
                        <div class="menu-price">Rs. <%= m.getPrice() %></div>
                        <div>
                            <% if("Available".equalsIgnoreCase(m.getStatus())) { %>
                                <span class="badge badge-available"><i class="fa-solid fa-check"></i> Available</span>
                            <% } else { %>
                                <span class="badge badge-out"><i class="fa-solid fa-xmark"></i> Out of Stock</span>
                            <% } %>
                        </div>
                    </div>
                <%      }
                    }
                %>
            </div>

        </div>
    </div>
</body>
</html>