package model;
import java.sql.*;
import java.text.SimpleDateFormat;
import java.util.*;


public class CartDAO {
	Connection con = Database.CON;
	SimpleDateFormat sdf =new SimpleDateFormat("yyyy년-MM월-dd일 HH:mm:ss");
	
	//장바구니삭제
	public void delete(CartVO vo) {
		try {
			String sql = "delete from cart where uid=? and gid=? ";
			PreparedStatement ps =con.prepareStatement(sql);
			ps.setString(1, vo.getUid());
			ps.setString(2, vo.getGid());
			ps.execute();
		}catch(Exception e) {
			System.out.println("장바구니삭제:"+ e.toString());
		
		}
	}
	
	
	
	//수량수정
	public void update(CartVO vo) {
		try {
			String sql = "update cart set qnt=? where gid=? and uid=?";
			PreparedStatement ps =con.prepareStatement(sql);
			ps.setInt(1, vo.getQnt());
			ps.setString(3, vo.getUid());
			ps.setString(2, vo.getGid());
			ps.execute();
		}catch(Exception e) {
			System.out.println("수량수정:"+ e.toString());
		
		}
	}
	
	
	//장바구니 목록
	public ArrayList<CartVO> list(String uid){
		ArrayList<CartVO> array = new ArrayList<CartVO>();
		try {
			String sql = "select * from view_cart where uid=?";
			PreparedStatement ps = con.prepareStatement(sql);
			ps.setString(1, uid);
			ResultSet rs = ps.executeQuery();
			while(rs.next()) {
				CartVO vo = new CartVO();
				vo.setGid(rs.getString("gid"));
				vo.setUid(rs.getString("uid"));
				vo.setTitle(rs.getString("title"));
				vo.setPrice(rs.getInt("price"));
				vo.setQnt(rs.getInt("qnt"));
				vo.setImage(rs.getString("image"));
				vo.setRegDate(sdf.format(rs.getTimestamp("rdate")));
				System.out.println(vo.toString());
				array.add(vo);
			}
		}catch(Exception e) {
			System.out.println("장바구니목록:" + e.toString());
		}
		return array;
	}

	//장바구니 넣기
	public boolean insert(CartVO vo) {
		try {
			String sql = "insert into cart(uid, gid, qnt) values(?,?,1)";
			PreparedStatement ps =con.prepareStatement(sql);
			ps.setString(1, vo.getUid());
			ps.setString(2, vo.getGid());
			ps.execute();
			return true;
		}catch(Exception e) {
			System.out.println("장바구니넣기:"+e.toString());
			return false;
		}
	}
	
}
