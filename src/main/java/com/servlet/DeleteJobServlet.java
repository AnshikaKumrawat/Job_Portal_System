package com.servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

import com.util.DBUtil;
import com.dao.JobDAO;
import com.dto.Jobs;
import com.util.DBUtil;
/**
 * Servlet implementation class DeleteJobServlet
 */
@WebServlet("/delete")
public class DeleteJobServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();

        try {
            int id = Integer.parseInt(request.getParameter("id"));
            JobDAO dao = new JobDAO(DBUtil.getConnection());

            if (dao.deleteJob(id)) {
                session.setAttribute("succMsg", "Job Deleted Successfully");
            } else {
                session.setAttribute("succMsg", "Delete Failed");
            }

            response.sendRedirect("view_job.jsp");

        } catch (Exception e) {
            e.printStackTrace();
            session.setAttribute("succMsg", "Invalid Request");
            response.sendRedirect("view_job.jsp");
        }
    }
}
