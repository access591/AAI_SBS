
<%@ page language="java" 
	pageEncoding="UTF-8" errorPage="error.jsp"%>
<%@page import="aims.bean.LoginInfo" %>

<% LoginInfo user = (LoginInfo) session.getAttribute("user");
            if (user == null) {
                RequestDispatcher rd = request
                        .getRequestDispatcher("./SbsIndex.jsp");
                rd.forward(request, response);
                
                System.out.println("1111111111");
            }
            
    session.setAttribute("username",user.getUserName()) ;       
            %>

<%String path = request.getContextPath();
            String basePath = request.getScheme() + "://"
                    + request.getServerName() + ":" + request.getServerPort()
                    + path + "/";
                    
             System.out.println("2222222222");  
             
                    
%>

	<html>
<jsp:include page="/SBSHeader.jsp"></jsp:include>
<%if(request.getParameter("mcd").equals("AM")) {%>
<jsp:include page="/PensionView/SBS/AdminMenu.jsp"></jsp:include> 
<%}else{ %>
<jsp:include page="/PensionView/SBS/Menu.jsp"></jsp:include>
	<%} %>
	<head>
		<meta charset="utf-8" />
		<title>EPIS - SBS</title>
		<meta http-equiv="X-UA-Compatible" content="IE=edge">
		<meta content="width=device-width, initial-scale=1.0" name="viewport" />
		<meta content="" name="description" />
		<meta content="" name="author" />
		<meta name="MobileOptimized" content="320">
		<!-- BEGIN GLOBAL MANDATORY STYLES -->
		<link href="<%=basePath%>assets/plugins/font-awesome/css/font-awesome.min.css"
			rel="stylesheet" type="text/css" />
		<link href="<%=basePath%>assets/plugins/bootstrap/css/bootstrap.min.css"
			rel="stylesheet" type="text/css" />
		<link href="<%=basePath%>assets/plugins/uniform/css/uniform.default.css"
			rel="stylesheet" type="text/css" />
		<!-- END GLOBAL MANDATORY STYLES -->
		<!-- BEGIN THEME STYLES -->
		<link href="<%=basePath%>assets/css/style-metronic.css" rel="stylesheet"
			type="text/css" />
		<link href="<%=basePath%>assets/css/style.css" rel="stylesheet" type="text/css" />
		<link href="<%=basePath%>assets/css/style-responsive.css" rel="stylesheet"
			type="text/css" />
		<link href="<%=basePath%>assets/css/plugins.css" rel="stylesheet" type="text/css" />
		<link href="<%=basePath%>assets/css/themes/default.css" rel="stylesheet"
			type="text/css" id="style_color" />
		<link href="<%=basePath%>assets/css/custom.css" rel="stylesheet" type="text/css" />
		<!-- END THEME STYLES -->
<!-- <link rel="shortcut icon" href="favicon.ico" /> -->
		<link href="<%=basePath%>assets/plugins/data-tables/DT_bootstrap.css"
			rel="stylesheet" type="text/css" />
	</head>
	<!-- END HEAD -->
	<!-- BEGIN BODY -->
	<body class="page-header-fixed">
		<!-- BEGIN HEADER -->
		
   	<div class="page-content-wrapper">
		<div class="page-content">
		</div></div>
		

	</body>
</html>
