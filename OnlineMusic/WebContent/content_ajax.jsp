<%@ page language="java"
	import="java.util.*,java.sql.*,Pluto.function,java.util.Date,java.text.SimpleDateFormat;"
	pageEncoding="UTF-8"%>
<jsp:useBean id="conn" class="Pluto.DBConnection" scope="session" />
<div class="post">
	<h2>An Example of the JW Player</h2>
	<p class="meta">Below you see a simple embedded example of the JW Player.</p>
	<div class="entry">
	<p>
	<!-- START OF THE PLAYER EMBEDDING TO COPY-PASTE -->
	<object id="player" classid="clsid:D27CDB6E-AE6D-11cf-96B8-444553540000" name="player" width="574" height="350"> 
		<param name="movie" value="player/player.swf" /> 
		<param name="allowfullscreen" value="true" /> 
		<param name="allowscriptaccess" value="always" /> 
		<param name="flashvars" value="file=upload\video.mp4&image=images/preview.jpg" /> 
 		<embed 
			type="application/x-shockwave-flash"
			id="player2"
			name="player2"
			src="player/player.swf" 
			width="574" 
			height="350"
			allowscriptaccess="always" 
			allowfullscreen="true"
			flashvars="file=../upload/video.mp4&image=images/preview.jpg" /> 
	</object> 
	</p>
	</div>
</div>