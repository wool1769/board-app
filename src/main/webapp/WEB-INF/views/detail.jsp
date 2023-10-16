<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
	<!DOCTYPE html>
	<html>

	<head>
		<meta charset="UTF-8">
		<!-- <meta name="viewport" content="width=device-width, initial-scale=1"> -->
		<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no">
		<title>게시판</title>
		<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
		<link rel="stylesheet" type="text/css" href="css/detail.css">
		<link rel="stylesheet" href="https://uicdn.toast.com/editor/latest/toastui-editor.min.css" />
	</head>

	<body>
		<% String userId=(String) session.getAttribute("id"); %>
		<div class="wrap">
			<header>
				<%@ include file="header.jsp" %>
			</header>
			<div class="headerFill"></div>
			<section class="detailSection">
				<h3 class="detailTitle">상세페이지</h3>
				<div class="detailBox">
					<div class="detailInner">

						<div class="titleBox">
							<div class="title">title</div>
							<%if(userId!=null){%>
								<div class="scrap">scrap◻︎</div>
							<%}%>
							
						</div>
						<div class="boardInfo">
							<div class="memberId">작성자</div>
							<div>
								<div>
									<p>view</p>
									<div class="view">0</div>
								</div>
								<div class="date">작성시간</div>
							</div>
						</div>

						<div class="content"></div>
						<div class="commentWrap">
							<h4>comment</h4>
							<div class="commentWriteBox">
								<input type="text" id="comment">
								<!-- <div class="commentSaveBtn" data-id="1">저장</div> -->
								<div id="saveBtn" class="commentSaveBtn">저장</div>
							</div>
							<!-- <div class="commentBox">
								<div class="comment">
									<div class="comContent" onclick="openCW(9999)">
										<div data-cid="9999">wool1769</div>
										<div data-cid="9999">댓글내용</div>
										<div data-cid="9999">작성날짜</div>
										<div data-cid="9999">x</div>
									</div>
									<div class="commentWriteBox ccWriteBox blind" data-coid="9999">
										<input type="text" id="comment">
										<div class="commentSaveBtn" data-id="9999">저장</div>
									</div>
									<div class="cCommentBox">
										<div class="cComment comContent">
											<div>wool1769</div>
											<div>댓글내용</div>
											<div>작성날짜</div>
											<div>×</div>
										</div>
									</div>
								</div>
							</div> -->
						</div>
					</div>
				</div>
				<div class="btns">
					<div id="list" class="detailBtns">목록</div>
					<div id="edit" class="detailBtns">수정</div>
					<div id="delete" class="detailBtns">삭제</div>
				</div>
			</section>
		</div>




		
			<script>
				let userId = '<%= userId %>'



				$(document).ready(function () {
					const params = new URLSearchParams(location.search);
					let boardid = params.get('baordid')
					let pageNum = params.get('page')
					let scrap = params.get('scrap')
					let scrapBoard




					$("#list").on("click", function () {
						if (pageNum == null && scrap != 1) {
							location.href = "/"
							return
						}
						if (scrap == 1) {
							history.back();
							return
						}
						location.href = "/?page=" + pageNum
					})
					$('#edit').on("click", () => {
						location.href = "/write?boardid=" + boardid
					})
					$("#delete").on("click", () => {
						let pw = prompt("비밀번호입력")

						$.ajax({
							type: 'delete',
							url: "/board/delete?boardId=" + boardid + "&memberPw=" + pw,
							dataType: 'json',
							success: function (data) {

								if (data) {
									location.href = "/"
								}

							}
						})

					})

					function dateform(contTime) {
						const year = contTime.getFullYear();
						const month = String(contTime.getMonth() + 1).padStart(2, '0');
						const day = String(contTime.getDate()).padStart(2, '0');
						let dateform = year + ". " + month + ". " + day
						return dateform
					}

					if (boardid != null) {

						$.ajax({
							type: 'get',
							url: "/board/get?boardId=" + boardid + "&plus=1",
							dataType: 'json',
							success: function (data) {
								let contTime = new Date(data.date);
								$.ajax({
									type: "post",
									url: "/favorites/get",
									data: JSON.stringify({
										"boardId": boardid,
										"id": userId
									}),
									contentType: 'application/json',
									success: function (result) {
										// alert(result)
										if (result) {
											$(".scrap").addClass("scrapAdd")
											$(".scrap").text("scrap☑︎")
											scrapBoard = result
										

										}


									}
								})

								$(".title").text(data.title)
								$(".content").append(data.content)
								$(".memberId").text(data.memberId)
								$(".view").text(data.views)
								$(".date").text(dateform(contTime))


								if (userId != data.memberId) {
									// 여기에 수정버튼 보여주는거 넣기
									$("#edit").addClass("blind")
									$("#delete").addClass("blind")
								}

								$.ajax({
									type: 'get',
									url: "/comment/listget?boardId=" + boardid,
									dataType: 'json',
									success: function (data) {
										console.log(data)
										if (data.length != 0) {
											$(".commentWrap").append('<div class="commentBox"><div class="comment"></div></div>')
											for (let i = 0; i < data.length; i++) {
												if (data[i].ccommentId == null) {
													let contTime = new Date(data[i].date);
													let ccdata = ""
													for (let j = 0; j < data.length; j++) {
														let contTime2 = new Date(data[j].date);
														if (data[j].ccommentId != null) {
															if (ccdata.length == 0) {
																ccdata = '<div class="cCommentBox">'
															}
															let xbtn1 = ""
															if (data[j].memberId == userId) {
																xbtn1 = '<div  onclick="coDelete(' + data[j].commentId + ')">×</div>'
															}
															if (data[j].ccommentId == data[i].commentId)
																ccdata += '<div class="cComment comContent">' +
																	'<div>' + data[j].memberId + '</div>' +
																	'<div>' + data[j].content + '</div>' +
																	'<div>' + dateform(contTime2) + '</div>' +
																	xbtn1 +
																	'</div>'

														}

													}
													if (ccdata.length != 0) {
														ccdata += '</div>'
													}
													let xbtn2 = ""
													if (data[i].memberId == userId) {
														xbtn2 = '<div  onclick="coDelete(' + data[i].commentId + ')">×</div>'
													}
													$(".comment").append(
														'<div class="comContent openCW" onclick="openCW(' + data[i].commentId + ')">' +
														'<div>' + data[i].memberId + '</div>' +
														'<div>' + data[i].content + '</div>' +
														'<div>' + dateform(contTime) + '</div>' +
														xbtn2 +
														'</div>' +
														'<div class="commentWriteBox ccWriteBox blind" data-coid="' + data[i].commentId + '">' +
														'<input type="text" id="input' + data[i].commentId + '">' +
														'<div class="commentSaveBtn" data-id="' + data[i].commentId + '"  onclick="saveBtns(' + data[i].commentId + ')">저장</div>' +
														'</div>' + ccdata
													)


												}
											}
										}
									}
								})



							}
						})
					} else {
						location.href = "/"
					}


					$("#saveBtn").on("click", function (e) {

						let btnDataId = e.target.getAttribute('data-id')

						if (userId != "null") {
							let commentVal = $("#comment").val()
							if (commentVal.length == 0) {
								alert("댓글을 작성하세요.")
								return
							}
							commentSave(commentVal, btnDataId)
							return
						}
						alert("로그인이 필요합니다.")
					})



					function commentSave(commentVal, ccommentId) {
						$.ajax({
							type: "post",
							url: "/comment/save",
							data: JSON.stringify({
								"content": commentVal,
								"boardId": boardid,
								"ccommentId": ccommentId,
								"memberId": userId
							}),
							contentType: 'application/json',
							success: function (result) {
								// alert("저장되었습니다.");
								// 저장한 후 댓글다시 불러오기 해야함 
								window.location.reload()
							},
							error: function (a, b, c) {
								alert(a + b + c);
							}

						})
					}

					//scrapBoard 변수명
					



					$(".scrap").on("click", () => {
						let url
						
						if (scrapBoard) {
							url = "/favorites/delete"
						}else{
							url = "/favorites/save"
						}
					
						$.ajax({
							type: "post",
							url: url,
							data: JSON.stringify({
								"boardId": boardid,
								"id": userId
							}),
							contentType: 'application/json',
							success: function (result) {
								if (result) {
									if (scrapBoard) {
										$(".scrap").removeClass("scrapAdd")
										$(".scrap").text("scrap◻︎")
										scrapBoard = false
									} else {
										$(".scrap").addClass("scrapAdd")
										$(".scrap").text("scrap☑︎")
										scrapBoard = true
									}
									if(scrapBoard){
										alert("저장했습니다.")
									}else{
										alert("삭제했습니다.")
									}
									
								}
							},
							error: function(e){
								alert(e)
							}
						})

					})




				})
				function saveBtns(e) {


					if (userId != "null") {

						let inputid = "#input" + e


						let commentVal = $(inputid).val()

						if (commentVal.length == 0) {
							alert("댓글을 작성하세요.")
							return
						}
						commentSaves(commentVal, e)
						return
					}
					alert("로그인이 필요합니다.")
				}


				function commentSaves(commentVal, ccommentId) {
					let paramss = new URLSearchParams(location.search);
					let boardid = paramss.get('baordid')


					$.ajax({
						type: "post",
						url: "/comment/save",
						data: JSON.stringify({
							"content": commentVal,
							"boardId": boardid,
							"ccommentId": ccommentId,
							"memberId": userId
						}),
						contentType: 'application/json',
						success: function (result) {
							// alert("저장되었습니다.");
							// 저장한 후 댓글다시 불러오기 해야함 
							window.location.reload()
						},
						error: function (a, b, c) {
							alert(a + b + c);
						}

					})
				}

				function openCW(e) {
					$('div[data-coid="' + e + '"]').toggleClass("blind")
				}

				function coDelete(e) {
					let pw = prompt("비밀번호를 입력하세요.")
					$.ajax({
						type: 'delete',
						url: "/comment/delete?memberPw=" + pw + "&commentId=" + e,
						dataType: 'json',
						success: function (data) {
							if (pw.length == 0) {
								return
							}
							if (data) {
								location.reload();
							} else {
								alert("비밀번호가 틀렸음.")
							}

						}
					})
				}




			</script>
	</body>

	</html>