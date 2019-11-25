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

public class LoginServlet extends HttpServlet {
	public void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException{
		String uname = req.getParameter("uname");
		String pass = req.getParameter("pass");
		Connection con=null;
		
		try {
			Class.forName("com.mysql.jdbc.Driver");
			con=DriverManager.getConnection("jdbc:mysql://localhost:3306/store","root","root");
			
			PreparedStatement pst = con.prepareStatement("select uname, pswd from users where uname=? and pswd=?");
			pst.setString(1, uname);
			pst.setString(2, pass);
			
			ResultSet rs = pst.executeQuery();
			if(rs.next()){
				HttpSession sess = req.getSession();
				sess.setAttribute("user",uname);
				resp.sendRedirect("success.jsp");
			}
			else{
				req.setAttribute("message", "Invalid User");
				RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/index.jsp");
				dispatcher.forward(req, resp);
			}
		} 
		
		catch (SQLException e) {
			e.printStackTrace();
		} 
		
		catch (ClassNotFoundException e){
			e.printStackTrace();
		}
	}
}
