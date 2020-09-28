<%@include file="/WEB-INF/admin_header.jsp"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>图书管理系统</title>
<style type="text/css">
#table {
	table-layout: fixed;
	word-wrap: break-word;
}

#table td {
	white-space: nowrap;
	overflow: hidden;
	text-overflow: ellipsis;
}
</style>

</head>
<body>
	<div id="page-wrapper">
		<div class="row">
			<div class="col-lg-12">
				<h1 class="page-header">图书管理</h1>
			</div>
			<!-- /.col-lg-12 -->
		</div>
		<!-- /.row -->
		<div class="panel panel-default">
			<div class="panel-body">
				<form class="form-inline" method="get" id="Search"
					action="${pageContext.request.contextPath }/admin/search_book.action">
					<div class="form-group">
						<label for="search_content">查询内容</label> <input type="text"
							class="form-control" id="search_content"
							value="${search_content }" name="search_content" />
					</div>
					<div class="form-group">
						<label for="cateFrom">书籍分类</label> <select class="form-control"
							id="cateFrom" name="cateSource">
							<option value="">--请选择--</option>
							<c:forEach items="${catelist}" var="item">
								<option value="${item.c_id}" ${item.c_id == c_id?'selected':'' }>
									${item.c_name}</option>
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
				<div>
					<a><button type="button" onclick="clearbook()"
							class="btn btn-primary" data-toggle="modal"
							data-target="#newbookDialog">新建</button></a>
				</div>
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
								<th scope="col">操作</th>
							</tr>
						</thead>
						<tbody>
							<c:forEach items="${page.rows}" var="row">
								<tr>
									<td>${row.book_id}</td>
									<td title="${row.book_name}">${row.book_name}</td>
									<td title="${row.intro}">${row.intro}</td>
									<td><img
										src="${pageContext.request.contextPath }${row.photourl}"
										width="100%" height="100%" /></td>
									<td>${row.position}</td>
									<td>${row.number}</td>

									<th><a
										href="${pageContext.request.contextPath }/admin/book_detail.action?book_id=${row.book_id}"
										class="btn btn-primary btn-xs">书籍详情</a><br />
									<hr /> <a data-toggle="modal" data-target="#bookEditDialog"
										onclick="editBook(${row.book_id})"
										class="btn btn-warning btn-xs">修改书籍</a><br />
									<hr /> <a onclick="deleteBook(${row.book_id})"
										class="btn btn-danger btn-xs">删除书籍</a></th>
								</tr>
							</c:forEach>
						</tbody>
					</table>
					<div class="col-md-12 text-right">
						<pagebar:page
							url="${pageContext.request.contextPath }/admin/booklist.action" />
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

<!-- 修改书籍信息模态框 -->
<div class="modal fade" id="bookEditDialog" data-backdrop="static"
	tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
	<div class="modal-dialog" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal"
					aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
				<h4 class="modal-title" id="myModalLabel">修改书籍信息</h4>
			</div>
			<div class="modal-body">
				<form class="form-horizontal" id="edit_book_form"
					enctype="multipart/form-data" method="post">
					<p style="color: red; width: 100%; text-align: center" id="message">${msg}</p>
					<input type="hidden" id="edit_book_id" name="book_id" />
					<div class="form-group" id="form_book">
						<label for="edit_bookName"
							style="float: left; padding: 7px 15px 0 27px;">书籍名称</label>
						<div class="col-sm-10">
							<input type="text" class="form-control" id="edit_bookName"
								placeholder="书籍名称" name="book_name" />
						</div>
					</div>
					<div class="form-group">
						<label for="edit_bookFrom"
							style="float: left; padding: 7px 15px 0 27px;">所属分类</label>
						<div class="col-sm-10">
							<select class="form-control" id="edit_bookFrom" name="type_id">
								<option value="">--请选择--</option>
								<c:forEach items="${catelist}" var="item">
									<option value="${item.c_id}">${item.c_name }</option>
								</c:forEach>
							</select>
						</div>
					</div>
					<div class="form-group">
						<label for="edit_author" class="col-sm-2 control-label">作者</label>
						<div class="col-sm-10">
							<input type="text" class="form-control" id="edit_author"
								placeholder="未知，多名作者请用逗号隔开" name="author" />
						</div>
					</div>
					<div class="form-group">
						<label for="edit_bookNum" class="col-sm-2 control-label">库存量</label>
						<div class="col-sm-10">
							<input type="number" class="form-control" id="edit_bookNum"
								placeholder="库存量" name="number" />
						</div>
					</div>
					<div class="form-group">
						<label for="edit_bookPrice" class="col-sm-2 control-label">价格</label>
						<div class="col-sm-10">
							<input type="number" value="0" min="0" step="0.1"
								class="form-control" id="edit_bookPrice" placeholder="未知"
								name="price" />
						</div>
					</div>
					<div class="form-group">
						<label for="edit_bookPosition" class="col-sm-2 control-label">区域</label>
						<div class="col-sm-10">
							<input type="text" class="form-control" id="edit_bookPosition"
								placeholder="区域" name="position" />
						</div>
					</div>
					<div class="form-group">
						<label for="edit_bookPress" class="col-sm-2 control-label">出版社</label>
						<div class="col-sm-10">
							<input type="text" class="form-control" id="edit_bookPress"
								placeholder="未知" name="press" />
						</div>
					</div>
					<div class="form-group">
						<label for="edit_bookPhoto" class="col-sm-2 control-label">上传图片</label>
						<div class="col-sm-10">
							<input type="file" class="form-control" id="edit_bookPhoto"
								placeholder="如果想更新图片则上传图片" name="photo" />
						</div>
					</div>
					<div class="form-group">
						<label for="edit_bookIntro" class="col-sm-2 control-label">简介</label>
						<div class="col-sm-10">
							<textarea class="form-control" id="edit_bookIntro" name="intro"
								style="resize: none; border-radius: 5px; padding: 10px" rows="5"
								cols="70" placeholder="未知"></textarea>
						</div>
					</div>
				</form>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
				<button type="button" class="btn btn-primary" onclick="updateBook()">修改书籍</button>
			</div>
		</div>
	</div>
