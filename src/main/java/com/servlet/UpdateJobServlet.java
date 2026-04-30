package com.servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

import com.dao.JobDAO;
import com.dto.Jobs;
import com.util.DBUtil;

/**
 * Servlet implementation class UpdateJobServlet
 */
@WebServlet("/update")
public class UpdateJobServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();

        try {
            Jobs j = new Jobs();
            j.setId(Integer.parseInt(request.getParameter("id")));
            j.setTitle(request.getParameter("title"));
            j.setDescription(request.getParameter("desc"));
            j.setCategory(request.getParameter("category"));
            j.setStatus(request.getParameter("status"));
            j.setLocation(request.getParameter("location"));
            j.setCompany(request.getParameter("company"));
            j.setExperience(Integer.parseInt(request.getParameter("experience")));
            j.setSalary(Double.parseDouble(request.getParameter("salary")));

            JobDAO dao = new JobDAO(DBUtil.getConnection());

            if (dao.updateJob(j)) {
                session.setAttribute("succMsg", "Job Updated Successfully");
            } else {
                session.setAttribute("succMsg", "Update Failed");
            }

            response.sendRedirect("view_job.jsp");

        } catch (Exception e) {
            e.printStackTrace();
            session.setAttribute("succMsg", "Invalid Data");
            response.sendRedirect("view_job.jsp");
        }
    }
}

