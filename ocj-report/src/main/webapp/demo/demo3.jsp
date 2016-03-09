<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>工作单快速录入</title>
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
	var editIndex ;
	
	function doAdd(){
		if(editIndex != undefined){
			$("#grid").datagrid('endEdit',editIndex);
		}
		if(editIndex==undefined){
			//alert("快速添加电子单...");
			$("#grid").datagrid('insertRow',{
				index : 0,
				row : {}
			});
			$("#grid").datagrid('beginEdit',0);
			editIndex = 0;
		}
	}
	
	function doSave(){
		$("#grid").datagrid('endEdit',editIndex );
	}
	
	// 判断对象是否为空
	function isEmptyObject(obj) {
		for ( var name in obj ) {
			return false;
		}
		return true;
	}
	
	function doCancel(){
		if(editIndex!=undefined){
			$("#grid").datagrid('cancelEdit',editIndex);
			// 如果新增行，删除，如果不是新增行，保留
			// 判断当前行是否为空行
			var rows = $("#grid").datagrid('getRows');// 返回所有行
			if(isEmptyObject(rows[editIndex])){
				$("#grid").datagrid('deleteRow',editIndex);
			}
			editIndex = undefined;
		}
	}
	
	//工具栏
	var toolbar = [ {
		id : 'button-add',	
		text : '新增一行',
		iconCls : 'icon-edit',
		handler : doAdd
	}, {
		id : 'button-cancel',
		text : '取消编辑',
		iconCls : 'icon-cancel',
		handler : doCancel
	}, {
		id : 'button-save',
		text : '保存',
		iconCls : 'icon-save',
		handler : doSave
	}];
	// 定义列
	var columns = [ [ {
		field : 'name',
		title : '客户名称',
		width : 120,
		align : 'center',
		editor :{
			type : 'validatebox',
			options : {
				required: true
			}
		}
	},{
		field : 'gender',
		title : '性别',
		width : 220,
		align : 'center',
		formatter : function(value,row,index){
			if(value=='male'){
				return "男";
			}else if(value == 'female'){
				return "女";
			}else{
				return "未知";
			}
		},
		editor :{
			type : 'combobox',
			options : {
				valueField: 'label',
				textField: 'value',
				data : [
					{
						label : 'male',
						value : '男'
					},
					{
						label : 'female',
						value : '女'
					}
				]
			}
		}
	},
	{
		field : 'address',
		title : '地址',
		width : 120,
		align : 'center',
		editor :{
			type : 'validatebox',
			options : {
				required: true
			}
		}
	},{
		field : 'telephone',
		title : '电话',
		width : 120,
		align : 'center',
		editor :{
			type : 'validatebox',
			options : {
				required: true
			}
		}
	} ] ];
	
	$(function(){
		// 先将body隐藏，再显示，不会出现页面刷新效果
		$("body").css({visibility:"visible"});
		
		// 收派标准数据表格
		$('#grid').datagrid( {
			iconCls : 'icon-forward',
			fit : true,
			border : true,
			rownumbers : true,
			striped : true,
			pageList: [30,50,100],
			pagination : true,
			toolbar : toolbar,
			url :  "${pageContext.request.contextPath}/ws/customer/customer/list",
			idField : 'id',
			columns : columns,
			onDblClickRow : doDblClickRow,
			onAfterEdit : function(rowIndex, rowData, changes){
				console.info(rowData);
				editIndex = undefined;
				// 提交数据保存请求
				$.post("${pageContext.request.contextPath}/workOrderManage_save.action", rowData , function(data){
					$("#grid").datagrid('reload');// 重写载入表格数据
				});
			}
		});
	});

	function doDblClickRow(rowIndex, rowData){
		alert("双击表格数据...");
		console.info(rowIndex);
		$('#grid').datagrid('beginEdit',rowIndex);
		editIndex = rowIndex;
	}
	
	// value 输入查询内容， name 是 <div data-options="name:'arrivecity' 中name属性值
	function doSearch(value,name){
		// alert("执行查询... name: "+ name + ",value:" + value );
		// 查询结果回显datagrid ，使用datagrid自带查询功能 
		$("#grid").datagrid('load',{
			"conditionName": name,
			"conditionValue" : value
		});
	}
</script>
</head>
<body class="easyui-layout" style="visibility:hidden;">
	<div region="center" border="false">
		<!-- 输入框 -->
		<input type="text" id="searchInput" name="conditionValue" class="easyui-searchbox" style="width:300px" data-options="searcher:doSearch,prompt:'请输入搜索内容',menu:'#mm'" />
		<div id="mm" style="width:120px"> 
			<div data-options="name:'address',iconCls:'icon-ok'">根据地址查询</div>
			<div data-options="name:'telephone',iconCls:'icon-ok'">根据电话号码查询</div>
		</div>
    	<table id="grid"></table>
	</div>
</body>
</html>