package com.telusko;


import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;




import java.sql.DriverManager;
import java.sql.*;

@Controller
public class AddController 
{
	@RequestMapping("/search")
	public ModelAndView search(HttpServletRequest req, HttpServletResponse res) 
	{
		String source = req.getParameter("source");
		String dest = req.getParameter("destination");
		
		Connection con=null;
		ModelAndView mv = new ModelAndView();
		try {
			Class.forName("com.mysql.jdbc.Driver");
			con=DriverManager.getConnection("jdbc:mysql://localhost:3306/flight","root","root");
			
			PreparedStatement pst = con.prepareStatement("select * from flightinfo where source=? and destination=?");
			pst.setString(1, source);
			pst.setString(2, dest);
			
			ResultSet rs = pst.executeQuery();
			
			mv.setViewName("display.jsp");
			mv.addObject("result",rs);
			
		} 
		
		catch (SQLException e) {
			e.printStackTrace();
		} 
		
		catch (ClassNotFoundException e){
			e.printStackTrace();
		}
		return mv;
		
	}
	
	@RequestMapping("/login")
	public ModelAndView login(HttpServletRequest req, HttpServletResponse res) {
		String username = req.getParameter("username");
		System.out.println(username);
		
		ModelAndView mv = new ModelAndView();
		
		if(username.equals("soham")) {
			mv.addObject("username", username);
			mv.setViewName("index.jsp");
		}
		else {
			mv.setViewName("login.jsp");
		}
		return mv;
	}
}