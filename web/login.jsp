<%-- 
    Document   : index
    Created on : Jun 13, 2019, 4:29:51 PM
    Author     : Wattana
--%>

<%@page import="com.br.api.app.Utility"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>


<html>
    <%
//        String userAgent = request.getHeader("user-agent");
//        if (userAgent.indexOf("MSIE") > -1) {
//            out.println("Your browser is Microsoft Internet Explorer<br/>");
//        } else {
//            out.println(userAgent);
//        }

// response.sendRedirect("http://192.200.9.189:8080/UserRequest/login.jsp");
        String namereq = request.getParameter("namereq");
        session.setAttribute("namereq", namereq);

        String msg2 = request.getParameter("msg2");
        session.setAttribute("msg2", msg2);
    %>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <link rel="stylesheet" type="text/css" href="assets/Bootstrap-3.3.7/css/bootstrap.min.css"/>
        <link rel="stylesheet" type="text/css" href="fonts/font-awesome-4.7.0/css/font-awesome.min.css">
        <link rel="stylesheet" type="text/css" href="fonts/iconic/css/material-design-iconic-font.min.css">
        <link rel="stylesheet" type="text/css" href="assets/animate/animate.css">
        <link rel="stylesheet" type="text/css" href="assets/css-hamburgers/hamburgers.min.css">
        <link rel="stylesheet" type="text/css" href="assets/animsition/css/animsition.min.css">
        <link rel="stylesheet" type="text/css" href="assets/select2/select2.min.css">
        <link rel="stylesheet" type="text/css" href="assets/util.css">
        <link rel="stylesheet" type="text/css" href="assets/main.css">
        <script type="text/javascript" src="assets/jQuery-3.3.1/jquery-3.3.1.min.js"></script>
        <script type="text/javascript" src="assets/Bootstrap-3.3.7/js/bootstrap.min.js"></script>
        <script src="assets/animsition/js/animsition.min.js"></script>
        <script src="assets/Bootstrap-3.3.7/js/popper.js"></script>
        <script src="assets/Bootstrap-3.3.7/js/bootstrap.min.js"></script>
        <script src="assets/select2/select2.min.js"></script>
        <script src="assets/countdowntime/countdowntime.js"></script>
        <script src="assets/main.js"></script>
        <title>User Request</title>
        <link rel="icon" type="image/ico" href="images/user-icon-vector.jpg" />
    </head>

    <style>
        .center {
            display: block;
            margin-left: auto;
            margin-right: auto;
        }

    </style>
    <body>
        <div class="limiter"> 
            <div class="container-login100">
                <div class="wrap-login100">                 
                    <form class="login100-form validate-form" action="Login" method="POST">
                        <img src="images/duck.jpg" class="center" width="180" height="180" alt="duck"/>          
                        <br><br>
                        <h4 class="text-center" style="color: blue">User Request</h4>
                        <input value="${msg2}" type="text" id="ChangePW" hidden="true">
                        <br>
                        <div class="wrap-input100 validate-input">
                            <input class="input100" type="text" name="username" id="vUsername" placeholder="Username" value="">
                        </div>
                        <div class="wrap-input100 validate-input">
                            <input class="input100" type="password" name="password" id="vPassword" placeholder="Password">
                        </div>
                        <h4 style="color: red;font-size: 16px;font-weight: bold;">${msg}</h4>
                        <!--<div class="row container col-md-12" style="font-size: 13px; width: 280px;">-->
                            <!--<div style="width: 140px;">-->
                                <!--<lable>Change Password</lable>-->       
                                <!--<a href="http://192.200.9.189:8080/UserRequest/?Destination=RequestUser"><li style="color: blue;"><u>Sign-Up</u></li></a>-->  
<!--                               <a href="http://localhost:8080/UserRequest/?Destination=RequestUser"><li style="color: blue;"><u>Sign-Up</u></li></a>  -->

                            <!--</div>-->  
                        <!--</div>-->
                        <!--<div class="row container col-md-12" style="font-size: 13px; width: 280px;">-->
                            <!--<div style="width: 140px;">-->
                                <!--<a href="http://192.200.9.189:8080/UserRequest/?Destination=ChangePW"><li style="color: blue;"><u>Change Password</u></li></a>-->  
                            <!--</div>-->  
                        <!--</div>-->
                         <div class="row container col-md-12" style="font-size: 13px; width: 280px;">
                            <div style="width: 140px;">
                                <a href="http://192.200.9.189:8080/UserRequest/?Destination=PResetPW"><li style="color: blue;"><u>Reset Password</u></li></a>  
                                <!--<a href="http://localhost:8080/UserRequest/?Destination=PResetPW"><li style="color: blue;"><u>Reset Password</u></li></a>-->  
                                <!--<a href="http://localhost:8080/UserRequest/?Destination=ChangePW"><li style="color: blue;"><u>Reset Password</u></li></a>-->  
                            </div>  
                        </div>
                        <div class="row container col-md-12" style="font-size: 13px; width: 280px;">
                            <div style="width: 140px;">
                                <a href="#" onclick="window.open('http://192.200.9.189:8080/UserRequest/คู่มือ.pdf', '_blank', 'fullscreen=yes'); return true;" ><li style="color: blue;"><u>คู่มือ</u></li></a>        
                            </div>  
                        </div>

                        <div class="container-login100-form-btn">
                            <button  class="btn btn-danger btn-lg btn-block" id="Login" type="submit" name="Login" value="Login">Login</button>                          
                        </div>
                    </form> 
                    <button hidden="true" onclick="window.open('http://192.200.9.189:8080/UserRequest/?Destination=ChangePW')" id="go">Continue</button>
                </div>
            </div>
        </div>
        <!--http://localhost:8080/UserRequest/?page=RequestUser-->
        <!--http://192.200.9.189:8080/UserRequest/login.jsp-->
    </body>


    <script>

       

        $(document).ready(function () {
        <% System.out.println("Path : " + request.getContextPath());%>
           
            var msg2 = $("#ChangePW").val();
            if (msg2 === "ChangePW") {
                $("#go").click();
            }

            if (navigator.userAgent.indexOf("Chrome") !== -1)
            {
                document.getElementById("Login").disabled = false;
            } else {
                $("#Login").css('background-color', '#949691');
                alert("Programs not support in Internet Explorer. \nPlease open in Google Chrome.");
            }
           

        });



        $('#vUsername').on('input', function (evt) {
            $(this).val(function (_, val) {
                return val.toUpperCase();
            });
        });

    </script>
</html>