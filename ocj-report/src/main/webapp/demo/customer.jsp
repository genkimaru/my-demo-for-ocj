<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>区域设置</title>
<!-- 导入jquery核心类库 -->
<script type="text/javascript"
	src="${pageContext.request.contextPath }/js/jquery-1.8.3.js"></script>
<!-- 导入easyui类库 -->
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath }/js/easyui/themes/metro/easyui.css">
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
	function doAdd(){
		$('#addRegionWindow').window("open");
	}
	
	function doView(){
		alert("修改...");
	}
	
	function doDelete(){
		alert("删除...");
	}
	

	
	
	//工具栏
	var toolbar = [ {
		id : 'button-edit',	
		text : '修改',
		iconCls : 'icon-edit',
		handler : doView
	}, {
		id : 'button-add',
		text : '增加',
		iconCls : 'icon-add',
		handler : doAdd
	}, {
		id : 'button-delete',
		text : '删除',
		iconCls : 'icon-cancel',
		handler : doDelete
	}];
	// 定义列
	var columns = [ [ {
		field : 'id',
		checkbox : true,
	},{
		field : 'name',
		title : '客户名字',
		width : 120,
		align : 'center'
	}, {
		field : 'gender',
		title : '性别',
		width : 120,
		align : 'center'
	}, {
		field : 'address',
		title : '地址',
		width : 120,
		align : 'center'
	}, {
		field : 'telephone',
		title : '电话号码',
		width : 120,
		align : 'center'
	}] ];
	
	$(function(){
		//表单数据直接转换成json字符串
		$.fn.serializeObject = function()    
		{    
		   var o = {};    
		   var a = this.serializeArray();    
		   $.each(a, function() {    
		       if (o[this.name]) {    
		           if (!o[this.name].push) {    
		               o[this.name] = [o[this.name]];    
		           }    
		           o[this.name].push(this.value || '');    
		       } else {    
		           o[this.name] = this.value || '';    
		       }    
		   });    
		   return o;    
		}; 
		
		// 先将body隐藏，再显示，不会出现页面刷新效果
		$("body").css({visibility:"visible"});
		
		// 收派标准数据表格
		$('#grid').datagrid( {
			iconCls : 'icon-forward',
			fit : true,
			border : false,
			rownumbers : true,
			striped : true,
			pageList: [30,50,100],
			pagination : true,
			toolbar : toolbar,
			url : "${pageContext.request.contextPath}/ws/customer/customer/list",
			idField : 'id',
			columns : columns,
			onDblClickRow : doDblClickRow,
			onRowContextMenu : rightClickRow
		});
		
		// 添加、修改区域窗口
		$('#addRegionWindow').window({
	        title: '添加修改区域',
	        width: 400,
	        modal: true,
	        shadow: true,
	        closed: true,
	        height: 400,
	        resizable:false
	    });
		
		
 		$("#save").click(
 				function(){
 					$.ajax({ 
						url: "${pageContext.request.contextPath}/ws/customer/customer/add", 
						type:"POST",
						contentType: 'application/json', 
						data: JSON.stringify($("#ff").serializeObject()),
						dataType: "json",
						success: function(data){
							$("#ff").form('clear');
							$("#addRegionWindow").window('close');
							$("#grid").datagrid('reload');
						},
						error:function(){
							
							$.messager.alert('警告','添加失败','warning');
							$("#ff").window('close');
						}
				})   
 				})
 				
	})

	function doDblClickRow(){
		alert("双击表格数据...");
	}
	
	function rightClickRow(){
		alert("右键表格数据...");
	}
	

	
</script>	
</head>
<body class="easyui-layout" style="visibility:hidden;">
	<div region="center" border="false">
    	<table id="grid"></table>
	</div>
	<div class="easyui-window" title="客户添加修改" id="addRegionWindow" collapsible="false" minimizable="false" maximizable="false" style="top:20px;left:200px">
		<div region="north" style="height:31px;overflow:hidden;" split="false" border="false" >
			<div class="datagrid-toolbar">
				<a id="save" icon="icon-save" href="#" class="easyui-linkbutton" plain="true" >保存</a>
			</div>
		</div>
		
		<div region="center" style="overflow:auto;padding:5px;" border="false">
			<form id="ff">
				<table class="table-edit" width="80%" align="center">
					<tr class="title">
						<td colspan="2">客户信息</td>
					</tr>
					<tr>
						<td>客户姓名</td>
						<td><input type="text" name="name" class="easyui-validatebox" required="true"/></td>
					</tr>
					<tr>
						<td>性别</td>
						<td><input type="text" name="gender" class="easyui-validatebox" required="true"/></td>
					</tr>
					<tr>
						<td>地址</td>
						<td><input type="text" name="address" class="easyui-validatebox" required="true"/></td>
					</tr>
					<tr>
						<td>电话</td>
						<td><input type="text" name="telephone" class="easyui-validatebox" required="true"/></td>
					</tr>
				
					</table>
			</form>
		</div>
	</div>
</body>
</html>