package model2;

import java.util.*;

public interface CouDAO {
	//강좌목록
	public ArrayList<CouVO> list(QueryVO vo);
	
	//검색수 출력
	public int total(QueryVO vo);
	
	//새로운 강좌코드가져오기
	public String getCode();
	
	//강좌등록
	public void insert(CouVO vo);
}
