<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <link href="${pageContext.request.contextPath}/resource/bootstrap-4.0.0-alpha/dist/css/bootstrap.css"
          rel="stylesheet">
    <script src="${pageContext.request.contextPath}/resource/js/jquery-3.1.0.min.js"></script>
    <script src="${pageContext.request.contextPath}/resource/js/jquery.form.js"></script>
    <script src="${pageContext.request.contextPath}/resource/bootstrap-4.0.0-alpha/dist/js/bootstrap.min.js"></script>
    <title>添加测试桩</title>
</head>
<body>


<div class="container1" style="padding: 10px;overflow-x: hidden;">
    <form:form method="post" id="addForm" modelAttribute="testUnitModel"
               action="${pageContext.request.contextPath}/manager/addTestUnit.action">
        <div class="form-group row">
            <label for="inputEmail3" class="col-sm-2 form-control-label">服务地址</label>

            <div class="col-sm-10">
                <form:input cssClass="form-control" path="requestServer" placeholder="服务地址"/>
            </div>
        </div>
        <div class="form-group row">
            <label for="" class="col-sm-2 form-control-label">服务路径</label>

            <div class="col-sm-10">
                <form:input cssClass="form-control" path="requestPath" placeholder="服务路径"/>
            </div>
        </div>

        <div class="form-group  row">
            <label for="" class="col-sm-2 form-control-label">上级目录</label>

            <div class="col-sm-10">
                <input type="hidden" name="parentPath">
                <select class="c-select" id="level_one_path">
                    <option selected>Open this select menu</option>

                </select>
                <select class="c-select" id="level_two_path">
                    <option selected value="">手动填写</option>
                </select>

            </div>
        </div>
        <div class="form-group  row">
            <label for="" class="col-sm-2 form-control-label"></label>

            <div class="col-sm-10">
                <input id="level_one" name="levelOne" value="${levelOne}" placeholder="一级目录" required>
                <input id="level_two" name="levelTwo" value="${levelTwo}" placeholder="二级目录" required>

            </div>
        </div>
        <div class="form-group row">
            <label for="" class="col-sm-2 form-control-label">名称</label>

            <div class="col-sm-10">
                <form:input cssClass="form-control" path="name" placeholder="名称"/>
            </div>
        </div>

        <div class="form-group row">
            <label for="" class="col-sm-2 form-control-label">请求报文</label>

            <div class="col-sm-10">
                <form:textarea cssClass="form-control" path="requestDatagram" cssStyle="height: 300px;"
                               placeholder="请求报文"/>
            </div>
        </div>

        <div class="form-group row">
            <div class="col-sm-offset-2 col-sm-10">
                <button type="button" id="submitBtn" class="btn btn-secondary">保存</button>
                <button type="button" id="openSaveAs" class="btn btn-secondary" data-toggle="modal"
                        data-target="#myModal">另保存
                </button>
            </div>
        </div>
    </form:form>
</div>

<div class="modal fade hide" id="myModal">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                    <span class="sr-only">Close</span>
                </button>
                <h4 class="modal-title">请输入名称</h4>
            </div>
            <div class="modal-body">
                <input type="text" class="form-control" id="modal_name" placeholder="测试名称">
            </div>
            <div class="modal-footer">
                <button type="button" id="saveAs" class="btn btn-secondary" data-dismiss="modal">确定</button>
            </div>
        </div>
        <!-- /.modal-content -->
    </div>
    <!-- /.modal-dialog -->
</div>
<!-- /.modal -->


</body>

<script>
    $(document).ready(function () {

        loadDirectory();


        $("#level_one_path").change(function () {
            var val = $(this).val();
            if (val == "") {
                $("#level_one").attr("disabled", false);
            } else {
                $("#level_one").attr("disabled", true);
                $("#level_one").val(val);
                loadTwoOnePath(val);
            }
        });

        $("#level_two_path").change(function () {
            var val = $(this).val();
            if (val == "") {
                $("#level_two").attr("disabled", false);
            } else {
                $("#level_two").attr("disabled", true);
                $("#level_two").val(val);
            }
        });

        $("#submitBtn").click(function () {

            ajaxSubmitFun();
        });

        $("#saveAs").click(function () {
            $("#name").val($("#modal_name").val());
            ajaxSubmitFun();
        });

        $("#level_one_path").val("${levelOne}");
        loadTwoOnePath("${levelOne}");
        $("#level_two_path").val("${levelTwo}");
    });

    function loadTwoOnePath(val) {
        var childData = directoryData[val];
        var html = "<option value=''>手动填写</option>";
        for (var i = 0; i < childData.length; i++) {
            var value = childData[i];
            html = html + "<option value='" + value + "'>" + value + "</option>";
        }
        $("#level_two_path").html(html);
    }

    function ajaxSubmitFun() {
        $('#addForm').ajaxSubmit({
            url: "${pageContext.request.contextPath }/manager/addTestUnitAjax.action",
            success: function (data) {
                alert("成功！");

            }
        });
    }

    var directoryData = null;
    function loadDirectory() {
        $.ajax({
            url: '<%=request.getContextPath()%>/manager/getFolderDirectorys.action',
            type: 'post',
            async: false, //默认为true 异步
            contentType: "application/json",
            error: function () {

            },
            success: function (data) {
                directoryData = eval("(" + data + ")");

                var html = "<option value=''>手动填写</option>";
                for (var o in directoryData) {
                    html = html + "<option value='" + o + "'>" + o + "</option>";
                }
                $("#level_one_path").html(html);

            }
        });
    }

</script>

</html>