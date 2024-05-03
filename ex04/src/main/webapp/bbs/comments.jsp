<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <style>
 	.delete{
 		font-size:15px;
 		cursor:pointer;
 		color:red;
 	}
 	.update{
 		font-size:15px;
 		cursor:pointer;
 		color:black;
 		}
 </style>
 <div class="text-end mt-2" id="div_insert">
	<textarea id="contents" rows="5" class="form-control" placeholder="댓글내용을 입력하세요."></textarea>
	<button class="btn btn-outline-danger px-5 mt-4 insert">등록</button>
</div>
<div class="mt-5 text-end" id="div_login">
	<button  class="btn btn-outline-danger px-5 mt-2 login">로그인</button>
</div>   
<div class="card mt-5">
	<div class="card-header">
		<span id= "total"></span>
	</div>
	<div class="card-body">
		<div id="div_comments"></div>
	</div>
</div>
<script id="temp_comments" type="x-handlebars-template">
	{{#each .}}
		<div class="text-muted">	
			<span>{{cdate}}</span>
			<span>{{uname}}({{writer}})</span>
			<i class="bi bi-pencil ms-3 update" style="{{update writer}}" cid="{{cid}}"></i>
			<i class="bi bi-trash3-fill ms-3 delete" style="{{delete writer}}" cid="{{cid}}"></i>
		</div>
		<div class="mb-3 ellipsis2"><b>{{cid}}</b>: {{contents}}</div>
	{{/each}}
</script>
<script>
	Handlebars.registerHelper("delete", function(writer){
		if(uid!=writer){
			return "display:none;";
		}
	});
	
	Handlebars.registerHelper("update", function(writer){
		if(uid!=writer){
			return "display:none;";
		}
	})
</script>

<div id="pagination" class="pagination justify-content-center mt-5"></div>
<jsp:include page="modal_update.jsp"/>

<script>
	const bid = "${bbs.bid}";
	let page=1;
	let size=3;
	
	
	getData();
	function getData(){
		$.ajax({
			type:"get",
			url:"/com/list.json",
			data:{bid, page, size},
			dataType:"json",
			success:function(data){
				const temp = Handlebars.compile($("#temp_comments").html());
				$("#div_comments").html(temp(data));
				
			}
			
			
		});
		
		
	}
	
	//페이지네이션 출력
	$("#pagination").twbsPagination({
		totalPages:100, 
		visiblePages: 5, 
		startPage : 1,
		initiateStartPageClick: false, 
		first:'<i class="bi bi-chevron-double-left"></i>', 
		prev :'<i class="bi bi-chevron-left"></i>',
		next :'<i class="bi bi-chevron-right"></i>',
		last :'<i class="bi bi-chevron-double-right"></i>',
		onPageClick: function (event, clickPage) {
			 page=clickPage; 
			 getData();
		}
	});
	
	
	
	getTotal();
	function getTotal(){
		$.ajax({
			type:"get",
			url:"/com/total",
			data:{bid},
			success:function(data){
					const totalPage=Math.ceil(data/size);
					$("#pagination").twbsPagination("changeTotalPages", totalPage, page);
					$("#total").html("댓글수:" + data + "건")
				
			}
		});
	}
	
	
	if(uid){
		$("#div_insert").show();
		$("#div_login").hide();
	}else{
		$("#div_insert").hide();
		$("#div_login").show();	
	}
	
	//로그인 버튼을 눌러서
	$("#div_login").on ("click", ".login", function(){
		sessionStorage.setItem("target", "/bbs/read?bid=" + bid);
		location.href="/user/login"
	});
	
	
	//등록버튼을 클릭한 경우
	
	$("#div_insert").on("click", ".insert", function(){
	const contents=$("#contents").val();
		if(contents==""){
			alert("댓글내용을 입력하세요!");
			$("#contents").focus();
			return;
		}
		$.ajax({
			type:"post",
			url:"/com/insert",
			data:{bid, contents, writer:uid},
			success:function(){
				page=1;
				getTotal();
				contents=$("#contents").val("");
			}
			
			
		})
	});
	
	//휴지통 버튼을 클릭했을 때
	$("#div_comments").on("click", ".delete", function(){
		const cid=$(this).attr("cid");
		if(confirm(cid + "번 댓글을 삭제하시겠습니까?")){
			//삭제하기
			$.ajax({
				type:"post",
				url:"/com/delete",
				data:{cid},
				success:function(){
					alert("삭제완료!");
					getTotal();
				}
				
			})
		}
	});
	
	
	//연필 버튼을 클릭했을 때 모달이 나오게 한다.
	$("#div_comments").on("click", ".update", function(){
		$("#modalUpdate").modal("show");
	});
	
	//모달안에 있는 수정버튼
	$("#btnUpdate").on("click", function(){
		const cid=$(this).attr("cid");
		const contents=$("contents").val();
		if(contents==""){
			alert("댓글을 수정하지 않았습니다.");
			return;
	}else{
		//수정하기
			$.ajax({
				type:"post",
				url:"/com/update",
				data:{contents, cid},
				success:function(){
					alert(cid + "번 글을 수정하시겠습니까?");
					getTotal();
				}
				
			})
		
		}
	});

</script>	