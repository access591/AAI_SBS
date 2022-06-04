<%@ page language="java" import="java.util.*,aims.bean.LicBean,aims.bean.SBSDeputationBean" %>
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
										<b>Annuity Form Receipt Acknowledgement:</b>
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
										Annuity/<%=bean.getFormType()%>/<%=bean.getAppId() %>
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


<tr>
										<td>Cancelled Cheque (Printed name of the Annuitant)</td>
										<td><%=bean.getCancelCheque() %></td></tr>
										
										<% if(bean.getAaiEDCPSoption().equals("A") || bean.getAaiEDCPSoption().equals("B")){%>
										<tr>
										<td>Photograph of primary Annuitant</td>
										<td><%=bean.getPhotograph() %></td></tr>
				<%}else if(bean.getAaiEDCPSoption().equals("C") || bean.getAaiEDCPSoption().equals("D")){ %>
				<tr>
										<td>Photograph of primary Annuitant and secondary Annuitant	</td>
										<td><%=bean.getPhotograph() %></td></tr>
				
				
				<%} %>





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

					<tr>
						<td colspan="6">
							<table width="100%" border="0" cellspacing="2" cellpadding="2" align="center">


								<tr>
									<td width="20%">
										&nbsp;
									</td>
									<td width="31%" class="reportsublabel">
									
										
									</td>
									<td width="6%"></td>
									<td width="43%" class="reportsublabel">
									
										
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
									<td>
										&nbsp;
									</td>
									<td colspan="3" class="reportsublabel">
										<b>Annuity Form HR Verification Form :</b>
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
									<td>
										&nbsp;
									</td>
									<td class="reportdata">
																	
a) All fields in the form verified from Service Books
									</td>
									<td>
										:
									</td>
									<td class="reportdata">
										<%=(bean.getServiceBook().equals("Y"))?"Yes verified":""%> 
									</td>
								</tr>
						
<tr>
									<td>
										&nbsp;
									</td>
									<td class="reportdata" colspan="2">
																	
<b>b) Further verification of EDCP Eligibility Condition of Employee  </b>

									</td>
									
									<td class="reportdata">
										<%if(bean.getEligibleStatus().equals("N")){ %>
										InEligible
										<%}else{ %>
										Eligible
										<%} %>
									</td>
								</tr>

								<tr>
									<td colspan="4">
										<table cellspacing="0" cellpadding="3px" border="1" align="center" width="60%">
										<tr>
										<th>Eligibility Condtion verified from Service Records</th>
										<th>Document Received (Y/N)</th>
										
										</tr>
										<tr>
										<td class="reportdata">CAD Pension Optee(less than 10 years)</td>
										<td class="reportdata"><%=bean.getCad() %></td>
										</tr>
										
										<tr><td>Separation Reason- If less than 15 years of service in CPSE for employees superannuating from 01.01.2007 to 02.08.2017</td>
										<td><%=bean.getCpse() %></td>
										</tr>
										<tr>
										<td>Separation Reason-  Termination, Dismissal, disciplinary proceedings, lispendens, or due to sudden disappearance (missing), CRS</td>
										<td><%=bean.getCrs() %></td></tr>
										<tr>
										<td>Separation Reason-  Resignation</td>
										<td><%=bean.getResign() %></td></tr>
										<tr>
										<td>Employees coming on  deputation to AAI</td>
										<td><%=bean.getDeputation() %></td></tr>





</table>

</td>
</tr>
<tr>
									<td>
										&nbsp;
									</td>
									<td class="reportdata" colspan="2">
																	
<b>c) Verification of Corpus:-  </b>

									</td>
									
									<td class="reportdata">
										
									</td>
								</tr>
<tr>
									<td>
										&nbsp;
									</td>
									<td class="reportdata">
																	
i) Whether Notional Increment was given or not?

									</td>
									<td>
										:
									</td>
									<td class="reportdata">
										<%=bean.getNotionalIncrement() %>
									</td>
								</tr>
								<tr>
									<td>
										&nbsp;
									</td>
									<td class="reportdata">
																	
ii) If yes then whether recovery in respect of notional increment to be recovered for the period 2007 onwards or not ?

									</td>
									<td>
										:
									</td>
									<td class="reportdata">
										<%=bean.getNotionaldisplay() %>
									</td>
								</tr>
					<% if(bean.getNotionalIncrement().equals("Y") && bean.getNotionaldisplay().equals("N")){%>			
								
				<tr>
									<td colspan="4">
										<table cellspacing="0" cellpadding="3px" border="1" align="center" width="50%">
										<tr><th> OB Remarks</th><th>Corpus OB Adjustment</th></tr>
										 <tr><td><%=bean.getObRemarks() %></td><td><%=bean.getCorpusOBAdjustment() %></td></tr>
										 </table>
									</td>
								
								</tr>				
								<%} %>
								<tr>
									<td>
										&nbsp;
									</td>
									<td class="reportdata">
																	
