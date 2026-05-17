<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.reservation.model.User" %>
<%@ page import="com.reservation.service.UserService" %>
<%

    String userEmail = (String) session.getAttribute("userEmail");
    if(userEmail == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    UserService userService = new UserService();
    User currentUser = userService.getUserByEmail(userEmail);
%>
<html>
<head>
    <title>My Profile - GrandEats</title>
    <style>

        .page-header { margin-bottom: 25px; border-bottom: 2px solid #f4f7f6; padding-bottom: 15px; }
        .page-header h2 { margin: 0; color: #1a1a1a; display: flex; align-items: center; gap: 10px; transition: 0.3s; }
        .page-header p { color: #666; margin-top: 5px; transition: 0.3s; }

        .profile-container { display: flex; gap: 30px; align-items: flex-start; flex-wrap: wrap; }

        .avatar-card { flex: 1; min-width: 250px; background: white; padding: 30px 20px; border-radius: 10px; box-shadow: 0 4px 15px rgba(0,0,0,0.03); text-align: center; transition: 0.3s; border: 1px solid transparent; }
        .avatar-circle { width: 100px; height: 100px; background: #fdfaf6; border: 2px dashed #f39c12; border-radius: 50%; margin: 0 auto 15px auto; display: flex; align-items: center; justify-content: center; font-size: 40px; color: #f39c12; transition: 0.3s; }
        .avatar-card h3 { margin: 0 0 5px 0; color: #333; transition: 0.3s; }
        .avatar-card p { margin: 0 0 15px 0; color: #888; font-size: 14px; transition: 0.3s; }
        .badge-member { display: inline-block; padding: 5px 15px; background: #1a1a1a; color: #f39c12; border-radius: 20px; font-size: 12px; font-weight: bold; letter-spacing: 1px; transition: 0.3s; }

        .form-card { flex: 2; min-width: 300px; background: white; padding: 30px; border-radius: 10px; box-shadow: 0 4px 15px rgba(0,0,0,0.03); transition: 0.3s; border: 1px solid transparent; }
        .section-title { font-size: 16px; color: #1a1a1a; margin-top: 0; margin-bottom: 20px; border-bottom: 1px solid #eee; padding-bottom: 10px; font-weight: 700; display: flex; align-items: center; gap: 8px; transition: 0.3s; }

        .form-row { display: grid; grid-template-columns: 1fr 1fr; gap: 20px; margin-bottom: 20px; }
        .form-group label { display: block; font-weight: 600; color: #555; margin-bottom: 8px; font-size: 13px; transition: 0.3s; }
        .form-control { width: 100%; padding: 12px 15px; border: 1px solid #ddd; border-radius: 6px; font-family: 'Poppins', sans-serif; font-size: 14px; box-sizing: border-box; transition: 0.3s; background: #fafafa; color: #333; }
        .form-control:focus { border-color: #f39c12; outline: none; background: #fff; }
        .readonly-input { background-color: #f1f1f1; color: #777; cursor: not-allowed; border: 1px dashed #ccc; }

        .btn-action { padding: 12px 25px; border: none; border-radius: 6px; font-weight: bold; cursor: pointer; transition: 0.3s; display: inline-flex; align-items: center; gap: 8px; }
        .btn-update { background: #28a745; color: white; }
        .btn-update:hover { background: #218838; transform: translateY(-2px); }
        .btn-security { background: #1a1a1a; color: white; }
        .btn-security:hover { background: #333; transform: translateY(-2px); }

        .alert { padding: 12px 15px; border-radius: 6px; margin-bottom: 20px; font-weight: bold; border-left: 5px solid; font-size: 14px; }
        .alert-success { background: #d4edda; color: #155724; border-left-color: #28a745; }
        .alert-warning { background: #fff3cd; color: #856404; border-left-color: #ffc107; }
        .alert-danger { background: #f8d7da; color: #721c24; border-left-color: #dc3545; }


        body.dark-mode .page-header { border-bottom-color: #333333; }
        body.dark-mode .page-header h2 { color: #f8f9fa; }
        body.dark-mode .page-header p { color: #aaaaaa; }

        body.dark-mode .avatar-card,
        body.dark-mode .form-card { background: #1e1e1e; border-color: #333333; box-shadow: 0 4px 15px rgba(0,0,0,0.4); }

        body.dark-mode .avatar-circle { background: #2a2a2a; }
        body.dark-mode .avatar-card h3 { color: #f8f9fa; }
        body.dark-mode .avatar-card p { color: #aaaaaa; }
        body.dark-mode .badge-member { background: #000000; border: 1px solid #f39c12; color: #f39c12; }

        body.dark-mode .section-title { color: #f8f9fa; border-bottom-color: #333333; }
        body.dark-mode .form-group label { color: #cccccc; }
        body.dark-mode .form-control { background: #2a2a2a; border-color: #444444; color: #f8f9fa; }
        body.dark-mode .form-control:focus { background: #333333; border-color: #f39c12; }
        body.dark-mode .readonly-input { background-color: #151515; color: #888888; border-color: #444444; }

        body.dark-mode .btn-security { background: #f39c12; color: #1a1a1a; }
        body.dark-mode .btn-security:hover { background: #e67e22; }

        body.dark-mode .alert-success { background: #1b4332; color: #d4edda; border-left-color: #28a745; }
        body.dark-mode .alert-warning { background: #664d03; color: #fff3cd; border-left-color: #ffc107; }
        body.dark-mode .alert-danger { background: #58151c; color: #f8d7da; border-left-color: #dc3545; }
    </style>
</head>
<body>

<jsp:include page="includes/header.jsp" />

<div class="dashboard-wrapper">
    <jsp:include page="includes/sidebar.jsp" />

    <div class="main-content">

        <div class="page-header">
            <h2><i class="fa-solid fa-user-gear" style="color: #f39c12;"></i> My Profile Settings</h2>
            <p>View your account details and update your security preferences.</p>
        </div>

        <% if(request.getParameter("msg") != null) { %>
        <% if(request.getParameter("msg").equals("profile_updated")) { %>
        <div class="alert alert-success"><i class="fa-solid fa-circle-check"></i> Your profile details have been updated successfully!</div>
        <% } else if(request.getParameter("msg").equals("password_updated")) { %>
        <div class="alert alert-success"><i class="fa-solid fa-shield-check"></i> Security updated! Your password has been changed.</div>
        <% } %>
        <% } %>

        <% if(request.getParameter("error") != null) { %>
        <% if(request.getParameter("error").equals("wrong_password")) { %>
        <div class="alert alert-warning"><i class="fa-solid fa-triangle-exclamation"></i> The current password you entered is incorrect.</div>
        <% } else if(request.getParameter("error").equals("update_failed")) { %>
        <div class="alert alert-danger"><i class="fa-solid fa-circle-exclamation"></i> System error: Could not update details. Please try again.</div>
        <% } %>
        <% } %>

        <div class="profile-container">

            <div class="avatar-card">
                <div class="avatar-circle">
                    <i class="fa-regular fa-user"></i>
                </div>
                <h3><%= (currentUser != null) ? currentUser.getFullName() : "Valued Member" %></h3>
                <p>Membership ID: <%= (currentUser != null) ? currentUser.getUserId() : "N/A" %></p>
                <span class="badge-member"><i class="fa-solid fa-star"></i> GOLD MEMBER</span>
            </div>

            <div class="form-card">

                <h3 class="section-title"><i class="fa-solid fa-address-card"></i> Personal Information</h3>
                <form action="UpdateProfileServlet" method="POST">
                    <div class="form-row">
                        <div class="form-group">
                            <label>Full Name</label>
                            <input type="text" name="fullName" class="form-control" value="<%= (currentUser != null) ? currentUser.getFullName() : "" %>" required>
                        </div>
                        <div class="form-group">
                            <label>Phone Number</label>
                            <input type="text" name="phoneNumber" class="form-control" value="<%= (currentUser != null) ? currentUser.getPhoneNumber() : "" %>" pattern="[0-9]{10}" maxlength="10" required>
                        </div>
                    </div>
                    <div class="form-row">
                        <div class="form-group">
                            <label>Email Address (Primary)</label>
                            <input type="email" class="form-control readonly-input" value="<%= userEmail %>" readonly>
                        </div>
                        <div class="form-group">
                            <label>Account User ID</label>
                            <input type="text" class="form-control readonly-input" value="<%= (currentUser != null) ? currentUser.getUserId() : "" %>" readonly>
                        </div>
                    </div>
                    <button type="submit" class="btn-action btn-update"><i class="fa-solid fa-floppy-disk"></i> Save Changes</button>
                </form>

                <h3 class="section-title" style="margin-top: 45px; border-top: 1px solid #eee; padding-top: 30px;">
                    <i class="fa-solid fa-shield-halved"></i> Security & Password
                </h3>
                <form action="ChangePasswordServlet" method="POST">
                    <div class="form-row">
                        <div class="form-group">
                            <label>Current Password</label>
                            <input type="password" name="oldPassword" class="form-control" placeholder="Required for verification" required>
                        </div>
                        <div class="form-group">
                            <label>New Secure Password</label>
                            <input type="password" name="newPassword" class="form-control" placeholder="Enter new password" required>
                        </div>
                    </div>
                    <button type="submit" class="btn-action btn-security"><i class="fa-solid fa-lock"></i> Update Security</button>
                </form>

            </div>
        </div>

    </div>
</div>

</body>
</html>