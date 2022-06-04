
<%@ page import="aims.bean.EmployeePersonalInfo,java.util.ArrayList"%>

<%String path = request.getContextPath();
			String basePath = request.getScheme() + "://"
					+ request.getServerName() + ":" + request.getServerPort()
					+ path + "/";
					
					%>
					
					
												
								<%
			ArrayList dataList = new ArrayList();
			String reportType="",region="",fileName="",type="",airport="";
			
			
				if(request.getAttribute("airport")!=null){
				airport="- "+request.getAttribute("airport").toString();
			}
				if(request.getAttribute("region")!=null){
				region=request.getAttribute("region").toString();
			}
				if(request.getAttribute("SBSOption")!=null){
				type=request.getAttribute("SBSOption").toString();
			}
			if(type.equals("Y")){
			type="Eligible";
			}else if(type.equals("N")){
			type="In Eligible";
			}else{
			type="Eligible/In Eligible";
			}
			
			if(request.getAttribute("sbsList")!=null){
				dataList=(ArrayList)request.getAttribute("sbsList");
			}
		
			if(request.getAttribute("reportType")!=null){
				reportType=(String)request.getAttribute("reportType");
				if(region.equals("")){
				region="All_Regions";
				}
				if (reportType.equals("Excel Sheet")
						|| reportType.equals("ExcelSheet")) {
					
					fileName = "Employee_Personal_report_"+region+".xls";
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
								<td colspan="6" class="ReportHeading">SBS <%=type%> Information  -  <%=region%>  <%=airport %></td></tr>
							<tr>
								<th class="label" >SNO</th>
								<th class="label" >PF ID</th>
								
							
								<th class="label" nowrap="nowrap">Employee name  </th>
								<th class="label" nowrap="nowrap">Date of Birth  </th>
								<th class="label" nowrap="nowrap">Date of Joining  </th>
									<th class="label" nowrap="nowrap">Sbs Option  </th>
								</tr>
						
				<%
				if (dataList.size() != 0) {
				int count = 0;
				
				EmployeePersonalInfo sbsPerBean=null;
				String styleClass="";
				for(int k=0;k<dataList.size();k++){
					count++;
					sbsPerBean = (EmployeePersonalInfo) dataList.get(k);
				
					
					//lastActive=beans.getDateofJoining();
				%>
				
		
			
							<tr>
								
								<td class="<%=styleClass%>" ><%=count%></td>
								<td class="<%=styleClass%>" ><%=sbsPerBean.getPensionNo() %></td>
								<td class="<%=styleClass%>" ><%=sbsPerBean.getEmployeeName()%></td>
								<td class="<%=styleClass%>" ><%=sbsPerBean.getDateOfBirth()%></td>
								<td class="<%=styleClass%>" ><%=sbsPerBean.getDateOfJoining()%></td>
								<td class="<%=styleClass%>" ><%=sbsPerBean.getSbsflag()%></td>
								
							</tr>
							
					
						<%}}else{%>
						
						<tr>
						<td colspan="6" style="color:red" align="center" >No Records Found!</td>
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
		</form>
</body>
</html>