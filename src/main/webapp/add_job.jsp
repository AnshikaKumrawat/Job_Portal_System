<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ page isELIgnored="false"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Add Job | JIT JOB PORTAL</title>

<%@ include file="all_component/all_css.jsp"%>

<style>
body {
    background-color: #f4f6f9;
    font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
}

.card {
    border: none;
    border-radius: 12px;
    box-shadow: 0 6px 20px rgba(0, 0, 0, 0.1);
}

.card-body {
    padding: 40px;
}

.custom-blue {
    color: #283593;
    font-weight: 700;
}

.form-control:focus, .custom-select:focus {
    border-color: #283593;
    box-shadow: 0 0 0 0.2rem rgba(40, 53, 147, 0.25);
}

.btn-custom-blue {
    background-color: #283593;
    color: white;
    border-radius: 30px;
    padding: 10px 25px;
    font-weight: 600;
    transition: 0.3s ease;
}

.btn-custom-blue:hover {
    background-color: #1a237e;
    transform: scale(1.05);
}

.alert-custom-blue {
    background-color: #283593;
    color: white;
    border-radius: 8px;
}

label {
    font-weight: 500;
    color: #283593;
}

.back-text {
    text-decoration: none;
    color: #283593;
    font-weight: 500;
}

.back-text:hover {
    color: #3949ab;
}

.back-text i {
    margin-right: 6px;
}
</style>
</head>

<body>

<!-- Admin check -->
<c:if test="${userobj.role ne 'admin'}">
    <c:redirect url="login.jsp"></c:redirect>
</c:if>

<!-- Navbar -->
<%@ include file="all_component/navbar.jsp"%>

<div class="container py-5">
    <div class="col-md-10 offset-md-1">

        <div class="mb-3">
            <a href="admin.jsp" class="back-text">
                <i class="fas fa-arrow-left"></i> Go Back
            </a>
        </div>

        <div class="card">
            <div class="card-body">

                <div class="text-center mb-4">
                    <i class="fas fa-briefcase fa-3x custom-blue mb-3"></i>
                    <h3 class="custom-blue">Post a New Job</h3>
                </div>

                <!-- Success message -->
                <c:if test="${not empty succMsg}">
                    <div id="alert-msg"
                        class="alert alert-custom-blue text-center">
                        ${succMsg}
                    </div>
                    <c:remove var="succMsg"/>
                </c:if>

                <!-- Add Job Form -->
                <form action="addJob" method="post">

    <div class="form-group">
        <label>Job Title</label>
        <input type="text" name="title" class="form-control"
               placeholder="e.g. Java Developer" required>
    </div>

    <div class="form-row">
        <div class="form-group col-md-4">
            <label>Location</label>
            <select name="location" class="custom-select" required>
                <option value="" disabled selected>Choose...</option>
                <option>Delhi</option>
                <option>Mumbai</option>
                <option>Bangalore</option>
                <option>Indore</option>
                <option>Pune</option>
                <option>Bhopal</option>
                <option>Hyderabad</option>
                <option>Gurugram</option>
                <option>Noida</option>
                <option>Ahmedabad</option>
                <option>Remote</option>
                <option>College Campus</option>
                <option>Other</option>
            </select>
        </div>

        <div class="form-group col-md-4">
            <label>Category</label>
            <select name="category" class="custom-select" required>
                <option value="" disabled selected>Choose...</option>
                <option>Teaching</option>
                 <option>Support Staff</option>
                  <option>Administrative</option>
                   <option>Laboratory</option>
                    <option>Library</option>
                    <option>IT</option>
                     <option>Core Engineering</option>
                <option>Business / Management</option>
                <option>Design</option>
                <option>Internship</option>
            </select>
        </div>

        <div class="form-group col-md-4">
            <label>Status</label>
            <select name="status" class="form-control" required>
                <option value="Active">Active</option>
                <option value="Inactive">Inactive</option>
            </select>
        </div>
    </div>

    <div class="form-row">
        <div class="form-group col-md-6">
            <label>Company Name</label>
            <input type="text" name="company" class="form-control" placeholder="e.g. Infosys" required>
        </div>

        <div class="form-group col-md-3">
            <label>Experience (Years)</label>
            <input type="number" name="experience" class="form-control" required>
        </div>

        <div class="form-group col-md-3">
            <label>Salary (₹)</label>
            <input type="number" name="salary" class="form-control" required>
        </div>
    </div>

    <div class="form-group">
        <label>Description</label>
        <textarea name="desc" rows="5" class="form-control" placeholder="Job description..." required></textarea>
    </div>

    <div class="form-row">
        <div class="form-group col-md-6">
            <label>Job Type</label>
            <select name="job_type" class="custom-select" required>
                <option value="" disabled selected>Choose...</option>
                <option value="internal">Internal</option>
                <option value="external">External</option>
            </select>
        </div>

        <div class="form-group col-md-6">
            <label>External Apply Link (for External Jobs only)</label>
            <input type="url" name="apply_link" class="form-control"
                   placeholder="https://example.com/apply">
        </div>
    </div>

    <div class="text-center mt-3">
        <button class="btn btn-custom-blue">Publish Job</button>
    </div>
</form>

            </div>
        </div>
    </div>
</div>

<script>
window.onload = function () {
    let alertBox = document.getElementById("alert-msg");
    if (alertBox) {
        setTimeout(() => alertBox.style.display = "none", 2500);
    }
}
</script>

</body>
</html>
