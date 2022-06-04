<%@ page language="java" import="java.util.*,aims.bean.LicBean" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
	 <%
  LicBean bean=null;
  
  bean=request.getAttribute("licBean")!=null?(LicBean)request.getAttribute("licBean"):new LicBean();
  
  
  String approveLevel=request.getAttribute("approveLevel")!=null?request.getAttribute("approveLevel").toString():"";
  
 // System.out.println("App id:::::::::"+bean.getAppId());
   %>

<html>
	<head>
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
		<meta http-equiv="description" content="This is my page">
		<script type="text/javascript" src="<%=basePath%>js/calendar.js"></script>
		<script type="text/javascript" src="<%=basePath%>js/CommonFunctions.js"></script>
		<script type="text/javascript" src="<%=basePath%>js/DateTime.js"></script>
		<link rel="stylesheet" href="<%=basePath%>css/style.css" type="text/css" />
		<LINK rel="stylesheet" href="<%=basePath%>css/displaytagstyle.css" type="text/css">
		
		
		
		
		<script type="text/javascript">
		
		function load(){
		
		
		var level='<%=approveLevel%>';
		document.getElementById("hr1").style.display = "none";
		document.getElementById("hr2").style.display = "none";
		alert(level);
		if(level=='HRLevel1'){
	
		
		}else if(level=='HRLevel2'){
	
		
		}
		
		
		}
		
	</script>
	</head>
	 
	<body >
		
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td colspan="6">
						<table width="100%" border="0" cellspacing="0" cellpadding="0">
							<tr>
								<td width="32%" rowspan="2">
									<img src="<%=basePath%>PensionView/images/logoani.gif" width="75" height="48" align="right" alt="" />
								</td>
								<td width="1%">
									&nbsp;
								</td>
								<td width="68%" class="reportlabel">
									AIRPORTS AUTHORITY OF INDIA
								</td>
							</tr>
							<tr>
								<td rowspan="2">
									&nbsp;
								</td>
								<td class="reportsublabel">
									Address of Unit Accepting the Annuity Form
								</td>
							</tr>
						</table>
					</td>
				</tr>

				

				<tr>
					<td colspan="6" align="center">
						<table width="100%" border="0" cellspacing="0" cellpadding="0">

							<tr>
								<td width="27%">
									&nbsp;
								</td>
								<td width="73%" class="reportlabel">
									
								</td>
							</tr>
							<tr>
								<td colspan="2" class="reportsublabel" align="center">

				
								</td>
							</tr>
							<tr>
								<td>
									&nbsp;
								</td>
							</tr>


						</table>
					</td>
				</tr>


				

					<tr>
						<td colspan="6">
							<table width="100%" border="0" cellspacing="2" cellpadding="2" align="center">


								<tr>
									<td width="20%">
										&nbsp;
									</td>
									<td width="31%" class="reportsublabel">
										Trust: AAI EDCP Trust
										
									</td>
									<td width="6%"></td>
									<td width="43%" class="reportsublabel">
										Region:<%=bean.getRegion() %>
										
									</td>
								</tr>


								<tr>
									<td>
										&nbsp;
									</td>
									<td colspan="3" class="reportsublabel">
									<% if(bean.getAaiEDCPSoption().equals("E")){%>
										<b>Annuity Form/Refund Application Receipt Acknowledgement :</b>
										<%}else{%>
                                         <b>Annuity Form Receipt Acknowledgement :</b>
										<%}%>

									</td>
								</tr>

								<tr>
									<td>
									</td>
								</tr>
								<tr>
									<td>
										&nbsp;
									</td>
									<td class="reportdata">
										Application No 
									</td>
									<td>
										:
									</td>
									<td class="reportdata">
										Annuity/<%=bean.getFormType() %>/<%=bean.getAppId() %>
									</td>
								</tr>
								<tr>
									<td>
										&nbsp;
									</td>
									<td class="reportdata">
										PF ID of Employee
									</td>
									<td>
										:
									</td>
									<td class="reportdata">
										 <%=bean.getEmployeeNo() %>
									</td>
								</tr>

								<tr>
									<td>
										&nbsp;
									</td>
									<td class="reportdata">
										Name of Employee/Beneficiary
									</td>
									<td>
										:
									</td>
									<td class="reportdata">
										<%=bean.getMemberName() %>
									</td>
								</tr>
							

								<tr>
									<td>
										&nbsp;
									</td>
									<td class="reportdata">
										Contact E-mail id 
									</td>
									<td>
										:
									</td>
									<td class="reportdata">
										<%=bean.getEmail() %>
									</td>
								</tr>
