<%@ page language="java" import="java.util.*,java.sql.*,Pluto.function"
	pageEncoding="UTF-8"%>
<jsp:useBean id="conn" class="Pluto.DBConnection" scope="session" />
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<title>OnlineCamera</title>
		<meta name="keywords" content="" />
		<meta name="description" content="" />
		<script type="text/javascript" src="js/jquery-1.9.0.js"></script>
		<script type="text/javascript" src="js/formly.js"></script>
		<script type="text/javascript" src="js/jquery.colorbox-min.js"></script>
		<script type="text/javascript" src="js/audioplayer.js"></script>
		<link href="css/default.css" rel="stylesheet" type="text/css" />
		<link href="css/page.css" rel="stylesheet" type="text/css" />
		<!-- <link href="css/thickbox.css" rel="stylesheet" type="text/css" /> -->
		<link rel="stylesheet" href="css/LoadingStatus.css" type="text/css" />
		<link rel="stylesheet" href="css/formly.css" type="text/css" />
		<link rel="stylesheet" href="css/colorbox.css" type="text/css" />
		<script type="text/javascript">
			$(document).ready(function(){
			$(".iframe").colorbox({iframe:true, innerWidth:590, innerHeight:525});
			$('.niceform').formly({'onBlur':false, 'theme':'Light'});
			dopage('index_ajax.jsp?page=1');
		});

		function dopage(ajaxurl){
			$('#LoadingStatus').show();
			$.ajax({url: ajaxurl,
			type: 'GET',
			dataType: 'html',
			timeout: 30000,
			async : false,
			error: function(){$('#content').html('<table  width="50%" border="0" align="center"> <tr> <td class="center_article" align="center">获取文章失败，请刷新此页面！！！</td></tr></table>');$('#LoadingStatus').hide(500);
			},
			success: function(html){
				//window.location="#article_md";
				$('#LoadingStatus').hide(1000);
				$('#content').html(html);
			}
			});
		}
		
		function addbox(music_id){
			$.ajax({url: 'addtobox.action?music_id=' + music_id,
			type: 'GET',
			dataType: 'html',
			timeout: 30000,
			async : false,
			error: function(){
				alert("出现错误！");
			},
			success: function(html){
				//window.location="#article_md";
				alert(html);
			}
			});
		}
		
		</script>
	</head>
	<body>
		<div id="header">
			<div id="logo">
				<h1>
					OnlineCamera
				</h1>
				<h2>
					
				</h2>
			</div>
			<div id="menu">
				<ul>
					<li class="active">
						<a href="index.jsp" accesskey="1" title="">首页</a>
					</li>
					<li>
						<a href="musicbox.jsp" accesskey="2" title="">音乐盒</a>
					</li>
					<li>
						<a href="message.jsp" accesskey="3" title="">短消息</a>
					</li>
					<li>
						<a href="uploadmusic.jsp" accesskey="3" title="">分享歌曲</a>
					</li>
					<li>
						<a href="player" accesskey="4" title="">播放列表</a>
					</li>
				</ul>
			</div>
		</div>
		<div id="LoadingStatus">
			<img src="images/ajax-loader.gif" />
		</div>
		<hr />
		<div id="page">

			<div id="bg">
				<a name="article_md"></a>

				<div id="content">

				</div>
				<!-- end contentn -->
				<div id="sidebar">
					<div id="about-box" style="font-size: 12px">
						<p>
							<%
								if (session.getAttribute("PlutoUser") == null) {
							%>
						</p>
						
						<form action="login.action" title="Sign up" subtitle="for exclusive beta access" width=230 method="post" class="niceform">

							<input type="text" id="textinput" name="userName" place="用户名" require="true"/>

							<input type="password" id="passwordinput" name="userPwd" require="true" label="Password" place="密码" />
							<br />
							<br />
							&nbsp;&nbsp;&nbsp;&nbsp;
<!-- 							<a href="register.jsp?height=400&width=475&modal=true"
								class="thickbox" title="我要注册">我要注册</a> -->
							<a class='iframe' href="register.jsp">我要注册</a>
							&nbsp;&nbsp;
							<input type="submit" value="登  陆" />
						</form>
						  
						<p></p>
						<%
							} else {
						%>
						<p>
							<%=session.getAttribute("PlutoUser").toString()%>，欢迎您回来！
						</p>
						<%
							String userName = session.getAttribute("PlutoUser").toString();
								ResultSet user_rs = conn
										.executeQuery("select id from user where name = '"
												+ userName + "'");
								user_rs.next();
								String id = user_rs.getString("id");
								ResultSet message_rs = conn
										.executeQuery("select count(id) as count from message where `to` ="
												+ id + " and `new` = 1");
								message_rs.next();
								int myMessage = message_rs.getInt("count");
						%>
						<p>
							您有<%=(myMessage==0)?(myMessage):("<font color=red><strong>" + myMessage + "</strong></font>")%>封未读短消息，请
							<a href="message.jsp" style="color: red">查看</a>！
							<br />
							播放我上次创建的
							<a href="player" style="color: red">[播放列表]</a>！
							<br />
							如果您有音乐分享，您可以点我进行
							<a href="uploadmusic.jsp" style="color: red">[上传音乐]</a>！
							<br />
						</p>
						<p>
							退出请点
							<a href="logout.action" style="color: #FF0000">[注销登陆]</a>！
						</p>
						<%
							}
						%>
					</div>
					<ul>
						<li>
							<h2>
								最新消息
							</h2>
							<ul>
								<%
									ResultSet tip_rs = conn
											.executeQuery("SELECT * FROM `tip` ORDER BY id DESC LIMIT 10");
									while (tip_rs.next()) {
										String tip = tip_rs.getString("value");
										out.println("<li>");
										out.println(tip);
										out.println("</li>");
									}
								%>

							</ul>
						</li>
						<li>
							<h2>
								友情链接
							</h2>
							<ul>
								<%
									ResultSet link_rs = conn
											.executeQuery("SELECT * FROM `link` ORDER BY id DESC LIMIT 20");
									while (link_rs.next()) {
										String link_title = link_rs.getString("title");
										String link_value = link_rs.getString("value");
										out.println("<li>");
										out.println("<a href=\""+link_value+"\">");
										out.println(link_title+"</a>");
										out.println("</li>");
									}
								%>
							</ul>
						</li>
					</ul>
				</div>
				<!-- end sidebar -->
				<div style="clear: both;">
					&nbsp;
				</div>
			</div>
		</div>
		<!-- end page -->
		<hr />
		<div id="footer">
			<p>
				(c) 2013 onlinemusic
			</p>
		</div>
</body>
</html>
