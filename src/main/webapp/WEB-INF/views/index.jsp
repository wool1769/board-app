<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
	<!DOCTYPE html>
	<html>

	<head>
		<meta charset="UTF-8">
		<!-- <meta name="viewport" content="width=device-width, initial-scale=1"> -->
		<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no">
		<title>게시판</title>
		<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
		<link rel="stylesheet" type="text/css" href="css/index.css">
	</head>

	<body>

		<div class="wrap">
			<header>
				<%@ include file="header.jsp" %>
			</header>
			<div class="headerFill"></div>
			<section class="boardContent">
				<div class="boardTop">
					<h3 id="boardTitle">게시판</h3>

					<div class="searchBox searchBoxClose">
						<div id="searchOpen" class="searchBoxopen">
							<div class="searchBoxopenInner blinds">
								<span class="sBtnO blinds"></span>
								<span class="sBtnT blinds"></span>
							</div>
						</div>
						<div class="serchClose blinds">▶︎</div>
						<select id="category" class="changeVal">
							<option value="1">제목+내용</option>
							<option value="2">제목</option>
							<option value="3">내용</option>
							<option value="4">작성자ID</option>
						</select>
						<input type="text" id="textbox" class="changeVal" placeholder="검색어를 입력하세요">
						<div class="searchBtnWrap BtnWrap">
							<div id="searchBtn">
								<span class="sBtnO "></span>
								<span class="sBtnT "></span>
							</div>
						</div>
						<div class="clearBtnWrap BtnWrap blind">
							<div id="clearBtn">
								<span class="cBtnO"></span>
								<span class="cBtnT"></span>
							</div>
						</div>
					</div>
				</div>
				<div class="contentBox">
					<div class="emptyContent blind">
						게시물이 없습니다.
					</div>

					<div class="content">
						<!-- 스크립트에서 삽입 -->
					</div>

				</div>
				<% if(session.getAttribute("id")!=null){ %>
					<div class="writeBtn" onclick="location.href='/write'">글쓰기</div>
					<%}%>
						<div class="pageBox">
							<!-- 스크립트에서 삽입 -->
							<div class="shade"></div>
						</div>
			</section>
		</div>





		<script>
			// 게시물 데이터
			

			$(document).ready(function () {
				const params = new URLSearchParams(location.search);
				const url = new URL(location);
				let pathname = url.pathname
				if (pathname == "/scrap") {
					$("#boardTitle").text("Scrap")
					$(".searchBox").addClass("blind")
					$(".writeBtn").addClass("blind")
				}


				let pageNum = params.get('page')
				let category = params.get('category')
				let search = params.get('search')
				let resultParmas = ''

				// 모바일 서치박스 열기 
				$("#searchOpen").on("click",()=>{
					$(".searchBox").removeClass("searchBoxClose")
					$("#searchOpen").addClass("blind")
					$(".searchBox").css("transition","0.5s ")
				})
				// 모바일 서치박스 닫기 
				$(".serchClose").on("click",()=>{
					$(".searchBox").addClass("searchBoxClose")
					$(".searchBox").css("transition","0.5s ")
					setTimeout(() => {
						$("#searchOpen").removeClass("blind")
					}, 501);
					

				})





				if (category != null && search != null) {
					resultParmas += "?category=" + category + "&search=" + search + "&"
					// 검색어 삭제 노출 
					$(".clearBtnWrap").removeClass("blind")
					$(".searchBtnWrap").addClass("blind")
					$("#category").prop("selectedIndex", category - 1);
					$("#textbox").val(search)
					// $(".searchBox").css("transition","0s ")
					$(".searchBox").removeClass("searchBoxClose")
					$("#searchOpen").addClass("blind")
					
					


				} else {
					resultParmas = "?"
				}
				if (pageNum != null) {
					resultParmas += "page=" + pageNum
				} else {
					resultParmas = ""
				}
				if (pathname == "/scrap") {
					if (resultParmas.length == 0) {
						resultParmas += "?"
					} else {
						resultParmas += "&"
					}
					resultParmas += "scrap=1"
				}
				$.ajax({
					type: 'get',
					url: "board/getlist" + resultParmas,
					dataType: 'json',
					success: function (data) {
						let boardData = data.getlist;
						let totalContent = data.totalContent;

						// 데이터가 없으면 데이터 없음 표시 페이지버튼 삭제
						if (totalContent == 0) {
							$(".pageBox").addClass("blind")
							$(".emptyContent").removeClass("blind")
						}




						for (let i = 0; i < boardData.length; i++) {
							// console.log(boardData[i])

							const nowtime = new Date();
							let contTime = new Date(boardData[i].date);
							contTime.setMinutes(contTime.getMinutes() + contTime.getTimezoneOffset());
							let notiTime
							let timeCalc = Math.floor((nowtime.getTime() - contTime.getTime()) / 1000);

							const year = contTime.getFullYear();
							const month = String(contTime.getMonth() + 1).padStart(2, '0');
							const day = String(contTime.getDate()).padStart(2, '0');



							if (timeCalc / 60 / 60 / 24 >= 1) {
								notiTime = year + ". " + month + ". " + day
							} else if (timeCalc / 60 / 60 >= 1) {
								notiTime = Math.floor(timeCalc / 60 / 60) + "시간 전"
							} else if (timeCalc / 60 >= 1) {
								notiTime = Math.floor(timeCalc / 60) + "분 전"
							} else {
								notiTime = "방금전"
							}

							let boardId = boardData[i].boardId
							if (pageNum != null) {
								boardId += "&page=" + pageNum
							}


							let detailPage = "location.href='/detail?baordid=" + boardId
							if (pathname == "/scrap") { detailPage += "&scrap=1" }
							detailPage += "'"
							$('.content').append(
								'<div class="contentInner"><div class="title" onclick="' + detailPage + ' ">' + boardData[i].title
								+ '</div><div class="infoBox"><div class="date">' + notiTime
								+ '</div><div class="infoR"><div class="view">view ' + boardData[i].views
								+ '</div><div class="id">' + boardData[i].memberId + '</div></div></div></div>'
							)
						}
						// console.log(totalContent + "전체게시물");
						// console.log(pageNum + "현제페이지")//현제페이지
						if (pageNum == null) {
							pageNum = 1
						}
						let totalPage = Math.ceil(totalContent / 10)//전체페이지수
						let totalGroup = Math.ceil(totalPage / 5)//전체그룹수
						let nowGroup = Math.ceil(pageNum / 5) //현제그룹

						let viewBtn = 5


						if (nowGroup == totalGroup && totalPage % 5 != 0) {
							viewBtn = totalPage % 5
						}
						// console.log(totalPage + "전체페이지수");
						// console.log(totalGroup + '전체그룹수');
						// console.log(nowGroup + '현제그룹');
						// console.log(viewBtn + "지금 페이지 갯수");
						let preRoute = "?"
						if (category != null && search != null) {
							preRoute += "category=" + category + "&search=" + search + "&"
						}
						preRoute += "page=" + ((nowGroup - 1) * 5) + "'" + '"'
						let prevParam = 'onclick="location.href=' + "'" + preRoute + "'" + '"'
						pageBtnBiew = ""
						if (nowGroup == 1) {
							pageBtnBiew = "pageBtnBiew"
						}

						let pageAppend = '<div class="prev ' + pageBtnBiew + '"' + prevParam + '>&lt;</div>'

						for (let i = 0; i < viewBtn; i++) {
							let num = (i + 1) + 5 * (nowGroup - 1)
							let nowPage = ""
							let params = 'onclick="location.href='
							params += "'?"
							if (num == pageNum) {
								nowPage = "nowPage"
							}
							if (category != null && search != null) {
								params += "category=" + category + "&search=" + search + "&"
							}
							params += "page=" + num + "'" + '"'
							// if (num == 1) {
							// 	params = 'onclick="location.href=' + "'/'" + '"'
							// }

							// <div class="s" onclick="location.href='?ne=ne'">dd</div>
							pageAppend += '<div class="' + nowPage + '"' + params + '>' + num + '</div>'

						}
						preRoute = "?"
						if (category != null && search != null) {
							preRoute += "category=" + category + "&search=" + search + "&"
						}
						let nextnum = nowGroup * 5 + 1
						preRoute += "page=" + nextnum + "'" + '"'
						prevParam = 'onclick="location.href=' + "'" + preRoute + "'" + '"'

						pageBtnBiew = ""
						if (nowGroup == totalGroup) {
							pageBtnBiew = "pageBtnBiew"
						}
						pageAppend += '<div class="next ' + pageBtnBiew + '"' + prevParam + '>&gt;</div>'
						// pageAppend += '<div class="next">next</div>'

						$('.pageBox').append(pageAppend)
					}
				})

				$("#searchBtn").on("click", function () {
					if ($("#textbox").val().length != 0) {
						category = $("#category").val()
						search = $("#textbox").val()
						window.location.href = "?category=" + category + "&search=" + search + "&page=1"
						// $("#category").prop("selectedIndex", 3);
					}
				})
				$("#textbox").on("keydown", function (event) {
					if (event.key === "Enter" || event.keyCode === 13) {
						if ($("#textbox").val().length != 0) {
							category = $("#category").val()
							search = $("#textbox").val()
							window.location.href = "?category=" + category + "&search=" + search + "&page=1"
							// $("#category").prop("selectedIndex", 3);
						}
					}
				});
				$("#clearBtn").on("click", function () {
					window.location.href = "/"
				})
				$(".changeVal").on("click", function () {
					if (category != null && search != null) {
						$(".searchBtnWrap").removeClass("blind")
						$(".clearBtnWrap").addClass("blind")
					}
				})



			})
		</script>
	</body>

	</html>