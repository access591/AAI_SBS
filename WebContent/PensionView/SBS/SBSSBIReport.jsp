
<%@ page language="java" import="java.util.*"%>
<%@ page import="aims.bean.LicBean,aims.bean.SBSNomineeBean"%>

<%String path = request.getContextPath();
			String basePath = request.getScheme() + "://"
					+ request.getServerName() + ":" + request.getServerPort()
					+ path + "/";
					
					%>
					
					
												
								<%
			ArrayList dataList = new ArrayList();
			String reportType="",region="",fileName="",type="",airport="",formtype="";

			if(request.getAttribute("approvedList")!=null){
				dataList=(ArrayList)request.getAttribute("approvedList");
			}
			if(request.getAttribute("formtype")!=null){
				formType=request.getAttribute("formtype");
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
								<td colspan="16" class="ReportHeading"> <%=formType> Annuity Approved Report</td></tr>
							<tr>
								 <th class="label" >Sr No</th>
                                 <th class="label" >DATE</th>
                                 <th class="label" >MPH name/Plant name</th>
                                 <th class="label" >Emp. Id.</th>
                                 <th class="label" >PF I'D</th>
                                 <th class="label" >Member Name</th>
                                 <th class="label" >Gender</th>
                                 <th class="label" >Member's Date of Birth (dd/mm/yyyy)</th>
                                 <th class="label" >Date of Joining AAI</th>
                                 <th class="label" >Date of VRS/Retirement</th>
                                 <th class="label" >Spouse Name</th>
                                 <th class="label" >"Spouse's Date of Birth (dd/mm/yyyy)"</th>
                                 <th class="label" >Type of Annuity</th>
                                 <th class="label" >Annuity Option Name</th>
                                 <th class="label" >"Joint Annuity  %"</th>
                                 <th class="label" >Annuity Payout Frequency</th>
                                 <th class="label" >"Contribution  for Annuity (Corpus / Purchase Price)"</th>
                                 <th class="label" >Member's Bank Name</th>
                                 <th class="label" >Member's  Bank Branch Name</th>
                                 <th class="label" >Member's  Bank Account Number</th>
                                 <th class="label" >Member's  Bank IFSC Code</th>
                                 <th class="label" >Member's  PAN No.</th>
                                 <th class="label" >Member's Address1</th>
                                 <th class="label" >Member's Address2</th>
                                 <th class="label" >Member's Address3</th>
                                 <th class="label" >Member's City</th>
                                 <th class="label" >Member's State</th>
                                 <th class="label" >Member's Pin Code</th>
                                 <th class="label" >Nationality</th>
                                 <th class="label" >Tax Residence of any country other than India (Y/N)</th>
                                 <th class="label" >Member's Mobile No.</th>
                                 <th class="label" >Member's e-mail ID</th>
                                 <th class="label" >Nominee 1 Name</th>
                                 <th class="label" >Nominee 1 Date of Birth</th>
                                 <th class="label" >Nominee 1 Gender</th>
                                 <th class="label" >Nominee 1 Relationship with Annuitant</th>
                                 <th class="label" >Nominee 1 Distribution Percentage</th>
                               <!-- <th class="label" >If nominee minor then Appointee Name require</th>
                                 <th class="label" >Appointee DOB</th>
                                 <th class="label" >Relationship with Nominee</th>-->
                                 <th class="label" >Nominee 2 Name</th>
                                 <th class="label" >Nominee 2 Date of Birth</th>
                                 <th class="label" >Nominee 2 Gender</th>
                                 <th class="label" >Nominee 2 Relationship with Annuitant</th>
                                 <th class="label" >Nominee 2 Distribution Percentage</th>
                                  <!--<th class="label" >If nominee minor then Appointee Name require</th>
                                 <th class="label" >Appointee DOB</th>
                                 <th class="label" >Relationship with Nominee</th>-->
                                 <th class="label" >Nominee 3 Name</th>
                                 <th class="label" >Nominee 3 Date of Birth</th>
                                 <th class="label" >Nominee 3 Gender</th>
                                 <th class="label" >Nominee 3 Relationship with Annuitant</th>
                                 <th class="label" >Nominee 3 Distribution Percentage</th>
                                  <!--<th class="label" >If nominee minor then Appointee Name require</th>
                                 <th class="label" >Appointee DOB</th>
                                 <th class="label" >Relationship with Nominee</th>-->
                                 <th class="label" >Nominee 4 Name</th>
                                 <th class="label" >Nominee 4 Date of Birth</th>
                                 <th class="label" >Nominee 4 Gender</th>
                                 <th class="label" >Nominee 4 Relationship with Annuitant</th>
                                 <th class="label" >Nominee 4 Distribution Percentage</th>
                                  <!--<th class="label" >If nominee minor then Appointee Name require</th>
                                 <th class="label" >Appointee DOB</th>
                                 <th class="label" >Relationship with Nominee</th> -->
                                 
                             </tr>
						
				<%
				if (dataList.size() != 0) {
				
				
				LicBean pbean = null;
				String styleClass="";
				int count=0;
				for(int k=0;k<dataList.size();k++){
				int pending=0,nilAct=0;
				
					count++;
					pbean = (LicBean) dataList.get(k);
				long annuityPurAmt=Math.round(Double.parseDouble(pbean.getEdcpCorpusAmt())+Double.parseDouble(pbean.getEdcpCorpusint()));
 long GSTAmt=Math.round((Double.parseDouble(pbean.getEdcpCorpusAmt())+Double.parseDouble(pbean.getEdcpCorpusint()))/1.018*(1.8/100));
				%>
							<tr>
								
								<td class="<%=styleClass%>" ><%=count%></td>
								<td class="<%=styleClass%>" ><%=pbean.getEdcpApproveDate() %></td>
								<td class="<%=styleClass%>" >AAI</td>
								<td class="<%=styleClass%>" ><%=pbean.getNewEmpCode() %></td>
								<td class="<%=styleClass%>" ><%=pbean.getEmployeeNo() %></td>
								<td class="<%=styleClass%>" ><%=pbean.getMemberName() %></td>
								<td class="<%=styleClass%>" ><%=pbean.getGender()%></td>
								<td class="<%=styleClass%>" ><%=pbean.getDob() %></td>
								<td class="<%=styleClass%>" ><%=pbean.getDoj() %></td>
								<td class="<%=styleClass%>" ><%=pbean.getDateOfexit() %></td>
								<td class="<%=styleClass%>" ><%=pbean.getSpouseName() %></td>
								<td class="<%=styleClass%>" ><%=pbean.getSpouseDob() %></td>
								<td class="<%=styleClass%>" ><%=pbean.getAaiEDCPSoption() %></td>
								<td class="<%=styleClass%>" ><%=pbean.getAaiEDCPSoptionDesc()%></td>
								<td class="<%=styleClass%>" >&nbsp;</td>
								<td class="<%=styleClass%>" ><%=pbean.getPaymentMode()%></td>
								<td class="<%=styleClass%>" ><%=annuityPurAmt %></td>
								<td class="<%=styleClass%>" ><%=pbean.getBankName()%></td>
								<td class="<%=styleClass%>" ><%=pbean.getBranch()%></td>
								<td class="<%=styleClass%>" ><%=pbean.getAccNo()%></td>
                                <td class="<%=styleClass%>" ><%=pbean.getIfscCode()%></td>
								<td class="<%=styleClass%>" ><%=pbean.getPanNo()%></td>
								<td class="<%=styleClass%>" ><%=pbean.getMemberPerAdd()%></td>
								<td class="<%=styleClass%>" ><%=pbean.getMemberAddress()%></td>
								<td class="<%=styleClass%>" >&nbsp;</td>
								<td class="<%=styleClass%>" ><%=pbean.getCtv()%></td>
								<td class="<%=styleClass%>" ><%=pbean.getState() %></td>
                                <td class="<%=styleClass%>" ><%=pbean.getPinCode()%></td>
								<td class="<%=styleClass%>" ><%=pbean.getNationality() %></td>
								<td class="<%=styleClass%>" >N</td>
                                <td class="<%=styleClass%>" ><%=pbean.getMobilNo()%></td>
								<td class="<%=styleClass%>" ><%=pbean.getEmail() %></td>
								
								
								<%  ArrayList list= (ArrayList)pbean.getNomineeList();
		                        	SBSNomineeBean nomineeBean=null;
									for(int i=0;i<list.size();i++){
			                        nomineeBean=(SBSNomineeBean)list.get(i);%>
			                       
                                 <td class="<%=styleClass%>" ><%=nomineeBean.getNomineename()%></td>
								 <td class="<%=styleClass%>" ><%=nomineeBean.getNomineeDOB()%></td>
								 <td class="<%=styleClass%>" ><%=nomineeBean.getGender()%></td>
								 <td class="<%=styleClass%>" ><%=nomineeBean.getNomineeRelation()%></td>
								 <td class="<%=styleClass%>" ><%=nomineeBean.getPercentage()%></td>
                                 <%}%>
								
                                

								  <%  ArrayList appointeeList= (ArrayList)pbean.getNomineeAppointeeList();
			SBSNomineeBean appointeeBean=null;
			for(int i=0;i<appointeeList.size();i++){
			appointeeBean=(SBSNomineeBean)appointeeList.get(i);%>
			
			
			<!-- <td><%=appointeeBean.getNomineename() %></td><td><%=appointeeBean.getAppointeeName() %></td><td><%=appointeeBean.getNomineeDOB() %></td><td><%=appointeeBean.getNomineeRelation() %></td><td><%=appointeeBean.getAppointeeMobile()%></td><td><%=appointeeBean.getAppointeeAddress() %></td>-->
			
			
			
			<% }
			
			
			 %>
			                 
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