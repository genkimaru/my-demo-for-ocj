<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://www.itcast.cn/itcast"  prefix="itcast"%>    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>收排标准</title>
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
	function doAdd(){
		//alert("增加...");
		$('#addStandardWindow').window("open");
	}
	
	function doView(){
		alert("查看...");
	}
	
	function doDelete(){
		alert("删除...");
		// 获得选中行 id 
		var allSelectedArray = $("#grid").datagrid('getSelections');
		var ids = []; //定义数组
		for(var i =0 ; i < allSelectedArray.length ; i++){
			// 获得每个id
			ids.push(allSelectedArray[i].id);
		}
		// 将数组每个元素用, 连接
		if(ids.length == 0){
			$.messager.alert("警告","必须选中后才能删除！","warning");
			return ;
		}
		$.post("${pageContext.request.contextPath}/standard_batchDel.action", {"ids" : ids.join(",")}, function(data){
			$("#grid").datagrid('reload');// 表格数据重载
		});
	}
	//工具栏
	var toolbar = [ 
	<itcast:privilege value="添加标准">
	{
		id : 'button-view',	
		text : '查询',
		iconCls : 'icon-search',
		handler : doView
	}, 
	</itcast:privilege>
	<itcast:privilege value="添加标准">
	{
		id : 'button-add',
		text : '增加',
		iconCls : 'icon-add',
		handler : doAdd
	}, 
	</itcast:privilege>
	
	{
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
		title : '标准名称',
		width : 120,
		align : 'center'
	}, {
		field : 'minweight',
		title : '最小重量',
		width : 120,
		align : 'center'
	}, {
		field : 'maxweight',
		title : '最大重量',
		width : 120,
		align : 'center'
	}, {
		field : 'user.username',
		title : '操作人',
		width : 120,
		align : 'center', 
		// 自定义显示规则
		formatter : function(value,rowData, rowIndex){// value当前属性对应值，rowData 该行数据对象， rowIndex 行索引
			if(rowData.user != null){
				return rowData.user.username;
			}
		}
	}, {
		field : 'updatetime',
		title : '操作时间',
		width : 160,
		align : 'center',
		formatter : function(value,rowData, rowIndex){// value当前属性对应值，rowData 该行数据对象， rowIndex 行索引
			return value.replace("T"," ");
		}
	}, {
		field : 'user.station',
		title : '操作单位',
		width : 200,
		align : 'center',
		formatter : function(value,rowData, rowIndex){// value当前属性对应值，rowData 该行数据对象， rowIndex 行索引
			if(rowData.user != null){
				return rowData.user.station;
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
			border : false,
			rownumbers : true,
			striped : true,
			pageList: [30,50,100],
			pagination : true,
			toolbar : toolbar,
			url : "${pageContext.request.contextPath}/standard_pageQuery.action",
			idField : 'id',
			columns : columns,
			onDblClickRow : doDblClickRow
		});
		
		// 添加收派标准窗口
		$('#addStandardWindow').window({
            title: '添加收派标准',
            width: 400,
            modal: true,
            shadow: true,
            closed: true,
            height: 400,
            resizable:false
        });
		
		
		// 点击保存按钮，以ajax方式提交 form
		$("#save").click(function(){
			$("#standardForm").form('submit',{
				url : '${pageContext.request.contextPath}/standard_add.action', // 提交到哪？
				success : function(data){
					alert(data);
					data = eval("("+data+")"); // 汉字存在错误
					// 成功后 执行回调函数
					if(data == "success"){
						$.messager.alert("信息","保存成功" ,"info");
					}else {
						alert(data);
					}
						$('#addStandardWindow').window("close"); // 关闭窗口
						$('#standardForm').get(0).reset();// get(0) 将jquery对象转换为 dom对象 
						$('#standard_id').val(''); // 手动清除隐藏id
						// 数据表格刷新
						$("#grid").datagrid('reload');
				}
			});
		});
		
	});
	
	// rowIndex 行索引
	// rowData 行数据
	function doDblClickRow(rowIndex, rowData){
		// 回显到 form中
		$("#standard_id").val(rowData.id);
		$("#name").val(rowData.name);
		// numberbox数据回显 
		$('#minweight').numberbox('setValue',rowData.minweight); 
		$('#maxweight').numberbox('setValue',rowData.maxweight); 
		
		// 弹出窗口
		$("#addStandardWindow").window('open');
	}
	
		
</script>	
</head>
<body class="easyui-layout" style="visibility:hidden;">
    <div region="center" border="false">
    	<table id="grid"></table>
	</div>
	
	<div class="easyui-window" title="收派标准" id="addStandardWindow" collapsible="false" minimizable="false" maximizable="false" style="top:100px;left:200px">
		<div region="north" style="height:31px;overflow:hidden;" split="false" border="false" >
			<div class="datagrid-toolbar">
				<a id="save" icon="icon-save" href="#" class="easyui-linkbutton" plain="true" >保存</a>
			</div>
		</div>
		<div region="center" style="overflow:auto;padding:5px;" border="false">
			<form id="standardForm" method="post">
				<table class="table-edit" width="80%" align="center">
					<tr class="title">
						<td colspan="2">收派标准信息</td>
					</tr>
					<tr>
						<td>标准名称</td>
						<td>
						<input type="hidden" name="id" id="standard_id" />
						<input type="text" class="easyui-validatebox" required="true" name="name" id="name"/></td>
					</tr>
					<tr>
						<td>最小重量</td>
						<td><input type="text" class="easyui-numberbox"  name="minweight" id="minweight"/></td>
					</tr>
					<tr>
						<td>最大重量</td>
						<td><input type="text" class="easyui-numberbox" name="maxweight" id="maxweight"/></td>
					</tr>
					</table>
			</form>
		</div>
	</div>
</body>
</html>