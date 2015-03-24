<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<%@taglib uri="/struts-tags" prefix="s"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
 
<body topmargin="2" leftmargin="2">
<script type="text/javascript">
</script>
<form id="questionForm" name="questionForm" method="post" action="">
<input type="hidden" name="tips.id" id="tipsId" value="${tips.id }"/>
<table width="100%" border="0" align="center" cellpadding="5" cellspacing="0">
	<tr>
    	<td>资讯标题</td>
        <td valign="middle">
            <input id="title" type="text" name="tips.title" class="l-text" style="width:400px;" value="${tips.title}" onblur="checkNull(this,$('#msg'));">
        </td>
    </tr>
    <tr>
    <tr>
        <td width="10%" align="center">
            资讯内容：
        </td>
        <td>
            <textarea name="content" cols="100" rows="5" class="l-textarea" id="editor" style="width:651px"  >${tips.content}</textarea>
            <textarea name="tips.content" id="content" style="display:none"></textarea>
        </td>
    </tr>
    <tr>
        <td colspan="2" align="center" style="border-top:#FF6600 solid 1px;">
           <span id="msg" style="color:red">&nbsp;</span>
        </td>
    </tr>
    <tr>
        <td colspan="2" height="30" align="center">
            <input type="button" name="Submit2" onClick="commit()" value=" 保 存 ">
        </td>
    </tr>
</table>
</form>
</body>
<script type="text/javascript" src="${pageContext.request.contextPath}/cms/js/jquery-1.4.3.js"></script>
<script type="text/javascript" charset="utf-8" src="${pageContext.request.contextPath}/cms/ueditor/editor.min.js"></script> 
<script type="text/javascript" charset="utf-8" src="${pageContext.request.contextPath}/cms/ueditor/editor_config.js"></script> 
<script type="text/javascript">
	   var editor,editor2;   
        editor = new UE.ui.Editor( { 
        toolbars:[['fullscreen', 'undo', 'redo', '|','bold', 'italic', 'underline', 'strikethrough', 'superscript', 'subscript', 'removeformat',
            'fontfamily', 'fontsize','forecolor','insertimage']],
        initialFrameWidth:950,
        initialFrameHeight:130,
        focus:true
        ,minFrameHeight:50
        //pasteplain:true        //纯文本粘贴
        } );
        editor.render('editor');
	//初始化连题设置
	$(function(){
		
	});
	
function checkNull(value,msg)
{
	if(!value||!$.trim(value))
	{
		$("#msg").html(msg+"不能为空");
		return false;
	}
	$("#msg").html("");
	return true;
}
function commit()
{
	if(!editor.hasContents())
	{
		$("#msg").html("题目内容不能为空!");
		return;
	}
	$.post(
			"${pageContext.request.contextPath}/tips/addOrUpdate",
			{"tips.id":$("#tipsId").val(),"tips.title":$("#title").val(),"tips.content":editor.getContent()},
			function(data){
				if(data)
				{
					alert("操作成功");
					parent.parent.closeTab("addTips");
				}else
				{
					$.ligerDialog.alert("操作失败,该记录可能不存在",function(){
						if(status=="") parent.closeTabAndFresh("addTips");
						else {
							//parent.parent.fresh("teacherList");
							parent.parent.closeTab("addTips");
							//parent.parent.selectTab("teacherList");
							}
					});
				}
			},
			"json"
		);
}
</script>
</html>
