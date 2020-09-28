<%@include file="/WEB-INF/admin_header.jsp"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>图书管理系统</title>
</head>
<body>
	<div id="page-wrapper">
		<div class="row">
			<div class="col-lg-12">
				<h1 class="page-header">用户管理</h1>
			</div>
			<!-- /.col-lg-12 -->
		</div>
		<!-- /.row -->
		<div class="panel panel-default">
			<div class="panel-body">
				<form class="form-inline" method="get" id="Search"
					action="${pageContext.request.contextPath }/admin/search_user.action">
					<div class="form-group">
						<label for="search_content">查询内容</label> <input type="text"
							class="form-control" id="search_content"
							value="${search_content }" name="search_content" />
					</div>
					<div class="form-group">
						<label for="rankFrom">身份</label> <select class="form-control"
							id="rankFrom" name="rankSource">
							<option value="">--请选择--</option>
							<option value="0" ${user_rank == 0?'selected':'' }>普通用户</option>
							<option value="1" ${user_rank == 1?'selected':'' }>管理员</option>
						</select>
					</div>
					<button type="submit" class="btn btn-primary">查询</button>
					<button type="button" class="btn btn-primary" onclick="resetAll()">重置</button>
				</form>
			</div>
		</div>
		<div class="row">
			<div class="col-lg-12">
				<div>
					<a><button type="button" onclick="clearuser()"
							class="btn btn-primary" data-toggle="modal"
							data-target="#newuserDialog">新建</button></a>
				</div>
				<div class="panel panel-default">
					<div class="panel-heading">用户信息列表</div>
					<!-- /.panel-heading -->
					<table id="table" class="table table-bordered table-striped">
						<thead>
							<tr>
								<th scope="col">User_ID</th>
								<th scope="col">用户名</th>
								<th scope="col">密码</th>
								<th scope="col">联系方式</th>
								<th scope="col">年龄</th>
								<th scope="col">性别</th>
								<th scope="col">权限</th>
								<th scope="col">操作</th>
							</tr>
						</thead>
						<tbody>
							<c:forEach items="${page.rows}" var="row">
								<tr>
									<td>${row.user_id}</td>
									<td>${row.user_name}</td>
									<td>${row.password}</td>
									<td>${row.phonenum}</td>
									<td>${row.age}</td>
									<td>${row.sex}</td>
									<td>${row.user_rank == 0?'普通用户':'管理员'}</td>
									<th><a data-toggle="modal" data-target="#userEditDialog"
										onclick="editUser(${row.user_id})" class="btn btn-primary btn-xs">更新用户</a><br />
										<hr /> <a onclick="deleteUser(${row.user_id})"
										class="btn btn-danger btn-xs">删除用户</a></th>
								</tr>
							</c:forEach>
						</tbody>
					</table>
					<div class="col-md-12 text-right">
						<pagebar:page
							url="${pageContext.request.contextPath }/admin/userlist.action" />
					</div>
					<!-- /.panel-body -->
				</div>
				<!-- /.panel -->
			</div>
			<!-- /.col-lg-12 -->
		</div>
	</div>
	<!-- 用户列表查询部分  end-->
