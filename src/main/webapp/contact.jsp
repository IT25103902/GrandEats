<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Contact Us - GrandEats</title>

    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>

    <style>
        .contact-wrapper { display: flex; gap: 30px; }
        .contact-info, .contact-form { background: white; padding: 30px; border-radius: 10px; box-shadow: 0 4px 15px rgba(0,0,0,0.05); flex: 1; }
        .info-item { display: flex; align-items: center; gap: 15px; margin-bottom: 20px; }
        .info-item i { font-size: 24px; color: #f39c12; background: #fff3e0; padding: 15px; border-radius: 50%; }

        .contact-form input, .contact-form textarea { width: 100%; padding: 12px; margin-bottom: 15px; border: 1px solid #ddd; border-radius: 5px; font-family: 'Poppins', sans-serif; transition: 0.3s; }
        .contact-form input:focus, .contact-form textarea:focus { border-color: #f39c12; outline: none; box-shadow: 0 0 8px rgba(243, 156, 18, 0.2); }
        .contact-form button { width: 100%; padding: 12px; background: #1a1a1a; color: white; border: none; border-radius: 5px; font-size: 16px; cursor: pointer; transition: 0.3s; font-weight: bold; }
        .contact-form button:hover { background: #f39c12; }
    </style>
</head>
<body>

    <jsp:include page="includes/header.jsp" />

    <div class="container animate-up">
        <h2 style="text-align: center; margin-bottom: 30px;">Get In Touch</h2>

        <div class="contact-wrapper">
            <div class="contact-info delay-1 animate-up">
                <h3>Contact Information</h3>
                <p style="color: #666; margin-bottom: 30px;">Feel free to reach out to us for bulk reservations or special event inquiries.</p>

                <div class="info-item">
                    <i class="fa-solid fa-location-dot"></i>
                    <div>
                        <strong>Address</strong>
                        <p style="margin:0; color:#555;">No 123, Main Street, Colombo 03</p>
                    </div>
                </div>
                <div class="info-item">
                    <i class="fa-solid fa-phone"></i>
                    <div>
                        <strong>Phone</strong>
                        <p style="margin:0; color:#555;">+94 11 234 5678</p>
                    </div>
                </div>
                <div class="info-item">
                    <i class="fa-solid fa-envelope"></i>
                    <div>
                        <strong>Email</strong>
                        <p style="margin:0; color:#555;">reservations@grandeats.com</p>
                    </div>
                </div>
            </div>

            <div class="contact-form delay-2 animate-up">
                <h3>Send a Message</h3>

                <%
                    // Retrieve user details from session if logged in
                    String sName = session.getAttribute("userName") != null ? (String) session.getAttribute("userName") : "";
                    String sEmail = session.getAttribute("userEmail") != null ? (String) session.getAttribute("userEmail") : "";

                    // Make name and email fields read-only if the user is already logged in
                    String readOnlyAttr = !sName.isEmpty() ? "readonly style='background-color: #f9f9f9; cursor: not-allowed; color: #888;'" : "";
                %>

                <form action="SubmitMessageServlet" method="POST">
                    <input type="text" name="name" placeholder="Your Full Name" value="<%= sName %>" <%= readOnlyAttr %> required>
                    <input type="email" name="email" placeholder="Your Email Address" value="<%= sEmail %>" <%= readOnlyAttr %> required>

                    <input type="text" name="subject" placeholder="Subject">
                    <textarea name="message" rows="5" placeholder="Write your message here..." required></textarea>
                    <button type="submit"><i class="fa-solid fa-paper-plane"></i> Send Message</button>
                </form>
            </div>
        </div>
    </div>

    <script>
        document.addEventListener("DOMContentLoaded", function() {
            // Check for URL parameters (?success=true or ?error=true)
            const urlParams = new URLSearchParams(window.location.search);

            // Trigger success alert if message sent successfully
            if (urlParams.has('success')) {
                Swal.fire({
                    icon: 'success',
                    title: 'Message Sent!',
                    text: 'Thank you for contacting GrandEats. We will get back to you soon!',
                    confirmButtonColor: '#f39c12'
                }).then(() => {
                    // Clean the URL to prevent re-triggering alert on page refresh
                    window.history.replaceState(null, null, window.location.pathname);
                });
            }
            // Trigger error alert if database operation fails
            else if (urlParams.has('error')) {
                Swal.fire({
                    icon: 'error',
                    title: 'Oops...',
                    text: 'Something went wrong. Please try again later.',
                    confirmButtonColor: '#dc3545'
                }).then(() => {
                    // Clean the URL to prevent re-triggering alert on page refresh
                    window.history.replaceState(null, null, window.location.pathname);
                });
            }
        });
    </script>

</body>
</html>