
<%@ page import="aims.bean.PolicyDocumentBean,java.util.ArrayList,aims.common.CommonUtil"%>

<%String path = request.getContextPath();
			String basePath = request.getScheme() + "://"
					+ request.getServerName() + ":" + request.getServerPort()
					+ path + "/";
					
					%>
					
					
												
								<%
								CommonUtil commonUtil=new CommonUtil();
			ArrayList dataList = new ArrayList();
			String reportType="",region="",fileName="",type="",airport="";
			
			
				
			
			if(request.getAttribute("policylist")!=null){
				dataList=(ArrayList)request.getAttribute("policylist");
			}
		
			if(request.getAttribute("reportType")!=null){
				reportType=(String)request.getAttribute("reportType");
				if(region.equals("")){
				region="All_Regions";
				}
				if (reportType.equals("Excel Sheet")
						|| reportType.equals("ExcelSheet")) {
					
					fileName = "PolicyDocument.xls";
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
								<td colspan="19" class="ReportHeading">Policy Document Report</td></tr>
							<tr>
								<th class="label" >Sl.No.</th>
								<th class="label" >Policy Number </th>
								<th class="label" >Annuity Start Date </th>
								<th class="label" >Annuity Purchase Amount </th>
							<th class="label" >GST 1.8% </th>
								<th class="label" >Total Annuity Purchase Amount   </th>
								<th class="label" >Annuity Pension Amount </th>
								<th class="label" >Annuity  Provider </th>
								<th class="label" nowrap="nowrap">PF ID  </th>
								<th class="label" >gl code (based on Annuity Service provider)</th>
								<th class="label" >DEBIT LIC/SBI/HDFC/BAJAJ ANNUITY Final Settlement AMOUNT (A)  </th>
								<th class="label" >gl code2</th>
								<th class="label" >CREDIT LIC/SBI/HDFC/BAJAJ ANNUITY PURCHASE AMOUNT (A)  </th>
								<th class="label" >Region </th>
								<th class="label" > Airport</th>
								<th class="label" >Name of Employee </th>
								<th class="label" >ERP-SAP Code </th>
							
									
								</tr>
						
				<%
				if (dataList.size() != 0) {
				int count = 0;
				
				PolicyDocumentBean pbean=null;
				String styleClass="";
				for(int k=0;k<dataList.size();k++){
					count++;
					pbean = (PolicyDocumentBean) dataList.get(k);
				
					
					//lastActive=beans.getDateofJoining();
				%>
				
		
			
							<tr>
								
								<td class="<%=styleClass%>" ><%=count%></td>
								<td class="<%=styleClass%>" ><%=pbean.getPolicynumber() %></td>
								<td class="<%=styleClass%>" ><%=pbean.getPolicydate() %></td>
								<td class="<%=styleClass%>" ><%=Integer.parseInt(pbean.getPurchaseamt())-Integer.parseInt(pbean.getGst()) %></td>
								<td class="<%=styleClass%>" ><%=pbean.getGst() %></td>
								<td class="<%=styleClass%>" ><%=pbean.getPurchaseamt() %></td>
								<td class="<%=styleClass%>" ><%=pbean.getPolicyAmount() %></td>
								<td class="<%=styleClass%>" ><%=pbean.getAnnuityProvider() %></td>
								<td class="<%=styleClass%>" ><%=pbean.getPensionno() %></td>
								
								<td class="<%=styleClass%>" ><%="DEBIT "+pbean.getAnnuityProvider()+" ANNUITY Final Settlement Gl"%></td>
								<td class="<%=styleClass%>" ><%=pbean.getDebit() %></td>
								<td class="<%=styleClass%>" ><%="Credit  "+pbean.getAnnuityProvider()+" ANNUITY Purchase GL" %></td>
								<td class="<%=styleClass%>" ><%=pbean.getCredit() %></td>
								<td class="<%=styleClass%>" ><%=pbean.getRegion() %></td>
								<td class="<%=styleClass%>" ><%=pbean.getAirport() %></td>
								<td class="<%=styleClass%>" ><%=pbean.getEmployeeName() %></td>
								<td class="<%=styleClass%>" ><%=pbean.getNewEmpCode() %></td>
								
							</tr>
							
					
						<%}}else{%>
						
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