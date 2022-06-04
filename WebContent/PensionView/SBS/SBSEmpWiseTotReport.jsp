
<%@ page import="aims.bean.EmployeePersonalInfo,java.util.ArrayList"%>
<%@ page import="java.text.DecimalFormat"%>

<%String path = request.getContextPath();
			String basePath = request.getScheme() + "://"
					+ request.getServerName() + ":" + request.getServerPort()
					+ path + "/";
					
					%>
					
					
												
								<%
			ArrayList dataList = new ArrayList();
			String reportType="",region="",fileName="",type="",airport="";
			
			
		
			
			if(request.getAttribute("penContrList")!=null){
				dataList=(ArrayList)request.getAttribute("penContrList");
			}
				if(request.getAttribute("airport")!=null){
				airport=request.getAttribute("airport").toString();
			}
			if("NO-SELECT".equals(airport)){
			airport="All_Airports";
			}
				if(request.getAttribute("region")!=null){
				region=request.getAttribute("region").toString();
			}
			if("NO-SELECT".equals(region)){
			region="All_Regions";
			}
		
			if(request.getAttribute("reportType")!=null){
				reportType=(String)request.getAttribute("reportType");
				if(region.equals("")){
				region="All_Regions";
				}
				if (reportType.equals("Excel Sheet")
						|| reportType.equals("ExcelSheet")) {
					
					fileName = "SBSEmpWiseTotReport.xls";
					response.setContentType("application/vnd.ms-excel");
					response.setHeader("Content-Disposition",
							"attachment; filename=" + fileName);
				}
			}
			System.out.println("ghjghjghjg"+dataList.size() );
				
			%>

<!DOCTYPE>
<html>

<HEAD>
<LINK rel="stylesheet" href="<%=basePath%>PensionView/css/aai.css" type="text/css">
<script type="text/javascript">
   
</script>
</HEAD>

	

<body>