</div>

<!-- 创建书籍模态框 -->
<div class="modal fade" id="newbookDialog" tabindex="-1" role="dialog"
	aria-labelledby="myModalLabel">
	<div class="modal-dialog" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal"
					aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
				<h4 class="modal-title" id="myModalLabel">新建书籍信息</h4>
			</div>
			<div class="modal-body">
				<form class="form-horizontal" id="new_book_form"
					enctype="multipart/form-data" method="post">
					<p style="color: red; width: 100%; text-align: center" id="message">${msg}</p>
					<div class="form-group">
						<label for="new_bookName" class="col-sm-2 control-label">
							书籍名称 </label>
						<div class="col-sm-10">
							<input type="text" class="form-control" id="new_bookName"
								placeholder="书籍名称" name="book_name" required />
						</div>
					</div>
					<div class="form-group">
						<label for="new_bookFrom"
							style="float: left; padding: 7px 15px 0 27px;">所属分类</label>
						<div class="col-sm-10">
							<select class="form-control" id="new_bookFrom" name="type_id">
								<option value="">--请选择--</option>
								<c:forEach items="${catelist}" var="item">
									<option value="${item.c_id}">${item.c_name }</option>
								</c:forEach>
							</select>
						</div>
					</div>
					<div class="form-group">
						<label for="new_bookAuthor" class="col-sm-2 control-label">作者</label>
						<div class="col-sm-10">
							<input type="text" class="form-control" id="new_bookAuthor"
								placeholder="多个作者用逗号隔开" name="author" />
						</div>
					</div>
					<div class="form-group">
						<label for="new_bookNum" class="col-sm-2 control-label">库存量</label>
						<div class="col-sm-10">
							<input type="number" class="form-control" id="new_bookNum"
								placeholder="库存量" name="number" required />
						</div>
					</div>
					<div class="form-group">
						<label for="new_bookPrice" class="col-sm-2 control-label">价格</label>
						<div class="col-sm-10">
							<input type="number" value="0" min="0" step="0.1"
								class="form-control" id="new_bookPrice" placeholder="价格"
								name="price" />
						</div>
					</div>
					<div class="form-group">
						<label for="new_bookPosition" class="col-sm-2 control-label">区域</label>
						<div class="col-sm-10">
							<input type="text" class="form-control" id="new_bookPosition"
								placeholder="区域" name="position" required />
						</div>
					</div>
					<div class="form-group">
						<label for="new_bookPress" class="col-sm-2 control-label">出版社</label>
						<div class="col-sm-10">
							<input type="text" class="form-control" id="new_bookPress"
								placeholder="出版社" name="press" />
						</div>
					</div>
					<div class="form-group">
						<label for="new_bookPhoto" class="col-sm-2 control-label">图片</label>
						<div class="col-sm-10">
							<input type="file" class="form-control" id="new_bookPhoto"
								placeholder="图片" name="photo" />
						</div>
					</div>
					<div class="form-group">
						<label for="new_bookIntro" class="col-sm-2 control-label">简介</label>
						<div class="col-sm-10">
							<textarea class="form-control" id="new_bookIntro" name="intro"
								style="resize: none; border-radius: 5px; padding: 10px" rows="5"
								cols="70" placeholder="书籍的简要介绍"></textarea>
						</div>
					</div>
				</form>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
				<button id="submitAdd" type="button" class="btn btn-primary"
					onclick="createbook()">新建书籍</button>
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

