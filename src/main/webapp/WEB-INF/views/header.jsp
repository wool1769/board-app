<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <!DOCTYPE html>
    <html>

    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>header</title>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
        <link rel="stylesheet" type="text/css" href="css/header.css">
    </head>

    <body>
        <div class="hdWrap">
            <div id="menuTogle" class="menuTogle blid">
                <span></span><span></span><span></span>
            </div>
            <h1><a href="/">BOARD</a></h1>
            <div class="menu">
                <!-- 디자인 끝나고 슬라이드 지우샘  -->
                <div class="menubox">

                    <%String grade=(String) session.getAttribute("grade"); if (grade !=null) { int
                        iGrade=Integer.valueOf(grade); if(iGrade==99){%>
                        <div>관리자</div>
                        <%}else if(iGrade==0){%>
                            <div onclick="location.href='/scrap'">SCRAP</div>
                            <div id="mypage">MYPAGE</div>
                            <%}}%>
                                <%String id=(String) session.getAttribute("id"); if (id==null) {%>
                                    <div id="loginBtn">LOGIN</div>
                                    <div class="loginModal blid">
                                        <div>
                                            <form id="loginForm">
                                                <div class="forminner">
                                                    <h3>Login</h3>
                                                    <div class="textBoxs">
                                                        <!-- <label for="id">사용자 이름:</label> -->
                                                        <input type="text" id="username" name="id" required
                                                            placeholder="아이디">
                                                        <!-- <label for="password">비밀번호:</label> -->
                                                        <input type="password" id="password" name="password" required
                                                            placeholder="비밀번호">
                                                    </div>
                                                    <div class="formBtns">
                                                        <input type="submit" value="로그인">
                                                        <button onclick="location.reload()">취소</button>
                                                    </div>
                                                    <div class="signUp" onclick="location.href='/signup'">회원가입</div>
                                                </div>
                                            </form>
                                        </div>
                                    </div>
                                    <%}else{%>

                                        <div id="logoutBtn" onclick="location.href='/logout'">LOGOUT</div>
                                        <%}%>

                </div>




            </div>
        </div>
        <script type="text/javascript">

            $(document).ready(function () {
                $("#mypage").on("click", () => {
                    location.href = "/mypage?userid=" + '<%= id %>'
                })

                $(loginForm).submit(function (event) {
                    event.preventDefault();

                    var username = $('#username').val();
                    var password = $('#password').val();
                    $.ajax({
                        type: "post",
                        url: "/login",
                        data: JSON.stringify({
                            "id": username,
                            "password": password
                        }),
                        contentType: 'application/json',
                        success: function (result) {
                            if (result) {
                                window.location.reload()
                                return
                            }
                            alert("로그인 정보를 확인하세요.");

                        },
                        error: function (a, b, c) {
                            alert(a + b + c);
                        }

                    })
                })


                $('#loginBtn').click(function () {
                    $('.loginModal').removeClass('blid')
                    setTimeout(() => {
                        if (confirm("확인 버튼을 누르시면 테스트 아이디로 바로 로그인됩니다.")) {
                            $.ajax({
                                type: "post",
                                url: "/login",
                                data: JSON.stringify({
                                    "id": "test",
                                    "password": "1234"
                                }),
                                contentType: 'application/json',
                                success: function (result) {
                                        window.location.reload()
                                        return
                                },
                                error: function (a, b, c) {
                                    alert(a + b + c);
                                }

                            })



                        }

                    }, 500);
                })
            })
            $('#menuTogle').click(function () {

                $('.menuTogle span:eq(0)').toggleClass('menuTogleSpan1')
                $('.menuTogle span:eq(1)').toggleClass('menuTogleSpan2')
                $('.menuTogle span:eq(2)').toggleClass('menuTogleSpan3')
                $('.menu').toggleClass('menuSlid')
                $('.loginModal').addClass('blid')

            })
        </script>
    </body>

    </html>