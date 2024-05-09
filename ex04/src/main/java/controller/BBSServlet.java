package controller;

import java.io.*;


import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;

import model.*;

@WebServlet(value={"/bbs/list","/bbs/list.json", "/bbs/insert", "/bbs/read", "/bbs/delete", "/bbs/update", "/bbs/total"})

public class BBSServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       BBSDAOImpl dao =new BBSDAOImpl();
   
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("text/html;charset=UTF-8");
		PrintWriter out = response.getWriter(); 
		RequestDispatcher dis=request.getRequestDispatcher("/home.jsp");
		switch(request.getServletPath()) {
		
		case "/bbs/list":
			request.setAttribute("pageName", "/bbs/list.jsp");
			dis.forward(request, response);
			break;
		case "/bbs/list.json":
			int page = request.getParameter("page")!=null ? Integer.parseInt(request.getParameter("page")) : 1;
			int size = request.getParameter("size")!=null ? Integer.parseInt(request.getParameter("size")) : 10;
			String query = request.getParameter("query")!=null ? request.getParameter("query") : "";
			Gson gson = new Gson();
			out.print(gson.toJson(dao.list(page, size, query)));
			break;
		case "/bbs/read":
			String bid=request.getParameter("bid");
			BBSVO vo = dao.read(Integer.parseInt(bid));
			request.setAttribute("bbs", vo);
			request.setAttribute("pageName", "/bbs/read.jsp");
			dis.forward(request, response);
			break;
		case "/bbs/insert":
			request.setAttribute("pageName", "/bbs/insert.jsp");
			dis.forward(request, response);
			break;
		case "/bbs/update":
			String title= request.getParameter("title");
			String contents=request.getParameter("contents");
			bid = request.getParameter("bid");
			BBSVO bbs =dao.read(Integer.parseInt(bid));
			request.setAttribute("bbs", bbs);
			request.setAttribute("pageName", "/bbs/update.jsp");
			dis.forward(request, response);
			break;
			
		case "/bbs/total":
			String query1=request.getParameter("query")==null ?
					"":request.getParameter("query");
			out.print(dao.total(query1));
			break;
		}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		switch(request.getServletPath()) {
		
		case "/bbs/insert":
			BBSVO vo = new BBSVO();
			vo.setWriter(request.getParameter("write"));
			vo.setTitle(request.getParameter("title"));
			vo.setContents(request.getParameter("contents"));
			//System.out.println(vo.toString());
			dao.insert(vo);
			response.sendRedirect("/bbs/list");
			break;
			
		case "/bbs/delete":
			String bid=request.getParameter("bid");
			dao.delete(Integer.parseInt(bid));
			break;
			
		case "/bbs/update":
			vo=new BBSVO();
			vo.setBid(Integer.parseInt(request.getParameter("bid")));
			vo.setTitle(request.getParameter("title"));
			vo.setContents(request.getParameter("contents"));
			//System.out.println(vo.toString());
			dao.update(vo);
			response.sendRedirect("/bbs/list");
			break;
			
			
		}
	}

}
