<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
   
<div class="mt-2">    
	<h1>수강신청 학생목록</h1>
	<div id="div_stu"></div>
</div>

<script id="temp_stu" type="x-handlebars-templage">
	<div class="mb-2">
		<button class="btn btn-success px-5" id="update">선택저장</button>
	</div>
	<table class="table table-bordered table-hover">
		<tr class="text-center table-secondary">
			<td><input type="checkbox" id="all"></td>
			<td>학생번호</td>
			<td>학생이름</td>
			<td>학생학과</td>
			<td>학생학년</td>
			<td>신청일</td>
			<td>점수</td>

		</tr>
		{{#each .}}
		<tr class="text-center" scode ="{{scode}}">
			<td><input type="checkbox" class="chk"></td>
			<td>{{scode}}</td>
			<td><a href="/stu/read?scode={{scode}}">{{sname}}</a></td>
			<td>{{sdept}}</td>
			<td>{{year}}학년</td>
			<td>{{edate}}</td>
			<td scode ="{{scode}}"> <input value="{{grade}}" size=3 class="text-end px-2 grade">
				<button class="btn btn-success btn-sm update">수정</button></td>
		</tr>
		{{/each}}
	</table>
</script>



<script>
 
	let lcode="${cou.lcode}";
	
	//체크박스 전체선택
	$("#div_stu").on("click", "#all" , function(){
		if($(this).is(":checked")){
			$("#div_stu .chk").each(function(){
				$(this).prop("checked", true);
			});
		}else{
			$(this).prop("checked", false);
		}
	});
	
	//각 행의 체크박스를 클릭한 경우
	
	$("#div_stu").on("click", ".chk", function(){
		let all = $("#div_stu .chk").length;
		let chk = $("#div_stu .chk:checked").length;
		if(all==chk){
			$("#div_stu #all").prop("checked", true);
		}else{
			$("#div_stu #all").prop("checked", false);
		}
		
	});
	
	//선택저장 눌렀을 때
	
	$("#div_stu").on("click", "#update", function(){
		let chk = $("#div_stu .chk:checked").length;
		if(chk==0){
			alert("수정할 학생들을 선택하세요!");
			return;
		}
		if(!confirm(chk + "개 성적을 수정하시겠습니까?")) return;
		let cnt=0;
		$("#div_stu .chk:checked").each(function(){
			let tr = $(this).parent().parent();
			let scode=tr.attr("scode");
			let grade=tr.find(".grade").val();
			$.ajax({
				type:"post",
				url:"/enroll/update",
				data:{lcode, scode, grade},		
				success:function(){
						cnt++;
						if(chk==cnt){
						alert("수정완료!");
						getData();
						
					}
				}
					
				
			});
		});
	});
	
	
	
	//각 행의 수정버튼을 클릭한 경우
	
	$("#div_stu").on("click", "tr .update", function(){
		let scode =$(this).parent().attr("scode");
		let td =$(this).parent()
		let grade=td.find(".grade").val();
		
		$.ajax({
			type:"post",
			url:"/enroll/update",
			data:{lcode, scode, grade},		
			success:function(){
				if(confirm("수정하시겠습니까?")){
					alert("수정완료!");
					getData();
				}
			}
				
			
		});
	});

	getData();
	function getData(){
		$.ajax({
			type:"get",
			url:"/enroll/slist.json",
			dataType:"json",
			data:{lcode},
			success:function(data){
				console.log(data);
				const temp=Handlebars.compile($("#temp_stu").html());
				$("#div_stu").html(temp(data));
			}
		});
}
</script>