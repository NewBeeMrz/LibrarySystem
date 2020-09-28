<%@include file="/WEB-INF/User_header.jsp"%>
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
					action="${pageContext.request.contextPath }/user/search_borrow.action">
					<div class="form-group">
						<label for="search_date">查询日期</label> <input type="date"
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
				<div class="panel panel-default">
					<div class="panel-heading">个人借阅信息列表</div>
					<!-- /.panel-heading -->
					<table id="table" class="table table-bordered table-striped">
						<thead>
							<tr>
								<th scope="col">书籍名称</th>
								<th scope="col">借阅人</th>
								<th scope="col">借阅时间</th>
								<th scope="col">归还时间</th>
								<th scope="col">状态</th>
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
								</tr>
							</c:forEach>
						</tbody>
					</table>
					<div class="col-md-12 text-right">
						<pagebar:page
							url="${pageContext.request.contextPath }/user/borrow.action" />
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
<script type="text/javascript">
	//清空表单内容
	function resetAll() {
		$("#Search").find('input[type=date],select').each(function() {
			$(this).val('');
		});
	}
</script>
</html>
<%@include file="/WEB-INF/footer.jsp"%>