iii) Whether any arrear iro period prior to 01.01.2007 was paid to employee during 1.1.2007 to till date? 

									</td>
									<td>
										:
									</td>
									<td class="reportdata">
										<%=bean.getArrear() %>
									</td>
								</tr>
								<% if(bean.getArrear().equals("Y")){  %>
											<tr>
									<td>
										&nbsp;
									</td>
									<td class="reportdata">
																	
 If yes details may be mentioned and shared with Finance for OB adjustment?

									</td>
									<td>
										:
									</td>
									<td class="reportdata">
										<%=bean.getObadjustment() %>
									</td>
								</tr>
								<%} %>
								
								
										<tr>
									<td>
										&nbsp;
									</td>
									<td class="reportdata">
																	
iv) AAI Employee on  deputation from AAI to Other Organization? 

									</td>
									<td>
										:
									</td>
									<td class="reportdata">
										<%=bean.getDepaaiToOtherorg() %>
									</td>
								</tr>
								
								<% if(bean.getDepaaiToOtherorg().equals("Y")){
								ArrayList depList=null;
								 depList=(ArrayList)bean.getDepList();
								
								if(depList!=null){
								 %>
								<tr>
									
									<td colspan="4">
									<table cellspacing="0" cellpadding="3px" border="1" align="center" width="50%">
										<tr><th> SNo</th><th>From Date</th><th>To Date</th></tr>
										
										<%
										SBSDeputationBean depbean=null;
										for(int i=0;i<depList.size();i++){
										depbean=(SBSDeputationBean)depList.get(i);
										%>
										<tr><td> <%=depbean.getDepId() %></td><td><%=depbean.getFromDate() %></td><td><%=depbean.getToDate() %></td></tr>
										
										 <% }%>
										</table>
									</td>
								</tr>
								
								<%}} %>
								<% if(bean.getAaiEDCPSoption().equals("E")){%>
	<tr>
									<td>
										&nbsp;
									</td>
	<td class="reportdata">
																	
v) Total SBS corpus   less than Rs. 2 lakhs

									</td>
									<td>
										:
									</td>
									<td class="reportdata">
										<%=bean.getTotcorpus2lakhs() %>
									</td>
									</tr>
									<tr>
									<td>
										&nbsp;
									</td>
									<td class="reportdata">
																	
vi) Wherever employee has expired-Death certificate and Nominee details verified and certified 

									</td>
									<td>
										:
									</td>
									<td class="reportdata">
										<%=bean.getDeathcertficate() %>
									</td>
									</tr>

								<%}%>
	<tr>
									<td>
										&nbsp;
									</td>
									<%String filename=bean.getAppId()+".pdf"; %> 
									<td class="reportdata">
										<a href="PensionView/SBS/Download.jsp?filename=<%=filename%>&&doctype=ack"><b>For View/Download Documents Click Here</b></a>
													
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
										
									</td>
									<td colspan="4" align="center">
										&nbsp;
									</td>
									
								</tr>	
										
										
										
										





					<tr>
									<td colspan="4" align="center">
									Verified And certified that employee is eligible for EDCP Scheme <br/> .Forwarded to Finance for payment action.
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
										&nbsp;Date : <%=bean.getHrApproveDate() %>
									</td>
									<td width="3%">
										&nbsp;
									</td>
									<td width="46%" class="reportsublabel" align="right">
										
										<!--<img src="<%=basePath%>/uploads/dbf/">-->
										<%=bean.getHr2displayname() %><br/><%=bean.getHr2designation() %>
										
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
								
						<tr>
									<td>
										&nbsp;
									</td>
									<td colspan="3" class="reportsublabel">
										<b> Finance Verification Form :</b>
									</td>
								</tr>
		
<tr>
									<td>
										&nbsp;
									</td>
									<td class="reportdata" colspan="2">
									<tr>
						<td colspan="6">
							<table width="100%" border="0" cellspacing="2" cellpadding="2" align="center">


								<tr>
									<td width="20%">
										&nbsp;
									</td>
									<td width="31%" class="reportsublabel">
									
										
									</td>
									<td width="6%"></td>
									<td width="43%" class="reportsublabel">
									
										
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
									<td>
										&nbsp;
									</td>
									<td class="reportdata" colspan="2">
																	
