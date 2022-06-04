<%@ page language="java" import="java.util.*,aims.bean.DatabaseBean,aims.common.CommonUtil,aims.common.Constants" contentType="text/html;charset=utf-8" pageEncoding="UTF-8"%>

<%@ page
	import="com.lowagie.text.pdf.*,com.lowagie.text.Phrase,com.lowagie.text.PageSize,com.lowagie.text.List,com.lowagie.text.ListItem,com.lowagie.text.Cell,com.lowagie.text.Table,com.lowagie.text.Section,com.lowagie.text.Font,com.lowagie.text.Chapter,com.lowagie.text.Paragraph,com.lowagie.text.Document,com.lowagie.text.FontFactory,java.io.*,com.lowagie.text.Image,java.awt.Color,com.lowagie.text.pdf.PdfPTable,com.lowagie.text.pdf.PdfPCell,com.lowagie.text.Element,com.lowagie.text.Rectangle,java.sql.ResultSet,com.lowagie.text.Chunk,com.lowagie.text.HeaderFooter"%>
<%@ page import="com.lowagie.text.pdf.TextField"%>
<%@ page import="com.lowagie.text.pdf.PdfName"%>
<%@ page import="aims.bean.EmployeeValidateInfo"%>
<%@ page import="aims.bean.EmployeePersonalInfo"%>
<%@ page import="aims.service.FinancialService"%>
<%@ page import="java.util.ArrayList" %>
<%@ page import="aims.bean.*"%>
<%@ page import="aims.dao.PensionDAO"%>
<jsp:useBean id="empBean" class="aims.bean.EmpMasterBean" scope="request">
	<jsp:setProperty name="empBean" property="*" />
</jsp:useBean>

<%String path = request.getContextPath();
			String basePath = request.getScheme() + "://"
					+ request.getServerName() + ":" + request.getServerPort()
					+ path + "/";
					
					%>
<%@ page import="javax.sound.sampled.DataLine"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"
"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
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
								
								<%
			ArrayList dataList = new ArrayList();
			String reportType="",region="",fileName="";
			
			if(request.getAttribute("reportList")!=null){
				dataList=(ArrayList)request.getAttribute("reportList");
			}
			if(request.getAttribute("region")!=null){
				region=(String)request.getAttribute("region");
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
			
				
			%>
								
								
							<tr>
								<td colspan="2" style="font-family: verdana; font-size:17px; color:#33419a;" >Employee Personnel Information  -  <%=region%> </td></tr>
					
						</table>
					</td>
				</tr>
					</table>
					</td>
					</tr>
	
				
					
				
			
					<tr>
							<td class="Data" style="font-family: verdana; font-size:12px; color:#FF0000;" >Note: PFID having incomplete data is  heighleted in Blue color</td>
						</tr>
						
				<tr>
					<td>
					<table class="sample"   cellpadding="2" cellspacing="0" width="100%" align="center" >
							<tr>
								<th class="label" >Serial<br> Number</th>
								<th class="label" >PF ID</th>
								<th class="label" >PF ID</th>
								<th class="label" >UAN</th>
								<th class="label">Old CPF ACC.No </th>
								<th class="label" >Employee<br> Number</th>
								<th class="label" >New Empcode</th>
								<th class="label">Employee Name</th>
								<th class="label" >Designation</th>
								<th class="label" nowrap="nowrap">Date Of Birth</th>
								<th class="label" nowrap="nowrap">Date Of Joining</th>
								<th class="label" >Father's /Husband's Name</th>
								<th class="label" >Pension Option  <br/></th>
								<th class="label" >Fresh Option  <br/></th>
								<th class="label" >SBS Option  <br/></th>
								<th class="label" >Status  <br/></th>
								<th class="label" >Gender</th>
								<th class="label" >Division</th>
								<th class="label" >AirportCode</th>
								<th class="label">Region </th>
							
								<th class="label" nowrap="nowrap">Remarks  </th>
								</tr>
						
				<%
				if (dataList.size() != 0) {
				int count = 0;
				
				EmployeePersonalInfo beans=null;
				String styleClass="";
				for(int k=0;k<dataList.size();k++){
					count++;
					beans = (EmployeePersonalInfo) dataList.get(k);
				
					if(beans.getDateOfBirth().equals("---")||beans.getEmployeeName().equals("---")||beans.getWetherOption().equals("---")||beans.getFhName().equals("---")){
						styleClass="HighlightData";
					}else{
						styleClass="Data";
					}
					//lastActive=beans.getDateofJoining();
				%>
				
		
			
							<tr>
								
								<td class="<%=styleClass%>" ><%=count%></td>
								<td class="<%=styleClass%>" ><%=beans.getPfID()%></td>
								<td class="<%=styleClass%>" ><%=beans.getPensionNo()%></td>
								<td class="<%=styleClass%>" ><%=beans.getUanno()%></td>
								<td class="<%=styleClass%>"><%=beans.getCpfAccno()%></td>
								<td class="<%=styleClass%>" ><%=beans.getEmployeeNumber()%></td>
								<td class="<%=styleClass%>" ><%=beans.getNewEmployeeNumber()%></td>
								<td class="<%=styleClass%>"  nowrap="nowrap"><%=beans.getEmployeeName()%></td>
								<td class="<%=styleClass%>" nowrap="nowrap"> <%=beans.getDesignation()%></td>
								<td class="<%=styleClass%>" nowrap="nowrap"><%=beans.getDateOfBirth()%></td>
								<td class="<%=styleClass%>" nowrap="nowrap"> <%=beans.getDateOfJoining()%></td>
								<td class="<%=styleClass%>" nowrap="nowrap"> <%=beans.getFhName()%></td>
								<td class="<%=styleClass%>" ><%=beans.getWetherOption()%></td>
								<td class="<%=styleClass%>" ><%=beans.getFreshPensionOption()%></td>
								<td class="<%=styleClass%>" > <%=beans.getSbsflag()%></td>
								<td class="<%=styleClass%>" > <%=beans.getStatus()%></td>
								<td class="<%=styleClass%>" > <%=beans.getGender()%></td>
								<td class="<%=styleClass%>" > <%=beans.getDivision()%></td>
								<td class="<%=styleClass%>"  nowrap="nowrap"><%=beans.getAirportCode()%></td>
								<td class="<%=styleClass%>" ><%=beans.getRegion()%></td>
								<td class="<%=styleClass%>" > <%=beans.getRemarks()%></td>
								
							</tr>
							
					
						<%}}%>
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