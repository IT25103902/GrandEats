<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Login - GrandEats</title>
    <style>
        .auth-container { max-width: 400px; margin: 60px auto; background: var(--card-bg, white); padding: 40px; border-radius: 10px; box-shadow: 0 10px 25px rgba(0,0,0,0.1); text-align: center; border: 1px solid var(--border-color, transparent); transition: 0.3s; }
        .auth-container h2 { color: #f39c12; margin-bottom: 10px; transition: 0.3s; }
        .auth-container p { color: var(--text-muted, #666); margin-bottom: 25px; transition: 0.3s; }

        .auth-form input { width: 100%; padding: 12px; margin-bottom: 15px; border: 1px solid var(--border-color, #ddd); border-radius: 5px; font-family: 'Poppins', sans-serif; box-sizing: border-box; background: var(--bg-color, white); color: var(--text-main, #333); transition: 0.3s; }
        .auth-form input:focus { border-color: #f39c12; outline: none; }

        .auth-form button { width: 100%; padding: 12px; background: #1a1a1a; color: white; border: none; border-radius: 5px; font-size: 16px; font-weight: bold; cursor: pointer; transition: 0.3s; }
        .auth-form button:hover { background: #f39c12; }

        .auth-links { margin-top: 20px; font-size: 14px; color: var(--text-main, #333); transition: 0.3s; }
        .auth-links a { color: #f39c12; font-weight: bold; }

        .error-msg { color: #dc3545; font-size: 14px; margin-bottom: 15px; background: rgba(220, 53, 69, 0.1); padding: 10px; border-radius: 5px; font-weight: 600;}

        .forgot-link { text-align: right; margin-top: -10px; margin-bottom: 15px; }
        .forgot-link a { font-size: 13px; color: #f39c12; font-weight: 600; text-decoration: none; }
        .forgot-link a:hover { text-decoration: underline; }
    </style>
</head>
<body>

    <jsp:include page="includes/header.jsp" />

    <div class="auth-container animate-up">
        <h2>Welcome Back</h2>
        <p>Login to manage your reservations.</p>

        <% if(request.getParameter("error") != null) { %>
            <div class="error-msg"><i class="fa-solid fa-circle-exclamation"></i> Invalid Email or Password!</div>
        <% } %>

        <form class="auth-form" action="LoginServlet" method="POST">
            <input type="email" name="email" placeholder="Email Address" required>
            <input type="password" name="password" placeholder="Password" required>

            <div class="forgot-link">
                <a href="forgot_password.jsp">Forgot Password?</a>
            </div>

            <button type="submit">Login</button>
        </form>

        <div class="auth-links">
            Don't have an account? <a href="signup.jsp">Sign Up Here</a>
        </div>
    </div>

</body>
</html>