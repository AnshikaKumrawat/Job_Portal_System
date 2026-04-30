<%@ page import="com.dao.JobDAO"%>
<%@ page import="com.dto.JobApplication"%>
<%@ page import="com.util.DBUtil"%>
<%@ page import="java.util.List"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page isELIgnored="false"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>Admin | Job Applications</title>

<%@ include file="all_component/all_css.jsp"%>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css"
	rel="stylesheet">

<style>
body {
	background: #f5f6fa;
	font-family: 'Segoe UI', Tahoma;
}

.back-dashboard-btn{
    background: linear-gradient(135deg, #283593, #5c6bc0);
    color: #fff;
    padding: 10px 24px;
    border-radius: 50px;
    font-weight: 600;
    box-shadow: 0 6px 18px rgba(40,53,147,0.4);
    transition: all 0.3s ease;
}

.back-dashboard-btn:hover{
    background: linear-gradient(135deg, #1a237e, #3949ab);
    transform: translateY(-2px);
    box-shadow: 0 10px 25px rgba(40,53,147,0.6);
    color: #fff;
}


.container {
	margin-top: 50px;
}

h2 {
	text-align: center;
	color: #283593;
	margin-bottom: 30px;
}

.table thead {
	background: #283593;
	color: #fff;
}

.table tbody tr:hover {
	background: #e8f0fe;
}

.btn-download {
	background: #3949ab;
	color: white;
	padding: 6px 15px;
	border-radius: 30px;
	text-decoration: none;
}

.btn-download:hover {
	background: #283593;
	color:white;
}

.back-btn {
	background: #283593;
	color: white;
	padding: 8px 20px;
	border-radius: 30px;
	text-decoration: none;
}

.back-btn:hover {
	background: #3949ab;
}
</style>
</head>

<body>

	<%@ include file="all_component/navbar.jsp"%>

	<%
	// ✅ FETCH DATA
	JobDAO dao = new JobDAO(DBUtil.getConnection());
	List<JobApplication> apps = dao.getAllApplications();

	// ⭐⭐ MOST IMPORTANT LINE ⭐⭐
	request.setAttribute("apps", apps);

	SimpleDateFormat sdf = new SimpleDateFormat("dd-MM-yyyy HH:mm");
	%>

	<div class="container">

		<div class="mb-4">
			<a href="admin.jsp" class="btn back-dashboard-btn"> <i
				class="fas fa-arrow-left me-2"></i> Back to Dashboard
			</a>
		</div>


		<h2>All Job Applications</h2>

		<!-- ✅ IF DATA EXISTS -->
		<c:if test="${not empty apps}">
			<div class="table-responsive">
				<table class="table table-bordered table-hover">
					<thead>
						<tr>
							<th>ID</th>
							<th>User Name</th>
							<th>Email</th>
							<th>Job Title</th>
							<th>Company</th>
							<th>Applied On</th>
							<th>Resume</th>
						</tr>
					</thead>
					<tbody>
						<%
						for (JobApplication app : apps) {
						%>
						<tr>
							<td><%=app.getId()%></td>
							<td><%=app.getUserName()%></td>
							<td><%=app.getEmail()%></td>
							<td><%=app.getJobTitle()%></td>
							<td><%=app.getCompany()%></td>
							<td><%=sdf.format(app.getAppliedOn())%></td>
							<td><a class="btn-download"
								href="resumes/<%=app.getResume()%>" target="_blank">Download</a>
							</td>
						</tr>
						<%
						}
						%>
					</tbody>
				</table>
			</div>
		</c:if>

		<!-- ❌ IF NO DATA -->
		<c:if test="${empty apps}">
			<h5 class="text-center text-danger mt-5">No job applications
				found!</h5>
		</c:if>

	</div>

</body>
</html>
