
<%@ page import="aims.bean.LicBean,java.util.ArrayList,java.text.DecimalFormat,aims.common.CommonUtil"%>

<%String path = request.getContextPath();
			String basePath = request.getScheme() + "://"
					+ request.getServerName() + ":" + request.getServerPort()
					+ path + "/";
					
					%>
					
					
												
								<%
								CommonUtil commonUtil=new CommonUtil();
			ArrayList dataList = new ArrayList();
			String reportType="",region="",fileName="",type="",airport="";
			
			DecimalFormat df = new DecimalFormat("#########0");
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
								<tr><td colspan="2" style=" font-size: 15px; color:#33419a"> <b>AAl Employees Defined Contribution Pension Trust</b></td>
								<td align="right" nowrap="nowrap" class="Data">Dt:<%=commonUtil.getCurrentDate("dd-MM-yyyy HH:mm:ss")%></td>
								</tr>
								
								
							
					
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
								<td colspan="20" class="ReportHeading">SBS Final Settlement Information  -  <%=region%>  <%=airport %></td></tr>
							<tr>
								<th class="label" >AAI EDCP Annuity Series No.</th>
								<th class="label" >ERP-SAP Employee Code</th>
								
							<th class="label" >PF ID</th>
								<th class="label" >Employee name  </th>
								<th class="label" >Annuity Service Provider </th>
								<th class="label" nowrap="nowrap">Region  </th>
								<th class="label" nowrap="nowrap">Station  </th>
								<th class="label" >Final Settlement Amount  </th>
								<th class="label" >Final Settlemnt Date DD-MM-YYYY  </th>
								<th class="label" >Final Settlemnt Month  </th>
								<th class="label" >Final Settlemnt Year  </th>
								<th class="label" >Final Settlemnt FinYear  </th>
									<th class="label" >Frequency of Annuity Payout </th>
									<th class="label" >Annuity Option </th>
									<th class="label" >Annuity Purchase Value</th>
									<th class="label" >GST@1.8%</th>
									<th class="label" >Total Debit Value</th>
									<th class="label" >Policy NO</th>
									<th class="label" >Policy Start Date</th>
									<th class="label" >Annuity Pension Amount</th>
								</tr>
						
				<%
				if (dataList.size() != 0) {
				int count = 0;
				double fsAmtTot=0.0,purchaseAmtTot=0.0,gstTot=0.0;
				LicBean fsbean=null;
				String styleClass="";
				for(int k=0;k<dataList.size();k++){
					count++;
					fsbean = (LicBean) dataList.get(k);
				fsAmtTot=fsAmtTot+Double.parseDouble(fsbean.getEdcpCorpusAmt());
				purchaseAmtTot=purchaseAmtTot+Double.parseDouble(fsbean.getEdcpCorpusAmt())-Double.parseDouble(fsbean.getEdcpCorpusint());
				gstTot=gstTot+Double.parseDouble(fsbean.getEdcpCorpusint());	
					//lastActive=beans.getDateofJoining();
				%>
				
		
			
							<tr>
								
								<td class="<%=styleClass%>" ><%=count%></td>
								<td class="<%=styleClass%>" ><%=fsbean.getNewEmpCode() %></td>
								<td class="<%=styleClass%>" ><%=fsbean.getEmployeeNo() %></td>
								<td class="<%=styleClass%>" ><%=fsbean.getMemberName()%></td>
								<td class="<%=styleClass%>" ><%=fsbean.getFormType()%></td>
								<td class="<%=styleClass%>" ><%=fsbean.getRegion()%></td>
								<td class="<%=styleClass%>" ><%=fsbean.getAirport()%></td>
								<td class="<%=styleClass%>" ><%=fsbean.getEdcpCorpusAmt()%></td>
								<td class="<%=styleClass%>" ><%=fsbean.getEdcpApproveDate()%></td>
								<td class="<%=styleClass%>" ><%=fsbean.getMonth()%></td>
								<td class="<%=styleClass%>" ><%=fsbean.getYear()%></td>
								<td class="<%=styleClass%>" ><%=fsbean.getFinYear()%></td>
								<td class="<%=styleClass%>" ><%=fsbean.getPaymentMode()%></td>
								<td class="<%=styleClass%>" ><%=fsbean.getAaiEDCPSoptionDesc()%></td>
							<%if(fsbean.getFormType().equals("RCForm")){%>
								<td class="<%=styleClass%>" ><%=fsbean.getEdcpCorpusAmt() %></td>
								<td class="<%=styleClass%>" >&nbsp;</td>
								<td class="<%=styleClass%>" ><%=fsbean.getEdcpCorpusAmt()%></td>
								<%}else{%>
								<td class="<%=styleClass%>" ><%=Integer.parseInt(fsbean.getEdcpCorpusAmt())-Integer.parseInt(fsbean.getEdcpCorpusint()) %></td>
								<td class="<%=styleClass%>" ><%=fsbean.getEdcpCorpusint()%></td>
								<td class="<%=styleClass%>" ><%=fsbean.getEdcpCorpusAmt()%></td>
								<%}%>
								<td class="<%=styleClass%>" ><%=fsbean.getPolicyNo() %></td>
								<td class="<%=styleClass%>" ><%=fsbean.getPolicyStartDate() %></td>
								<td class="<%=styleClass%>" ><%=fsbean.getPolicyPensionAmt() %></td>
							</tr>
							
					
						<%}%>
						<tr>
						<td class="<%=styleClass%>"colspan="7" >Total</td>
						<td class="<%=styleClass%>" ><%=df.format(fsAmtTot) %></td>
						<td class="<%=styleClass%>" ></td>
						<td class="<%=styleClass%>" ></td>
						<td class="<%=styleClass%>" ></td>
						<td class="<%=styleClass%>" ></td>
						<td class="<%=styleClass%>" ></td>
						<td class="<%=styleClass%>" ></td>
						<td class="<%=styleClass%>" ><%=df.format(purchaseAmtTot) %></td>
						<td class="<%=styleClass%>" ><%=df.format(gstTot) %></td>
						<td class="<%=styleClass%>" ><%=df.format(fsAmtTot) %></td>
						<td class="<%=styleClass%>" ></td>
						<td class="<%=styleClass%>" ></td>
						</tr>
						<% }else{%>
						
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
		</form>
</body>
</html>