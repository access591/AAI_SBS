
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page import="aims.bean.*,java.text.DecimalFormat"%>
<%@ page import="aims.common.CommonUtil"%>

<%String path = request.getContextPath();
			String basePath = request.getScheme() + "://"
					+ request.getServerName() + ":" + request.getServerPort()
					+ path + "/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<base href="<%=basePath%>">

		<title>AAI</title>

		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
		<meta http-equiv="description" content="This is my page">

		<LINK rel="stylesheet" href="<%=basePath%>PensionView/css/aai.css" type="text/css">
	</head>

	<body>
	<%
	   CommonUtil commonUtil=new CommonUtil();
		String region="",fileHead="",reportType="",fileName="",dispRemtSelYears="";
		String emoluments="",pension="",disPension="",pensionHding="",ranges="";
		  DecimalFormat df1 = new DecimalFormat("#########0.00");
		  ArrayList pensionList=new ArrayList();
			 	if (request.getAttribute("range") != null) {
			ranges=(String)request.getAttribute("range");
			}
			if (request.getAttribute("region") != null) {
			region=(String)request.getAttribute("region");
			if(region.equals("NO-SELECT")){
			fileHead="ALL_REGIONS";
			}else{
			fileHead=region;
			}
		}
		if(region.equals("NO-SELECT") && !ranges.equals("")){
			fileHead="PFID_WISE_"+ranges;
		}
		if (request.getAttribute("dspRemtYears") != null) {
			dispRemtSelYears=(String)request.getAttribute("dspRemtYears");
		}
		if (request.getAttribute("pensionHding") != null) {
			pensionHding=(String)request.getAttribute("pensionHding");
		}
		
		if (request.getAttribute("reportType") != null) {
				reportType = (String) request.getAttribute("reportType");
				if (reportType.equals("Excel Sheet")
						|| reportType.equals("ExcelSheet")) {
				
					fileName = "Form_8_Report_"+fileHead+".xls";
					response.setContentType("application/vnd.ms-excel");
					response.setHeader("Content-Disposition",
							"attachment; filename=" + fileName);
				}
			}
	    ArrayList form8allYearsList=new ArrayList();
	    int totalYearssize=0;
		if(request.getAttribute("form8List")!=null){
		Form7MultipleYearBean multipleBean=null;
			ArrayList dataList=new ArrayList();
			ArrayList form8List=new ArrayList();
			form8List=(ArrayList)request.getAttribute("form8List");
			totalYearssize=form8List.size();
			
			
						int count=0;
						double totalEmoluments=0.0,totalPension=0.0,dispTotalPension=0.0;
						double yearTotalEmoluments=0.0,yearTotalPension=0.0;
						Long cpfAdjOB=null,pensionAdjOB=null,pfAdjOB=null,empSubOB=null,adjPensionContri=null;
						String obFlag="",calYear="",adjYear="",finalRemarks="",remarks="",arrearMonth="";
						double arrearEmoluemntsAmount=0.00,arrearContriAmount=0.00;
     					boolean arrearflags=false;
						ArrayList obList=new ArrayList();
						boolean regionFlag=false;
						String dispRegion="";
						double grandTotalPensionContr=0,grandTotalEmoluments=0,totalAprContribution=0.0,totalMayContribution=0.0;
						double totalJunContribution=0.0,totalJulContribution=0.0,totalAugContribution=0.0,totalSepContribution=0.0,totalOctContribution=0.0,totalNovContribution=0.0,totalDecContribution=0.0,totalJanContribution=0.0,totalFebContribution=0.0,totalMarContribution=0.0;
						double totalAprAdjobContribution=0.0,grantTotalRemtPension=0.0;
						String   isArrearMnthApr="",isArrearMnthMay ="",isArrearMnthJun ="",isArrearMnthJul ="",isArrearMnthAug ="",isArrearMnthSep ="",isArrearMnthOct ="", isArrearMnthNov ="",isArrearMnthDec ="",isArrearMnthJan ="",isArrearMnthFeb ="",isArrearMnthMar ="";
						Form8DataBean personalInfo=new Form8DataBean();
						Form8RemittanceBean remittanceBean=new Form8RemittanceBean();
						String employeename="",pensionno="";
						System.out.println("form8List List Size=============="+form8List.size());
						    for(int j=0;j<form8List.size();j++){
						    
							personalInfo=(Form8DataBean)form8List.get(j);
							dataList=personalInfo.getForm8List();
							remittanceBean=personalInfo.getRemittanceBean();
							
							totalAprContribution=totalAprContribution+remittanceBean.getTotalAprContribution()+remittanceBean.getTotalAprDueContribution();
							totalMayContribution=totalMayContribution+remittanceBean.getTotalMayContribution()+remittanceBean.getTotalMayDueContribution();
							totalJunContribution=totalJunContribution+remittanceBean.getTotalJunContribution()+remittanceBean.getTotalJunDueContribution();
							totalJulContribution=totalJulContribution+remittanceBean.getTotalJulContribution()+remittanceBean.getTotalJulDueContribution();
							totalAugContribution=totalAugContribution+remittanceBean.getTotalAugContribution()+remittanceBean.getTotalAugDueContribution();
							totalSepContribution=totalSepContribution+remittanceBean.getTotalSepContribution()+remittanceBean.getTotalSepDueContribution();
							totalOctContribution=totalOctContribution+remittanceBean.getTotalOctContribution()+remittanceBean.getTotalOctDueContribution();
							totalNovContribution=totalNovContribution+remittanceBean.getTotalNovContribution()+remittanceBean.getTotalNovDueContribution();
							totalDecContribution=totalDecContribution+remittanceBean.getTotalDecContribution()+remittanceBean.getTotalDecDueContribution();
							totalJanContribution=totalJanContribution+remittanceBean.getTotalJanContribution()+remittanceBean.getTotalJanDueContribution();
							totalFebContribution=totalFebContribution+remittanceBean.getTotalFebContribution()+remittanceBean.getTotalFebDueContribution();
							totalMarContribution=totalMarContribution+remittanceBean.getTotalMarContribution()+remittanceBean.getTotalMarDueContribution();
							grantTotalRemtPension=totalAprContribution+totalMayContribution+totalJunContribution+totalJulContribution+totalAugContribution+totalSepContribution+totalOctContribution+totalNovContribution+totalDecContribution+totalJanContribution+totalFebContribution+totalMarContribution;
								
							System.out.println("Data List Size=============="+dataList.size()); 
							EmployeePensionCardInfo cardInfo=new EmployeePensionCardInfo();
							System.out.println("===============pensionList.size()"+dataList.size());
							for(int r=0;r<dataList.size();r++){
							cardInfo=(EmployeePensionCardInfo)dataList.get(r);
							obFlag=cardInfo.getObFlag();
  								if(obFlag.equals("Y")){
  								      obList=cardInfo.getObList();
  								      if(obList.size()>3){
             							adjYear="Apr-"+(String)obList.get(4);
							             cpfAdjOB=(Long)obList.get(5);
							           	 pensionAdjOB=(Long)obList.get(6);
							             pfAdjOB=(Long)obList.get(7);
							             empSubOB=(Long)obList.get(8);
							             adjPensionContri=(Long)obList.get(9);
             						}
          
  								}
  							if(cardInfo.getTransArrearFlag().equals("Y")){
  								System.out.println("==Arrear Amnt ===="+cardInfo.getOringalArrearAmnt());
    								arrearEmoluemntsAmount= arrearEmoluemntsAmount + Double.parseDouble(cardInfo.getOringalArrearAmnt());
    								arrearContriAmount= arrearContriAmount + Double.parseDouble(cardInfo.getOringalArrearContri());
     								arrearflags=true;
     								arrearMonth=commonUtil.converDBToAppFormat(cardInfo.getMonthyear(),"dd-MMM-yyyy","MMM-yyyy");
    								String month = commonUtil.converDBToAppFormat(
						cardInfo.getMonthyear(), "dd-MMM-yyyy", "MMM");	
     								 if(month.toUpperCase().equals("APR")) {
						  isArrearMnthApr  = arrearMonth ;
					  }else if(month.toUpperCase().equals("MAY")) {
						  isArrearMnthMay  = arrearMonth;
					  }else if(month.toUpperCase().equals("JUN")) {
						  isArrearMnthJun  = arrearMonth;
					  }else if(month.toUpperCase().equals("JUL")) {
						  isArrearMnthJul  = arrearMonth;
					  }else if(month.toUpperCase().equals("AUG")) {
						 isArrearMnthAug  = arrearMonth;
					  }else if(month.toUpperCase().equals("SEP")) {
						  isArrearMnthSep  = arrearMonth;
					  }else if(month.toUpperCase().equals("OCT")) {
						  isArrearMnthOct  = arrearMonth;
					  }else if(month.toUpperCase().equals("NOV")) {
						  isArrearMnthNov  = arrearMonth;
					  }else if(month.toUpperCase().equals("DEC")) {
						  isArrearMnthDec  = arrearMonth;
					  }else if(month.toUpperCase().equals("JAN")) {
						  isArrearMnthJan  = arrearMonth;						  
					  }else if(month.toUpperCase().equals("FEB")) {
						 isArrearMnthFeb  = arrearMonth;
					  }else if(month.toUpperCase().equals("MAR")) {
						  isArrearMnthMar  = arrearMonth;
					  } 
    							 
    						  }
							dispRegion=cardInfo.getRegion();
							totalEmoluments=totalEmoluments+Math.round(Double.parseDouble(cardInfo.getEmoluments()))+Math.round(Double.parseDouble(cardInfo.getDueemoluments()));
							totalPension=totalPension+Math.round(Double.parseDouble(cardInfo.getPensionContribution()))+Math.round(Double.parseDouble(cardInfo.getDuepensionamount()));
							}
							if(arrearflags==true){
					      		finalRemarks=arrearEmoluemntsAmount+","+arrearContriAmount;
				   				totalEmoluments=totalEmoluments-arrearEmoluemntsAmount;
				   				totalPension=totalPension-arrearContriAmount;
					    		
					    		if(remittanceBean.getAprMnth().equals(isArrearMnthApr)){
					    			totalAprContribution=totalAprContribution-  remittanceBean.getAprMnthArrearContri ();					    			
					    		}else if(remittanceBean.getMayMnth().equals(isArrearMnthMay)){
					    			totalMayContribution=totalMayContribution-   remittanceBean.getMayMnthArrearContri();					    			
					    		}else if(remittanceBean.getJunMnth().equals(isArrearMnthJun)){
					    			totalJunContribution=totalJunContribution-  remittanceBean.getJunMnthArrearContri ();
					    		}else if(remittanceBean.getJulMnth().equals(isArrearMnthJul)){
					    			totalJulContribution=totalJulContribution-   remittanceBean.getJulMnthArrearContri();
					    		}else if(remittanceBean.getAugMnth().equals(isArrearMnthAug)){
					    			totalAugContribution=totalAugContribution-  remittanceBean.getAugMnthArrearContri();
					    		}else if(remittanceBean.getSepMnth().equals(isArrearMnthSep)){
					    			totalSepContribution=totalSepContribution-  remittanceBean.getSepMnthArrearContri() ;
					    		}else if(remittanceBean.getOctMnth().equals(isArrearMnthOct)){
					    			totalOctContribution=totalOctContribution-  remittanceBean.getOctMnthArrearContri();
					    			System.out.println("--remittanceBean.getOctMnth()--"+remittanceBean.getOctMnth()+"----totalOctContribution--"+totalOctContribution+"------cardInfo.getOctMnthArrearContri()---"+remittanceBean.getOctMnthArrearContri());
					    		
					    		}else if(remittanceBean.getNovMnth().equals(isArrearMnthNov)){
					    			totalNovContribution=totalNovContribution-  remittanceBean.getNovMnthArrearContri() ;
					    		}else if(remittanceBean.getDecMnth().equals(isArrearMnthDec)){
					    			totalDecContribution=totalDecContribution-  remittanceBean.getDecMnthArrearContri();
					    		}else if(remittanceBean.getJanMnth().equals(isArrearMnthJan)){
					    		 System.out.println("--totalJanContribution--"+totalJanContribution+"------cardInfo.getJanMnthArrearContri()---"+remittanceBean.getJanMnthArrearContri());
					    		
					    			totalJanContribution=totalJanContribution-  remittanceBean.getJanMnthArrearContri();
					    		}else if(remittanceBean.getFebMnth().equals(isArrearMnthFeb)){
					    			totalFebContribution=totalFebContribution-  remittanceBean.getFebMnthArrearContri();
					    		}else if(remittanceBean.getMarMnth().equals(isArrearMnthMar)){
					    			totalMarContribution=totalMarContribution- remittanceBean.getMarMnthArrearContri();
					    		}
					    		grantTotalRemtPension=grantTotalRemtPension-arrearContriAmount;
      						}
      					
      						if(!finalRemarks.equals("")){
      							remarks=finalRemarks+"<br/>"+personalInfo.getRemarks();
      						}else{
      						remarks=personalInfo.getRemarks();
      						}
      						if(adjPensionContri!=null){
							if(adjPensionContri.longValue()!=0.00){
									totalEmoluments=totalEmoluments+Math.round(adjPensionContri.longValue()*100/8.33);
									totalPension=totalPension+adjPensionContri.longValue();
									grantTotalRemtPension=grantTotalRemtPension+adjPensionContri.longValue();
									totalAprAdjobContribution=adjPensionContri.longValue();
							}
							}
						
	%>
	
		<table width="100%" border="0" cellpadding="0" cellspacing="0">
			<tr>
				<td width="9%">
					&nbsp;
				</td>
				<td width="15%">
					&nbsp;
				</td>
				<td width="12%">
					&nbsp;
				</td>
				<td width="33%">
					&nbsp;
				</td>
				<td width="13%">
					&nbsp;
				</td>
				<td width="9%">
					&nbsp;
				</td>
				<td width="9%">
					&nbsp;
				</td>
			</tr>	
			<tr>
				<td>
					&nbsp;
				</td>
				<td>
					&nbsp;
				</td>
				
							<td colspan="2" align="center" class="reportsublabel"><%=request.getAttribute("screenHeading")%></td>
						
				<td>
					&nbsp;
				</td>
				<td>
					&nbsp;
				</td>
				<td>
					&nbsp;
				</td>
			</tr>
						<tr>
				<td>
					&nbsp;
				</td>
				<td>
					&nbsp;
				</td>
				
							<td colspan="2" align="center" class="reportsublabel">(For Exempted Establishments only)</td>
						
				<td>
					&nbsp;
				</td>
				<td>
					&nbsp;
				</td>
				<td>
					&nbsp;
				</td>
			</tr>
			<tr>
				<td>
					&nbsp;
				</td>
				<td>
					&nbsp;
				</td>
				
							<td colspan="2" align="center" class="reportsublabel">THE EMPLOYEES PENSION SCHEME, 1995</td>
						
				<td>
					&nbsp;
				</td>
				<td>
					&nbsp;
				</td>
				<td>
					&nbsp;
				</td>
			</tr>

			<tr>
				<td>
					&nbsp;
				</td>
				<td>
					&nbsp;
				</td>
				<td colspan="3" class="reportlabel" align="center">
					Annual Statement Of Contribution For The Currency
				</td>
				<td>
					&nbsp;
				</td>
				<td>
					&nbsp;
				</td>
			</tr>
			<tr>
				<td>
					&nbsp;
				</td>
				<td>
					&nbsp;
				</td>
				<td colspan="2">
					<table width="100%" border="0" cellspacing="0" cellpadding="0">
						<tr>
							<td width="13%">
								&nbsp;
							</td>
							<td width="87%" class="reportsublabel" align="center">
								<font style="text-decoration: underline">Period From <%=request.getAttribute("dspYear")%></font>
							</td>
						</tr>
					</table>
				</td>
				<td>
					&nbsp;
				</td>
				<td>
					&nbsp;
				</td>
				<td>
					&nbsp;
				</td>
			<tr>
				<td>
					&nbsp;
				</td>
				<td>
					&nbsp;
				</td>
				<td>
					&nbsp;
				</td>
				<td>
					&nbsp;
				</td>
				<td>
					&nbsp;
				</td>
				<td>
					&nbsp;
				</td>
				<td>
					&nbsp;
				</td>
			<tr>
				<td colspan="4">
					<table width="100%" border="0" cellspacing="0" cellpadding="0">
						<tr>
							<td width="36%" class="label">
								Name &amp; Address of the Establishment
							</td>
							<td width="64%">
								Airports Authority Of India,
								<br />
								Rajiv Gandhi Bhawan,Safdarjung Airport,New Delhi-3
							</td>
						</tr>
					</table>
				</td>
				<td>
					&nbsp;
				</td>
				<td>
					&nbsp;
				</td>
				<td>
					&nbsp;
				</td>
			<tr>
				<td colspan="4">
					<table width="100%" border="0" cellspacing="0" cellpadding="0">
						<tr>
							<td width="36%" class="label">
								Code No. of the Establishment
							</td>
							<td width="64%">
								DL/36478
							</td>
						</tr>
					</table>
				</td>
				<td>
					&nbsp;
				</td>
				<td>
					&nbsp;
				</td>
				<td>
					&nbsp;
				</td>
			<tr>
				<td>
					&nbsp;
				</td>
				<td>
					&nbsp;
				</td>
				<td>
					&nbsp;
				</td>
				<td>
					&nbsp;
				</td>
				<td>
					&nbsp;
				</td>
				<td>
					&nbsp;
				</td>
				<td>
					&nbsp;
				</td>
			<tr>
				<td colspan="7">
					<table width="100%" border="1" cellspacing="0" cellpadding="0">
						
						<%
					
						
					
							
						%>
						<%if(regionFlag==false){%>
						<tr>
							<td class="label" colspan=8><font color=blue>Name Of Region :&nbsp;<%=dispRegion%></font></td>
							
						</tr>
						<tr>
							<td width="6%" class="reportsublabel">
								Sl. No.
							</td>
						
							<td width="17%" class="reportsublabel">
								Account No.
							</td>
						
							<td width="22%" class="reportsublabel">
								Name of Member
								<br>
								(in block letters)</span>
							</td>
							<td width="25%" class="reportsublabel">
								Wages, retaining allowance,if any &amp; DA paid during the currency period
							</td>
							<%if(pensionHding.equals("true")){%>
							<td width="11%" class="reportsublabel">
								Contribution to Pension Fund 8.33% / 2*1.16%
							</td>
							<%}else{%>
								<td width="11%" class="reportsublabel">
								Contribution to Pension Fund 8.33% 
							</td>
							<%}%>
							
						

							<td width="10%" class="reportsublabel">
								Remarks
							</td>
							
						</tr>
						<%regionFlag=false;}
						
							count++;
						%>
						<tr>
							<td class="Data"><%=count%></td>
							<td class="Data"><%="DL/36478/"+commonUtil.leadingZeros(5,personalInfo.getPensionNo())%></td>
						
							<td class="Data"><%=personalInfo.getEmployeeName()%></td>
							<td class="NumData"><%=Math.round(totalEmoluments)%></td>
							<td class="NumData"><%=Math.round(totalPension)%></td>
							
							<td class="Data"><%=remarks%></td>
						</tr>
						
						
						<tr>
							<td class="NumData"><%=count%></td>
							<td class="Data" colspan="2">&nbsp;</td>
							<td class="NumData"><%=Math.round(totalEmoluments)%></td>
							<td class="NumData"><%=Math.round(totalPension)%></td>
							
							<td class="Data" >&nbsp;</td>
						
							
						</tr>
					</table>
				</td>
			<tr>
				<td>
					&nbsp;
				</td>
				<td>
					&nbsp;
				</td>
				<td>
					&nbsp;
				</td>
				<td>
					&nbsp;
				</td>
				<td>
					&nbsp;
				</td>
				<td>
					&nbsp;
				</td>
				<td>
					&nbsp;
				</td>
			</tr>
			<%
  			yearTotalEmoluments=yearTotalEmoluments+Math.round(totalEmoluments);
            yearTotalPension=yearTotalPension+Math.round(totalPension);%>
			<tr>
				<td colspan="7">
					<table width="100%" border="0" cellspacing="0" cellpadding="0">
						<tr>
							<td>
								<span class="reportsublabel">Reconciliation of Remittances as </span>____________________ <span class="reportsublabel">Total</span>________________ <span class="reportsublabel">Rs</span><%=Math.round(totalPension)%>
							</td>
						</tr>
					</table>
				</td>
			</tr>
		
			<tr>
				<td>
					&nbsp;
				</td>
				<td>
					&nbsp;
				</td>
				<td>
					&nbsp;
				</td>
				<td>
					&nbsp;
				</td>
				<td>
					&nbsp;
				</td>
				<td>
					&nbsp;
				</td>
				<td>
					&nbsp;
				</td>
			</tr>
			<tr>
				<td>
					&nbsp;
				</td>
				<td>
					&nbsp;
				</td>
				<td>
					&nbsp;
				</td>
				<td>
					&nbsp;
				</td>
				<td>
					&nbsp;
				</td>
				<td>
					&nbsp;
				</td>
				<td>
					&nbsp;
				</td>
			</tr>
			<tr>
				<td colspan="7">
					<table width="100%" border="1" cellspacing="0" cellpadding="0">
						<tr>
							<td width="12%" class="label">
								Sl. No.
							</td>
						
							<td width="27%" class="label">
								Month Pension Fund Contribution A/c No. 10
							</td>
							<td width="10%" class="label">
								Cheque No.
							</td>
							<td width="10%" class="label">
								Cheque Date
							</td>
							<td>
								&nbsp;
							</td>
						</tr>
						<tr>
						
							<td class="Data">
								1
							</td>
							<td class="Data" nowrap="nowrap">
								Rs.<%=Math.round(totalAprContribution)%> (<%=dispRemtSelYears%>)for All members for month of April 
							</td>
							<td>
								&nbsp;
							</td>
							<td>
								&nbsp;
							</td>
						
							<td rowspan="13" valign="top">
								<span class="Data">Certified that the difference between the figures of total Pension Fund Contributions remitted during the currency period and the total Pension Fund Contribution shown under Column (5) is solely due to the rounding of amounts to the nearest Rupee
								under the rules.</span>
								<br/>
								<span class="Data">(i) Total number of contribution cards enclosed in Form 7 (PS). (ii) Certified that the Form 7 (PS) completed of all the members listed in this statement are enclosed, except those already sent during the course of the currency
									period for the final settlement of the concerned members account &quot;Remarks&quot; furnished against the names of the respective members 1 above</span>.
							</td>
						</tr>
						<%if (totalAprAdjobContribution!=0.00){%>
						<tr>
						
							<td class="Data">
								1.1
							</td>
							<td class="Data" nowrap="nowrap">
								Rs.<%=Math.round(totalAprAdjobContribution)%> (<%=dispRemtSelYears%>)Adj.ob for All members for month of April 
							</td>
							<td>
								&nbsp;
							</td>
							<td>
								&nbsp;
							</td>
						
							<td rowspan="13" valign="top">
								<span class="Data">Certified that the difference between the figures of total Pension Fund Contributions remitted during the currency period and the total Pension Fund Contribution shown under Column (5) is solely due to the rounding of amounts to the nearest Rupee
								under the rules.</span>
								<br/>
								<span class="Data">(i) Total number of contribution cards enclosed in Form 7 (PS). (ii) Certified that the Form 7 (PS) completed of all the members listed in this statement are enclosed, except those already sent during the course of the currency
									period for the final settlement of the concerned members account &quot;Remarks&quot; furnished against the names of the respective members 1 above</span>.
							</td>
						</tr>
						<%}%>
						<tr>
							<td class="Data">
								2
							</td>
							<td class="Data" nowrap="nowrap">
								Rs.<%=Math.round(totalMayContribution)%> (<%=dispRemtSelYears%>)for All members for month of May
							</td>
							<td>
								&nbsp;
							</td>
							<td>
								&nbsp;
							</td>
						
						</tr>
						<tr >
							<td class="Data">
								3
							</td>
							<td class="Data" nowrap="nowrap">
								Rs.<%=Math.round(totalJunContribution)%> (<%=dispRemtSelYears%>)for All members for month of June 
							</td>
							<td>
								&nbsp;
							</td>
							<td>
								&nbsp;
							</td>
						</tr>
						<tr >
							<td class="Data">
								4
							</td>
							<td class="Data" nowrap="nowrap">
								Rs.<%=Math.round(totalJulContribution)%> (<%=dispRemtSelYears%>)for All members for month of July
							</td>
							<td>
								&nbsp;
							</td>
							<td>
								&nbsp;
							</td>
						</tr>
						<tr >
							<td class="Data">
								5
							</td>
							<td class="Data" nowrap="nowrap">
								Rs.<%=Math.round(totalAugContribution)%> (<%=dispRemtSelYears%>)for All members for month of August 
							</td>
							<td>
								&nbsp;
							</td>
							<td>
								&nbsp;
							</td>
						</tr>
						<tr>
							<td class="Data">
								6
							</td>
							<td class="Data" nowrap="nowrap">
								Rs.<%=Math.round(totalSepContribution)%> (<%=dispRemtSelYears%>)for All members for month of September
							</td>
							<td>
								&nbsp;
							</td>
							<td>
								&nbsp;
							</td>
						</tr>
						<tr >
							<td class="Data">
								7
							</td>
							<td class="Data" nowrap="nowrap">
								Rs.<%=Math.round(totalOctContribution)%> (<%=dispRemtSelYears%>)for All members for month of October
							</td>
							<td>
								&nbsp;
							</td>
							<td>
								&nbsp;
							</td>
						</tr>
						<tr >
							<td class="Data">
								8
							</td>
							<td class="Data" nowrap="nowrap">
								Rs.<%=Math.round(totalNovContribution)%> (<%=dispRemtSelYears%>)for All members for month of November
							</td>
							<td>
								&nbsp;
							</td>
							<td>
								&nbsp;
							</td>
						</tr>
						<tr>
							<td  class="Data">
								9
							</td>
							<td class="Data" nowrap="nowrap">
								Rs.<%=Math.round(totalDecContribution)%> (<%=dispRemtSelYears%>)for All members for month of December
							</td>
							<td>
								&nbsp;
							</td>
							<td>
								&nbsp;
							</td>
						</tr>
						<tr >
							<td class="Data">
								10
							</td>
							<td class="Data" nowrap="nowrap">
								Rs.<%=Math.round(totalJanContribution)%> (<%=dispRemtSelYears%>)for All members for month of January
							</td>
							<td>
								&nbsp;
							</td>
							<td>
								&nbsp;
							</td>
						</tr>
						<tr >
							<td class="Data">
								11
							</td>
							<td class="Data" nowrap="nowrap">
								Rs.<%=Math.round(totalFebContribution)%> (<%=dispRemtSelYears%>)for All members for month of February
							</td>
							<td>
								&nbsp;
							</td>
							<td>
								&nbsp;
							</td>
						</tr>
						<tr >
							<td class="Data">
								12
							</td>
							<td class="Data" nowrap="nowrap">
								Rs.<%=Math.round(totalMarContribution)%>(<%=dispRemtSelYears%>)for All members for month of March
							</td>
								<td>
								&nbsp;
							</td>
							<td>
								&nbsp;
							</td>
						</tr>
						<tr >
							<td class="Data">
								Total
							</td>
							<td class="Data" nowrap="nowrap">
								Rs.<%=df1.format(grantTotalRemtPension)%>
							</td>
								<td>
								&nbsp;
							</td>
							<td>
								&nbsp;
							</td>
						</tr>
					</table>
				</td>
			</tr>
			
			<tr>
				<td width="9%">
					&nbsp;
				</td>
				<td width="15%">
					&nbsp;
				</td>
				<td width="12%">
					&nbsp;
				</td>
				<td width="33%">
					&nbsp;
				</td>
				<td width="13%">
					&nbsp;
				</td>
				<td width="9%">
					&nbsp;
				</td>
				<td width="9%">
					&nbsp;
				</td>
			</tr>
				<tr>
				<td class="label" align="right" colspan=7>&nbsp;</td>
							
			</tr>
			<tr>
				<td class="label" align="right" colspan=7>Signature of the Employer<br/>(With office seal)</td>
							
			</tr>
		</table>
		<%
		 grandTotalPensionContr=0;grandTotalEmoluments=0;totalAprContribution=0.0;totalMayContribution=0.0;
		totalJunContribution=0.0;totalJulContribution=0.0;totalAugContribution=0.0;totalSepContribution=0.0;totalOctContribution=0.0;totalNovContribution=0.0;totalDecContribution=0.0;totalJanContribution=0.0;totalFebContribution=0.0;totalMarContribution=0.0;
		grantTotalRemtPension=0.0;totalEmoluments=0.0;totalPension=0.0;dispTotalPension=0.0;
			arrearEmoluemntsAmount=0.00;arrearContriAmount=0.00;
		arrearflags=false;
		%>
	
		<%}%>
		<br style='page-break-before:always;'>
							<table width="100%" border="1" cellspacing="0" cellpadding="0" bordercolor="gray">
					<tr>
					<td colspan="4" align="center" style="label">Total Years Grand Totals
					</td>
				<tr>
    
    <td class="label">Amount of wages, retaining allowance<br />
          if any &amp; DA paid during the month</td>
    <td class="label">Contribution to Pension Fund</td>
    
    
  </tr>
						      <tr>
   
    <td class="Data"><%=df1.format(yearTotalEmoluments)%></td>
    <td class="Data"><%=df1.format(yearTotalPension)%></td>
    
  </tr>
  </table>				
		<%}%>
	</body>
</html>
