
<%@ page import="aims.bean.SBSEmWiseTotBean,java.util.ArrayList"%>
<%@ page import="java.text.DecimalFormat"%>

<%String path = request.getContextPath();

			String basePath = request.getScheme() + "://"
					+ request.getServerName() + ":" + request.getServerPort()
					+ path + "/";
					
					%>
					
					
												
								<%
								DecimalFormat df = new DecimalFormat("#########0");
			ArrayList dataList = new ArrayList();
			String reportType="",region="",fileName="",type="",airport="",finyear="",finyear1="";
			
			
				
			
			if(request.getAttribute("empList")!=null){
				dataList=(ArrayList)request.getAttribute("empList");
			}
			if(request.getAttribute("finyear")!=null){
				
				finyear=(String)request.getAttribute("finyear");
				System.out.println("finyear==="+finyear);
				finyear1=finyear.substring(0, 4);
			}
		
			if(request.getAttribute("reportType")!=null){
				reportType=(String)request.getAttribute("reportType");
				if(region.equals("")){
				region="All_Regions";
				}
				if (reportType.equals("Excel Sheet")
						|| reportType.equals("ExcelSheet")) {
					
					fileName = "SBSCardTotal.xls";
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
								<td colspan="16" class="ReportHeading">SBS Card Report Employee Wise Total For thr year <%=finyear%></td></tr>
							<tr>
								<th class="label" >Sl.No.</th>
								<th class="label" >Employee Name </th>
								<th class="label" >Designation </th>
								<th class="label" >SAP EMP NO </th>
								<th class="label" >PF ID</th>
								<th class="label" >Date of Birth  </th>
								<th class="label" >Date Of Joining </th>
								<th class="label" nowrap="nowrap">Date of Separation Reason  </th>
								<th class="label" >Date of Separation Date  </th>
								<th class="label" >Airport Code  </th>
								<th class="label" >Region  </th>
								<th class="label" >Opening Balance remitted(A)  </th>
								<th class="label" >Adj. in  OB(B)  </th>
								<%if(finyear.equals("2020-2021")){%>
								<th class="label" >Prov. Interest upto 31.03.2020 @7.4312%  </th>
								<%}%>
								<th class="label" >Apr-<%=finyear1%>  </th>
								<th class="label" >May-<%=finyear1%>  </th>
								<th class="label" >Jun-<%=finyear1%>  </th>
								<th class="label" >Jul-<%=finyear1%>  </th>
								<th class="label" >Aug-<%=finyear1%>  </th>
								<th class="label" >Sep-<%=finyear1%>  </th>
								<th class="label" >OCt-<%=finyear1%>  </th>
								<th class="label" >Nov-<%=finyear1%>  </th>
								<th class="label" >Dec-<%=finyear1%>  </th>
								<th class="label" >Jan-<%=finyear1%>  </th>
								<th class="label" >Feb-<%=finyear1%>  </th>
								<th class="label" >Mar-<%=finyear1%> </th>
								<th class="label" >Year Total  </th>
								<th class="label" >INTEREST @ 6.431% </th>
								<th class="label" >CLOSING BALANCE  </th>
								<th class="label" >Final Settlement  </th>
								<th class="label" >Balance carried forward to next year  </th>
								<th class="label" >Remarks  </th>		
								</tr>
						
				<%
				if (dataList.size() != 0) {
				int count = 0;
				double obGranTot=0.0,adjObGrandTot=0.0,provIntGrandTot=0.0,intGranTot=0.0,clBalGrandTot=0.0,fsCorpusTot=0.0;
				SBSEmWiseTotBean bean=null;
				double openingbal=0.0;
				String styleClass="";
				for(int k=0;k<dataList.size();k++){
					count++;
					bean = (SBSEmWiseTotBean) dataList.get(k);
				
				adjObGrandTot=adjObGrandTot+Double.parseDouble(bean.getAdjOb());
				provIntGrandTot=provIntGrandTot+Double.parseDouble(bean.getProvInt());	
				//if(bean.getFinYear().equals("2020-2021")){
				openingbal=Double.parseDouble(bean.getOb());
				//}else{
				//openingbal=Double.parseDouble(bean.getOb())+Double.parseDouble(bean.getProvInt());
                //openingbal=Math.round(openingbal+openingbal*(6.431/100));
				//}
				obGranTot=obGranTot+openingbal;
				intGranTot=intGranTot+Double.parseDouble(bean.getCummilativeInt());
				clBalGrandTot=clBalGrandTot+Double.parseDouble(bean.getClosingBal());
				fsCorpusTot=fsCorpusTot+Double.parseDouble(bean.getFsCorpusAmt());
					//lastActive=beans.getDateofJoining();
				%>
				
		
			
							<tr>
								
								<td class="<%=styleClass%>" ><%=count%></td>
								<td class="<%=styleClass%>" ><%=bean.getEmpName() %></td>
								<td class="<%=styleClass%>" ><%=bean.getDesignation()%></td>
								<td class="<%=styleClass%>" ><%=bean.getSapEmpNo()%></td>
								<td class="<%=styleClass%>" ><%=bean.getPfId() %></td>
								<td class="<%=styleClass%>" ><%=bean.getDob() %></td>
								<td class="<%=styleClass%>" ><%=bean.getDoj() %></td>
								<td class="<%=styleClass%>" ><%=bean.getDosReason() %></td>
								<td class="<%=styleClass%>" ><%=bean.getDosDate() %></td>
								<td class="<%=styleClass%>" ><%=bean.getAirport() %></td>
								<td class="<%=styleClass%>" ><%=bean.getRegion() %></td>
								<td class="<%=styleClass%>" ><%=openingbal%></td>
								<td class="<%=styleClass%>" ><%=bean.getAdjOb() %></td>
								<%if(bean.getFinYear().equals("2020-2021")){%>
								<td class="<%=styleClass%>" ><%=bean.getProvInt() %></td>
								<%}%>
								<td class="<%=styleClass%>" ></td>
								<td class="<%=styleClass%>" ></td>
								<td class="<%=styleClass%>" ></td>
								<td class="<%=styleClass%>" ></td>
								<td class="<%=styleClass%>" ></td>
								<td class="<%=styleClass%>" ></td>
								<td class="<%=styleClass%>" ></td>
								<td class="<%=styleClass%>" ></td>
								<td class="<%=styleClass%>" ></td>
								<td class="<%=styleClass%>" ></td>
								<td class="<%=styleClass%>" ></td>
								<td class="<%=styleClass%>" ></td>
								<td class="<%=styleClass%>" ></td>
								<td class="<%=styleClass%>" ><%=bean.getCummilativeInt() %></td>
								<td class="<%=styleClass%>" ><%=bean.getClosingBal() %></td>
								<td class="<%=styleClass%>" ><%=bean.getFsCorpusAmt() %></td>
								<td class="<%=styleClass%>" ><%=Double.parseDouble(bean.getClosingBal())-Double.parseDouble(bean.getFsCorpusAmt()) %></td>
								<td class="<%=styleClass%>" ></td>
							</tr>
							
					
						<%}%>
						<tr>
							<td class="<%=styleClass%>" colspan="11">Grand Total</td>
							<td class="<%=styleClass%>" ><%=df.format(obGranTot) %></td>
							<td class="<%=styleClass%>" ><%=df.format(adjObGrandTot) %></td>
							<%if(finyear.equals("2020-2021")){%>
							<td class="<%=styleClass%>" ><%=df.format(provIntGrandTot) %></td>
							<%}%>
							<td class="<%=styleClass%>" ></td>
							<td class="<%=styleClass%>" ></td>
							<td class="<%=styleClass%>" ></td>
							<td class="<%=styleClass%>" ></td>
							<td class="<%=styleClass%>" ></td>
							<td class="<%=styleClass%>" ></td>
							<td class="<%=styleClass%>" ></td>
							<td class="<%=styleClass%>" ></td>
							<td class="<%=styleClass%>" ></td>
							<td class="<%=styleClass%>" ></td>
							<td class="<%=styleClass%>" ></td>
							<td class="<%=styleClass%>" ></td>
							<td class="<%=styleClass%>" ></td>
							<td class="<%=styleClass%>" ><%=df.format(intGranTot) %></td>
							<td class="<%=styleClass%>" ><%=df.format(clBalGrandTot) %></td>
							<td class="<%=styleClass%>" ><%=df.format(fsCorpusTot) %></td>
							<td class="<%=styleClass%>" ><%=df.format(clBalGrandTot-fsCorpusTot) %></td>
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
</html>