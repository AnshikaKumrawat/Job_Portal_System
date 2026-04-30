<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ page isELIgnored="false"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Edit Profile</title>
<%@ include file="all_component/all_css.jsp"%>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css"
	rel="stylesheet">
</head>
<body style="background-color: #f5f6fa;">

	<c:if test="${empty userobj}">
		<c:redirect url="login.jsp" />
	</c:if>

	<%@ include file="all_component/navbar.jsp"%>

	<div class="container mt-5 mb-5">
		<div class="row justify-content-center">
			<div class="col-md-5">
				<div class="card shadow-sm">
					<div class="card-body">
						<div class="text-center mb-3">
							<i class="fa fa-user-edit fa-2x text-primary"></i>
							<h4>Edit Profile</h4>
						</div>

						<!-- Success Alert -->
						<c:if test="${not empty succMsg}">
							<div id="successAlert" class="alert alert-success">${succMsg}</div>
							<c:remove var="succMsg" />
						</c:if>

						<!-- Error Alert -->
						<c:if test="${not empty errorMsg}">
							<div class="alert alert-danger">${errorMsg}</div>
							<c:remove var="errorMsg" />
						</c:if>

						<form action="update_profile" method="post">
							<input type="hidden" name="id" value="${userobj.id}">

							<div class="mb-3">
								<label class="form-label">Full Name</label> <input type="text"
									class="form-control" name="name" required
									value="${userobj.name}">
							</div>
							<div class="mb-3">
								<label class="form-label">Email</label> <input type="email"
									class="form-control" name="email" required
									value="${userobj.email}">
							</div>
							<div class="mb-3">
								<label class="form-label">Password</label> <input type="text"
									class="form-control" name="ps" required
									value="${userobj.password}">
							</div>
							<div class="mb-3">
								<label class="form-label">Qualification</label> <input
									type="text" class="form-control" name="qua" required
									value="${userobj.qualification}">
							</div>

							<div class="d-flex justify-content-between">
								<button type="submit" class="btn btn-primary w-50 me-2">Update
									Profile</button>
								<a href="home.jsp" class="btn btn-secondary w-50">Back</a>
							</div>
						</form>

					</div>
				</div>
			</div>
		</div>
	</div>

	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

	<script>
		// Auto-hide success alert after 3 seconds
		setTimeout(function() {
			var alert = document.getElementById('successAlert');
			if (alert) {
				alert.style.display = 'none';
			}
		}, 1000);
	</script>
	
	<%@ include file="all_component/footer.jsp"%>

</body>
</html>
