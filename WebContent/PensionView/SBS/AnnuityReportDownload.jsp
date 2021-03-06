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

		<table width="98%">
			<tr>
				<td align="right" style="margin: 35px 40px;">
					<img src="assets/img/lic-logo.png">
				</td>
				<td align="left">


					<span
						style="font-size: 20px; font-weight: 600; text-align: center !important;">
						<center>
							P&GS DEPARTMENT, DELHI DIVISIONAL OFFICE-I
							<br>
							6TH FLOOR, JEEVAN PRAKASH;
							<br>
							25 K G MARG, NEW DELHI -110001
							<br>
							<font style="color: blue">Bo_g103gsca@licindia.com </font>
						</center> </span>


				</td>
			</tr>
			<tr>
				<td colspan=2>

					<center>
						====================================================================================================
					</center>
				</td>

			</tr>

			<tr>
				<td colspan=2
					style="text-align: center; font-weight: 400 !important;">

					<center>
						Intimation of Retirement/Death/Leaving Services
					</center>

				</td>
			</tr>
			<tr>
				<td align="center">


					<b> Type of Scheme : NGSCA </b>
				</td>
				<td></td>
			</tr>
			<tr>
				<td align="center">


					<b>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						Master Policy No. : ---103006297 </b>
				</td>
				<td></td>
			</tr>

			<tr>
				<td colspan="2" align="center">
					<table>
						<tr>
							<td>
								<b> We would like to submit our claim for payment of the
									benefit under the superannuation scheme in respect of the <br>
									following member, who has exited the services of the
									organization by way of Superannuation/Voluntary <br>
									Retirement/Resignation/Death. The details of the member are
									given below for your perusal.</b>
							</td>
						</tr>
					</table>

				</td>
			</tr>
			<tr>
				<td colspan="2" align="center">
					<table border="1" width="950" cellspacing="0" cellpadding="2px">
						<tr>
							<td>
								1
							</td>
							<td>
								Name of Member/Beneficiary
							</td>
							<td><%=bean.getMemberName()%></td>
						</tr>
						<tr>
							<td>
								2
							</td>
							<td>
								LIC ID Number
							</td>
							<td></td>
						</tr>
						<tr>
							<td>
								3
							</td>
							<td>
								Employee Number(PF ID)
							</td>
							<td><%=bean.getEmployeeNo()%></td>
						</tr>
						<tr>
							<td>
								4
							</td>
							<td>
								Date of Birth
							</td>
							<td><%=bean.getDob()%></td>
						</tr>
						<tr>
							<td>
								5
							</td>
							<td>
								Date of Exit & Date of Joining
							</td>
							<td><%=bean.getDateOfexit()%> &
								<%=bean.getDoj()%></td>
						</tr>
						<tr>
							<td>
								6
							</td>
							<td>
								Cause of Exit <br>In case of Death (Original Death Certificate to be
								attached)
							</td>
							<td><%=bean.getExitReason()%></td>
						</tr>
						<tr>
							<td>
								7
							</td>
							<td>
								Final Contribution, if any, on cassation of services
							</td>
							<td></td>
						</tr>
						<tr>
							<td>
								8
							</td>
							<td>
								Whether option to commute part of pension exercised or not:
							</td>
							<td>
								NOT APPLICABLE AS PER AAIEDCPS RULES
							</td>
						</tr>

						<tr>
							<td colspan="3">
								<table border="0">
									<tr>
										<td>
											9.Type of pension Option elected (Initials of the member
											<br>
											against the pension option exercised). Option available(As
											decided by AAIEDCPS)
											<td></td>
										<td>
											<table border="1" cellspacing="0" cellpadding="2px">
												<tr>
													<td>
														Option Chosen
													</td>
													<td><%=bean.getAaiEDCPSoption()%></td>
												</tr>
												<tr>
													<td>
														Sign/Initials of the member
													</td>
													<td>
														&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
													</td>
												</tr>
											</table>
										</td>
										</t>
									</tr>
									<tr>
										<td colspan="2">
											a) Life Pension

										</td>
									</tr>
									<tr>
										<td colspan="2">
											b) Life Pension With Return Of Corpus

										</td>
									</tr>
									<tr>
										<td colspan="2">
											c) Annuity for life with a provision for 100% of the annuity
											payable to the spouse on death of the annuitant WITHOUT
											return of corpus thereafter.

										</td>
									</tr>
									<tr>
										<td colspan="2">
											d) Annuity for life with a provision for 100% of the annuity
											payable to the spouse on death of the annuitant WITH return
											of corpus to Nominee therafter.

										</td>
									</tr>
									<tr>
										<td colspan="2">

											<b>10. If joint life pension is opted, furnish the
												following details:</b>
										</td>
									</tr>
								</table>
						<tr>
							<td colspan="3">

								<table width="100%" cellspacing="0" border="1">
									<tr>
										<th>
											Name of the spouse
										</th>
										<th>
											Address
										</th>
										<th>
											Date of Birth
										</th>
										<th>
											Relationship (Husband/Wife)
										</th>
									</tr>
									<tr>
										<td>
											<%=bean.getSpouseName() %>
										</td>
										<td><%=bean.getSpouseAdd() %></td>
										<td><%=bean.getSpouseDob() %></td>
										<td><%=bean.getSpouseRelation() %></td>
									</tr>

								</table>
						</td>
						</tr>



						<tr>
							<td>
								11
							</td>
							<td>
								Mode of Annuity Payment
							</td>
							<td><%=bean.getPaymentMode()%></td>
						</tr>
						<tr>
							<td>
								12
							</td>
							<td>
								<b>Particulars of Member/Beneficiary</b>
							</td>
							<td></td>
						</tr>
						<tr>
							<td>

							</td>
							<td>
								a) Complete Residential Address of correspondence
							</td>
							<td><%=bean.getMemberAddress()%></td>
						</tr>
						<tr>
							<td>

							</td>
							<td>
								b) Permanent Residential Address
							</td>
							<td><%=bean.getMemberPerAdd()%></td>
						</tr>
						<tr>
							<td>

							</td>
							<td>
								c) Name of the Nominee
							</td>
							<td><%=bean.getNomineeName()%></td>
						</tr>
						<tr>
							<td>

							</td>
							<td>
								d) Relationship with Member/Beneficiary
							</td>
							<td><%=bean.getRelationtoMember()%></td>
						</tr>
						<tr>
							<td>

							</td>
							<td>
								e) Date of Birth of Nominee
							</td>
							<td><%=bean.getNomineeDob()%></td>
						</tr>
						<tr>
							<td>

							</td>
							<td>
								f) PAN NO(pl attach a copy)
							</td>
							<td><%=bean.getPanNo()%></td>
						</tr>
						<tr>
							<td>

							</td>
							<td>
								g) Adhar No(attach a copy)
							</td>
							<td><%=bean.getAdharno()%></td>
						</tr>
						<tr>
							<td>

							</td>
							<td>
								h) Mobile/Phone no
							</td>
							<td><%=bean.getMobilNo()%></td>
						</tr>
						<tr>
							<td>

							</td>
							<td>
								i) E Mail Id
							</td>
							<td><%=bean.getEmail()%></td>
						</tr>
						<tr>
							<td>

							</td>
							<td>
								<b>j)Bank account details to which pension is
