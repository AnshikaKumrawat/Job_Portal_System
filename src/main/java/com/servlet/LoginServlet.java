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

/**
 * Servlet implementation class LoginServlet
 */
@WebServlet("/login")
public class LoginServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public LoginServlet() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
	        throws ServletException, IOException {
	    try {
	        String em = request.getParameter("email").trim();
	        String ps = request.getParameter("password").trim();
	        HttpSession session = request.getSession();

	        // Admin login
	        if ("admin@gmail.com".equals(em) && "admin@121".equals(ps)) {
	            User u = new User();
	            u.setEmail(em);
	            u.setRole("admin");
	            u.setName("Admin");
	            session.setAttribute("userobj", u);
	            response.sendRedirect("admin.jsp");
	        } else {
	            // Regular user login
	            UserDAO dao = new UserDAO(DBUtil.getConnection());
	            User user = dao.login(em, ps);
	            if (user != null) {
	                session.setAttribute("userobj", user);
	                response.sendRedirect("home.jsp");
	            } else {
	                session.setAttribute("succMsg", "Invalid Email & Password");
	                response.sendRedirect("login.jsp");
	            }
	        }
	    } catch (Exception e) {
	        e.printStackTrace();
	    }
	}

}
