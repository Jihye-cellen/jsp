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
//		vo.setKey("lname");
//		vo.setWord("리");
//		vo.setPage(1);
//		vo.setSize(2);
//		dao.list(vo);
		
		//dao.read("N223");
//		System.out.println("N223삭제결과:" + dao.delete("N223"));
//		System.out.println("C411삭제결과:" + dao.delete("C421"));
		
		EnollDAO dao1 = new EnollDAO();
		dao1.slist("C301");
		
	}
}