to be credited</b>
							</td>
							<td></td>
						</tr>
						<tr>
							<td>

							</td>
							<td>
								k)Name of Bank
							</td>
							<td><%=bean.getBankName()%></td>
						</tr>
						<tr>
							<td>

							</td>
							<td>
								l)Address of Bank Branch
							</td>
							<td><%=bean.getBranch()%></td>
						</tr>
						<tr>
							<td>

							</td>
							<td>
								m)IFSC Code(11 Characters of the Bank
Branch-As appearing in your cheque book)

							</td>
							<td><%=bean.getIfscCode()%></td>
						</tr>
						<tr>
							<td>

							</td>
							<td>
								
m)MICR Code
							</td>
							<td><%=bean.getMicrCode()%></td>
						</tr>
						<tr>
							<td>

							</td>
							<td>
								
n)Type of Account(Saving/Current)
							</td>
							<td><%=bean.getAccType()%></td>
						</tr>
						<tr>
							<td>

							</td>
							<td>
o)Account Number ( Pl attach a copy of the
cancelled cheque leaf / passbook)
							</td>
							<td><%=bean.getAccNo()%></td>
						</tr>
					</table>
				</td>

			</tr>
			<tr>
			<td colspan="2" align="center">
			<table border="0" width="950" cellspacing="15px" cellpadding="3px"><tr><td colspan="2" align="left"><b>For Self and Co-Trustees of _AAIEDCPS_Superannuation Scheme.</b></td></tr>
			<tr><td  align="left"><b>(Sign. Of Member/Beneficiary )</b></td><td align="right"><b>Signature of The Trustee</b></td></tr>
			<tr><td  align="left"></td><td align="right"><b>(Name & Stamp)</b></td></tr>
			<tr><td colspan="2" align="left"><b>Note: - It very important that appropriate answers are given. Without which the settlement will not be possible.</b></td></tr>
			</table>
			
			</td>
			</tr>
			<tr>
			<td colspan="2" align="center">
			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			
			</td>
			</tr>
			<tr>
			<td colspan="2" align="center">
			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			
			</td>
			</tr>
			
			<tr>
				<tr>
			<td colspan="2" align="center">
			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			
			</td>
			</tr>
			
			<tr>
				<tr>
			<td colspan="2" align="center">
			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			
			</td>
			</tr>
			
			<tr>
				<tr>
			<td colspan="2" align="center">
			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			
			</td>
			</tr>
			
			<tr>
			<td colspan="2" align="center">
			<table border="0" width="950" cellspacing="25px" cellpadding="5px"><tr><td colspan="2" align="center"><h4>Discharge Receipt<br/>
