package model;

import java.util.*;
import java.sql.*;
import java.text.SimpleDateFormat;

public class GoodsDAO {
	Connection con = Database.CON;
	SimpleDateFormat sdf =new SimpleDateFormat("yyyy년-MM월-dd일 HH:mm:ss");
	
	
	//상품정보
	public GoodVO read(String gid) {
		GoodVO vo = new GoodVO();
		try {
			String sql = "select * from goods where gid=?";
			PreparedStatement ps = con.prepareStatement(sql);
			ps.setString(1, gid);
			ResultSet rs=ps.executeQuery();
			while(rs.next()) {
				vo.setGid(rs.getString("gid"));
				vo.setTitle(rs.getString("title"));
				vo.setImage(rs.getString("image"));
				vo.setPrice(rs.getInt("price"));
				vo.setBrand(rs.getString("brand"));
				vo.setRegDate(sdf.format(rs.getTimestamp("regDate")));
				
			}
		}catch(Exception e) {
			System.out.println("상품읽기:"+ e.toString());
		}
		return vo;
	}
	
	//검색수
		public int total(String word){
			int total=0;
			try {
				String sql = "select count(*) from goods where title like ? ";
				PreparedStatement ps = con.prepareStatement(sql);
				ps.setString(1, "%" + word + "%");
				ResultSet rs = ps.executeQuery();
				if(rs.next()) {
					total=rs.getInt("count(*)");
				}
			}catch(Exception e) {
				System.out.println("검색수:"+ e.toString());
			}
			
			return total;
		}
	
	
	//상품삭제
	public boolean delete(String gid) {
		try {
			String sql = "delete from goods where gid=?";
			PreparedStatement ps = con.prepareStatement(sql);			
			ps.setString(1, gid);
			ps.execute();
			return true;
		}catch(Exception e) {
			System.out.println("상품삭제:" + e.toString());
			return false;
		}
	}
	//상품목록
	public ArrayList<GoodVO> list(QueryVO query){
		ArrayList<GoodVO> array = new ArrayList<GoodVO>();
		try {
			String sql = "select * from goods where title like ? order by regDate desc limit ?, ?";
			PreparedStatement ps = con.prepareStatement(sql);
			ps.setString(1, "%" +query.getWord() + "%");
			ps.setInt(2, (query.getPage()-1) * query.getSize());
			ps.setInt(3, query.getSize());
			ResultSet rs=ps.executeQuery();
			while(rs.next()) {
				GoodVO vo = new GoodVO();
				vo.setGid(rs.getString("gid"));
				vo.setTitle(rs.getString("title"));
				vo.setImage(rs.getString("image"));
				vo.setPrice(rs.getInt("price"));
				vo.setBrand(rs.getString("brand"));
				vo.setRegDate(sdf.format(rs.getTimestamp("regDate")));
				array.add(vo);
			}
		}catch(Exception e) {
			System.out.println("상품목록:"+ e.toString());
		}
		return array;
	}
	
	//상품등록
	public boolean insert(GoodVO vo) {
		try {
			String sql = "insert into goods(gid, title, price, brand, image) values(?,?,?,?,?)";
			PreparedStatement ps = con.prepareStatement(sql);			
			ps.setString(1,  vo.getGid());
			ps.setString(2,  vo.getTitle());
			ps.setInt(3,  vo.getPrice());
			ps.setString(4,  vo.getBrand());
			ps.setString(5,  vo.getImage());
			ps.execute();
			return true;
		}catch(Exception e) {
			System.out.println("상품등록:" + e.toString());
			return false;
		}
	}
}
