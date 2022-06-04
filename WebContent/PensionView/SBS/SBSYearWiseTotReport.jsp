
<%@ page import="aims.bean.EmployeePersonalInfo,java.util.ArrayList,aims.bean.PensionContBean"%>
<%@ page import="java.text.DecimalFormat"%>
<%@ page import="aims.common.*"%>

<%String path = request.getContextPath();
			String basePath = request.getScheme() + "://"
					+ request.getServerName() + ":" + request.getServerPort()
					+ path + "/";
					
					%>
					
					
												
								<%
			ArrayList dataList = new ArrayList();
			String reportType="",region="",fileName="",type="",airport="";
			
			
		
			
			if(request.getAttribute("penContrList")!=null){
				dataList=(ArrayList)request.getAttribute("penContrList");
			}
				if(request.getAttribute("airport")!=null){
				airport=request.getAttribute("airport").toString();
			}
			if("NO-SELECT".equals(airport)){
			airport="All_Airports";
			}
				if(request.getAttribute("region")!=null){
				region=request.getAttribute("region").toString();
			}
			if("NO-SELECT".equals(region)){
			region="All_Regions";
			}
		
			if(request.getAttribute("reportType")!=null){
				reportType=(String)request.getAttribute("reportType");
				if(region.equals("")){
				region="All_Regions";
				}
				if (reportType.equals("Excel Sheet")
						|| reportType.equals("ExcelSheet")) {
					
					fileName = "SBSYearWiseTotReportForALL.xls";
					response.setContentType("application/vnd.ms-excel");
					response.setHeader("Content-Disposition",
							"attachment; filename=" + fileName);
				}
			}
			System.out.println("ghjghjghjg"+dataList.size() );
				 String fullWthrOptionDesc="",genderDescr="",mStatusDec="";
			 String employeeNm="",pensionNo="",doj="",dob="",cpfacno="",employeeNO="",designation="",fhName="",gender="",mStatus="",discipline="",newemployeecode="",docofEDCR="";
  	 		String ntIncrement="",chkRegionString="",dispSignPath="",dispSignStation="",chkStationString="",chkBulkPrint="",whetherOption="",dateOfEntitle="",empSerialNo="";
			ArrayList personalList=(ArrayList)request.getAttribute("personalList");
			
			for(int i=0;i<personalList.size();i++){
			PensionContBean contr=(PensionContBean)personalList.get(i);
			employeeNm=contr.getEmployeeNM();
			pensionNo=contr.getPensionNo();
			empSerialNo=contr.getEmpSerialNo();
			doj=contr.getEmpDOJ();
			newemployeecode=contr.getNewEmpCode();
			docofEDCR=contr.getDocofEDCR();
			ntIncrement=contr.getSbsNTIncrement();
		
			
			dob=contr.getEmpDOB();
			cpfacno=StringUtility.replaces(contr.getCpfacno().toCharArray(),",=".toCharArray(),",").toString();
			System.out.println("cpfacno "+cpfacno);
			if(cpfacno.indexOf(",=")!=-1){
						cpfacno=cpfacno.substring(1,cpfacno.indexOf(",="));
			}else if(cpfacno.indexOf(",")!=-1){
				cpfacno=cpfacno.substring(cpfacno.indexOf(",")+1,cpfacno.length());
			}
			whetherOption=contr.getWhetherOption();
			if(whetherOption.toUpperCase().trim().equals("A")){
			fullWthrOptionDesc="Full Pay";
			}else if(whetherOption.toUpperCase().trim().equals("B") || whetherOption.toUpperCase().trim().equals("NO")){
			fullWthrOptionDesc="Ceiling Pay";
			}else{
			fullWthrOptionDesc=whetherOption;
			}
			employeeNO=contr.getEmployeeNO();
			designation=contr.getDesignation();
			fhName=contr.getFhName();
			gender=contr.getGender();
			
			if(gender.trim().toLowerCase().equals("m")){
				genderDescr="Male";
			}else if(gender.trim().toLowerCase().equals("f")){
				genderDescr="Female";
			}else{
				genderDescr=gender;
			}
			
			mStatus	=contr.getMaritalStatus().trim();
			
			if(mStatus.toLowerCase().equals("m")||(mStatus.toLowerCase().trim().equals("yes"))){
				mStatusDec="Married";
			}else if(mStatus.toLowerCase().equals("u")||(mStatus.toLowerCase().trim().equals("no"))){
				mStatusDec="Un-married";
			}else if(mStatus.toLowerCase().equals("w")){
				mStatusDec="Widow";
			}else{
				mStatusDec=mStatus;
			}
			dateOfEntitle=contr.getDateOfEntitle();
			
			}
				
			%>

