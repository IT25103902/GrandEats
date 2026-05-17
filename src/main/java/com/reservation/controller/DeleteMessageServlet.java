package com.reservation.controller;

import com.reservation.service.MessageService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet("/DeleteMessageServlet")
public class DeleteMessageServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // 1. Security Check: Verify if the user session belongs to an admin
        HttpSession session = request.getSession();
        String role = (String) session.getAttribute("role");

        if (role == null || !role.equals("admin")) {
            response.sendRedirect("login.jsp");
            return;
        }

        // 2. Delete Process: Handle data removal and manage dashboard redirection
        try {
            int id = Integer.parseInt(request.getParameter("id"));
            MessageService ms = new MessageService();

            String redirectUrl = ms.deleteMessage(id) ? "admin_messages.jsp?deleted=true" : "admin_messages.jsp?error=true";
            response.sendRedirect(redirectUrl);

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("admin_messages.jsp?error=true");
        }
    }
}