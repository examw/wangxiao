<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<style type="text/css">
        center {margin-top:50px}
        
 </style>
<script src="${pageContext.request.contextPath}/cms/js/jquery-1.5.2.min.js" type="text/javascript"></script>
 <script type="text/javascript">
 	var text = "<%=request.getParameter("examId")%>";
 	var category ="<%=request.getParameter("category")%>";
 	var examId = text.split(",");
 	var length = examId.length;
 	var num = "<%=request.getParameter("num")%>";
 	var withIndex = "<%=request.getParameter("withIndex")%>";
 	var withColumn = "<%=request.getParameter("withColumn")%>";
 	var pagenum = "<%=request.getParameter("pagenum")%>";
 	$(function(){	
 		f_release(0);
 	});
 	
 	function f_release(i){
 		url = "${pageContext.request.contextPath}/release/releaseNewsList";
 		$.post(url,{examId:examId[i],newsClassIds:category,num:num,withIndex:withIndex,withColumn:withColumn,pagenum:pagenum},
          					function(ok){
          						if(ok==true){
          							$("center").html("第<span style=\"color:green;\">"+(i+1)+"</span>个考试发布成功，共<span style=\"color:red;\">"+length+"</span>个栏目");
          							if(i==length-1){ 
          								$("center").html("<span style=\"color:green;\">发布完成，共发布<span style=\"color:red;\">"+length+"</span>个栏目");
          								setTimeout(parent.f_closeWindow,3000);
          							}else{
          								f_release(i+1);
          							}

          						}else{
          							$("center").html("第<span style=\"color:red;\">"+(i+1)+"</span>个考试发布失败，共<span style=\"color:red;\">"+length+"</span>个栏目");
          						}
							},
							"json"
          					);
 	}
 </script>
<title>发布课程</title>
</head>
<body>
	<center>
		<span style="color: green">准备发布中.....</span>
	</center>
</body>
</html>