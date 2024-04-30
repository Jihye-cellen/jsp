<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<div>
	<h1>도서검색</h1>
	<div class="col-6 col-md-6 col-lg-4 mb-5">
		<form name="frm">
			<div class="input-group">
				<input class="form-control" placeholder="검색어를 입력해주세요">
				<button class="btn btn-danger">검색</button>
			</div>
		</form>
	</div>
	<div class="row" id="div_book"></div>
</div>

<script id="temp_book" type="x-handlebars-template">
		{{#each documents}}
			<div class="col-6 col-md-4 col-lg-2">
				<div class="card">
				<div class="card-body">
					<img src="{{thumbnail}}" width="90%" style:"cursor:pointer">
				</div>
				<div class="card-footer">
					<div class="ellipsis">{{title}}</div>
				</div>
			</div>
		</div>
		{{/each}}
	</script>
	
<script>
	//이미지유무체크함수
	Handlebars.registerHelper("check", function(thumbnail){
		if(thumbnail){
		return thumbnail;
	}else{
		return "http://via.placeholder.com/125x175";
		}
	});
</script>
	
	<div class="text-center my-5">
		<button id="prev" class="btn btn-outline-danger">이전</button>
		<span class="mx-3" id="span"></span>
		<button id="next" class="btn btn-outline-danger">다음</button>
	</div>


<script>
let query=$(frm.query).val();
let page=1;

	//이전, 다음 버튼 작동

	$("#prev").on("click", function() {
		page--;
		getData();
	});
	
	$("#next").on("click", function() {
		page++;
		getData();
	});

	
	
	//submit
	$(frm).on("click", function(e) {
		e.preventDefault();
		qurery = $(frm.query).val();
		if (query == "") {
			alert("검색어를 입력하세요!");
		} else {
			getData();
			page = 1;
		}

	})
	
	//데이터불러오기
	getData();
	function getData() {
		$.ajax({
			type : "get",
			url : "https://dapi.kakao.com/v3/search/book?target=title",
			headers : {"Authorization" : "KakaoAK 20d01e20f89a5de9ecf4fd2d01cc1e22"},
			dataType : "json",
			data : {"query" : "JSP", page:page, size:6},
			success : function(data) {
				console.log(data);
				const temp = Handlebars.compile($("#temp_book").html());
				$("#div_book").html(temp(data));
				
				
				const last = Math.ceil(data.meta.pageable_count / 6);
				$("#span").html(`<b>${span} / ${last}</b>`);

				if (page == 1) {
					$("#prev").attr("disabled", true);
				} else {
					$("#prev").attr("disabled", false);
				}
				if (data.meta.is_end) {
					$("#next").attr("disabled", true);
				} else {
					$("#next").attr("disabled", false);
				}

			}
		});
	}
</script>