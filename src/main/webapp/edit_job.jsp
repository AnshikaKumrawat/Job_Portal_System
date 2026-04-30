<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@page import="com.util.DBUtil"%>
<%@page import="com.dao.JobDAO"%>
<%@page import="com.dto.Jobs"%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>Edit Job | JIT JOB PORTAL</title>
<%@ include file="all_component/all_css.jsp"%>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
<style>
body, html { margin: 0; font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; background: #f5f6fa; }
.container { padding-top: 60px; padding-bottom: 60px; }
.card { border-radius: 15px; box-shadow: 0 8px 25px rgba(0,0,0,0.1); padding: 30px; transition: transform 0.2s ease, box-shadow 0.2s ease; }
.card:hover { transform: translateY(-3px); box-shadow: 0 12px 35px rgba(0,0,0,0.15); }
.card-body h5 { font-weight: 700; font-size: 1.8rem; color: #283593; margin-bottom: 25px; }
.card-body i { color: #283593; margin-bottom: 15px; }
.form-control, .custom-select { border-radius: 10px; padding: 10px; font-size: 0.95rem; border: 1px solid #ccc; transition: border 0.2s ease, box-shadow 0.2s ease; }
.form-control:focus, .custom-select:focus { border-color: #283593; box-shadow: 0 0 8px rgba(40, 53, 147, 0.2); }
.btn-success { background-color: #283593; border: none; padding: 10px 25px; border-radius: 50px; font-weight: 600; transition: all 0.2s ease; }
.btn-success:hover { background-color: #3949ab; transform: scale(1.05); }
.btn-back { background-color: #283593; color: #fff; font-weight: 500; border-radius: 50px; padding: 8px 25px; text-decoration: none; transition: all 0.2s ease; }
.btn-back:hover { background-color: #3949ab; transform: scale(1.05); text-decoration: none; color: #fff; }
@media (max-width: 768px) { .form-row { flex-direction: column; } .form-group.col-md-4 { margin-bottom: 15px; } }
</style>
</head>
<body>

<c:if test="${userobj.role ne 'admin'}">
    <c:redirect url="login.jsp" />
</c:if>

<%@ include file="all_component/navbar.jsp"%>

<%
    int id = Integer.parseInt(request.getParameter("id"));
    JobDAO dao = new JobDAO(DBUtil.getConnection());
    Jobs j = dao.getJobById(id);
    request.setAttribute("job", j);
%>

<div class="container">
    <div class="col-md-10 offset-md-1">
        <div class="card">
            <div class="card-body text-center">
                <i class="fas fa-edit fa-3x"></i>
                <h5>Edit Job</h5>

                <form action="update" method="post" class="mt-4 text-start">
                    <input type="hidden" name="id" value="${job.id}">

                    <div class="form-group mb-3">
                        <label>Job Title</label>
                        <input type="text" name="title" required class="form-control" value="${job.title}">
                    </div>

                    <div class="form-group mb-3">
                        <label>Company Name</label>
                        <input type="text" name="company" required class="form-control" value="${job.company}">
                    </div>

                    <div class="form-row">
                        <div class="form-group col-md-4 mb-3">
                            <label>Location</label>
                            <select name="location" class="custom-select">
                                <option value="Odisha" ${job.location == 'Odisha' ? 'selected' : ''}>Odisha</option>
                                <option value="Jharkhand" ${job.location == 'Jharkhand' ? 'selected' : ''}>Jharkhand</option>
                                <option value="Gujarat" ${job.location == 'Gujarat' ? 'selected' : ''}>Gujarat</option>
                                <option value="Bhubaneswar" ${job.location == 'Bhubaneswar' ? 'selected' : ''}>Bhubaneswar</option>
                                <option value="Delhi" ${job.location == 'Delhi' ? 'selected' : ''}>Delhi</option>
                                <option value="Bangalore" ${job.location == 'Bangalore' ? 'selected' : ''}>Bangalore</option>
                                <option value="Chennai" ${job.location == 'Chennai' ? 'selected' : ''}>Chennai</option>
                                <option value="Hyderabad" ${job.location == 'Hyderabad' ? 'selected' : ''}>Hyderabad</option>
                                <option value="Indore" ${job.location == 'Indore' ? 'selected' : ''}>Indore</option>
                                <option value="Mumbai" ${job.location == 'Mumbai' ? 'selected' : ''}>Mumbai</option>
                                <option value="Noida" ${job.location == 'Noida' ? 'selected' : ''}>Noida</option>
                                <option value="Gurgaon" ${job.location == 'Gurgaon' ? 'selected' : ''}>Gurgaon</option>
                                <option value="Pune" ${job.location == 'Pune' ? 'selected' : ''}>Pune</option>
                            </select>
                        </div>

                        <div class="form-group col-md-4 mb-3">
                            <label>Category</label>
                            <select name="category" class="custom-select">
                                <option value="IT" ${job.category == 'IT' ? 'selected' : ''}>IT</option>
                                <option value="Developer" ${job.category == 'Developer' ? 'selected' : ''}>Developer</option>
                                <option value="Banking" ${job.category == 'Banking' ? 'selected' : ''}>Banking</option>
                                <option value="Engineer" ${job.category == 'Engineer' ? 'selected' : ''}>Engineer</option>
                                <option value="Teacher" ${job.category == 'Teacher' ? 'selected' : ''}>Teacher</option>
                            </select>
                        </div>

                        <div class="form-group col-md-4 mb-3">
                            <label>Status</label>
                            <select name="status" class="custom-select">
                                <option value="Active" ${job.status == 'Active' ? 'selected' : ''}>Active</option>
                                <option value="Inactive" ${job.status == 'Inactive' ? 'selected' : ''}>Inactive</option>
                            </select>
                        </div>
                    </div>

                    <div class="form-row">
                        <div class="form-group col-md-6 mb-3">
                            <label>Experience (Years)</label>
                            <input type="number" min="0" name="experience" required class="form-control" value="${job.experience}">
                        </div>
                        <div class="form-group col-md-6 mb-3">
                            <label>Salary (₹)</label>
                            <input type="number" min="0" step="0.01" name="salary" required class="form-control" value="${job.salary}">
                        </div>
                    </div>

                    <div class="form-group mb-3">
                        <label>Description</label>
                        <textarea required rows="6" name="desc" class="form-control">${job.description}</textarea>
                    </div>

                    <div class="text-center mt-3">
                        <button class="btn btn-success">Update Job</button>
                        <a href="view_job.jsp" class="btn btn-back">Back to Jobs</a>
                    </div>

                </form>
            </div>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
