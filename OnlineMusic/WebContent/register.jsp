<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD>
<META http-equiv=Content-Type content="text/html; charset=utf-8">
<META content="MSHTML 6.00.2900.3157" name=GENERATOR>
<script type="text/javascript" src="js/jquery.js"></script>
<script type="text/javascript" src="js/formly.js"></script>
<link rel="stylesheet" href="css/formly.css" type="text/css" /> 
<script type="text/javascript">
	$(document).ready(function(){
	$('#register').formly();
	$('.niceform').formly({'theme':'Light'});
	});
	$(function() {
		$('#kaptchaImage').click(
				function() {
					$(this).hide().attr('src',
							'kaptcha.jpg?' + Math.floor(Math.random() * 100)).fadeIn();
				});
	});

	function myTime(i){
		if(i>=1){
			$("#btnCode").val(i + "秒之后点击获取");
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
				url : "sendSMS.action",
				success : function(data){ alert("success");alert(data.state);},
				error : function(){ alert("error");}
			});
			myTime(5);
		}
	}
	
</script>
</HEAD>
<BODY>
<DIV style="TEXT-ALIGN: center">
<form id="register" class="niceform" action="register.action" method="post">
<TABLE style="MARGIN: 0px auto" cellSpacing=3 cellPadding=3 border=0>
  <TBODY>
  <TR>
    <TD colspan="2"><div align="center">用户注册</div></TD>
    </TR>
  <TR>
    <TD>&nbsp;</TD>
    <TD>&nbsp;</TD>
  </TR>
  <TR>
    <TD><LABEL>用户名：</LABEL> </TD>
    <TD><input type="text" name="userName" require="true" label="user name" place="用户名" maxlength="16"/></TD></TR>
  <TR>
    <TD><LABEL>用户密码：</LABEL> </TD>
    <TD><input type="password" name="userPwd" require="true" label="password" place="password" maxlength="16"/></TD>
  </TR>
  <TR>
    <TD><LABEL>确认密码：</LABEL> </TD>
    <TD><INPUT type="password" name="confirmPwd" require="true" match="userPwd" place="Re-type password" maxlength="16"/></TD>
  </TR>
  <TR>
    <TD><LABEL>Email：</LABEL> </TD>
    <TD><INPUT type="text" name="email" require="true" validate="email" place="Email address"/></TD></TR>
  <TR>
  <TR>
  	<TD><LABEL>验证码：</LABEL> </TD>
			<TD>
				<input type="text" name="kaptcha" require="true" value="" />
			</TD>
			<TD> 
				<img src="kaptcha.jpg" id="kaptchaImage" />
			</TD> 
			<!-- <input type="submit" name="submit" value="submit" /> -->
  </TR>		
  <TR>
    <TD><LABEL>手机号码：</LABEL> </TD>
    <TD><INPUT type="text" name="userPhone" require="true" maxlength="11"/></TD>
    <TD>
    	<div id="div1" >
		<input type="button" id="btnCode" onclick="document.getElementById('div2').style.display='block';JavaScript:getVCode()" value="获取短信验证码" />
		</div>
    </TD>
    <TD>
        <div id="div2" style="display:none">
    	<input type="text" name="verifyCode" maxlength="5" size='4' require="true" display='none'/>
    	</div>
    </TD>
  </TR>
  <TR>
<!--   <TR align=right>
    <TD colSpan=2>&nbsp;</TD>
  </TR> -->
  <TR align=right>
    <TD colSpan=2>
    <div align="center">
      <INPUT id=Login type=submit value="注 册">
      &nbsp;&nbsp;
      <INPUT id=Reset type=reset value="重置">
    </div>
    </TD></TR></TBODY></TABLE>
</form>
</DIV></BODY></HTML>
