.<%@ page language="java" import="java.util.*,aims.bean.LicBean" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
	 <%
  LicBean bean=null;
  
  bean=request.getAttribute("licBean")!=null?(LicBean)request.getAttribute("licBean"):new LicBean();
  
  
  String approveLevel=request.getAttribute("approveLevel")!=null?request.getAttribute("approveLevel").toString():"";
  
 // System.out.println("App id:::::::::"+bean.getAppId());
 long annuityPurAmt=Math.round(Double.parseDouble(bean.getEdcpCorpusAmt())+Double.parseDouble(bean.getEdcpCorpusint()));
 long GSTAmt=Math.round((Double.parseDouble(bean.getEdcpCorpusAmt())+Double.parseDouble(bean.getEdcpCorpusint()))/1.018*(1.8/100));
   %>


					<%if(bean.getFormType().equals("LIC")){%>
					<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
<title>Lic LIFE</title>
</head>
<body>
<center>
<div style="width:750px; border:solid 0px; border-color:#D2D2D2; padding:20px 10px;">
<table width="100%" border="0" cellspacing="0" cellpadding="0">
<tr>
	<td style="font-family:Georgia, Arial, Helvetica, sans-serif; font-size:18px; font-weight:600;
    text-align:center; text-decoration:;" colspan="3">AAI EMPLOYEES DEFINED CONTRIBUTION PENSION TRUST</td>
    </tr>
    <tr>
    <td style="width:30px"> </td>
    <td style="width:690px">
    <hr />
    </td>
<td style="width:30px"></td>
</tr>
</table>
<table width="100%" border="0" cellspacing="0" cellpadding="0" style="margin-top:40px;">
<tr>
<td style="width:50%; text-align:left; font-family:Arial, Helvetica, sans-serif; font-size:15px; padding-left:5px; height:20px;">AAIEDCPT\Corres.F.Mgrs\LIC\<%=bean.getAppId() %> </td>
<td style="width:50%; text-align:right; font-family:Arial, Helvetica, sans-serif; font-size:15px; padding-right:5px; height:20px;">Dated: <%=bean.getEdcpApproveDate() %> </td></tr>
</table>
<table width="100%" border="0" cellspacing="0" cellpadding="0" style="margin-top:40px;">
<tr>
<td style="width:100%; text-align:left; font-family:Arial, Helvetica, sans-serif; font-size:13px; padding-left:5px; height:30px; " colspan="3">TO
</td>
</tr>
<tr>
<td style="width:100%; text-align:left; font-family:Arial, Helvetica, sans-serif; font-size:13px; padding-left:5px; height:20px; " colspan="3">Divisional Manager									
</td>
</tr>
<tr>
<td style="width:100%; text-align:left; font-family:Arial, Helvetica, sans-serif; font-size:13px; padding-left:5px; height:20px;" colspan="3">
Life Insurance Corporation of India,
</td>
</tr>
<tr>
<td style="width:100%; text-align:left; font-family:Arial, Helvetica, sans-serif; font-size:13px; padding-left:5px; height:20px; " colspan="3">
Delhi Divisional Office-1, Jeevan Prakash
</td>
</tr>
<tr>
<td style="width:100%; text-align:left; font-family:Arial, Helvetica, sans-serif; font-size:13px; padding-left:5px; " colspan="3">
25, K.G. Marg, New Delhi-110001
</td>
</tr>
<tr>
<td style="width:750px; text-align:center; font-family:Arial, Helvetica, sans-serif; font-size:15px; padding-left:5px; font-weight:600; padding-top:30px; text-decoration:underline;" colspan="3">
Kind Attention: Sh. Sunil Kumar/Shishir Prasoon
</td>
</tr>
<tr>
<td style="width:750px; text-align:left; font-family:Arial, Helvetica, sans-serif; font-size:15px; padding-left:5px; font-weight:600; padding-top:30px; text-decoration:underline;" colspan="3">
Subject: - Request for Issue of Annuity Policy to Sh. <%=bean.getMemberName() %>, PF id <%=bean.getEmployeeNo() %>, against the Funds available with LIC
</td>
</tr>

<tr>
<td style="width:100%; text-align:left; font-family:Arial, Helvetica, sans-serif; font-size:15px; padding-left:5px; height:25px;  padding-top:7px;" colspan="3">
Sir,
</td>
</tr>
<tr>
<td style="width:750px; text-align:left; font-family:Arial, Helvetica, sans-serif; font-size:15px;   padding-top:10px;padding-left:5px; height:25px;" colspan="3">
Please find enclosed herewith Annuity Application form along with requisite documents and cancelled cheque in respect of the following superannuated Employees, namely:- 
</td>
</tr>
<tr>
<td class="3" style="padding-top:20px;">
<table width="750" border="1" cellspacing="0" cellpadding="0" style="border-color:#fff;">
  <tr><td style="font-family:Arial, Helvetica, sans-serif; font-size:13px; font-weight:600; text-align:center;"> SL. No.</td>
  <td style="font-family:Arial, Helvetica, sans-serif; font-size:13px; font-weight:600; text-align:center;"> Employee Name </td>
  <td style="font-family:Arial, Helvetica, sans-serif; font-size:13px; font-weight:600; text-align:center;"> Designation </td>
  <td style="font-family:Arial, Helvetica, sans-serif; font-size:13px; font-weight:600; text-align:center;"> ERP SAP Code </td>
  <td style="font-family:Arial, Helvetica, sans-serif; font-size:13px; font-weight:600; text-align:center;">Employee PF id </td>
  <td style="font-family:Arial, Helvetica, sans-serif; font-size:13px; font-weight:600; text-align:center;">Last place of posting</td>
  <td style="font-family:Arial, Helvetica, sans-serif; font-size:13px; font-weight:600; text-align:center;">Annuity Purchase Value (Rs/-)
 </td></tr>
  <tr>
    <td style="font-family:Arial, Helvetica, sans-serif; font-size:13px; font-weight:normal; text-align:center; height:25px;">1</td>
     <td style="font-family:Arial, Helvetica, sans-serif; font-size:13px; font-weight:normal; text-align:center; height:25px;"> <%=bean.getMemberName() %></td>
      <td style="font-family:Arial, Helvetica, sans-serif; font-size:13px; font-weight:normal; text-align:center; height:25px;"> <%=bean.getDesignation() %> </td>
            <td style="font-family:Arial, Helvetica, sans-serif; font-size:13px; font-weight:normal; text-align:center; height:25px;"><%=bean.getNewEmpCode() %></td>
       <td style="font-family:Arial, Helvetica, sans-serif; font-size:13px; font-weight:normal; text-align:center; height:25px;"><%=bean.getEmployeeNo() %></td>
        <td style="font-family:Arial, Helvetica, sans-serif; font-size:13px; font-weight:normal; text-align:center; height:25px;"><%=bean.getAirport() %></td>
         <td style="font-family:Arial, Helvetica, sans-serif; font-size:13px; font-weight:normal; text-align:center; height:25px;">
         <table width="100%" border="1" cellspacing="0" cellpadding="0" style="border-color:#fff;height:25px;">
  <tr><td style="font-family:Arial, Helvetica, sans-serif; font-size:13px; font-weight:600; text-align:center;">Annuity Purchase value</td><td><%=annuityPurAmt-GSTAmt %></td></tr>
  <tr ><td style="font-family:Arial, Helvetica, sans-serif; font-size:13px; font-weight:600; text-align:center;">GST@1.8%</td><td><%=GSTAmt%></td></tr>
  <tr><td style="font-family:Arial, Helvetica, sans-serif; font-size:13px; font-weight:600; text-align:center;">Total Debit Value</td><td><%=annuityPurAmt %></td></tr></table>
          </td>
  </tr>
</table>

</td>
</tr>
<tr>
<td colspan="3" style="font-family:Arial, Helvetica, sans-serif; font-size:13px; font-weight:normal; text-align:left; height:25px; padding-left:10px; padding-top:10px;">
 Kindly issue Annuity policies as per the Annuity application submitted out of the Trust Funds available with LIC. An early action from your side will be highly appreciated. 
</td>
</tr>
<tr>
<td colspan="3" style="font-family:Arial, Helvetica, sans-serif; font-size:13px; font-weight:normal; text-align:left; height:25px;">
  
</td>
</tr>
<tr>
<td colspan="3" style="font-family:Arial, Helvetica, sans-serif; font-size:13px; font-weight:normal; text-align:left; height:25px;">
 Thanking you,
</td>
</tr>
<tr>
<td colspan="3" style="font-family:Arial, Helvetica, sans-serif; font-size:13px; font-weight:normal; text-align:right; height:25px; padding-top:15px;">
Yours Faithfully,
</td>
</tr>
<tr>
<td colspan="3" style="font-family:Arial, Helvetica, sans-serif; font-size:13px; font-weight:normal; text-align:right; height:25px;">

</td>
</tr>
<tr>
<td colspan="3" style="font-family:Arial, Helvetica, sans-serif; font-size:13px; font-weight:normal; text-align:right; height:25px;">
<% System.out.println("display name===="+bean.getEdcpDisplayname1());
	if(!bean.getEdcpDisplayname1().equals("")){%>
<%=bean.getEdcpDisplayname1() %>
<%}else{%>
(Indu P Pillai)
<%}%>
</td>
</tr>
<% System.out.println("Designation name===="+bean.getEdcpDesignation1());
	if(!bean.getEdcpDesignation1().equals("")){%>
<tr>
<td colspan="3" style="font-family:Arial, Helvetica, sans-serif; font-size:13px; font-weight:normal; text-align:right; height:25px;">
<%=bean.getEdcpDesignation1() %>
</td>
</tr>
<tr>
<td colspan="3" style="font-family:Arial, Helvetica, sans-serif; font-size:13px; font-weight:normal; text-align:right; height:25px;">
 AAIEDCP Trust
</td>
</tr>
<%}else{%>
<tr>
<td colspan="3" style="font-family:Arial, Helvetica, sans-serif; font-size:13px; font-weight:normal; text-align:right; height:25px;">
Asstt. General Manager (F&A)
</td>
</tr>
<tr>
<td colspan="3" style="font-family:Arial, Helvetica, sans-serif; font-size:13px; font-weight:normal; text-align:right; height:25px;">
Secretary, AAIEDCP Trust
</td>
</tr>
<%}%>
<tr>
<td colspan="3" style="font-family:Arial, Helvetica, sans-serif; font-size:13px; font-weight:normal; text-align:left; height:25px; padding-left:50px">
Encl : As Above
</td>
</tr>
</table>
<table width="100%" border="0" cellspacing="0" cellpadding="0" style="margin-top:40px;">
<tr>
<td style="width:30px"> </td>
<td style="width:690px">
<hr />
</td>
<td style="width:30px"></td>
</tr>
<tr>
<td style="width:30px"> </td>
<td style="width:690px; height:3px; ">

</td>
<td style="width:30px"></td>
</tr>

<tr>
<td  colspan="3" style="font-family:Arial, Helvetica, sans-serif; font-size:13px; font-weight:normal; text-align:center;">
BLOCK-A, RAJIV GANDHI BHAWAN, SAFDARDUNG AIRPORT, NEW DELHI-110003
</td>
</tr>
<tr>
<td style="height:12px" colspan="3">
</td>
</tr>
<tr>
<td colspan="3" style="font-family:Arial, Helvetica, sans-serif; font-size:13px; font-weight:normal; text-align:center;">PHONE: 24632950, E-MAIL ID  aaiedcpt@aai.aero
</td>
</tr>
</table>

</div>
</center>
</body>
</html>
					
					
					<% }else if(bean.getFormType().equals("HDFC")){ %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>HDFC LIFE</title>
</head>

<body>
<center>
<div style="width:750px; border:solid 0px; border-color:#D2D2D2; padding:20px 10px;">

<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td style="font-family:Georgia, Arial, Helvetica, sans-serif; font-size:18px; font-weight:600;
    text-align:center; text-decoration:;" colspan="3">AAI EMPLOYEES DEFINED CONTRIBUTION PENSION TRUST</td>
  </tr>  
  <tr>
<td style="width:30px"> </td>
<td style="width:690px">
<hr />
</td>
<td style="width:30px"></td>
</tr>
  
</table>
<table width="100%" border="0" cellspacing="0" cellpadding="0" style="margin-top:40px;">
<tr>
<td style="width:50%; text-align:left; font-family:Arial, Helvetica, sans-serif; font-size:15px; padding-left:5px; height:20px;">AAIEDCPT\Corres.F.Mgrs\HDFC\<%=bean.getAppId() %> </td>
<td style="width:50%; text-align:right; font-family:Arial, Helvetica, sans-serif; font-size:15px; padding-right:5px; height:20px;">Dated: <%=bean.getEdcpApproveDate() %> </td></tr>
</table>
<table width="100%" border="0" cellspacing="0" cellpadding="0" style="margin-top:40px;">
<tr>
<td style="width:100%; text-align:left; font-family:Arial, Helvetica, sans-serif; font-size:13px; padding-left:5px; height:30px; " colspan="3">TO
</td>
</tr>
<tr>
<td style="width:100%; text-align:left; font-family:Arial, Helvetica, sans-serif; font-size:13px; padding-left:5px; height:20px; " colspan="3">Associate Vice President									

</td>
</tr>
<tr>
<td style="width:100%; text-align:left; font-family:Arial, Helvetica, sans-serif; font-size:13px; padding-left:5px; height:20px; " colspan="3">								
HDFC LIFE,
</td>
</tr>
<tr>
<td style="width:100%; text-align:left; font-family:Arial, Helvetica, sans-serif; font-size:13px; padding-left:5px; height:20px;" colspan="3">
131/140, 1st Floor, Ansal Chamber 1,
</td>
</tr>
<tr>
<td style="width:100%; text-align:left; font-family:Arial, Helvetica, sans-serif; font-size:13px; padding-left:5px; height:20px; " colspan="3">
Bhikaji Cama Place, New Delhi-110066
</td>
</tr>


<tr>
<td style="width:750px; text-align:center; font-family:Arial, Helvetica, sans-serif; font-size:15px; padding-left:5px; font-weight:600; padding-top:30px; text-decoration:underline;" colspan="3">
Kind Attention: Sh. Anand Kumar/Sh. Saket Nandan/Sh.Imo Loitongbam
</td>
</tr>
<tr>
<td style="width:750px; text-align:left; font-family:Arial, Helvetica, sans-serif; font-size:15px; padding-left:5px; font-weight:600; padding-top:30px; text-decoration:underline;" colspan="3">
Subject: - Request for Issue of Annuity Policy to Sh. <%=bean.getMemberName() %>, PF id <%=bean.getEmployeeNo() %>, against the Funds available with HDFC LIFE
</td>
</tr>
<tr>
<td style="width:100%; text-align:left; font-family:Arial, Helvetica, sans-serif; font-size:15px; padding-left:5px; height:25px;  padding-top:7px;" colspan="3">
Sir,
</td>
</tr>
<tr>
<td style="width:750px; text-align:left; font-family:Arial, Helvetica, sans-serif; font-size:15px;   padding-top:10px;padding-left:5px; height:25px;" colspan="3">
Please find enclosed herewith Annuity Application form along with requisite documents and cancelled cheque in respect of the following superannuated Employee, namely:- 
</td>
</tr>
<tr>
<td class="3" style="padding-top:20px;">
<table width="750" border="1" cellspacing="0" cellpadding="0" style="border-color:#fff;">
  <tr>
    <td style="font-family:Arial, Helvetica, sans-serif; font-size:13px; font-weight:600; text-align:center;"> SL. No.</td>
     <td style="font-family:Arial, Helvetica, sans-serif; font-size:13px; font-weight:600; text-align:center;"> Employee Name </td>
      <td style="font-family:Arial, Helvetica, sans-serif; font-size:13px; font-weight:600; text-align:center;"> Designation </td>
            <td style="font-family:Arial, Helvetica, sans-serif; font-size:13px; font-weight:600; text-align:center;"> ERP SAP Code </td>
       <td style="font-family:Arial, Helvetica, sans-serif; font-size:13px; font-weight:600; text-align:center;">Employee PF id </td>
        <td style="font-family:Arial, Helvetica, sans-serif; font-size:13px; font-weight:600; text-align:center;">Last place of posting</td>
         <td style="font-family:Arial, Helvetica, sans-serif; font-size:13px; font-weight:600; text-align:center;">Annuity Purchase Value (Rs/-)
 </td>
  </tr>
  <tr>

  <tr>
    <td style="font-family:Arial, Helvetica, sans-serif; font-size:13px; font-weight:normal; text-align:center; height:25px;">1</td>
     <td style="font-family:Arial, Helvetica, sans-serif; font-size:13px; font-weight:normal; text-align:center; height:25px;"> <%=bean.getMemberName() %></td>
      <td style="font-family:Arial, Helvetica, sans-serif; font-size:13px; font-weight:normal; text-align:center; height:25px;"> <%=bean.getDesignation() %> </td>
             <td style="font-family:Arial, Helvetica, sans-serif; font-size:13px; font-weight:normal; text-align:center; height:25px;"><%=bean.getNewEmpCode() %></td>
       <td style="font-family:Arial, Helvetica, sans-serif; font-size:13px; font-weight:normal; text-align:center; height:25px;"><%=bean.getEmployeeNo() %></td>
        <td style="font-family:Arial, Helvetica, sans-serif; font-size:13px; font-weight:normal; text-align:center; height:25px;"><%=bean.getAirport() %></td>
       <td style="font-family:Arial, Helvetica, sans-serif; font-size:13px; font-weight:normal; text-align:center; height:25px;">
         <table width="100%" border="1" cellspacing="0" cellpadding="0" style="border-color:#fff;height:25px;">
  <tr><td style="font-family:Arial, Helvetica, sans-serif; font-size:13px; font-weight:600; text-align:center;">Annuity Purchase value</td><td><%=annuityPurAmt-GSTAmt %></td></tr>
  <tr ><td style="font-family:Arial, Helvetica, sans-serif; font-size:13px; font-weight:600; text-align:center;">GST@1.8%</td><td><%=GSTAmt%></td></tr>
  <tr><td style="font-family:Arial, Helvetica, sans-serif; font-size:13px; font-weight:600; text-align:center;">Total Debit Value</td><td><%=annuityPurAmt %></td></tr></table>
          </td>  
 </tr>
</table>

</td>
</tr>
<tr>
<td colspan="3" style="font-family:Arial, Helvetica, sans-serif; font-size:13px; font-weight:normal; text-align:left; height:25px; padding-left:10px; padding-top:10px;">
 Kindly issue Annuity policies  as per the Annuity application submitted out of the Trust Funds available with HDFC LIFE. An early action from your side will be highly appreciated. 
</td>
</tr>
<tr>
<td colspan="3" style="font-family:Arial, Helvetica, sans-serif; font-size:13px; font-weight:normal; text-align:left; height:25px;">

</td>
</tr>
<tr>
<td colspan="3" style="font-family:Arial, Helvetica, sans-serif; font-size:13px; font-weight:normal; text-align:left; height:25px;">
 Thanking you,
</td>
</tr>
<tr>
<td colspan="3" style="font-family:Arial, Helvetica, sans-serif; font-size:13px; font-weight:normal; text-align:right; height:25px; padding-top:15px;">
Yours Faithfully,
</td>
</tr>
<tr>
<td colspan="3" style="font-family:Arial, Helvetica, sans-serif; font-size:13px; font-weight:normal; text-align:right; height:25px;">

</td>
</tr>
<tr>
<td colspan="3" style="font-family:Arial, Helvetica, sans-serif; font-size:13px; font-weight:normal; text-align:right; height:25px;">
<% System.out.println("display name===="+bean.getEdcpDisplayname1());
	if(!bean.getEdcpDisplayname1().equals("")){%>
<%=bean.getEdcpDisplayname1() %>
<%}else{%>
(Indu P Pillai)
<%}%>
</td>
</tr>
<% System.out.println("Designation name===="+bean.getEdcpDesignation1());
	if(!bean.getEdcpDesignation1().equals("")){%>
<tr>
<td colspan="3" style="font-family:Arial, Helvetica, sans-serif; font-size:13px; font-weight:normal; text-align:right; height:25px;">
<%=bean.getEdcpDesignation1() %>
</td>
</tr>
<tr>
<td colspan="3" style="font-family:Arial, Helvetica, sans-serif; font-size:13px; font-weight:normal; text-align:right; height:25px;">
 AAIEDCP Trust
</td>
</tr>
<%}else{%>
<tr>
<td colspan="3" style="font-family:Arial, Helvetica, sans-serif; font-size:13px; font-weight:normal; text-align:right; height:25px;">
Asstt. General Manager (F&A)
</td>
</tr>
<tr>
<td colspan="3" style="font-family:Arial, Helvetica, sans-serif; font-size:13px; font-weight:normal; text-align:right; height:25px;">
Secretary, AAIEDCP Trust
</td>
</tr>
<%}%>


<tr>
<td colspan="3" style="font-family:Arial, Helvetica, sans-serif; font-size:13px; font-weight:normal; text-align:left; height:25px; padding-left:50px">
Encl : As Above
</td>
</tr>
</table>
<table width="100%" border="0" cellspacing="0" cellpadding="0" style="margin-top:40px;">
<tr>
<td style="width:30px"> </td>
<td style="width:690px">
<hr />
</td>
<td style="width:30px"></td>
</tr>
<tr>
<td style="width:30px"> </td>
<td style="width:690px; height:3px; ">

</td>
<td style="width:30px"></td>
</tr>

<tr>
<td  colspan="3" style="font-family:Arial, Helvetica, sans-serif; font-size:13px; font-weight:normal; text-align:center;">
BLOCK-A, RAJIV GANDHI BHAWAN, SAFDARDUNG AIRPORT, NEW DELHI-110003
</td>
</tr>
<tr>
<td style="height:12px" colspan="3">
</td>
</tr>
<tr>
<td colspan="3" style="font-family:Arial, Helvetica, sans-serif; font-size:13px; font-weight:normal; text-align:center;">PHONE: 24632950, E-MAIL ID  aaiedcpt@aai.aero
</td>
</tr>
</table>

</div>
</center>
</body>
</html>

						
								<%}else if(bean.getFormType().equals("SBI")){ %>
					
					<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>SBI LIFE</title>
</head>

<body>
<center>
<div style="width:750px; border:solid 0px; border-color:#D2D2D2; padding:20px 10px;">

<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td style="font-family:Georgia, Arial, Helvetica, sans-serif; font-size:18px; font-weight:600;
    text-align:center; text-decoration:;" colspan="3">AAI EMPLOYEES DEFINED CONTRIBUTION PENSION TRUST</td>
  </tr>  
  <tr>
<td style="width:30px"> </td>
<td style="width:690px">
<hr />
</td>
<td style="width:30px"></td>
</tr>
  </tr>  
</table>
<table width="100%" border="0" cellspacing="0" cellpadding="0" style="margin-top:40px;">
<tr>
<td style="width:50%; text-align:left; font-family:Arial, Helvetica, sans-serif; font-size:15px; padding-left:5px; height:20px;">AAIEDCPT\Corres.F.Mgrs\SBI\<%=bean.getAppId() %>	 </td>
<td style="width:50%; text-align:right; font-family:Arial, Helvetica, sans-serif; font-size:15px; padding-right:5px; height:20px;">Dated: <%=bean.getEdcpApproveDate() %> </td></tr>
</table>
<table width="100%" border="0" cellspacing="0" cellpadding="0" style="margin-top:40px;">
<tr>
<td style="width:100%; text-align:left; font-family:Arial, Helvetica, sans-serif; font-size:13px; padding-left:5px; height:30px; " colspan="3">TO
</td>
</tr>
<tr>
<td style="width:100%; text-align:left; font-family:Arial, Helvetica, sans-serif; font-size:13px; padding-left:5px; height:20px; " colspan="3">Sh. Dhiraj Srivastava
</td>
</tr>
<tr>
<td style="width:100%; text-align:left; font-family:Arial, Helvetica, sans-serif; font-size:13px; padding-left:5px; height:20px;" colspan="3">
Key accounts Manager
</td>
</tr>
<tr>
<td style="width:100%; text-align:left; font-family:Arial, Helvetica, sans-serif; font-size:13px; padding-left:5px; height:20px; " colspan="3">
SBI Life Insurance Co. Ltd.
<td>
</tr>
<tr>
<td style="width:100%; text-align:left; font-family:Arial, Helvetica, sans-serif; font-size:13px; padding-left:5px; " colspan="3">
The Statesman House, Barakhamba Road, New Delhi.110001
</td>
</tr>

<tr>
<td style="width:750px; text-align:left; font-family:Arial, Helvetica, sans-serif; font-size:15px; padding-left:5px; font-weight:600; padding-top:30px; text-decoration:underline;" colspan="3">
Subject: - Request for Issue of Annuity Policy to Sh. <%=bean.getMemberName() %>, PF id <%=bean.getEmployeeNo() %>, against the Funds available with SBI LIFE

</td>
</tr>

<tr>
<td style="width:100%; text-align:left; font-family:Arial, Helvetica, sans-serif; font-size:15px; padding-left:5px; height:25px;  padding-top:7px;" colspan="3">
Sir.
</td>
</tr>
<tr>
<td style="width:750px; text-align:left; font-family:Arial, Helvetica, sans-serif; font-size:15px;   padding-top:10px;padding-left:5px; height:25px;" colspan="3">
Please find enclosed herewith Annuity Application form along with requisite documents and cancelled cheque in respect of the following superannuated Employee, namely:- 
</td>
</tr>
<tr>
<td class="3" style="padding-top:20px;">
<table width="750" border="1" cellspacing="0" cellpadding="0" style="border-color:#fff;">
  <tr>
    <td style="font-family:Arial, Helvetica, sans-serif; font-size:13px; font-weight:600; text-align:center;"> SL. No.</td>
     <td style="font-family:Arial, Helvetica, sans-serif; font-size:13px; font-weight:600; text-align:center;"> Employee Name </td>
      <td style="font-family:Arial, Helvetica, sans-serif; font-size:13px; font-weight:600; text-align:center;"> Designation </td>
      <td style="font-family:Arial, Helvetica, sans-serif; font-size:13px; font-weight:600; text-align:center;"> ERP SAP Code </td>
       <td style="font-family:Arial, Helvetica, sans-serif; font-size:13px; font-weight:600; text-align:center;">Employee PF id </td>
        <td style="font-family:Arial, Helvetica, sans-serif; font-size:13px; font-weight:600; text-align:center;">Last place of posting</td>
         <td style="font-family:Arial, Helvetica, sans-serif; font-size:13px; font-weight:600; text-align:center;">Annuity Purchase Value (Rs/-)
 </td>
  </tr>
  <tr>

  <tr>
    <td style="font-family:Arial, Helvetica, sans-serif; font-size:13px; font-weight:normal; text-align:center; height:25px;">1</td>
     <td style="font-family:Arial, Helvetica, sans-serif; font-size:13px; font-weight:normal; text-align:center; height:25px;"> <%=bean.getMemberName() %></td>
      <td style="font-family:Arial, Helvetica, sans-serif; font-size:13px; font-weight:normal; text-align:center; height:25px;"> <%=bean.getDesignation() %> </td>
      <td style="font-family:Arial, Helvetica, sans-serif; font-size:13px; font-weight:normal; text-align:center; height:25px;"><%=bean.getNewEmpCode() %></td>
       <td style="font-family:Arial, Helvetica, sans-serif; font-size:13px; font-weight:normal; text-align:center; height:25px;"><%=bean.getEmployeeNo() %></td>
        <td style="font-family:Arial, Helvetica, sans-serif; font-size:13px; font-weight:normal; text-align:center; height:25px;"><%=bean.getAirport() %></td>
  <td style="font-family:Arial, Helvetica, sans-serif; font-size:13px; font-weight:normal; text-align:center; height:25px;">
         <table width="100%" border="1" cellspacing="0" cellpadding="0" style="border-color:#fff;height:25px;">
  <tr><td style="font-family:Arial, Helvetica, sans-serif; font-size:13px; font-weight:600; text-align:center;">Annuity Purchase value</td><td><%=annuityPurAmt-GSTAmt %></td></tr>
  <tr ><td style="font-family:Arial, Helvetica, sans-serif; font-size:13px; font-weight:600; text-align:center;">GST@1.8%</td><td><%=GSTAmt%></td></tr>
  <tr><td style="font-family:Arial, Helvetica, sans-serif; font-size:13px; font-weight:600; text-align:center;">Total Debit Value</td><td><%=annuityPurAmt %></td></tr></table>
          </td></tr>
</table>

</td>
</tr>
<tr>
<td colspan="3" style="font-family:Arial, Helvetica, sans-serif; font-size:13px; font-weight:normal; text-align:left; height:25px; padding-left:10px; padding-top:10px;">
  Kindly issue Annuity policy  as per the Annuity application submitted out of the Trust Funds 
</td>
</tr>
<tr>
<td colspan="3" style="font-family:Arial, Helvetica, sans-serif; font-size:13px; font-weight:normal; text-align:left; height:25px;">
  available with SBI LIFE. An early action from your side will be highly appreciated. 
</td>
</tr>
<tr>
<td colspan="3" style="font-family:Arial, Helvetica, sans-serif; font-size:13px; font-weight:normal; text-align:left; height:25px;">
 Thanking you,
</td>
</tr>
<tr>
<td colspan="3" style="font-family:Arial, Helvetica, sans-serif; font-size:13px; font-weight:normal; text-align:right; height:25px; padding-top:15px;">
Yours Faithfully,
</td>
</tr>

<tr>
<td colspan="3" style="font-family:Arial, Helvetica, sans-serif; font-size:13px; font-weight:normal; text-align:right; height:25px;">

</td>
</tr>
<tr>
<td colspan="3" style="font-family:Arial, Helvetica, sans-serif; font-size:13px; font-weight:normal; text-align:right; height:25px;">
<% System.out.println("display name===="+bean.getEdcpDisplayname1());
	if(!bean.getEdcpDisplayname1().equals("")){%>
<%=bean.getEdcpDisplayname1() %>
<%}else{%>
(Indu P Pillai)
<%}%>
</td>
</tr>
<% System.out.println("Designation name===="+bean.getEdcpDesignation1());
	if(!bean.getEdcpDesignation1().equals("")){%>
<tr>
<td colspan="3" style="font-family:Arial, Helvetica, sans-serif; font-size:13px; font-weight:normal; text-align:right; height:25px;">
<%=bean.getEdcpDesignation1() %>
</td>
</tr>
<tr>
<td colspan="3" style="font-family:Arial, Helvetica, sans-serif; font-size:13px; font-weight:normal; text-align:right; height:25px;">
 AAIEDCP Trust
</td>
</tr>
<%}else{%>
<tr>
<td colspan="3" style="font-family:Arial, Helvetica, sans-serif; font-size:13px; font-weight:normal; text-align:right; height:25px;">
Asstt. General Manager (F&A)
</td>
</tr>
<tr>
<td colspan="3" style="font-family:Arial, Helvetica, sans-serif; font-size:13px; font-weight:normal; text-align:right; height:25px;">
Secretary, AAIEDCP Trust
</td>
</tr>
<%}%>
<tr>
<td colspan="3" style="font-family:Arial, Helvetica, sans-serif; font-size:13px; font-weight:normal; text-align:left; height:25px; padding-left:50px">
Encl : As Above
</td>
</tr>
</table>
<table width="100%" border="0" cellspacing="0" cellpadding="0" style="margin-top:40px;">
<tr>
<td style="width:30px"> </td>
<td style="width:690px">
<hr />
</td>
<td style="width:30px"></td>
</tr>
<tr>
<td style="width:30px"> </td>
<td style="width:690px; height:3px; ">

</td>
<td style="width:30px"></td>
</tr>

<tr>
<td  colspan="3" style="font-family:Arial, Helvetica, sans-serif; font-size:13px; font-weight:normal; text-align:center;">
BLOCK-A, RAJIV GANDHI BHAWAN, SAFDARDUNG AIRPORT, NEW DELHI-110003
</td>
</tr>
<tr>
<td style="height:12px" colspan="3">
</td>
</tr>
<tr>
<td colspan="3" style="font-family:Arial, Helvetica, sans-serif; font-size:13px; font-weight:normal; text-align:center;">PHONE: 24632950, E-MAIL ID  aaiedcpt@aai.aero
</td>
</tr>
</table>

</div>
</center>
</body>
</html>
					
						
								<%} %>
								