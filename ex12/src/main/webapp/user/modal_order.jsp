<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 

<!-- Modal -->
<div class="modal fade" id="modal_orders" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
  <div class="modal-dialog modal-lg">
    <div class="modal-content">
      <div class="modal-header">
        <h1 class="modal-title fs-5" id="pid">{{pid}}</h1>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body">
        <div id="address">배송지주소: {{address1}} {{address2}}</div>
        <hr>
        <div id="div_order_cart">
        </div>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
      </div>
    </div>
  </div>
</div>

<script id="temp_order_cart" type="x-handlebars-template">
	
	<table class="table table-bordered table-hover">
		<tr class="text-center table-warning">
			
			<td>상품번호</td>
			<td>상품명</td>
			<td>가격</td>
			<td>수량</td>
			<td>금액</td>
			
		</tr>
		{{#each .}}
		<tr class="text-center" gid="{{gid}}">
			<td>{{gid}}</td>
			<td class="text-start"><img src = "{{image}}"  width="60px">
				<a href="/goods/read?gid={{gid}}">{{{title}}}</a></td>				
			<td>{{sum1 price 1}}원</td>
			<td>{{qnt}}</td>
			<td>{{sum1 price qnt}}원</td>
		</tr>
		{{/each}}
	</table>


</script>


<script>
	Handlebars.registerHelper("sum1", function(price, qnt){
		const sum1= price * qnt;
		return sum1.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
	});

</script>
	
	


<script>

		function getOrders(pid){
		$.ajax({
			type:"get",
			url:"/order/list.json",
			dataType:"json",
			data:{pid},
			success:function(data){
				const temp=Handlebars.compile($("#temp_order_cart").html());
			$("#div_order_cart").html(temp(data));
			}
		});


	}
	
</script>