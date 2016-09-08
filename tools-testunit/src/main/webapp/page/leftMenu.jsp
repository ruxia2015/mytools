<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
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

<div class="list-group" style="text-align: left">
    <c:forEach items="${fileModels}" var="fileModel" varStatus="oneS">
    <a class="list-group-item" href="#two_${oneS.index}" data-toggle="collapse" aria-expanded="true" style="text-align: left">${fileModel.fileSimpleName}</a>
    <div class="list-group collapse" id="two_${oneS.index}" >
        <c:forEach items="${fileModel.childFileModels}" var="twoFileModel" varStatus="twoS">
        <a class="list-group-item "   href="#three_${oneS.index}_${twoS.index}" data-toggle="collapse" style="text-align: left">&nbsp;&nbsp;&nbsp;&nbsp;——  ${twoFileModel.fileSimpleName}</a>

        <div class="list-group collapse " id="three_${oneS.index}_${twoS.index}">
            <c:forEach items="${twoFileModel.childFileModels}" var="threeFileModel" varStatus="threes">
             <a class="list-group-item" href="#" style="text-align: left">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;——  ${twoFileModel.fileSimpleName}${threeFileModel.fileSimpleName}&nbsp;&nbsp;</a>
            </c:forEach>
        </div>
       </c:forEach>
    </div>
    </c:forEach>
</div>

<%--
<c:forEach items="${fileModels}" var="fileModel" varStatus="oneS">
    <c:if test="${fileModel.folder}">
        <div class="list-group">
            <a href="#" class="list-group-item list-group-item-success">Dapibus ac facilisis in</a>
            <a href="#" class="list-group-item list-group-item-info">Cras sit amet nibh libero</a>
            <a href="#" class="list-group-item list-group-item-warning">Porta ac consectetur ac</a>
            <a href="#" class="list-group-item list-group-item-danger">Vestibulum at eros</a>
        </div>
        <a class="list-group-item list-group-item-success " data-toggle="collapse" href="#menu_two_${oneS.index}" aria-expanded="true">
                ${fileModel.fileSimpleName}
        </a>

        <div class="collapse" id="menu_two_${oneS.index}">
            <c:forEach items="${fileModel.childFileModels}" var="twoFileModel" varStatus="twoS">
                <c:if test="${twoFileModel.folder}">
                    <a class="btn btn-info list-group-item" data-toggle="collapse" href="#menu_three_${oneS.index}_${twoS.index}"
                       aria-expanded="false">
                            ${twoFileModel.fileSimpleName}
                    </a>
                    <div class="collapse" id="#menu_three_${oneS.index}_${twoS.index}">
                        <c:forEach items="${twoFileModel.childFileModels}" var="threeFileModel" varStatus="threes">
                            <a class="btn btn-success-outline list-group-item">
                                    ${threeFileModel.fileSimpleName}
                            </a>
                        </c:forEach>
                    </div>
                </c:if>
                <c:if test="${!twoFileModel.folder}">
                    <a class="btn btn-success-outline list-group-item">
                            ${twoFileModel.fileSimpleName}
                    </a>
                </c:if>
            </c:forEach>
        </div>
    </c:if>
    <c:if test="${!fileModel.folder}">
        <a class="btn btn-success-outline">
                ${fileModel.fileSimpleName}
        </a>
    </c:if>

</c:forEach>--%>


</body>
<script>
    $(document).ready(function(){
        $('.collapse').collapse();
    });

</script>


<%--<script>
    $(document).ready(function(){
        loadDirectory();


    });

    var directoryData = null;
    function loadDirectory(){
        $.ajax({
            url:'<%=request.getContextPath()%>/testunit/manager/getFolderDirectorys.action',
            type:'post',
            async : false, //默认为true 异步
            contentType: "application/json",
            error:function(){

            },
            success:function(data){
                directoryData = eval("(" + data + ")");


                for(var o in directoryData){

                }


            }
        });
    }

    function createMenu(menuData){
        var childMenu = new Array();
        var childMenuList = new Array();
        for(var o in menuData){
            var item = menuData[o];
            if(item.folder){
                childMenuList.push(item);
            }else{
                childMenu.push(item)
            }
        }

        for(var i=0;i<childMenuList.length;i++){

        }

    }

</script>--%>


</html>