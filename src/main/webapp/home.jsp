<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.util.DBUtil"%>
<%@ page import="com.dao.JobDAO"%>
<%@ page import="com.dto.Jobs"%>
<%@ page import="java.util.List"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page isELIgnored="false"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>Jobs | JIT JOB PORTAL</title>
<%@ include file="all_component/all_css.jsp"%>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">

<style>
/* Body & General */
body { 
    background-color: #f5f6fa; 
    font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
}
h2.text-primary { font-weight: 700; margin-bottom: 30px; text-align:center; }

/* Card Styling */
.card-job { 
    border: none; 
    border-radius: 12px; 
    background-color: #fff; 
    box-shadow: 0 4px 15px rgba(0,0,0,0.08); 
    transition: transform 0.3s ease, box-shadow 0.3s ease; 
    padding: 25px; 
    margin-bottom: 25px; 
}
.card-job:hover { 
    transform: translateY(-8px); 
    box-shadow: 0 15px 30px rgba(0,0,0,0.15); 
}
.card-job .card-title { 
    font-weight: 700; 
    font-size: 1.4rem; 
    color: #1a237e; 
}

/* Job Meta */
.job-meta { 
    font-size: 0.95rem; 
    color: #555; 
    margin-bottom: 8px; 
}
.job-meta i { color: #1a237e; margin-right: 5px; }

/* Badges */
.badge-category { 
    background-color: #283593; 
    color: #fff; 
    font-size: 0.75rem; 
    padding: 5px 12px; 
    border-radius: 15px; 
    margin-right: 5px; 
}
.badge-status { 
    background-color: #43a047; 
    color: #fff; 
    font-size: 0.75rem; 
    padding: 5px 12px; 
    border-radius: 15px; 
    margin-right: 5px; 
}
.badge-date { 
    background-color: #f57c00; 
    color: #fff; 
    font-size: 0.7rem; 
    padding: 3px 10px; 
    border-radius: 15px; 
}

/* Buttons */
.btn-view, .btn-apply { 
    border-radius: 50px; 
    font-weight: 600; 
    padding: 8px 20px; 
    transition: transform 0.2s ease, background-color 0.2s ease, box-shadow 0.2s ease; 
    font-size: 0.9rem;
}
.btn-view { border: 1px solid #3949ab; color: #3949ab; }
.btn-apply { border: 1px solid #2e7d32; color: #fff; background-color: #2e7d32; }
.btn-view:hover { 
    background-color: #3949ab; 
    color: #fff; 
    transform: scale(1.05); 
    box-shadow: 0 5px 15px rgba(57,73,171,0.3);
}
.btn-apply:hover { 
    background-color: #1b5e20; 
    color: #fff; 
    transform: scale(1.05); 
    box-shadow: 0 5px 15px rgba(46,125,50,0.3);
}

/* Search / Filter Form */
.input-group .form-control {
    border-radius: 50px;
    height: 45px;
    font-size: 0.95rem;
}
.input-group-text {
    border-radius: 50px 0 0 50px;
    background-color: #3949ab;
    color: #fff;
    border: none;
}
button.btn-primary {
    border-radius: 50px;
    font-weight: 600;
    font-size: 0.95rem;
}

/* Info / No jobs */
.no-jobs { margin-top: 50px; font-size: 1.3rem; color: #d32f2f; text-align: center; }
.filter-info { margin-bottom: 20px; font-size: 0.95rem; color: #333; font-weight: 500; }

/* Responsive */
@media (max-width: 768px) {
    .card-job { padding: 20px; }
    .btn-view, .btn-apply { font-size: 0.85rem; padding: 6px 16px; }
}
@media (max-width: 576px) {
    .card-job { padding: 15px; }
    .btn-view, .btn-apply { font-size: 0.8rem; padding: 5px 12px; }
    .input-group .form-control { font-size: 0.85rem; height: 40px; }
}
</style>
</head>
<body>

<%@ include file="all_component/navbar.jsp"%>

<div class="container mt-4">
    <h2 class="text-primary">Available Jobs</h2>
    
    

    <!-- Search / Filter Form -->
    <form method="get" class="row g-2 mb-4">
        <div class="col-md-4">
            <div class="input-group">
                <span class="input-group-text"><i class="fas fa-search"></i></span>
                <input type="text" name="title" class="form-control" placeholder="Job Title"
                       value="<%= request.getParameter("title") != null ? request.getParameter("title") : "" %>">
            </div>
        </div>
        <div class="col-md-4">
            <div class="input-group">
                <span class="input-group-text"><i class="fas fa-briefcase"></i></span>
                <input type="text" name="cat" class="form-control" placeholder="Role / Category"
                       value="<%= request.getParameter("cat") != null ? request.getParameter("cat") : "" %>">
            </div>
        </div>
        <div class="col-md-4">
            <div class="input-group">
                <span class="input-group-text"><i class="fas fa-map-marker-alt"></i></span>
                <input type="text" name="loc" class="form-control" placeholder="Location"
                       value="<%= request.getParameter("loc") != null ? request.getParameter("loc") : "" %>">
            </div>
        </div>
        <div class="col-md-2 mt-2">
            <button type="submit" class="btn btn-primary w-100"><i class="fas fa-search me-1"></i> Search</button>
        </div>
    </form>

<%
    String title = request.getParameter("title");
    String cat = request.getParameter("cat");
    String loc = request.getParameter("loc");

    if(title != null) title = title.trim();
    if(cat != null) cat = cat.trim();
    if(loc != null) loc = loc.trim();

    JobDAO dao = new JobDAO(DBUtil.getConnection());
    List<Jobs> list = dao.searchJobs(title, cat, loc);

    if ((title != null && !title.isEmpty()) || (cat != null && !cat.isEmpty()) || (loc != null && !loc.isEmpty())) {
%>
    <div class="filter-info">
        Showing jobs
        <%
            if(title != null && !title.isEmpty()) { %> with title "<%= title %>" <% }
            if(cat != null && !cat.isEmpty()) { %> in category "<%= cat %>" <% }
            if(loc != null && !loc.isEmpty()) { %> at location "<%= loc %>" <% }
        %>
    </div>
<%
    }

    if(list == null || list.isEmpty()) {
%>
    <div class="no-jobs">No jobs available</div>
<%
    } else {
        SimpleDateFormat sdf = new SimpleDateFormat("dd MMM yyyy");
        for(Jobs j : list) {
%>
    <div class="card card-job shadow-sm">
        <div class="card-body">
            <h5 class="card-title"><i class="fas fa-briefcase me-2"></i><%= j.getTitle() %></h5>
            <p class="job-meta">
                <i class="fas fa-building me-1"></i><strong><%= j.getCompany() %></strong> |
                <i class="fas fa-map-marker-alt me-1"></i><%= j.getLocation() %>
            </p>
            <p class="job-meta">
                <i class="fas fa-hourglass-half me-1"></i>Experience: <%= j.getExperience() %> Years |
                <i class="fas fa-money-bill-wave me-1"></i>Salary: ₹ <%= j.getSalary() %>
            </p>
            <span class="badge-category"><%= j.getCategory() %></span>
            <span class="badge-status"><%= j.getStatus() %></span>
            <span class="badge-date">Posted on: <%= sdf.format(j.getPdate()) %></span>
            <div class="mt-3">
    <a href="one_view.jsp?id=<%= j.getId() %>" class="btn btn-outline-primary btn-sm btn-view me-2">
        <i class="fas fa-eye me-1"></i>View Details
    </a>
    <% if(j.getLink() != null && !j.getLink().trim().isEmpty()) { %>
        <!-- External Job -->
        <a href="<%= j.getLink() %>" target="_blank" class="btn btn-success btn-sm btn-apply">
            <i class="fas fa-paper-plane me-1"></i>Apply
        </a>
    <% } else { %>
        <!-- Internal Job -->
        <a href="apply_job.jsp?jobId=<%= j.getId() %>" class="btn btn-success btn-sm btn-apply">
            <i class="fas fa-paper-plane me-1"></i>Apply
        </a>
    <% } %>
</div>
        </div>
    </div>
<%
        }
    }
%>
</div>

<%@ include file="all_component/footer.jsp"%>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>