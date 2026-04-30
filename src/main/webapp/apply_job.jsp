<%@ page import="com.dao.JobDAO"%>
<%@ page import="com.dto.Jobs"%>
<%@ page import="com.util.DBUtil"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ page isELIgnored="false"%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>Apply for Job | JIT JOB PORTAL</title>

<%@ include file="all_component/all_css.jsp"%>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">

<style>
body {
    font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
    background: #f5f6fa;
    margin:0; padding:0;
}

/* Container Card */
.container-card {
    max-width: 650px;
    margin: 50px auto;
    background: #fff;
    padding: 35px 40px;
    border-radius: 15px;
    box-shadow: 0 12px 25px rgba(0,0,0,0.1);
    transition: transform 0.3s ease, box-shadow 0.3s ease;
}
.container-card:hover {
    transform: translateY(-3px);
    box-shadow: 0 16px 35px rgba(0,0,0,0.15);
}

h2 {
    text-align: center;
    color: #283593;
    margin-bottom: 30px;
    font-weight: 600;
}

/* Form Fields */
.form-label {
    font-weight: 500;
}
input, textarea, select {
    width: 100%;
    padding: 12px 15px;
    margin-bottom: 20px;
    border: 1px solid #ccc;
    border-radius: 8px;
    transition: border 0.2s ease, box-shadow 0.2s ease;
}
input:focus, textarea:focus, select:focus {
    border-color: #283593;
    box-shadow: 0 0 8px rgba(40,53,147,0.2);
}

/* Submit Button */
input[type="submit"] {
    background-color: #283593;
    color: #fff;
    border-radius: 50px;
    font-size: 16px;
    font-weight: 600;
    cursor: pointer;
    padding: 12px 30px;
    border: none;
    transition: all 0.2s ease;
}
input[type="submit"]:hover {
    background-color: #3949ab;
    transform: scale(1.05);
}

/* Back Button */
.back-btn {
    display: inline-block;
    margin-bottom: 20px;
    color: #283593;
    font-weight: 500;
    text-decoration: none;
    transition: all 0.2s ease;
}
.back-btn i {
    margin-right: 5px;
}
.back-btn:hover {
    color: #3949ab;
}

/* Alerts */
.alert-success, .alert-danger {
    padding: 10px;
    border-radius: 8px;
    text-align: center;
    margin-bottom: 20px;
}
.alert-success { background: #28a745; color: #fff; }
.alert-danger { background: #dc3545; color: #fff; }

/* Responsive */
@media (max-width: 576px) {
    .container-card { padding: 25px 20px; }
}
</style>
</head>
<body>

<%
    String jobId = request.getParameter("jobId");
    Jobs job = null;
    if (jobId != null) {
        JobDAO dao = new JobDAO(DBUtil.getConnection());
        job = dao.getJobById(Integer.parseInt(jobId));
        request.setAttribute("job", job);
    }
%>

<div class="container container-card">

    <!-- Back Button -->
    <a href="home.jsp" class="back-btn">
        <i class="fas fa-arrow-left"></i> Back to Jobs
    </a>

    <h2>Apply for Job</h2>

    <!-- Messages -->
    <c:if test="${not empty succMsg}">
        <div class="alert-success">${succMsg}</div>
        <c:remove var="succMsg"/>
    </c:if>

    <c:if test="${not empty errMsg}">
        <div class="alert-danger">${errMsg}</div>
        <c:remove var="errMsg"/>
    </c:if>

    <!-- Job Details -->
    <c:if test="${not empty job}">
        <div class="mb-3">
            <label class="form-label">Job Title</label>
            <input type="text" value="${job.title}" readonly>
        </div>

        <div class="mb-3">
            <label class="form-label">Company</label>
            <input type="text" value="${job.company}" readonly>
        </div>
    </c:if>

    <!-- Apply Form -->
    <form action="ApplyJobServlet" method="post" enctype="multipart/form-data">

        <input type="hidden" name="jobId" value="${job.id}">

        <label class="form-label">Your Name</label>
        <input type="text" name="name" placeholder="Enter your full name" required>

        <label class="form-label">Email</label>
        <input type="email" name="email" placeholder="Enter your email" required>

        <label class="form-label">Upload Resume</label>
        <input type="file" name="resume" accept=".pdf,.doc,.docx" required>

        <div class="text-center">
            <input type="submit" value="Apply Now">
        </div>
    </form>

</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script>
window.onload = function () {
    setTimeout(() => {
        document.querySelectorAll('.alert-success,.alert-danger')
            .forEach(e => e.style.display = 'none');
    }, 3000);
}
</script>

</body>
</html>
