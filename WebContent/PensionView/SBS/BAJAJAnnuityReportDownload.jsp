<%@ page language="java" import="java.util.*"%>
<%@ page import="aims.bean.LicBean,aims.bean.SBSNomineeBean"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<base href="<%=basePath%>">

		
	    <LINK rel="stylesheet" href="<%=basePath%>PensionView/css/aai.css" type="text/css">
	
	


	

	</head>
	<%
		LicBean bean = null;
		bean = (LicBean) request.getAttribute("licBean") != null
				? (LicBean) request.getAttribute("licBean")
				: new LicBean();
	%>






	<body>
<table align="center" border="1"  width="90%" cellpadding="0px" cellspacing="0px"><tr><td width="40%" align="left"><b>Master Policy No:<% %></b></td><td align="left"><b>Master Policy Holder Name:</b></td></tr>

<tr><td colspan="2">
		<table width="100%" border="1" cellpadding="3px" cellspacing="0">
		<tr>
		<th colspan="2">Particulars of Member/Beneficiary</th>
			</tr>
			<tr>
		<td width="50%">Member Employee Number</td><td><%=bean.getEmployeeNo() %></td>
			</tr>
			<tr>
		<td>Primary Annuitant's Name</td><td><%=bean.getMemberName() %></td>
			</tr>
			<tr>
		<td>Gender</td><td><%=bean.getGender() %></td>
			</tr>
			<tr>
		<td>Date of Birth</td><td><%=bean.getDob() %></td>
			</tr>
			<tr>
		<td> Annuitant's Address</td><td><%=bean.getMemberPerAdd() %></td>
			</tr>
			<tr>
		<td>City/Town/Village</td><td><%=bean.getCtv() %></td>
			</tr>
			<tr>
		<td>State</td><td><%=bean.getState() %></td>
			</tr>
			<tr>
		<td>Pin Code</td><td><%=bean.getPinCode() %></td>
			</tr>
			<tr>
		<td>Mobile Number</td><td><%=bean.getMobilNo() %></td>
			</tr>
			<tr>
		<td>E-Mail I'd</td><td><%=bean.getEmail() %></td>
			</tr>
			<tr>
		<td>PAN Number</td><td><%=bean.getPanNo() %></td>
			</tr>
			<tr>
		<td>Nationality</td><td><%=bean.getNationality() %></td>
			</tr>
			<tr>
		<td>Father's Name</td><td><%=bean.getFatherName() %></td>
			</tr>
			</table>
			</td></tr>
			<tr><td>&nbsp;</td></tr>
			<tr><td>
			<table width="100%" border="1" bordercolor="#444" cellpadding="3px" cellspacing="0">
		<tr>
		<th colspan="2">Bank Details</th>
			</tr>
			<tr>
		<td width="50%">Bank Account Number</td><td><%=bean.getAccNo() %></td>
			</tr>
			<tr>
		<td>Bank Name</td><td><%=bean.getBankName() %></td>
			</tr>
			<tr>
		<td>Branch Address</td><td><%=bean.getBranch() %></td>
			</tr>
			<tr>
		<td>IFSC Code</td><td><%=bean.getIfscCode() %></td>
			</tr>
			<tr>
		<td> Account Type</td><td><%=bean.getAccType() %></td>
			</tr>
			
			</table>
			</td></tr>
			<tr><td>&nbsp;</td></tr>
			<tr><td>
			<table width="100%" border="1" bordercolor="#444" cellpadding="3px" cellspacing="0">
		
			<tr>
		<td width="50%">Corpus Amount/Purchase Price(In Rs)</td><td><%=bean.getCorpusAmt() %></td>
			</tr>
			<tr>
		<td>Name of the Annuity Service Provider</td><td>SBI Life Insurance Company Ltd</td>
			</tr>
			
			
			</table>
			</td></tr>
			<tr><td>&nbsp;</td></tr>
			<tr><td>
			<table width="100%" border="1" bordercolor="#444" cellpadding="3px" cellspacing="0">
		<tr><th colspan="4">Frequency of Payouts</th></tr>
			<tr>
		<td>Monthly<%=bean.getPaymentMode().equals("monthly")?"<img width:12px; height:15px; src='assets/img/check_mark.png'/>":"" %></td><td>Quarterly<%=bean.getPaymentMode().equals("qly")?"<img width:12px; height:15px; src='assets/img/check_mark.png'/>":"" %></td>
			
		<td>Half Yearly<%=bean.getPaymentMode().equals("hly")?"<img width:12px; height:15px; src='assets/img/check_mark.png'/>":"" %></td><td>Yearly<%=bean.getPaymentMode().equals("yearly")?"<img width:12px; height:15px; src='assets/img/check_mark.png'/>":"" %></td>
			</tr>
			
			
			</table>
			</td></tr>
			<tr><td>&nbsp;</td></tr>
			<tr><td>
			<table width="100%" border="1" bordercolor="#444" cellpadding="3px" cellspacing="0">
		<tr><th colspan="4">Annuity Option</th></tr>
			<tr>
		<td>Life Annuity<%=bean.getAaiEDCPSoption().equals("A")?"<img width:12px; height:15px; src='assets/img/check_mark.png'/>":"" %></td><td>Life Annuity With Return Of Purchase Price<%=bean.getAaiEDCPSoption().equals("B")?"<img width:12px; height:15px; src='assets/img/check_mark.png'/>":"" %></td>
			
		<td>Joint Life Annuity<%=bean.getAaiEDCPSoption().equals("C")?"<img width:12px; height:15px; src='assets/img/check_mark.png'/>":"" %></td><td>Joint Life Annuity with Return Of Purchase Price<%=bean.getAaiEDCPSoption().equals("D")?"<img width:12px; height:15px; src='assets/img/check_mark.png'/>":"" %></td>
			</tr>
			
			
			</table>
			</td></tr>
			<tr><td>&nbsp;</td></tr>
			<tr><td>
			
			<table width="100%" border="1"  bordercolor="#444" cellpadding="3px" cellspacing="0">
		<tr><th colspan="2">In Case the Option chosen is 'Joint Life Annuity With Return Of Purchase Price',please fill the below details: </th></tr>
			<tr>
		<td width="50%">Name of the secondary annuitant</td><td><%=bean.getSpouseName() %></td>
			</tr>
			<tr>
		<td>Date of birth Of secondary annuitant</td><td><%=bean.getSpouseDob() %></td>
			</tr>
			<tr>
		<td>Relationship With  primary annuitant</td><td><%=bean.getSpouseRelation() %></td>
			</tr>
			<tr>
		<td>PAN number of  secondary annuitant</td><td><%=bean.getSecAnnuitantPAN() %></td>
			</tr>
			
			</table>
			</td></tr>
			<tr><td>&nbsp;</td></tr>
			<tr><td>
			
				<table width="100%" border="1" bordercolor="#444" cellpadding="3px" cellspacing="0">
		<tr><th colspan="6">Nominee Details </th></tr>
			<tr>
		<th>S.no</th><th>Nominee Name</th><th>Nominee Date of Birth</th><th>Nominee Gender</th><th>Nominee Relation With Primary Annuitanr</th><th>Distribution Percentage</th>
			</tr>
			<%  ArrayList list= (ArrayList)bean.getNomineeList();
			SBSNomineeBean nomineeBean=null;
			for(int i=0;i<list.size();i++){
			nomineeBean=(SBSNomineeBean)list.get(i);%>
			
			
			<tr><td><%=i+1 %></td> <td><%=nomineeBean.getNomineename() %></td><td><%=nomineeBean.getNomineeDOB() %></td><td><%=nomineeBean.getGender() %></td><td><%=nomineeBean.getNomineeRelation() %></td><td><%=nomineeBean.getPercentage() %></td></tr>
			
			
			
			<% }
			
			
			 %>
			
			</table>
			</td></tr>
			<tr><td>&nbsp;</td></tr>
			<tr><td>
			
				<table width="100%" border="1" bordercolor="#444" cellpadding="3px" cellspacing="0">
		<tr><th colspan="7">In case of the nominee is a minor,kindly fill the appointee details</th></tr>
			<tr>
		<th>S.no</th><th>Nominee Name</th><th>Name of the appointee</th><th>Appointee Date of Birth</th><th>Appointee Relationship with Nominee</th><th>Appointee's Mobile Number</th><th>Appointee's Adress</th>
			</tr>
			<%  ArrayList appointeeList= (ArrayList)bean.getNomineeAppointeeList();
			SBSNomineeBean appointeeBean=null;
			for(int i=0;i<appointeeList.size();i++){
			appointeeBean=(SBSNomineeBean)appointeeList.get(i);%>
			
			
			<tr><td><%=i+1 %></td> <td><%=appointeeBean.getNomineename() %></td><td><%=appointeeBean.getNomineeDOB() %></td><td><%=appointeeBean.getNomineeDOB() %></td><td><%=appointeeBean.getNomineeRelation() %></td><td><%=appointeeBean.getAppointeeMobile()%></td><td><%=appointeeBean.getAppointeeAddress() %></td></tr>
			
			
			
			<% }
			
			
			 %>
			
			</table>
			</td></tr>
			<tr><td>&nbsp;</td></tr>
			<tr><td>
			
			<table width="100%" border="1" bordercolor="#444" cellpadding="7px" cellspacing="0">
		
			<tr>
		<td width="50%">Signature of primary annuitant</td><td></td>
			</tr>
			<tr>
		<td>Name of primary annuitant</td><td></td>
			</tr>
			<tr>
		<td>Signature of officer representing Airports Authority of India</td><td></td>
			</tr>
			<tr>
		<td>Name of the officer representing Airports Authority of India</td><td></td>
			</tr>
			<tr>
		<td>Stamp and seal of the organigation/trust making the payment</td><td></td>
			</tr>
			
			</table>
			</td></tr>
			<tr><td>&nbsp;</td></tr>
			<tr><td>
			</table>
	</body>



</html>
