<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<style>
	.bi-heart, .bi-heart-fill{
		color:red;
	}
</style>
<div>
	<div class="row my-5">
		<div class="col">
			<img src="${goods.image}" width="90%">
		</div>
		<div class="col">
			<h3>${goods.title}</h3>
			<span class="bi bi-heart-fill" id="heart" gid="${goods.gid}" style="cursor:pointer"></span>
			<span id="fcnt" style="font-size:15px"></span>
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
	//param으로 주소에 있는 value를 가져올 수 있다.
	const gid="${goods.gid}";
	const ucnt="${goods.ucnt}";
	const fcnt="${goods.fcnt}";
	$("#fcnt").html(fcnt);
	
	if(ucnt=="0"){
		$("#heart").removeClass("bi-heart-fill");
		$("#heart").addClass("bi-heart");
	}else{
		$("#heart").removeClass("bi-heart");
		$("#heart").addClass("bi-heart-fill");
	}
	
	//빈하트 클릭한 경우
	$(".bi-heart").on("click", function(){
		const gid=$(this).attr("gid");
		if(uid){
			$.ajax({
				type:"post",
				url:"/favorite/insert",
				data:{uid, gid},
				success:function(){
					alert("좋아요! 등록")
					location.reload(true); //refresh
				}
			});
		}else{
			const target = window.location.href; //돌아올 주소
			sessionStorage.setItem("target", target);
			location.href="/user/login";
		}
	});
	
	
	//채워진 하트를 클릭한 경우
	$(".bi-heart-fill").on("click", function(){
		const gid=$(this).attr("gid");
		$.ajax({
			type:"post",
			url:"/favorite/delete",
			data:{uid, gid},
			success:function(){
				alert("좋아요! 취소");
				location.href="/goods/read?gid=" + gid;
			}
		});
	});
	
	$("#cart").on("click", function(){
		if(uid){
			//장바구니 넣기
			$.ajax({
				type:"post",
				url:"/cart/insert",
				data:{uid, gid},
				success:function(data){
					let message="";
					if(data=="true"){
						message="장바구니에 넣었습니다.";	
					}else{
						message="장바구니에 있는 상품입니다.";
					}
						if(confirm(message +"\n장바구니로 이동하시겠습니까?")){
							location.href="/goods/cart";
						}else{
							location.href="/";
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