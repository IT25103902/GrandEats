<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%

    if(session.getAttribute("userEmail") == null) {
        response.sendRedirect("login.jsp");
        return;
    }
    String userName = (String) session.getAttribute("userName");
%>
<html>
<head>
    <title>Overview - GrandEats</title>
    <style>

        .welcome-header { display: flex; justify-content: space-between; align-items: center; margin-bottom: 20px; }


        .stat-cards { display: grid; grid-template-columns: repeat(auto-fit, minmax(220px, 1fr)); gap: 15px; margin-top: 20px; }
        .card { padding: 25px; border-radius: 12px; color: white; box-shadow: 0 4px 15px rgba(0,0,0,0.1); transition: transform 0.3s; position: relative; overflow: hidden;}
        .card:hover { transform: translateY(-5px); }
        .card h3 { margin: 10px 0 0 0; font-size: 32px; font-weight: 700; z-index: 2; position: relative;}
        .card p { margin: 5px 0 0 0; opacity: 0.9; font-weight: 500; font-size: 15px; z-index: 2; position: relative;}
        .card i { font-size: 30px; opacity: 0.8; margin-bottom: 5px; z-index: 2; position: relative;}


        .activity-list { list-style: none; padding: 0; margin-top: 20px; }
        .activity-list li { padding: 15px 20px; border-left: 4px solid #f39c12; background: #fff; margin-bottom: 12px; border-radius: 6px; font-size: 14px; box-shadow: 0 2px 8px rgba(0,0,0,0.04); display: flex; justify-content: space-between; align-items: center;}
        .activity-left { display: flex; align-items: center; gap: 15px; color: #444; font-weight: 500;}
        .activity-left i { color: #f39c12; font-size: 18px; width: 20px; text-align: center;}
        .activity-time { font-size: 12px; color: #888; background: #f4f7f6; padding: 4px 10px; border-radius: 20px;}


        .promo-banner { background: linear-gradient(135deg, #f6d365 0%, #fda085 100%); padding: 25px; border-radius: 12px; color: white; margin-top: 40px; display: flex; justify-content: space-between; align-items: center; box-shadow: 0 5px 20px rgba(253, 160, 133, 0.4);}
        .promo-text h3 { margin: 0 0 8px 0; font-size: 22px;}
        .promo-text p { margin: 0; font-size: 15px; opacity: 0.95; }
        .btn-promo { padding: 12px 25px; background: white; color: #d35400; border: none; border-radius: 25px; font-weight: bold; cursor: pointer; text-decoration: none; font-size: 14px; transition: 0.3s; box-shadow: 0 4px 10px rgba(0,0,0,0.1);}
        .btn-promo:hover { background: #fff3e0; transform: scale(1.05); }


        .btn-header { padding: 10px 20px; border-radius: 5px; font-weight: bold; text-decoration: none; display: inline-block; transition: 0.3s; }
        .btn-outline { background: #fff; color: #1a1a1a; border: 1px solid #ddd; }
        .btn-outline:hover { background: #f9f9f9; border-color: #f39c12; }
        .btn-dark { background: #1a1a1a; color: white; border: 1px solid #1a1a1a; }
        .btn-dark:hover { background: #f39c12; border-color: #f39c12; }
    </style>
</head>
<body>
    <jsp:include page="includes/header.jsp" />

    <div class="dashboard-wrapper">
        <jsp:include page="includes/sidebar.jsp" />

        <div class="main-content">
            <div class="welcome-header">
                <div>
                    <h2>Welcome Back! <i class="fa-solid fa-hand-wave" style="color: #f39c12;"></i></h2>
                    <p style="color: #666; margin-top: -10px;">Here is what's happening with your dining account today.</p>
                </div>


                <div style="display: flex; gap: 15px;">
                    <a href="contact.jsp" class="btn-header btn-outline">
                        <i class="fa-solid fa-envelope" style="color: #f39c12;"></i> Contact Support
                    </a>
                    <a href="book_table.jsp" class="btn-header btn-dark">
                        <i class="fa-solid fa-plus"></i> New Booking
                    </a>
                </div>
            </div>

            <div class="stat-cards">
                <div class="card" style="background: linear-gradient(45deg, #4facfe, #00f2fe);">
                    <i class="fa-solid fa-calendar-check"></i>
                    <h3>1</h3>
                    <p>Upcoming Bookings</p>
                </div>
                <div class="card" style="background: linear-gradient(45deg, #43e97b, #38f9d7);">
                    <i class="fa-solid fa-utensils"></i>
                    <h3>4</h3>
                    <p>Total Past Visits</p>
                </div>
                <div class="card" style="background: linear-gradient(45deg, #fa709a, #fee140);">
                    <i class="fa-solid fa-star"></i>
                    <h3>450</h3>
                    <p>Loyalty Points</p>
                </div>
                <div class="card" style="background: linear-gradient(45deg, #667eea, #764ba2);">
                    <i class="fa-solid fa-crown"></i>
                    <h3 style="font-size: 26px; margin-top: 15px;">Gold</h3>
                    <p>Member Status</p>
                </div>
            </div>

            <div class="promo-banner">
                <div class="promo-text">
                    <h3><i class="fa-solid fa-gift"></i> Special Member Offer!</h3>
                    <p>Redeem 300 Loyalty Points for a complimentary dessert on your next visit.</p>
                </div>
                <a href="book_table.jsp" class="btn-promo">Claim Offer</a>
            </div>

            <h3 style="margin-top: 40px; border-bottom: 2px solid #eee; padding-bottom: 10px; color: #333;">Recent Activity</h3>
            <ul class="activity-list">
                <li>
                    <div class="activity-left">
                        <i class="fa-solid fa-right-to-bracket"></i>
                        <span>Logged into the dashboard securely</span>
                    </div>
                    <span class="activity-time">Just now</span>
                </li>
                <li>
                    <div class="activity-left">
                        <i class="fa-solid fa-calendar-plus" style="color: #28a745;"></i>
                        <span>Reserved a VIP Private Room for 4 Guests</span>
                    </div>
                    <span class="activity-time">Yesterday, 10:30 AM</span>
                </li>
                <li>
                    <div class="activity-left">
                        <i class="fa-solid fa-envelope-circle-check" style="color: #17a2b8;"></i>
                        <span>Updated account email address</span>
                    </div>
                    <span class="activity-time">April 18, 2026</span>
                </li>
                <li>
                    <div class="activity-left">
                        <i class="fa-solid fa-star" style="color: #e67e22;"></i>
                        <span>Left a 5-star review for the Seafood Platter</span>
                    </div>
                    <span class="activity-time">April 10, 2026</span>
                </li>
            </ul>

        </div>
    </div>
</body>
</html>