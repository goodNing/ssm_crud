<%--
  Created by IntelliJ IDEA.
  User: 11196
  Date: 2020/2/18
  Time: 17:32
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<% pageContext.setAttribute("APP_PATH",request.getContextPath()); %>
<html>
<head>
    <title>员工列表</title>
</head>
<%--web路径:无/开始：当前资源路径   有/开始，服务器路径，例如http://localhost:8080
需要加上项目名称--%>
<script href="${APP_PATH}/static/bootstrap/js/bootstrap.min.js"></script>
<script type="text/javascript" href="${APP_PATH}/static/jquery/jquery-3.4.1/jquery-3.4.1.min.js"></script>
<link rel="stylesheet" href="${APP_PATH}/static/bootstrap/css/bootstrap.min.css">
<body>
<%--搭建bootstrap栅格系统的显示界面--%>
    <div class="container">
        <div class="row"><%--标题--%>
            <div class="col-md-8 col-md-offset-4"><h1>SSM-CRUD</h1></div>
        </div>
        <div class="row"><%--按钮--%>
            <div class="col-md-4 col-md-offset-8">
                <button class="btn btn-primary">新增</button>
                <button class="btn btn-danger">删除</button>
            </div>
        </div>
        <div class="row"><%--表格--%>
            <div class="col-md-12">
                <table class="table table-hover">
                    <tr>
                        <th>#</th>
                        <th>姓名</th>
                        <th>性别</th>
                        <th>邮箱</th>
                        <th>部门</th>
                        <th>操作</th>
                    </tr>
                    <c:forEach items="${pageInfo.list}" var="emp">
                        <tr>
                            <th>${emp.empId}</th>
                            <th>${emp.empName}</th>
                            <th>${emp.gender==1?"男":"女"}</th>
                            <th>${emp.email}</th>
                            <th>${emp.department.deptName}</th>
                            <th>
                                <button class="btn btn-primary btn-sm">
                                    <span class="glyphicon glyphicon-pencil" aria-hidden="true"></span>
                                    编辑
                                </button>
                                <button class="btn btn-danger btn-sm">
                                    <span class="glyphicon glyphicon-trash" aria-hidden="true"></span>
                                    删除
                                </button>
                            </th>
                        </tr>

                    </c:forEach>
                </table>
            </div>
        </div>
        <%-- 显示分页信息--%>
        <div class="row">
            <div class="col-md-6">
                ${pageInfo.pageNum}/${pageInfo.pages}，共${pageInfo.total}条记录
            </div>
            <div class="col-md-6">
                <nav aria-label="Page navigation">
                    <ul class="pagination">
                        <li>
                            <a href="${APP_PATH}/emps?page=1">
                                首页
                            </a>
                        </li>
                        <c:if test="${pageInfo.pageNum>1}">
                            <li>
                                <a href="${APP_PATH}/emps?page=${pageInfo.pageNum-1}" aria-label="Previous">
                                    <span aria-hidden="true">&laquo;</span>
                                </a>
                            </li>
                        </c:if>
                        <c:forEach items="${pageInfo.navigatepageNums}" var="page_num">
                            <c:if test="${page_num==pageInfo.pageNum}">
                                <li class="active"><a href="#">${page_num}</a></li>
                            </c:if>
                            <c:if test="${page_num!=pageInfo.pageNum}">
                                <li><a href="${APP_PATH}/emps?page=${page_num}">${page_num}</a></li>
                            </c:if>
                        </c:forEach>
                        <c:if test="${pageInfo.pageNum<pageInfo.pages}">
                            <li>
                                <a href="${APP_PATH}/emps?page=${pageInfo.pageNum+1}" aria-label="Next">
                                    <span aria-hidden="true">&raquo;</span>
                                </a>
                            </li>
                        </c:if>
                        <li>
                            <a href="${APP_PATH}/emps?page=${pageInfo.pages}">
                                尾页
                            </a>
                        </li>
                    </ul>
                </nav>
            </div>
        </div>

    </div>
</body>
</html>
