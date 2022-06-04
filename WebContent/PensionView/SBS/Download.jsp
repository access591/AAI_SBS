<%@page import="java.io.OutputStream"%>
<%@page import="java.io.File"%>
<%@ page language="java" import="java.util.*" pageEncoding="ISO-8859-1"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>My JSP 'Download.jsp' starting page</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->

  </head>
  
  <body>
   <%    
  String filename = request.getParameter("filename"); 
  String doctype = request.getParameter("doctype");
  String filepath="";
  if(doctype.equals("fin")){  
   filepath = "C:\\SBS_Upload\\fin\\"; 
   //filepath = "SBS_Upload/fin/"; 
   }else{
   filepath = "C:\\SBS_Upload\\hr\\";
 //  filepath = "SBS_Upload/hr/";
   }  
    
  
  File downloadFile = new File(filepath + filename);
  java.io.FileInputStream fileInputStream=new java.io.FileInputStream(filepath + filename);  
  
  response.setContentType("application/pdf");   
  response.setHeader("Content-Disposition","attachment; filename=\"" + filename + "\""); 
  byte[] buffer = new byte[4096];
  OutputStream outStream = response.getOutputStream();
  int i;  
  if(fileInputStream.read()!=-1 ){
  while ((i = fileInputStream.read(buffer)) != -1) {  
	  outStream.write(buffer, 0, i); 
  }   
  }else{
  %>
  <div class="">
		<div class="col-md-12" style="text-align:center">File not Exist 
			<button type="button" class="btn default">Back</button>
		</div>
  </div>
  <% 
  }
  fileInputStream.close();   
%>   
  </body>
</html>
