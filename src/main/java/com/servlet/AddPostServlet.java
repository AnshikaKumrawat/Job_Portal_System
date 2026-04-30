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
 * Servlet implementation class AddPostServlet
 */
@WebServlet("/addJob")

public class AddPostServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();

        try {
            Jobs j = new Jobs();
            j.setTitle(request.getParameter("title"));
            j.setDescription(request.getParameter("desc"));
            j.setCategory(request.getParameter("category"));
            j.setStatus(request.getParameter("status"));
            j.setLocation(request.getParameter("location"));
            j.setCompany(request.getParameter("company"));
            j.setExperience(Integer.parseInt(request.getParameter("experience")));
            j.setSalary(Double.parseDouble(request.getParameter("salary")));
            j.setLink(request.getParameter("link"));
            

            JobDAO dao = new JobDAO(DBUtil.getConnection());

            if (dao.addJobs(j)) {
                session.setAttribute("succMsg", "Job Posted Successfully");
            } else {
                session.setAttribute("succMsg", "Something went wrong");
            }

            response.sendRedirect("add_job.jsp");

        } catch (Exception e) {
            e.printStackTrace();
            session.setAttribute("succMsg", "Invalid data");
            response.sendRedirect("add_job.jsp");
        }
    }
}
