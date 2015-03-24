<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <title></title>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" /> 
    <link href="../../css/ligerui-all.css" rel="stylesheet" type="text/css" />
    <link href="${pageContext.request.contextPath}/cms/css/sliver/all.css" rel="stylesheet" type="text/css" /> 
    <script src="../../js/jquery-1.3.2.min.js" type="text/javascript"></script>
    <script src="../../js/base.js" type="text/javascript"></script> 
    <script src="../../js/ligerGrid.js" type="text/javascript"></script>
    <script src="../../js/ligerResizable.js" type="text/javascript"></script>
    <script src="../../js/ligerDrag.js" type="text/javascript"></script>
    <script src="../../js/ligerTab.js" type="text/javascript"></script>
    <script src="../../js/ligerToolBar.js" type="text/javascript"></script>
    <script src="../../js/CustomersData.js" type="text/javascript"></script>
    <script src="../../js/ligerButton.js" type="text/javascript"></script>
    <script src="../../js/ligerDialog.js" type="text/javascript"></script>
    <script src="../../js/ligerMenu.js" type="text/javascript"></script>
    <style type="text/css">
    	.l-select{
    	border:1px solid #AECAF0; 
    	background:#DBEBFF url('../../images/controls/bg-trigger.gif') repeat-x left;}
    </style>
    <script type="text/javascript">
    	$.ligerDefaults.Grid.formatters['mydate'] = function (value, column) {
    	 	if(!value) return "";
    	 	return value.toString().replace("T","  ");
    	 };
        var g,manager;
        
        $(function ()
        {
            g = $("#maingrid4").ligerGrid({
                columns: [ 
                {display:'编号' ,name:'id',isAllowHide:true,hide:1},
                {display: '标题', name: 'title', width: 280 } ,
                { display: '添加时间', name: 'addtime', minWidth: 280 }
                ], url:"${pageContext.request.contextPath}/tips/tipsList", pageSize: 10,sortName:'addtime',sortOrder:'desc',method:"post",
                width: '98%', height: '98%', rownumbers:true,dateFormat:"yyyy-MM-dd",dataAction:"server",rowHeight: 25,headerRowHeight:30, 
                toolbar: { items: [
                { text: '增加', click: f_add, img: '../../images/icon/add.gif' },
                { line: true },
                { text: '修改', click: f_modify, img: '../../images/icon/modify.gif' },
                { line: true },
                { text: '删除', click: f_delete, img: '../../images/icon/delete.gif' },
                 { line: true },
                { text: '刷新', click: f_reload, img: '../../images/icon/refresh.gif' }
                ]}
            });
            manager=$("#maingrid4").ligerGetGridManager();
            //绑定双击事件
           	// manager.bind("dblClickRow",
            //			function(rowdata, rowindex, rowDomElement){
            //				parent.addTab("teacherDetail","${pageContext.request.contextPath}/user/loadTeacher1?id="+rowdata.tchId,"详细信息");
            //			});
            $("#pageloading").hide();
            $("#searchbtn").click( function ()
            {
               f_search();
            });
        });
       
        //添加
        function f_add()
        {
        	parent.addTab("addTips","${pageContext.request.contextPath}/cms/jsp/tips/addTips.jsp","添加资讯");
        }
        //修改
        function f_modify()
        {
            var row = manager.getSelectedRow();
            if (!row) { alert('请选择行'); return; }
            parent.addTab("addTips","${pageContext.request.contextPath}/tips/loadTips?id=" + row.id,"修改资讯");
        }
        //刷新
        function f_reload()
        {
            manager.loadData();
        }
        //删除
        function f_delete()
        {
            var row = manager.getSelectedRow();
            if (!row) { alert('请选择行'); return; }
            $.ligerDialog.confirm("确认删除吗？",function (r)
            {
  				if(r)
            	{
            		$.ajax({
            		async:true,
            		type:'POST',
            		url:"${pageContext.request.contextPath}/tips/deleteTips", 
            		data:{"id": row.id },
            		dataType:'json', 
            		success:function (data)
            		{
                		if(data)
                		{
                			$.ligerDialog.success( '删除成功!', function ()
                			{
                    			manager.loadData();
                			}); 
                		}
            		},
            		error:function(){alert('系统错误');}
            	});
            	}
            });
        }
        //封装alert方法
        var alert = function (content)
        {
            $.ligerDialog.alert(content);
        };
        //搜索
        function f_search()
        {
        	//如果搜索框为空，提示
        	if(!$.trim($("#content").val()))
        	{
        		alert("请输入搜索内容！");
        		return;
        	}
        	//显示返回按钮
            $("#back").show();
            //加载搜索结果
            var str = escape(escape($("#content").val()));
            g.set({url:"${pageContext.request.contextPath}/user/searchTeacher?str="+str+"&searchName="+$("#search").val(),newPage:1});
        }
        //返回
        function f_back()
        {
        	$("#back").hide();
        	g.set({url:"${pageContext.request.contextPath}/user/teacherList",newPage:1});
        }
    </script>
</head>
<body style="padding: 4px; overflow: hidden;">
<div id="navtab1" style="width: 100%;overflow:hidden; border:1px solid #A3C0E8; ">
<!-- 增删改button----------------------------------------
<a class="l-button" style="width:60px; float:left; margin-left:10px;" onclick="f_add()">添加</a>
<a class="l-button" style="width:60px; float:left; margin-left:10px;" onclick="f_modify()">修改</a>
<a class="l-button" style="width:60px; float:left; margin-left:10px;" onclick="f_delete()">删除</a>
<a class="l-button" style="width:60px; float:left; margin-left:10px;" onclick="f_reload()">刷新</a>-->
<div tabid="home" title="资讯列表" lselected="true"  style="height:100%" >
<!-- search button---------------------------------------- --
<div class="l-panel-search" >
    <div class="l-panel-search-item">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 搜索： 
    </div>
    <div class="l-panel-search-item">
        <input class="l-text" type="text" id="content" />
    </div>
     <div class="l-panel-search-item">
        <select name="searchName" class="l-select" id="search" ltype="select">
			<option value="tchId" selected="selected">按编号</option>
			<option value="tchUsername">按用户名</option>
			<option value="tchName">按姓名</option>
		</select>
    </div>
    <div class="l-panel-search-item">
        <div id="searchbtn" class="l-btn"  style="width:80px;">搜索<div class="l-btn-l"></div><div class="l-btn-r"></div><span></span></div>
    </div>
    <div class="l-panel-search-item">
        <div id="back" class="l-btn"  style="width:80px;display:none" onclick="f_back()">返回<div class="l-btn-l"></div><div class="l-btn-r"></div><span></span></div>
    </div>
</div-->
<!--表格 ---------------------------------------- -->
    <div class="l-loading" style="display: block" id="pageloading">
    </div> 
    <div id="maingrid4" style="margin: 0; padding: 0">
    </div>
    <div style="display: none;">
    </div>
</div>
</div>
</body>
</html>
