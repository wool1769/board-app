<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
	<!DOCTYPE html>
	<html>

	<head>
		<meta charset="UTF-8">
		<!-- <meta name="viewport" content="width=device-width, initial-scale=1"> -->
		<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no">
		<title>게시판</title>
		<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
		<link rel="stylesheet" type="text/css" href="css/write.css">
		<link rel="stylesheet" href="https://uicdn.toast.com/editor/latest/toastui-editor.min.css" />
	</head>

	<body>
		<div class="wrap">
			<header>
				<%@ include file="header.jsp" %>
			</header>
			<div class="headerFill"></div>
			<section class="writeSection">
				<h3 class="newPost">새글쓰기</h3>
				<h3 class="editPost blind">글수정</h3>
				<div class="writeBox">
					<div class="boxInner">
						<input type="text" placeholder="제목을 입력하세요" id="title">
						<div id="content"></div>
					</div>
				</div>
				<div class="saveBtn">저장</div>
			</section>
		</div>




		<% String userId=(String) session.getAttribute("id"); %>
			<script src="https://uicdn.toast.com/editor/latest/toastui-editor-all.min.js"></script>
			<script>
				let userId = '<%= userId %>'

				const editor = new toastui.Editor({
					el: document.querySelector('#content'), // 에디터를 적용할 요소 (컨테이너)
					height: '500px',                        // 에디터 영역의 높이 값 (OOOpx || auto)
					initialEditType: 'wysiwyg',            // 최초로 보여줄 에디터 타입 (markdown || wysiwyg)
					initialValue: '내용을 입력해 주세요.',     // 내용의 초기 값으로, 반드시 마크다운 문자열 형태여야 함
					previewStyle: 'vertical'                // 마크다운 프리뷰 스타일 (tab || vertical)
				});

				$(document).ready(function () {
					const params = new URLSearchParams(location.search);
					let boardid = params.get('boardid')
					if (boardid != null) {
						$(".newPost").addClass("blind")
						$(".editPost").removeClass("blind")

						$.ajax({
							type: 'get',
							url: "/board/get?boardId=" + boardid,
							dataType: 'json',
							success: function (data) {
								// console.log(data)
								$("#title").val(data.title)
								editor.setHTML(data.content)
								if (userId != data.memberId) {
									alert("잘못된 접근입니다.")
									window.location.href = "/"
								}
							}
						})
					}

					$(".saveBtn").on("click", function () {
						let titleVal = $("#title").val();
						let contentVal = editor.getHTML();
						if (titleVal.length == 0) {
							alert("제목을 입력하세요.")
							return
						}
						let type ="post"
						let postUrl = "/board/save"
						let jsonData = {
							"title": titleVal,
							"content": contentVal,
							"memberId": userId
						}
						if (boardid != null) {
							type ="put"
							postUrl = "/board/update"
							jsonData = {
								"boardId": boardid,
								"title": titleVal,
								"content": contentVal
							}
						}

						$.ajax({
							type: type,
							url: postUrl,
							data: JSON.stringify(jsonData),
							contentType: 'application/json',
							success: function (e) {
								alert("저장되었습니다");
								//저장후 해당게시물 상세페이지로 이동할 예정 
							
								if(boardid == null){
									window.location.href = "/detail?baordid="+e
									return
								}
								window.location.href = "/detail?baordid="+boardid
							},
							error: function (a, b, c) {
								alert(a + b + c);
							}

						})


					})





				})
			</script>
	</body>

	</html>