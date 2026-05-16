package com.reservation.controller;

import com.reservation.service.MessageService;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/SubmitMessageServlet")
public class SubmitMessageServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String subject = request.getParameter("subject");
        String message = request.getParameter("message");

        // Combine subject and message into a formatted string
        String fullMessage = "Subject: " + subject + " | Message: " + message;

        MessageService ms = new MessageService();
        boolean isSaved = ms.addmessage(name, email, fullMessage);

        // Redirect to contact page with proper success or error query parameter
        String redirectUrl = isSaved ? "contact.jsp?success=true" : "contact.jsp?error=true";
        response.sendRedirect(redirectUrl);
    }
}