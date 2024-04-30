package model;

public class TestVO {

	public static void main(String[] args) {
		UserDAO dao = new UserDAO();
		UserVO vo = dao.read("blue");
		System.out.println(vo.toString());

	}

}