<!DOCTYPE>
<html>

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
								<tr>
								<tr><td colspan="2" style=" font-size: 15px; color:#33419a"> <b>AAl Employees Defined Contribution Pension Trust</b></td></tr>
					
					
						</table>
					</td>
				</tr>
					</table>
					</td>
					</tr>	
				<tr></table>
			<table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
					<tr>
					<td colspan="2">
					
					</td>
					</tr>	
				<tr>
					<td >
					<div style="overflow:auto !important; width:100% !important">
					<table class="sample"   cellpadding="2" cellspacing="0" width="1205px" align="center" >
					<tr>
								<td colspan="11" style="font" class="ReportHeading" >SBS Year Wise Total -  <%=employeeNm%> - <%=pensionNo %></td>
								</tr>
								<tr>
								<td colspan="11">
						
						<table class="sample"   cellpadding="2" cellspacing="0" width="100%" align="center" 	>
							<tr >
								
								<td class="reportsublabel">PF ID</td>
								<td class="reportdata"><%=pensionNo%></td>	
									<input type="hidden" name="pfid" value="<%=empSerialNo%>">			
									<td class="reportsublabel">NAME</td>
									<td class="reportdata"><%=employeeNm%></td>		
												
							</tr>
							<tr>
								<!--<td class="reportsublabel">EMP NO</td>
								<td class="reportdata"><%=employeeNO%></td>
							--><td class="reportsublabel">DESIGNATION</td>
								<td class="reportdata"><%=designation%></td>
								<td class="reportsublabel">GENDER</td>
								<td class="reportdata"><%=genderDescr%></td>
														
								
							</tr>
							<tr>
							<td class="reportsublabel">FATHER'S/HUSBAND'S NAME</td>
								<td class="reportdata"><%=fhName%></td>
							
							<td class="reportsublabel">DATE OF BIRTH</td>
								<td class="reportdata"><%=dob%></td>
							
							
								
								
							</tr>
							<tr>
								
								<td class="reportsublabel">SAP EMPLOYEE CODE</td>
								<td class="reportdata"><%=newemployeecode%></td>
									
								<td class="reportsublabel">ANNUITY ACCOUNT NUMBER</td>
								<td class="reportdata"></td>
								
							</tr>
							<tr>
								<td class="reportsublabel">DATE OF JOINING AAI</td>
								<td class="reportdata"><%=doj%></td>
								<td class="reportsublabel">Date of Commencement of membership of EDCP</td>
								<td class="reportdata"><%=docofEDCR%></td>
									
							</tr>
							<tr>
								<td class="reportsublabel">Notional Increment Recovery</td>
								<td class="reportdata"><%=ntIncrement%></td>
								<td class="reportsublabel"></td>
								<td class="reportdata"></td>
									
							</tr>
							<!--<tr>
								<td class="reportsublabel">DATE OF MEMBERSHIP</td>
								<td class="reportdata"><%=dateOfEntitle%></td>
								<td class="reportsublabel">PENSION OPTION</td>
								<td class="reportdata"><%=fullWthrOptionDesc%></td>
							
									
							</tr>
						--></table>
				
								
								
								</td>
								
								</tr>
								
							<tr>
								<th class="label" style="width:50px" >SNO</th>
							
								<th class="label" style="width:120px">Fin Year  </th>
								<th class="label" style="width:120px">Emoluments  </th>
								<th class="label" style="width:130px">AAI SBS Contribution  </th>
								<th class="label" style="width:200px">Notational Additional Increment Recovery  </th>
								<th class="label" style="width:180px">Adjustment in SBS Contribution  </th>
								
							
								
								<th class="label" style="width:120px">Interest  </th>
								<th class="label" style="width:120px">Gross Contri</th>
				
								<th class="label" style="width:120px">RateOfInt</th>
								<th class="label" style="width:120px">Taxable Value of Perquisite Value after relief u/s 89 (with intt)</th>
							<th class="label" style="width:120px">Taxable Value of Perquisite Value after relief u/s 89 (without intt)</th>
							
								</tr>
						
				<%
				double emolumentsTotal=0.0,adjEmolumentsTotal=0.0,sbsContriTotal=0.0,noIncrementTotal=0.0,adjSbsTotal=0.0,sbsInterestTotal=0.0,grossContriTotal=0.0,taxValwithInttTot=0.0,taxValwithoutInttTot=0.0,sbsContriIntTotal=0.0,totCount=0.0;
				
				DecimalFormat df = new DecimalFormat("#########0");
				if (dataList.size() != 0) {
				int count = 0;
				
				EmployeePersonalInfo sbsPerBean=null;
				String styleClass="";
				
				
				for(int k=0;k<dataList.size();k++){
					count++;
					sbsPerBean = (EmployeePersonalInfo) dataList.get(k);
					
					
					emolumentsTotal=emolumentsTotal+Double.parseDouble(sbsPerBean.getEmoluments());
				
					sbsContriTotal=sbsContriTotal+Double.parseDouble(sbsPerBean.getSbsContri());
					sbsInterestTotal=sbsInterestTotal+Double.parseDouble(sbsPerBean.getInterest());
					noIncrementTotal=noIncrementTotal+Double.parseDouble(sbsPerBean.getNoIncrement());
					adjSbsTotal=adjSbsTotal+Double.parseDouble(sbsPerBean.getAdjSbscontri());
					grossContriTotal=grossContriTotal+Double.parseDouble(sbsPerBean.getGrossContri());
					taxValwithInttTot=taxValwithInttTot+Double.parseDouble(sbsPerBean.getTaxValwithIntt());
					taxValwithoutInttTot=taxValwithoutInttTot+Double.parseDouble(sbsPerBean.getTaxValwithoutIntt());
					//sbsContriIntTotal=sbsContriIntTotal+Double.parseDouble(sbsPerBean.getSbsTot());
					totCount=count;
				
					
					//lastActive=beans.getDateofJoining();
				%>
				
		
			
							<tr>
								
								<td ><%=count%></td>
								
								<td ><%=sbsPerBean.getFinyear()%></td>
								<td ><%=sbsPerBean.getEmoluments()%></td>
								<td ><%=sbsPerBean.getSbsContri()%></td>
								<td ><%=sbsPerBean.getNoIncrement()%></td>
								<td ><%=sbsPerBean.getAdjSbscontri() %></td>
								<td ><%=sbsPerBean.getInterest()%></td>
								<td ><%=sbsPerBean.getGrossContri()%></td>
								<td ><%=sbsPerBean.getRemarks() %></td>
								<td ><%=sbsPerBean.getTaxValwithIntt()%></td>
								<td ><%=sbsPerBean.getTaxValwithoutIntt()%></td>
							
								
							</tr>
							
							
					
						<%}}else{%>
						
						<tr>
						<td colspan="8" style="color:red" align="center" >No Records Found!</td>
						</tr>
						
						
						<%} %>
						<tr >
								
								
								
							
								<td colspan="2" style="font-weight:bold">Total</td>
								<td style="font-weight:bold"><%=df.format(emolumentsTotal)%></td>
								<td style="font-weight:bold"><%=df.format(sbsContriTotal)%></td>
								<td style="font-weight:bold"><%=df.format(noIncrementTotal) %></td>
								<td style="font-weight:bold"><%=df.format(adjSbsTotal) %></td>
								<td style="font-weight:bold"><%=df.format(sbsInterestTotal)%></td>
								<td style="font-weight:bold"><%=df.format(grossContriTotal)%></td>
								
								
								<td style="font-weight:bold"></td>
								<td style="font-weight:bold"><%=df.format(taxValwithInttTot)%></td>
								<td style="font-weight:bold"><%=df.format(taxValwithoutInttTot)%></td>
								
								
							</tr>
						</table>
						
						
						
						
						
						
				
				
			
		</form>
</body>
</html>