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

public class ForgotServlet extends HttpServlet {
	public void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException{
		String uname = req.getParameter("uname");
		String pass = req.getParameter("pass");
		Connection con=null;
		
		try {
			Class.forName("com.mysql.jdbc.Driver");
			con=DriverManager.getConnection("jdbc:mysql://localhost:3306/store","root","root");
			
			PreparedStatement pst = con.prepareStatement("update users set pswd=? where uname=?");
			pst.setString(1, pass);
			pst.setString(2, uname);
			
			int rs = pst.executeUpdate();	
			if(rs>0){
				req.setAttribute("message", "Password successfully updated!!");
				RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/index.jsp");
				dispatcher.forward(req, resp);
			}
			else{
				req.setAttribute("message", "Invalid User!!");
				RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/forgot_password.jsp");
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
