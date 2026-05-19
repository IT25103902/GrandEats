<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.reservation.service.UserService" %>

<%
    // Generate next id
    UserService us = new UserService();
    String nextId = us.getNextUserId();
%>

<html>
<head>
    <title>Sign Up - GrandEats</title>

    <!-- SweetAlert2 -->
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>

    <style>
        .auth-container { max-width: 450px; margin: 60px auto; background: var(--card-bg, white); padding: 40px; border-radius: 10px; box-shadow: 0 10px 25px rgba(0,0,0,0.1); text-align: center; border: 1px solid var(--border-color, transparent); transition: 0.3s; }
        .auth-container h2 { color: #f39c12; margin-bottom: 10px; transition: 0.3s; }
        .auth-container p { color: var(--text-muted, #666); margin-bottom: 25px; transition: 0.3s; }

        .auth-form input { width: 100%; padding: 12px; margin-bottom: 15px; border: 1px solid var(--border-color, #ddd); border-radius: 5px; font-family: 'Poppins', sans-serif; transition: 0.3s; box-sizing: border-box; background: var(--bg-color, white); color: var(--text-main, #333); }
        .auth-form input:focus { border-color: #f39c12; outline: none; box-shadow: 0 0 8px rgba(243, 156, 18, 0.2); }

        .readonly-field { background-color: var(--border-color, #f9f9f9) !important; border: 1px dashed #f39c12 !important; color: #f39c12 !important; font-weight: bold; cursor: not-allowed; }

        .auth-form button { width: 100%; padding: 12px; background: #28a745; color: white; border: none; border-radius: 5px; font-size: 16px; font-weight: bold; cursor: pointer; transition: 0.3s; }
        .auth-form button:hover { background: #218838; transform: translateY(-2px); }

        .auth-links { margin-top: 20px; font-size: 14px; color: var(--text-main, #333); transition: 0.3s; }
        .auth-links a { color: #f39c12; font-weight: bold; text-decoration: none; }
        .auth-links a:hover { text-decoration: underline; }

        .input-label { display: block; text-align: left; font-size: 13px; color: var(--text-main, #555); margin-bottom: 5px; font-weight: 600; transition: 0.3s; }
    </style>
</head>
<body>

    <jsp:include page="includes/header.jsp" />

    <div class="auth-container animate-up">
        <h2>Create an Account</h2>
        <p>Join GrandEats to reserve your tables easily.</p>

        <form class="auth-form" action="RegisterServlet" method="POST">

            <label class="input-label">Your User ID (Auto-Generated):</label>
            <input type="text" name="userId" value="<%= nextId %>" class="readonly-field" readonly>

            <input type="text" name="fullName" placeholder="Full Name" required>

            <input type="email" name="email" placeholder="Email Address" required>

            <input type="text"
                   name="phoneNumber"
                   placeholder="Phone Number (e.g. 0771234567)"
                   pattern="[0-9]{10}"
                   maxlength="10"
                   title="Please enter a valid 10-digit phone number"
                   required>

            <input type="password" name="password" placeholder="Password" required>

            <button type="submit">Sign Up</button>
        </form>

        <div class="auth-links">
            Already have an account? <a href="login.jsp">Login Here</a>
        </div>
    </div>

    <!-- Error SweetAlert2 Logic -->
    <script>
        document.addEventListener("DOMContentLoaded", function() {
            const urlParams = new URLSearchParams(window.location.search);
            if (urlParams.has('error')) {
                const errorMsg = urlParams.get('error');
                let title = "Registration Failed!";
                let text = "Please try again.";

                if (errorMsg === 'email_exists') {
                    text = "This email is already registered. Please login to your account.";
                } else if (errorMsg === 'failed') {
                    text = "Something went wrong while creating your account. Please try again.";
                }

                Swal.fire({
                    icon: 'error',
                    title: title,
                    text: text,
                    confirmButtonColor: '#dc3545'
                });
            }
        });
    </script>

</body>
</html>