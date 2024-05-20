<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<div>
	<h1>수강신청목록</h1>
	<div class="input-group mb-3">
		<div id ="div_cou"></div>
		<button class="btn btn-danger mb-2" id="insert">수강신청</button>
	</div>
	<div id="div_enroll"></div>
</div>
<script id="temp_enroll" type="x-handlebars-template">
	<table class="table table-bordered table-hover">
		<tr class="text-center table-secondary">
			<td>강좌번호</td>
			<td>강좌이름</td>
			<td>강의시간</td>
			<td>강의실</td>
			<td>신청인원</td>
			<td>담당교수</td>
			<td>신청일</td>
			<td>취소</td>
		</tr>
		{{#each .}}
		<tr class="text-center">
			<td>{{lcode}}</td>
			<td><a href="/cou/read?lcode={{lcode}}">{{lname}}</a></td>
			<td>{{hours}}</td>
			<td>{{room}}</td>
			<td>{{persons}}/{{capacity}}</td>
			<td>{{pname}}({{pcode}})</td>
			<td>{{edate}}</td>
			<td><button class="btn btn-secondary btn-sm delete" lcode="{{lcode}}">취소</td>
		</tr>
		{{/each}}
	</table>
</script>
<script id="temp_cou" type="x-handlebars-template">
	<select class="form-select" id="lcode">
		{{#each .}}
		<option value={{lcode}}>{{lcode}}&nbsp;{{lname}}:&nbsp;{{pname}}&nbsp;&nbsp;({{persons}}/{{capacity}})</option>
		{{/each}}
	</select>


</script>
<script>
	let scode="${stu.scode}";

	getData();
		function getData(){
			$.ajax({
				type:"get",
				url:"/enroll/list.json",
				data:{scode},
				dataType:"json",
				success:function(data){
					const temp=Handlebars.compile($("#temp_enroll").html());
					$("#div_enroll").html(temp(data));
				}
			});
		}


	getCou();
		function getCou(){
			$.ajax({
				type:"get",
				url:"/cou/list.json",
				data:{page:1, size:100, key:"lcode", word:''},
				dataType:"json",
				success:function(data){
					const temp=Handlebars.compile($("#temp_cou").html());
					$("#div_cou").html(temp(data));
				}
			});
		}


	//수강신청 버튼을 누른경우
	$("#insert").on("click", function(){
		const lcode=$("#div_cou #lcode").val();
		if(confirm("수강신청 하시겠습니까?")){
			$.ajax({
				type:"post",
				url:"/enroll/insert",
				data:{scode, lcode},
				success:function(data){
					if(data=="true"){
						alert("수강신청완료!");
						getData();
						getCou();
					}else{
						alert("이미 수강신청한 강좌입니다!");
					}
				}
				
			});
		}
		
	});
	
	$("#div_enroll").on("click", ".delete", function(){
		const lcode=$(this).attr("lcode");
		if(confirm(lcode+"번 강좌의 수강신청을 취소하시겠습니까?")){
			$.ajax({
				type:"post",
				url:"/enroll/delete",
				data:{scode, lcode},
				success:function(data){
					if(data=="true"){
						alert("수강신청 취소완료!");
						getData();
						getCou();
					}else{
						alert("수강신청취소 실패");
					}
				}
				
			});
		}
	});
</script>