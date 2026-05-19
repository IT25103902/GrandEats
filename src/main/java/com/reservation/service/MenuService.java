package com.reservation.service;

import com.reservation.model.MenuItem;
import com.reservation.util.DBConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class MenuService {

    // 1. add new food items
    public boolean addMenuItem(MenuItem item) {
        String query = "INSERT INTO menu_items (name, category, price, status, image_url) VALUES (?, ?, ?, ?, ?)";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(query)) {

            ps.setString(1, item.getName());
            ps.setString(2, item.getCategory());
            ps.setInt(3, item.getPrice());
            ps.setString(4, item.getStatus());
            ps.setString(5, item.getImageUrl());

            int result = ps.executeUpdate();
            return result > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    // 2.Get all menu items (show in menu.jsp)    public List<MenuItem> getAllMenuItems() {
    List<MenuItem> menuList = new ArrayList<>();
    String query = "SELECT * FROM menu_items";

        try (Connection con = DBConnection.getConnection();
    PreparedStatement ps = con.prepareStatement(query);
    ResultSet rs = ps.executeQuery()) {

        while (rs.next()) {
            MenuItem item = new MenuItem(
                    rs.getInt("id"),
                    rs.getString("name"),
                    rs.getString("category"),
                    rs.getInt("price"),
                    rs.getString("status"),
                    rs.getString("image_url")
            );
            menuList.add(item);
        }
    } catch (SQLException e) {
        e.printStackTrace();
    }
        return menuList;
}

// 3. Deleting a dish (Admin side)
public boolean deleteMenuItem(int id) {
    String query = "DELETE FROM menu_items WHERE id = ?";
    try (Connection con = DBConnection.getConnection();
         PreparedStatement ps = con.prepareStatement(query)) {

        ps.setInt(1, id);
        int result = ps.executeUpdate();
        return result > 0;
    } catch (SQLException e) {
        e.printStackTrace();
        return false;
    }
}
// 4. Updating a dish (in the database)
public boolean updateMenuItem(MenuItem item) {
    String query = "UPDATE menu_items SET name=?, category=?, price=?, status=?, image_url=? WHERE id=?";
    try (Connection con = DBConnection.getConnection();
         PreparedStatement ps = con.prepareStatement(query)) {

        ps.setString(1, item.getName());
        ps.setString(2, item.getCategory());
        ps.setInt(3, item.getPrice());
        ps.setString(4, item.getStatus());
        ps.setString(5, item.getImageUrl());
        ps.setInt(6, item.getId()); // The ID is the only way to identify the exact food.

        int result = ps.executeUpdate();
        return result > 0;
    } catch (SQLException e) {
        e.printStackTrace();
        return false;
    }
}
// 5.Finding a food by ID (for Edit Page)
public MenuItem getMenuItemById(int id) {
    String query = "SELECT * FROM menu_items WHERE id = ?";
    try (Connection con = DBConnection.getConnection();
         PreparedStatement ps = con.prepareStatement(query)) {

        ps.setInt(1, id);
        try (ResultSet rs = ps.executeQuery()) {
            if (rs.next()) {
                return new MenuItem(
                        rs.getInt("id"),
                        rs.getString("name"),
                        rs.getString("category"),
                        rs.getInt("price"),
                        rs.getString("status"),
                        rs.getString("image_url")
                );
            }
        }
    } catch (SQLException e) {
        e.printStackTrace();
    }
    return null;
  }