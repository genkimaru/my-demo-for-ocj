<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>OCJ</title>
<!-- 导入jquery核心类库 -->
<script type="text/javascript"
	src="${pageContext.request.contextPath }/js/jquery-1.8.3.js"></script>
<!-- 导入easyui类库 -->
<link id="easyuiTheme" rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath }/js/easyui/themes/metro/easyui.css">
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath }/js/easyui/themes/icon.css">
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath }/css/default.css">
<script type="text/javascript"
	src="${pageContext.request.contextPath }/js/easyui/jquery.easyui.min.js"></script>
<!-- 导入ztree类库 -->
<link rel="stylesheet"
	href="${pageContext.request.contextPath }/js/ztree/zTreeStyle.css"
	type="text/css" />
<script
	src="${pageContext.request.contextPath }/js/ztree/jquery.ztree.core-3.3.js"
	type="text/javascript"></script>
<script
	src="${pageContext.request.contextPath }/js/easyui/locale/easyui-lang-zh_CN.js"
	type="text/javascript"></script>
<body class="easyui-layout">
    <div data-options="region:'north',border:false" style="height: 60px; padding: 10px">
        tabs 右键菜单demo QQ：15129679</div>
    <div data-options="region:'west',split:true,title:'操作菜单'" style="width: 150px; padding: 10px;">
        <ul id="webMenu_list" class="ztree" style="display: ;">
        </ul>
    </div>
    <div data-options="region:'center',title:'',border:false">
        <div id="tt" class="easyui-tabs" data-options="fit:true">
            <div title="首页" style="padding: 20px;">
                <h3>
                    欢迎您来到网站信息管理系统<br>
                    我的博客地址:http://www.cnblogs.com/yeminglong/p/3745914.html
                    
                    </h3>
            </div>
        </div>
    </div>
    <div id="mm" class="easyui-menu" style="width:120px;">
         <div id="mm-tabclose" name="1">关闭</div>
        <div id="mm-tabcloseall" name="2">全部关闭</div>
        <div id="mm-tabcloseother" name="3">除此之外全部关闭</div>
        <div class="menu-sep"></div>
        <div id="mm-tabcloseright" name="4">当前页右侧全部关闭</div>
        <div id="mm-tabcloseleft" name="5">当前页左侧全部关闭</div>

    </div>
    <script type="text/javascript">
    
    
        //添加Tabs
        function addTabs(event, treeId, treeNode, clickFlag){
            if(!$("#tt").tabs('exists', treeNode.name)){
                $('#tt').tabs('add',{
                    id:treeId,
                    title: treeNode.name,
                    selected: true,
                    href:treeNode.dataurl,
                    closable:true
                });
            }else $('#tt').tabs('select',treeNode.name);
        }
        
        //删除Tabs
        function closeTab(menu, type){
            var allTabs = $("#tt").tabs('tabs');
            var allTabtitle = [];
            $.each(allTabs,function(i,n){
                var opt=$(n).panel('options');
                if(opt.closable)
                    allTabtitle.push(opt.title);
            });

            switch (type){
                case "1" :
                    var curTabTitle = $(menu).data("tabTitle");
                    $("#tt").tabs("close", curTabTitle);
                    return false;
                break;
                case "2" :
                    for(var i=0;i<allTabtitle.length;i++){
                        $('#tt').tabs('close', allTabtitle[i]);
                    }
                break;
                case "3" :
            
                break;
                case "4" :
            
                break;
                case "5" :
            
                break;
            }
            
        }
        
        
        $(document).ready(function () {
            //监听右键事件，创建右键菜单
            $('#tt').tabs({
                onContextMenu:function(e, title,index){
                    e.preventDefault();
                    if(index>0){
                        $('#mm').menu('show', {
                            left: e.pageX,
                            top: e.pageY
                        }).data("tabTitle", title);
                    }
                }
            });
            //右键菜单click
            $("#mm").menu({
                onClick : function (item) {
                    closeTab(this, item.name);
                }
            });
            //treeNodes
            var zNodes = [
                { id:1, pId:0, name:"操作菜单", open:true,url:"",click:false},
                { id: 11, pId: 1, name: "杨凌现代农业科技创业网", dataurl: "02.html", target: "_self" },
                { id: 12, pId: 1, name: "杨凌外贸农产品质量溯源公共服务平台", dataurl: "02.html", target: "_self" },
                { id: 13, pId: 1, name: "华县农产品标准化生产溯源管理系统华县农产品标准化生产溯源管理系统", dataurl: "02.html", target: "_self" },
                { id: 14, pId: 1, name: "杨陵区科技局", dataurl: "02.html", target: "_self" },
                { id: 15, pId: 1, name: "杨陵区农民专业合作社联合会", dataurl: "02.html", target: "_self" },
                { id: 16, pId: 1, name: "杨凌农产品标准化生产溯源管理系统", dataurl: "02.html", target: "_self" },
                { id: 17, pId: 1, name: "站点列表", dataurl: "02.html", target: "_self" },
                { id: 18, pId: 1, name: "站点列表", dataurl: "02.html", target: "_self" }
            ];
        
            var setting = {
                view: {
                    selectedMulti: false
                },
                callback: {
                    onClick: addTabs
                }
            };

            $.fn.zTree.init($("#webMenu_list"), setting,zNodes);
            
        });
    </script>
</body>
</html>