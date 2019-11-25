package com.Store;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import java.io.IOException;
import java.sql.DriverManager;
import java.sql.*;

public class SearchServlet extends HttpServlet {
	public void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException{
		String searchText = req.getParameter("find");
		req.getSession().setAttribute("search",searchText);
		RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/success.jsp");
		dispatcher.forward(req, resp);
	}
}
