<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ page isELIgnored="false"%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>Application Status | JIT JOB PORTAL</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">

<style>
body {
    font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
    background-color: #f0f2f5;
    margin: 0;
    padding: 0;
}

/* Centered card */
.container-card {
    max-width: 500px;
    margin: 120px auto;
    background: #fff;
    padding: 40px 30px;
    border-radius: 15px;
    box-shadow: 0 12px 35px rgba(0,0,0,0.1);
    text-align: center;
    transition: transform 0.3s ease, box-shadow 0.3s ease;
}
.container-card:hover {
    transform: translateY(-3px);
    box-shadow: 0 16px 40px rgba(0,0,0,0.15);
}

h2 {
    font-weight: 600;
    margin-bottom: 25px;
    color: #283593;
}

/* Success/Failure Icons */
.status-icon {
    font-size: 60px;
    margin-bottom: 20px;
}

.alert-success {
    color: #28a745;
}

.alert-danger {
    color: #dc3545;
}

.msg-text {
    font-size: 1.15rem;
    font-weight: 500;
    margin-bottom: 25px;
}

/* Back button */
.btn-home {
    background-color: #283593;
    color: white;
    border-radius: 50px;
    padding: 12px 28px;
    font-weight: 500;
    text-decoration: none;
    transition: all 0.3s ease;
}
.btn-home:hover {
    background-color: #3949ab;
    color: white;
}

/* Animation for icon */
@keyframes pop {
    0% { transform: scale(0.5); opacity: 0; }
    60% { transform: scale(1.2); opacity: 1; }
    100% { transform: scale(1); }
}

.status-icon {
    animation: pop 0.5s ease;
}

/* Responsive */
@media (max-width: 576px) {
    .container-card { padding: 30px 20px; margin: 80px 15px; }
    .status-icon { font-size: 50px; }
}
</style>
</head>

<body>

<div class="container container-card">

    <!-- Status Icon -->
    <c:choose>
        <c:when test="${sessionScope.msgType eq 'success'}">
            <i class="fas fa-check-circle status-icon alert-success"></i>
        </c:when>
        <c:otherwise>
            <i class="fas fa-times-circle status-icon alert-danger"></i>
        </c:otherwise>
    </c:choose>

    <!-- Heading -->
    <h2>Application Status</h2>

    <!-- Message -->
    <c:choose>
        <c:when test="${sessionScope.msgType eq 'success'}">
            <div class="msg-text text-success">${sessionScope.msgText}</div>
        </c:when>
        <c:otherwise>
            <div class="msg-text text-danger">${sessionScope.msgText}</div>
        </c:otherwise>
    </c:choose>

    <!-- Back to Jobs Button -->
    <a href="home.jsp" class="btn-home"><i class="fas fa-arrow-left me-1"></i> Back to Jobs</a>

</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script>
window.onload = function () {
    // Clear session messages after displaying once
    <% 
        session.removeAttribute("msgType");
        session.removeAttribute("msgText");
    %>
};
</script>

</body>
</html>
