Fund WithDraw
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
								<td class="reportlabel"  width="38%" align="left">
									AAI EDCP TRUST
								</td>
							</tr>
							<tr>
								<td rowspan="2">
									&nbsp;
								</td>
								<td class="reportlabel" align="left">
									CHQ
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
										Voucher Type : Receipt
										
									</td>
									<td width="6%"></td>
									<td width="43%" class="reportsublabel">
										Bank Name : Lic
										
									</td>
								</tr>


								<tr>
									<td width="20%">
										&nbsp;
									</td>
									<td width="31%" class="reportsublabel">
										Fund withdraw No :
										
									</td>
									<td width="6%"></td>
									<td width="43%" class="reportsublabel">
										Account Number
										
									</td>
								</tr>

								<tr>
									<td width="20%">
										&nbsp;
									</td>
									<td width="31%" class="reportsublabel">
										FManager :Lic
										
									</td>
									<td width="6%"></td>
									<td width="43%" class="reportsublabel">
										Financial Year : 2019-20
										
									</td>
								</tr>
								<tr>
									<td width="20%">
										&nbsp;
									</td>
									<td width="31%" class="reportsublabel">
										Employee  PFid:
									</td>
									<td width="6%"></td>
									<td width="43%" class="reportsublabel">
										Voucher No :
										
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
										Prepared Date :
										
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
										Voucher Date :
										
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
										Trust Type : AAI EDCP
										
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
										<th>Acciunt Code</th>
										<th>Particular</th>
										<th>Maonth/Year</th>
										<th>Details(if any)</th>
										<th>Cheque No</th>
										<th>Debit(Rs)</th>
										<th>Credit(Rs)</th>
										</tr>

										<tr>
										<td >672.04</td>
										<td class="reportdata">Fund Withdraw CLIC</td>
										<td>Dec/2019</td>
										<td>&nbsp;</td>
										<td>&nbsp;</td>
										<td>262500</td>
										<td>0</td>
										</tr>

										<tr>
										<td class="reportdata" colspan="5">Total</td>
										<td>262500</td>
										<td>0</td>
										</tr>

										


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
									<td width="20%">
										&nbsp;
									</td>
									<td width="31%" class="reportsublabel">
										&nbsp;
									</td>
									<td width="6%"></td>
									<td width="43%" class="reportsublabel">
										Net Amount:262500
										
									</td>
								</tr>

								
                                <tr>
								<td>
										&nbsp;
									</td>
									<td width="20%" colspan="3">
										Rupees (in words) Two Lakh Sixty Two thousand Five hundred only.
									</td>
									
								</tr>

								<tr>
									<td width="10%">
										&nbsp;
									</td>
									<td width="10%" class="reportsublabel">
										prepared By:
									</td>
									<td width="10%">Checked By</td>
									<td width="20%" class="reportsublabel">
										Approved By
										
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
									<td width="10%">
										&nbsp;
									</td>
									<td width="10%" class="reportsublabel">
										Vocher prep No:
									</td>
									<td width="10%">Received By</td>
									<td width="20%" class="reportsublabel">
										------------------------
										
									</td>
								</tr>
</table>

			</td></tr>	
		
										
										
										





										
								
								
								
							
								
							
						</td>
					</tr>
				
			</table>

		
	</body>
</html>
