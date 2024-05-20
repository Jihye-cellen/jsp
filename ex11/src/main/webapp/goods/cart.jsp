<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<div>
	<h1>장바구니</h1>
	
	<div id="div_cart"></div>
	<div class="alert alert-light text-end" role="alert" id="div_total">총 금액: </div>
</div>

<script id="temp_cart" type="x-handlebars-template">
	<div class="mb-2">
		<button class="btn btn-success" id="delete">선택상품삭제</button>
	</div>
	<table class="table table-bordered table-hover">
		<tr class="text-center table-warning">
			<td><input type="checkbox" id="all">
			<td>상품번호</td>
			<td>상품명</td>
			<td>가격</td>
			<td>수량</td>
			<td>금액</td>
			<td>삭제</td>
		</tr>
		{{#each .}}
		<tr class="text-center" gid="{{gid}}">
			<td><input type="checkbox" class="chk">
			<td>{{gid}}</td>
			<td class="text-start"><img src = "{{image}}"  width="60px">
				<a href="/goods/read?gid={{gid}}">{{{title}}}</a></td>				
			<td>{{sum price 1}}</td>
			<td><input value="{{qnt}}" class="qnt" size=2><button class="btn btn-light btn-sm update">수정</button></td>
			<td>{{sum price qnt}}</td>
			<td><i class="bi bi-trash delete" style="cursor:pointer"></i></td>
		</tr>
		{{/each}}
	</table>


</script>


<script>
	Handlebars.registerHelper("sum", function(price, qnt){
		const sum= price * qnt;
		return sum.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
	});

</script>


<script>
	//선택삭제하기 버튼을 클릭한 경우
	$("#div_cart").on("click", "#delete", function(){
		const chk = $("#div_cart .chk:checked").length;
		if(chk==0){
			alert("삭제할 상품들을 선택하세요!");
			return;
		}
		if(!(confirm(chk +"개 상품을 삭제하시겠습니까?"))) return;
		
			let cnt = 0;
			$("#div_cart .chk:checked").each(function(){
				const gid=$(this).parent().parent().attr("gid");
				$.ajax({
					type:"post",
					url:"/cart/delete",
					data:{gid,uid},
					success:function(){
						cnt++;
						if(chk==chk){
							getData();
						}
					}
				});
			});
		
	});


	//전체 체크박스 클릭
	$("#div_cart").on("click", "#all", function(){
		if($(this).is(":checked")){
			$("#div_cart .chk").each(function(){
				$(this).prop("checked", true);
			});
		}else{
			$("#div_cart .chk").each(function(){
				$(this).prop("checked", false);
			});
		}
	});
	
	//행의 체크박스 클릭한 경우
	$("#div_cart").on("click", ".chk", function(){
		const all = $("#div_cart .chk").length;
		const chk = $("#div_cart .chk:checked").length;
		if(all==chk){
			$("#div_cart #all").prop("checked", true);
		}else{
			$("#div_cart #all").prop("checked", false);
		}
	});
	


	$("#div_cart").on("click", ".delete", function(){
		const gid = $(this).parent().parent().attr("gid");
		if(!confirm(gid+"번 상품을 삭제하시겠습니까?")) return;
		//삭제하기
		$.ajax({
			type:"post",
			url:"/cart/delete",
			data:{gid,uid},
			success:function(){
					getData();
				
			}
		});
	});

	$("#div_cart").on("click", ".update", function(){
		const qnt = $(this).parent().find(".qnt").val();
		const gid = $(this).parent().parent().attr("gid");
		//alert(uid + ": " + qnt + ": " + gid);
		
		$.ajax({
			type:"post",
			url:"/cart/update",
			data:{qnt, gid, uid},
			success:function(){
				getData();
			}
		});
	});


	getData();
	//alert(uid);
	function getData(){
		$.ajax({
			type:"get",
			url:"/cart/list.json",
			data:{uid},
			dataType:"json",
			success:function(data){
				console.log(data);
				const temp = Handlebars.compile($("#temp_cart").html());
				$("#div_cart").html(temp(data));
				
				let total=0;
				$(data).each(function(){
					const price = this.price;
					const qnt = this.qnt;
					const sum = price * qnt;
					total += sum;
				});
				$("#div_total").html("총 금액: " + total.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",") + "원");
			}
		});
	}

</script>
