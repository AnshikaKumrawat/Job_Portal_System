<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@page import="com.util.DBUtil"%>
<%@page import="java.sql.Connection"%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>Home | JIT JOB PORTAL</title>
<%@ include file="all_component/all_css.jsp"%>
<style>
/* Full-page gradient background */
/* Full-page gradient background */
body, html {
    height: 100%;
    margin: 0;
    padding: 0;
    font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
    background: linear-gradient(135deg, #283593, #5c6bc0);
    color: #fff;
}

/* Fix navbar spacing */
.navbar {
    margin-bottom: 0 !important;
}

/* Hero Section */
.section-container {
    min-height: 85vh;
    display: flex;
    align-items: center;
    padding: 20px 0; /* reduced padding */
}

.left-content {
    display: flex;
    flex-direction: column;
    justify-content: center;
    padding: 40px;
}

.left-content h2 {
    font-weight: 700;
    font-size: 2.5rem;
    margin-bottom: 20px;
    line-height: 1.2;
}

.left-content p {
    font-size: 1.1rem;
    margin-bottom: 25px;
    color: #e0e0e0;
}

.left-content .btn-primary {
    background-color: #ffc107;
    border: none;
    color: #283593;
    font-weight: bold;
    padding: 12px 30px;
    border-radius: 50px;
    transition: all 0.3s ease;
    text-decoration: none;
}

.left-content .btn-primary:hover {
    background-color: #ffb300;
    color: #1a237e;
}

.right-content img {
    width: 100%;
    max-width: 500px;
    height: auto;
    border-radius: 15px;
    box-shadow: 0 15px 30px rgba(0,0,0,0.2);
    transition: transform 0.3s ease;
}

.right-content img:hover {
    transform: scale(1.05);
}

/* Footer will appear clearly */
footer {
    width: 100%;
    text-align: center;
    padding: 15px 0;
    font-size: 0.9rem;
}

/* Responsive */
@media(max-width: 992px) {
    .section-container {
        flex-direction: column-reverse;
        text-align: center;
    }
    .left-content h2 {
        font-size: 2rem;
    }
    .left-content p {
        font-size: 1rem;
    }
    .right-content img {
        max-width: 80%;
        margin-bottom: 30px;
    }
}
</style>
</head>
<body>

<%@ include file="all_component/navbar.jsp"%>

<div class="container-fluid section-container">
    <div class="row align-items-center">
        <!-- Left (Description) -->
        <div class="col-lg-6 left-content">
    <h2>Find Your Dream Job</h2>
    <p>
        Welcome to <b>JOB PORTAL</b>.  
        Explore thousands of job opportunities across multiple domains.  
        Sign up today and take the first step towards your career.
    </p>

    <%
        // Check if user is logged in
        Object userObj = session.getAttribute("userobj");
        if(userObj != null) {
            // Logged in → show Dashboard button
    %>
            <a href="home.jsp" class="btn btn-primary">Go to Dashboard</a>
    <%
        } else {
            // Not logged in → show Signup button
    %>
            <a href="signup.jsp" class="btn btn-primary">Get Started</a>
    <%
        }
    %>
</div>


        <!-- Right (Image) -->
        <div class="col-lg-6 right-content text-center">
            <img src="img/bg.svg" alt="Job Portal Hero Image">
        </div>
    </div>
</div>

<%@ include file="all_component/footer.jsp"%>

</body>
</html>
