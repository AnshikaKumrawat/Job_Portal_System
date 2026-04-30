<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.util.DBUtil"%>
<%@ page import="com.dao.JobDAO"%>
<%@ page import="com.dto.Jobs"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ page isELIgnored="false"%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>Job Details | JIT JOB PORTAL</title>
<%@ include file="all_component/all_css.jsp"%>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">

<style>
body { font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; background: #f5f6fa; }
.job-card { background: #fff; padding: 30px; border-radius: 12px; margin-bottom:50px; box-shadow:0 6px 20px rgba(0,0,0,0.05); margin-top:50px; max-width:800px; margin-left:auto; margin-right:auto;}
.job-header i { font-size:3rem; color:#283593; }
.job-title { color:#283593; font-weight:600; margin-top:15px; text-align:center;}
.job-desc { color:#555; font-size:1rem; text-align:justify; margin-bottom:20px;}
.badge-custom { display:inline-block; padding:6px 14px; border-radius:50px; font-size:0.9rem; margin-right:5px; margin-bottom:5px; color:#fff;}
.bg-location { background-color:#283593; }
.bg-category { background-color:#3949ab; }
.bg-status { background-color:#43a047; }
.bg-company { background-color:#1e88e5; }
.btn-back, .btn-apply { border-radius:50px; padding:6px 20px; transition: all 0.2s ease; text-decoration:none; }
.btn-back { background-color:#283593; color:#fff; }
.btn-back:hover { background-color:#3949ab; transform:scale(1.05); color:#fff; }
.btn-apply { background-color:#2e7d32; color:#fff; }
.btn-apply:hover { background-color:#388e3c; transform:scale(1.05); color:#fff; }
.job-meta { margin:15px 0; font-size:0.95rem; color:#555; }
.job-meta i { margin-right:5px; color:#283593; }
</style>
</head>
<body>

<c:if test="${empty userobj}">
    <c:redirect url="login.jsp" />
</c:if>

<%@ include file="all_component/navbar.jsp"%>

<div class="container">
    <%
        int id = Integer.parseInt(request.getParameter("id"));
        JobDAO dao = new JobDAO(DBUtil.getConnection());
        Jobs j = dao.getJobById(id);
        SimpleDateFormat sdf = new SimpleDateFormat("dd MMM yyyy");
    %>

    <div class="job-card text-center">
        <div class="job-header mb-3">
            <i class="far fa-clipboard"></i>
        </div>

        <h3 class="job-title"><%= j.getTitle() %></h3>

        <div class="my-3">
            <span class="badge-custom bg-location"><i class="fas fa-map-marker-alt"></i> <%= j.getLocation() %></span>
            <span class="badge-custom bg-category"><i class="fas fa-briefcase"></i> <%= j.getCategory() %></span>
            <span class="badge-custom bg-status"><i class="fas fa-check-circle"></i> <%= j.getStatus() %></span>
            <span class="badge-custom bg-company"><i class="fas fa-building"></i> <%= j.getCompany() %></span>
        </div>

        <div class="job-meta">
            <i class="fas fa-hourglass-half"></i> Experience: <%= j.getExperience() %> Years |
            <i class="fas fa-money-bill-wave"></i> Salary: ₹ <%= j.getSalary() %>
        </div>

        <div class="job-desc">
            <p><%= j.getDescription() %></p>
        </div>

        <hr>

        <div class="d-flex justify-content-between align-items-center flex-wrap">
            <small class="text-muted">Published On: <%= sdf.format(j.getPdate()) %></small>
            <div class="mt-2">
                <a href="home.jsp" class="btn btn-back me-2"><i class="fas fa-arrow-left me-1"></i> Back to Jobs</a>
                <a href="apply_job.jsp?jobId=<%= j.getId() %>" class="btn btn-apply"><i class="fas fa-paper-plane me-1"></i> Apply Now</a>
            </div>
        </div>
    </div>
</div>

<%@ include file="all_component/footer.jsp"%>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
