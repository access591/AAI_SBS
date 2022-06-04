
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
								<td colspan="16" class="ReportHeading"> SBS MIS Report</td></tr>
							<tr>
								<th class="label" >Sl.No.</th>
								<th class="label" >Region </th>
								<th class="label" >Total
								Separated Employees (A)</th>
								<th class="label" >Less Final Settlement done(B) </th>
							<th class="label" >Balance Pending settlement cases(c)</th>
								<th class="label" >Cases with NIL activity (D)  </th>
								<th class="label" >Cases HR Assisting Officer(E) </th>
								<th class="label" >Cases with HR Verification Officer(F)  </th>
								
								<th class="label" >Cases with Finance Nodal Officer(G) </th>
								<th class="label" >Cases with Regional Sub-Committee-HR (H)  </th>
								<th class="label" >Cases with Regional Sub-Committee Finance (I)  </th>
								<th class="label" >Cases CHQ SS Section (J)  </th>	
								<th class="label" >Cases with EDCP Trust(K)  </th>	
								
								<th class="label" >Cases CHQ Sub-Committee- Finance (L)  </th>	
								<th class="label" >Cases CHQ Sub-Committee- HR (M)   </th>	
								<th class="label" >Check(C=D+E+F+G+H+I+J+K+L+M)   </th>
								</tr>
						
				<%
				if (dataList.size() != 0) {
				int empTot=0,lessFsDoneTot=0,pendingSettlementTot=0,nilActivityTot=0,hrAssistantTot=0,hrVerTot=0,FinTot=0,regSubHRTot=0,regSubFinTot=0;
				int ssTot=0,edcp1Tot=0,edcp2Tot=0,edcp3Tot=0;
				int count = 0;
				
				MisdataBean pbean=null;
				String styleClass="";
				for(int k=0;k<dataList.size();k++){
				int pending=0,nilAct=0;
				
					count++;
					pbean = (MisdataBean) dataList.get(k);
				empTot=empTot+Integer.parseInt(pbean.getEmpCount());
				lessFsDoneTot=lessFsDoneTot+Integer.parseInt(pbean.getLessfsdone());
				pendingSettlementTot=pendingSettlementTot+Integer.parseInt(pbean.getEmpCount())-Integer.parseInt(pbean.getLessfsdone());
				nilActivityTot=nilActivityTot+(Integer.parseInt(pbean.getEmpCount())-Integer.parseInt(pbean.getHrasscount())-Integer.parseInt(pbean.getLessfsdone())-(Integer.parseInt(pbean.getHrcount())+
								Integer.parseInt(pbean.getFincount())+Integer.parseInt(pbean.getRhqhrcnt())+Integer.parseInt(pbean.getRhqfincnt())+Integer.parseInt(pbean.getChqhrcnt())+Integer.parseInt(pbean.getEdcp1count())+Integer.parseInt(pbean.getEdcp2cnt())+Integer.parseInt(pbean.getEdcp3cnt())));
				hrAssistantTot=hrAssistantTot+Integer.parseInt(pbean.getHrasscount());
				hrVerTot=hrVerTot+Integer.parseInt(pbean.getHrcount());
				FinTot=FinTot+Integer.parseInt(pbean.getFincount());
				regSubHRTot=regSubHRTot+Integer.parseInt(pbean.getRhqhrcnt());
				regSubFinTot=regSubFinTot+Integer.parseInt(pbean.getRhqfincnt());
				ssTot=ssTot+Integer.parseInt(pbean.getChqhrcnt());
				edcp1Tot=edcp1Tot+Integer.parseInt(pbean.getEdcp1count());
				edcp2Tot=edcp2Tot+Integer.parseInt(pbean.getEdcp2cnt());
				edcp3Tot=edcp3Tot+Integer.parseInt(pbean.getEdcp3cnt());
					//lastActive=beans.getDateofJoining();
				%>
				
		
			
							<tr>
								
								<td class="<%=styleClass%>" ><%=count%></td>
								<td class="<%=styleClass%>" ><%=pbean.getRegion() %></td>
								<td class="<%=styleClass%>" ><%=pbean.getEmpCount() %></td>
								<td class="<%=styleClass%>" ><%=pbean.getLessfsdone() %></td>
								<td class="<%=styleClass%>" ><%=Integer.parseInt(pbean.getEmpCount())-Integer.parseInt(pbean.getLessfsdone()) %></td>
								<td class="<%=styleClass%>" ><%=Integer.parseInt(pbean.getEmpCount())-Integer.parseInt(pbean.getHrasscount())-Integer.parseInt(pbean.getLessfsdone())-(Integer.parseInt(pbean.getHrcount())+
								Integer.parseInt(pbean.getFincount())+Integer.parseInt(pbean.getRhqhrcnt())+Integer.parseInt(pbean.getRhqfincnt())+Integer.parseInt(pbean.getChqhrcnt())+Integer.parseInt(pbean.getEdcp1count())+Integer.parseInt(pbean.getEdcp2cnt())+Integer.parseInt(pbean.getEdcp3cnt())) %></td>
								<td class="<%=styleClass%>" ><%=pbean.getHrasscount()%></td>
								<td class="<%=styleClass%>" ><%=pbean.getHrcount() %></td>
								<td class="<%=styleClass%>" ><%=pbean.getFincount() %></td>
								<td class="<%=styleClass%>" ><%=pbean.getRhqhrcnt() %></td>
								<td class="<%=styleClass%>" ><%=pbean.getRhqfincnt() %></td>
								
								
								<td class="<%=styleClass%>" ><%=pbean.getChqhrcnt() %></td>
								<td class="<%=styleClass%>" ><%=pbean.getEdcp1count() %></td>
								<td class="<%=styleClass%>" ><%=pbean.getEdcp2cnt() %></td>
								<td class="<%=styleClass%>" ><%=pbean.getEdcp3cnt() %></td>
								<td class="<%=styleClass%>" ><%=Integer.parseInt(pbean.getEmpCount())-Integer.parseInt(pbean.getLessfsdone()) %>=<%=Integer.parseInt(pbean.getEmpCount())-Integer.parseInt(pbean.getHrasscount())-Integer.parseInt(pbean.getLessfsdone())-(Integer.parseInt(pbean.getHrcount())+
								Integer.parseInt(pbean.getFincount())+Integer.parseInt(pbean.getRhqhrcnt())+Integer.parseInt(pbean.getRhqfincnt())+Integer.parseInt(pbean.getChqhrcnt())+Integer.parseInt(pbean.getEdcp1count())+Integer.parseInt(pbean.getEdcp2cnt())+Integer.parseInt(pbean.getEdcp3cnt()))+(Integer.parseInt(pbean.getHrasscount())+Integer.parseInt(pbean.getHrcount())+
								Integer.parseInt(pbean.getFincount())+Integer.parseInt(pbean.getRhqhrcnt())+Integer.parseInt(pbean.getRhqfincnt())+Integer.parseInt(pbean.getChqhrcnt())+Integer.parseInt(pbean.getEdcp1count())+Integer.parseInt(pbean.getEdcp2cnt())+Integer.parseInt(pbean.getEdcp3cnt())) %></td>
							</tr>
							
					
						<%}%>
						<tr>
						<td class="<%=styleClass%>" colspan="2">Total</td>
						<td class="<%=styleClass%>"  ><%=empTot %></td>
						<td class="<%=styleClass%>"  ><%=lessFsDoneTot %></td>
						<td class="<%=styleClass%>"  ><%=pendingSettlementTot %></td>
						<td class="<%=styleClass%>"  ><%=nilActivityTot %></td>
						<td class="<%=styleClass%>"  ><%=hrAssistantTot %></td>
						<td class="<%=styleClass%>"  ><%=hrVerTot %></td>
						<td class="<%=styleClass%>"  ><%=FinTot %></td>
						<td class="<%=styleClass%>"  ><%=regSubHRTot %></td>
						<td class="<%=styleClass%>"  ><%=regSubFinTot %></td>
						<td class="<%=styleClass%>"  ><%=ssTot %></td>
						<td class="<%=styleClass%>"  ><%=edcp1Tot %></td>
						<td class="<%=styleClass%>"  ><%=edcp2Tot %></td>
						<td class="<%=styleClass%>"  ><%=edcp3Tot %></td>
<td class="<%=styleClass%>"  ><%=edcp3Tot %></td>
						</tr>
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