(To be completed by the Member/Beneficiary)</h4></td></tr>
			<tr><td colspan="2" align="left"><b>I, Shri/Smt. <u>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<%=bean.getMemberName() %>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</u> received from the Life Insurance Corporation of India the
sum of Rs.__________ (Rupees_________________________________) in full satisfaction and discharge
of my under mentioned claims and demand under Master Policy No- 103006297</b></td></tr>
			<tr><td  align="left"><b>Commuted Value</b></td><td align="right"><b>Rs. ___________________</b></td></tr>
			<tr><td colspan="2" align="left"><b>MLY/QLY/HLY/YLY/ pension Installment due (........to......)Rs. ___________________</b></td></tr>
			<tr><td  align="left"><b>TOTAL</b></td><td align="right"><b>Rs. ___________________</b></td></tr>
			<tr><td  align="left"><b><u>Witness</u></b></td><td align="right"><b></b></td></tr>
			<tr><td  align="left"><b>Signature : ______________________<br/>
			Name &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;	: ______________________<br/>
			Address &nbsp;&nbsp;: ______________________
			</b></td><td align="left"><table cellspacing="0" border="1"><tr><td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Across&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<br/>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Rs.1/-<br/>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Revenue<br/>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Stamp</td></tr></table><br/>
Signature of the Member/Beneficiary</td></tr>
			</table>
			
			</td>
			</tr>
			<tr>
			<td colspan="2" align="center">
			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			
			</td>
			</tr>
			<tr>
			<td colspan="2" align="center">
			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			
			</td>
			</tr>
			<tr>
			<td colspan="2" align="center">
			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			
			</td>
			</tr>
			<tr>
			<td colspan="2" align="center">
			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			
			</td>
			</tr>
			<tr>
			<td colspan="2" align="center">
			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			
			</td>
			</tr>
			<tr>
			<td colspan="2" align="center">
			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			
			</td>
			</tr>
			<tr>
			<td colspan="2" align="center">
			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			
			</td>
			</tr>
			<tr>
			<td colspan="2" align="center">
			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			
			</td>
			</tr>
			<tr>
			<td colspan="2" align="center">
			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			
			</td>
			</tr>
			<tr>
			<td colspan="2" align="center">
			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			
			</td>
			</tr>
			</table>
			<br style='page-break-after:always;'>
			<table width="98%">
			
			<tr>
			<td colspan="2" align="center">
			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			
			</td>
			</tr><tr>
			<td colspan="2" align="center">
			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			
			</td>
			</tr><tr>
			<td colspan="2" align="center">
			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			
			</td>
			</tr><tr>
			<td colspan="2" align="center">
			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			
			</td>
			</tr><tr>
			<td colspan="2" align="center">
			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			
			</td>
			</tr><tr>
			<td colspan="2" align="center">
			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			
			</td>
			</tr><tr>
			<td colspan="2" align="center">
			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			
			</td>
			</tr><tr>
			<td colspan="2" align="center">
			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			
			</td>
			</tr><tr>
			<td colspan="2" align="center">
			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			
			</td>
			</tr><tr>
			<td colspan="2" align="center">
			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			
			</td>
			</tr><tr>
			<td colspan="2" align="center">
			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			
			</td>
			</tr><tr>
			<td colspan="2" align="center">
			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			
			</td>
			</tr><tr>
			<td colspan="2" align="center">
			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			
			</td>
			</tr><tr>
			<td colspan="2" align="center">
			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			
			</td>
			</tr>
			<tr>
			<td colspan="2" align="center">
			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			
			</td>
			</tr>
			<tr>
			<td colspan="2" align="center">
			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			
			</td>
			</tr>
			<tr>
			<td colspan="2" align="center">
			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			
			</td>
			</tr>
			<tr>
			<td colspan="2" align="center">
			<table border="0" width="950" cellspacing="25px" cellpadding="5px"><tr><td colspan="2" align="center"><h4>(To be completed by the Annuitant and kept/Preserved with the Trustee)
