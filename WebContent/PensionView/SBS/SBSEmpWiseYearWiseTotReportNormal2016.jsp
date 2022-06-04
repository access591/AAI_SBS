
<%@ page import="aims.bean.EMPWiseYearWiseBean,java.util.ArrayList"%>
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
								<td colspan="19" style="font" class="ReportHeading" >SBS Employee Wise Year wise Total -  <%=region%> - <%=airport %></td>
								<td colspan="1" style="font" class="ReportHeading" ></td></tr>
								
							<tr>
								<th class="label" style="width:50px" >SNO</th>
								<th class="label" style="width:150px">EMP_CODE_SAP  </th>
								<th class="label" style="width:120px">PF ID  </th>
								<th class="label" style="width:110px">Employee Name</th>
								<th class="label" style="width:110px">Airport</th>
								<th class="label" style="width:100px">Region</th>
								<th class="label" style="width:150px">FY 2006-2007  </th>
								<th class="label" style="width:150px">FY 2007-2008 </th>
								<th class="label" style="width:150px">FY 2008-2009  </th>
								<th class="label" style="width:150px">FY 2009-2010  </th>
								<th class="label" style="width:150px">FY 2010-2011  </th>
								<th class="label" style="width:150px">FY 2011-2012  </th>
								<th class="label" style="width:150px">FY 2012-2013  </th>
								<th class="label" style="width:150px">FY 2013-2014  </th>
								<th class="label" style="width:150px">FY 2014-2015  </th>
								<th class="label" style="width:150px">FY 2015-2016  </th>
								<th class="label" style="width:150px">April 2016 to Dec2016  </th>
							<th class="label" style="width:150px">Total AAI EDCP Contribution  </th>
							<th class="label" style="width:150px">OB Adjustment  </th>
							<th class="label" style="width:150px">Grand Total   </th>
								</tr>
						
				<%
				double fy2006_07=0.0,fy2007_08=0.0,fy2008_09=0.0,fy2009_10=0.0,fy2010_11=0.0,fy2011_12=0.0,
				fy2012_13=0.0,fy2013_14=0.0,fy2014_15=0.0,fy2015_16=0.0,fy2016_17=0.0,TotalGrand=0.0,totCount=0.0;
			double adjob=0.0,GrandTotalTot=0.0;
			DecimalFormat df = new DecimalFormat("#########0");
				if (dataList.size() != 0) {
				int count = 0;
				
				EMPWiseYearWiseBean bean=null;
				String styleClass="";
				double adjSbscontri2016=0.0,adjSbscontri2020=0.0;
				
				
				
				for(int k=0;k<dataList.size();k++){
				double	grandTotal=0.0;
					count++;
					bean = (EMPWiseYearWiseBean) dataList.get(k);
					fy2006_07=fy2006_07+Double.parseDouble(bean.getFy2006_07());
					fy2007_08=fy2007_08+Double.parseDouble(bean.getFy2007_08());
					fy2008_09=fy2008_09+Double.parseDouble(bean.getFy2008_09());
					fy2009_10=fy2009_10+Double.parseDouble(bean.getFy2009_10());
					fy2010_11=fy2010_11+Double.parseDouble(bean.getFy2010_11());
					fy2011_12=fy2011_12+Double.parseDouble(bean.getFy2011_12());
					fy2012_13=fy2012_13+Double.parseDouble(bean.getFy2012_13());
					fy2013_14=fy2013_14+Double.parseDouble(bean.getFy2013_14());
					
					fy2014_15=fy2014_15+Double.parseDouble(bean.getFy2014_15());
					fy2015_16=fy2015_16+Double.parseDouble(bean.getFy2015_16());
					fy2016_17=fy2016_17+Double.parseDouble(bean.getFy2016_17());
					
					TotalGrand=TotalGrand+bean.getGrandTotal();
					adjob=adjob+Double.parseDouble(bean.getAdjob());
					grandTotal=bean.getGrandTotal()+Double.parseDouble(bean.getAdjob());
					GrandTotalTot=GrandTotalTot+grandTotal;
					totCount=count;
				%>
				
		
			
							<tr>
								
								<td ><%=count%></td>
								<td ><%=bean.getSapCode()%></td>
								<td ><%=bean.getPfid()%></td>
								<td ><%=bean.getEmpName()%></td>
								<td ><%=bean.getStation()%></td>
								<td ><%=bean.getRegion()%></td>
								<td ><%=bean.getFy2006_07()%></td>
								<td ><%=bean.getFy2007_08()%></td>
								<td ><%=bean.getFy2008_09()%></td>
								<td ><%=bean.getFy2009_10()%></td>
								<td ><%=bean.getFy2010_11()%></td>
								<td ><%=bean.getFy2011_12()%></td>
								<td ><%=bean.getFy2012_13()%></td>
								<td ><%=bean.getFy2013_14()%></td>
								<td ><%=bean.getFy2014_15()%></td>
								<td ><%=bean.getFy2015_16()%></td>
								<td ><%=bean.getFy2016_17()%></td>
								<td ><%=df.format(bean.getGrandTotal())%></td>
								<td ><%=bean.getAdjob()%></td>
								<td><%=df.format(grandTotal) %></td>
							</tr>
							
							
					
						<%}}else{%>
						
						<tr>
						<td colspan="16" style="color:red" align="center" >No Records Found!</td>
						</tr>
						
						
						<%} %>
						<tr >
								
								<td colspan="5" style="font-weight:bold">No of Employees: <%=df.format(totCount)%></td>
								
							
								<td style="font-weight:bold">Total</td>
								
								<td style="font-weight:bold"><%=df.format(fy2006_07)%></td>
								<td style="font-weight:bold"><%=df.format(fy2007_08)%></td>
								
								<td style="font-weight:bold"><%=df.format(fy2008_09)%></td>
								
								<td style="font-weight:bold"><%=df.format(fy2009_10)%></td>
								
								<td style="font-weight:bold"><%=df.format(fy2010_11)%></td>
								
								<td style="font-weight:bold"><%=df.format(fy2011_12)%></td>
								<td style="font-weight:bold"><%=df.format(fy2012_13)%></td>
								<td style="font-weight:bold"><%=df.format(fy2013_14)%></td>
								<td style="font-weight:bold"><%=df.format(fy2014_15)%></td>
								<td style="font-weight:bold"><%=df.format(fy2015_16)%></td>
								<td style="font-weight:bold"><%=df.format(fy2016_17)%></td>
								<td style="font-weight:bold"><%=df.format(TotalGrand)%></td>
								<td style="font-weight:bold"><%=df.format(adjob)%></td>
								<td style="font-weight:bold"><%=df.format(GrandTotalTot)%></td>
								
								
							</tr>
						</table>
						
						
						
						
						
						
				
				
			
		</form>
</body>
</html>