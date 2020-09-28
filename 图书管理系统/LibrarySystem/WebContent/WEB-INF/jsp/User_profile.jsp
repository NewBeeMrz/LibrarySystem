<%@include file="/WEB-INF/User_header.jsp"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>图书管理系统</title>
<style type="text/css">
#list li {
	font-size: large;
	font-family: sans-serif;
}

.container {
	width: 75%
}
</style>
</head>
<body>
	<div id="page-wrapper">
		<div class="row">
			<div class="col-lg-12">
				<h1 class="page-header">个人中心</h1>
			</div>
		</div>
		<div class="container">
			<div class="jumbotron">
				<h2>${user.user_name }</h2>
				<hr class="my-4">
				<ul id="list">
					<li>用户编号：${user.user_id }</li>
					<li>用户名：${user.user_name }</li>
					<li>联系方式：${user.phonenum }</li>
					<li>年龄：${user.age }</li>
					<li>性别：${user.sex }</li>
				</ul>
				<div style="margin-left: 15px">
					<a><button type="button" class="btn btn-primary"
							data-toggle="modal" data-target="#userEditDialog"
							onclick="editUser()">编辑个人资料</button></a>
				</div>
			</div>
		</div>
	</div>

	<!-- 修改用户信息模态框 -->
	<div class="modal fade" id="userEditDialog" data-backdrop="static"
		tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
					<h4 class="modal-title" id="myModalLabel">修改用户信息</h4>
				</div>
				<div class="modal-body">
					<form class="form-horizontal" id="edit_user_form">
						<input type="hidden" id="edit_user_id" name="user_id" readonly />
						<div class="form-group" id="form_user">
							<label for="edit_userName"
								style="float: left; padding: 7px 15px 0 27px; margin-right: 14px">用户名</label>
							<div class="col-sm-10">
								<input type="text" class="form-control" id="edit_userName"
									placeholder="用户名称" name="user_name" required />
							</div>
						</div>
						<div class="form-group" id="form_user">
							<label for="edit_userPass"
								style="float: left; padding: 7px 15px 0 27px; margin-right: 28px">密码</label>
							<div class="col-sm-10">
								<input type="text" class="form-control" id="edit_userPass"
									name="password" required />
							</div>
						</div>
						<div class="form-group" id="form_user">
							<label for="edit_userphonenum"
								style="float: left; padding: 7px 15px 0 27px;">联系方式</label>
							<div class="col-sm-10">
								<input type="text" class="form-control" id="edit_userphonenum"
									placeholder="暂无联系方式" name="phonenum" />
							</div>
						</div>
						<div class="form-group" id="form_user">
							<label for="edit_userAge"
								style="float: left; padding: 7px 15px 0 27px; margin-right: 28px">年龄</label>
							<div class="col-sm-10">
								<input type=number class="form-control" id="edit_userAge"
									name="age" max=100 min=0 value=1 step=1 placeholder="未知" />
							</div>
						</div>
						<div class="form-group" id="form_user"
							style="text-align: justify;">
							<label
								style="float: left; padding: 7px 15px 0 27px; margin-right: 28px">性别</label>
							<div class="col-sm-10"
								style="margintop: auto 0; marginbottom: auto 0;">
								<input type="radio" id="edit_userSex1" name="sex" value="男" />男
								<input type="radio" id="edit_userSex2" name="sex" value="女" />女
							</div>
						</div>

						<div class="form-group" id="form_user">
							<label for="edit_userRank"
								style="float: left; padding: 7px 15px 0 27px; margin-right: 28px">权限</label>
							<div class="col-sm-10">
								<select class="form-control" id="edit_userRank" name="rank"
									style="background-color: #EEEEEE;" disabled="disabled">
									<option value="1">管理员</option>
									<option value="0">普通用户</option>
								</select>
							</div>
						</div>
					</form>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
					<button type="button" class="btn btn-primary"
						onclick="updateUser()">修改用户</button>
				</div>
			</div>
		</div>
	</div>
</body>
<script type="text/javascript">
//获取修改的个人信息
function editUser() {
	  $.ajax({
	        type:"get",
	        url:"<%=basePath%>user/getUser.action",
			data : {},
			success : function(data) {
				$("#edit_user_id").val(data.user_id);
				$("#edit_userName").val(data.user_name);
				$("#edit_userPass").val(data.password);
				$("#edit_userAge").val(data.age);
				$("#edit_userphonenum").val(data.phonenum);
				$("#edit_userRank").val(data.user_rank)
				if (data.sex == '男') {
					$("#edit_userSex1").prop("checked", true);
					$("#edit_userSex2").prop("checked", false);
				} else {
					$("#edit_userSex1").prop("checked", false);
					$("#edit_userSex2").prop("checked", true);
				}

			}
		});
	}
	// 执行修改用户操作
	function updateUser() {

		$.post("${pageContext.request.contextPath}/user/update.action", $(
				"#edit_user_form").serialize(), function(data) {
			if (data == "OK") {
				alert("用户信息更新成功！");
				window.location.reload();
			} else {
				alert("用户信息更新失败！");
				window.location.reload();
			}
		});
	}
</script>
</html>
<%@include file="/WEB-INF/footer.jsp"%>