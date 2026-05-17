package com.reservation.model;

public class MenuItem {
    private int id;
    private String name;
    private String category;
    private int price; // දැන් Price එක Integer එකක්
    private String status;
    private String imageUrl;

    //1. Constructor used to add a new food (no ID)
    public MenuItem(String name, String category, int price, String status, String imageUrl) {
        this.name = name;
        this.category = category;
        this.price = price;
        this.status = status;
        this.imageUrl = imageUrl;
    }

    // 2.The constructor used to read/update a food from the database (with the ID)
    public MenuItem(int id, String name, String category, int price, String status, String imageUrl) {
        this.id = id;
        this.name = name;
        this.category = category;
        this.price = price;
        this.status = status;
        this.imageUrl = imageUrl;
    }

    // Getters and Setters
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public String getName() { return name; }
    public void setName(String name) { this.name = name; }

    public String getCategory() { return category; }
    public void setCategory(String category) { this.category = category; }

    public int getPrice() { return price; }
    public void setPrice(int price) { this.price = price; }

    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }

    public String getImageUrl() { return imageUrl; }
    public void setImageUrl(String imageUrl) { this.imageUrl = imageUrl; }
}