<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<div class="my-5">
	<div class="text-end">
		<button class="btn btn-outline-success px-5" id="rbtn">리뷰쓰기</button>
	</div>
	<div id="div_review"></div>
</div>

<div id="pagination" class="pagination justify-content-center mt-5 pagination-sm"></div>

<jsp:include page="modal_review.jsp"/>

<script id="temp_review" type="x-handlebars-template">
	{{#each .}}
		<div class="my-3">
			<div class="row">
			<div class="col" style="text-size:15px;">
				<span style="font-weight:bold">{{uid}}</span> |
				<span style="font-size:12px">{{rid}}</span>
				<span style="color:gray; font-size:10px;">{{revDate}}</span>
			</div>
			<div class="ellipsis content" style="cursor:pointer">
				 {{breaklines content}}
			</div>
				<div class="text-end mb-2" style="{{display uid}}" rid="{{rid}}">
						<button class="btn btn-outline-secondary btn-sm update" content="{{content}}">수정</button>
						<button class="btn btn-outline-dark btn-sm delete">삭제</button>
				</div>
			</div>		
		</div>
		<hr>
	{{/each}}

</script>

<script>
//줄바꿈 registerhelper

	Handlebars.registerHelper('breaklines', function(text) {
     text = Handlebars.Utils.escapeExpression(text);
     text = text.replace(/(\r\n|\n|\r)/gm, '<br>');
     return new Handlebars.SafeString(text);
   });
   
   
   //로그인한 수정삭제 버튼 나오기 
   
   Handlebars.registerHelper("display", function(writer){
	  if(uid!=writer) return "display:none";
   });
</script>

<script>
	let page=1;
	let size=5;
	let gid1="${param.gid}";
	getTotal();
	
	//수정버튼을 클릭한 경우
	$("#div_review").on("click", ".update", function(){
		const rid=$(this).parent().attr("rid");
		const content=$(this).attr("content");
		$("#modalReview").modal("show");
		$("#modalReview #content").val(content);
		$("#rid").val(rid);
		$(".insert").hide();
		$(".btn-update").show();
		
	});
	
	

	//모달의 수정버튼을 클릭한 경우
	
	$(".btn-update").on("click", function(){
		const content = $("#content").val();
		const rid=$("#rid").val();
		if(!confirm("작성한 리뷰 내용을 수정하시겠습니까?")) return;
		
		$.ajax({
			type:"post",
			url:"/review/update",
			data:{rid, content},
			success:function(){
				alert("리뷰수정성공!");
				$("#modalReview").modal("hide");
				getTotal();
			}
		});
		
	});
	
	
	//삭제버튼을 클릭한 경우
	$("#div_review").on("click", ".delete", function(){
		const rid=$(this).parent().attr("rid");
		if(!confirm(rid+"번 리뷰를 삭제하시겠습니까?"))return;
		
		$.ajax({
			type:"post",
			url:"/review/delete",
			data:{rid},
			success:function(){
				alert("리뷰삭제성공!");
				getTotal();
			}
		});
		
	});
	
	
	
	
	
	//getData();
	function getData(){
		$.ajax({
			type:"get",
			url:"/review/list.json",
			dataType:"json",
			data:{page, size, gid:gid1},
			success:function(data){
				const temp = Handlebars.compile($("#temp_review").html());
				$("#div_review").html(temp(data));
			}
		});
	}
	
	
	
	function getTotal(){
		$.ajax({
			type:"get",
			url:"/review/total",
			data:{gid:gid1},
			success:function(data){
				  const total = parseInt(data);
				  if(total==0){
					  getData();
					  $("#pagination").hide();
					  return;
				  }else{
					 const totalPage=Math.ceil(total/size);
					 $("#pagination").twbsPagination("changeTotalPages", totalPage, page);
						 if(total>size){
							 $("#pagination").show();
						 }else{
							 $("#pagination").hide();
						 }
			
				  }
			  }
		});
	}
	
	//리뷰창 클릭하면 긴글나오게 하기 
	
	$("#div_review").on("click", ".content", function(){
		$("#div_review .content").addClass("ellipsis");
		$(this).removeClass("ellipsis");
	});

	//리뷰쓰기 버튼을 눌렀을 때
	$("#rbtn").on("click", function(){
		if(uid){
			$("content").val("");
			$("#modalReview").modal("show");
			$(".insert").show();
			$(".btn-update").hide();
		}else{
			alert("로그인이 필요한 작업입니다!")
			sessionStorage.setItem("target", "/goods/read?gid=" + gid); 
			location.href="/user/login";
		}
		
		
	
	});
	
	
	$("#pagination").twbsPagination({
	      totalPages:10, 
	      visiblePages: 5, 
	      startPage : 1,
	      initiateStartPageClick: false, 
	      first:'<i class="bi bi-caret-left-fill"></i>', 
	      prev :'<i class="bi bi-caret-left"></i>',
	      next :'<i class="bi bi-caret-right"></i>',
	      last :'<i class="bi bi-caret-right-fill"></i>',
	      onPageClick: function (event, clickPage) {
	          page=clickPage; 
	          getData();
	      }
	   });
	

</script>