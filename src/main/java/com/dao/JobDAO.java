package com.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

import com.dto.JobApplication;
import com.dto.Jobs;

public class JobDAO {

    private Connection con;

    public JobDAO(Connection con) {
        this.con = con;
    }

    // Add Job
    public boolean addJobs(Jobs j) {
        boolean f = false;

        String sql = "INSERT INTO job(title,description,category,status,location,company,experience,salary,pdate,link) VALUES(?,?,?,?,?,?,?,?,?,?)";

        try (PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, j.getTitle());
            ps.setString(2, j.getDescription());
            ps.setString(3, j.getCategory());
            ps.setString(4, j.getStatus());
            ps.setString(5, j.getLocation());
            ps.setString(6, j.getCompany());
            ps.setInt(7, j.getExperience());
            ps.setDouble(8, j.getSalary());
            ps.setTimestamp(9, new Timestamp(System.currentTimeMillis()));
            ps.setString(10, j.getLink());

            f = ps.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
        }

        return f;
    }

    // Get All Jobs (Admin)
    public List<Jobs> getAllJobs() {
        List<Jobs> list = new ArrayList<>();
        String sql = "SELECT * FROM job ORDER BY id DESC";
        try (PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                list.add(mapJob(rs));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    // Get Active Jobs (User)
    public List<Jobs> getAllJobsForUser() {
        List<Jobs> list = new ArrayList<>();
        String sql = "SELECT * FROM job WHERE status='Active' ORDER BY id DESC";
        try (PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                list.add(mapJob(rs));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    // Get Job by ID
    public Jobs getJobById(int id) {
        Jobs j = null;
        String sql = "SELECT * FROM job WHERE id=?";
        try (PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                j = mapJob(rs);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return j;
    }

    // Search Jobs by Title + Category + Location
    public List<Jobs> searchJobs(String title, String category, String location) {
        List<Jobs> list = new ArrayList<>();

        String sql = "SELECT * FROM job WHERE status='Active'";
        if (title != null && !title.trim().isEmpty()) {
            sql += " AND LOWER(title) LIKE LOWER(?)";
        }
        if (category != null && !category.trim().isEmpty()) {
            sql += " AND LOWER(category) LIKE LOWER(?)";
        }
        if (location != null && !location.trim().isEmpty()) {
            sql += " AND LOWER(location) LIKE LOWER(?)";
        }
        sql += " ORDER BY id DESC";

        try (PreparedStatement ps = con.prepareStatement(sql)) {
            int index = 1;
            if (title != null && !title.trim().isEmpty()) {
                ps.setString(index++, "%" + title.trim() + "%");
            }
            if (category != null && !category.trim().isEmpty()) {
                ps.setString(index++, "%" + category.trim() + "%");
            }
            if (location != null && !location.trim().isEmpty()) {
                ps.setString(index++, "%" + location.trim() + "%");
            }

            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                list.add(mapJob(rs));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }

    // Update Job
    public boolean updateJob(Jobs j) {
        boolean f = false;
        String sql = "UPDATE job SET title=?,description=?,category=?,status=?,location=?,company=?,experience=?,salary=?, link=? WHERE id=?";
        try (PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, j.getTitle());
            ps.setString(2, j.getDescription());
            ps.setString(3, j.getCategory());
            ps.setString(4, j.getStatus());
            ps.setString(5, j.getLocation());
            ps.setString(6, j.getCompany());
            ps.setInt(7, j.getExperience());
            ps.setDouble(8, j.getSalary());
            ps.setString(9, j.getLink()); // NEW: external link
            ps.setInt(10, j.getId());
            f = ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return f;
    }

    // Delete Job
    public boolean deleteJob(int id) {
        boolean f = false;
        String sqlApp = "DELETE FROM job_applications WHERE job_id=?";
        String sqlJob = "DELETE FROM job WHERE id=?";
        try (PreparedStatement psApp = con.prepareStatement(sqlApp);
             PreparedStatement psJob = con.prepareStatement(sqlJob)) {

            psApp.setInt(1, id);
            psApp.executeUpdate(); // delete applications first

            psJob.setInt(1, id);
            f = psJob.executeUpdate() == 1; // then delete job

        } catch (Exception e) {
            e.printStackTrace();
        }
        return f;
    }

    // Map ResultSet to Job object
    private Jobs mapJob(ResultSet rs) throws Exception {
        Jobs j = new Jobs();
        j.setId(rs.getInt("id"));
        j.setTitle(rs.getString("title"));
        j.setDescription(rs.getString("description"));
        j.setCategory(rs.getString("category"));
        j.setStatus(rs.getString("status"));
        j.setLocation(rs.getString("location"));
        j.setCompany(rs.getString("company"));
        j.setExperience(rs.getInt("experience"));
        j.setSalary(rs.getDouble("salary"));
        j.setPdate(rs.getTimestamp("pdate"));
        j.setLink(rs.getString("link")); // NEW: map external URL
        return j;
    }

    // Apply Job
    public boolean applyJob(int jobId, String name, String email, String resumeFile) {
        boolean f = false;
        String sql = "INSERT INTO job_applications(job_id, user_name, email, resume) VALUES(?,?,?,?)";
        try (PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, jobId);
            ps.setString(2, name);
            ps.setString(3, email);
            ps.setString(4, resumeFile);
            f = ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return f;
    }

    // Get All Applications
    public List<JobApplication> getAllApplications() {
        List<JobApplication> list = new ArrayList<>();
        String sql = "SELECT ja.id, ja.user_name, ja.email, ja.resume, ja.applied_on, "
                   + "j.title as job_title, j.company "
                   + "FROM job_applications ja "
                   + "INNER JOIN job j ON ja.job_id = j.id "
                   + "ORDER BY ja.applied_on DESC";
        try (PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                JobApplication app = new JobApplication();
                app.setId(rs.getInt("id"));
                app.setUserName(rs.getString("user_name"));
                app.setEmail(rs.getString("email"));
                app.setResume(rs.getString("resume"));
                app.setAppliedOn(rs.getTimestamp("applied_on"));
                app.setJobTitle(rs.getString("job_title"));
                app.setCompany(rs.getString("company"));
                list.add(app);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }
    
    
    
    
    
    public List<Jobs> getJobsByLocation(String location) {
        List<Jobs> list = new ArrayList<>();
        String sql = "SELECT * FROM job WHERE location=? AND status='Active' ORDER BY id DESC";

        try (PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, location);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                list.add(mapJob(rs));
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }
    
    public List<Jobs> getJobsByCategory(String category) {

        List<Jobs> list = new ArrayList<>();

        String sql = "SELECT * FROM job WHERE category=? AND status='Active' ORDER BY id DESC";

        try (PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, category);

            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                list.add(mapJob(rs));
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }
    
    public List<Jobs> getJobsByCategoryAndLocation(String category, String location) {

        List<Jobs> list = new ArrayList<>();

        String sql = "SELECT * FROM job WHERE category=? AND location=? AND status='Active' ORDER BY id DESC";

        try (PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, category);
            ps.setString(2, location);

            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                list.add(mapJob(rs));
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }
}