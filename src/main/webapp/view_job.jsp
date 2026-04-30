<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.util.DBUtil"%>
<%@ page import="com.dao.JobDAO"%>
<%@ page import="com.dto.Jobs"%>
<%@ page import="java.util.List"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ page isELIgnored="false"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Admin: View Jobs | JIT JOB PORTAL</title>
<%@ include file="all_component/all_css.jsp"%>

<!-- External Fonts & Icons -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">

<style>
body { background: #f8f9fa; font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; }
.container { padding-top: 40px; padding-bottom: 60px; }

/* Job Card */
.card {
    border-radius: 12px;
    box-shadow: 0 4px 15px rgba(0,0,0,0.1);
    transition: transform 0.3s ease, box-shadow 0.3s ease;
    margin-bottom: 20px;
    background: #fff;
    padding: 20px;
}
.card:hover {
    transform: translateY(-5px);
    box-shadow: 0 10px 30px rgba(0,0,0,0.15);
}

/* Job Title & Company */
.card h5 { color: #1a237e; font-weight: 700; margin-bottom: 5px; }
.card h6 { color: #3949ab; font-weight: 500; margin-bottom: 10px; }

/* Description */
.card p { color: #424242; font-size: 0.95rem; line-height: 1.4; }

/* Job Details Row */
.job-details { margin-top: 10px; display: flex; flex-wrap: wrap; gap: 10px; }
.job-details div {
    background: #e8eaf6;
    padding: 5px 12px;
    border-radius: 20px;
    font-size: 0.85rem;
    color: #1a237e;
    font-weight: 500;
}

/* Buttons */
.btn-custom {
    background-color: #1a237e;
    color: #fff;
    border-radius: 50px;
    padding: 6px 20px;
    font-weight: 500;
    transition: all 0.2s ease;
    font-size: 0.85rem;
}
.btn-custom:hover {
    background-color: #3949ab;
    transform: scale(1.05);
}

/* Back Button */
.back-text {
    text-decoration: none;
    color: #1a237e;
    font-weight: 500;
    font-size: 1rem;
}
.back-text:hover { color: #3949ab; }

/* Publish Date */
.publish-date {
    font-size: 0.85rem;
    color: #616161;
    margin-top: 10px;
}
</style>
</head>
<body>

<c:if test="${userobj.role ne 'admin'}">
    <c:redirect url="login.jsp"></c:redirect>
</c:if>

<%@ include file="all_component/navbar.jsp"%>

<div class="container">
    <div class="mb-4">
        <a href="admin.jsp" class="back-text"><i class="fas fa-arrow-left"></i> Back to Dashboard</a>
    </div>

    <h4 class="text-center mb-4" style="color: #1a237e;">All Jobs</h4>

    <c:if test="${not empty succMsg}">
        <div id="alert-msg" class="alert text-white" style="background-color: #1a237e;">
            ${succMsg}
        </div>
        <c:remove var="succMsg" />
    </c:if>

    <%
        JobDAO dao = new JobDAO(DBUtil.getConnection());
        List<Jobs> list = dao.getAllJobs();
        SimpleDateFormat sdf = new SimpleDateFormat("dd-MM-yyyy HH:mm");
        for (Jobs j : list) {
    %>
    <div class="card">
        <div class="d-flex justify-content-between align-items-start mb-2">
            <div>
                <h5><%= j.getTitle() %></h5>
                <h6><i class="fas fa-building"></i> <%= j.getCompany() %></h6>
            </div>
            <div>
                <span class="badge bg-success"><%= j.getStatus() %></span>
            </div>
        </div>

        <p><%= j.getDescription() %></p>

        <div class="job-details">
            <div><i class="fas fa-map-marker-alt"></i> <%= j.getLocation() %></div>
            <div><i class="fas fa-layer-group"></i> <%= j.getCategory() %></div>
            <div><i class="fas fa-clock"></i> <%= j.getExperience() %> yrs</div>
            <div><i class="fas fa-money-bill-wave"></i> ₹ <%= j.getSalary() %></div>
        </div>

        <div class="publish-date">Published on: <%= sdf.format(j.getPdate()) %></div>

        <div class="mt-3 text-end">
            <a href="edit_job.jsp?id=<%= j.getId() %>" class="btn btn-custom me-2"><i class="fas fa-edit"></i> Edit</a>
            <form action="delete" method="post" style="display:inline;">
                <input type="hidden" name="id" value="<%= j.getId() %>">
                <button type="submit" class="btn btn-custom"><i class="fas fa-trash-alt"></i> Delete</button>
            </form>
        </div>
    </div>
    <%
        }
    %>
</div>

<script>
window.onload = function() {
    var alertBox = document.getElementById('alert-msg');
    if (alertBox) setTimeout(() => alertBox.style.display = 'none', 2000);
}
</script>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
