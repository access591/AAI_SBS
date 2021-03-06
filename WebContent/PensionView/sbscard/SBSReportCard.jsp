<%@ page language="java" import="java.util.*,aims.bean.PensionContBean,aims.bean.EmployeePensionCardInfo,aims.bean.TempPensionTransBean" pageEncoding="ISO-8859-1"%>
<%@page import="aims.bean.EmployeeCardReportInfo"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
String reportType ="";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>SBS Report Card</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">

<LINK rel="stylesheet" href="<%=basePath%>PensionView/css/aai.css" type="text/css">
	

  </head>
  <%@ page import="java.text.DecimalFormat"%>
  
  <% 
  ArrayList empList=new ArrayList();
  PensionContBean empBean=null;
  
  DecimalFormat df = new DecimalFormat("#########0");
  empList=request.getAttribute("empList")!=null?(ArrayList)request.getAttribute("empList"):null; 
  String finyear=request.getAttribute("finyear")!=null?request.getAttribute("finyear").toString():null;
  
  ArrayList pensionList=new ArrayList();
  ArrayList obList=new ArrayList();
  ArrayList adjobList=new ArrayList();
  %>
  
  
  <body background="">
   <%
    double sbsContriGrandTot=0.0,sbsNotationalGrandTot=0.0,sbsadjAAIEDCPGrandTot=0.0,sbsadjAAIEDCPGrossTot=0.0;
	String pensionno="";
   for(int i=0;i<empList.size();i++){
   empBean=(PensionContBean)empList.get(i);
   pensionList=empBean.getEmpPensionList();
   
   obList=empBean.getObList();
   if(empBean.getAdjOBList()!=null){
   System.out.println("getAdjOBList::::"+empBean.getAdjOBList().size());
   adjobList=empBean.getAdjOBList();
   System.out.println("adjobList::::"+adjobList);
    }
   if (request.getAttribute("reportType") != null) {
				reportType = (String) request.getAttribute("reportType");
				System.out.println("reportType::::"+reportType);
				if (reportType.equals("Excel Sheet")
						|| reportType.equals("ExcelSheet")) {
				String	fileName = "AAIEDCP Corpus Report.xls";
					response.setContentType("application/vnd.ms-excel");
					response.setHeader("Content-Disposition",
							"attachment; filename=" + fileName);
				}
			}
    %>
   <table width="100%" border="0" 	background="<img src='<%=basePath%>PensionView/images/logoani.gif' >" align="center" cellpadding="0" cellspacing="0">
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
               String heading="AAl Employees Defined Contribution Pension Trust";
                %>
								<tr>
								<td colspan="2" style="font-family: verdana; font-size:17px; color:#33419a;" ><%=heading%> </td></tr>
						
						</table>
					</td>
				</tr>
					</table>
					</td>
					</tr>			
           
					
							
							<%
               String headingsub="Provisional EDCP Annual Contribution Receipt Card For The FY "+finyear;
             // System.out.println("headingsub==="+headingsub);
			   pensionno=empBean.getPfID();
						//	System.out.println("pfid==="+empBean.getPfID());
						//	System.out.println("empname==="+empBean.getEmployeeNM());
						//	System.out.println("designation==="+empBean.getDesignation());
						//	System.out.println("Gender==="+empBean.getGender());
						//	System.out.println("Father==="+empBean.getFhName());
						//	System.out.println("Date of Birth==="+empBean.getEmpDOB());
						//	System.out.println("SAP Employee Code==="+empBean.getNewEmpCode());
                         //   System.out.println("Date of Joining AAI==="+empBean.getEmpDOJ());
						//	System.out.println("Date of Commencement of membership of EDCP==="+empBean.getDateOfEntitle());
						//	System.out.println("Notional Increment Recovery==="+empBean.getSbsNTIncrement());
                        //    System.out.println("AAI EDCP Contribution Rate==="+empBean.getContriPer());
						//	System.out.println("Date of separation ==="+empBean.getDateofSeperationDt());
						//	System.out.println("Reason for separation ==="+empBean.getSeparationReason());
                %>
							<tr>
						<td>
								<table border="0"    cellpadding="2" cellspacing="0" width="100%" align="center">
								<tr>
								<td align="center" class="ReportHeading" colspan="2"> <%=headingsub%>  </td>	
								</tr>
								</table>
								</td>
							</tr>
							
							
							
				<tr >
					<td>
						<table class="sample"   cellpadding="2" cellspacing="0" width="100%" align="center">
							<tr >
							<td class="reportsublabel">PF ID</td>
								<td class="reportdata"><%=empBean.getPfID() %></td>	
										
									<td class="reportsublabel">NAME</td>
									<td class="reportdata"><%=empBean.getEmployeeNM()%></td>		
												
							</tr>
							<tr >
							<td class="reportsublabel">Designation</td>
								<td class="reportdata"><%=empBean.getDesignation() %></td>	
											
									<td class="reportsublabel">Gender</td>
									<td class="reportdata"><%=empBean.getGender()%></td>		
												
							</tr>
							<tr >
							<td class="reportsublabel">Father's/Husband's Name</td>
								<td class="reportdata"><%=empBean.getFhName() %></td>	
											
									<td class="reportsublabel">Date of Birth</td>
									<td class="reportdata"><%=empBean.getEmpDOB()%></td>		
												
							</tr>
							<tr >
							<td class="reportsublabel">SAP Employee Code</td>
								<td class="reportdata"><%=empBean.getNewEmpCode() %></td>	
									
									<td class="reportsublabel">Annuity Account Number</td>
									<td class="reportdata"></td>		
												
							</tr>
							<tr >
							<td class="reportsublabel">Date of Joining AAI</td>
								<td class="reportdata"><%=empBean.getEmpDOJ() %></td>	
											
									<td class="reportsublabel">Date of Commencement of membership of EDCP</td>
									<td class="reportdata"><%=empBean.getDateOfEntitle()%></td>		
												
							</tr>
							
							<tr >
							<td class="reportsublabel">Notional Increment Recovery</td>
								<td class="reportdata"><%=empBean.getSbsNTIncrement() %></td>	
											
									<td class="reportsublabel">AAI EDCP Contribution Rate (%)</td>
									<td class="reportdata"><%=empBean.getContriPer()%></td>		
												
							</tr>
							<tr >
							<td class="reportsublabel">Date of separation </td>
								<td class="reportdata"><%=empBean.getDateofSeperationDt() %></td>	
											
									<td class="reportsublabel">Reason for separation </td>
									<td class="reportdata"><%=empBean.getSeparationReason()%></td>		
												
							</tr>
							</table>
					</td>
				</tr>
				<% 
				} %>
				
				<tr>
					<td  colspan="5" >
					
						<table  class="sample"    cellpadding="2" cellspacing="0" width="100%" align="center" >
							
							<tr>
								<th class="label" width="10%" align="center">Month</th>
								
								
								<th class="label" width="10%" align="center">Emoluments</th>
								
								
								<th class="label" width="10%" align="center">AAI EDCPS Contribution @ 10% (D=C*10%) </th>
						
								
							
								<th class="label" width="10%" align="center">Recovery of Contribution on Notional Additional Increment (E=C*1%) wherever applicable</th>
								<th class="label" width="10%" align="center">Adjusted AAI EDCPS Contribution (F=D-E)</th>
								
								<th class="label" width="10%" align="center">Employee Voluntary EDCPS Subscription (G)</th>
								<th class="label" width="8%" align="center">Gross Contribution (H=F+G)</th>
								
								<th class="label" width="12%" align="center" nowrap>Station</th>
								<th class="label" width="10%" align="center">Deputation (Y/N)</th>
								<th class="label" width="10%" align="center">Remarks</th>
								<th class="label" width="10%" align="center">Cost Centre</th>
								<th class="label" width="10%" align="center">Voucher No.</th>
								
								
							
							</tr>
							<% 
							System.out.println("obBean===");
						String obSbsContri="0",obNotational="0",obAdjSBSContri="0";
						TempPensionTransBean obBean=null;
							obBean=(TempPensionTransBean)obList.get(0);
							obSbsContri=obBean.getPensionContr();
							obNotational=obBean.getNoIncrement();
							obAdjSBSContri=obBean.getAdjSbsContri();
							System.out.println("obBean==="+obBean);
							System.out.println("obSbsContri==="+obSbsContri);
							System.out.println("obNotational==="+obNotational);
							System.out.println("obAdjSBSContri==="+obAdjSBSContri);
							 %>
							 
							
							<tr>
							 <% if(finyear.equals("2020-2021")) {%>
						 <td colspan="2" ><b> Corpus remitted(A)(Jan 2007 to Dec 2016)</b></td>
						 <%}else{ %>
						 <td colspan="2" ><b> OB -1.4.2021</b></td>
						 <%} %>
						 <% if(finyear.equals("2020-2021")) {%>
						 <td><b><%=obSbsContri %></b></td>
						 <%}else{ %>
						<td><b> </b></td>
						 <%} %>
						 <td><b><%=obNotational %></b></td>
						 
						  <% if(finyear.equals("2020-2021")) {%>
						<td><b><%=obAdjSBSContri %> </b></td>
						 <%}else{ %>
						<td><b> </b></td>
						 <%} %>
						  <td></td>
						 <td><b><%=obAdjSBSContri %></b></td>
						  <td></td>
						  <td></td>
						 <td><%=obBean.getRemarks() %></td>
						 <td></td>
						 <td></td>
							
						</tr>
						<% 
						String adjobSbsContri="0",adjobNotational="0",adjobAdjSBSContri="0",adjobVpf="0";
						 String intMonth="";
						TempPensionTransBean adjobBean=null;
							adjobBean=new TempPensionTransBean();
							
							adjobBean=(TempPensionTransBean)adjobList.get(0);
							adjobSbsContri=adjobBean.getPensionContr();
							adjobNotational=adjobBean.getNoIncrement();
							adjobAdjSBSContri=adjobBean.getAdjSbsContri();
							adjobVpf=adjobBean.getEmpVPF();

							
							
							 %>
							<tr>
							 <% if(finyear.equals("2020-2021")) {%>
						 <td colspan="2" ><b>Adj. in (B) above</b></td>
						 <%}else{ %>
                         <td colspan="2" ><b>OB.Adj (B) </b></td>						
						 <%} %>
						  <td><%=adjobSbsContri %></td>
						  <td><%=adjobNotational %></td>
						 <td><%=(Double.parseDouble(adjobSbsContri)-Double.parseDouble(adjobNotational)) %></td>
						 <td><%=adjobVpf %></td>
						<td><%=(Double.parseDouble(adjobSbsContri)+Double.parseDouble(adjobVpf)-Double.parseDouble(adjobNotational)) %></td>
						 <td></td>
						  <td></td>
						 <td><%=adjobBean.getRemarks() %></td>
						 <td></td>
						 <td></td>
							
						</tr>
						 <% if(finyear.equals("2020-2021")) {%>
						<tr>
						 <td colspan="2" ><b>Prov. Interest  @7.431% (C=((A+B)*7.431%))</b></td>
						  <td></td>
						  <td></td>
						  <% System.out.println("obAdjSBSContri:"+obAdjSBSContri+"adjobNotational"+adjobNotational+"adjobSbsContri"+adjobSbsContri); %>
						 <td><%=Math.round((Double.parseDouble(obAdjSBSContri)-Double.parseDouble(adjobNotational)+Double.parseDouble(adjobSbsContri)+Double.parseDouble(adjobVpf))*(0.07431)) %></td>
						 <td></td>
						 <!--<td><%=Math.round((Double.parseDouble(obAdjSBSContri)-Double.parseDouble(adjobNotational)+Double.parseDouble(adjobSbsContri)+Double.parseDouble(adjobSbsContri))*(0.07431)) %></td>-->
						 <td><%=Math.round((Double.parseDouble(obAdjSBSContri)-Double.parseDouble(adjobNotational)+Double.parseDouble(adjobSbsContri)+Double.parseDouble(adjobVpf))*(0.07431)) %></td>
						 <td></td>
						  <td></td>
						 <td></td>
						 <td></td>
						 <td></td>
							
						</tr>	
						<%}else{ %>	
						
						<%} %>
						<%
						System.out.println("reportType1122::::"+reportType);
						int emolumentsTotal=0,aaiedcpTotal=0,notationalTotal=0,adjAAIEDCPTotal=0;
						double cumilativeTotal=0.0,grosscontributon=0.0;
						if(pensionList.size()>0){
						for(int k=0;k<pensionList.size();k++){
						EmployeePensionCardInfo cardInfo =(EmployeePensionCardInfo)pensionList.get(k);
						
						emolumentsTotal=emolumentsTotal+Integer.parseInt(cardInfo.getEmoluments());
						aaiedcpTotal=aaiedcpTotal+Integer.parseInt(cardInfo.getAaiedcpContri());
						notationalTotal=notationalTotal+Integer.parseInt(cardInfo.getNotationaIncrement());
						adjAAIEDCPTotal=adjAAIEDCPTotal+Integer.parseInt(cardInfo.getAaiedcpContri())-Integer.parseInt(cardInfo.getNotationaIncrement());
						cumilativeTotal=cumilativeTotal+Double.parseDouble(cardInfo.getGrandCummulative());
						grosscontributon=grosscontributon+(Double.parseDouble(cardInfo.getAaiedcpContri())-Double.parseDouble(cardInfo.getNotationaIncrement()));
						 %>
						 <tr>
						 <td><%=cardInfo.getMonthyear()%></td>
						 
						 <td><%=cardInfo.getEmoluments()%></td>
						 <td><%=cardInfo.getAaiedcpContri()%></td>
						 <td><%=cardInfo.getNotationaIncrement()%></td>
						 <td><%=Double.parseDouble(cardInfo.getAaiedcpContri())-Double.parseDouble(cardInfo.getNotationaIncrement())%></td>
						 <td></td>
						 <td><%=Double.parseDouble(cardInfo.getAaiedcpContri())-Double.parseDouble(cardInfo.getNotationaIncrement())%></td>
						 <td><%=cardInfo.getStation()%></td>
						  <td><%=cardInfo.getDeputation()%></td>
						 <td></td>
						 <td></td>
						 <td></td>
						
						 </tr>
						 <%}%>
						 
						 
						 
					<tr>
						 <td><b>Year Total</b></td>
						 
						 <td><%=emolumentsTotal %></td>
						 <td><%=aaiedcpTotal %></td>
						 <td><%=notationalTotal %></td>
						 <td><%=adjAAIEDCPTotal %></td>
						 <td></td>
						 <td><%=adjAAIEDCPTotal %></td>
						 <td></td>
						  <td></td>
						 <td></td>
						 <td></td>
						 <td></td>
						
						 </tr>	 
						 	 <%
						 sbsContriGrandTot=sbsContriGrandTot+(aaiedcpTotal+Double.parseDouble(obSbsContri)+Double.parseDouble(adjobSbsContri));
						  sbsadjAAIEDCPGrandTot=sbsadjAAIEDCPGrandTot+(adjAAIEDCPTotal+Double.parseDouble(obAdjSBSContri)-Double.parseDouble(adjobNotational)+Double.parseDouble(adjobSbsContri));
						  sbsadjAAIEDCPGrossTot=sbsadjAAIEDCPGrossTot+(adjAAIEDCPTotal+Double.parseDouble(obAdjSBSContri)-Double.parseDouble(adjobNotational)+Double.parseDouble(adjobSbsContri)+Double.parseDouble(adjobVpf));
						   sbsNotationalGrandTot=sbsNotationalGrandTot+(notationalTotal+Double.parseDouble(obNotational)+Double.parseDouble(adjobNotational));
						   
						 
						 
						 
						  %>
						 <%  double obInt=0.0,obintInt=0.0,cumilativeint=0.0;double OBInt=0.0;
						 if(finyear.equals("2020-2021")){
						  OBInt=Math.round((Double.parseDouble(obAdjSBSContri)-Double.parseDouble(adjobNotational)+Double.parseDouble(adjobSbsContri)+Double.parseDouble(adjobVpf))*(0.07431));
						 }else{
						}
						System.out.print("OBInt:::::KKKKKKK"+((Double.parseDouble(obAdjSBSContri)-Double.parseDouble(adjobNotational)+Double.parseDouble(adjobSbsContri)+Double.parseDouble(adjobVpf)))+"LLLLLLL");
						 //Double.parseDouble(obAdjSBSContri)*(0.07431);
						 double rateOfInt=0.00;
						 if(finyear.equals("2022-2023")){
						  rateOfInt=7.00;
						 }else{
						 rateOfInt=6.431;
						 }
						 int intMonths;
						 System.out.println("empBean.getNoOfMonths()==="+empBean.getNoOfMonths());
						if(empBean.getNoOfMonths()<12){
						 intMonths=empBean.getNoOfMonths()-1; 
						 }else{
						 intMonths=empBean.getNoOfMonths();
						 }
						if(intMonths==10){
						 intMonth="January";
						 }else if(intMonths==11){
						 intMonth="February";
						 }else if(intMonths==12){
						 intMonth="March";
						 }else if(intMonths==1){
						 intMonth="April";
						 }else if(intMonths==2){
						 intMonth="May";
						 }else if(intMonths==3){
						 intMonth="June";
						 }else if(intMonths==4){
						 intMonth="July";
						 }else if(intMonths==5){
						 intMonth="August";
						 }else if(intMonths==6){
						 intMonth="September";
						 }else if(intMonths==7){
						 intMonth="October";
						 }else if(intMonths==8){
						 intMonth="November";
						 }else if(intMonths==9){
						 intMonth="December";
						 }else if(intMonths==0){
						 intMonth="March-21";
					}
						 obInt=(Double.parseDouble(obAdjSBSContri)-Double.parseDouble(adjobNotational)+Double.parseDouble(adjobSbsContri)+Double.parseDouble(adjobVpf))*rateOfInt/100*intMonths/12;
						
						/*
						* Added if condition on 03 May 2021 by  Kranthi
						*/
						if(!finyear.equals("2021-2022")){
						 obintInt=(Double.parseDouble(obAdjSBSContri)-Double.parseDouble(adjobNotational)+Double.parseDouble(adjobSbsContri)+Double.parseDouble(adjobVpf))*(0.07431)*rateOfInt/100*intMonths/12;
						}
						System.out.println("cumilativeTotal===="+cumilativeTotal+"rateOfInt===="+rateOfInt+"intMonths==="+intMonths);
                         if(pensionno.equals("3185") || pensionno.equals("14982") || pensionno.equals("8277")){
                           intMonths=6;
						 }
						 if(pensionno.equals("61") || pensionno.equals("553")){
                           intMonths=3;
						 }
						 if(pensionno.equals("14067") ){
                           intMonths=8;
						 }
						 if(pensionno.equals("26619") ){
                           intMonths=4;
						 }
						 if(pensionno.equals("9491") || pensionno.equals("6232") ){
                           intMonths=2;
						 }
							
                           cumilativeint=grosscontributon*rateOfInt/100*intMonths/12;
                        // cumilativeint=cumilativeTotal*rateOfInt/100*intMonths/12;
						 
						 
						 System.out.println("obInt:"+obInt+"obintInt"+obintInt+"cumilativeint:"+cumilativeint);
						  %>
						<tr>
						 <td><b>INTEREST @ <%=rateOfInt %>%</b></td>
						 <%if(intMonths==0){ %>
						 <td><b>Interest updated up to <%=intMonth %></b> </td>
						 <%}else {%>
						 <td><b>Interest up to <%=intMonth %></b> </td>
						 <%} %>
						 <td></td>
						 <td></td>
						 <td><%=df.format(obInt+obintInt+cumilativeint) %></td>
						 <td></td>
						 <td><%=df.format(obInt+obintInt+cumilativeint) %></td>
						 <td></td>
						  <td></td>
						 <td></td>
						 <td></td>
						 <td></td>
						
						 </tr>	
						 <tr>
					
						 <td colspan="2"><b>CLOSING BALANCE</b></td>
						
						 <td><b><%=sbsContriGrandTot %></b></td>
						 <td><b><%=sbsNotationalGrandTot %></b></td>
						  <% if(finyear.equals("2020-2021")){%>
						  
						 <td><b><%=df.format(sbsadjAAIEDCPGrandTot+OBInt+obInt+obintInt+cumilativeint) %></b></td>
						 <%}else{ %>
						  <td><b>0</b></td>
						 <%} %>
						 <td></td>
						 <td><b><%=df.format(sbsadjAAIEDCPGrossTot+OBInt+obInt+obintInt+cumilativeint)  %></b></td>
						  <td></td>
						 <td></td>
						 <td></td>
						 <td></td>
						<td></td>
						 </tr>
						 <% if(empBean.getSactionflag().equals("A")){ %>
						 <tr>
					
						 <td colspan="2"><b>Less Final settlement (interest upto <%=empBean.getInterestCalUpto() %>)</b></td>
						
						 <td><b></b></td>
						 <td><b></b></td>
						 <td><b>-<%=empBean.getPfSettled() %></b></td>
						 <td></td>
						 <td><b>-<%=empBean.getPfSettled() %></b></td>
						  <td>Sanction Order details-</td>
						 <td></td>
						 <td></td>
						 <td></td>
						<td></td>
						 </tr>
						 
						 
						 <tr>
					
						 <td colspan="2"><b>Balance carried forward to next year</b></td>
						
						 <td></td>
						 <td><b><%=sbsNotationalGrandTot %></b></td>
						 <td><b><%=Math.round((sbsadjAAIEDCPGrandTot+OBInt+obInt+obintInt+cumilativeint)-(Double.parseDouble(empBean.getPfSettled()) )) %></b></td>
						 <td></td>
						 <td><b><%=Math.round((sbsadjAAIEDCPGrossTot+OBInt+obInt+obintInt+cumilativeint)-(Double.parseDouble(empBean.getPfSettled()) )) %></b></td>
						  <td></td>
						 <td></td>
						 <td></td>
						 <td></td>
						<td></td>
						 </tr>
						 <%} %>	
						 <tr>
						 <td colspan="4"><b></b></td>
						 <td></td>
						 <td></td>
						 <td></td>
						 <td></td>
						 <td></td>
						  <td></td>
						 <td></td>
						 <td></td>
						 </tr>	 
						 <% } %>	
   </table>
   
  
  </body>
</html>
