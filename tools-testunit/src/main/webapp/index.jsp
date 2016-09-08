<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <jsp:include page="page/common/commonHeader.jsp"/>
    <title></title>
</head>
<body>

<jsp:include page="page/common/commonMenu.jsp"/>

<div class="container">
    <div class="col-sm-4" id="leftMenu">
    </div>
    <div class="col-sm-8">
        <ul class="nav nav-tabs" id="rightTabs">

        </ul>
        <div style="margin-top: 10px;padding-top:20px;" class="card">
            <iframe id="showFrame" width="100%" height="900px" style="overflow-x: auto;border: 0px;"></iframe>

        </div>
    </div>

</div>


</body>
<script>


    $(document).ready(function () {
        $('.collapse').collapse('toggle');
        $('#two_0').collapse('toggle');
        //加载菜单
        loadMenu("leftMenu", loadMenuCallBackFun);
    });


    function loadMenuCallBackFun(uuid) {
        $("#showFrame").attr("src", _serverPath+"/testUnit/toSendDatagramByUuid.action?uuid=" + uuid);
    }


</script>


</html>