<br/>
NOMINATION</h4></td></tr>
<tr><td colspan="2" align="left"><b>I, Shri/Smt. <u>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<%=bean.getMemberName() %>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</u> a member of AAIEDCPS Superannuation Scheme hereby
appoint nominees in terms of the Nomination Rules governing the fund to received the Pension in the event of my
death during the guaranteed period as per the rules of the fund or to receive the Capital refund under Return of
Capital Scheme in the event of my death as given below:</b></td></tr>
<tr><td colspan="2">
<table border="1" width="950" cellspacing="0px" ><tr><th>Name of the
Nominee</th><th>Address</th><th>Date of
Birth</th><th>Relationship</th><th>Percentage</th></tr>

<% if(bean.getNomineeList()!=null){ 
ArrayList nomineeList=bean.getNomineeList();
System.out.println(nomineeList.size());
SBSNomineeBean nominee=null;
for(int i=0;i<nomineeList.size();i++){
 nominee=(SBSNomineeBean)nomineeList.get(i);

%>

<tr><td><%=nominee.getNomineename() %></td><td><%=nominee.getNomineeAdd() %></td><td><%=nominee.getNomineeDOB()  %></td><td><%=nominee.getNomineeRelation() %></td><td><%=nominee.getPercentage()  %></td></tr>
<%}}else{ %>
<tr><td colspan="4"> No Records Found</td></tr>
<%} %>

</table>

</td></tr>
	<tr>
			<td colspan="2" align="left">
			<b>If the nominee is minor, furnish the details of appointee:</b>
			
			</td>
			</tr>
			<tr><td colspan="2">
