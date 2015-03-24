<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <title></title>
    <link href="${pageContext.request.contextPath}/cms/css/ligerui-all.css" rel="stylesheet" type="text/css" />
    <link href="${pageContext.request.contextPath}/cms/css/sliver/all.css" rel="stylesheet" type="text/css" />
    <script src="${pageContext.request.contextPath}/cms/js/jquery-1.5.2.min.js" type="text/javascript"></script>
    <script src="${pageContext.request.contextPath}/cms/js/ligerui.all.js" type="text/javascript"></script>
    <script type="text/javascript" charset="utf-8" src="${pageContext.request.contextPath}/cms/ueditor/editor_config.js"></script>
   	<script type="text/javascript" charset="utf-8" src="${pageContext.request.contextPath}/cms/ueditor/editor.min.js"></script>
    <style type="text/css">
    .l-panel td.l-grid-row-cell-editing { padding-bottom: 2px;padding-top: 2px;}
    </style>
</head>
<body style="padding:2px; text-align:center;">
  <div class="layout">
     <div position="left" title="资讯" id="mainmenu">
    	 <div class="accordion" > 
       		<div title="资讯类别" id="lesson">
           		<div id="classtree"></div>
     		</div>	
  		</div>    
     </div>
     <div  position="center" title="模板编辑" >
        <div id="maingrid"  style="margin:2px;">    	
        </div> 
    </div>
  </div>
<script type="text/javascript">
   $(function (){ 
        //布局
        var bodyHeight = $(".l-layout-center:first").height();
        accordion = $(".accordion").ligerAccordion({ height: bodyHeight-35, speed: null ,changeHeightOnResize:true});
   		var examCategory = $("#classtree").ligerTree({
	        url: "${pageContext.request.contextPath}/new/examList",
	        textFieldName: "examName",
	        checkbox: false,
	        nodeWidth:60,  
	        nodeDraggable: false, 
	        isLeaf:function(node){
			       if(node.examChildrenNum!=0){
					return true;
					}
				}, 
			onSelect: function (node)
	        {
	        }
	    });
	    
	    var ue = UE.getEditor('editor', UE.utils.extend({toolbars:[['source']]}));
    	layout = $(".layout").ligerLayout({ height: '100%', heightDiff: -20, leftWidth: 150,  minLeftWidth: 120 });
		  
   	});
      
 </script>
</body>
</html>
