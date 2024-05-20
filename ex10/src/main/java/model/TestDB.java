package model;

public class TestDB {

	public static void main(String[] args) {
		//UserDAO dao = new UserDAO();
		//UserVO vo = dao.read("blue");
		//System.out.println(vo.toString());
		
		CartDAO vo = new CartDAO();
		vo.list("red");
	}

}
