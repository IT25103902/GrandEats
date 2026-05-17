<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Home - GrandEats Reservation</title>
    <style>
        .hero { text-align: center; padding: 80px 20px; background: linear-gradient(rgba(0,0,0,0.6), rgba(0,0,0,0.6)), url('https://images.unsplash.com/photo-1517248135467-4c7edcad34c4?w=1200') no-repeat center center/cover; color: white; border-radius: 15px; margin-top: 20px; box-shadow: 0 10px 30px rgba(0,0,0,0.2); }
        .hero h1 { font-size: 48px; margin-bottom: 10px; }
        .hero p { font-size: 18px; margin-bottom: 30px; font-weight: 300; }
        .btn-main { background-color: #f39c12; color: #1a1a1a; padding: 15px 30px; font-size: 18px; font-weight: bold; border-radius: 30px; transition: 0.3s; display: inline-block; }
        .btn-main:hover { background-color: #fff; transform: translateY(-3px); }

        .features { display: flex; justify-content: space-between; margin-top: 50px; gap: 20px; }


        .feature-card { background: var(--card-bg, white); padding: 30px; border-radius: 10px; text-align: center; flex: 1; box-shadow: 0 5px 15px rgba(0,0,0,0.05); transition: 0.3s; border: 1px solid var(--border-color, transparent); }
        .feature-card:hover { transform: translateY(-10px); box-shadow: 0 15px 25px rgba(0,0,0,0.1); }
        .feature-card i { font-size: 40px; color: #f39c12; margin-bottom: 15px; }
        .feature-card h3 { color: var(--text-main, #333); margin-bottom: 10px; transition: 0.3s; }
        .feature-card p { color: var(--text-muted, #666); transition: 0.3s; line-height: 1.5; }
    </style>
</head>
<body>

    <jsp:include page="includes/header.jsp" />

    <div class="container">
        <div class="hero animate-up">
            <h1>Experience Fine Dining</h1>
            <p>Reserve your perfect table in seconds and enjoy world-class culinary delights.</p>
            <a href="signup.jsp" class="btn-main">Book a Table Now</a>
        </div>

        <div class="features">
            <div class="feature-card animate-up delay-1">
                <i class="fa-solid fa-clock"></i>
                <h3>Instant Booking</h3>
                <p>Check availability in real-time and secure your table without any hassle.</p>
            </div>
            <div class="feature-card animate-up delay-2">
                <i class="fa-solid fa-star"></i>
                <h3>Premium Service</h3>
                <p>Enjoy VIP tables, custom menus, and top-tier hospitality.</p>
            </div>
            <div class="feature-card animate-up delay-2">
                <i class="fa-solid fa-wine-glass"></i>
                <h3>Rich Menu</h3>
                <p>Explore a variety of dishes crafted by our award-winning chefs.</p>
            </div>
        </div>
    </div>

</body>
</html>