SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tbAppAdvice]') AND type in (N'U'))
BEGIN
-- APP建议表
CREATE TABLE [dbo].[tbAppAdvice](
	[id] [int] IDENTITY(1,1) NOT NULL,	-- ID
	[advice_content] [varchar](2000) NOT NULL,	--内容
	[advice_addTime] [datetime] NOT NULL,	--添加时间
	[advice_appType] [int] NOT NULL,	--类型
	[username] [varchar](50) NULL,	--用户名
	[stu_id] [int] NULL,	--用户ID
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (IGNORE_DUP_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tbNews]') AND type in (N'U'))
BEGIN
-- 新闻表
CREATE TABLE [dbo].[tbNews](
	[new_id] [int] IDENTITY(1001,1) NOT NULL,	--ID
	[new_title] [varchar](500) NOT NULL,	--标题
	[sub_time] [varchar](500) NULL,		--
	[new_content] [text] NOT NULL,		--内容
	[click_num] [int] NULL DEFAULT ((0)),	--点击数
	[is_top] [int] NULL DEFAULT ((0)),	--是否置顶
	[new_templet] [varchar](250) NULL,	--模板
	[new_path] [varchar](250) NULL,	--路径
	[exam_id] [int] NULL,	--考试ID
	[class_id] [int] NULL,	--分类ID
	[order_id] [int] NULL DEFAULT ((0)),	--排序号
	[add_time] [datetime] NOT NULL,	--添加时间
	[aditor] [varchar](100) NOT NULL,	--编辑
	[province_id] [int] NULL DEFAULT (NULL),	--地区
	[new_keywords] [varchar](250) NULL DEFAULT (NULL),	--关键字
	[new_description] [varchar](512) NULL,	--描述
PRIMARY KEY CLUSTERED 
(
	[new_id] ASC
)WITH (IGNORE_DUP_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- 自定义id增长函数
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tradeIdSequence]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
BEGIN
execute dbo.sp_executesql @statement = N'CREATE    FUNCTION    [dbo].[tradeIdSequence]() 
RETURNS    INT 
AS 
BEGIN 
    DECLARE    @MINNUM    INT 
    DECLARE    @MAXNUM    INT 
    SET    @MINNUM=1    
    SET    @MAXNUM=1999999999 
    RETURN(    SELECT CASE    
            WHEN    ISNULL(MAX(trade_id),@MINNUM-1)+1 >@MAXNUM THEN    0 
            ELSE    ISNULL(MAX(trade_id),@MINNUM-1)+1 
               END 
        FROM tbTrade) 
END
' 
END

GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tbTrade]') AND type in (N'U'))
BEGIN
-- 交易记录表
CREATE TABLE [dbo].[tbTrade](
	[id] [int] IDENTITY(1,1) NOT NULL,	-- ID
	[trade_id] [int] NOT NULL DEFAULT ([dbo].[tradeIdSequence]()),	-- 交易ID
	[trade_time] [datetime] NOT NULL,	--交易时间
	[trade_money] [float] NOT NULL,	-- 交易金额
	[trade_ip] [varchar](20) NULL,	-- ip
	[order_id] [int] NULL,	--订单ID
	[card_id] [varchar](50) NULL,	--学习卡ID
	[trade_type] [int] NULL,	--交易类型
	[trade_note] [varchar](1000) NULL,	--备注
	[stu_id] [int] NULL,	-- 学员ID
	[trade_pattern] [varchar](20) NULL,	--支付类型
	[trade_orderNo] [varchar](30) NULL,	--订单号
	[trade_CardBalance] [float] NULL,	--学习卡余额
	[trade_CashBalance] [float] NULL,	--现金余额
PRIMARY KEY CLUSTERED 
(
	[trade_id] ASC
)WITH (IGNORE_DUP_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tchIdSequence]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
BEGIN
-- 自定义id增长函数
execute dbo.sp_executesql @statement = N'CREATE    FUNCTION    [dbo].[tchIdSequence]() 
RETURNS    INT 
AS 
BEGIN 
    DECLARE    @MINNUM    INT 
    DECLARE    @MAXNUM    INT 
    SET    @MINNUM=1001    
    SET    @MAXNUM=1999999999 
    RETURN(    SELECT CASE    
            WHEN    ISNULL(MAX(tch_id),@MINNUM-1)+1 >@MAXNUM THEN    0 
            ELSE    ISNULL(MAX(tch_id),@MINNUM-1)+1 
               END 
        FROM tbTeacher) 
END
' 
END

GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tbTeacher]') AND type in (N'U'))
BEGIN
-- 教师表
CREATE TABLE [dbo].[tbTeacher](
	[id] [int] IDENTITY(1,1) NOT NULL,	-- ID
	[tch_id] [int] NOT NULL CONSTRAINT [ConstraintIdForTeacher]  DEFAULT ([dbo].[tchIdSequence]()),	-- id 自定义id增长函数
	[tch_username] [varchar](20) NOT NULL,	-- 用户名
	[tch_password] [varchar](50) NOT NULL,	-- 密码
	[tch_name] [varchar](20) NOT NULL,	-- 名字
	[tch_phone] [varchar](20) NULL,	-- 电话
	[tch_addTime] [datetime] NULL,	-- 添加时间
	[tch_description] [varchar](3000) NULL,	--描述
	[tch_lessons] [varchar](100) NULL,	--所授课程
	[tch_valuation] [varchar](1000) NULL,	-- 评价
	[tch_score] [int] NULL,	--得分
	[tch_imgURL] [varchar](100) NULL,	-- 图片地址
	[tch_status] [int] NOT NULL DEFAULT ((0)),	--状态
	[tch_sex] [varchar](2) NULL,	--性别
 CONSTRAINT [PK_tchId] PRIMARY KEY CLUSTERED 
(
	[tch_id] ASC
)WITH (IGNORE_DUP_KEY = OFF) ON [PRIMARY],
UNIQUE NONCLUSTERED 
(
	[tch_username] ASC
)WITH (IGNORE_DUP_KEY = OFF) ON [PRIMARY],
UNIQUE NONCLUSTERED 
(
	[tch_id] ASC
)WITH (IGNORE_DUP_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[new_class]') AND type in (N'U'))
BEGIN
-- 新闻分类
CREATE TABLE [dbo].[new_class](
	[class_id] [int] IDENTITY(1001,1) NOT NULL,		
	[class_ename] [varchar](100) NULL DEFAULT (NULL),
	[class_cname] [varchar](100) NOT NULL,
	[del_flag] [int] NULL DEFAULT ((0)),
	[order_id] [int] NULL DEFAULT ((0)),
	[add_time] [datetime] NOT NULL,
	[descri] [varchar](500) NULL DEFAULT (NULL),
	[keywords] [varchar](500) NULL DEFAULT (NULL),
	[parent_id] [int] NULL DEFAULT (NULL),
	[class_temp] [varchar](200) NULL DEFAULT (NULL),
	[url_path] [varchar](1000) NULL,
	[pids] [varchar](100) NULL DEFAULT (NULL),
PRIMARY KEY CLUSTERED 
(
	[class_id] ASC
)WITH (IGNORE_DUP_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[itemsIdSequence]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
BEGIN
execute dbo.sp_executesql @statement = N'CREATE    FUNCTION    [dbo].[itemsIdSequence]() 
RETURNS    INT 
AS 
BEGIN 
    DECLARE    @MINNUM    INT 
    DECLARE    @MAXNUM    INT 
    SET    @MINNUM=1    
    SET    @MAXNUM=1999999999 
    RETURN(    SELECT CASE    
            WHEN    ISNULL(MAX(item_id),@MINNUM-1)+1 >@MAXNUM THEN    0 
            ELSE    ISNULL(MAX(item_id),@MINNUM-1)+1 
               END 
        FROM tbItems) 
END
' 
END

GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[orderIdSequence]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
BEGIN
execute dbo.sp_executesql @statement = N'CREATE    FUNCTION    [dbo].[orderIdSequence]() 
RETURNS    INT 
AS 
BEGIN 
    DECLARE    @MINNUM    INT 
    DECLARE    @MAXNUM    INT 
    SET    @MINNUM=1001    
    SET    @MAXNUM=1999999999 
    RETURN(    SELECT CASE    
            WHEN    ISNULL(MAX(order_id),@MINNUM-1)+1 >@MAXNUM THEN    0 
            ELSE    ISNULL(MAX(order_id),@MINNUM-1)+1 
               END 
        FROM tbOrder) 
END
' 
END

GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[orderNoSequence]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
BEGIN
execute dbo.sp_executesql @statement = N'CREATE    FUNCTION    [dbo].[orderNoSequence]() 
RETURNS    varchar(50) 
AS 
BEGIN 
    DECLARE    @DAT    varchar(10) 
    DECLARE    @MAXID  INT 
    DECLARE    @MINNUM    INT 
    DECLARE    @MAXNUM    INT 
    SET    @MINNUM=1001    
    SET    @MAXNUM=1999999999 
    SET    @DAT=convert(varchar(10),getdate(),112) 
    SET    @MAXID=(SELECT CASE    
            WHEN    ISNULL(MAX(order_id),@MINNUM-1)+1 >@MAXNUM THEN    0 
            ELSE    ISNULL(MAX(order_id),@MINNUM-1)+1 
               END 
        FROM tbOrder) 
    RETURN (@DAT+convert(varchar,@MAXID)) 
END
' 
END

GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tbTips]') AND type in (N'U'))
BEGIN
-- 公告
CREATE TABLE [dbo].[tbTips](
	[id] [int] IDENTITY(1,1) NOT NULL,	-- ID
	[title] [varchar](256) NOT NULL,	--标题
	[addtime] [datetime] NULL,	--添加时间
	[content] [text] NOT NULL,	--内容
	[create_by] [varchar](32) NULL,	--编辑
	[click_num] [int] NULL,	--点击数
	[source] [varchar](128) NULL,	--来源
 CONSTRAINT [id] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (IGNORE_DUP_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tbGradeCategory]') AND type in (N'U'))
BEGIN
-- 班级分类表
CREATE TABLE [dbo].[tbGradeCategory](
	[id] [int] IDENTITY(1,1) NOT NULL,	
	[gType_id] [int] NOT NULL,	--类别ID
	[gType_name] [varchar](20) NOT NULL,	--类别名称
 CONSTRAINT [PK_TBGRADECATEGORY] PRIMARY KEY CLUSTERED 
(
	[gType_id] ASC
)WITH (IGNORE_DUP_KEY = OFF) ON [PRIMARY],
UNIQUE NONCLUSTERED 
(
	[gType_id] ASC
)WITH (IGNORE_DUP_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tbLink]') AND type in (N'U'))
BEGIN
-- 友情链接
CREATE TABLE [dbo].[tbLink](
	[id] [int] IDENTITY(1,1) NOT NULL,	--IDENTITY
	[name] [varchar](128) NULL,	-- 名字
	[url] [varchar](512) NULL,	--URL
	[addtime] [datetime] NULL,	-- 添加时间
	[creator] [varchar](64) NULL,	--编辑
	[status] [int] NULL	--状态
) ON [PRIMARY]
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tbExamCategory]') AND type in (N'U'))
BEGIN
-- 考试分类
CREATE TABLE [dbo].[tbExamCategory](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[exam_id] [int] NOT NULL,	-- ID
	[exam_name] [varchar](50) NOT NULL,	 -- 名称
	[exam_pid] [int] NULL DEFAULT ((0)),	--父ID
	[exam_childrenNum] [int] NOT NULL,	--子数
	[exam_addTime] [datetime] NOT NULL,	--添加时间
	[exam_orderId] [int] NOT NULL,	--排序号
	[isexpand] [varchar](5) NULL DEFAULT ('false'),	--是否展开
	[examUrl] [varchar](50) NULL,	--url
	[examDescription] [nvarchar](1000) NULL,	--描述
	[exam_ename] [varchar](50) NULL,	--英文名
	[status] [int] NULL DEFAULT ((0)),	--状态
	[title] [text] NULL,	--标题
	[description] [text] NULL,	--描述
	[keywords] [text] NULL,	--关键字
	[parentsId] [varchar](200) NULL,	--父类IDs
 CONSTRAINT [PK_TBEXAMCATEGORY] PRIMARY KEY CLUSTERED 
(
	[exam_id] ASC
)WITH (IGNORE_DUP_KEY = OFF) ON [PRIMARY],
UNIQUE NONCLUSTERED 
(
	[exam_id] ASC
)WITH (IGNORE_DUP_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[province]') AND type in (N'U'))
BEGIN
-- 地区表
CREATE TABLE [dbo].[province](
	[province_id] [int] IDENTITY(1001,1) NOT NULL,	--IDENTITY
	[province_name] [varchar](100) NOT NULL,	--名称
	[parent_id] [int] NULL DEFAULT (NULL),	--父ID
	[province_code] [int] NULL DEFAULT (NULL),	--编码
	[province_ename] [varchar](50) NULL,	--英文名
PRIMARY KEY CLUSTERED 
(
	[province_id] ASC
)WITH (IGNORE_DUP_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[collectIdSequence]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
BEGIN
execute dbo.sp_executesql @statement = N'CREATE    FUNCTION    [dbo].[collectIdSequence]() 
RETURNS    INT 
AS 
BEGIN 
    DECLARE    @MINNUM    INT 
    DECLARE    @MAXNUM    INT 
    SET    @MINNUM=1    
    SET    @MAXNUM=1999999999 
    RETURN(    SELECT CASE    
            WHEN    ISNULL(MAX(collect_id),@MINNUM-1)+1 >@MAXNUM THEN    0 
            ELSE    ISNULL(MAX(collect_id),@MINNUM-1)+1 
               END 
        FROM tbQuestionCollect) 
END
' 
END

GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[cardIdSequence]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
BEGIN
execute dbo.sp_executesql @statement = N'CREATE    FUNCTION    [dbo].[cardIdSequence]() 
RETURNS    INT 
AS 
BEGIN 
    DECLARE    @MINNUM    INT 
    DECLARE    @MAXNUM    INT 
    SET    @MINNUM=1001    
    SET    @MAXNUM=1999999999 
    RETURN(    SELECT CASE    
            WHEN    ISNULL(MAX(card_id),@MINNUM-1)+1 >@MAXNUM THEN    0 
            ELSE    ISNULL(MAX(card_id),@MINNUM-1)+1 
               END 
        FROM tbCard) 
END
' 
END

GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tbCard]') AND type in (N'U'))
BEGIN
-- 学习卡
CREATE TABLE [dbo].[tbCard](
	[id] [int] IDENTITY(1,1) NOT NULL,	--ID
	[card_id] [int] NOT NULL CONSTRAINT [ConstraintIdForCard]  DEFAULT ([dbo].[cardIdSequence]()), --学习卡ID
	[card_password] [varchar](50) NOT NULL,	--密码
	[card_value] [int] NOT NULL,	--面值
	[card_addTime] [datetime] NOT NULL,	--添加时间
	[card_overTime] [datetime] NOT NULL,	--过期时间
	[stu_id] [bigint] NULL,	--学员ID
	[card_useTime] [datetime] NULL,	--使用时间
	[card_isPresent] [int] NULL DEFAULT ((0)),	--是否赠送
	[card_balance] [float] NULL,	--余额
	[create_username] [varchar](64) NULL,	--创建人
	[prefix] [varchar](64) NULL,
 CONSTRAINT [PK_TBCARD] PRIMARY KEY CLUSTERED 
(
	[card_id] ASC
)WITH (IGNORE_DUP_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[acIdSequence]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
BEGIN
execute dbo.sp_executesql @statement = N'CREATE    FUNCTION    [dbo].[acIdSequence]() 
RETURNS    INT 
AS 
BEGIN 
    DECLARE    @MINNUM    INT 
    DECLARE    @MAXNUM    INT 
    SET    @MINNUM=1    
    SET    @MAXNUM=1999999999 
    RETURN(    SELECT CASE    
            WHEN    ISNULL(MAX(ac_id),@MINNUM-1)+1 >@MAXNUM THEN    0 
            ELSE    ISNULL(MAX(ac_id),@MINNUM-1)+1 
               END 
        FROM tbAskOrComplain) 
END
' 
END

GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tbAskOrComplain]') AND type in (N'U'))
BEGIN
-- 咨询与投诉
CREATE TABLE [dbo].[tbAskOrComplain](
	[id] [int] IDENTITY(1,1) NOT NULL,	
	[ac_id] [int] NOT NULL DEFAULT ([dbo].[acIdSequence]()),
	[grade_id] [int] NULL,	--班级ID
	[ac_name] [varchar](100) NOT NULL,	--名称
	[ac_type] [int] NOT NULL,	--类型
	[ac_status] [int] NOT NULL DEFAULT ((0)),	--状态
	[ac_addTime] [datetime] NOT NULL,
	[ac_content] [text] NOT NULL,
	[stu_id] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[ac_id] ASC
)WITH (IGNORE_DUP_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[answerIdSequence]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
BEGIN
execute dbo.sp_executesql @statement = N'CREATE    FUNCTION    [dbo].[answerIdSequence]() 
RETURNS    INT 
AS 
BEGIN 
    DECLARE    @MINNUM    INT 
    DECLARE    @MAXNUM    INT 
    SET    @MINNUM=1    
    SET    @MAXNUM=1999999999 
    RETURN(    SELECT CASE    
            WHEN    ISNULL(MAX(answer_id),@MINNUM-1)+1 >@MAXNUM THEN    0 
            ELSE    ISNULL(MAX(answer_id),@MINNUM-1)+1 
               END 
        FROM tbAnswer) 
END
' 
END

GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[questionIdSequence]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
BEGIN
execute dbo.sp_executesql @statement = N'CREATE    FUNCTION    [dbo].[questionIdSequence]() 
RETURNS    INT 
AS 
BEGIN 
    DECLARE    @MINNUM    INT 
    DECLARE    @MAXNUM    INT 
    SET    @MINNUM=1    
    SET    @MAXNUM=1999999999 
    RETURN(    SELECT CASE    
            WHEN    ISNULL(MAX(question_id),@MINNUM-1)+1 >@MAXNUM THEN    0 
            ELSE    ISNULL(MAX(question_id),@MINNUM-1)+1 
               END 
        FROM tbQuestion) 
END
' 
END

GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[admIdSequence]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
BEGIN
execute dbo.sp_executesql @statement = N'CREATE    FUNCTION    [dbo].[admIdSequence]() 
RETURNS    INT 
AS 
BEGIN 
    DECLARE    @MINNUM    INT 
    DECLARE    @MAXNUM    INT 
    SET    @MINNUM=1001    
    SET    @MAXNUM=1999999999 
    RETURN(    SELECT CASE    
            WHEN    ISNULL(MAX(adm_id),@MINNUM-1)+1 >@MAXNUM THEN    0 
            ELSE    ISNULL(MAX(adm_id),@MINNUM-1)+1 
               END 
        FROM tbAdministor) 
END
' 
END

GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[addrIdSequence]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
BEGIN
execute dbo.sp_executesql @statement = N'CREATE    FUNCTION    [dbo].[addrIdSequence]() 
RETURNS    INT 
AS 
BEGIN 
    DECLARE    @MINNUM    INT 
    DECLARE    @MAXNUM    INT 
    SET    @MINNUM=1001    
    SET    @MAXNUM=1999999999 
    RETURN(    SELECT CASE    
            WHEN    ISNULL(MAX(addr_id),@MINNUM-1)+1 >@MAXNUM THEN    0 
            ELSE    ISNULL(MAX(addr_id),@MINNUM-1)+1 
               END 
        FROM tbAddress) 
END
' 
END

GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tbAddress]') AND type in (N'U'))
BEGIN
-- 地址表
CREATE TABLE [dbo].[tbAddress](
	[id] [int] IDENTITY(1,1) NOT NULL,		--ID
	[addr_id] [int] NOT NULL CONSTRAINT [ConstraintIdForAddress]  DEFAULT ([dbo].[addrIdSequence]()),	--ID
	[addr_receiveName] [varchar](20) NOT NULL,	--收货人
	[addr_fullAddress] [varchar](100) NOT NULL,	--地址
	[addr_mobile] [varchar](20) NOT NULL,	--手机
	[addr_email] [varchar](50) NULL,	--
	[addr_phone] [varchar](20) NULL,
	[addr_postalCode] [varchar](20) NULL,	--邮编
	[stu_id] [int] NOT NULL,
	[addr_isDefault] [int] NULL,	--默认
 CONSTRAINT [PK_TBADDRESS] PRIMARY KEY CLUSTERED 
(
	[addr_id] ASC
)WITH (IGNORE_DUP_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sendIdSequence]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
BEGIN
execute dbo.sp_executesql @statement = N'CREATE    FUNCTION    [dbo].[sendIdSequence]() 
RETURNS    INT 
AS 
BEGIN 
    DECLARE    @MINNUM    INT 
    DECLARE    @MAXNUM    INT 
    SET    @MINNUM=1001    
    SET    @MAXNUM=1999999999 
    RETURN(    SELECT CASE    
            WHEN    ISNULL(MAX(send_id),@MINNUM-1)+1 >@MAXNUM THEN    0 
            ELSE    ISNULL(MAX(send_id),@MINNUM-1)+1 
               END 
        FROM tbSend) 
END
' 
END

GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[replyIdSequence]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
BEGIN
execute dbo.sp_executesql @statement = N'CREATE    FUNCTION    [dbo].[replyIdSequence]() 
RETURNS    INT 
AS 
BEGIN 
    DECLARE    @MINNUM    INT 
    DECLARE    @MAXNUM    INT 
    SET    @MINNUM=1    
    SET    @MAXNUM=1999999999 
    RETURN(    SELECT CASE    
            WHEN    ISNULL(MAX(reply_id),@MINNUM-1)+1 >@MAXNUM THEN    0 
            ELSE    ISNULL(MAX(reply_id),@MINNUM-1)+1 
               END 
        FROM tbReply) 
END
' 
END

GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[examQuestionIdSequence]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
BEGIN
execute dbo.sp_executesql @statement = N'CREATE    FUNCTION    [dbo].[examQuestionIdSequence]() 
RETURNS    INT 
AS 
BEGIN 
    DECLARE    @MINNUM    INT 
    DECLARE    @MAXNUM    INT 
    SET    @MINNUM=1001    
    SET    @MAXNUM=1999999999 
    RETURN(    SELECT CASE    
            WHEN    ISNULL(MAX(quest_id),@MINNUM-1)+1 >@MAXNUM THEN    0 
            ELSE    ISNULL(MAX(quest_id),@MINNUM-1)+1 
               END 
        FROM tbExamQuestion) 
END
' 
END

GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tbExamQuestion]') AND type in (N'U'))
BEGIN
-- 试题表
CREATE TABLE [dbo].[tbExamQuestion](
	[id] [int] IDENTITY(1,1) NOT NULL,	
	[quest_id] [int] NOT NULL DEFAULT ([dbo].[examQuestionIdSequence]()),	--ID
	[quest_ruleId] [int] NULL,	--大题ID
	[quest_paperId] [int] NULL,	--试卷ID
	[quest_examId] [int] NULL,	--考试ID
	[quest_content] [text] NULL,	--内容
	[quest_answer] [text] NULL,	--答案
	[quest_analysis] [text] NULL,	--分析
	[quest_type] [int] NULL,	--题型
	[quest_optionNum] [int] NULL,	--选项个数
	[quest_orderId] [int] NULL,	-- 排序ID
	[quest_addTime] [datetime] NULL,	--添加时间
	[quest_linkQuestionId] [varchar](30) NULL,	--关联ID
	[quest_editor] [varchar](30) NULL,	--编辑
	[quest_clickNum] [int] NULL,	--点击数
	[quest_errorNum] [int] NULL,	--错误数
	[quest_md5code] [varchar](64) NULL,	--md5码
PRIMARY KEY CLUSTERED 
(
	[quest_id] ASC
)WITH (IGNORE_DUP_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[paperIdSequence]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
BEGIN
execute dbo.sp_executesql @statement = N'CREATE    FUNCTION    [dbo].[paperIdSequence]() 
RETURNS    INT 
AS 
BEGIN 
    DECLARE    @MINNUM    INT 
    DECLARE    @MAXNUM    INT 
    SET    @MINNUM=1001    
    SET    @MAXNUM=1999999999 
    RETURN(    SELECT CASE    
            WHEN    ISNULL(MAX(paper_id),@MINNUM-1)+1 >@MAXNUM THEN    0 
            ELSE    ISNULL(MAX(paper_id),@MINNUM-1)+1 
               END 
        FROM tbExamPaper) 
END
' 
END

GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tbExamPaper]') AND type in (N'U'))
BEGIN
-- 试卷表
CREATE TABLE [dbo].[tbExamPaper](
	[id] [int] IDENTITY(1,1) NOT NULL,	--ID
	[paper_id] [int] NOT NULL DEFAULT ([dbo].[paperIdSequence]()),
	[paper_examId] [int] NULL,	--考试ID
	[paper_e_gradeId] [int] NULL,	--班级ID
	[paper_e_g_cheaterId] [int] NULL,	--章节ID
	[paper_name] [varchar](256) NOT NULL,	--名称
	[paper_time] [int] NOT NULL,	--时间
	[paper_score] [int] NOT NULL,	--分数
	[paper_addTime] [datetime] NOT NULL,	
	[paper_type] [int] NOT NULL,	--类型
	[paper_clickNum] [int] NULL,
	[paper_isChecked] [int] NULL,	--审核
	[paper_editor] [varchar](30) NULL,
	[paper_linkName] [varchar](200) NULL,
PRIMARY KEY CLUSTERED 
(
	[paper_id] ASC
)WITH (IGNORE_DUP_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[rcIdSequence]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
BEGIN
execute dbo.sp_executesql @statement = N'CREATE    FUNCTION    [dbo].[rcIdSequence]() 
RETURNS    INT 
AS 
BEGIN 
    DECLARE    @MINNUM    INT 
    DECLARE    @MAXNUM    INT 
    SET    @MINNUM=1    
    SET    @MAXNUM=1999999999 
    RETURN(    SELECT CASE    
            WHEN    ISNULL(MAX(rc_id),@MINNUM-1)+1 >@MAXNUM THEN    0 
            ELSE    ISNULL(MAX(rc_id),@MINNUM-1)+1 
               END 
        FROM tbRechargeRecord) 
END
' 
END

GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[epcIdSequence]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
BEGIN
execute dbo.sp_executesql @statement = N'CREATE    FUNCTION    [dbo].[epcIdSequence]() 
RETURNS    INT 
AS 
BEGIN 
    DECLARE    @MINNUM    INT 
    DECLARE    @MAXNUM    INT 
    SET    @MINNUM=1001    
    SET    @MAXNUM=1999999999 
    RETURN(    SELECT CASE    
            WHEN    ISNULL(MAX(epc_id),@MINNUM-1)+1 >@MAXNUM THEN    0 
            ELSE    ISNULL(MAX(epc_id),@MINNUM-1)+1 
               END 
        FROM tbExpressCompany) 
END
' 
END

GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tbExpressCompany]') AND type in (N'U'))
BEGIN
-- 快递公司
CREATE TABLE [dbo].[tbExpressCompany](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[epc_id] [int] NOT NULL CONSTRAINT [ConstraintIdForEPC]  DEFAULT ([dbo].[epcIdSequence]()),
	[epc_name] [varchar](30) NOT NULL,
	[epc_url] [varchar](20) NOT NULL,
	[epc_phone] [varchar](15) NOT NULL,
	[epc_orderId] [int] NOT NULL,
	[epc_addr] [varchar](100) NULL,
 CONSTRAINT [PK_EPCID] PRIMARY KEY CLUSTERED 
(
	[epc_id] ASC
)WITH (IGNORE_DUP_KEY = OFF) ON [PRIMARY],
UNIQUE NONCLUSTERED 
(
	[epc_id] ASC
)WITH (IGNORE_DUP_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ruleIdSequence]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
BEGIN
execute dbo.sp_executesql @statement = N'CREATE    FUNCTION    [dbo].[ruleIdSequence]() 
RETURNS    INT 
AS 
BEGIN 
    DECLARE    @MINNUM    INT 
    DECLARE    @MAXNUM    INT 
    SET    @MINNUM=1001    
    SET    @MAXNUM=1999999999 
    RETURN(    SELECT CASE    
            WHEN    ISNULL(MAX(rule_id),@MINNUM-1)+1 >@MAXNUM THEN    0 
            ELSE    ISNULL(MAX(rule_id),@MINNUM-1)+1 
               END 
        FROM tbExamRule) 
END
' 
END

GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tbExamRecord]') AND type in (N'U'))
BEGIN
-- 考试记录
CREATE TABLE [dbo].[tbExamRecord](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[paper_id] [int] NULL,	--试卷ID
	[paper_name] [varchar](300) NULL,	--试卷名称
	[stu_id] [int] NULL,	-- 学员ID
	[rcd_stauts] [int] NULL,	--状态
	[rcd_score] [float] NULL,	--得分
	[rcd_startTime] [datetime] NULL,	--开始时间
	[rcd_endTime] [datetime] NULL,	--结束时间
	[rcd_answers] [text] NULL,	--答案
	[rcd_scoreForEachRule] [varchar](500) NULL,	--每大题得分
	[paper_score] [float] NULL,	--得分
	[stu_userName] [varchar](50) NULL,	--用户名
	[rcd_scoreForEachQuestion] [text] NULL,	--每题得分
	[rcd_tempAnswer] [text] NULL,	--临时答案
	[rcd_testNum] [int] NULL,	--测试次数
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (IGNORE_DUP_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tbDeal]') AND type in (N'U'))
BEGIN
-- 协议表
CREATE TABLE [dbo].[tbDeal](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[deal_id] [int] NOT NULL,
	[deal_name] [varchar](30) NOT NULL,
	[deal_content] [text] NOT NULL,
	[deal_pkgId] [int] NULL,
	[deal_lastDate] [datetime] NULL,
 CONSTRAINT [PK_TBDEAL] PRIMARY KEY CLUSTERED 
(
	[deal_id] ASC
)WITH (IGNORE_DUP_KEY = OFF) ON [PRIMARY],
UNIQUE NONCLUSTERED 
(
	[deal_id] ASC
)WITH (IGNORE_DUP_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[log4sccms]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[log4sccms](
	[id] [bigint] IDENTITY(1,1) NOT NULL,
	[message] [varchar](200) NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (IGNORE_DUP_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tbClassPackage]') AND type in (N'U'))
BEGIN
-- 套餐表
CREATE TABLE [dbo].[tbClassPackage](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[pkg_id] [int] NOT NULL,
	[deal_id] [int] NULL,	--协议ID
	[pkg_name] [varchar](30) NOT NULL,
	[pType_id] [int] NOT NULL,
	[pkg_oPrice] [float] NULL,	--原价
	[pkg_rPrice] [float] NULL,	--优惠价
	[pkg_sPrice] [float] NULL,	--老学员价
	[pkg_description] [varchar](1000) NULL,
	[pkg_rMatureDate] [datetime] NOT NULL,	--招生到期时间
	[pkg_lMatureDate] [datetime] NULL,	--套餐到期时间
	[pkg_totalTime] [int] NULL,
	[pkg_addTime] [datetime] NOT NULL,
	[adm_id] [int] NOT NULL,
	[pkg_present] [varchar](100) NULL,	--赠送
	[pkg_includeCid] [varchar](100) NULL,	--包含班级ID
PRIMARY KEY CLUSTERED 
(
	[pkg_id] ASC
)WITH (IGNORE_DUP_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tbComment]') AND type in (N'U'))
BEGIN
-- 评论表
CREATE TABLE [dbo].[tbComment](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[comment_id] [int] NOT NULL,
	[comment_content] [nvarchar](500) NULL,
	[comment_score] [int] NULL,
	[stu_id] [int] NULL,
	[tch_id] [int] NULL,
	[comment_addTime] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[comment_id] ASC
)WITH (IGNORE_DUP_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[proc_get_package_by_stuId]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'create procedure [dbo].[proc_get_package_by_stuId] 
@stuId int 
as 
select cp.* from (select i.* from tbItems i join tbOrder o on i.order_id = o.order_id where o.stu_id =@stuId and o.order_status in (1,2,3)) temp,tbClassPackage cp where (temp.productId = cp.pkg_id and temp.item_pType=0)
' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tbQuestionError]') AND type in (N'U'))
BEGIN
-- 试题纠错
CREATE TABLE [dbo].[tbQuestionError](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[paper_id] [int] NULL,
	[quest_id] [int] NOT NULL,
	[stu_userName] [varchar](50) NULL,
	[error_addTime] [datetime] NULL,
	[error_type] [int] NOT NULL,
	[error_content] [varchar](500) NULL,
	[error_status] [int] NOT NULL,
	[error_dealTime] [datetime] NULL,
	[error_dealPerson] [varchar](50) NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (IGNORE_DUP_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tbPackageCategory]') AND type in (N'U'))
BEGIN
-- 套餐分类
CREATE TABLE [dbo].[tbPackageCategory](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[pType_id] [int] NOT NULL,
	[pType_name] [varchar](20) NOT NULL,
	[exam_id] [int] NOT NULL,
	[pType_pid] [int] NOT NULL,		--分类父ID
	[pType_childrenNum] [int] NOT NULL,
	[pType_orderId] [int] NOT NULL,
	[pType_addTime] [datetime] NOT NULL,
	[pType_description] [varchar](1000) NULL,
	[imageUrl] [varchar](50) NULL,
PRIMARY KEY CLUSTERED 
(
	[pType_id] ASC
)WITH (IGNORE_DUP_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tbMenu]') AND type in (N'U'))
BEGIN
-- 菜单
CREATE TABLE [dbo].[tbMenu](
	[menu_id] [int] IDENTITY(1001,1) NOT NULL,
	[menu_name] [varchar](50) NOT NULL,
	[menu_address] [varchar](50) NULL,
	[menu_icon] [varchar](50) NULL,
	[menu_pid] [int] NOT NULL,
	[menu_number] [varchar](50) NULL,
PRIMARY KEY CLUSTERED 
(
	[menu_id] ASC
)WITH (IGNORE_DUP_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tbLog]') AND type in (N'U'))
BEGIN
-- 日志表
CREATE TABLE [dbo].[tbLog](
	[log_id] [int] IDENTITY(1001,1) NOT NULL,
	[adm_id] [int] NULL,
	[adm_username] [varchar](50) NOT NULL,
	[operatetime] [datetime] NOT NULL,
	[operatetype] [int] NOT NULL,
	[logconten] [varchar](50) NOT NULL,
	[broswer] [varchar](100) NOT NULL,
	[ip] [varchar](50) NOT NULL,
	[adm_password] [varchar](50) NULL,
PRIMARY KEY CLUSTERED 
(
	[log_id] ASC
)WITH (IGNORE_DUP_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tbWebInfo]') AND type in (N'U'))
BEGIN
-- 网站信息
CREATE TABLE [dbo].[tbWebInfo](
	[webInfo_id] [int] IDENTITY(1001,1) NOT NULL,
	[webInfo_comName] [varchar](50) NOT NULL,
	[webInfo_comAddress] [varchar](255) NULL,
	[webInfo_comPostCode] [varchar](50) NULL,
	[webInfo_comEmail] [varchar](50) NULL,
	[webInfo_serviceTel] [varchar](50) NULL,
	[webInfo_officePhone] [varchar](50) NULL,
	[webInfo_comfax] [varchar](50) NULL,
	[webInfo_copyright] [varchar](50) NULL,
	[webInfo_index] [varchar](50) NULL,
	[webInfo_workday] [varchar](50) NULL,
PRIMARY KEY CLUSTERED 
(
	[webInfo_id] ASC
)WITH (IGNORE_DUP_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tbRole]') AND type in (N'U'))
BEGIN
-- 角色表
CREATE TABLE [dbo].[tbRole](
	[role_id] [int] IDENTITY(1001,1) NOT NULL,
	[role_name] [varchar](255) NULL,
	[menu_id] [varchar](500) NULL,
	[role_describe] [varchar](500) NULL,
PRIMARY KEY CLUSTERED 
(
	[role_id] ASC
)WITH (IGNORE_DUP_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[proc_getSecondExamNameOfPkg]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'create procedure [dbo].[proc_getSecondExamNameOfPkg] 
@pkgId int 
as  
select ec.exam_name from (select pc.* from tbClassPackage cp join tbPackageCategory pc on cp.pType_id = pc.pType_id where cp.pkg_id=@pkgId)temp join tbExamCategory ec on temp.exam_id = ec.exam_id
' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[stuIdSequence]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
BEGIN
execute dbo.sp_executesql @statement = N'CREATE    FUNCTION    [dbo].[stuIdSequence]() 
RETURNS    INT 
AS 
BEGIN 
    DECLARE    @MINNUM    INT 
    DECLARE    @MAXNUM    INT 
    SET    @MINNUM=1001    
    SET    @MAXNUM=1999999999 
    RETURN(    SELECT CASE    
            WHEN    ISNULL(MAX(stu_id),@MINNUM-1)+1 >@MAXNUM THEN    0 
            ELSE    ISNULL(MAX(stu_id),@MINNUM-1)+1 
               END 
        FROM tbStudent) 
END
' 
END

GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tbStudent]') AND type in (N'U'))
BEGIN
-- 学生表
CREATE TABLE [dbo].[tbStudent](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[stu_id] [int] NOT NULL CONSTRAINT [ConstraintIdForStudent]  DEFAULT ([dbo].[stuIdSequence]()),
	[stu_username] [varchar](20) NOT NULL,
	[stu_password] [varchar](50) NOT NULL,
	[stu_email] [varchar](50) NULL,
	[stu_phone] [varchar](20) NULL,
	[stu_mobile] [varchar](20) NULL,
	[stu_name] [varchar](20) NULL,
	[stu_sex] [varchar](2) NULL,
	[stu_addr] [varchar](50) NULL CONSTRAINT [DF_stuAddress]  DEFAULT ('地址不详'),
	[stu_pAddr] [varchar](50) NULL,
	[stu_postcal] [varchar](20) NULL,
	[stu_addTime] [datetime] NULL,
	[stu_lastLoginTime] [datetime] NULL,
	[stu_loginNumber] [int] NULL,
	[stu_loginIP] [varchar](50) NULL,
	[stu_score] [int] NULL DEFAULT ((0)),
	[stu_card] [float] NULL DEFAULT ((0.00)),
	[stu_cash] [float] NULL DEFAULT ((0.00)),
	[stu_status] [int] NOT NULL DEFAULT ((0)),
	[stu_imgUrl] [varchar](300) NULL DEFAULT ('../upload/userface/no_face.gif'),
	[QICQ] [varchar](20) NULL,
	[stu_type] [int] NULL DEFAULT ((0)),	--学员类型
	[stu_area] [varchar](20) NULL,	--地区
	[stu_exam] [varchar](20) NULL,	--考试
	[stu_token] [varchar](256) NULL,	--学员的令牌
 CONSTRAINT [PK_stuId] PRIMARY KEY CLUSTERED 
(
	[stu_id] ASC
)WITH (IGNORE_DUP_KEY = OFF) ON [PRIMARY],
UNIQUE NONCLUSTERED 
(
	[stu_email] ASC
)WITH (IGNORE_DUP_KEY = OFF) ON [PRIMARY],
UNIQUE NONCLUSTERED 
(
	[stu_id] ASC
)WITH (IGNORE_DUP_KEY = OFF) ON [PRIMARY],
UNIQUE NONCLUSTERED 
(
	[stu_username] ASC
)WITH (IGNORE_DUP_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tbGrade]') AND type in (N'U'))
BEGIN
-- 班级表
CREATE TABLE [dbo].[tbGrade](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[grade_id] [int] NOT NULL,	--ID
	[exam_id] [int] NOT NULL,		--考试ID
	[gType_id] [int] NOT NULL,	-- 班级类型
	[tch_id] [int] NOT NULL,	-- 老师id
	[grade_time] [int] NOT NULL,	
	[grade_oPrice] [float] NOT NULL,	-- 原价
	[grade_rPrice] [float] NOT NULL,	-- 优惠价
	[grade_single] [int] NULL DEFAULT ((1)),	--是否单卖
	[grade_addTime] [datetime] NOT NULL,	--添加时间
	[adm_id] [int] NOT NULL,
	[grade_dueTime] [datetime] NOT NULL,	--到期时间
	[deal_id] [int] NOT NULL,
	[grade_remark] [varchar](1000) NULL,
	[tch_Name] [varchar](50) NULL,
	[data_download_url] [varchar](255) NULL,
	[grade_name] [varchar](255) NULL,
 CONSTRAINT [PK_TBGRADE] PRIMARY KEY CLUSTERED 
(
	[grade_id] ASC
)WITH (IGNORE_DUP_KEY = OFF) ON [PRIMARY],
UNIQUE NONCLUSTERED 
(
	[grade_id] ASC
)WITH (IGNORE_DUP_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tbItems]') AND type in (N'U'))
BEGIN
-- 订单条目表
CREATE TABLE [dbo].[tbItems](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[item_id] [int] NOT NULL CONSTRAINT [ConstraintIdForItems]  DEFAULT ([dbo].[itemsIdSequence]()),
	[order_id] [int] NOT NULL,
	[productId] [int] NOT NULL,
	[item_oPrice] [float] NOT NULL,
	[item_rPrice] [float] NOT NULL,
	[item_name] [varchar](50) NOT NULL,
	[item_pType] [int] NOT NULL,
	[item_sPrice] [float] NULL,
	[exam_id] [int] NULL,
	[item_present] [varchar](1000) NULL DEFAULT (NULL),
	[item_overTime] [datetime] NULL,	--过期时间
	[item_note] [varchar](2000) NULL,
 CONSTRAINT [PK_ITEMID] PRIMARY KEY CLUSTERED 
(
	[item_id] ASC
)WITH (IGNORE_DUP_KEY = OFF) ON [PRIMARY],
UNIQUE NONCLUSTERED 
(
	[item_id] ASC
)WITH (IGNORE_DUP_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tbSend]') AND type in (N'U'))
BEGIN
-- 寄送表
CREATE TABLE [dbo].[tbSend](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[send_id] [int] NOT NULL CONSTRAINT [ConstraintIdForSend]  DEFAULT ([dbo].[sendIdSequence]()),
	[order_id] [int] NOT NULL,
	[epc_id] [int] NULL,
	[send_status] [int] NOT NULL,
	[send_time] [datetime] NULL,
	[send_person] [varchar](20) NULL,
	[send_confirmTime] [datetime] NULL,
	[send_detail] [varchar](500) NULL,
	[send_addTime] [datetime] NULL,
	[epc_name] [varchar](30) NULL,
	[send_content] [varchar](20) NULL,
	[send_cost] [float] NULL DEFAULT ((0.0)),
	[send_receiveName] [varchar](20) NULL,
	[send_fullAddress] [varchar](200) NULL,
	[send_mobile] [varchar](20) NULL,
	[send_postalCode] [varchar](20) NULL,
	[send_type] [int] NULL,
	[send_expressNo] [varchar](50) NULL,
 CONSTRAINT [PK_SENDID] PRIMARY KEY CLUSTERED 
(
	[send_id] ASC
)WITH (IGNORE_DUP_KEY = OFF) ON [PRIMARY],
UNIQUE NONCLUSTERED 
(
	[send_id] ASC
)WITH (IGNORE_DUP_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tbClassDetail]') AND type in (N'U'))
BEGIN
-- 班级详情表
CREATE TABLE [dbo].[tbClassDetail](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[class_id] [int] NOT NULL,
	[grade_id] [int] NOT NULL,
	[class_title] [varchar](30) NOT NULL,
	[class_orderId] [int] NOT NULL,
	[class_year] [int] NOT NULL,
	[class_addTime] [datetime] NOT NULL,
	[class_openTime] [datetime] NOT NULL,	-- 开班时间
	[class_ifFree] [int] NULL DEFAULT ((0)),	--是否免费
	[adm_id] [int] NOT NULL,
	[class_time] [int] NOT NULL,
	[tch_id] [int] NULL,
	[class_hdUrl] [varchar](60) NULL,
	[class_triUrl] [varchar](60) NULL,
	[class_audio] [varchar](60) NULL,
 CONSTRAINT [PK_TBCLASSDETAIL] PRIMARY KEY CLUSTERED 
(
	[class_id] ASC
)WITH (IGNORE_DUP_KEY = OFF) ON [PRIMARY],
UNIQUE NONCLUSTERED 
(
	[class_id] ASC
)WITH (IGNORE_DUP_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tbLecture]') AND type in (N'U'))
BEGIN
-- 讲义表
CREATE TABLE [dbo].[tbLecture](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[lect_id] [int] NOT NULL,
	[class_id] [int] NOT NULL,
	[lect_content] [text] NOT NULL,
	[lect_addTime] [datetime] NOT NULL,
	[lect_orderId] [int] NOT NULL,
	[lect_timePoint] [int] NOT NULL,
	[lect_title] [nvarchar](50) NULL,
 CONSTRAINT [PK_TBLECTURE] PRIMARY KEY CLUSTERED 
(
	[lect_id] ASC
)WITH (IGNORE_DUP_KEY = OFF) ON [PRIMARY],
UNIQUE NONCLUSTERED 
(
	[lect_id] ASC
)WITH (IGNORE_DUP_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tbReply]') AND type in (N'U'))
BEGIN
-- 回复表
CREATE TABLE [dbo].[tbReply](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[reply_id] [int] NOT NULL DEFAULT ([dbo].[replyIdSequence]()),
	[ac_id] [int] NULL,
	[reply_content] [text] NOT NULL,
	[reply_addTime] [datetime] NOT NULL,
	[reply_people] [varchar](20) NULL,
PRIMARY KEY CLUSTERED 
(
	[reply_id] ASC
)WITH (IGNORE_DUP_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tbAnswer]') AND type in (N'U'))
BEGIN
-- 回复表
CREATE TABLE [dbo].[tbAnswer](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[answer_id] [int] NOT NULL CONSTRAINT [ConstraintIdForAnswer]  DEFAULT ([dbo].[answerIdSequence]()),
	[question_id] [int] NOT NULL,
	[tch_id] [int] NOT NULL,
	[answer_content] [text] NOT NULL,
	[answer_time] [datetime] NOT NULL,
	[answer_valuation] [int] NULL,
 CONSTRAINT [PK_ANSWERID] PRIMARY KEY CLUSTERED 
(
	[answer_id] ASC
)WITH (IGNORE_DUP_KEY = OFF) ON [PRIMARY],
UNIQUE NONCLUSTERED 
(
	[answer_id] ASC
)WITH (IGNORE_DUP_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tbExamRule]') AND type in (N'U'))
BEGIN
-- 考试大题表
CREATE TABLE [dbo].[tbExamRule](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[rule_id] [int] NOT NULL DEFAULT ([dbo].[ruleIdSequence]()),
	[paper_Id] [int] NOT NULL,
	[rule_title] [varchar](500) NULL,
	[rule_idInPaper] [int] NULL,
	[rule_type] [int] NULL,
	[rule_questionNum] [int] NULL,
	[rule_scoreForEach] [float] NULL,
	[rule_actualAddNum] [int] NULL,
	[rule_scoreSet] [varchar](10) NULL,
PRIMARY KEY CLUSTERED 
(
	[rule_id] ASC
)WITH (IGNORE_DUP_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tbStuDeal]') AND type in (N'U'))
BEGIN
-- 学员协议表
CREATE TABLE [dbo].[tbStuDeal](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[stuDeal_id] [int] NOT NULL,
	[deal_id] [int] NULL,
	[stuDeal_status] [int] NULL,
	[stuDeal_time] [datetime] NULL,
	[stu_id] [int] NULL,
	[stu_username] [nvarchar](100) NULL,
	[stu_name] [nvarchar](50) NULL,
	[stu_cards] [nvarchar](50) NULL,
	[paytype] [nvarchar](50) NULL,
	[stu_address] [nvarchar](200) NULL,
	[stu_phone] [nvarchar](30) NULL,
	[stu_email] [nvarchar](50) NULL,
	[pkg_name] [nvarchar](50) NULL,
PRIMARY KEY CLUSTERED 
(
	[stuDeal_id] ASC
)WITH (IGNORE_DUP_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tbAdministor]') AND type in (N'U'))
BEGIN
-- 管理员表
CREATE TABLE [dbo].[tbAdministor](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[adm_id] [int] NOT NULL CONSTRAINT [ConstraintIdForAdmin]  DEFAULT ([dbo].[admIdSequence]()),
	[adm_username] [varchar](20) NOT NULL,
	[adm_password] [varchar](50) NOT NULL,
	[adm_name] [varchar](20) NOT NULL,
	[adm_addTime] [datetime] NULL,
	[adm_loginNumbers] [int] NULL,
	[adm_lastLoginTime] [datetime] NULL,
	[adm_lastLoginIP] [varchar](20) NULL,
	[adm_role] [int] NULL DEFAULT ((0)),
	[adm_status] [int] NULL DEFAULT ((0)),
	[role_id] [int] NULL,
 CONSTRAINT [PK_admId] PRIMARY KEY CLUSTERED 
(
	[adm_id] ASC
)WITH (IGNORE_DUP_KEY = OFF) ON [PRIMARY],
UNIQUE NONCLUSTERED 
(
	[adm_username] ASC
)WITH (IGNORE_DUP_KEY = OFF) ON [PRIMARY],
UNIQUE NONCLUSTERED 
(
	[adm_id] ASC
)WITH (IGNORE_DUP_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tbRechargeRecord]') AND type in (N'U'))
BEGIN
-- 充值记录表
CREATE TABLE [dbo].[tbRechargeRecord](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[rc_id] [int] NOT NULL CONSTRAINT [ConstraintIdForRR]  DEFAULT ([dbo].[rcIdSequence]()),
	[rc_money] [float] NOT NULL,
	[rc_type] [int] NOT NULL,
	[rc_ip] [varchar](20) NOT NULL,
	[rc_cardId] [int] NOT NULL,
	[stu_id] [int] NOT NULL,
	[rc_addTime] [datetime] NOT NULL,
	[rc_isPresent] [int] NULL DEFAULT ((0)),
 CONSTRAINT [PK_TBRECHARGERECORD] PRIMARY KEY CLUSTERED 
(
	[rc_id] ASC
)WITH (IGNORE_DUP_KEY = OFF) ON [PRIMARY],
UNIQUE NONCLUSTERED 
(
	[rc_id] ASC
)WITH (IGNORE_DUP_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tbStudyRecord]') AND type in (N'U'))
BEGIN
-- 学习记录表
CREATE TABLE [dbo].[tbStudyRecord](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[record_id] [int] NOT NULL,
	[stu_id] [int] NOT NULL,
	[class_id] [int] NOT NULL,
	[record_startTime] [datetime] NOT NULL,
	[record_ip] [varchar](20) NOT NULL,
	[grade_id] [int] NOT NULL,
	[record_name] [nvarchar](100) NULL,
	[countNum] [int] NULL,
 CONSTRAINT [PK_record] PRIMARY KEY CLUSTERED 
(
	[record_id] ASC
)WITH (IGNORE_DUP_KEY = OFF) ON [PRIMARY],
UNIQUE NONCLUSTERED 
(
	[record_id] ASC
)WITH (IGNORE_DUP_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tbQuestionCollect]') AND type in (N'U'))
BEGIN
-- 问题收藏表
CREATE TABLE [dbo].[tbQuestionCollect](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[collect_id] [int] NOT NULL CONSTRAINT [ConstraintIdForQCollect]  DEFAULT ([dbo].[collectIdSequence]()),
	[question_id] [int] NOT NULL,
	[stu_id] [int] NOT NULL,
	[collect_addTime] [datetime] NOT NULL,
 CONSTRAINT [PK_COLLECTID] PRIMARY KEY CLUSTERED 
(
	[collect_id] ASC
)WITH (IGNORE_DUP_KEY = OFF) ON [PRIMARY],
UNIQUE NONCLUSTERED 
(
	[collect_id] ASC
)WITH (IGNORE_DUP_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tbQuestion]') AND type in (N'U'))
BEGIN
-- 问题表
CREATE TABLE [dbo].[tbQuestion](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[question_id] [int] NOT NULL CONSTRAINT [ConstraintIdForQuestion]  DEFAULT ([dbo].[questionIdSequence]()),
	[exam_id] [int] NOT NULL,
	[grade_id] [int] NOT NULL,
	[class_id] [int] NOT NULL,
	[question_source] [int] NULL,
	[question_title] [varchar](100) NOT NULL,
	[question_content] [text] NOT NULL,
	[question_status] [int] NOT NULL,
	[stu_id] [int] NOT NULL,
	[question_addTime] [datetime] NOT NULL,
	[question_path] [varchar](200) NULL,
 CONSTRAINT [PK_QUESTIONID] PRIMARY KEY CLUSTERED 
(
	[question_id] ASC
)WITH (IGNORE_DUP_KEY = OFF) ON [PRIMARY],
UNIQUE NONCLUSTERED 
(
	[question_id] ASC
)WITH (IGNORE_DUP_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tbOrder]') AND type in (N'U'))
BEGIN
-- 订单表
CREATE TABLE [dbo].[tbOrder](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[order_id] [int] NOT NULL CONSTRAINT [ConstraintIdForOrder]  DEFAULT ([dbo].[orderIdSequence]()),
	[order_no] [varchar](40) NULL CONSTRAINT [ConstraintNoForOrder]  DEFAULT ([dbo].[orderNoSequence]()),
	[stu_id] [int] NOT NULL,
	[order_money] [float] NOT NULL,
	[order_invoice] [int] NULL,
	[order_status] [int] NOT NULL,
	[order_payment] [int] NULL,
	[order_addTime] [datetime] NOT NULL,
	[order_payTime] [datetime] NULL,
	[order_payType] [varchar](20) NULL,	--支付类型
	[adm_id] [int] NULL,
	[order_dealTime] [datetime] NULL,
	[order_note] [varchar](300) NULL,
	[order_isNeedSend] [int] NULL,
	[order_sendDetail] [varchar](2000) NULL,	--寄送详情
	[order_price] [float] NULL,
	[adm_username] [varchar](50) NULL,
 CONSTRAINT [PK_ORDERID] PRIMARY KEY CLUSTERED 
(
	[order_id] ASC
)WITH (IGNORE_DUP_KEY = OFF) ON [PRIMARY],
UNIQUE NONCLUSTERED 
(
	[order_no] ASC
)WITH (IGNORE_DUP_KEY = OFF) ON [PRIMARY],
UNIQUE NONCLUSTERED 
(
	[order_id] ASC
)WITH (IGNORE_DUP_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tbNote]') AND type in (N'U'))
BEGIN
-- 笔记表
CREATE TABLE [dbo].[tbNote](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[note_id] [int] NOT NULL,
	[class_id] [int] NOT NULL,
	[note_addTime] [datetime] NOT NULL,
	[note_content] [text] NOT NULL,
	[stu_id] [int] NOT NULL,
	[note_couresType] [int] NULL,
	[note_videotime] [float] NULL,
 CONSTRAINT [PK_noteId] PRIMARY KEY CLUSTERED 
(
	[note_id] ASC
)WITH (IGNORE_DUP_KEY = OFF) ON [PRIMARY],
UNIQUE NONCLUSTERED 
(
	[note_id] ASC
)WITH (IGNORE_DUP_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[proc_get_exam_from_package]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'create procedure [dbo].[proc_get_exam_from_package] 
@stuId int 
as 
    select distinct ec.* from tbExamCategory ec join (select pc.* from (select cp.* from (select i.* from tbItems i join tbOrder o on i.order_id = o.order_id where o.stu_id =@stuId and o.order_status in (1,2)) temp,tbClassPackage cp where (temp.productId = cp.pkg_id and temp.item_pType=0)) temp2 join tbPackageCategory pc on pc.pType_id = temp2.pType_id) pc2 on ec.exam_id = pc2.exam_id 
' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[proc_grade_by_stuId]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'create procedure [dbo].[proc_grade_by_stuId] 
@stuId int 
as 
select g.* from (select i.* from tbItems i join tbOrder o on i.order_id = o.order_id where o.stu_id =@stuId and o.order_status in (1,2,3)) temp,tbGrade g where (temp.productId = g.grade_id and temp.item_pType=1)
' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[proc_get_distinct_order_by_stuId]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'create procedure [dbo].[proc_get_distinct_order_by_stuId] 
@stuId int, 
@page int, 
@pagesize int, 
@keywords varchar(100), 
@sortname varchar(30), 
@sortorder varchar(6) 
as 
	select * from ( 
    select ROW_NUMBER() OVER( 
        order by (''o2.''+@sortname +'' ''+@sortorder)) as pos,  
        o2.* 
        from 
         (select distinct o1.* from 
            tbOrder o1, tbItems i 
            where o1.order_id  = i.order_id and o1.stu_id =127 and i.item_name like ''%''+@keywords+''%'' 
        ) o2) sp where sp.pos between (@page-1)*@pagesize+1 and @page*@pagesize
' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[proc_get_grade_by_stuId]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'create procedure [dbo].[proc_get_grade_by_stuId] 
@stuId int 
as 
select g.* from (select i.* from tbItems i join tbOrder o on i.order_id = o.order_id where o.stu_id =@stuId and o.order_status in (1,2,3)) temp,tbGrade g where (temp.productId = g.grade_id and temp.item_pType=1)
' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[proc_get_exam_from_grade]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'create procedure [dbo].[proc_get_exam_from_grade] 
@stuId int 
as 
select distinct ec.* from tbExamCategory ec join (select g.* from (select i.* from tbItems i join tbOrder o on i.order_id = o.order_id where o.stu_id =@stuId and o.order_status in (1,2,3)) temp,tbGrade g where (temp.productId = g.grade_id and temp.item_pType=1))temp2 on ec.exam_id = temp2.exam_id
' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[proc_getSecondExamNameOfGrade]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'create procedure [dbo].[proc_getSecondExamNameOfGrade] 
@gradeId int 
as  
select ec2.exam_name from (select ec.* from (select g.* from tbGrade g where g.grade_id = @gradeId) temp1 join tbExamCategory ec on temp1.exam_id = ec.exam_id) temp2 join tbExamCategory ec2 on temp2.exam_pid = ec2.exam_id
' 
END
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_tbExamCategory_tbExamCategory]') AND parent_object_id = OBJECT_ID(N'[dbo].[tbExamCategory]'))
ALTER TABLE [dbo].[tbExamCategory]  WITH CHECK ADD  CONSTRAINT [FK_tbExamCategory_tbExamCategory] FOREIGN KEY([exam_id])
REFERENCES [dbo].[tbExamCategory] ([exam_id])
GO
IF NOT EXISTS (SELECT * FROM sys.check_constraints WHERE object_id = OBJECT_ID(N'[dbo].[CK_stuSex]') AND parent_object_id = OBJECT_ID(N'[dbo].[tbStudent]'))
ALTER TABLE [dbo].[tbStudent]  WITH CHECK ADD  CONSTRAINT [CK_stuSex] CHECK  (([stu_sex]='男' OR [stu_sex]='女'))
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_TBGRADE_REFERECE_TBEXAMCA]') AND parent_object_id = OBJECT_ID(N'[dbo].[tbGrade]'))
ALTER TABLE [dbo].[tbGrade]  WITH CHECK ADD  CONSTRAINT [FK_TBGRADE_REFERECE_TBEXAMCA] FOREIGN KEY([tch_id])
REFERENCES [dbo].[tbTeacher] ([tch_id])
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_TBGRADE_REFERENCE_TBEXAMCA]') AND parent_object_id = OBJECT_ID(N'[dbo].[tbGrade]'))
ALTER TABLE [dbo].[tbGrade]  WITH CHECK ADD  CONSTRAINT [FK_TBGRADE_REFERENCE_TBEXAMCA] FOREIGN KEY([exam_id])
REFERENCES [dbo].[tbExamCategory] ([exam_id])
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_TBGRADE_REFERENCE_TBGRADEC]') AND parent_object_id = OBJECT_ID(N'[dbo].[tbGrade]'))
ALTER TABLE [dbo].[tbGrade]  WITH CHECK ADD  CONSTRAINT [FK_TBGRADE_REFERENCE_TBGRADEC] FOREIGN KEY([gType_id])
REFERENCES [dbo].[tbGradeCategory] ([gType_id])
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_ITEMS_REFERENCE_TBORDER]') AND parent_object_id = OBJECT_ID(N'[dbo].[tbItems]'))
ALTER TABLE [dbo].[tbItems]  WITH CHECK ADD  CONSTRAINT [FK_ITEMS_REFERENCE_TBORDER] FOREIGN KEY([order_id])
REFERENCES [dbo].[tbOrder] ([order_id])
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_SEND_REFERENCE_TBORDER]') AND parent_object_id = OBJECT_ID(N'[dbo].[tbSend]'))
ALTER TABLE [dbo].[tbSend]  WITH CHECK ADD  CONSTRAINT [FK_SEND_REFERENCE_TBORDER] FOREIGN KEY([order_id])
REFERENCES [dbo].[tbOrder] ([order_id])
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_TBCLASSD_REFERENCE_TBGRADE]') AND parent_object_id = OBJECT_ID(N'[dbo].[tbClassDetail]'))
ALTER TABLE [dbo].[tbClassDetail]  WITH CHECK ADD  CONSTRAINT [FK_TBCLASSD_REFERENCE_TBGRADE] FOREIGN KEY([grade_id])
REFERENCES [dbo].[tbGrade] ([grade_id])
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_TBLECTUR_REFERENCE_TBCLASSD]') AND parent_object_id = OBJECT_ID(N'[dbo].[tbLecture]'))
ALTER TABLE [dbo].[tbLecture]  WITH CHECK ADD  CONSTRAINT [FK_TBLECTUR_REFERENCE_TBCLASSD] FOREIGN KEY([class_id])
REFERENCES [dbo].[tbClassDetail] ([class_id])
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_TBREPLY_REFERENCE_TBASKORCOMPLAIN]') AND parent_object_id = OBJECT_ID(N'[dbo].[tbReply]'))
ALTER TABLE [dbo].[tbReply]  WITH CHECK ADD  CONSTRAINT [FK_TBREPLY_REFERENCE_TBASKORCOMPLAIN] FOREIGN KEY([ac_id])
REFERENCES [dbo].[tbAskOrComplain] ([ac_id])
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_TBANSWER_REFERENCE_TBQUESTI]') AND parent_object_id = OBJECT_ID(N'[dbo].[tbAnswer]'))
ALTER TABLE [dbo].[tbAnswer]  WITH CHECK ADD  CONSTRAINT [FK_TBANSWER_REFERENCE_TBQUESTI] FOREIGN KEY([question_id])
REFERENCES [dbo].[tbQuestion] ([question_id])
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__tbExamRul__paper__17F790F9]') AND parent_object_id = OBJECT_ID(N'[dbo].[tbExamRule]'))
ALTER TABLE [dbo].[tbExamRule]  WITH CHECK ADD FOREIGN KEY([paper_Id])
REFERENCES [dbo].[tbExamPaper] ([paper_id])
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__tbExamRul__paper__6CD828CA]') AND parent_object_id = OBJECT_ID(N'[dbo].[tbExamRule]'))
ALTER TABLE [dbo].[tbExamRule]  WITH CHECK ADD FOREIGN KEY([paper_Id])
REFERENCES [dbo].[tbExamPaper] ([paper_id])
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_TBDEAL_REFERENCE_TBSTUDEAL]') AND parent_object_id = OBJECT_ID(N'[dbo].[tbStuDeal]'))
ALTER TABLE [dbo].[tbStuDeal]  WITH CHECK ADD  CONSTRAINT [FK_TBDEAL_REFERENCE_TBSTUDEAL] FOREIGN KEY([deal_id])
REFERENCES [dbo].[tbDeal] ([deal_id])
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_TBADMIN_REFERENCE_TBROLE]') AND parent_object_id = OBJECT_ID(N'[dbo].[tbAdministor]'))
ALTER TABLE [dbo].[tbAdministor]  WITH CHECK ADD  CONSTRAINT [FK_TBADMIN_REFERENCE_TBROLE] FOREIGN KEY([role_id])
REFERENCES [dbo].[tbRole] ([role_id])
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_TBRECHARGE_REFERENCE_TBSTUDEN]') AND parent_object_id = OBJECT_ID(N'[dbo].[tbRechargeRecord]'))
ALTER TABLE [dbo].[tbRechargeRecord]  WITH CHECK ADD  CONSTRAINT [FK_TBRECHARGE_REFERENCE_TBSTUDEN] FOREIGN KEY([stu_id])
REFERENCES [dbo].[tbStudent] ([stu_id])
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_TBSTUDYR_REFERENCE_TBSTUDEN]') AND parent_object_id = OBJECT_ID(N'[dbo].[tbStudyRecord]'))
ALTER TABLE [dbo].[tbStudyRecord]  WITH CHECK ADD  CONSTRAINT [FK_TBSTUDYR_REFERENCE_TBSTUDEN] FOREIGN KEY([stu_id])
REFERENCES [dbo].[tbStudent] ([stu_id])
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_QUESTION_REFERENCE_TBSTUDEN]') AND parent_object_id = OBJECT_ID(N'[dbo].[tbQuestionCollect]'))
ALTER TABLE [dbo].[tbQuestionCollect]  WITH CHECK ADD  CONSTRAINT [FK_QUESTION_REFERENCE_TBSTUDEN] FOREIGN KEY([stu_id])
REFERENCES [dbo].[tbStudent] ([stu_id])
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_TBQUESTI_REFERENCE_TBSTUDEN]') AND parent_object_id = OBJECT_ID(N'[dbo].[tbQuestion]'))
ALTER TABLE [dbo].[tbQuestion]  WITH CHECK ADD  CONSTRAINT [FK_TBQUESTI_REFERENCE_TBSTUDEN] FOREIGN KEY([stu_id])
REFERENCES [dbo].[tbStudent] ([stu_id])
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_TBORDER_REFERENCE_TBSTUDEN]') AND parent_object_id = OBJECT_ID(N'[dbo].[tbOrder]'))
ALTER TABLE [dbo].[tbOrder]  WITH CHECK ADD  CONSTRAINT [FK_TBORDER_REFERENCE_TBSTUDEN] FOREIGN KEY([stu_id])
REFERENCES [dbo].[tbStudent] ([stu_id])
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_TBNOTE_REFERENCE_TBSTUDEN]') AND parent_object_id = OBJECT_ID(N'[dbo].[tbNote]'))
ALTER TABLE [dbo].[tbNote]  WITH CHECK ADD  CONSTRAINT [FK_TBNOTE_REFERENCE_TBSTUDEN] FOREIGN KEY([stu_id])
REFERENCES [dbo].[tbStudent] ([stu_id])
