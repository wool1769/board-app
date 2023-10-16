<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
	<!DOCTYPE html>
	<html>

	<head>
		<meta charset="UTF-8">
		<!-- <meta name="viewport" content="width=device-width, initial-scale=1"> -->
		<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no">
		<title>게시판</title>
		<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
		<link rel="stylesheet" type="text/css" href="css/signup.css">
	</head>

	<body>
		<% String userId=(String) session.getAttribute("id"); %>
			<div class="wrap">
				<header>
					<%@ include file="header.jsp" %>
				</header>
				<div class="headerFill"></div>
				<section class="signUpSection">
					<%if(userId==null){ %>
						<h3>회원가입</h3>
						<% }else{%>
							<h3>회원정보</h3>
							<%} %>
								<!-- <h3>회원정보</h3>
				<h3>회원가입</h3> -->
								<div class="signUpBox">
									<div>
										<p>아이디</p>
										<%if(userId==null){ %><input type="text" id="signupId">
											<% }else{%>
												<input type="text" id="signupId" readonly>
												<%} %>

									</div>


									<%if(userId!=null){%>
										<div>
											<p>기존비밀번호</p>
											<input type="password" id="nowPw">
										</div>
										<%}%>
											<div>
												<p>비밀번호</p>
												<input type="password" id="signupPw">
											</div>
											<div>
												<p>비밀번호 확인</p>
												<input type="password" id="signupPw2">
											</div>
											<div>
												<p>주소</p>
												<input type="text" id="addr1" name="address" readonly />
											</div>
											<div>
												<p>상세주소</p>
												<input type="text" id="addr2" name="address_detail" />
											</div>
											<div>
												<p>이메일</p>
												<input type="text" id="signUpemail">
											</div>
								</div>
								<div class="signUpBtn">회원가입</div>
				</section>
			</div>



			<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
			<script>
				document.getElementById("addr1").addEventListener("click", function () { //주소입력칸을 클릭하면
					//카카오 지도 발생
					new daum.Postcode({
						oncomplete: function (data) { //선택시 입력값 세팅
							document.getElementById("addr1").value = data.address; // 주소 넣기
							document.querySelector("input[name=address_detail]").focus(); //상세입력 포커싱
						}
					}).open();
				});
			</script>
			<script>
				$(document).ready(function () {

					const params = new URLSearchParams(location.search);
					let userid = params.get('userid')
					$.ajax({
						type: 'get',
						url: "/memberdata?id=" + userid,
						dataType: 'json',
						success: function (data) {
							console.log(data)
							if ("<%=userId%>" != "null") {
								$(".signUpBtn").text("수정")
								$("#signupId").val(data.id);
								$("#addr1").val(data.address1);
								$("#addr2").val(data.address2);
								$("#signUpemail").val(data.email);
							}

							if ("<%=userId%>" != data.id) {
								location.href = "/"

							}

						}
					})

					var idregExp = /^[a-z]+[a-z0-9]{5,19}$/g;
					var pwregExp = /^(?=.*\d)(?=.*[a-zA-Z])[0-9a-zA-Z]{8,16}$/;
					var emailregExp = /^[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*\.[a-zA-Z]{2,3}$/i;


					$(".signUpBtn").on("click", function () {
						let idval = $("#signupId").val();
						let pw1val = $("#signupPw").val();
						let pw2val = $("#signupPw2").val();
						let addr1val = $("#addr1").val();
						let addr2val = $("#addr2").val();
						let emailval = $("#signUpemail").val();
						if (
							idval.length == 0 ||
							pw1val.length == 0 ||
							pw2val.length == 0 ||
							addr1val.length == 0 ||
							addr2val.length == 0 ||
							emailval.length == 0
						) {
							alert("모두 작성해주세요.")
							return
						}
						if (!(idregExp.test(idval))) {
							alert("아이디를 확인해 주세요.(영문자로 시작하는 영문자 또는 숫자 6~20자)")
							return
						}
						if (pw1val != pw2val || !(pwregExp.test(pw1val))) {
							alert("비밀번호와 비밀번확인을 같게 작성하세요.\n(비밀번호는8 ~ 16자 영문, 숫자 조합)")
							return
						}
						if (!(emailregExp.test(emailval))) {
							alert("이메일을 확인하세요.")
							return
						}

						let type = "post"
						let url = "/memberjoin"
						let data = {
							"id": idval,
							"password": pw1val,
							"address1": addr1val,
							"address2": addr2val,
							"email": emailval
						}
						let message = "가입이 완료되었습니다."
						let message2 = "중복된 아이디 입니다."
						// if ("<%=userId%>" != null) {
						// 	type = "put"
						// 	url = "/userupdate"
						// 	data = {
						// 		"id": idval,
						// 		"password": $("#nowPw").val(),
						// 		"address1": addr1val,
						// 		"address2": addr2val,
						// 		"email": emailval,
						// 		"updatepw": pw1val
						// 	}
						// 	message="수정완료"
						// 	message2 = "비번이 틀렸어요."
						// }
						if ("<%=userId%>" == "null") {
							$.ajax({
								type: "post",
								url: "/memberjoin",
								data: JSON.stringify({
									"id": idval,
									"password": pw1val,
									"address1": addr1val,
									"address2": addr2val,
									"email": emailval
								}),
								contentType: 'application/json',
								success: function (result) {
									if (result) {
										alert("가입이 완료되었습니다.")
										location.href = "/"
									} else {
										alert("중복된 아이디 입니다.")
									}

								},
								error: function (a, b, c) {
									alert(a + b + c);
								}

							})

						} else {
							$.ajax({
								type: "put",
								url: "/userupdate",
								data: JSON.stringify({
									"id": idval,
									"password": $("#nowPw").val(),
									
									"address1": addr1val,
									"address2": addr2val,
									"email": emailval,
									"updatepw": pw1val
								}),
								contentType: 'application/json',
								success: function (result) {
									if (result) {
										alert("변경되었다.")
										location.href = "/"
									} else {
										alert("비밀번호가 틀렸다.")
									}

								},
								error: function (a, b, c) {
									alert(a + b + c);
								}

							})
						}



					})




				})
			</script>
	</body>

	</html>