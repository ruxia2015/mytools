<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <link href="${pageContext.request.contextPath}/resource/bootstrap-4.0.0-alpha/dist/css/bootstrap.css"  rel="stylesheet">
    <script src="${pageContext.request.contextPath}/resource/js/jquery-3.1.0.min.js"></script>
    <script src="${pageContext.request.contextPath}/resource/js/jquery.form.js"></script>
    <script src="${pageContext.request.contextPath}/resource/bootstrap-4.0.0-alpha/dist/js/bootstrap.min.js"></script>
    <title></title>
</head>
<body>
<div class="container">
<form:form method="post" id="form" modelAttribute="testUnitModel"  >
    <form:hidden path="parentPath" />
    <form:hidden path="name" />
    <div class="form-group row">
        <label for="inputEmail3" class="col-sm-2 form-control-label">服务地址</label>
        <div class="col-sm-10">
            <form:input path="requestServer" cssClass="form-control"  placeholder="服务地址"/>

        </div>
    </div>
    <div class="form-group row">
        <label for="" class="col-sm-2 form-control-label">服务路径</label>
        <div class="col-sm-10">
            <form:input path="requestPath" cssClass="form-control"  placeholder="服务路径"/>
        </div>
    </div>
    <div class="form-group row">
    <label for="" class="col-sm-2 form-control-label">请求报文</label>
    <div class="col-sm-10">
        <form:textarea path="requestDatagram"  placeholder="请求报文" cssClass="form-control" cssStyle="height: 230px;"></form:textarea>
    </div>
</div>
    <div class="form-group row">
        <label for="" class="col-sm-2 form-control-label">响应报文</label>
        <div class="col-sm-10">
            <textarea id="responseDatagram"   class="form-control" style="height: 230px;" disabled></textarea>
        </div>
    </div>

    <div class="form-group row">
        <label for="" class="col-sm-2 form-control-label">是否保存</label>
        <div class="col-sm-10">
            <input name="save"   value="1" type="checkbox" checked/>
        </div>
    </div>



    <div class="form-group row">
        <div class="col-sm-offset-2 col-sm-10">
            <button type="button" id="submitBtn" onclick="submitFun();" class="btn btn-secondary">发送请求</button>
        </div>
    </div>
</form:form>
</div>
</body>

<script>
    $(document).ready(function(){
       //$("submitBtn").bind("click",submitFun());
    });

    function submitFun(){
        $('#form').ajaxSubmit({
            url:"${pageContext.request.contextPath }/testUnit/sendDatagram.action",
            success: function(data) {
                data = eval("("+data+")");
                if(data.statusCode==200) {
                    $("#responseDatagram").val(data.responseMsg);
                }else{
                    $("#responseDatagram").val(data);
                }
            }
        });

    }


</script>

</html>