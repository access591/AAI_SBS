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

		<title>My JSP 'AnnuityReportDownload.jsp' starting page</title>

		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
		<script type="text/javascript" src="<%=basePath%>js/calendar.js"></script>
		<script type="text/javascript"
			src="<%=basePath%>js/CommonFunctions.js"></script>
		<script type="text/javascript" src="<%=basePath%>js/DateTime.js"></script>
		<link rel="stylesheet" href="<%=basePath%>css/style.css"
			type="text/css" />
		<LINK rel="stylesheet" href="<%=basePath%>css/displaytagstyle.css"
			type="text/css">
		<script text/javascript">
	
</script>

		</style>

	</head>
	<%
		LicBean bean = null;
		bean = (LicBean) request.getAttribute("licBean") != null
				? (LicBean) request.getAttribute("licBean")
				: new LicBean();
	%>






	<body>
<table align="center" border="1px" bordercolor="#444" cellpadding="0px" cellspacing="0px"><tr height="25px" style="color:#ffffff"><td align="center"><B>APPLICATION FOR REFUND OF CORPUS</B></td></tr>

<tr><td>
		<table width="100%" border="1" bordercolor="#444" cellpadding="3px" cellspacing="0">
		<tr>
		<th colspan="2">Particulars of Member/Beneficiary</th>
			</tr>
			
			
			<tr>
		<td width="50%">Member Employee Number(PF ID)</td><td><%=bean.getEmployeeNo() %></td>
			</tr>
			<tr>
		<td>Name of Employee</td><td><%=bean.getMemberName() %></td>
			</tr>
			<tr>
		<td>Region</td><td><%=bean.getRegion() %></td>
			</tr>
			<tr>
		<td>Airport Name</td><td><%=bean.getAirport() %></td>
			</tr>

			<tr>
		<td>Designation </td><td><%=bean.getDesignation() %></td>
			</tr>
			<tr>
		<td>Date of Separation/Death</td><td><%=bean.getDateOfexit() %></td>
			</tr>
			<tr>
		<td> ERP SAP Employee Code</td><td><%=bean.getEmpsapCode() %></td>
			</tr>
			<tr>
		<td>Reason for Request of Refund</td><td>Total Corpus appearing in SBS Card  is less than  Rs 2 lakhs</td>
			</tr>
			<tr>
		<td>Mobile Number</td><td><%=bean.getMobilNo() %></td>
			</tr>
			<tr>
		<td>E-mail id of the Employee </td><td><%=bean.getEmail() %></td>
			</tr>
			<tr>
		<td>In case of deceased employee name of Nominee</td><td><%=bean.getNomineeName() %></td>
			</tr>
			<tr>
		<td>Name of Nominee2 </td><td><%=bean.getNomineeName2() %></td>
			</tr>
			<tr>
		<td>Name of Nominee3</td><td><%=bean.getNomineeName3() %></td>
			</tr>
			</table>
			</td></tr>
			<tr><td>&nbsp;</td></tr>
			<tr><td>
			<table width="100%" border="1" bordercolor="#444" cellpadding="3px" cellspacing="0">
		<tr>
		<th colspan="2"> EMPLOYEE/Beneficiary BANK INFORMATION</th>
			</tr>
			<tr>
			<td width="50%">Name of Employee/ In Case of deceased Employee-Name of Nominee (As per Saving Bank Account)</td>
			<td><%=bean.getCustomerName() %></td>
			</tr>
			<tr>
		<td width="50%">Bank Account Number</td><td><%=bean.getAccNo() %></td>
			</tr>
			<tr>
		<td>Bank Name</td><td><%=bean.getBankName() %></td>
			</tr>
			<tr>
		<td>Branch Code & MICR Code</td><td><%=bean.getMicrCode() %></td>
			</tr>
			<tr>
		<td>Branch Address</td><td><%=bean.getBranch() %></td>
			</tr>
			<tr>
		<td>IFSC Code</td><td><%=bean.getIfscCode() %></td>
			</tr>
			<tr>
		<td> Cancelled Cheque attached </td><td>Yes</td>
			</tr>
			
			</table>
			</td></tr>
			
			<tr><td>&nbsp;</td></tr>
			<tr><td>
			<table width="100%" border="1" bordercolor="#444" cellpadding="3px" cellspacing="0">
		<tr>
		<th colspan="2">Beneficiary 2 BANK INFORMATION:-(wherever multiple beneficiary is there iro deceased employee)</th>
			</tr>
			<tr>
			<td width="50%">Name of Employee/ In Case of deceased Employee-Name of Nominee (As per Saving Bank Account)</td>
			<td><%=bean.getCustomerName2() %></td>
			</tr>
			<tr>
		<td width="50%">Bank Account Number</td><td><%=bean.getAccNo2() %></td>
			</tr>
			<tr>
		<td>Bank Name</td><td><%=bean.getBankName2() %></td>
			</tr>
			<tr>
		<td>Branch Code & MICR Code</td><td><%=bean.getMicrCode2() %></td>
			</tr>
			
			<tr>
		<td>Branch Address</td><td><%=bean.getBranch2() %></td>
			</tr>
			<tr>
		<td>IFSC Code</td><td><%=bean.getIfscCode2() %></td>
			</tr>
			<tr>
		<td> Cancelled Cheque attached </td><td>Yes</td>
			</tr>
			
			</table>
			
			</td></tr>
			<tr><td>&nbsp;</td></tr>
			<tr>
				<td colspan="2" align="center">
					<table>
						<tr>
							<td>
								<b> I certify that particulars given above are correct and complete to the best of my knowledge and I am eligible for AAI EDCP Scheme. I also authorize AAI EDCP Trust to e-transfer the funds to my above-mentioned bank A/c.</b>
							</td>
						</tr>
					</table>

				</td>
			</tr>

			<tr><td>&nbsp;</td></tr>

			<tr>
			<table width="100%" border="1" bordercolor="#444" cellpadding="3px" cellspacing="0">
			<tr>
		<td width="50%" height="10%">Dated : <%=bean.getPolicyStartDate() %></td><td>Name and Signature of the Applicant</td>
			</tr>
			</table>
			</tr>

			<tr><td>&nbsp;</td></tr>
			<tr>
				<td colspan="2" align="center">
					<table  width="100%" border="1" bordercolor="#444" cellpadding="3px" cellspacing="0">
						<tr>
							<td>
								<b> Approval by Establishment wherein Service Records are maintained:</b>
							</td>
						</tr>
					</table>

				</td>
			</tr>

			<tr><td>&nbsp;</td></tr>
			<tr>
				<td colspan="2" align="center">
					<table  width="100%" border="1" bordercolor="#444" cellpadding="3px" cellspacing="0">
						<tr>
							<td>
								<b> Certified that the above particulars have been verified from Service records and is correct as per the service records. In case of deceased employee the nominee mentioned hereinabove is duly verified and certified latest nomination details filed by the employee.</b>
							</td>
						</tr>
					</table>

				</td>
			</tr>
			<tr><td>&nbsp;</td></tr>
			<tr>
				<td colspan="2" align="center">
					<table  width="100%" border="1" bordercolor="#444" cellpadding="3px" cellspacing="0">
						<tr>
							<td>
								<b> (Name, Designation  & Signature  of HR Nodal Officer )</b>
							</td>
						</tr>
					</table>
				</td>
			</tr>
			<tr><td>&nbsp;</td></tr>
			<tr><td>
			</table>
	</body>
</html>
