<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <style>
 	#size{
 		width:100px;
 		float:right;
 	}
 </style>
<div><h1>교수관리</h1></div>
<div class="row mt-5 mb-3">
	<form class="col-10 col-md-6" name="frm">
		<div class="input-group">
			<select class="form-select me-3" name="key">
				<option value="pcode">교수번호</option>	
				<option value="pname" selected>교수이름</option>
				<option value="dept">교수학과</option>		
			</select>
			<input placeholder="검색어를 입력하세요" class="form-control" name="word">
			<button class="btn btn-warning">검색</button>
		</div>
	</form>
	<div class="col">
		<select class="form-select" id="size">
			<option value="2">2행</option>
			<option value="3">3행</option>
			<option value="4">4행</option>
		</select>
	</div>
</div>
<div id = "div_pro"></div>
<div id="pagination" class="pagination justify-content-center mt-5"></div>
<script id="temp_pro" type="x-handlebars-template">
	<table class="table table-border table-hover">
		<tr class="table-warning">
			<td>교수번호</td>
			<td>교수이름</td>
			<td>교수학과</td>
			<td>교수직급</td>
			<td>교수급여</td>
			<td>임용날짜</td>
		</tr>
	{{#each .}}
		<tr>
			<td>{{pcode}}</td>
			<td><a href="/pro/read?pcode={{pcode}}">{{pname}}</a></td>
			<td>{{dept}}</td>
			<td>{{title}}</td>
			<td>{{salary}}</td>
			<td>{{hiredate}}</td>
		</tr>
	{{/each}}
	</table>
</script>


<script>
	let page=1;
	let size=$("#size").val();
	let key=$(frm.key).val();
	let word=$(frm.word).val();

	$(frm).on("submit", function(e){
		e.preventDefault();
		size=$("#size").val();
		key=$(frm.key).val();
		word=$(frm.word).val();
		page=1;
		getData();
	});
	
	$("#size").on("change", function(){
		size=$("#size").val();
		page=1;
		//getData();
		getTotal();
	});
	
	getTotal();
	function getData(){
		$.ajax({
			type:"get",
			url:"/pro/list.json",
			data:{page, size, key, word},
			dataType:"json",
			success:function(data){
				//console.log(data);
				const temp=Handlebars.compile($("#temp_pro").html());
				$("#div_pro").html(temp(data));
			}
		})
	}
	
		function getTotal(){
			$.ajax({
				type:"get",
				url:"/pro/total",
				data:{key, word},
				success:function(data){
					if(data==0){
						alert("검색내용이 없습니다!");
						$(frm.word).val("");
						return;
					}
					const totalPage= Math.ceil(data/size);
					$("#pagination").twbsPagination("changeTotalPages", totalPage, page);
					if(data>size){
						$("#pagination").show();
					}else{
						$("#pagination").hide();
					}
				}
			});
		}
	
	   $('#pagination').twbsPagination({
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