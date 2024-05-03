package model;

public class DBTest {

	public static void main(String[] args) {
//		BBSDAOImpl dao = new BBSDAOImpl();
//		dao.read(2);
		
//		CommentDAOImpl dao = new CommentDAOImpl();
//		System.out.println("36188번의 댓글수...." + dao.total(36188));
		
		CommentDAOImpl dao = new CommentDAOImpl();
		CommentVO vo = new CommentVO();
		vo.setCid(825);
		vo.setContents("새로운 댓글입니다");
		dao.update(vo);
	}

}
