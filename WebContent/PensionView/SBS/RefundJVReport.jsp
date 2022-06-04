<%@ page language="java" import="java.util.*,aims.bean.LicBean,aims.common.CommonUtil" pageEncoding="UTF-8"%>
<%@ page import="java.text.DecimalFormat"%>
<jsp:useBean id="nc" class="aims.common.CommonUtil" />
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
	 <%
  LicBean bean=null;
  DecimalFormat df = new DecimalFormat("#########0");
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
								<td width="1%" align="center">
									&nbsp;
								</td>
								<td width="68%" class="reportlabel">
									AIRPORTS AUTHORITY OF INDIA
								</td>
							</tr>
							<tr>
								<td rowspan="2" align="center">
									&nbsp;
								</td>
								<td class="reportlabel"  width="38%" align="left">
									AAI EDCP TRUST
								</td>
							</tr>
							<tr>
								<td rowspan="2" align="center">
									&nbsp;
								</td>
								<td class="reportlabel" align="left">
									<%=bean.getRegion() %>
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
										Voucher Type : Journal Voucher
										
									</td>
									<td width="6%"></td>
									<td width="43%" class="reportsublabel">
										Financial Year:<%=bean.getFinYear() %>
										
									</td>
								</tr>


								<tr>
									<td width="20%">
										&nbsp;
									</td>
									<td width="31%" class="reportsublabel">
										Employee Name :  <%=bean.getMemberName() %>
										
									</td>
									<td width="6%"></td>
									<td width="43%" class="reportsublabel">
										Preperation Date :<%=bean.getJvPrepDate() %>
										
									</td>
								</tr>

								<tr>
									<td width="20%">
										&nbsp;
									</td>
									<td width="31%" class="reportsublabel">
										PFID : :<%=bean.getEmpsapCode() %>
										
									</td>
									<td width="6%"></td>
									<td width="43%" class="reportsublabel">
										Voucher Number : <%=bean.getJvNumber() %>
										
									</td>
								</tr>
								<tr>
									<td width="20%">
										&nbsp;
									</td>
									<td width="31%" class="reportsublabel">
										&nbsp;
									</td>
									<td width="6%"></td>
									<td width="43%" class="reportsublabel">
										Voucher Date :<%=bean.getJvEnterdDt() %>
										
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
										<th>Region</th>
										<th>Station</th>
										<th>Account Code</th>
										<th>Account Name</th>
										<th>Details</th>
										<th>Debit</th>
										<th>Credit</th>
										</tr>

										<tr>
										<td class="reportdata"><%=bean.getRegion() %></td>
										<td class="reportdata"><%=bean.getAirport() %></td>
                                        <%if(bean.getFormType().equals("RCForm")){ %>
										<td>305</td>
										<td>To Refund Final Settlement</td>
                                         <%} else if(bean.getFormType().equals("HDFC")){ %>
                                        <td>302</td>
										<td>To Final Settlement-Member A/c-HDFC</td>
                                         <%} else if(bean.getFormType().equals("SBI")){ %>
										 <td>303</td>
										<td>To Final Settlement-Member A/c-SBI</td>
                                         <%} else if(bean.getFormType().equals("LIC")){ %>
										 <td>301</td>
										<td>To Final Settlement-Member A/c-LIC</td>
                                         <%}%>
										<td>&nbsp;</td>
										<td><%=bean.getDebitAmount() %></td>
										<td>0.00</td>
										</tr>

										<tr>
										<td class="reportdata"><%=bean.getRegion() %></td>
										<td class="reportdata"><%=bean.getAirport() %></td>
										<%if(bean.getFormType().equals("RCForm")){ %>
										<td>655</td>
										<td>To Refund (less than 2 lakhs) payable</td>
										<%} else if(bean.getFormType().equals("HDFC")){ %>
                                        <td>652</td>
										<td>Annuity Purchase from Funds Invested-HDFC</td>
                                         <%} else if(bean.getFormType().equals("SBI")){ %>
										 <td>653</td>
										<td>Annuity Purchase from Funds Invested-SBI</td>
                                         <%} else if(bean.getFormType().equals("LIC")){ %>
										 <td>651</td>
										<td>Annuity Purchase from Funds Invested-LIC</td>
                                         <%}%>
										<td>&nbsp;</td>
										<td>0.00</td>
										<td><%=bean.getCreditAmount() %></td>
										</tr>

										<tr>
										<td colspan="5">&nbsp</td>
										<td><%=bean.getDebitAmount() %></td>
										<td><%=bean.getCreditAmount() %></td>
										</tr>

</table>

<tr colspan="6"><td>&nbsp;</td></tr>

<tr>
<td colspan="6" align="center">
 AMOUNT IN WORDS:-<%=nc.findWords(df.format(Double.parseDouble(bean.getDebitAmount()))) %>
</td>
</tr>
<tr colspan="6"><td>&nbsp;</td></tr>

<tr>
<td colspan="6" align="center">
 Approval of Refund  amount, Reg <%=bean.getMemberName() %>, pfid :<%=bean.getEmpsapCode() %> vide applicationno ANNUITY/<%=bean.getFormType() %>/<%=bean.getAppId() %>  
</td>
</tr>
<tr colspan="6"><td>&nbsp;</td></tr>
<tr colspan="6"><td>&nbsp;</td></tr>
<tr>
<td colspan="3" align="center">
 Prepared By- Anil Kumar
</td>
<td colspan="3" align="center">
 Approved By- Naresh Kumar Jain
</td>
</tr>
<tr>
<td colspan="3" align="center">
 Manager(F)
</td>
<td colspan="3" align="center">
 AGM(FIN)
</td>
</tr>
<tr>
<td colspan="3" align="center">
 (Authorized Signatory)
</td>
<td colspan="3" align="center">
 (Authorized Signatory)
</td>
</tr>

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

		
	</body>
</html>
