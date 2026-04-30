package com.servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

import com.util.DBUtil;
import com.dao.UserDAO;
import com.dto.User;
/**
 * Servlet implementation class RegisterServlet
 */
@WebServlet("/add_user")
public class RegisterServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public RegisterServlet() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		try {
			String name  = request.getParameter("name");
			String qua  = request.getParameter("qua");
			String email  = request.getParameter("email");
			String ps  = request.getParameter("ps");
			UserDAO dao = new UserDAO(DBUtil.getConnection());
			User u =new User(name, email, ps, qua, "User");
			boolean f = dao.register(u);
			HttpSession session = request.getSession();
			if(f) {
				session.setAttribute("succMsg", "Registration Successfully");
				response.sendRedirect("signup.jsp");
			}
			else {
				session.setAttribute("succMsg", "Something Wrong on Server");
				response.sendRedirect("signup.jsp");
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

}
