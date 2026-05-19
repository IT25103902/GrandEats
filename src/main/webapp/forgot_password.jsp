<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Forgot Password - GrandEats</title>
    <style>
        .auth-container { max-width: 400px; margin: 80px auto; background: white; padding: 40px; border-radius: 10px; box-shadow: 0 10px 25px rgba(0,0,0,0.1); text-align: center; font-family: 'Poppins', sans-serif; }
        .auth-form input { width: 100%; padding: 12px; margin-bottom: 20px; border: 1px solid #ddd; border-radius: 5px; box-sizing: border-box; }
        .btn-submit { width: 100%; padding: 12px; background: #1a1a1a; color: white; border: none; border-radius: 5px; font-weight: bold; cursor: pointer; }
    </style>
</head>
<body>
    <jsp:include page="includes/header.jsp" />
    <div class="auth-container">
        <h2>Forgot Password?</h2>
        <p style="color: #666; font-size: 14px;">Enter your email to receive a 6-digit verification code.</p>

        <form action="ForgotPasswordServlet" method="POST" class="auth-form">
            <input type="email" name="email" placeholder="Enter Registered Email" required>
            <button type="submit" class="btn-submit">Send Code</button>
        </form>
        <a href="login.jsp" style="display: block; margin-top: 15px; font-size: 13px; color: #777;">Back to Login</a>
    </div>
</body>
</html>