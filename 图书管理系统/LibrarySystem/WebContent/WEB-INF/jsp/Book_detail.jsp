<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="pagebar" uri="http://neusoft.edu.cn/common/"%>
<c:if test="${rank == 1 }">
	<%@include  file="/WEB-INF/admin_header.jsp"%>
</c:if>
<c:if test="${rank == 0 }">
	<%@include  file="/WEB-INF/User_header.jsp"%>
</c:if>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE HTML>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>图书管理系统</title>	
	<style type="text/css">
		.img{
			float: left
		}
		.list{
			margin-left:150px
		}
		li{
			margin-bottom: 10px;
			font-family: serif;
		}
	</style>
</head>
<body>
    <div id="page-wrapper">
	<div class="row">
			<div class="col-lg-12">
				<h1 class="page-header">书籍详情</h1>
			</div>
			<!-- /.col-lg-12 -->
			<div class="container" style="width:50%;margin-top: 100px">
				<div>
				<div class="img" >
					<img src="${pageContext.request.contextPath }${book.photourl}" width="150px" height="150px"/>
				</div>
				<div class="list">
					<ul>
						<li>书籍名称：${book.book_name}</li>
						<li>作者：${book.author}</li>
						<li>库存数量：${book.number} 本</li>
						<li>区域：${book.position}</li>
						<li>价格：￥${book.price}</li>
						<li>类型：${book.c_name}</li>
						<li>出版社：${book.press}</li>
						<li>简介：<br/><textarea style="resize:none; border:0;border-radius:5px;background-color:rgba(241,241,241,.98);padding: 10px" rows="5" cols="70" readonly>${book.intro}</textarea></li>
					</ul>
				</div>
			</div>
			</div>	
	</div>
	</div>
<%@include  file="/WEB-INF/footer.jsp"%>