<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.util.DBUtil"%>
<%@ page import="com.dao.JobDAO"%>
<%@ page import="com.dto.Jobs"%>
<%@ page import="java.util.List"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ page isELIgnored="false"%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>Jobs | JIT JOB PORTAL</title>
<%@ include file="all_component/all_css.jsp"%>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">

<style>
body { background:#f4f6f9; font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;}
.page-title { text-align:center; color:#283593; margin-bottom:30px; font-weight:700; font-size:2rem;}
.job-card { background:#fff; border-radius:12px; padding:25px; margin-bottom:25px; box-shadow:0 6px 20px rgba(0,0,0,0.05);}
.job-card:hover { transform: translateY(-3px); box-shadow:0 10px 30px rgba(0,0,0,0.1);}
.job-header { display:flex; align-items:center; margin-bottom:10px;}
.job-header i { color:#283593; font-size:1.8rem; margin-right:10px;}
.job-header h5 { margin:0; font-weight:600; color:#283593;}
.job-desc { color:#555; font-size:0.95rem; margin-bottom:10px;}
.badge-custom { display:inline-block; background-color:#283593; color:#fff; padding:5px 12px; border-radius:50px; font-size:0.85rem; margin-right:5px; margin-bottom:5px;}
.btn-custom { background-color:#283593; color:#fff; font-weight:500; border-radius:50px; padding:8px 20px; margin-top:10px; transition:all 0.2s ease;}
.btn-custom:hover { background-color:#3949ab; transform:scale(1.05);}
</style>
</head>
<body>

<c:if test="${empty userobj}">
    <c:redirect url="login.jsp" />
</c:if>

<%@ include file="all_component/navbar.jsp"%>

<div class="container">
    <h2 class="page-title">Available Jobs</h2>

    <!-- Filter form -->
    <div class="card mb-4 p-3">
        <form class="row g-3" method="get" action="more_view.jsp">
            <div class="col-md-6">
                <label class="form-label">Location</label>
                <select name="loc" class="form-select">
                    <option value="">All Locations</option>
                    <option value="Odisha">Odisha</option>
                    <option value="Jharkhand">Jharkhand</option>
                    <option value="Gujarat">Gujarat</option>
                    <option value="Bhubaneswar">Bhubaneswar</option>
                    <option value="Delhi">Delhi</option>
                    <option value="Banglore">Banglore</option>
                    <option value="Chennai">Chennai</option>
                    <option value="Hydrabad">Hydrabad</option>
                    <option value="Indore">Indore</option>
                    <option value="Mumbai">Mumbai</option>
                    <option value="Noida">Noida</option>
                    <option value="Gurgaon">Gurgaon</option>
                </select>
            </div>
            <div class="col-md-6">
                <label class="form-label">Category</label>
                <select name="cat" class="form-select">
                    <option value="">All Categories</option>
                    <option value="IT">IT</option>
                    <option value="Developer">Developer</option>
                    <option value="Banking">Banking</option>
                    <option value="Engineer">Engineer</option>
                    <option value="Teacher">Teacher</option>
                </select>
            </div>
            <div class="col-12 text-center">
                <button class="btn btn-custom" type="submit">Filter Jobs</button>
            </div>
        </form>
    </div>

    <%
        String loc = request.getParameter("loc");
        String cat = request.getParameter("cat");
        JobDAO dao = new JobDAO(DBUtil.getConnection());
        List<Jobs> list;

        boolean locEmpty = (loc == null || loc.trim().isEmpty());
        boolean catEmpty = (cat == null || cat.trim().isEmpty());

        if (!locEmpty && !catEmpty) {
            list = dao.getJobsByCategoryAndLocation(cat, loc);
        } else if (!locEmpty) {
            list = dao.getJobsByLocation(loc);
        } else if (!catEmpty) {
            list = dao.getJobsByCategory(cat);
        } else {
            list = dao.getAllJobsForUser();
        }

        if (list == null || list.isEmpty()) {
    %>
        <h4 class="text-center text-danger mt-5">No jobs available</h4>
    <%
        } else {
            for (Jobs j : list) {
    %>
        <div class="job-card">
            <div class="job-header">
                <i class="far fa-clipboard"></i>
                <h5><%= j.getTitle() %></h5>
            </div>
            <p class="job-desc"><%= j.getDescription().length() > 120 ? j.getDescription().substring(0,120) + "..." : j.getDescription() %></p>
            <div>
                <span class="badge-custom">Location: <%= j.getLocation() %></span>
                <span class="badge-custom">Category: <%= j.getCategory() %></span>
            </div>
            <small class="text-muted">Published on: <%= j.getPdate() %></small>
            <div class="text-center mt-2">
                <a href="one_view.jsp?id=<%= j.getId() %>" class="btn btn-custom">View More</a>
                <a href="apply_job.jsp?jobId=<%= j.getId() %>" class="btn btn-custom ms-2">Apply Now</a>
            </div>
        </div>
    <%
            }
        }
    %>

</div>

<%@ include file="all_component/footer.jsp"%>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
