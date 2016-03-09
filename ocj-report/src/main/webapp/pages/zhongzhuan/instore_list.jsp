<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="/struts-tags" prefix="s" %>        
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
</head>
<body class="easyui-layout">
  <div region="center" >
  	<table id="grid" class="easyui-datagrid" rownumbers="true" fit="true">  
  		<thead>
  			<tr>
  				<th data-options="field:'id'" width="120">编号</th>
  				<th data-options="field:'name'" width="200">名称</th>
  				<th data-options="field:'executionId'" width="80">执行编号</th>
  				<th data-options="field:'workordermanage'" width="200">工作单信息</th>
  				<th data-options="field:'zhuangzhuaninfo'" width="200">中转信息</th>
  				<th data-options="field:'complete'" width="200">办理任务</th>
  			</tr>
  		</thead>
  		<tbody>
  			<s:iterator value="#zhongZhuanInfoList" var="zhongZhuanInfo">
  				<tr>
  					<td><s:property value="#zhongZhuanInfo.currentTask.id"/> </td>
  					<td><s:property value="#zhongZhuanInfo.currentTask.name"/> </td>
  					<td><s:property value="#zhongZhuanInfo.currentTask.executionId"/> </td>
  					<td><s:property value="#zhongZhuanInfo.workOrderManage"/> </td>
  					<!-- 显示中转信息 .... -->
  					<td><s:property value="#zhongZhuanInfo.transferInfos"/> </td>
  					<td>
						<s:a action="page_zhongzhuan_instore_complete" cssClass="easyui-linkbutton">办理任务
							<s:param name="taskId" value="#zhongZhuanInfo.currentTask.id" ></s:param>
						</s:a>
					</td>
  				</tr>
  			</s:iterator>
  		</tbody>
  	</table>
  </div>
</body>
</html>