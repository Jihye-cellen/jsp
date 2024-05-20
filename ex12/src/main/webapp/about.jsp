<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <style>
	.brand {
		font-size:12px;
	} 
 
 	#div_shop img{
 		border-radius:10px;
 	}
 	
 	.bi-heart, .bi-heart-fill{
 		color:red;
 		float:right;
 		font-size:12px;
 		cursor:pointer;
 		
 	}
 </style>   
 
<div class="my-5">
	<div class="row mb-3 justify-content-end">
		<div class="col-6 col-md-4">
			<form name="frm">
				<div class="input-group">
					<input class="form-control" placeholder="검색어" name="word">
					<button class="btn btn-success">검색</button>
				</div>
			</form>
		</div>
	</div>
	<div id="div_shop" class="row"></div>
</div>
<ul id="pagination" class="pagination justify-content-center mt-5 pagination-sm"></ul>
<script id="temp_shop" type="x-handlebars-template">
	{{#each .}}
		<div class="col-2 col-md-4 col-lg-2">
			<div class="mb-2"><img src="{{image}}" gid="{{gid}}" width="90%" style="cursor:pointer"></div>
			<div class="brand">{{brand}} {{gid}}</div>
			<div class="ellipsis">{{{title}}}</div>
			<div><b>{{fmtPrice price}}원</b>
				<span class="bi {{heart ucnt}}" gid="{{gid}}" > <span style="font-size:12px; color:red">{{fcnt}}/{{rcnt}}</span></span>
			</div>
		</div>
	{{/each}}
</script>

<script>
	
	Handlebars.registerHelper("fmtPrice", function(price){
		return price.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
	});
	
	Handlebars.registerHelper("heart", function(value){
		if(value==0) return "bi-heart";
		else return "bi-heart-fill";
	});
</script>


<script>

	let size=12;
	let page=1;
	let word="";
	
	getTotal();
	
	//이미지를 클릭한 경우 (uid는 로그인이 되어서 이미 가져올 수 있음)
	$("#div_shop").on("click", "img", function(){
		const gid= $(this).attr("gid");
		location.href="/goods/read?uid=" + uid + "&gid=" + gid;
		
	});
	
	//좋아요 취소
	
	$("#div_shop").on("click", ".bi-heart-fill", function(){
		const gid= $(this).attr("gid");
			$.ajax({
				type:"post",
				url:"/favorite/delete",
				data:{uid, gid},
				success:function(){
					alert("좋아요 취소!");
					getData();
				}
			});
		});
	
	
	//좋아요 클릭
	$("#div_shop").on("click", ".bi-heart", function(){
		const gid= $(this).attr("gid");
		if(uid){
			$.ajax({
				type:"post",
				url:"/favorite/insert",
				data:{uid, gid},
				success:function(){
					alert("좋아요 등록!");
					getData();
				}
			});
		}else{
			alert("로그인을 해주세요!")
			sessionStorage.setItem("target", "/goods/read?gid="+gid);
			location.href="/user/login";
		}
		
		
	});
	
	
	$(frm).on("submit", function(e){
		e.preventDefault();
		word=$(frm.word).val();
		page=1;
		getTotal();
	});
	
	function getData(){
		$.ajax({
			type:"get",
			url:"/goods/list.json",
			data:{word, page, size, uid},
			dataType:"json",
			success:function(data){
				const temp = Handlebars.compile($("#temp_shop").html());
				$("#div_shop").html(temp(data));
				
			}
		});
	}
	
	function getTotal(){
		  $.ajax({
			  type:"get",
			  url:"/goods/total",
			  data:{word},
			  success:function(data){
				  const total = parseInt(data);
				  if(total==0){
					  alert("검색한 상품이 없습니다.");
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
	
	
	
	 $("#pagination").twbsPagination({
	      totalPages:10, 
	      visiblePages: 5, 
	      startPage : 1,
	      initiateStartPageClick: false, 
	      first:'<i><<</i>', 
	      prev :'<i><</i>',
	      next :'<i>></i>',
	      last :'<i>>></i>',
	      onPageClick: function (event, clickPage) {
	          page=clickPage; 
	          getData();
	      }
	   });
</script>