//清空新建商品窗口中的数据
function clearbook() {
	//清空模态框中from表单元素
	$('#new_book_form')[0].reset();
	//清空模态框中的文本域
	$('.w-e-text').html('');
	//清空提醒信息
	$("#message").text("");
}

// 创建商品
function createbook() {
var book_name = $("#new_bookName").val();
var number = $("#new_bookNum").val();
var position = $("#new_bookPosition").val();
var type_id=$("#new_bookFrom option:selected").val();
if(book_name == null || book_name == ""){
	$("#message").text("书籍名称不能为空！");
	return false
}
if(number == null || number == ""){
	$("#message").text("库存量不能为空！");
	return false
}
if(position == null || position == ""){
	$("#message").text("书籍存放区域不能为空！");
	return false
}
if(type_id == null || type_id == ""){
	$("#message").text("请选择书籍类别！");
	return false
}

var fm = new FormData($( "#new_book_form" )[0]);
//进行Ajax请求(带有文件上传的方式)
$.ajax({
    //几个参数需要注意一下
    type: "POST",//方法类型
    dataType: "json",//预期服务器返回的数据类型,可以不设置
    url: "${pageContext.request.contextPath}/admin/create_book.action" ,//url
    data: fm,
    async: false,  
    cache: false,
    contentType: false, //禁止设置请求类型
    processData: false, //禁止jquery对DAta数据的处理,默认会处理
    success: function (result) {
        console.log(result);//打印服务端返回的数据(调试用)
        if (result) {
        	alert("新建书籍成功！");
        	window.location.reload();
        }
    },
    error : function() {
        alert("新建书籍失败，请重试！");
        window.location.reload();
    }
});
}

//删除书籍   Jquery异步请求操作
function deleteBook(book_id) {
    if(confirm('确定要删除该书籍吗?')) {
$.post("${pageContext.request.contextPath}/admin/book_delete.action",{"book_id":book_id},
function(data){//回调函数
            if(data =="OK"){
                alert("书籍删除成功！");
                window.location.reload();
            }else{
                alert("删除书籍失败！");
                window.location.reload();
            }
        });
    }
}

//通过id获取修改的书籍信息
function editBook(book_id) {
    $.ajax({
        type:"get",
        url:"<%=basePath%>admin/getBookByID.action",
        data:{"book_id":book_id},
        success:function(data) {
            $("#edit_book_id").val(data.book_id);
            $("#edit_bookName").val(data.book_name);
            $("#edit_author").val(data.author);
            $("#edit_bookNum").val(data.number);
            $("#edit_bookPrice").val(data.price);
            $("#edit_bookPress").val(data.press);
            $("#edit_bookIntro").val(data.intro);
            $("#edit_bookFrom").val(data.type_id);
            $("#edit_bookPosition").val(data.position)
        }
    });
}

//执行修改书籍操作
function updateBook() {
	var book_name = $("#edit_bookName").val();
	var number = $("#edit_bookNum").val();
	var position = $("#edit_bookPosition").val();
	var type_id=$("#edit_bookFrom option:selected").val();
	if(book_name == null || book_name == ""){
		$("#message").text("书籍名称不能为空！");
		return false
	}
	if(number == null || number == ""){
		$("#message").text("库存量不能为空！");
		return false
	}
	if(position == null || position == ""){
		$("#message").text("书籍存放区域不能为空！");
		return false
	}
	if(type_id == null || type_id == ""){
		$("#message").text("请选择书籍类别！");
		return false
	}

	var fm = new FormData($( "#edit_book_form" )[0]);
	//进行Ajax请求(带有文件上传的方式)
	$.ajax({
	    //几个参数需要注意一下
	    type: "POST",//方法类型
	    dataType: "json",//预期服务器返回的数据类型,可以不设置
	    url: "${pageContext.request.contextPath}/admin/update_book.action" ,//url
	    data: fm,
	    async: false,  
	    cache: false,
	    contentType: false, //禁止设置请求类型
	    processData: false, //禁止jquery对DAta数据的处理,默认会处理
	    success: function (result) {
	        console.log(result);//打印服务端返回的数据(调试用)
	        if (result) {
	        	alert("修改书籍成功！");
	        	window.location.reload();
	        }
	    },
	    error : function() {
	        alert("修改书籍失败，请重试！");
	        window.location.reload();
	    }
	});
}
</script>
</html>
<%@include file="/WEB-INF/footer.jsp"%>