<table border="1" width="950" cellspacing="0px" ><tr><th>Name & Address of the Appointee</th><th>Relationship
With
Nominee</th><th>Date of
Birth</th><th>Signature of the
appointee</th></tr>

<% if(bean.getNomineeAppointeeList()!=null){ 
ArrayList nomineeAppList=bean.getNomineeAppointeeList();
SBSNomineeBean appointee=null;
for(int n=0;n<nomineeAppList.size();n++){
 appointee=(SBSNomineeBean)nomineeAppList.get(n);

%>
<tr><td><%=appointee.getNomineename() %></td><td><%=appointee.getNomineeRelation() %></td><td><%=appointee.getNomineeDOB() %></td><td></td></tr>
<%}}else{ %>
<tr><td colspan="4"> No Records Found</td></tr>
<%} %>
</table>

</td></tr>
<tr>
			<td colspan="2" align="left">
			<b>I further agree and declare that upon such PENSION payment or RETURN OF CAPITAL amount, the
Corporation will be <br/> discharged of all liability in this respect under the Master Policy No 103006297</b>
			
			</td>
			</tr>
			<tr>
			<td colspan="2" align="left">
			<b>Place:
 <br/> Date:</b>
			
			</td>
			</tr>
			<tr>
			<td  align="left">
			<b>Signature of Member / Annuitant</b>
			
			</td>
			<td align="center"><b>Counter Signature by the Trustee<br/>
Seal of the Truste</b></td>
			</tr>

</table>
			
			</td>
			</tr>
			
			<tr>
									<td colspan="4">
										<table cellspacing="0" cellpadding="3px" border="1" align="center" width="60%">
										<tr>
										<th colspan="2">Documents Required</th>
										
										
										</tr>
										<tr>
										<td class="reportdata" colspan="2">Four Sets of Claim form (in original)</td>
										
										</tr>
										
										<tr><td colspan="2">Self-Attested Copy of AAI Identity Card</td>
										
										</tr>
										<tr>
										<td colspan="2">Self-Attested Copy of Last Pay Slip</td>
										</tr>
										
										<% if(bean.getAaiEDCPSoption().equals("A") || bean.getAaiEDCPSoption().equals("B")){%>
										<tr>
										<td colspan="2">Self-Attested copy of PAN card of primary Annuitant</td>
										</tr>
				<%}else if(bean.getAaiEDCPSoption().equals("C") || bean.getAaiEDCPSoption().equals("D")){ %>
				<tr>
										<td colspan="2">Self-Attested copy of PAN card of primary Annuitant and secondary Annuitant</td>
										</tr>
				
				
				<%} %>
				
				
				<% if(bean.getAaiEDCPSoption().equals("A") || bean.getAaiEDCPSoption().equals("B")){%>
										<tr>
										<td colspan="2">Self-Attested copy of Aadhar card of primary Annuitant</td>
										</tr>
				<%}else if(bean.getAaiEDCPSoption().equals("C") || bean.getAaiEDCPSoption().equals("D")){ %>
				<tr>
										<td colspan="2">Self-Attested copy of Aadhar card of primary Annuitant and secondary Annuitant</td>
										</tr>
				
				
				<%} %>

<tr>
										<td colspan="2">Cancelled Cheque (Printed name of the Annuitant)</td>
										</tr>
										
										<% if(bean.getAaiEDCPSoption().equals("A") || bean.getAaiEDCPSoption().equals("B")){%>
										<tr>
										<td colspan="2">Photograph of primary Annuitant</td>
										</tr>
				<%}else if(bean.getAaiEDCPSoption().equals("C") || bean.getAaiEDCPSoption().equals("D")){ %>
				<tr>
										<td colspan="2">Photograph of primary Annuitant and secondary Annuitant	</td>
										</tr>
				
				
				<%} %>





</table>

</td>
</tr>
			
		</table>
	</body>



</html>
