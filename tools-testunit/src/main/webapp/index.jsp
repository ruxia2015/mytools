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
    <title></title>
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
<br/>

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

        $.ajax({
            url: '<%=request.getContextPath()%>/showMenu/leftMenu.action',
            type: 'post',
            async: false, //默认为true 异步
            contentType: "application/json",
            error: function () {

            },
            success: function (data) {
                directoryData = eval("(" + data + ")");
                var html = buildLeftMenu(directoryData);
                $("#leftMenu").append(html);


            }
        });
    });

    function buildLeftMenu(data) {
        var html = "<div class=\"list-group\" style=\"text-align: left\">";
        for (var one in data) {
            var oneFileModel = data[one];
            html = html + "<a  id=\"one_"+one+"\" class=\"list-group-item\" href=\"#two_" + one + "\" data-toggle=\"collapse\" aria-expanded=\"true\" style=\"text-align: left\">" + oneFileModel.fileName + "</a>";
            html = html + "<div class=\"list-group collapse\" id=\"two_" + one + "\" >";
            var twoHtml = "";

            for (var two in oneFileModel.childFileModels) {
                var twoFileModel = oneFileModel.childFileModels[two];
                if(twoFileModel.folder){
                    twoHtml = twoHtml + "  <a class=\"list-group-item \"   href=\"#three_"+one+"_"+two+"\" data-toggle=\"collapse\" style=\"text-align: left\">&nbsp;&nbsp;&nbsp;&nbsp;+ &nbsp;" + twoFileModel.fileName + "</a>" ;
                }else{
                    twoHtml = twoHtml + "  <a id=\"a_"+twoFileModel.uuid+"\"  class=\"list-group-item \"   href=\"javascript:openTabFun('"+twoFileModel.fileName+"','"+twoFileModel.uuid+"')\"   style=\"text-align: left\">&nbsp;&nbsp;&nbsp;&nbsp;->" + twoFileModel.fileName + "</a>" ;
                }
                               twoHtml = twoHtml +        "        <div class=\"list-group collapse \" id=\"three_"+one+"_"+two+"\" >";
                for (var three in twoFileModel.childFileModels) {
                    var threeFileModel = twoFileModel.childFileModels[three];
                    twoHtml = twoHtml + "<a  id=\"a_"+threeFileModel.uuid+"\" class=\"list-group-item\" href=\"javascript:openTabFun('"+threeFileModel.fileName+"','"+threeFileModel.uuid+"')\" style=\"text-align: left\">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;-> " + threeFileModel.fileName + "&nbsp;&nbsp;</a>" ;

                }
                twoHtml = twoHtml + "</div>";
            }
            twoHtml = twoHtml + "</div>";
            html = html + twoHtml;
            html = html + "    </div>";
        }


        html = html + "</div>";


        return html;
    }

    var tabsCon = {};
    function openTabFun(name,uuid){
        var tabId = "tab_"+uuid;
        if(currentClose==tabId){
            currentClose = "";
            return;
        }

        if(tabsCon[tabId]!=1){
            var html = "  <li id=\""+tabId+"\" class=\"nav-item \">"+
                    "               <a href=\"javascript:openTabFun('"+name+"','"+uuid+"');\" class=\"nav-link active\" >"+name +"&nbsp;&nbsp;&nbsp;<label onclick=\"closeFun('"+tabId+"')\" title='关闭'> x </label></a>"+
                    "            </li>";
            $("#rightTabs").append(html);

        }
        $("#leftMenu a").css("color","");
        $("#a_"+uuid).css("color","blue");
        $("#rightTabs a").removeClass("active");
        $("#"+tabId +" > a").addClass("active");
        tabsCon[tabId] = 1;

        $("#showFrame").attr("src","testUnit/toSendDatagramByUuid.action?uuid="+uuid);

    }

    var currentClose = "";
    function closeFun(id){
        currentClose = id;

        if($("#"+id).prev()){
            $("#"+id).prev().click();
        }else{
            $("#"+id).next().click();
        }
        $("#"+id).remove();
        tabsCon[id]=0;
        return false;
    }

    function showTestData(){
        $.ajax({
            url: '<%=request.getContextPath()%>/testUnit/sendDatagram.action',
            type: 'post',
            async: false, //默认为true 异步
            contentType: "application/json",
            error: function () {

            },
            success: function (data) {
                directoryData = eval("(" + data + ")");
                var html = buildLeftMenu(directoryData);
                $("#leftMenu").append(html);


            }
        });


    }

    $(function () {
        $('#one_0').collapse('show');
        $('#two_0').collapse('show');
        $('#three_0_0').collapse('show');
        $("#three_0_0 a:first-child")[0].click();

    });
</script>


</html>