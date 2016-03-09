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
<script type="text/javascript">
	$(function(){
		$("body").css({visibility:"visible"});
		$("#grid").datagrid({
			url : '${pageContext.request.contextPath}/function_pageQuery.action',
			toolbar: [{
				id : 'add',
				text : '添加新功能',
				iconCls : 'icon-add',
				handler : function(){
					// 弹出隐藏window
					$("#addFunctionWindow").window('open');
				}
			}],
			columns:[[ 
				{
					field: 'id',
					title: '编号',
					width: 100
				},
				{
					field: 'name',
					title: '名称',
					width: 100
				},
				{
					field: 'description',
					title: '描述',
					width: 200
				},
				{
					field: 'page',
					title: '路径',
					width: 200
				},
				{
					field: 'generateMenu',
					title: '是否生成菜单',
					width: 100,
					formatter : function(value,row, index){
						if(value=="1"){
							return "是";
						}else if(value=="0"){
							return "否";
						}
					}
				},
				{
					field: 'zindex',
					title: '优先级',
					width: 100
				}
			]],
			pagination:true,
			pageList : [10,20,30],
			fit : true
		});
		
		// 点击保存
		$("#save").click(function(){
			$("#functionForm").form('submit',{
				url : '${pageContext.request.contextPath}/function_add.action',
				success : function(){
					$("#functionForm").get(0).reset();
					$("#addFunctionWindow").window('close');
					$("#grid").datagrid('reload'); 
				}
			});
		});
	});
</script>	
</head>
<body class="easyui-layout" style="visibility:hidden;">
    <div region="center" border="false">
    	<table id="grid"></table>
	</div>
	
	<div class="easyui-window" title="添加功能" id="addFunctionWindow" closed="true" collapsible="false" minimizable="false" maximizable="false" style="top:100px;left:200px">
		<div region="north" style="height:31px;overflow:hidden;" split="false" border="false" >
			<div class="datagrid-toolbar">
				<a id="save" icon="icon-save" href="#" class="easyui-linkbutton" plain="true" >保存</a>
			</div>
		</div>
		<div region="center" style="overflow:auto;padding:5px;" border="false">
			<form id="functionForm" method="post">
				<table class="table-edit" width="80%" align="center">
					<tr class="title">
						<td colspan="2">功能权限信息</td>
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
						<td>访问路径</td>
						<td><input type="text" name="page"  /></td>
					</tr>
					<tr>
						<td>是否生成菜单</td>
						<td>
							<select name="generateMenu" class="easyui-combobox">
								<option value="1">生成</option>
								<option value="0">不生成</option>
							</select>
						</td>
					</tr>
					<tr>
						<td>优先级</td>
						<td>
							<input type="text" name="zindex" class="easyui-numberbox" data-options="required:true" />
						</td>
					</tr>
					<tr>
						<td>父功能点</td>
						<td>
							<input name="parentFunction.id" class="easyui-combobox" data-options="valueField:'id',textField:'info',url:'${pageContext.request.contextPath }/function_ajaxlist.action'"/>
						</td>
					</tr>
					<tr>
						<td>描述</td>
						<td>
							<textarea name="description" rows="4" cols="60"></textarea>
						</td>
					</tr>
					</table>
			</form>
		</div>
	</div>
</body>
</html>