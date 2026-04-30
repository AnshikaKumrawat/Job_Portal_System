package com.servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.File;
import java.io.IOException;
import java.nio.file.Path;

import com.dao.JobDAO;
import com.util.DBUtil;

@WebServlet("/ApplyJobServlet")
@MultipartConfig(fileSizeThreshold = 1024 * 1024 * 2, // 2MB
		maxFileSize = 1024 * 1024 * 10, // 10MB
		maxRequestSize = 1024 * 1024 * 20 // 20MB
)
public class ApplyJobServlet extends HttpServlet {

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		HttpSession session = request.getSession();

		try {
			int jobId = Integer.parseInt(request.getParameter("jobId").trim());
			String name = request.getParameter("name").trim();
			String email = request.getParameter("email").trim();

			// Get uploaded resume
			Part resumePart = request.getPart("resume");
			String originalFileName = Path.of(resumePart.getSubmittedFileName()).getFileName().toString();

			// Make filename unique to prevent overwrite
			String uniqueFileName = System.currentTimeMillis() + "_" + originalFileName;

			// Save resume in server folder
			String uploadDir = getServletContext().getRealPath("") + File.separator + "resumes";
			File uploadFolder = new File(uploadDir);
			if (!uploadFolder.exists())
				uploadFolder.mkdirs();

			resumePart.write(uploadDir + File.separator + uniqueFileName);

			// Insert into database
			JobDAO dao = new JobDAO(DBUtil.getConnection());
			boolean success = dao.applyJob(jobId, name, email, uniqueFileName);

			if (success) {
				session.setAttribute("msgType", "success");
				session.setAttribute("msgText", "You have successfully applied for the job!");
			} else {
				session.setAttribute("msgType", "error");
				session.setAttribute("msgText", "Failed to apply. Please try again.");
			}

		} catch (Exception e) {
			e.printStackTrace();
			session.setAttribute("msgType", "error");
			session.setAttribute("msgText", "Invalid data or server error.");
		}

		// Redirect to the result page
		response.sendRedirect("apply_result.jsp");
	}
}
