<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <title></title>
    <link href="${pageContext.request.contextPath}/cms/css/ligerui-all.css" rel="stylesheet" type="text/css" />
    <link href="${pageContext.request.contextPath}/cms/css/sliver/all.css" rel="stylesheet" type="text/css" /> 
    <script src="${pageContext.request.contextPath}/cms/js/jquery-1.5.2.min.js" type="text/javascript"></script>
    <script src="${pageContext.request.contextPath}/cms/js/base.js" type="text/javascript"></script>
   	<script src="${pageContext.request.contextPath}/cms/js/ligerLayout.js" type="text/javascript"></script>
   	<script src="${pageContext.request.contextPath}/cms/js/ligerTree.js" type="text/javascript"></script>
   	<script src="${pageContext.request.contextPath}/cms/js/ligerTab.js" type="text/javascript"></script>
   	<script src="${pageContext.request.contextPath}/cms/js/ligerDialog2.js" type="text/javascript"></script>
    <script src="${pageContext.request.contextPath}/cms/js/ligerMenu.js" type="text/javascript"></script>
    <script src="${pageContext.request.contextPath}/cms/js/ligerDrag.js" type="text/javascript"></script> 
    <script src="${pageContext.request.contextPath}/cms/js/LG.js" type="text/javascript"></script>
    <script src="${pageContext.request.contextPath}/cms/js/ligerAccordion.js" type="text/javascript"></script>
    <link href="${pageContext.request.contextPath}/cms/css/common.css" rel="stylesheet" type="text/css" />  
    <script src="${pageContext.request.contextPath}/cms/js/common.js" type="text/javascript"></script>  

    <style type="text/css">
    .l-panel td.l-grid-row-cell-editing { padding-bottom: 2px;padding-top: 2px;}
        .l-table-edit {margin-top:180px}
        .l-table-edit-td{ padding:4px;}
        .l-button-submit,.l-button-reset{width:80px; float:left; margin-left:10px; padding-bottom:2px;}
    </style>
</head>
<body style="padding:2px;text-align:center;">
  <div class="layout1">
  	 <div position="left">
  	<div class="accordion1" > 
	      <div title="栏目" id="lesson">
              			<div id="maintree"></div>
        </div>	
  	</div> 
  	</div>    
    <div position="center" title="操作" > 
    <div class="layout1">
    		 <div position="left" title="资讯" id="mainmenu">
    		 	<div class="accordion1" > 
       				<div title="资讯类别" id="lesson">
           				<div id="classtree"></div>
     				</div>	
  				</div>    
    		 </div>
    		 <div  position="center" title="资讯发布" >
    		 		<table cellpadding="0" cellspacing="0" class="l-table-edit" style="margin-left:10px">
    		 		<tr style="margin-top:20px">
    		 			<td >更新前</td>
    		 			<td ><input type="text" name="number" id="number"/>行(默认前200条)</td>
    		 		</tr>
    		 		<tr><td colspan="2">&nbsp;</td></tr>
    		 		<tr style="margin-top:20px">
    		 			<td >分页单页条数</td>
    		 			<td ><input type="text" name="pagenum" id="pagenum"/>行(默认35条)</td>
    		 		</tr>
    		 		<tr><td colspan="2">&nbsp;</td></tr>
    		 		<tr>
    		 			<td>同时发布首页</td>
    		 			<td>
    		 				<label><input type="radio" name="withIndex" value="1" checked="checked"/>是</label>
    		 				<label><input type="radio" name="withIndex" value="0"/>否</label>
    		 			</td>
    		 		</tr>
    		 		<tr><td colspan="2">&nbsp;</td></tr>
    		 		<tr>
    		 			<td>同时发布栏目首页</td>
    		 			<td>
    		 				<label><input type="radio" name="withColumn" value="1" checked="checked"/>是</label>
    		 				<label><input type="radio" name="withColumn" value="0"/>否</label>
    		 			</td>
    		 		</tr>
    		 		<tr><td colspan="2">&nbsp;</td></tr>
        			<tr>
            		<td><input type="button" value="发布资讯" class="l-button l-button-reset" onclick="f_release('发布资讯',1)"/></td>
       			 </tr>  
   				</table>
    		 </div>
    	</div>
    </div>
  </div>
