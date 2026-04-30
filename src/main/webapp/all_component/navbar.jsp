<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ page isELIgnored="false"%>
<%@page import="com.dto.User"%>


<nav class="navbar navbar-expand-lg navbar-dark shadow-sm sticky-top" style="background-color: #283593;">
    <button class="navbar-toggler" type="button" data-toggle="collapse"
        data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent"
        aria-expanded="false" aria-label="Toggle navigation">
        <span class="navbar-toggler-icon"></span>
    </button>

    <div class="collapse navbar-collapse" id="navbarSupportedContent">

        <!-- Left side -->
        <ul class="navbar-nav mr-auto">
            <li class="nav-item active">
                <a class="nav-link font-weight-bold" href="index.jsp">
                    Home <span class="sr-only">(current)</span>
                </a>
            </li>
        </ul>

        <!-- Right side -->
        <ul class="navbar-nav ml-auto">
            <!-- Admin -->
            <c:if test="${not empty sessionScope.userobj and sessionScope.userobj.role eq 'admin'}">
                <li class="nav-item">
                    <a href="#" class="btn btn-light mr-2 rounded-pill px-3" style="color:#283593;"
                       data-toggle="modal" data-target="#exampleModal">
                        <i class="fa-regular fa-user"></i> Admin
                    </a>
                </li>
                <li class="nav-item">
                    <a href="logout" class="btn btn-light rounded-pill px-3" style="color:#283593;">
                        <i class="fa-solid fa-arrow-right-to-bracket"></i> LogOut
                    </a>
                </li>
            </c:if>

            <!-- User -->
            <c:if test="${not empty sessionScope.userobj and sessionScope.userobj.role eq 'user'}">
                <li class="nav-item dropdown">
                    <a href="#" class="btn btn-light mr-2 rounded-pill px-3 dropdown-toggle" id="userDropdown"
                       data-toggle="dropdown" aria-haspopup="true" aria-expanded="false" style="color:#283593;">
                        <i class="fa-regular fa-user"></i> ${sessionScope.userobj.name}
                    </a>
                    <div class="dropdown-menu dropdown-menu-right" aria-labelledby="userDropdown">
                        <a class="dropdown-item" href="edit_profile.jsp">Edit Profile</a>
                        <a class="dropdown-item" href="logout">Logout</a>
                    </div>
                </li>
            </c:if>

            <!-- Guest -->
            <c:if test="${empty sessionScope.userobj}">
                <li class="nav-item">
                    <a href="login.jsp" class="btn btn-light mr-2 rounded-pill px-3" style="color:#283593;">Login</a>
                </li>
                <li class="nav-item">
                    <a href="signup.jsp" class="btn btn-light rounded-pill px-3" style="color:#283593;">Sign Up</a>
                </li>
            </c:if>
        </ul>
    </div>
</nav>

<style>
    .navbar-nav .nav-link:hover {
        background: rgba(255,255,255,0.1);
        border-radius: 20px;
        transition: 0.3s;
    }
</style>
