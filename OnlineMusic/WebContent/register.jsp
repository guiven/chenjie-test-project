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
	$('.niceform').formly({'onBlur':false, 'theme':'Light'});
	});
	$(function() {
		$('#kaptchaImage').click(
				function() {
					$(this).hide().attr('src',
							'kaptcha.jpg?' + Math.floor(Math.random() * 100)).fadeIn();
				});
	});
	
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
    <TD><input type="text" name="userName" require="true" place="username" maxlength="16"/></TD></TR>
  <TR>
    <TD><LABEL>用户密码：</LABEL> </TD>
    <TD><input type="password" name="userPwd" require="true" place="password" maxlength="16"/></TD>
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
    <TD><INPUT type="text" name="userPhone" maxlength="11"/></TD>
    <TD>
		<input type="button" onclick=" " value="获取短信验证码">
    </TD>
  </TR> 
  <TR align=right>
    <TD colSpan=2>&nbsp;</TD>
  </TR>
  <TR align=right>
    <TD colSpan=2>
    <div align="center">
      <INPUT id=Login type=submit value="注 册">
      &nbsp;
      <INPUT  type="reset" onclick=tb_remove() value="取 消" />
    </div>
    </TD></TR></TBODY></TABLE>
</form>
</DIV></BODY></HTML>
