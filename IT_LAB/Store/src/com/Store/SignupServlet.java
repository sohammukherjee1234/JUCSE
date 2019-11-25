package com.Store;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class SignupServlet extends HttpServlet {
	public void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException{
		String uname = req.getParameter("uname");
		String pass = req.getParameter("pass");
		String email = req.getParameter("email");
		String fname = req.getParameter("fname");
		String lname = req.getParameter("lname");
		String sex = req.getParameter("sex");
		String pref = req.getParameter("pref");
		Connection con=null;
		
		try {
			Class.forName("com.mysql.jdbc.Driver");
			con=DriverManager.getConnection("jdbc:mysql://localhost:3306/store","root","root");
			
			PreparedStatement pst = con.prepareStatement("select uname from users where uname=?");
			pst.setString(1, uname);
			
			ResultSet rs = pst.executeQuery();
			if(rs.next()){
				req.setAttribute("message", "User name exists");
				RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/signup.jsp");
				dispatcher.forward(req, resp);
			}
			else{
				pst = con.prepareStatement("select email from users where email=?");
				pst.setString(1, email);
				rs = pst.executeQuery();
				
				if(rs.next()){
					req.setAttribute("message", "Email exists");
					RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/signup.jsp");
					dispatcher.forward(req, resp);
				}
				else{
					pst = con.prepareStatement("insert into users values('"+uname+"','"+pass+"','"+email+"','"+fname+"','"+lname+"','"+sex+"','"+pref+"')");
					int i = pst.executeUpdate();
					HttpSession sess = req.getSession();
					sess.setAttribute("user",uname);
					resp.sendRedirect("success.jsp");
				}
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
