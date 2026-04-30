<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ page isELIgnored="false"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>Login | JIT JOB PORTAL</title>
<%@ include file="all_component/all_css.jsp"%>
<style>
/* Basic Reset & Body */
html, body {
    height: 100%;
    margin: 0;
    font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
    background: linear-gradient(135deg, #283593, #5c6bc0);
    display: flex;
    flex-direction: column;
}

/* Main content area (centered form) */
.main-content {
    flex: 1;
    display: flex;
    justify-content: center;
    align-items: center;
    padding: 20px;
}

/* Login form container */
.login-form-container {
    background-color: #fff;
    padding: 40px 50px;
    border-radius: 15px;
    max-width: 500px;
    width: 100%;
    box-shadow: 0 15px 30px rgba(0,0,0,0.15);
    text-align: center;
    position: relative;
    z-index: 1;
    transition: transform 0.3s ease;
}
.login-form-container:hover {
    transform: translateY(-3px);
}

/* Heading */
.login-form-container h2 {
    color: #283593;
    font-weight: 700;
    margin-bottom: 25px;
    font-size: 2rem;
}

/* Input fields */
.form-control {
    width: 100%;
    padding: 12px 15px;
    font-size: 1rem;
    border-radius: 8px;
    border: 1px solid #ccc;
    margin-bottom: 15px;
    transition: all 0.3s ease;
}
.form-control:focus {
    box-shadow: 0 0 0 0.2rem rgba(40, 53, 147, 0.25);
    border-color: #283593;
}

/* Login button */
.btn-login {
    background-color: #283593;
    color: white;
    font-weight: bold;
    width: 100%;
    border-radius: 50px;
    padding: 12px;
    font-size: 1rem;
    transition: background-color 0.3s ease, transform 0.2s ease;
}
.btn-login:hover {
    background-color: #1a237e;
    transform: scale(1.05);
}

/* Alert message */
.alert-custom {
    color: #283593;
    font-weight: 600;
    margin-bottom: 15px;
    font-size: 0.95rem;
    animation: fadeIn 0.5s;
}

/* Additional links */
.login-links {
    margin-top: 12px;
    font-size: 0.9rem;
}
.login-links a {
    color: #283593;
    text-decoration: none;
    font-weight: 500;
}
.login-links a:hover {
    text-decoration: underline;
}

/* Top-right Home link */
.home-link {
    position: absolute;
    top: 20px;
    right: 40px;
}
.home-link a {
    color: white;
    font-weight: bold;
    text-decoration: none;
    font-size: 0.95rem;
    padding: 8px 18px;
    border: 1px solid white;
    border-radius: 25px;
    transition: all 0.3s ease;
}
.home-link a:hover {
    background-color: white;
    color: #283593;
}



@keyframes fadeIn {
    from {opacity: 0;}
    to {opacity: 1;}
}

@media(max-width: 600px) {
    .login-form-container {
        padding: 30px 25px;
    }
    .home-link {
        top: 10px;
        right: 20px;
    }
}
</style>
</head>
<body>

<!-- Top-right Home link -->
<div class="home-link">
    <a href="index.jsp">Home</a>
</div>

<!-- Main content: Login form -->
<div class="main-content">
    <div class="login-form-container">
        <h2>Login</h2>

        <!-- Success/Error message -->
        <c:if test="${not empty succMsg }">
            <div id="loginAlert" class="alert-custom">${succMsg}</div>
            <c:remove var="succMsg" />
        </c:if>

        <!-- Login form -->
        <form action="login" method="post">
            <input type="email" class="form-control" name="email" placeholder="Email" required>
            <input type="password" class="form-control" name="password" placeholder="Password" required>
            <button type="submit" class="btn btn-login">Login</button>
        </form>

        <!-- Additional links -->
        <div class="login-links">
            <p>Don't have an account? <a href="signup.jsp">Sign Up</a></p>
        </div>
    </div>
</div>


<script>
    // Hide alert after 2.5 seconds
    window.onload = function() {
        setTimeout(function() {
            var alertBox = document.getElementById("loginAlert");
            if(alertBox) alertBox.style.display = "none";
        }, 2500);
    }
</script>
</body>
</html>
