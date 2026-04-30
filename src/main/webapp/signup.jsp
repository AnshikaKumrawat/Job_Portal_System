<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ page isELIgnored="false"%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>Sign Up | JIT JOB PORTAL</title>
<%@ include file="all_component/all_css.jsp"%>
<style>
    body, html {
        height: 100%;
        margin: 0;
        font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        background: linear-gradient(135deg, #283593, #5c6bc0);
        display: flex;
        flex-direction: column;
        justify-content: flex-start; /* top se start */
        align-items: center;
        min-height: 100vh;
    }

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

    .signup-form-container {
        background-color: white;
        padding: 30px 50px;
        border-radius: 12px;
        width: 100%;
        max-width: 600px;
        box-shadow: 0 15px 30px rgba(0,0,0,0.1);
        text-align: center;
        margin: 60px 0; /* upar niche space */
    }

    .signup-form-container h2 {
        color: #283593;
        font-weight: 700;
        margin-bottom: 20px;
        font-size: 1.8rem;
    }

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
        box-shadow: none;
        border-color: #283593;
    }

    .btn-signup {
        background-color: #283593;
        color: white;
        font-weight: bold;
        width: 100%;
        border-radius: 50px;
        padding: 12px;
        margin-top: 5px;
        font-size: 1rem;
        transition: background-color 0.3s ease;
    }

    .btn-signup:hover {
        background-color: #1a237e;
    }

    .alert-custom {
        color: #283593;
        font-weight: 600;
        margin-bottom: 12px;
        font-size: 0.95rem;
    }

    .signup-links {
        margin-top: 12px;
        font-size: 0.9rem;
    }

    .signup-links a {
        color: #283593;
        text-decoration: none;
        font-weight: 500;
    }

    .signup-links a:hover {
        text-decoration: underline;
    }

    

    @media(max-width: 700px) {
        .signup-form-container {
            padding: 20px 25px;
            max-width: 100%;
        }

        .home-link {
            right: 20px;
            top: 10px;
        }
    }
</style>
</head>
<body>

    <div class="home-link">
        <a href="index.jsp">Home</a>
    </div>

    <div class="signup-form-container">
        <h2>Create Your Account</h2>

        <c:if test="${not empty succMsg }">
            <div id="signupMsg" class="alert-custom">${succMsg}</div>
            <c:remove var="succMsg" />
        </c:if>

        <form action="add_user" method="post">
            <input type="text" class="form-control" name="name" placeholder="Full Name" required>
            <input type="text" class="form-control" name="qua" placeholder="Qualification" required>
            <input type="email" class="form-control" name="email" placeholder="Email" required>
            <input type="password" class="form-control" name="ps" placeholder="Password" required>
            <button type="submit" class="btn btn-signup">Register</button>
        </form>

        <div class="signup-links">
            <p>Already have an account? <a href="login.jsp">Login</a></p>
        </div>
    </div>

    

    <script>
        setTimeout(function(){
            var msgDiv = document.getElementById("signupMsg");
            if(msgDiv) msgDiv.style.display = "none";
        }, 2000);
    </script>
</body>
</html>