</body>
<!-- 新建用户模态框 -->
<div class="modal fade" id="newuserDialog" tabindex="-1" role="dialog"
	aria-labelledby="myModalLabel">
	<div class="modal-dialog" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal"
					aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
				<h4 class="modal-title" id="myModalLabel">新建用户信息</h4>
			</div>
			<div class="modal-body">
				<form class="form-horizontal" id="new_user_form" method="post">
					<p style="color: red; width: 100%; text-align: center" id="message">${msg}</p>
					<div class="form-group">
						<label for="new_userName" class="col-sm-2 control-label">
							用户名 </label>
						<div class="col-sm-10">
							<input type="text" class="form-control" id="new_userName"
								placeholder="请输入用户名" name="user_name" />
						</div>
					</div>
					
					<div class="form-group">
						<label for="new_password" class="col-sm-2 control-label">密码</label>
						<div class="col-sm-10">
							<input type="password" class="form-control" id="new_password"
								placeholder="请输入密码" name="password" />
						</div>
					</div>
					<div class="form-group">
						<label for="new_phonenum" class="col-sm-2 control-label">联系方式</label>
						<div class="col-sm-10">
							<input type="text" class="form-control" id="new_phonenum"
								placeholder="请输入联系方式（移动手机或者座机）" name="phonenum"/>
						</div>
					</div>
					<div class="form-group">
						<label for="new_age" class="col-sm-2 control-label">年龄</label>
						<div class="col-sm-10">
							<input type="number" value="0" min="0"
								class="form-control" id="new_age"
								name="age" />
						</div>
					</div>
					<div class="form-group">
						<label for="new_bookPosition" class="col-sm-2 control-label">性别</label>
						<div class="col-sm-10">
							<input type="radio" id="new_userSex1" name="sex" value="男" />男
							<input type="radio" id="new_userSex2" name="sex" value="女" />女
						</div>
					</div>
					<div class="form-group">
						<label for="new_userFrom"
							style="float: left; padding: 7px 15px 0 27px;">身份权限</label>
						<div class="col-sm-10">
							<select class="form-control" id="new_userFrom" name="user_rank">
								<option value="">--请选择--</option>
									<option value="0">普通用户</option>
									<option value="1">管理员</option>
							</select>
						</div>
					</div>
				</form>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
				<button id="submitAdd" type="button" class="btn btn-primary"
					onclick="createuser()">新建用户</button>
			</div>
		</div>
	</div>
</div>

<!-- 修改用户信息模态框 -->
<div class="modal fade" id="userEditDialog" data-backdrop="static" tabindex="-1" role="dialog"
	aria-labelledby="myModalLabel">
	<div class="modal-dialog" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
				<h4 class="modal-title" id="myModalLabel">修改用户信息</h4>
			</div>
			<div class="modal-body">
				<form class="form-horizontal" id="edit_user_form">
					<p style="color: red; width: 100%; text-align: center" id="msg">${message}</p>
                    <input type="hidden" id="edit_user_id" name="user_id"/>
					<div class="form-group" id="form_user">
						<label for="edit_userName" class="col-sm-2 control-label">用户名</label> 
						<div class="col-sm-10">
							<input type="text" class="form-control" id="edit_userName" placeholder="用户名" name="user_name"/>
						</div>
					</div>
					<div class="form-group" id="form_user">
						<label for="edit_userPass" class="col-sm-2 control-label">密码</label> 
						<div class="col-sm-10">
							<input type="text" class="form-control" id="edit_userPass" name="user_pass"/>
						</div>
					</div>
					<div class="form-group" id="form_user">
						<label for="edit_phonenum" class="col-sm-2 control-label">联系方式</label> 
						<div class="col-sm-10">
							<input type="text" class="form-control" id="edit_phonenum" placeholder="暂无" name="phonenum"/>
						</div>
					</div>
					<div class="form-group" id="form_user">
						<label for="edit_age" class="col-sm-2 control-label">年龄</label> 
						<div class="col-sm-10">
							<input type=number class="form-control" id="edit_age" name="age" max=100 min=0 value=1 step=1 placeholder="未知"/>
						</div>
					</div>
					<div class="form-group" id="form_user" style="text-align:justify;">
						<label   class="col-sm-2 control-label">性别</label> 
							<div class="col-sm-10" style="margintop:auto 0;marginbottom:auto 0;">
							<input type="radio" id="edit_userSex1"  name="sex" value="男"/>男&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
							<input type="radio" id="edit_userSex2"   name="sex" value="女"/>女
							</div>
					</div>
					<div class="form-group" id="form_user">
						<label for="edit_userRank" class="col-sm-2 control-label">身份权限</label> 
						<div class="col-sm-10">
							<select	class="form-control" id="edit_userRank" name="user_rank">
								<option value="0">
								普通用户								
								</option>
								<option value="1">
								管理员								
								</option>
							</select>
						</div>
					</div>
				</form>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
				<button type="button" class="btn btn-primary" onclick="updateUser()">修改用户</button>
			</div>
		</div>
	</div>
