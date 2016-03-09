<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<!-- 导入jquery核心类库 -->
<script type="text/javascript"
	src="${pageContext.request.contextPath }/js/jquery-1.8.3.js"></script>
<!-- 导入easyui类库 -->
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath }/js/easyui/themes/default/easyui.css">
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath }/js/easyui/themes/icon.css">
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath }/js/easyui/ext/portal.css">
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath }/css/default.css">	
<script type="text/javascript"
	src="${pageContext.request.contextPath }/js/easyui/jquery.easyui.min.js"></script>
<script type="text/javascript"
	src="${pageContext.request.contextPath }/js/easyui/ext/jquery.portal.js"></script>
<script type="text/javascript"
	src="${pageContext.request.contextPath }/js/easyui/ext/jquery.cookie.js"></script>
<script
	src="${pageContext.request.contextPath }/js/easyui/locale/easyui-lang-zh_CN.js"
	type="text/javascript"></script>
<!-- 导入ztree类库 -->
<link rel="stylesheet"
	href="${pageContext.request.contextPath }/js/ztree/zTreeStyle.css"
	type="text/css" />
<script
	src="${pageContext.request.contextPath }/js/ztree/jquery.ztree.all-3.5.js"
	type="text/javascript"></script>	
<script type="text/javascript">
	// 1、设置参数
	var setting = {
		// 异步加载
		async: {
			enable: true,
			url:"${pageContext.request.contextPath}/function_treelist.action",
			autoParam:["id"], // 在展开一级节点后，产生参数
			dataFilter: filter
		},
		// 勾选效果
		check: {
			enable: true,
			chkStyle: "checkbox",
			chkboxType: { "Y": "ps", "N": "ps" }
		}
	};
	
	// 2、对于返回子节点过滤
	function filter(treeId, parentNode, childNodes) {
		if (!childNodes) return null;
		return childNodes;
	}
	
	$(function(){
		// 3、加载Ztree
		$.fn.zTree.init($("#functionTree"), setting);
		
		// 保存角色
		$("#save").click(function(){
			// 获得树中所有选中的节点
			var treeObj = $.fn.zTree.getZTreeObj("functionTree");
			var nodes = treeObj.getCheckedNodes(true);
			// 将勾选id 拼接为 String
			var ids = [];
			
			for(var i=0;i< nodes.length ; i++){
				if(!nodes[i].getCheckStatus().half){// 加入完全勾选的节点
					ids.push(nodes[i].id);// 加入数组
				}
			}
			
			// 提交表单
			$("#roleForm").form('submit',{
				url : '${pageContext.request.contextPath}/role_add.action?ids='+ids.join(","), // 以get 方式提交勾选数据
				success : function(){
					$("#roleForm").get(0).reset();
					$("#addRoleWindow").window('close');
					// 勾选状态清除
					treeObj.checkAllNodes(false);
					$("#grid").datagrid('reload');
				}		
			});
		});
	});	

	$(function(){
		$("body").css({visibility:"visible"});
		$("#grid").datagrid({
			url : '${pageContext.request.contextPath}/role_pageQuery.action',
			toolbar: [
				{
					id : 'add',
					text : '添加新角色',
					iconCls :'icon-add',
					handler : function(){
						alert("添加新角色");
						$("#addRoleWindow").window('open');
					}
				}          
			],
			columns : [[
			  {field:'id',title:'编号',width:150},
			  {field:'name',title:'名称',width:150},
			  {field:'description',title:'描述',width:300}
			]]
		});
	});
</script>	
</head>
<body class="easyui-layout" style="visibility:hidden;">
    <div region="center" border="false">
    	<table id="grid"></table>
	</div>
	
	<div class="easyui-window" title="添加功能" id="addRoleWindow" closed="true" collapsible="false" minimizable="false" maximizable="false" style="top:100px;left:200px">
		<div region="north" style="height:31px;overflow:hidden;" split="false" border="false" >
			<div class="datagrid-toolbar">
				<a id="save" icon="icon-save" href="#" class="easyui-linkbutton" plain="true" >保存</a>
			</div>
		</div>
		<div region="center" style="overflow:auto;padding:5px;" border="false">
			<form id="roleForm" method="post">
				<table class="table-edit" width="80%" align="center">
					<tr class="title">
						<td colspan="2">角色信息</td>
					</tr>
					<tr>
						<td width="200">编号</td>
						<td>
							<input type="text" name="id" class="easyui-validatebox" data-options="required:true" />						
						</td>
					</tr>
					<tr>
						<td>名称</td>
						<td><input type="text" name="name" class="easyui-validatebox" data-options="required:true" /></td>
					</tr>
					<tr>
						<td>描述</td>
						<td>
							<textarea name="description" rows="4" cols="60"></textarea>
						</td>
					</tr>
					<tr>
						<td>授权</td>
						<td>
							<ul id="functionTree" class="ztree"></ul>
						</td>
					</tr>
					</table>
			</form>
		</div>
	</div>
</body>
</html>