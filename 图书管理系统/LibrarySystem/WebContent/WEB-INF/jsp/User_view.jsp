<%@include  file="/WEB-INF/User_header.jsp"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>图书管理系统</title>
<style type="text/css">
	#table{
		table-layout: fixed;
		word-wrap:break-word;
	}
	#table td{
		 white-space:nowrap;
		 overflow:hidden;
		 text-overflow: ellipsis;
	}
</style>

</head>
<body>
	<div id="page-wrapper">
	<div class="row">
			<div class="col-lg-12">
				<h1 class="page-header">浏览图书</h1>
			</div>
			<!-- /.col-lg-12 -->
	</div>
	<!-- /.row -->
		<div class="panel panel-default">
			<div class="panel-body">
				<form  class="form-inline" method="get" id="Search" 
				    action="${pageContext.request.contextPath }/user/search_book.action">
					<div class="form-group">
						<label for="search_content">查询内容</label> 
						<input type="text" class="form-control" id="search_content" 
						                    value="${search_content }" name="search_content" />
					</div>
					<div class="form-group">
						<label for="cateFrom">书籍分类</label> 
						<select	class="form-control" id="cateFrom" name="cateSource">
							<option value="">--请选择--</option>
							<c:forEach items="${catelist}" var="item">
								<option value="${item.c_id}" ${item.c_id == c_id?'selected':'' }>       
								   ${item.c_name}
								</option>
							</c:forEach>
						</select>
					</div>
					<button type="submit" class="btn btn-primary">查询</button>
					<button type="button" class="btn btn-primary" onclick="resetAll()">重置</button>
				</form>
			</div>
		</div>
	<div class="row">
			<div class="col-lg-12">
				<div class="panel panel-default">
					<div class="panel-heading">图书信息列表</div>
					<!-- /.panel-heading -->
					<table id="table" class="table table-bordered table-striped">
						<thead>
							<tr>
							  <th scope="col">ID</th>
						      <th scope="col">名称</th>
						      <th scope="col">简介</th>
						      <th scope="col">图片</th>
						      <th scope="col">区域</th>
						      <th scope="col">库存数量</th>
							</tr>
						</thead>
						<tbody>
							<c:forEach items="${page.rows}" var="row">
								<tr>
									<td>${row.book_id}</td>
									<td title="${row.book_name}">${row.book_name}</td>
									<td title="${row.intro}">${row.intro}</td>
									<td><img src="${pageContext.request.contextPath }${row.photourl}" width="100%" height="100%"/></td>
									<td>${row.position}</td>
									<td>${row.number}</td>
								    
									<td>
										<a href="${pageContext.request.contextPath }/user/book_detail.action?book_id=${row.book_id}"  class="btn btn-primary btn-xs" >书籍详情</a>
									</td>
								</tr>
							</c:forEach>
						</tbody>
					</table>
					<div class="col-md-12 text-right">
						<pagebar:page url="${pageContext.request.contextPath }/user/view.action" />
					</div> 
					<!-- /.panel-body -->
				</div>
				<!-- /.panel -->
			</div>
			<!-- /.col-lg-12 -->
		</div>
	</div>
	<!-- 书籍列表查询部分  end-->
</body>
<script type="text/javascript">
//清空表单搜索框内容
function resetAll() {
	 $("#Search").find('input[type=text],select').each(function() {
     $(this).val('');
    });
}
</script>
</html>
<%@include  file="/WEB-INF/footer.jsp"%>