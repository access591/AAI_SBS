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
									<b>AIRPORTS AUTHORITY OF INDIA</b>
								</td>
							</tr>
							<tr>
								<td rowspan="2">
									&nbsp;
								</td>
								<td class="reportsublabel">
									&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;AAI EDCP Trust
								</td>
							</tr>
							<tr>
								<td rowspan="2">
									&nbsp;
								</td>
								<td class="reportsublabel">
									&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;CHQ
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
									<td colspan="3" class="reportsublabel" align="center">
									<%String Formname="";
										if(bean.getFormType().equals("RCForm")){
											Formname="Refund of corpus";
										}else{
                                            Formname="Annuity";
										}
											%>
										<b><h3>Sub:<%=Formname%> Form Approval</h3></b>
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
									<%if(bean.getFormType().equals("RCForm")){%>
										Refund/<%=bean.getFormType() %>/<%=bean.getAppId() %>
										<%}else{%>
										Annuity/<%=bean.getFormType() %>/<%=bean.getAppId() %>
										<%}%>
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
										Amount Admitted by AAI EDCP Trust with Interest upto
									</td>
									<td>
										:
									</td>
									<td class="reportdata">
										<%=bean.getIntcalcdate() %> 
									</td>
								</tr>
								<tr>
									<td>
										&nbsp;
									</td>
									<td class="reportdata">
										Date of Separation
									</td>
									<td>
										:
									</td>
									<td class="reportdata">
										<%=bean.getDos() %> 
									</td>
								</tr>
								<%if(!bean.getFormType().equals("RCForm")){
									System.out.println("mode of payment=="+bean.getPaymentMode());
									String paymentmode="";
									if(bean.getPaymentMode().equals("qly")){
                                       paymentmode="Quarterly";
									}else if(bean.getPaymentMode().equals("hly")){
										 paymentmode="Half yearly";
									}else{
                                         paymentmode=bean.getPaymentMode();
									}
									%>
								<tr>
									<td>
										&nbsp;
									</td>
									<td class="reportdata">
									a) Frequency :-
									</td>
									<td>
										:
									</td>
									<td class="reportdata">
										<%=paymentmode%> 
									</td>
								</tr>
								<%}%>
								
								<tr>
									<td>
										&nbsp;
									</td>
									<td class="reportdata">
									b) Corpus Details:-
									</td>
									<td>
										:
									</td>
									<td class="reportdata">
										Amount in Rs.
									</td>
								</tr>
									<tr>
									<td>
										&nbsp;
									</td>
									<td class="reportdata">
								Corpus approved by Regional Committee
									</td>
									<td>
										:
									</td>
									<%String RhqHrPurchaseAmt="";
									if(bean.getRhqHrPurchaseAmt().equals("")){
										 RhqHrPurchaseAmt="0";
									}else{
										RhqHrPurchaseAmt=bean.getRhqHrPurchaseAmt();
									}%>

									<td class="reportdata">
										<!--<%=bean.getEdcpCorpusAmt() %>-->
										<%=RhqHrPurchaseAmt %>
									</td>
								</tr>
									<tr>
									<td>
										&nbsp;
									</td>
									<td class="reportdata">
									Add: Interest upto <%=bean.getIntcalcdate() %>
									</td>
									<td>
										:
									</td>
									<% double intrestdiffamt=0;
									if(RhqHrPurchaseAmt.equals("0")){
                                     intrestdiffamt=0;
									}else{
									 intrestdiffamt= (Double.parseDouble(bean.getEdcpCorpusAmt())+Double.parseDouble(bean.getEdcpCorpusint()))-Double.parseDouble(RhqHrPurchaseAmt);
									}
									%>
									<td class="reportdata">
										<!--<%=bean.getEdcpCorpusint() %>-->
										<%=intrestdiffamt%>
									</td>
								</tr>
									<tr>
									<td>
										&nbsp;
									</td>
									<td class="reportdata">
									Total Annuity Purchase Amount to be paid
									</td>
									<td>
										:
									</td>
									<td class="reportdata">
										<%=Double.parseDouble(bean.getEdcpCorpusAmt())+Double.parseDouble(bean.getEdcpCorpusint()) %>
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
									<td class="reportdata" colspan="3">
									Interest rate for period upto FY 2019-20 has been calculated provisionally  @  7.431% pa.
									</td>
								</tr>
						
							
				<tr>
									<td>
										&nbsp;
									</td>
									<td class="reportdata" colspan="3">
									Interest rate for FY 2020-21 and 2021-22  has been calculated provisionally  @ 6.431% pa.
									</td>
								</tr>
									

								<tr>
									<td>
										&nbsp;
									</td>
									<td class="reportdata" colspan="3">
								CHQ Sub-Committe may please sanction the fnal  settlement of member by <%=Formname%> amounting to Rs.<%=Double.parseDouble(bean.getEdcpCorpusAmt())+Double.parseDouble(bean.getEdcpCorpusint()) %>/-  Subject to approval by Board of Trustees.
								</td>
								</tr>

								
								<!--<tr>
									<td>
										&nbsp;
									</td>
									<td class="reportdata" colspan="3">
									On approval we may request to issue Annuity Policy by adjusting Rs. <%=Double.parseDouble(bean.getEdcpCorpusAmt())+Double.parseDouble(bean.getEdcpCorpusint()) %>/- against the Funds available with them.	
									</td>
								</tr>
									<tr>
									<td>
										&nbsp;
									</td>
									<td class="reportdata" colspan="3">
									Committee  may please sanction the final settlement of Member by purchase of Annuity policy for RS.<%=Double.parseDouble(bean.getEdcpCorpusAmt())+Double.parseDouble(bean.getEdcpCorpusint()) %>/- subject to approval by Board of Trustees.</td>
								</tr>
								-->

								
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
										&nbsp;Date : <%=bean.getEdcpApproveDate1() %>
									</td>
									<td width="3%">
										&nbsp;
									</td>
									<td width="46%" class="reportsublabel" align="right">
										
										<!--  <img src="<%=basePath%>/uploads/dbf/">-->
										<%=bean.getEdcpDisplayname1() %><br/><%=bean.getEdcpDesignation1() %>
										
										
										
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
								
								
								
						</td>
					</tr>
				
			</table>

		
	</body>
</html>
