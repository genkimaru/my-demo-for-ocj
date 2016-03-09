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
  	<table id="grid" class="easyui-datagrid" rownumbers="true">  
  		<thead>
  			<tr>
  				<th data-options="field:'id'" width="120">编号</th>
  				<th data-options="field:'product'" width="200">商品</th>
  				<th data-options="field:'sendername'" width="80">发货人</th>
  				<th data-options="field:'senderaddr'" width="80">发货城市</th>
  				<th data-options="field:'receivername'" width="200">收货人</th>
  				<th data-options="field:'receiveraddr'" width="200">收货城市</th>
  				<th data-options="field:'check'" width="80">审核</th>
  			</tr>
  		</thead>
  		<tbody>
  				<s:iterator value="#workOrderManages" var="workOrderManage">
  				<tr>
  					<td><s:property value="#workOrderManage.id"/> </td>
  					<td><s:property value="#workOrderManage.product"/></td>
  					<td><s:property value="#workOrderManage.sendername"/></td>
  					<td><s:property value="#workOrderManage.senderaddr"/></td>
  					<td><s:property value="#workOrderManage.receivername"/></td>
  					<td><s:property value="#workOrderManage.receiveraddr"/></td>
  					<td>
  						<s:a action="workOrderManage_check" cssClass="easyui-linkbutton">审核通过
  							<s:param name="id" value="#workOrderManage.id"></s:param>
  						</s:a>
  					</td>
  				</tr>
  				</s:iterator>
  		</tbody>
  	</table>
  </div>
</body>
</html>