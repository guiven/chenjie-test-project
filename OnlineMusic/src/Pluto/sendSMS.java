package Pluto;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.util.Calendar;

import javax.servlet.http.HttpServletResponse;

import org.apache.commons.httpclient.HttpClient;
import org.apache.commons.httpclient.HttpException;
import org.apache.commons.httpclient.NameValuePair;
import org.apache.commons.httpclient.methods.PostMethod;
import org.apache.struts2.ServletActionContext;
import org.dom4j.Document;
import org.dom4j.DocumentException;
import org.dom4j.DocumentHelper;
import org.dom4j.Element;

import com.opensymphony.xwork2.ActionSupport;

public class sendSMS extends ActionSupport {
	private String userPhone = null;
	private String verifyCode = null;
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
		
		HttpServletResponse response = ServletActionContext.getResponse();
		response.setCharacterEncoding("utf-8");
		response.setContentType("application/json; charset=UTF-8");
		PrintWriter out = response.getWriter();
		String msg = "{\"state\":\"" + "01" + "\"}";
		out.write(msg);
		String num = "";
	    for (int i = 0; i < 4; i++) {
	        num = num + (int)Math.floor(Math.random() * 10);
	    }
	    System.out.println(num);
	    long timeNow = Calendar.getInstance().getTimeInMillis();
	    java.sql.Timestamp ts = new java.sql.Timestamp(timeNow);
	    DBConnection conn = new DBConnection();
	    conn.execute("insert into vcode(phone,vcode,creattime) values('"+userPhone+"','"+ num +"','" + ts+"')");
/*		String Url = "http://106.ihuyi.com/webservice/sms.php?method=Submit";
		HttpClient client = new HttpClient(); 
		PostMethod method = new PostMethod(Url); 
			
		//client.getParams().setContentCharset("GBK");		
		client.getParams().setContentCharset("UTF-8");
		method.setRequestHeader("ContentType","application/x-www-form-urlencoded;charset=UTF-8");

	    String content = new String("您的验证码是：7528。请不要把验证码泄露给其他人。"); 
	    
		NameValuePair[] data = {//提交短信
			    new NameValuePair("account", "cf_guiven"), 
			    new NameValuePair("password", "890121"), 	//密码可以使用明文密码或使用32位MD5加密
			    new NameValuePair("mobile", "13916336841"), 
			    new NameValuePair("content", content),
		};
		
		method.setRequestBody(data);		
		
		
		try {
			client.executeMethod(method);	
			
			String SubmitResult =method.getResponseBodyAsString();
					
			//System.out.println(SubmitResult);

			Document doc = DocumentHelper.parseText(SubmitResult); 
			Element root = doc.getRootElement();


			String code = root.elementText("code");	
			String msg = root.elementText("msg");	
			String smsid = root.elementText("smsid");	
			
			
			System.out.println(code);
			System.out.println(msg);
			System.out.println(smsid);
			
			if(code == "2"){
				System.out.println("短信提交成功");
			}
			
		} catch (HttpException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (DocumentException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}*/
		
		System.out.println("test RUN");
		
		return null;
	}
	
}
