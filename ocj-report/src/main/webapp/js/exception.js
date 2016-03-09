$.ajaxSetup({
	beforeSend : function(){
		alert("请求前...");
	},
	error : function (XMLHttpRequest, textStatus, errorThrown){
		alert("出错了...");
	}
});