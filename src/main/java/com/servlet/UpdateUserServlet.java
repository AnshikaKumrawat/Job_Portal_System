package com.servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

import com.dao.UserDAO;
import com.dto.User;
import com.util.DBUtil;

@WebServlet("/update_profile")
public class UpdateUserServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            int id = Integer.parseInt(request.getParameter("id"));
            String name = request.getParameter("name");
            String email = request.getParameter("email");
            String password = request.getParameter("ps");
            String qualification = request.getParameter("qua");

            User u = new User();
            u.setId(id);
            u.setName(name);
            u.setEmail(email);
            u.setPassword(password);
            u.setQualification(qualification);

            UserDAO dao = new UserDAO(DBUtil.getConnection());
            boolean updated = dao.updateUser(u);

            HttpSession session = request.getSession();
            if (updated) {
                // Fetch correct updated user
                User updatedUser = dao.login(email, password);
                session.setAttribute("userobj", updatedUser); // Correct session user
                session.setAttribute("succMsg", "Profile Updated Successfully!");
                response.sendRedirect("edit_profile.jsp");
            } else {
                session.setAttribute("errorMsg", "Something went wrong. Please try again!");
                response.sendRedirect("edit_profile.jsp");
            }

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("edit_profile.jsp");
        }
    }
}
