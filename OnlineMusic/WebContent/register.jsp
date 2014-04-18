<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<%
boolean update = false;
if(request.getParameter("userName")!=null&&!request.getParameter("userName").equals("")){
	update = true;
	
}
%>
<html xmlns="http://www.w3.org/1999/xhtml"><head>
<!-- <META http-equiv=Content-Type content="text/html; charset=utf-8">
<META content="MSHTML 6.00.2900.3157" name=GENERATOR> -->
<script type="text/javascript" src="js/jquery-1.9.0.js"></script>
<script type="text/javascript" src="js/formly.js"></script>
<link rel="stylesheet" href="css/formly.css" type="text/css" /> 
<script type="text/javascript">
	$(document).ready(function(){
 		$('.niceform').formly({'theme':'Light'}, function(e) { 
			$('.callback').html(e);} ); 
/*  		$('#ContactInfo').formly({'theme':'Dark'}, function(e) { 
			$('.callback').html(e); 
		}); */
		$(function() {
			$('#kaptchaImage').click(
					function() {
						$(this).hide().attr('src',
								'kaptcha.jpg?' + Math.floor(Math.random() * 100)).fadeIn();
					});
		});
	});
	
	function myTime(i){
		if(i>=1){
			$("#btnCode").val(i + "秒后重新获取");
			setTimeout(function(){myTime(i-1);},1000);
		}else if(i==0){
			$("#btnCode").val("点击获取验证码");
			$("#btnCode").attr("disabled", false);
		}
	}
	
	function getVCode() {
		if ($("input[name='kaptcha']").val() == "") {
			alert("请输入验证码");
		}else if($("input[name='userPhone']").val() == ""){
			alert("请输入手机号");
		} 
		else {
            $("#btnCode").attr("disabled", true);
			$.ajax({
				type : "GET",
				url : "sendSMS.action?userPhone=" + $("input[name='userPhone']").val(),
				success : function(data){ alert("success");alert(data.state);},
				error : function(){ alert("error");}
			});
			myTime(5);
		}
	}
	
</script>
</HEAD>
<BODY>
<!--  <DIV style="TEXT-ALIGN: center"> -->
 
<form id="register" title="用户注册" class="niceform" action="register.action" width="400px" method="post">
    <input type="text" name="userName" require="true" label="用户名" place="用户名" size="30" />
    </br>
    <input type="text" name="email" require="true" label="Email address" validate="email" place="Email address" size="30" />
    <input type="text" name="kaptcha" require="true" label="图形验证码" size="30" place="图形验证码" />
    <input type="image" src="kaptcha.jpg" id="kaptchaImage" style="margin-left:10px;"/>
    <INPUT type="text" name="userPhone" require="true" label="手机号" place="手机号" size="30"  maxlength="11"/>
	
	<input type="button" id="btnCode" onclick="document.getElementById('div2').style.display='block';JavaScript:getVCode()" size="30" style="margin-left:10px;" value="获取短信验证码" />
	</br>
    <input type="text" id="div2" name="verifyCode" maxlength="5" size='4' require="true" label="手机验证码" style="display:none"/>
    <input type="password" name="userPwd" require="true" label="password" place="password" />
    <input type="password" name="confirmPwd" match="userPwd" place="Re-type password" />
    </br>
    <input type="checkbox" name="agree" require="true" label="Terms" value="agree" /> I agree to the terms
    <input id="Login" type="submit" value="注 册">
    <input id="Reset" type="reset" value="重置"> 
</form>

<!-- <form id="ContactInfo" width="600px" title="Member sign up">
<input type="text" name="first_name" place="Your first name" size="30" /> 
<input type="text" name="last_name" place="Your last name" size="30" style="margin-left:10px;" />
<input type="text" name="email" validate="email" place="Email address" size="30" />
<input type="text" name="website" place="Your website" size="30" pre-fix="http://" validate="http" style="margin-left:10px;" />
<select id="gender">
<option value="male">Male</option>
<option value="female">Female</option>
</select>
<input type="radio" name="membership" value="new" style="margin-left:10px;" /> New member
<input type="radio" name="membership" value="existing" /> Existing member

<input type="password" name="pword" require="true" label="Password" place="Password" />
<input type="password" name="pwordm" match="pword" label="Password" place="Re-type password" />
<input type="checkbox" name="agree" require="true" label="Terms" value="agree" /> I agree to the terms
<input type="submit" value="Sign up" /><input type="reset" value="Clear" />
</form> -->

 <!-- </DIV> -->
</body></html>
