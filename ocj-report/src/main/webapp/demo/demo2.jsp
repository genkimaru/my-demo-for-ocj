<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>工作单批量导入</title>
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
<script type="text/javascript"
	src="${pageContext.request.contextPath }/js/jquery.ocupload-1.1.2.js"></script>	
<script type="text/javascript">
	$(function(){
		$("#grid").datagrid({
			url : "${pageContext.request.contextPath}/ws/customer/customer/list",
			toolbar : [
				{
					id : 'btn-download',
					text : '模板下载',
					iconCls : 'icon-save',
					handler : function(){
						location.href = "${pageContext.request.contextPath}/download/download.xls.action";
					}
				},{
					id : 'btn-upload',
					text : '批量导入',
					iconCls : 'icon-redo'
				},{
					id : 'btn-refresh',
					text : '刷新',
					iconCls : 'icon-reload',
					handler : function(){
						$("#grid").datagrid('reload');						
					}
				}        
			],
			columns : [[
				{
					field : 'name',
					title : '客户名称',
					width : 120 ,
					align : 'center'
				},{
					field : 'gender',
					title : '性别',
					width : 120 ,
					align : 'center'
				},{
					field : 'address',
					title : '地址',
					width : 120 ,
					align : 'center'
				},{
					field : 'telephone',
					title : '电话号码',
					width : 120 ,
					align : 'center'
				}
			]],
			pageList: [30,50],
			border : false,
			pagination : true,
			striped : true,
			singleSelect: true,
			rownumbers : true,
			fit : true // 占满容器
		});
		
		// 一键上传
		$("#btn-upload").upload({
			 name: 'myfile',  // <input name="file" />
		     action: '${pageContext.request.contextPath}/batchImport.action',  // 提交请求action路径
		     enctype: 'multipart/form-data', // 编码格式
		     autoSubmit: true, // 选中文件提交表单
		     onComplete: function(response) {
		    	 alert(response);
		    		response = eval("("+response+")");
		        	if(response=="success"){
		        		$.messager.alert("提示信息","数据导入成功！","info");
		        		$("#grid").datagrid("reload");
		        	}else{
		        		$.messager.alert("错误提示",response,"error");
		        	}
		     }// 请求完成时 调用函数
		});
	});
</script>	
</head>
<body class="easyui-layout" >
	<div region="center">
		<table id="grid"></table>
	</div>
</body>
</html>