<b>a) Bank details verified from Cancelled Cheque:-  </b>

									</td>
									
									<td class="reportdata">
										
									</td>
								</tr>
								
<tr>
									<td>
										&nbsp;
									</td>
									<td class="reportdata">
																	
Name of Bank

									</td>
									<td>
										:
									</td>
									<td class="reportdata">
										<%=bean.getBankName() %>
									</td>
								</tr>
								<tr>
									<td>
										&nbsp;
									</td>
									<td class="reportdata">
																	
Bank Branch

									</td>
									<td>
										:
									</td>
									<td class="reportdata">
										<%=bean.getBranch() %>
									</td>
								</tr>
								<tr>
									<td>
										&nbsp;
									</td>
									<td class="reportdata">
																	
IFSC Code

									</td>
									<td>
										:
									</td>
									<td class="reportdata">
										<%=bean.getIfscCode() %>
									</td>
								</tr>
								<tr>
									<td>
										&nbsp;
									</td>
									<td class="reportdata">
																	
	MICR Code

									</td>
									<td>
										:
									</td>
									<td class="reportdata">
										<%=bean.getMicrCode() %>
									</td>
								</tr>
								<tr>
									<td>
										&nbsp;
									</td>
									<td class="reportdata">
																	
	Account No.

									</td>
									<td>
										:
									</td>
									<td class="reportdata">
										<%=bean.getAccNo() %>
									</td>
								</tr>
										<tr>
									<td>
										&nbsp;
									</td>
									<td class="reportdata">
																	
	b) Whether recovery for  Notional Increment is appearing in Corpus Card correctly?

									</td>
									<td>
										:
									</td>
									<td class="reportdata">
										<%=bean.getFinNoIncrement() %>
									</td>
								</tr>
								<tr>
									<td>
										&nbsp;
									</td>
									<td class="reportdata">
																	
	c) Whether any arrear iro period prior to 01.01.2007 was paid to employee during 1.1.2007 to till date? 

									</td>
									<td>
										:
									</td>
									<td class="reportdata">
										<%=bean.getFinArrear() %>
									</td>
								</tr>
								<tr>
									<td>
										&nbsp;
									</td>
									<td class="reportdata">
																	
d) If yes then OB adjustment for arrear pertaining to pre 01.01.2007 done in the card?

									</td>
									<td>
										:
									</td>
									<td class="reportdata">
										<%=bean.getFinPreOBadj() %>
									</td>
								</tr>
								<tr>
									<td>
										&nbsp;
									</td>
									<td class="reportdata">
																	
	e) OB adjustment for any other reason required?

									</td>
									<td>
										:
									</td>
									<td class="reportdata">
										<%=bean.getObOtherReason() %>
									</td>
								</tr>
								<tr>
									<td>
										&nbsp;
									</td>
									<td class="reportdata">
																	
	f) If yes then OB adjustment updated in the Corpus Card?	

									</td>
									<td>
										:
									</td>
									<td class="reportdata">
										<%=bean.getFinOBadjCorpusCard() %>
									</td>
								</tr>
								<tr>
									<td>
										&nbsp;
									</td>
									<td class="reportdata">
																	
	g) Corpus card verified and duly signed copy forwarded to RHQ/CHQ/EDCP Trust as the case may be?	

									</td>
									<td>
										:
									</td>
									<td class="reportdata">
										<%=bean.getFinCorpusVerified() %>
									</td>
								</tr>
							
		<% if(bean.getAaiEDCPSoption().equals("E")){%>
		<tr>
									<td>
										&nbsp;
									</td>
									<td class="reportdata">
																	
	   h) Total SBS corpus   less than Rs. 2 lakhs:	

									</td>
									<td>
										:
									</td>
									<td class="reportdata">
										<%=bean.getTotcorpus2lakhs() %>
									</td>
								</tr>
								<%}%>
							
								
							
								
	<tr>
									<td>
										&nbsp;
									</td>
									<td class="reportdata">
										<a href="PensionView/SBS/Download.jsp?filename=<%=filename%>&&doctype=ack"><b>For View/Download Documents Click Here</b></a>
													
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
										&nbsp;Date : <%=bean.getFinApproveDate() %>
									</td>
									<td width="3%">
										&nbsp;
									</td>
									<td width="46%" class="reportsublabel" align="right">
										
										<!--  <img src="<%=basePath%>/uploads/dbf/">-->
										<%=bean.getFindisplayname() %><br/><%=bean.getFindesignation() %>
										
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
