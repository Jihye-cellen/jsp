package model2;

import java.sql.*;

public class TestDB {
	public static void main(String[] args) {
//		ProDAOImpl dao = new ProDAOImpl();
//		QueryVO vo = new QueryVO();
//		vo.setPage(1);
//		vo.setSize(2);
//		vo.setKey("dept");
//		vo.setWord("건축");
		//dao.list(vo);
		//System.out.println("검색수:" + dao.total(vo));
		//System.out.println("새로운 코드" + dao.getCode());
		
		CouDAOImpl dao = new CouDAOImpl();
		QueryVO vo = new QueryVO();
		vo.setKey("lname");
		vo.setWord("리");
		vo.setPage(1);
		vo.setSize(2);
		dao.list(vo);
		
		
		
	}
}
