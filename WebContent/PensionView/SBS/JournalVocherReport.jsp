
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
					
					fileName = "Journal Voucher_"+region+".xls";
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
								<tr><td colspan="2" style=" font-size: 15px; color:#33419a"> <b>AAI EDCP TRUST</b></td>
								<td align="right" nowrap="nowrap" class="Data">Dt:<%=commonUtil.getCurrentDate("dd-MM-yyyy HH:mm:ss")%></td>
								</tr>
								<tr><td colspan="2" style=" font-size: 15px; color:#33419a"> <b>CHQ</b></td></tr>
								
								
							
					
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
								<td colspan="20" class="ReportHeading">Journal Voucher Report </td></tr>
							<tr>
								<th class="label" >JV ID</th>
								<th class="label" >JV Number</th>
								<th class="label" >PF ID</th>
								<th class="label" >Employee name  </th>
								<th class="label" >Appid </th>
								<th class="label" nowrap="nowrap">Region  </th>
								<th class="label" nowrap="nowrap">Station  </th>
								<th class="label" >Form Type </th>
								<th class="label" >Financial Year  </th>
                                <th class="label" >Debit Amount  </th>
								<th class="label" >Credit Amount  </th>
								<th class="label" >JVPREParation DATE  </th>
								<th class="label" >Prepared By </th>
							 </tr>
						
				<%
				System.out.println("datalist==="+dataList.size() );
				if (dataList.size() != 0) {
				int count = 0;
				LicBean fsbean=null;
				for(int k=0;k<dataList.size();k++){
					count++;
                    System.out.println("k=="+k);
					fsbean = (LicBean) dataList.get(k);
				System.out.println("fsbean.getJvNumber()=="+fsbean.getJvNumber());
				System.out.println("fsbean.getEmpsapCode()=="+fsbean.getEmpsapCode());
				System.out.println("fsbean.getMemberName()=="+fsbean.getMemberName());
				System.out.println("fsbean.getAppId()=="+fsbean.getAppId());
				System.out.println("fsbean.getRegion()=="+fsbean.getRegion());
				System.out.println("fsbean.getAirport()=="+fsbean.getAirport());
				System.out.println("fsbean.getFormType()=="+fsbean.getFormType());
				System.out.println("fsbean.getFinYear()=="+fsbean.getFinYear());
				
                System.out.println("fsbean.getDebitAmount()=="+fsbean.getDebitAmount());
				System.out.println("fsbean.getCreditAmount()=="+fsbean.getCreditAmount());
				System.out.println("fsbean.getJvPrepDate()=="+fsbean.getJvPrepDate());
				System.out.println("fsbean.getJvEnterdBy()=="+fsbean.getJvEnterdBy());
				
				%>
				
		
			
							<tr>
								
								<td ><%=count%></td>
								<td ><%=fsbean.getJvNumber() %></td>
								<td  ><%=fsbean.getEmpsapCode() %></td>
								<td><%=fsbean.getMemberName()%></td>
								<td  ><%=fsbean.getAppId()%></td>
								<td><%=fsbean.getRegion()%></td>
								<td ><%=fsbean.getAirport()%></td>
								<td  ><%=fsbean.getFormType()%></td>
								<td  ><%=fsbean.getFinYear()%></td>
								
								<td ><%=fsbean.getDebitAmount()%></td>
								<td ><%=fsbean.getCreditAmount()%></td>
								<td  ><%=fsbean.getJvPrepDate()%></td>
								<td  ><%=fsbean.getJvEnterdBy()%></td>
								
							</tr>
							
					
						<%}%>
						
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