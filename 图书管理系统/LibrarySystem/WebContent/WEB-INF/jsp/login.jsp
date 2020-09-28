<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE HTML>
<html>
<head>
<title>登录页面</title>
<meta http-equiv=Content-Type content="text/html; charset=utf-8">
<link href="${pageContext.request.contextPath}/css/style.css"
	type=text/css rel=stylesheet>
<!-- Bootstrap Core CSS -->
<link href="${pageContext.request.contextPath}/css/bootstrap.min.css"
	rel="stylesheet" />
<script src="${pageContext.request.contextPath}/js/jquery-1.11.3.min.js">
	
</script>

<script>
	// 判断是登录账号和密码是否为空
	function check() {
		var username = $("#username").val();
		var password = $("#password").val();
		var rank = $("#rank option:selected").val();
		if (username == "" || password == "") {
			$("#message").text("账号或密码不能为空！");
			return false;
		}
		if (rank == "" || rank == null) {
			$("#message").text("登录身份不能为空！");
			return false;
		}
		$("form").submit();
	}
</script>
</head>
<body>
	<div ALIGN="center">
		<table border="0" width="100%" cellspacing="0" cellpadding="0"
			id="table1">
			<tr>
				<td height="93"></td>
				<td></td>
			</tr>
			<tr>

				<th class="login_msg" width="100%" align="center">
					<!-- margin:0px auto; 控制当前标签居中 -->
					<fieldset style="width: 100%; margin: 0px auto;">
						<legend style="text-align: center">
							<font style="font-size: 40px" face="宋体"> 欢迎使用图书管理系统 </font>
						</legend>
						<%-- 提交后的位置：/WEB-INF/jsp/customer.jsp--%>
						<form action="${pageContext.request.contextPath }/login.action"
							method="post" class="form-horizontal">
							&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<br />
							<br />

							<div class="container" style="width: 340px">
								<div style="width: 80%; margin: 0 auto">
									<%-- 提示信息--%>
									<p style="color: red; width: 100%; text-align: center"
										id="message">${msg}</p>
									<span>账&nbsp;号：<input id="username" type="text"
										name="username" /> <br />
									<br /> 密&nbsp;码：<input id="password" type="password"
										name="password" /> <br />
									<br /></span> <span> 身&nbsp;份： <select id="rank" name="rank">
											<option value="">--请选择--</option>
											<option value="0">普通用户</option>
											<option value="1">图书管理员</option>
									</select>
									</span>
								</div>
							</div>
						</form>
						<br />
						<br />
						<div class="container" style="width: 340px">
							<input type="button" value="登录" class="btn btn-success"
								onclick="check()" /> <a href="register.action"><button
									class="btn btn-danger">注册</button></a>
						</div>
					</fieldset>
				</th>
			</tr>
		</table>
	</div>
</body>
</html>
