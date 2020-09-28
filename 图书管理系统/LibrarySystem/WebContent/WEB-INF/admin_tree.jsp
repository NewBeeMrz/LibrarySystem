<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!-- 左侧显示列表部分 start-->
<div class="navbar-default sidebar" role="navigation">
	<div class="sidebar-nav navbar-collapse">
		<ul class="nav" id="side-menu">
			<li class="sidebar-search">
				<div class="input-group custom-search-form">
					<input type="text" class="form-control" placeholder="查询内容...">
					<span class="input-group-btn">
						<button class="btn btn-default" type="button">
							<i class="fa fa-search" style="padding: 3px 0 3px 0;"></i>
						</button>
					</span>
				</div>
			</li>
			<li><a
				href="${pageContext.request.contextPath }/admin/categorylist.action">
					<i class="fa fa-bookmark fa-fw"></i> 图书分类管理
			</a></li>
			<li><a
				href="${pageContext.request.contextPath }/admin/booklist.action">
					<i class="fa fa-book fa-fw"></i> 图书管理
			</a></li>

			<li><a
				href="${pageContext.request.contextPath }/admin/userlist.action">
					<i class="fa fa-user fa-fw"></i> 用户管理
			</a></li>
			<li><a
				href="${pageContext.request.contextPath }/admin/borrowlist.action">
					<i class="fa fa-bars fa-fw"></i> 借阅管理
			</a></li>

		</ul>
	</div>
</div>
<!-- 左侧显示列表部分 end-->
