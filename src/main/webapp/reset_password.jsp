<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Reset Password - GrandEats</title>
    <style>
        .auth-container { max-width: 400px; margin: 80px auto; background: white; padding: 40px; border-radius: 10px; box-shadow: 0 10px 25px rgba(0,0,0,0.1); text-align: center; font-family: 'Poppins', sans-serif; }
        .auth-container h2 { color: #f39c12; margin-bottom: 10px; }
        .auth-container p { color: #666; margin-bottom: 25px; font-size: 14px; }
        .auth-form input { width: 100%; padding: 12px; margin-bottom: 15px; border: 1px solid #ddd; border-radius: 5px; box-sizing: border-box; font-family: 'Poppins', sans-serif; }
        .auth-form input:focus { border-color: #f39c12; outline: none; }
        .btn-submit { width: 100%; padding: 12px; background: #28a745; color: white; border: none; border-radius: 5px; font-weight: bold; cursor: pointer; font-size: 16px; transition: 0.3s; }
        .btn-submit:hover { background: #218838; transform: translateY(-2px); }
        .alert-success { background: #d4edda; color: #155724; padding: 10px; border-radius: 5px; margin-bottom: 15px; font-size: 13px; font-weight: bold; display: none; }
        .alert-error { background: #f8d7da; color: #721c24; padding: 10px; border-radius: 5px; margin-bottom: 15px; font-size: 13px; font-weight: bold; display: none; }
    </style>
</head>
<body>

    <jsp:include page="includes/header.jsp" />

    <div class="auth-container animate-up">
        <h2>Secure Password Reset</h2>
        <p>Please enter the 6-digit code sent to your email along with your new password.</p>

        <%-- Status Messages --%>
        <% if(request.getParameter("status") != null && request.getParameter("status").equals("sent")) { %>
            <div class="alert-success" style="display: block;">
                <i class="fa-solid fa-check-circle"></i> Verification code sent successfully! Check your inbox.
            </div>
        <% } %>

        <% if(request.getParameter("error") != null) { %>
            <div class="alert-error" style="display: block;">
                <% if(request.getParameter("error").equals("invalid_otp")) { out.print("Incorrect verification code. Please try again."); } %>
                <% if(request.getParameter("error").equals("update_failed")) { out.print("Failed to update password. Please try again later."); } %>
            </div>
        <% } %>

        <form action="ResetPasswordServlet" method="POST" class="auth-form">
            <input type="text" name="otp" placeholder="Enter 6-Digit Code" maxlength="6" pattern="[0-9]{6}" required>
            <input type="password" name="newPassword" placeholder="Enter New Password" required>
            <button type="submit" class="btn-submit">Reset Password</button>
        </form>

        <a href="login.jsp" style="display: block; margin-top: 20px; font-size: 13px; color: #777; text-decoration: none;">Cancel and Back to Login</a>
    </div>

</body>
</html>