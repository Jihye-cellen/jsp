<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- Button trigger modal -->
<style>
	#modalPass{
		top:30%
	}
</style>

<!-- Modal -->
<div class="modal fade" id="modalPass" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <h1 class="modal-title fs-5" id="staticBackdropLabel">비밀번호변경</h1>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body">
        <input id="upass" placeholder="현재비밀번호" type="password" class="form-control mb-2">
        <input id="npass" placeholder="새비밀번호" type="password" class="form-control mb-2">
        <input id="cpass" placeholder="새비밀번호확인" type="password" class="form-control mb-2">
      </div>
      <div class="text-center mb-5">
        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">닫기</button>
        <button id="btnSave" type="button" class="btn btn-danger">저장</button>
      </div>
    </div>
  </div>
</div>

<script>
	$("#modalPass").on("click", "#btnSave", function(){
		const upass=$("#upass").val();
		const npass=$("#npass").val();
		const cpass=$("#cpass").val();
		if(upass=="" || npass=="" || cpass==""){
			alert("모든 비밀번호를 입력하세요!")
		}else{
			$.ajax({
				type:"post",
				url:"/user/login",
				data:{uid, upass},
				success:function(data){
					if(data==2){
						alert("현재 비밀번호가 일치하지 않습니다.");
						$("#upass").val("");
						$("#upass").focus();
					}else{
						if(npass!=cpass){번
							alert("새 비밀번호가 일치하지 않습니다.");
						}else{
							$.ajax({
								type:"post",
								url:"/user/update/pass",
								data:{uid, npass},
								success:function(data){
									alert("비밀번호가 변경되었습니다.");
									location.href="/user/logout";
								}
								
								
							})
						}
					}
				}
				
			})
		}
			
		
	});
</script>