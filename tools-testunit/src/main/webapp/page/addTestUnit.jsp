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
    <title>添加测试桩</title>
</head>
<body>

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
<div class="container" >
    <ul class="nav nav-pills">
        <li class="nav-item">
            <a href="${pageContext.request.contextPath}" class="nav-link ">测试</a>
        </li>
        <li class="nav-item">
            <a class="nav-link active" href="#">添加测试桩</a>

        </li>
        <li class="nav-item">
            <a href="#" class="nav-link ">修改测试桩</a>
        </li>
      </ul>

</div>
<br/>

<div class="container">
<form:form method="post" id="addForm" modelAttribute="testUnitModel" action="${pageContext.request.contextPath}/manager/addTestUnit.action" >
    <div class="form-group row">
        <label for="inputEmail3" class="col-sm-2 form-control-label">服务地址</label>
        <div class="col-sm-6">
            <input type="text" class="form-control" name="requestServer" placeholder="服务地址">
        </div>
    </div>
    <div class="form-group row">
        <label for="" class="col-sm-2 form-control-label">服务路径</label>
        <div class="col-sm-6">
            <input type="text" class="form-control" name="requestPath"  placeholder="服务路径">
        </div>
    </div>

    <div class="form-group  row">
        <label for="" class="col-sm-2 form-control-label">上级目录</label>
        <div class="col-sm-6">
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
        <div class="col-sm-6">
          <input id="level_one" name="levelOne" placeholder="一级目录" required>
            <input id="level_two" name="levelTwo"  placeholder="二级目录"  required>

        </div>
    </div>
    <div class="form-group row">
        <label for="" class="col-sm-2 form-control-label">名称</label>
        <div class="col-sm-6">
            <input type="text" class="form-control" id="name"  name="name" placeholder="名称">
        </div>
    </div>

    <div class="form-group row">
        <label for="" class="col-sm-2 form-control-label">请求报文</label>
        <div class="col-sm-6">
            <textarea type="text" name="requestDatagram" class="form-control"  placeholder="请求报文"></textarea>
        </div>
    </div>

    <div class="form-group row">
        <div class="col-sm-offset-2 col-sm-10">
            <button type="button" id="submitBtn" class="btn btn-secondary">保存</button>
            <button type="button" id="openSaveAs" class="btn btn-secondary" data-toggle="modal" data-target="#myModal"  >另保存</button>
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
                <input type="text" class="form-control"  id="modal_name" placeholder="测试名称">
            </div>
            <div class="modal-footer">
                <button type="button" id="saveAs" class="btn btn-secondary" data-dismiss="modal">确定</button>
            </div>
        </div><!-- /.modal-content -->
    </div><!-- /.modal-dialog -->
</div><!-- /.modal -->



</body>

<script>
    $(document).ready(function(){
        loadDirectory();

        $("#level_one_path").click(function(){
            var val = $(this).val();
            if(val==""){
                $("#level_one").attr("disabled",false);
            }else{
                $("#level_one").attr("disabled",true);
                $("#level_one").val(val);
                var childData =directoryData[val];
                var html = "<option value=''>手动填写</option>";
                for(var i=0;i<childData.length;i++){
                    var value = childData[i];
                    html = html+"<option value='"+value+"'>"+value+"</option>";
                }
                $("#level_two_path").html(html);
            }
        });

        $("#level_two_path").click(function(){
            var val = $(this).val();
            if(val==""){
                $("#level_two").attr("disabled",false);
            }else{
                $("#level_two").attr("disabled",true);
                $("#level_two").val(val);
            }
        });

        $("#submitBtn").click(function(){

            ajaxSubmitFun();
        });

        $("#saveAs").click(function(){
            $("#name").val($("#modal_name").val());
            ajaxSubmitFun();
        });

    });

    function ajaxSubmitFun(){
        $('#addForm').ajaxSubmit({
            url:"${pageContext.request.contextPath }/manager/addTestUnitAjax.action",
            success: function(data) {
                alert("成功！");

            }
        });
    }

    var directoryData = null;
    function loadDirectory(){
        $.ajax({
            url:'<%=request.getContextPath()%>/manager/getFolderDirectorys.action',
            type:'post',
            async : false, //默认为true 异步
            contentType: "application/json",
            error:function(){

            },
            success:function(data){
                directoryData = eval("(" + data + ")");

                var html = "<option value=''>手动填写</option>";
                for(var o in directoryData){
                    html = html+"<option value='"+o+"'>"+o+"</option>";
                }
                $("#level_one_path").html(html);

            }
        });
    }

</script>

</html>