<script type="text/javascript">
	 function f_heightChanged(options) {
            if (accordion && options.middleHeight - 24 > 0)
                accordion.setHeight(options.middleHeight - 24);
        }
	$(function ()
           { 
				layout = $(".layout1").ligerLayout({ height: '100%', leftWidth: 220, onHeightChanged: f_heightChanged, minLeftWidth: 120 });
          		var bodyHeight = $(".l-layout-center:first").height();
          		
                accordion = $(".accordion1").ligerAccordion({ height: bodyHeight-24, speed: null ,changeHeightOnResize:true});
                
          });
      //验证
	 $(function ()
            { 
            //layout
            layout = $("#layout").ligerLayout({ height: '100%', heightDiff: -3, leftWidth: 190, minLeftWidth: 120 });
             layout1 = $("#layout1").ligerLayout();
            });
    
      //覆盖本页面grid的loading效果
    LG.overrideGridLoading(); 
    var currentMenuParentNo;
    tree1=$("#maintree").ligerTree(
            {
                checkbox:true, 
                treeLine :true,
                icon: 'archives',
                nodeWidth :100,   
                slide :false,
                url: "${pageContext.request.contextPath}/exam/examTree",
                textFieldName:"examName",
                idFieldName:"examId",
                parentIDFieldName:"examPid",
                btnClickToToggleOnly:false  ,
                onClick: function (node)
		        {
		        }      
            });
    newsClassTree = $("#classtree").ligerTree({
        url: "${pageContext.request.contextPath}/new/tree.action",
        textFieldName: "classCname",
        checkbox: true,
        nodeWidth:60,  
        nodeDraggable: false, 
        icon: 'archives',
        idFieldName:"id",
        parentIDFieldName:"parentId"
    });
    //预览
    function f_preview(){
    	var text =getChecked();
    	if(text.length!=1){
    		$.ligerDialog.warn('请选择单个考试');
    		return;
    	}
    	 window.loginWin=$.ligerDialog.open({ 
	          	  	url: "http://localhost:8080/main/main?examId="+text[0],
	          	    title:'预览',
	          	    isHidden: false,
	          	    icon: 'images/Program Files Folder.png',
	          	    height: 500,width:900
	          	    });	       
    }   
    //发布
     function f_release(title,category){
     	if(getChecked(0).length==0){
     	$.ligerDialog.warn('请选择考试');
    	return;
     	}
     	if(getChecked(1).length==0){
         	$.ligerDialog.warn('请选择资讯类别');
        	return;
         	}
     	var text = getChecked(0);
     	var text2 = getChecked(1);
     	var text3 = Number($("#number").val());
     	var text4 = $("input[name='withIndex']:checked").val();
    	var text5 = $("input[name='withColumn']:checked").val();
    	var text6 = Number($("#pagenum").val());
     	if(!text3) text3 = 200;
     	if(!text6) text6 = 35;
     	window.loginWin=$.ligerDialog.open({ 
			          	  	url: '${pageContext.request.contextPath}/cms/jsp/new/demo.jsp?examId='+text+'&category='+text2+'&num='+text3+'&withIndex='+text4+'&withColumn='+text5+'&pagenum='+text6,
			          	    title:title,
			          	    isHidden: false,
			          	    icon: 'images/Program Files Folder.png',
			          	    height: 200,width: 300
		});		
     	
			    
    }
    function getChecked(tag)
        {
        	var text = [];
        	if(tag == 0)
        	{
            var nodes = tree1.getChecked();
            $(nodes).each(function (i, node)
                    {
                        if (node.data.children) return;
                        text.push(node.data.examId);
                    });
        	}else{
        		var nodes = newsClassTree.getChecked();
                $(nodes).each(function (i, node)
                        {
                            text.push(node.data.id);
                        });
        	}
            return text;
        }
        
    function  f_closeWindow()
   			{
                //$.ligerDialog.close();  //写法1，这么写遮罩会不消失，这不是坑爹么？？
               window.loginWin.close(); 
    		}                
        
 </script>
</body>
</html>
