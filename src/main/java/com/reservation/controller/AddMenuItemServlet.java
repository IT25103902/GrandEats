package com.reservation.controller;

import com.reservation.model.MenuItem;
import com.reservation.service.MenuService;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet("/AddMenuItemServlet")
public class AddMenuItemServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        String role = (String) session.getAttribute("role");

        if (role == null || !role.equals("admin")) {
            response.sendRedirect("login.jsp");
            return;
        }

        try {
            // Get the data from the form
            String name = request.getParameter("name");
            String category = request.getParameter("category");
            int price = Integer.parseInt(request.getParameter("price")); // Converts Price to an Int            String status = request.getParameter("status");
            String imageUrl = request.getParameter("imageUrl");


// Creates a new object using a constructor without an ID
            MenuItem newItem = new MenuItem(name, category, price, status, imageUrl);
            MenuService ms = new MenuService();

            // Save to the database
            if (ms.addMenuItem(newItem)) {
                response.sendRedirect("admin_menu.jsp?msg=item_added");
            } else {
                response.sendRedirect("admin_menu.jsp?error=add_failed");
            }
        } catch (NumberFormatException e) {
            // Catch the error that occurs when typing in the price field
            e.printStackTrace();
            response.sendRedirect("admin_menu.jsp?error=invalid_price");
        }
    }
}
// It receives form data from admin_menu.jsp