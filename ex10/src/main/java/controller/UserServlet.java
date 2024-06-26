package controller;

import java.io.*;

import model.*;


import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


@WebServlet(value={"/user/login"})
public class UserServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
     UserDAO dao = new UserDAO();  
    
  
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		RequestDispatcher dis = request.getRequestDispatcher("/home.jsp");
		switch(request.getServletPath()) {
		case "/user/login":
			request.setAttribute("pageName", "/user/login.jsp");
			dis.forward(request, response);
			break;
		}
	}


	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		PrintWriter out = response.getWriter();
		switch(request.getServletPath()) {
		case "/user/login":
			String uid = request.getParameter("uid");
			String upass=request.getParameter("upass");
			UserVO vo = dao.read(uid);
			int result=0; //아이디가 없는 경우
			if(vo.getUid()!=null) {
				result=1; //로그인 성공
			}else {
				result=2; //비밀번호가 불일치하는 경우
			}
			out.print(result);
		 break;
		}
	
	}

}
