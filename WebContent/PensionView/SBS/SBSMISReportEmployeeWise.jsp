
<%@ page import="aims.bean.MisdataBean,java.util.ArrayList"%>

<%String path = request.getContextPath();
			String basePath = request.getScheme() + "://"
					+ request.getServerName() + ":" + request.getServerPort()
					+ path + "/";
					
					%>
					
					
												
								<%
			ArrayList dataList = new ArrayList();
			String reportType="",region="",fileName="",type="",airport="";
			
			
				
			
			if(request.getAttribute("misList")!=null){
				dataList=(ArrayList)request.getAttribute("misList");
			}
		
			if(request.getAttribute("reportType")!=null){
				reportType=(String)request.getAttribute("reportType");
				if(region.equals("")){
				region="All_Regions";
				}
				if (reportType.equals("Excel Sheet")
						|| reportType.equals("ExcelSheet")) {
					
					fileName = "MISData.xls";
					response.setContentType("application/vnd.ms-excel");
					response.setHeader("Content-Disposition",
							"attachment; filename=" + fileName);
				}
			}
			System.out.println("ghjghjghjg"+dataList.size() );
				
			%>



<HEAD>
<LINK rel="stylesheet" href="<%=basePath%>PensionView/css/aai.css" type="text/css">
<script type="text/javascript">
   
</script>
</HEAD>

	


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
								<tr><td colspan="2" style=" font-size: 15px; color:#33419a"> <b>AAl Employees Defined Contribution Pension Trust</b></td></tr>
								
								
							
					
						</table>
					</td>
				</tr>
					</table>
					</td>
					</tr>
	
				
					
				
			
						
				<tr>
					<td>
					<table class="sample"   cellpadding="2" cellspacing="0" width="100%" align="center" >
					<tr>
								<td colspan="16" class="ReportHeading"> SBS MIS Report Employee Wise</td></tr>
							<tr>
								<th class="label" >Sl.No.</th>
								<th class="label" >Status </th>
								<th class="label" >App ID</th>
								<th class="label" >PF ID </th>
							<th class="label" >Employee Name</th>
								<th class="label" >Received On  </th>
								<th class="label" >Region </th>
								<th class="label" >Station  </th>
								
								<th class="label" >Forwarded By </th>
								<th class="label" >Present Level  </th>
								
								</tr>
						
				<%
				if (dataList.size() != 0) {
				
				int count = 0;
				
				MisdataBean pbean=null;
				String styleClass="";
				for(int k=0;k<dataList.size();k++){
				
				
					count++;
					pbean = (MisdataBean) dataList.get(k);
				
					//lastActive=beans.getDateofJoining();
				%>
				
		
			
							<tr>
								
								<td class="<%=styleClass%>" ><%=count%></td>
								<td class="<%=styleClass%>" ><%=pbean.getStatus() %></td>
								<td class="<%=styleClass%>" ><%=pbean.getAppId() %></td>
								<td class="<%=styleClass%>" ><%=pbean.getPensionno() %></td>
								<td class="<%=styleClass%>" ><%=pbean.getEmployeeName() %></td>
								<td class="<%=styleClass%>" ><%=pbean.getAppdate()%></td>
								<td class="<%=styleClass%>" ><%=pbean.getRegion() %></td>
								<td class="<%=styleClass%>" ><%=pbean.getAirport() %></td>
								<td class="<%=styleClass%>" ></td>
								<td class="<%=styleClass%>" ><%=pbean.getPresentLevel() %></td>
								
								
								
							</tr>
							
					
						<%}%>
						
						<%}else{%>
						
						<tr>
						<td colspan="16" style="color:red" align="center" >No Records Found!</td>
						</tr>
						</table>
						<%} %>
						</table>
						
						</td>
						</tr>
						<tr>
							<td>&nbsp;&nbsp;&nbsp;&nbsp;</td>
						</tr>
						
						
						
				
				
			</table>

</html>