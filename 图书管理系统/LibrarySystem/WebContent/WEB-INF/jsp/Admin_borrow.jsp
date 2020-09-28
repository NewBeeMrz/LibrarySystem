<%@include  file="/WEB-INF/admin_header.jsp"%>
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
				<h1 class="page-header">借阅记录</h1>
			</div>
			<!-- /.col-lg-12 -->
		</div>
		<!-- /.row -->
		<div class="panel panel-default">
			<div class="panel-body">
				<form class="form-inline" method="get" id="Search"
					action="${pageContext.request.contextPath }/admin/search_borrow.action">
					<div class="form-group">
						<label for="search_content">查询内容</label> <input type="text"
							class="form-control" id="search_content" value="${search_content }"
							name="search_content" />
					</div>
					<div class="form-group">
						<label for="search_date">日期</label> <input type="date"
							class="form-control" id="search_date" value="${time }"
							name="search_date" />
					</div>
					<div class="form-group">
						<label for="statusFrom">借阅状态</label> <select class="form-control"
							id="statusFrom" name="statusSource">
							<option value="">--请选择--</option>
							<option value="未归还" ${status eq '未归还'?'selected':'' }>未归还</option>
							<option value="已归还" ${status eq '已归还'?'selected':'' }>已归还</option>
						</select>
					</div>
					<button type="submit" class="btn btn-primary">查询</button>
					<button type="button" class="btn btn-primary" onclick="resetAll()">重置</button>
				</form>
			</div>
		</div>

		<div>
			<p style="color: red">${msg}</p>
		</div>

		<div class="row">
			<div class="col-lg-12">
				<div>
					<a><button type="button" onclick="clearborrow()"
							class="btn btn-primary" data-toggle="modal"
							data-target="#newborrowDialog">借书</button></a>
				</div>
				<div class="panel panel-default">
					<div class="panel-heading">借阅信息列表</div>
					<!-- /.panel-heading -->
					<table id="table" class="table table-bordered table-striped">
						<thead>
							<tr>
								<th scope="col">书籍名称</th>
								<th scope="col">借阅人</th>
								<th scope="col">借阅时间</th>
								<th scope="col">归还时间</th>
								<th scope="col">状态</th>
								<th scope="col">操作</th>
							</tr>
						</thead>
						<tbody>
							<c:forEach items="${page.rows}" var="row">
								<tr>
									<td>${row.book_name}</td>
									<td>${row.user_name}</td>
									<td>${row.borrow_date}</td>
									<td>${row.return_date}</td>
									<td>${row.status}</td>
									<td>
									<button type="button" class="btn btn-primary" onclick="returnBook(${row.user_id},${row.book_id })" ${row.status eq '已归还'?'disabled="disabled"':''}>还书</button>
									</td>
								</tr>
							</c:forEach>
						</tbody>
					</table>
					<div class="col-md-12 text-right">
						<pagebar:page
							url="${pageContext.request.contextPath }/admin/borrowlist.action" />
					</div>
					<!-- /.panel-body -->
				</div>
				<!-- /.panel -->
			</div>
			<!-- /.col-lg-12 -->
		</div>
	</div>
	<!-- 借阅列表查询部分  end-->
</body>
<!-- 新建借阅记录模态框 -->
<div class="modal fade" id="newborrowDialog" tabindex="-1" role="dialog"
	aria-labelledby="myModalLabel">
	<div class="modal-dialog" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal"
					aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
				<h4 class="modal-title" id="myModalLabel">新建借阅信息</h4>
			</div>
			<div class="modal-body">
				<form class="form-horizontal" id="new_borrowtable_form" method="post">
					<p style="color: red; width: 100%; text-align: center" id="message">${msg}</p>
					<div class="form-group">
						<label for="new_userid" class="col-sm-2 control-label">
							用户ID </label>
						<div class="col-sm-10">
							<input type="text" class="form-control" id="new_userid"
								placeholder="请输入用户ID号" name="user_id" />
						</div>
					</div>
					
					<div class="form-group">
						<label for="new_bookid" class="col-sm-2 control-label">书籍ID</label>
						<div class="col-sm-10">
							<input type="text" class="form-control" id="new_bookid"
								placeholder="请输入书ID号" name="book_id" />
						</div>
					</div>
				</form>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
				<button id="submitAdd" type="button" class="btn btn-primary"
					onclick="createborrow()">新建</button>
			</div>
		</div>
	</div>
</div>
<script type="text/javascript">
	//清空表单内容
	function resetAll() {
		$("#Search").find('input[type=date],input[type=text],select').each(function() {
			$(this).val('');
		});
	}
	
	//清空借阅窗口中的数据
	function clearborrow() {
		//清空模态框中from表单元素
		$('#new_borrow_form')[0].reset();
		//清空模态框中的文本域
		$('.w-e-text').html('');
		//清空提醒信息
		$("#message").text("");
	}
	
	//创建借阅记录
	function createborrow() {
	var user_id = $("#new_userid").val();
	var book_id = $("#new_bookid").val();
	if(user_id == null || user_id == ""){
		$("#message").text("用户ID不能为空！");
		return false
	}
	if(book_id == null || book_id == ""){
		$("#message").text("书籍ID不能为空！");
		return false
	}

	$.post("${pageContext.request.contextPath}/admin/borrowtable_careate.action",$("#new_borrowtable_form").serialize(),function(data){
			        if(data =="OK"){
			            alert("借书成功！");
			            window.location.reload();
			        }else{
			            alert("借书失败，请重试！");
			            window.location.reload();
			        }
			        
			    });
	}
	
	//还书
	function returnBook(user_id,book_id){
		if(confirm("您确定还书？确定后信息将无法更改！")){
			$.post("${pageContext.request.contextPath}/admin/return_Book.action",{"user_id":user_id,"book_id":book_id},function(data){
		        if(data =="OK"){
		            alert("还书成功！");
		            window.location.reload();
		        }else{
		            alert("还书失败，请重试！");
		            window.location.reload();
		        }
		        
		    });
		}
	}
</script>
</html>
<%@include  file="/WEB-INF/footer.jsp"%>