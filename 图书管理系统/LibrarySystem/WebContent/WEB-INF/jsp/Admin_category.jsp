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
				<h1 class="page-header">图书分类管理</h1>
			</div>
			<!-- /.col-lg-12 -->
		</div>
		<!-- /.row -->
		<div class="panel panel-default">
			<div class="panel-body">
				<form class="form-inline" method="post" id="Search"
					action="${pageContext.request.contextPath }/admin/category_search.action">
					<div class="form-group">
						<label for="search_content">查询内容</label> 
						<input type="text" class="form-control" id="search_content" value="${search_content}" name="search_content" />
					</div>
					<button type="submit" class="btn btn-primary">查询</button>
					<button type="button" class="btn btn-primary" onclick="resetAll()">重置</button>
				</form>
			</div>
		</div>
		<div class="row">
			<div class="col-lg-12">
				<div>
					<a><button type="button" onclick="clearbook()"
							class="btn btn-primary" data-toggle="modal"
							data-target="#newcategoryDialog">新建</button></a>
				</div>
				<div class="panel panel-default">
					<div class="panel-heading">图书分类列表</div>
					<!-- /.panel-heading -->
					<table id="table" class="table table-bordered table-striped">
						<thead>
							<tr>
								<th scope="col">ID</th>
								<th scope="col">名称</th>
								<th scope="col">介绍</th>
								<th scope="col">操作</th>
							</tr>
						</thead>
						<tbody>
							<c:forEach items="${categorylist}" var="category">
								<tr>
									<td>${category.c_id}</td>
									<td>${category.c_name}</td>
									<td title="${category.intro}">${category.intro}</td>
									<th><a data-toggle="modal"
										data-target="#categoryEditDialog"
										onclick="editCategory(${category.c_id})"
										class="btn btn-primary btn-xs">修改分类</a><br />
										<hr /> <a onclick="deleteCategory(${category.c_id})"
										class="btn btn-danger btn-xs">删除分类</a></th>
								</tr>
							</c:forEach>
						</tbody>
					</table>
				</div>
				<!-- /.panel -->
			</div>
			<!-- /.col-lg-12 -->
		</div>
	</div>
	<!-- 分类列表查询部分  end-->
</body>
<!-- 创建分类模态框 -->
<div class="modal fade" id="newcategoryDialog" tabindex="-1"
	role="dialog" aria-labelledby="myModalLabel">
	<div class="modal-dialog" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal"
					aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
				<h4 class="modal-title" id="myModalLabel">新建分类信息</h4>
			</div>
			<div class="modal-body">
				<form class="form-horizontal" id="new_category_form">
					<p style="color: red; width: 100%; text-align: center" id="message">${msg}</p>
					<div class="form-group">
						<label for="new_categoryName" class="col-sm-2 control-label">
							分类名称 </label>
						<div class="col-sm-10">
							<input type="text" class="form-control" id="new_categoryName"
								placeholder="分类名称" name="c_name" required />
						</div>
					</div>
					<div class="form-group">
						<label for="new_intro" class="col-sm-2 control-label">介绍</label>
						<div class="col-sm-10">
							<input type="text" class="form-control" id="new_intro"
								placeholder="请输入分类介绍（非必填）" name="intro" />
						</div>
					</div>
				</form>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
				<button id="submitAdd" type="button" class="btn btn-primary"
					onclick="createcategory()">新建分类</button>
			</div>
		</div>
	</div>
</div>

<!-- 修改书籍分类信息模态框 -->
<div class="modal fade" id="categoryEditDialog" data-backdrop="static"
	tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
	<div class="modal-dialog" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal"
					aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
				<h4 class="modal-title" id="myModalLabel">修改分类信息</h4>
			</div>
			<div class="modal-body">
				<form class="form-horizontal" id="edit_category_form" method="post">
					<p style="color: red; width: 100%; text-align: center" id="msg">${msg}</p>
					<div class="form-group">
						<label for="edit_categoryID" class="col-sm-2 control-label">分类ID</label>
						<div class="col-sm-10">
							<input type="text" class="form-control" id="edit_categoryID"
								placeholder="分类ID" name="c_id" readonly />
						</div>
					</div>
					<div class="form-group" id="form_category">
						<label for="edit_categoryName" class="col-sm-2 control-label">分类名称</label>
						<div class="col-sm-10">
							<input type="text" class="form-control" id="edit_categoryName"
								placeholder="分类名称" name="c_name" />
						</div>
					</div>
					<div class="form-group">
						<label for="edit_intro" class="col-sm-2 control-label">介绍</label>
						<div class="col-sm-10">
							<input type="text" class="form-control" id="edit_intro"
								placeholder="未知" name="intro" />
						</div>
					</div>
				</form>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
				<button type="button" class="btn btn-primary"
					onclick="updateCategory()">修改分类</button>
			</div>
		</div>
	</div>
</div>
<script type="text/javascript">
//清空表单搜索框内容
function resetAll() {
	 $("#Search").find('input[type=text]').each(function() {
     $(this).val('');
    });
}

//清空新建分类窗口中的数据
function clearbook() {
	//清空模态框中from表单元素
	$('#new_category_form')[0].reset();
	//清空模态框中的文本域
	$('.w-e-text').html('');
	//清空提醒信息
	$("#message").text("");
}

//创建分类
function createcategory() {
var category_name = $("#new_categoryName").val();
if(category_name == null || category_name == ""){
	$("#message").text("分类名称不能为空！");
	return false
}

$.post("${pageContext.request.contextPath}/admin/category_careate.action",$("#new_category_form").serialize(),function(data){
		        if(data =="OK"){
		            alert("分类新建成功！");
		            window.location.reload();
		        }else{
		            alert("分类新建失败，请重试！");
		            window.location.reload();
		        }
		        
		    });
}

//删除分类
function deleteCategory(c_id){
	if(confirm('确定要删除该分类吗?')) {
		$.post("${pageContext.request.contextPath}/admin/category_delete.action",{'c_id':c_id},function(data){
	        if(data =="OK"){
	            alert("分类删除成功！");
	            window.location.reload();
	        }else{
	            alert("分类删除失败，请重试！");
	            window.location.reload();
	        } 
	    });
	}
}

//获取修改的分类信息
function editCategory(c_id) {
	  $.ajax({
	        type:"get",
	        url:"<%=basePath%>admin/getCategorybyID.action",
			data : {"c_id":c_id},
			success : function(data) {
				$("#edit_categoryID").val(data.c_id);
				$("#edit_categoryName").val(data.c_name);
				$("#edit_intro").val(data.intro);
			}
		});
	}

//执行修改分类操作
function updateCategory(){
	var c_name = $("#edit_categoryName").val();
	if(c_name == null || c_name == ""){
		$("#msg").text("分类名称不能为空！");
		return false
	}
	$.post("${pageContext.request.contextPath}/admin/category_update.action", $("#edit_category_form").serialize(), function(data) {
		if (data == "OK") {
			alert("分类信息更新成功！");
			window.location.reload();
		} else {
			alert("分类信息更新失败，请重试！");
			window.location.reload();
		}
	});
}
</script>
</html>
<%@include file="/WEB-INF/footer.jsp"%>