</div>
<script type="text/javascript">
//清空表单搜索框内容
function resetAll() {
	 $("#Search").find('input[type=text],select').each(function() {
     $(this).val('');
    });
}

//清空新建用户窗口中的数据
function clearuser() {
	//清空模态框中from表单元素
	$('#new_user_form')[0].reset();
	//清空模态框中的文本域
	$('.w-e-text').html('');
	//清空提醒信息
	$("#message").text("");
}

//创建用户
function createuser() {
var user_name = $("#new_userName").val();
var password = $("#new_password").val();
var user_rank = $("#new_userFrom option:selected").val();
var age = $("#new_age").val();
var phonenum = $("#new_phonenum").val();
var myreg=/^[1][3,4,5,7,8][0-9]{9}$/;

if(phonenum != "" && !myreg.test(phonenum)){
	$("#message").text("手机号码不正确！");
	return false;
}
if(user_name == null || user_name == ""){
	$("#message").text("用户名不能为空！");
	return false
}
if(password == null || password == ""){
	$("#message").text("密码不能为空！");
	return false
}
if(user_rank == null || user_rank == ""){
	$("#message").text("身份权限不能为空！");
	return false
}
if(age == null || age == ""){
	$("#message").text("年龄不能为空！");
	return false
}
$.post("${pageContext.request.contextPath}/admin/user_careate.action",$("#new_user_form").serialize(),function(data){
		        if(data =="OK"){
		            alert("用户新建成功！");
		            window.location.reload();
		        }else{
		            alert("用户新建失败，请重试！");
		            window.location.reload();
		        }
		        
		    });
}
//通过id获取修改的用户信息
function editUser(user_id) {
	  $.ajax({
	        type:"get",
	        url:"<%=basePath%>admin/getUserById.action",
	        data:{"user_id":user_id},
	        success:function(data) {
	        	$("#edit_user_id").val(data.user_id);
	            $("#edit_userName").val(data.user_name);
	            $("#edit_userPass").val(data.password);
	            $("#edit_age").val(data.age);
	            $("#edit_phonenum").val(data.phonenum);
	            $("#edit_userRank").val(data.user_rank);
	            if(data.sex == "男"){
	            	$("#edit_userSex1").prop("checked",true);
	            	$("#edit_userSex2").prop("checked",false);
	            }else{
	            	$("#edit_userSex1").prop("checked",false);
	            	$("#edit_userSex2").prop("checked",true);
	            }
	            
	        }
	    });
}
// 执行修改用户操作
function updateUser() {
	var phonenum = $("#edit_phonenum").val();
	var myreg=/^[1][3,4,5,7,8][0-9]{9}$/;
	
	if(phonenum != "" && !myreg.test(phonenum)){
		$("#msg").text("手机号码不正确！");
		return false;
	}
	
	$.post("${pageContext.request.contextPath}/admin/user_update.action",$("#edit_user_form").serialize(),function(data){
		if(data =="OK"){
			alert("用户信息更新成功！");
			window.location.reload();
		}else{
			alert("用户信息更新失败！");
			window.location.reload();
		}
	});
}

function deleteUser(user_id) {
    if(confirm('确定要删除该书籍吗?')) {
$.post("${pageContext.request.contextPath}/admin/user_delete.action",{"user_id":user_id},
function(data){//回调函数
            if(data =="OK"){
                alert("用户删除成功！");
                window.location.reload();
            }else{
                alert("用户删除失败！");
                window.location.reload();
            }
        });
    }
}
</script>
</html>
<%@include file="/WEB-INF/footer.jsp"%>