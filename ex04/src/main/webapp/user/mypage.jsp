<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>  

<style>
.modal-body img, .card-body img{
		border-radius:50%; border: 1px solid gray; cursor: pointer
	}

</style>

<div class="row justify-content-center">
	<div class="col-12 col-md-8 col-lg-6">
		<h1>마이페이지</h1>
		<div class="card">
			<div class="card-body">
				<div class="mb-3">
					<img src ="" id="imgphoto" width="50">
				<span>이름: ${user.uname}(${user.uid})</span>
				<button class="btn btn btn-outline-danger btn-sm ms-3" id="btnPass">비밀번호변경</button><hr>
				</div>
				<div class="mb-3">주소: ${user.address1} ${user.address2}<hr></div>
				<div class="mb-3">전화: ${user.phone}<hr></div>
				<div class="mb-3">가입일: <fmt:formatDate value= "${user.jdate}" pattern="yyyy년 MM월 dd일 HH:mm:ss"/><hr></div>
				<div class="mb-3">최근정보수정일: <fmt:formatDate value="${user.udate}" pattern="yyyy년 MM월 dd일 HH:mm:ss"/><hr></div>
				<div class="text-center mt-3"><button id="btnInfo" class="btn btn-warning px-5">정보수정</button></div>
			</div>
		</div>
	</div>
	<jsp:include page="modal_info.jsp"/>
	<jsp:include page="modal_pass.jsp"/>
	<jsp:include page="modal_photo.jsp"/>
</div>


<script>
	const photo = "${user.photo}";
	if(photo){
		$("#imgphoto").attr("src", photo);
		$("#photo").attr("src", photo);
	}else{
		$("#imgphoto").attr("src", "http://via.placeholder.com/50x50");
		$("#photo").attr("src", "http://via.placeholder.com/200x200");
	}


	$("#btnInfo").on("click", function(){
		$("#modalInfo").modal("show");
	});
	
	$("#btnPass").on("click", function(){
		$("#modalPass").modal("show");
	});
	
	$("#imgphoto").on("click", function(){
		$("#modalPhoto").modal("show");
	})
</script>