package com.dto;

import java.sql.Timestamp;

public class Jobs {

    private int id;
    private String title;
    private String description;
    private String category;
    private String status;
    private String location;
    private String company;
    private int experience;   // years
    private double salary;    // INR
    private Timestamp pdate;
    
    private String link;
    public String getLink() { return link; }
    public void setLink(String link) { this.link = link; }
    

    public Jobs() {
        super();
    }

    // Getters & Setters
    public int getId() {
        return id;
    }
    public void setId(int id) {
        this.id = id;
    }

    public String getTitle() {
        return title;
    }
    public void setTitle(String title) {
        this.title = title;
    }

    public String getDescription() {
        return description;
    }
    public void setDescription(String description) {
        this.description = description;
    }

    public String getCategory() {
        return category;
    }
    public void setCategory(String category) {
        this.category = category;
    }

    public String getStatus() {
        return status;
    }
    public void setStatus(String status) {
        this.status = status;
    }

    public String getLocation() {
        return location;
    }
    public void setLocation(String location) {
        this.location = location;
    }

    public String getCompany() {
        return company;
    }
    public void setCompany(String company) {
        this.company = company;
    }

    public int getExperience() {
        return experience;
    }
    public void setExperience(int experience) {
        this.experience = experience;
    }

    public double getSalary() {
        return salary;
    }
    public void setSalary(double salary) {
        this.salary = salary;
    }

    public Timestamp getPdate() {
        return pdate;
    }
    public void setPdate(Timestamp pdate) {
        this.pdate = pdate;
    }
}