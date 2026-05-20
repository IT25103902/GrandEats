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

@WebServlet("/UpdateMenuItemServlet")
public class UpdateMenuItemServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        String role = (String) session.getAttribute("role");

        if (role == null || !role.equals("admin")) {
            response.sendRedirect("login.jsp");
            return;
        }

        try {
            // In the new way, we find food by ID.
            int id = Integer.parseInt(request.getParameter("id"));

            // new details
            String newName = request.getParameter("name");
            String category = request.getParameter("category");
            int price = Integer.parseInt(request.getParameter("price")); //Price is now an Int.
            String status = request.getParameter("status");
            String imageUrl = request.getParameter("imageUrl");

            // Pass the details to the new constructor (along with the ID)
            MenuItem updatedItem = new MenuItem(id, newName, category, price, status, imageUrl);
            MenuService ms = new MenuService();

            //Calling the new method of MenuService
            if (ms.updateMenuItem(updatedItem)) {
                response.sendRedirect("admin_menu.jsp?msg=item_updated");
            } else {
                response.sendRedirect("admin_menu.jsp?error=update_failed");
            }

        } catch (NumberFormatException e) {
            //The error that appears if the ID or Price cannot be taken as a number
            e.printStackTrace();
            response.sendRedirect("admin_menu.jsp?error=invalid_data");
        }
    }
}
