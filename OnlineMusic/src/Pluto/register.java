package Pluto;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Calendar;

import org.apache.struts2.ServletActionContext;

import com.opensymphony.xwork2.ActionSupport;

public class register extends ActionSupport {
	private String userName = null;
	private String userPwd = null;
	private String confirmPwd = null;
	private String email = null;
	private String kaptcha = null;
	private String userPhone = null;
	private String verifyCode = null;
	
	public String getUserName() {
		return userName;
	}

	public void setUserName(String userName) {
		this.userName = userName;
	}

	public String getUserPwd() {
		return userPwd;
	}

	public void setUserPwd(String userPwd) {
		this.userPwd = userPwd;
	}

	public String getConfirmPwd() {
		return confirmPwd;
	}

	public void setConfirmPwd(String confirmPwd) {
		this.confirmPwd = confirmPwd;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getKaptcha() {
		return kaptcha;
	}

	public void setKaptcha(String kaptcha) {
		this.kaptcha = kaptcha;
	}

	public String getUserPhone() {
		return userPhone;
	}

	public void setUserPhone(String userPhone) {
		this.userPhone = userPhone;
	}

	public String getVerifyCode() {
		return verifyCode;
	}

	public void setVerifyCode(String verifyCode) {
		this.verifyCode = verifyCode;
	}

	public String execute() throws SQLException, IOException{
		ServletActionContext.getResponse().setCharacterEncoding("utf-8");
		PrintWriter out = ServletActionContext.getResponse().getWriter();
		ServletActionContext.getResponse().setHeader("Pragma", "No-cache");
		ServletActionContext.getResponse().setHeader("Cache-Control",
				"no-cache");
		ServletActionContext.getResponse().setDateHeader("Expires", 0);
		String kaptchaExpected = (String) ServletActionContext.getContext().getSession()
				.get(com.google.code.kaptcha.Constants.KAPTCHA_SESSION_KEY);
		if (!kaptcha.equals(kaptchaExpected)) {
			out.println(function.PlutoJump("验证码输入错误！", "register.jsp"));
		}else if (function.isInvalid(userName) || function.isInvalid(userPwd)
				|| function.isInvalid(confirmPwd)) {
			out.println(function.PlutoJump("用户名或密码输入错误！", "register.jsp"));
		}
		else if(!userPwd.equals(confirmPwd)){
			out.println(function.PlutoJump("两次输入的密码不一致！", "register.jsp"));
		}else{
		DBConnection conn = new DBConnection();
		ResultSet rs = conn.executeQuery("select * from user where name = '"+userName+"' or phone = '"+userPhone+"'");
		ResultSet rs1 = conn.executeQuery("select * from vcode where phone = '"+userPhone+"' and vcode = '" + verifyCode + "'");
		if(rs.next()){
			out.println(function.PlutoJump("用户名或手机号已存在！", "register.jsp"));
		}else if(rs1.next()){
		    long timeNow = Calendar.getInstance().getTimeInMillis();
		    java.sql.Timestamp ts = new java.sql.Timestamp(timeNow);
			if(timeNow-rs1.getTimestamp("creattime").getTime()>300000){
				out.println(function.PlutoJump("验证码已过期，请重新注册", "register.jsp"));
			}else{
			conn.executeUpdate("update vcode set updatetime='"+ts+"' where phone = '"+userPhone+"' and vcode = '" + verifyCode + "'");
			boolean insert = conn.execute("insert into user(name,pwd,email,phone) values('"+userName+"','"+function.MD5Encode(userPwd)+"','"+email+"','"+userPhone+"')");
			if(insert){
				out.println(function.PlutoComplete("注册成功，请登陆！"));
			}else{
				out.println(function.PlutoComplete("注册失败！"));
			}
			}
		}else{
			out.println(function.PlutoJump("验证码无效", "register.jsp"));
		}
		}
		return null;
	}
}
