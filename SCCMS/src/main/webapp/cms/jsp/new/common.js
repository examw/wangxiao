(function($){
	$('#search_button').click(function(){
		$("#search_form").submit();
		});
	//搜索初始化
	function chkCss(){	
		$("input[class='search1']").each(function(){
			setCss($(this));
			$(this).focus(function(){
				clearCss($(this));
			});
			$(this).blur(function(){
				setCss($(this));
			});
		});	
		$('#loginout').click(function(){
			loginout();
		})
	}
	
	function loginout()
	{
		$.ajax({
    		async:true,
    		type:"POST",
    		dataType:'json',
    		url:"/stuCenter.do?logout",
    		success:function(data)
    		{
    			if(data.success)
    			{
    				location.reload(); 
    			}else
    			{
    				alert("退出失败");
    			}
    		},
    		error:function()
    		{
    			alert("系统异常");
    		}	
    	});
	}
	function setCss(obj){
		if(obj.val() != "")	clearCss(obj);
		else fillCss(obj);
	} 
	function clearCss(obj){
		obj.css("background-position","-20px -35px");
	}
	function fillCss(obj){
		obj.css("background-position","-20px -7px");
	}
	/*$.post("/user/userName",function(result){
		if(result!=null){
			$("#top_loginarea").html("您好，"+result+"（<a href='/user/stuLogin'  target='_blank' cl class='cRed1 bold'>会员中心</a>）"+"【<a href='javascript:;' id='loginout'  class='cRed1 bold'>退出</a>】");
	
		}else{
			$("#top_loginarea").html("您好，请先<a href='/user/stuLogin'  target='_blank' class='bold'>登录</a>&nbsp;<a href='/user/register.jsp'  target='_blank' class='bold'>注册</a>");
		}
	});*/
	$.ajax({
		   type:"POST",
		   url:"/user/checkStu",
		   dataType:'json',
		   success:function(data){
			   if(data.ok){
				   $("#top_loginarea").html("您好，"+data.name+"（<a href='/user/stuLogin'  target='_blank' cl class='cRed1 bold'>会员中心</a>）"+"【<a href='javascript:;' id='loginout'  class='cRed1 bold'>退出</a>】");
			   }
			   else{
				   $("#top_loginarea").html("您好，请先<a href='/user/stuLogin'  target='_blank' class='bold'>登录</a>&nbsp;<a href='/user/register.jsp'  target='_blank' class='bold'>注册</a>");
			   }
		   }
	   });
	$("#J_SearchTab").hover(
		  function () {
			$(this).addClass("triggers-hover");
		  },
		  function () {
		    $(this).removeClass("triggers-hover");
		  }
			); 
	$("li[data-searchtype='item']").each(function(){
		$(this).click(function(){
			//当前选择
			$(this).addClass('selected');
			//根据选择获得action
			$("#search_form").attr('action',$(this).attr('data-defaultpage'))
			//其他移除选
			$li =$(this).siblings().clone([true]);
			$(this).siblings().remove();
			$("#test1").append($li)
			$("#J_SearchTab").removeClass("triggers-hover");
		})
	})
	setTimeout(function(){chkCss();},100);
})(jQuery);    