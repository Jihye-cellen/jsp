<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<style>
	#div_shop img{
		cursor:pointer;
		border-radius:5px;
	}
</style>
<div>
	<h1>상품목록</h1>
	<div class="row">
		<div class="col">
			<button class="btn btn-danger mb-3" id="delete">선택삭제</button>
		</div>
		<div class="col-8 col-md-6">
			<form name="frm">
				<div class="input-group">
					<select class="form-select me-3" name="key">
				<option>카테고리</option>
				<option>-----------</option>	
				<option value="gid">상품아이디</option>	
				<option value="title" selected>상품명</option>
				<option value="brand">브랜드</option>
				<option value="price">가격</option>
				<option value="regDate">등록일</option>		
			</select>
					<span id="total" class="me-2 mt-2"></span>
					<input class="form-control" placeholder="검색어 입력하세요." name="word">
					<button class="btn btn-outline-success">검색</button>
				</div>
			</form>
		</div>
	</div>
	<div id="div_shop"></div>
	<div id="pagination" class="pagination justify-content-center mt-5"></div>
</div>

<script id="temp_shop" type="x-handlebars-template">
	<table class="table table-bordered table-hover text-center">
		<tr class="text-center table-secondary">
			<td><input type="checkbox" id="all"></td>
			<td>아이디</td><td>브랜드명</td><td colspan=2>상품명</td><td>상품가격</td><td>삭제</td>

		</tr>
		{{#each .}}		
		<tr>
			<td><input type="checkbox"  class="chk" gid="{{gid}}"></td>
			<td>{{gid}}</td>
			<td>{{brand}}</td>
			<td><img src={{image}} width="50" index={{@index}}></td>
			<td><div class="ellipsis">{{{title}}}</div>
				<div>({{regDate}})</div>	
			</td>
			<td>{{fmtPrice price}}</td>
			<td><button class="btn btn-outline-danger text-center delete" gid="{{gid}}">삭제</button>
			<jsp:include page="modal_image.jsp"/>
			</td>
		</tr>
		{{/each}}
	</table>
</script>

<script>
	let page=1;
	let size=7;
	let word="";
	let key=$(frm.key).val();
	//select value 값은 컬럼이 와야한다. 
	getTotal();
	
	
	
	
	
	
	Handlebars.registerHelper("fmtPrice", function(price){
		return price.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
	});
	
	//이미지를 클릭했을 때 모달이 뜨는거
	
	$("#div_shop").on("click", "img", function(){
		const index=$(this).attr("index");
		$("#modal"+ index).modal("show");
	});
	
	//submit
	$(frm).on("submit", function(e){
		e.preventDefault();
		word=$(frm.word).val();
		key=$(frm.key).val();
		page=1;
		getTotal();
	});


	//선택 삭제 버튼을 클릭한 경우
	$("#delete").on("click", function(){
		const chk = $("#div_shop .chk:checked").length;
		if(chk==0){
			alert("삭제할 상품을 선택하세요!");
		}else{
			if(!confirm(chk+"개 상품을 삭제하시겠습니까?"))return;
			
			let cnt = 0;
			let success=0;
			$("#div_shop .chk:checked").each(function(){
				const gid=$(this).attr("gid");
				$.ajax({
					type:"post",
					url:"/goods/delete",
					data:{gid},
					success:function(data){
						cnt++;
						if(data=="true") success++;
						if(cnt==chk){
							alert(success+"개 상품이 삭제되었습니다.");
							//getData();
							getTotal();
						}
					}
				});
			});
		}
	})
	
	//전체선택 체크박스를 클릭한 경우
	$("#div_shop").on("click", "#all", function(){
		if($(this).is(":checked")){
			$("#div_shop .chk").each(function(){
				$(this).prop("checked", true);
			});
		}else{
			$("#div_shop .chk").each(function(){
				$(this).prop("checked", false);
			});
		}
	});
	
	
	//각 행의 체크박스를 클릭한 경우
	$("#div_shop").on("click", ".chk", function(){
		const all = $("#div_shop .chk").length;
		const chk = $("#div_shop .chk:checked").length;
		if(all==chk){
			$("#div_shop #all").prop("checked", true);
		}else{
			$("#div_shop #all").prop("checked", false);
		}
	});
	
	//삭제버튼을 클릭한 경우
	$("#div_shop").on("click", ".delete", function(){
		const gid =$(this).attr("gid");
		if(confirm(gid + "번 상품을 삭제하시겠습니까?")){
			$.ajax({
				type:"post",
				url:"/goods/delete",
				data:{gid},
				success:function(data){
					if(data=="true"){
						alert("삭제성공!");
						//getData();
						getTotal();
					}else{
						alert("삭제실패!");
					}
				}
			});
		}
	});

		

	function getData(){
		$.ajax({
			type:"get",
			url:"/goods/list.json",
			data:{word, page, size, key},
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
			  data:{word, key},
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
				  		$("#total").html("검색수:"+ total);
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