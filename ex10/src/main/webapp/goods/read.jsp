<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<div>
	<div class="row my-5">
		<div class="col">
			<img src="${goods.image}" width="90%">
		</div>
		<div class="col">
			<h3>${goods.title}</h3>
			<hr>
			<div class="mb-3">가격: <fmt:formatNumber value="${goods.price}" pattern="#,###원"/></div>
			<div class="mb-3">브랜드: ${goods.brand}</div>
			<div class="mb-3">등록일: ${goods.regDate}</div>
			<div class="mb-3">배송정보: 한진택배</div>
			<div class="mb-3">카드할인: 하나카드 무이자 최대 2개월</div>
			<div class="my-5 text-center">
				<button class="px-5 btn btn-warning">바로구매</button>
				<button class="px-5 btn btn-success" id="cart">장바구니</button>
			</div>
		</div>
	</div>
</div>

<script>
	//menu.jsp에서 이미 session에 uid가 저장되어 있음 그러므로 또 넣어주면 오류가 나올 수 있다. 
	const gid="${goods.gid}";
	
	$("#cart").on("click", function(){
		if(uid){
			//장바구니 넣기
			$.ajax({
				type:"post",
				url:"/cart/insert",
				data:{uid, gid},
				success:function(data){
					if(data=="true"){
						alert("장바구니에 넣었습니다.");
							
					}else{
						alert("장바구니에 있는 상품입니다!")
					}
				}
			});
		}else{
			alert("로그인이 필요한 작업입니다.");
			sessionStorage.setItem("target", "/goods/read?gid=" + gid); //로그인을 안한 상태에서의 주소를 저장하고, 로그인을 한 후, getItem을 이용해 다시 그 주소를 꺼낸다.
			location.href="/user/login";
		}
	});

</script>