<tr>
									<td>
										&nbsp;
									</td>
									<td class="reportdata">
										Contact Mobile No. 
									</td>
									<td>
										:
									</td>
									<td class="reportdata">
										<%=bean.getMobilNo() %>
									</td>
								</tr>
								<tr>
									<td>
										&nbsp;
									</td>
									<td class="reportdata">
										Annuity Option Form Selected 
									</td>
									<td>
										:
									</td>
									<td class="reportdata">
										<%=bean.getAaiEDCPSoptionDesc() %> 
									</td>
								</tr>

								<tr>
									<td>
										&nbsp;
									</td>
									<td class="reportdata">
										&nbsp;
									</td>
									<td>
										&nbsp;
									</td>
									<td class="reportdata">
										&nbsp;
									</td>
								</tr>

						
								


								<tr>
									<td colspan="4">
										<table cellspacing="0" cellpadding="3px" border="1" align="center" width="60%">
										<tr>
										<th>List of Documents required as per Annuity Option selected</th>
										<th>Document Received (Y/N)</th>
										
										</tr>
										<tr>
										<td class="reportdata">One Set of Claim form (in original)</td>
										<td class="reportdata"><%=bean.getClaimForm() %></td>
										</tr>
										
										<tr><td>Self-Attested Copy of AAI Identity Card</td>
										<td><%=bean.getIdentityCard() %></td>
										</tr>
										<tr>
										<td>Self-Attested Copy of Last Pay Slip</td>
										<td><%=bean.getPaySlip() %></td></tr>
										
										<% if(bean.getAaiEDCPSoption().equals("A") || bean.getAaiEDCPSoption().equals("B")){%>
										<tr>
										<td>Self-Attested copy of PAN card of primary Annuitant</td>
										<td><%=bean.getPanCard() %></td></tr>
				<%}else if(bean.getAaiEDCPSoption().equals("C") || bean.getAaiEDCPSoption().equals("D")){ %>
				<tr>
										<td>Self-Attested copy of PAN card of primary Annuitant and secondary Annuitant</td>
										<td><%=bean.getPanCard() %></td></tr>
				
				
				<%} %>
				
				
				<% if(bean.getAaiEDCPSoption().equals("A") || bean.getAaiEDCPSoption().equals("B")){%>
										<tr>
										<td>Self-Attested copy of Aadhar card of primary Annuitant</td>
										<td><%=bean.getAdharCard() %></td></tr>
				<%}else if(bean.getAaiEDCPSoption().equals("C") || bean.getAaiEDCPSoption().equals("D")){ %>
				<tr>
										<td>Self-Attested copy of Aadhar card of primary Annuitant and secondary Annuitant</td>
										<td><%=bean.getAdharCard() %></td></tr>
				
				
				<%} %>

                                        <tr>
										<td>Cancelled Cheque (Printed name of the Annuitant)</td>
										<td><%=bean.getCancelCheque() %></td>
										</tr>
										
										<% if(bean.getAaiEDCPSoption().equals("A") || bean.getAaiEDCPSoption().equals("B")){%>
										<tr>
										<td>Photograph of primary Annuitant</td>
										<td><%=bean.getPhotograph() %></td></tr>
				<%}else if(bean.getAaiEDCPSoption().equals("C") || bean.getAaiEDCPSoption().equals("D")){ %>
				<tr>
										<td>Photograph of primary Annuitant and secondary Annuitant	</td>
										<td><%=bean.getPhotograph() %></td></tr>
				
				
				<%} %>

				<% if(bean.getAaiEDCPSoption().equals("E")){%>
                 <tr>
				 <td>In case of deceased employee, death certificate of employee</td>
				 <td><%=bean.getDeceasedemployee() %></td>
				 </tr>
				 <tr>
				 <td>For deceased employee case-Nomination Documents</td>
				 <td><%=bean.getNominationdoc() %></td>
				 </tr>
				 <tr>
				 <td>If yes,ID Proof of Nominee </td>
				 <td><%=bean.getNomineeproof() %></td>
				 </tr>
				<%}%>





</table>

</td>
</tr>
	<tr>
									<td>
										&nbsp;
									</td>
									<td class="reportdata">
										&nbsp;
									</td>
									<td>
										&nbsp;
									</td>
									<td class="reportdata">
										&nbsp;
									</td>
								</tr>
								
								
</table>


			</td></tr>	
			<tr>
									<td colspan="4" align="center">
										The documents received are subject to verification and scrutiny.
									</td>
									<td colspan="4" align="center">
										&nbsp;
									</td>
									
								</tr>	
										
										
										
										





										
								
								
								
							
								<tr>
									<td width="20%">
										&nbsp;
									</td>
									<td width="31%" class="reportsublabel">
										&nbsp;Date : <%=bean.getAckApproveDate() %>
									</td>
									<td width="3%">
										&nbsp;
									</td>
									<td width="46%" class="reportsublabel" align="right">
										
											<!--  <img src="<%=basePath%>/uploads/dbf/">-->
										<%=bean.getHr1displayname() %><br/><%=bean.getHr1designation() %>
										
										
									</td>
								</tr>
								<tr>
									<td>
										&nbsp;
									</td>
									<td class="reportsublabel">
										&nbsp;
									</td>
									<td>
										
									</td>
									<td class="reportsublabel" align="right">
										(Authorized Signatory)
									</td>
								</tr>
								
						</td>
					</tr>
				
			</table>

		
	</body>
</html>
