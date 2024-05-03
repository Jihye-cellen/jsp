package model;

import java.util.*;

public interface BBSDAO {
	//목록
	public ArrayList<BBSVO> list();
	//입력
	public void insert(BBSVO vo);
	//읽기
	public BBSVO read(int bid);
	//수정
	public void update(BBSVO vo);
	//삭제
	public void delete(int bid);
	//페이징목록
	public ArrayList<BBSVO> list(int page, int size, String query);
} 