<form action="method">
<table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
					<tr>
					<td colspan="2">
					<table width="100%">
					<tr>
					<td style="width:40%; text-align: right"><img src="<%=basePath%>PensionView/images/logoani.gif" ></td>
					<td style="width:60%; text-align: left;">
						<table border=0 cellpadding=3 cellspacing=0 width="100%">
							<tr>
								<td>
									
								</td>
								<td class="label" align="left" valign="top" nowrap="nowrap" style="font-family: serif; font-size: 21px; color:#33419a">
									 AIRPORTS AUTHORITY OF INDIA 
								</td>
								</tr>	
								<tr>
								<tr><td colspan="2" style=" font-size: 15px; color:#33419a"> <b>AAl Employees Defined Contribution Pension Trust</b></td></tr>
					
					
						</table>
					</td>
				</tr>
					</table>
					</td>
					</tr>	
				<tr></table>
			<table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
					<tr>
					<td colspan="2">
					
					</td>
					</tr>	
				<tr>
					<td >
					<div style="overflow:auto !important; width:100% !important">
					<table class="sample"   cellpadding="2" cellspacing="0" width="2205px" align="center" >
					<tr>
								<td colspan="13" style="font" class="ReportHeading" >SBS Employee Wise Total -  <%=region%> - <%=airport %></td>
								<td colspan="7" style="font" class="ReportHeading" ></td></tr>
								
							<tr>
								<th class="label" style="width:50px" >SNO</th>
								<th class="label" style="width:150px">Employee name  </th>
								<th class="label" style="width:120px">Designation  </th>
								<th class="label" style="width:110px">Old EMP NO</th>
								<th class="label" style="width:110px">SAP EMP NO</th>
								<th class="label" style="width:100px">PF ID</th>
								<th class="label" style="width:150px">Date of Birth  </th>
								<th class="label" style="width:150px">Date of Joining  </th>
								<th class="label" style="width:150px">Date of Separation Reason  </th>
								
								<th class="label" style="width:120px">Emoluments  </th>
								<th class="label" style="width:130px">AAI SBS Contribution  </th>
								
								<th class="label" style="width:200px">Notational Additional Increment Recovery  </th>
								<th class="label" style="width:180px">Adjustment SBS Contri </th>
								<th class="label" style="width:120px">Interest  </th>
							
								
								
								<th class="label" style="width:120px">Gross Contri</th>
								<th class="label" style="width:120px">Taxable Value of Perquisite Value after relief u/s 89 (with intt)</th>
								<th class="label" style="width:120px">Taxable Value of Perquisite Value after relief u/s 89 (without intt)</th>

						<th class="label" style="width:180px">Date of Separation Date</th>
								<th class="label" style="width:120px">Airport Code  </th>
								<th class="label" style="width:120px">Region  </th>
								
							
								</tr>
						
				<%
				double emolumentsTotal=0.0,adjSbsContriTotal=0.0,sbsContriTotal=0.0,sbsInterestTotal=0.0,sbsContriIntTotal=0.0,totCount=0.0,noIncrementTotal=0.0;
				double grossContriTotal=0.0,taxValWithIntt=0.0,taxValWithoutIntt=0.0;
				DecimalFormat df = new DecimalFormat("#########0");
				if (dataList.size() != 0) {
				int count = 0;
				
				EmployeePersonalInfo sbsPerBean=null;
				String styleClass="";
				
				
				for(int k=0;k<dataList.size();k++){
					count++;
					sbsPerBean = (EmployeePersonalInfo) dataList.get(k);
					
					
					emolumentsTotal=emolumentsTotal+Double.parseDouble(sbsPerBean.getEmoluments());
					//adjEmolumentsTotal=adjEmolumentsTotal+Double.parseDouble(sbsPerBean.getAdjEmoluments());
					adjSbsContriTotal=adjSbsContriTotal+Double.parseDouble(sbsPerBean.getAdjSbscontri());
					sbsContriTotal=sbsContriTotal+Double.parseDouble(sbsPerBean.getSbsContri());
					noIncrementTotal=noIncrementTotal+Double.parseDouble(sbsPerBean.getNoIncrement());
					sbsInterestTotal=sbsInterestTotal+Double.parseDouble(sbsPerBean.getInterest());
					grossContriTotal=grossContriTotal+Double.parseDouble(sbsPerBean.getGrossContri());
					taxValWithIntt=taxValWithIntt+Double.parseDouble(sbsPerBean.getTaxValwithIntt());
					taxValWithoutIntt=taxValWithoutIntt+Double.parseDouble(sbsPerBean.getTaxValwithoutIntt());
					//sbsContriIntTotal=sbsContriIntTotal+Double.parseDouble(sbsPerBean.getSbsTot());
					totCount=count;
				
					
					//lastActive=beans.getDateofJoining();
				%>
				
		
			
							<tr>
								
								<td ><%=count%></td>
								
								<td ><%=sbsPerBean.getEmployeeName()%></td>
								<td ><%=sbsPerBean.getDesignation() %></td>
								<td ><%=sbsPerBean.getEmployeeNumber() %></td>
								<td ><%=sbsPerBean.getNewEmployeeNumber() %></td>
								<td ><%=sbsPerBean.getPensionNo()%></td>
								<td   ><%=sbsPerBean.getDateOfBirth()%></td>
								<td ><%=sbsPerBean.getDateOfJoining()%></td>
								<td ><%=sbsPerBean.getSeperationReason()%></td>
								
								<td ><%=sbsPerBean.getEmoluments()%></td>
								<td ><%=sbsPerBean.getSbsContri()%></td>
								<td ><%=sbsPerBean.getNoIncrement()%></td>
								<td ><%=sbsPerBean.getAdjSbscontri()%></td>
								
								<td ><%=sbsPerBean.getInterest()%></td>
								<td ><%=sbsPerBean.getGrossContri()%></td>
								<td ><%=sbsPerBean.getTaxValwithIntt()%></td>
								<td ><%=sbsPerBean.getTaxValwithoutIntt() %></td>
								<td ><%=sbsPerBean.getSeperationDate()%></td>
								<td ><%=sbsPerBean.getAirportCode()%></td>
								<td ><%=sbsPerBean.getRegion()%></td>
								
								
							</tr>
							
							
					
						<%}}else{%>
						
						<tr>
						<td colspan="16" style="color:red" align="center" >No Records Found!</td>
						</tr>
						
						
						<%} %>
						<tr >
								
								<td colspan="8" style="font-weight:bold">No of Employees: <%=df.format(totCount)%></td>
								
							
								<td style="font-weight:bold">Total</td>
								<td style="font-weight:bold"><%=df.format(emolumentsTotal)%></td>
								<td style="font-weight:bold"><%=df.format(sbsContriTotal)%></td>
								<td style="font-weight:bold"><%=df.format(noIncrementTotal)%></td>
								<td style="font-weight:bold"><%=df.format(adjSbsContriTotal)%></td>
								
								<td style="font-weight:bold"><%=df.format(sbsInterestTotal)%></td>
								<td style="font-weight:bold"><%=df.format(grossContriTotal)%></td>
								<td style="font-weight:bold"><%=df.format(taxValWithIntt)%></td>
								<td style="font-weight:bold"><%=df.format(taxValWithoutIntt)%></td>
								<td colspan="4" style="font-weight:bold"></td>
								
								
							</tr>
						</table>
						
						
						
						
						
						
				
				
			
		</form>
</body>
</html>