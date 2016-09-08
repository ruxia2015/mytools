function contactStrWith(parentid,level,index){
    return parentid+"_"+level+"_"+index;

}

function getSpace(number){
    var res = "&nbsp;&nbsp;";
    for(var i=0;i<number;i++){
        res = res + "&nbsp;&nbsp;&nbsp;&nbsp;";
    }

    return res;
}

var _loadMenuCallBackFun = null;
function loadMenu(leftMenuId,callFun){
    _loadMenuCallBackFun = callFun;
    $.ajax({
        url: _serverPath+'/showMenu/leftMenu.action',
        type: 'post',
        async: false, //默认为true 异步
        contentType: "application/json",
        error: function () {

        },
        success: function (data) {
            directoryData = eval("(" + data + ")");
            var html = buildLeftMenu(directoryData);
            $("#"+leftMenuId).append(html);
            $('#'+leftMenuId+'>div>div').collapse('show');
            $('#'+leftMenuId+'>div>div>div').collapse('show');

            $('#'+leftMenuId+'>div>div>div a:first-child')[0].click();

        }
    });
}

function buildLeftMenu(data,level,parentUuid,index) {
    if (typeof level == "undefined" || level < 1) {
        level = 1;
    }
    var html = "";
    if (level == 1) {
        html = "<div class=\"list-group\" style=\"text-align: left\">";
    }else{
        html = "  <div class=\"list-group collapse \" id=\"div_"+contactStrWith(parentUuid,level,index)+"\" >";
    }
    for (var childIndex in data) {
        var oneFileModel = data[childIndex];
        var uuid = oneFileModel.uuid;
        if (oneFileModel.folder) {
            html = html + "  <a class=\"list-group-item   \"   href=\"#div_" + contactStrWith(uuid,level+1,childIndex) + "\" data-toggle=\"collapse\" style=\"text-align: left\">&nbsp;&nbsp;"+getSpace(level)+"&nbsp;+ &nbsp;" + oneFileModel.fileSimpleName + "</a>";

            html = html + buildLeftMenu(oneFileModel.childFileModels,  level + 1,oneFileModel.uuid,childIndex);
        } else {
            html = html + "  <a id=\"a_" + oneFileModel.uuid + "\"  class=\"list-group-item leaf \"  href=\"javascript:openTabFun('" + oneFileModel.fileSimpleName + "','" + oneFileModel.uuid + "')\"   style=\"text-align: left\">&nbsp;&nbsp;&nbsp;&nbsp;->" + oneFileModel.fileSimpleName + "</a>";
        }
    }

    if (level == 1) {
        html = html + "</div>";
    }else{
        html = html + "</div>";
    }

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

    _loadMenuCallBackFun(uuid);
   // $("#showFrame").attr("src","testUnit/toSendDatagramByUuid.action?uuid="+uuid);

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