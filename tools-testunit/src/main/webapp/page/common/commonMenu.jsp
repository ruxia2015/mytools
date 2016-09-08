<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<div class="container">
    <div class="card card-inverse card-primary text-center">
        <div class="card-block">
            <blockquote class="card-blockquote">
                <p>V 1.0 接口测试管理工具 </p>
                <%--   <footer>Someone famous in <cite title="Source Title">Source Title</cite></footer>--%>
            </blockquote>
        </div>
    </div>
</div>
<div class="container"  style="padding-bottom: 20px;">
    <ul class="nav nav-pills " style="background-color: #e3f2fd;">
        <li class="nav-item ">
            <a href="${pageContext.request.contextPath}" class="nav-link active ">测试</a>
        </li>
        <li class="nav-item">
            <a class="nav-link " href="${pageContext.request.contextPath}/manager/toAddTestUnit.action">添加测试桩</a>

        </li>
        <li class="nav-item">
            <a  class="nav-link "  href="${pageContext.request.contextPath}/manager/toUpdateTestUnit.action">修改测试桩</a>
        </li>

        <li class="nav-item">
            <a  class="nav-link "  href="${pageContext.request.contextPath}/manager/toUpdateGlobalTestUnit.action">全局修改</a>
        </li>

    </ul>

</div>