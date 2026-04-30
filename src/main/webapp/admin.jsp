<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ page isELIgnored="false"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>Admin Dashboard</title>
<%@ include file="all_component/all_css.jsp"%>
<style>
/* Full gradient background */
body, html {
    height: 100%;
    margin: 0;
    font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
    background: linear-gradient(135deg, #283593, #5c6bc0);
    color: #fff;
}

/* Hero container */
.dashboard-container {
    min-height: 85vh;
    display: flex;
    justify-content: center;
    align-items: center;
    padding: 40px 20px;
}

/* Glassmorphism card */
.dashboard-card {
    background: rgba(255, 255, 255, 0.1);
    backdrop-filter: blur(12px);
    border-radius: 15px;
    padding: 40px;
    max-width: 650px;
    width: 100%;
    text-align: center;
    box-shadow: 0 8px 25px rgba(0,0,0,0.2);
}

/* Heading + Subheading */
.dashboard-card h1 {
    font-weight: 700;
    font-size: 2.5rem;
    margin-bottom: 15px;
}

.dashboard-card p {
    font-size: 1.2rem;
    margin-bottom: 30px;
    color: #e0e0e0;
}

/* Action buttons */
.dashboard-actions .btn {
    margin: 10px;
    padding: 12px 25px;
    border-radius: 50px;
    font-weight: bold;
    transition: all 0.3s ease;
}

.btn-post {
    background: #ffc107;
    color: #283593;
    border: none;
}

.btn-post:hover {
    background: #ffb300;
    color: #1a237e;
}

.btn-view {
    background: #fff;
    color: #283593;
    border: none;
}

.btn-view:hover {
    background: #e0e0e0;
    color: #1a237e;
}

.btn-applications {
    background: #4caf50;
    color: #fff;
    border: none;
}

.btn-applications:hover {
    background: #43a047;
    color: #fff;
}
</style>
</head>
<body>

<!-- Restrict Non-Admins -->
<c:if test="${userobj.role ne 'admin'}">
    <c:redirect url="login.jsp"></c:redirect>
</c:if>

<%@ include file="all_component/navbar.jsp"%>

<!-- Dashboard Section -->
<div class="container-fluid dashboard-container">
    <div class="dashboard-card">
        <h1>Welcome, Admin</h1>
        <p>Manage job postings and applications for job seekers.</p>

        <div class="dashboard-actions">
            <a href="add_job.jsp" class="btn btn-post">+ Post Job</a>
            <a href="view_job.jsp" class="btn btn-view">👁 View Jobs</a>
            <a href="view_applications.jsp" class="btn btn-applications">📄 View Applications</a>
        </div>
    </div>
</div>

<%@ include file="all_component/footer.jsp"%>
</body>
</html>
