<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE HTML>
<html>
<head>
<title>注册页面</title>
<meta http-equiv=Content-Type content="text/html; charset=utf-8">
<link href="${pageContext.request.contextPath}/css/style.css"
	type=text/css rel=stylesheet>
<!-- Bootstrap Core CSS -->
<link href="${pageContext.request.contextPath}/css/bootstrap.min.css"
	rel="stylesheet" />
<script src="${pageContext.request.contextPath}/js/jquery-1.11.3.min.js">
	
</script>
</head>
<body>
	<fieldset style="width: 100%; margin: 0px auto;">
		<legend style="text-align: center">
			<font style="font-size: 40px" face="宋体"> 欢迎使用注册系统 </font>
		</legend>
	</fieldset>
	<form id="register_form" class="form-horizontal">
		<div class="container" style="width: 600px">
			<div>
				<p style="color: red; width: 100%; text-align: center" id="message">${msg}</p>
				<div class="form-group">
					<label for="new_Name" class="col-sm-2 control-label"> 用户名 </label>
					<div class="col-sm-10">
						<input type="text" class="form-control" id="new_userName"
							placeholder="请输入用户名" name="user_name" required />
					</div>
				</div>
				<div class="form-group">
					<label for="new_password" class="col-sm-2 control-label">密码</label>
					<div class="col-sm-10">
						<input type="password" class="form-control" id="new_password"
							placeholder="请输入密码" name="password" required />
					</div>
				</div>
				<div class="form-group">
					<label for="new_repassword" class="col-sm-2 control-label">确认密码</label>
					<div class="col-sm-10">
						<input type="password" class="form-control" id="new_repassword"
							placeholder="请再次确认密码" name="ord" />
					</div>
				</div>
				<div class="form-group">
					<label for="new_phonenum" class="col-sm-2 control-label">联系方式</label>
					<div class="col-sm-10">
						<input type="text" class="form-control" id="new_phonenum"
							placeholder="请输入联系方式（非必填）" name="nenum" />
					</div>
				</div>
				<div class="form-group">
					<label for="new_age" class="col-sm-2 control-label">年龄</label>
					<div class="col-sm-10">
						<input type="number" value="0" class="form-control" id="new_age"
							placeholder="请输入年龄（非必填）" name="age" />
					</div>
				</div>
				<div class="form-group">
					<label for="new_bookPress" class="col-sm-2 control-label">性别</label>
					<div class="col-sm-10">
						<input type="radio" id="edit_userSex1" name="sex" value="男"
							checked />男 <input type="radio" id="edit_userSex2" name="sex"
							value="女" />女
					</div>
				</div>
				<div class="form-group">
					<label for="new_userRank" class="col-sm-2 control-label">权限</label>
					<div class="col-sm-10">
						<select class="form-control" id="new_userRank" name="user_rank"
							style="background-color: #EEEEEE;" disabled="disabled">
							<option value="1">管理员</option>
							<option value="0" selected>普通用户</option>
						</select>
					</div>
				</div>
			</div>
		</div>
	</form>
	<div class="container" style="width: 20%">
		<button type="button" class="btn btn-primary" onclick="register()">注册</button>
		<a href="login.action"><button class="btn btn-danger">返回登录页面</button></a>
	</div>
</body>
<script type="text/javascript">
	// 判断是登录账号和密码是否为空
	function register() {
		var username = $("#new_userName").val();
		var password = $("#new_password").val();
		var repassword = $("#new_repassword").val();
		var phonenum  = $("#new_phonenum").val();
		var myreg=/^[1][3,4,5,7,8][0-9]{9}$/;
		$("#new_userRank").attr("disabled", false);//让select的disabled失效能够获取到值
		if (username == "" || password == "") {
			$("#message").text("账号或密码不能为空！");
			return false;
		}
		if (password != repassword) {
			$("#message").text("密码不一致，请重新输入！");
			return false;
		}
		if(phonenum != "" && !myreg.test(phonenum)){
			$("#message").text("手机号码不正确！");
			return false;
		}
		$.post("${pageContext.request.contextPath}/user/add.action", $("#register_form").serialize(), function(data) {
			if (data == "OK") {
				alert("用户注册成功！(确认后自动跳转至登录页面)");
				window.location.replace("${pageContext.request.contextPath}/return_login.action");
			} else {
				alert("用户注册失败，请重试！");
				window.location.reload();
			}
		});
	}
</script>
</html>
