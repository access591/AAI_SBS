
<%@ page language="java"  pageEncoding="UTF-8"%>

<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
String target = request.getParameter("target");
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    <link href="<%=basePath%>css/style.css" rel="stylesheet" type="text/css" /> 
    <link href="<%=basePath%>css/epis.css" rel="stylesheet" type="text/css" /> 
   <script language="JavaScript" type="text/JavaScript">
	
	javascript:window.history.forward(-1);
	
	function loading(){
		
		document.forms[0].action="/SessionTimeOut.jsp";
		document.forms[0].submit();
		
	}

</script> 
  </head>

 
  <body class="page-header-fixed">
		<!-- BEGIN HEADER -->
		
   	<div class="page-content-wrapper">
		<div class="page-content">
		
<table width="100%" border="0" cellspacing="0" cellpadding="0">
 
   
   <tr>
    <td align="left" valign="top">
  		<table  height="510" width="700" cellpadding="0" cellspacing="0" border=0>
                <tr height="40%">
                  <td align="left" valign="top" width="30%" >&nbsp;</td>
                  <td align="left" valign="top" width="40%">&nbsp;</td>
                  <td align="left" valign="top" width="30%">&nbsp;</td>
                </tr>
                <tr height="10%">
                  <td align="center" valign="top" width="30%" colspan=3 ><h2><font color='blue'>Session Expired !</font></h2></td>                  
                </tr>
                <tr >
                  <td align="center" valign="top" width="30%" colspan=3 ><a href="<%=basePath%>" style="color:Black;font-family:Verdana;font-size:14px;" >Re-Login</a>&nbsp;&nbsp;<a href="#" onclick="javascript: self.close ()" style="color:Black;font-family:Verdana;font-size:14px;">Close Window</a></td>                  
                </tr>
                <tr height="40%">
                  <td align="left" valign="top" width="30%">&nbsp;</td>
                  <td align="left" valign="top" width="40%">&nbsp;</td>
                  <td align="left" valign="top" width="30%">&nbsp;</td>
                </tr>
                
         </table>
    </td>
   </tr>
      
  
  
</table>

</div></div>
		

	</body>
  
</html>
