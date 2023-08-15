<%@page import="com.entity.Expenses"%>
<%@page import="java.util.List"%>
<%@page import="com.db.HibernateUtil"%>
<%@page import="com.dao.ExpenseDao"%>
<%@page import="com.entity.User"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<%@include file="../component/allcss.jsp"%>
</head>
<body>
	<%@include file="../component/navbar.jsp"%>
	<c:if test="${empty loginUser}">
		<c:redirect url="../login.jsp"></c:redirect>
	</c:if>
	<div class="container ">
		<div class="row">
			<div class="col-md-8 offset-md-2">
				<div class="card card-sh">
					<div class="card-header text-center">
						<p class="fs-3">All Expenses</p>
						<c:if test="${not empty msg}">
							<p class="text-center text-success fs-4">${msg }</p>
							<c:remove var="msg" />
						</c:if>
					</div>
					<div class="card-body">
						<table class="table">
							<thead>
								<tr>
									<th scope="col">Title</th>
									<th scope="col">Description</th>
									<th scope="col">Date</th>
									<th scope="col">Time</th>
									<th scope="col">Price</th>
									<th scope="col">Action</th>
								</tr>
							</thead>
							<tbody>
								<%
								User user = (User) session.getAttribute("loginUser");

								ExpenseDao dao = new ExpenseDao(HibernateUtil.getSessionFactory());
								List<Expenses> list = dao.getAllExpenseByUser(user);

								for (Expenses ex : list) {
								%>

								<tr>
									<th scope="row"><%=ex.getTitle()%></th>
									<td><%=ex.getDescription()%></td>
									<td><%=ex.getDate()%></td>
									<td><%=ex.getTime()%></td>
									<td><%=ex.getPrice()%></td>

									<td><a href="edit_expense.jsp?id=<%=ex.getId()%>"
										class="btn btn-sm btn-primary me-1">Edit</a>
										 <a href="../deleteExpense?id=<%=ex.getId()%>"
										class="btn btn-sm btn-danger me-1">Delete</a></td>
								</tr>

								<%
								}
								%>
							</tbody>
						</table>
					</div>
				</div>
			</div>
		</div>
	</div>
</body>
</html>