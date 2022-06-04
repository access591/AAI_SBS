
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page import="aims.bean.*,aims.common.CommonUtil,java.text.DecimalFormat"%>
<%@ page import="aims.common.CommonUtil" %>

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
	
		String region="",fileHead="",reportType="",fileName="",filemssage="";
		
		if (request.getAttribute("fileNameMessage") != null) {
			filemssage=(String)request.getAttribute("fileNameMessage");
		}else{
			filemssage="";
		}
		if (request.getAttribute("region") != null) {
			region=(String)request.getAttribute("region");
			if(region.equals("NO-SELECT")){
			fileHead=filemssage+"_ALL_REGIONS";
			}else{
			fileHead=filemssage+"_"+region;
			}
		}
		
		if (request.getAttribute("reportType") != null) {
				reportType = (String) request.getAttribute("reportType");
				if (reportType.equals("Excel Sheet")
						|| reportType.equals("ExcelSheet")) {
				
					fileName = "Form_7(PS)_Revised_Report_"+fileHead+".xls";
					response.setContentType("application/vnd.ms-excel");
					response.setHeader("Content-Disposition",
							"attachment; filename=" + fileName);
				}
			}
	
	%>
	
		<%	
		String dispYear="";
		CommonUtil commonUtil=new CommonUtil();
		if(request.getAttribute("dspYear")!=null){
		dispYear=request.getAttribute("dspYear").toString();
		}
		
	
						ArrayList dataList=new ArrayList();
						ArrayList pensionDataList=new ArrayList();
						boolean seperationFlag=false;
						int count=0,size=0;
						EmployeePersonalInfo personalInfo=new EmployeePersonalInfo();
						String remarks="",monthYear="",shnMonthYear="",arrearRevisedFlag="",pensionRemarks="",rstchkYear="",seperationMnth="";
						DecimalFormat df = new DecimalFormat("#########0");
						 DecimalFormat df1 = new DecimalFormat("#########0.00");
						if(request.getAttribute("chkYear")!=null){
							rstchkYear=(String)request.getAttribute("chkYear");
						}else{
							rstchkYear="1995";
						}
						 Form7MultipleYearBean form7MulBean=null;
						double totalEmoluments=0.0,totalPension=0.0,dispTotalPension=0.0,dueEmoluments=0.0,duePension=0.0,dueTotalEmoluments=0.0,dueTotalPension=0.0;
						double dueGrandTotalEml=0.0,dueGrandTotalPension=0.0;
						double yearTotalEmoluments=0.0,yearTotalPension=0.0,yearTotalDueEmoluments=0.0,yearTotalDuePension=0.0;
						String arrearBreakUpData="";
						double totalDueEmoluments=0.00,totalDueArrears=0.00,grandTotalArrearEmoluments=0.00,grandtTotalArrearPension=0.00;
						double previsedEmoluments=0.00,previsedContri=0.00,monthlyDueEmolumens=0.00,monthlyPensionContri=0.00;
						ArrayList allYearForm8List=new ArrayList();
						if(request.getAttribute("form8List")!=null){
						allYearForm8List=(ArrayList)request.getAttribute("form8List");
							
							for(int cntYear=0;cntYear<allYearForm8List.size();cntYear++){
							form7MulBean=(Form7MultipleYearBean)allYearForm8List.get(cntYear);
								dataList=form7MulBean.getEachYearList();
								dispYear=form7MulBean.getMessage();
							  if(dataList.size()!=0){
						
							for(int i=0;i<dataList.size();i++){
							count++;
							personalInfo=(EmployeePersonalInfo)dataList.get(i);
						
							if(personalInfo.getRemarks().equals("")){
								remarks="---";
							}else{
								remarks=personalInfo.getRemarks();
								//pensionRemarks=remarks;
								remarks="";
								
							}
							//System.out.println("seperation date is : "+personalInfo.getSeperationDate());
							if(!personalInfo.getSeperationDate().equals("---")){
								seperationMnth=commonUtil.converDBToAppFormat(personalInfo.getSeperationDate(),"dd-MMM-yyyy","MMM-yyyy");
							}else{
								seperationMnth="---";
							}
							
							//System.out.println("EmployeeName"+personalInfo.getEmployeeName()+"Date Of Seperation"+personalInfo.getSeperationDate()+"pensionRemarks=========================="+pensionRemarks);							
							pensionDataList=personalInfo.getPensionList();
							if(!personalInfo.getArreatBreakupData().equals("")){
								arrearBreakUpData=personalInfo.getArreatBreakupData();
								if(arrearBreakUpData.indexOf("-")!=-1){
									String[] arrearBreakUpDataList=arrearBreakUpData.split("-");
									totalDueEmoluments=Double.parseDouble(arrearBreakUpDataList[0]);
									totalDueArrears=Double.parseDouble(arrearBreakUpDataList[1]);
								}
								
							}
							
							if(pensionDataList.size()!=0){
							
							
			%>
		<table width="100%" border="0" cellspacing="0" cellpadding="0">
	    <tr>
			<td>
				<table width="100%" border="0" cellspacing="0" cellpadding="0">

	
  <tr>
    <td width="16%">&nbsp;</td>
    <td colspan="3" class="reportlabel"><table width="70%" border="0" cellspacing="0" cellpadding="0">
      <tr>
        <td width="20%" rowspan="3"><img src="<%=basePath%>PensionView/images/logoani.gif" width="87" height="50" align="right" /></td>
        <td width="80%" class="reportlabel"  align="center">FORM-7 PS</td>
      </tr>
      <tr>
        <td nowrap="nowrap" align="center" class="reportsublabel">(FOR EXEMPTED ESTABLISHMENT ONLY)</td>
      </tr>
      <tr>
        <td nowrap="nowrap" align="center" class="reportsublabel">THE EMPLOYEES' PENSION SCHEME, 1995</td>
      </tr>
      <tr>
        <td>&nbsp;</td>
      </tr>
    </table></td>
  </tr>

    <tr>
    <td>&nbsp;</td>
	
    <td colspan="3"  align="center" class="reportsublabel">CONTRIBUTION CARDS FOR MEMBERS FOR THE YEAR <%=dispYear%></td>
  </tr>
  <tr>
    <td>&nbsp;</td>
    <td width="27%">&nbsp;</td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td colspan="4"><table width="100%" border="2" bordercolor="gray" cellspacing="0" cellpadding="0">
      <tr>
        <td  class="label">1. Account No.: </td>
        <td  class="Data">DL/36478/<%=personalInfo.getPensionNo()%></td>
       	<td  class="label">6. Emp No.: </td>
        <td  class="Data"><%=personalInfo.getEmployeeNumber()%></td>
      </tr>
      <tr>
        <td nowrap="nowrap" class="label">2. Name/Surname:</td>
        <td class="Data"><%=personalInfo.getEmployeeName().toUpperCase()%></td>
        <td class="label">7. Statutory Rate of Contribution </td>
		<%if(rstchkYear.equals("1995")){%> 
        <td class="Data">1.16% and 8.33%</td>
		<%}else if (!rstchkYear.equals("1995")){%>
		<td class="Data">8.33%</td>
		<%}%> 
      </tr>
      <tr>
        <td class="label">3. Father's/Husband's Name:</td>
        <td class="Data"><%=personalInfo.getFhName().toUpperCase()%></td>
        <td class="label">8. Date of Commencement of<br/> membership of EPS :</td>
		<%if(!personalInfo.getDateOfEntitle().equals("---")){%>
        <td class="Data"><%=personalInfo.getDateOfEntitle()%></td>
		<%}else{%>
 			<td class="Data">01-Apr-1995</td>

		<%}%>
      </tr>
       <tr>
        
        <td nowrap="nowrap" class="label">4. Date Of Birth:</td>
        <td class="Data"><%=personalInfo.getDateOfBirth()%></td>
         <td class="label">9.Unit:</td>
        <td class="Data" nowrap="nowrap"><%=personalInfo.getRegion().toUpperCase()%>/<%=personalInfo.getAirportCode().toUpperCase()%></td>
      </tr>
		
      <tr>
        
        <td nowrap="nowrap" class="label">5. Name &amp; Address of the Establishment:</td>
        <td class="Data">Airports Authority Of India,<br/>Rajiv Gandhi Bhawan,Safdarjung Airport,New Delhi-3</td>
         <td class="label">10. Voluntary Higher rate of employees'cont.,if any:</td> 
         <td class="label">&nbsp;</td> 
      </tr>
 <tr>
        <td nowrap="nowrap" class="label">11. UAN No:</td>
        <td class="Data"><%=personalInfo.getUanno()%></td>
      </tr>
      <tr>
       
      </tr>
    </table></td>
 
   
  </tr>
  <tr>
    <td colspan="4"><table width="100%" border="1" bordercolor="gray" cellpadding="2" cellspacing="0">
           <tr>
        <td width="13%" rowspan="2" align="center" class="label">Month</td>
        <td width="30%" colspan="3" align="center" class="label">Amount of wages, retaining allowance<br />
          if any &amp; DA paid during the month</td>
       	 <td width="23%" colspan="3" align="center" class="label">Contribution to Pension Fund </td>
          <td width="23%" rowspan="2" align="center" class="label"> No.of days/ period of non-contributing<br/>service, if any</td>
         <td width="34%" rowspan="2" align="center" class="label">Remarks</td>
      </tr>
      <tr>
      	 	<td   align="center" class="label">Pre-revised </td>
      	  	<td   align="center" class="label">Arrears </td>
      	   	<td   align="center" class="label">Total </td>
      	   	<td   align="center" class="label">Pre-revised </td>
      	  	<td   align="center" class="label">Arrears </td>
      	  	<td   align="center" class="label">Total </td>
      </tr>
      <tr>
        <td class="label" width="13%" align="center">1</td>
        <td class="label" width="30%" align="center">2</td>
        <td class="label" width="23%" align="center">3</td>
        <td class="label" width="23%" align="center">4</td>
        <td class="label" width="34%"  align="center">5</td>
        <td class="label" width="23%" align="center">6</td>
        <td class="label" width="23%" align="center">7</td>
        <td class="label" width="34%"  align="center">8</td>
        <td class="label" width="34%"  align="center">9</td>
      </tr>
   
  
       <%
    	ArrayList obList=new ArrayList();
        Long cpfAdjOB=null,pensionAdjOB=null,pfAdjOB=null,empSubOB=null,adjPensionContri=null;
        double arrearEmoluemntsAmount=0.00,arrearContriAmount=0.00;
     	boolean arrearflags=false;
		String obFlag="",calYear="";
    	EmployeePensionCardInfo cardInfo=new EmployeePensionCardInfo();
    	String form7NarrationRemarks="",finalRemarks="";
    	for(int j=0;j<pensionDataList.size();j++){
    	cardInfo=(EmployeePensionCardInfo)pensionDataList.get(j);
    	obFlag=cardInfo.getObFlag();
    	shnMonthYear=cardInfo.getShnMnthYear();
    	seperationMnth=personalInfo.getLastatteained();
    	System.out.println("shnMonthYear:"+cardInfo.getMonthyear().substring(3,11)+"seperationMnth:"+seperationMnth.substring(3,11));
    	if(seperationMnth.substring(3,11).equals(cardInfo.getMonthyear().substring(3,11))){
    	if(personalInfo.getRemarks().equals("")){
								remarks="---";
							}else{
								remarks=personalInfo.getRemarks();
								pensionRemarks=remarks;
								remarks="";
								
							}
    	}
  		if(obFlag.equals("Y")){
  			 
	  		 obList=cardInfo.getObList();
	  
             if(obList.size()>3){
             cpfAdjOB=(Long)obList.get(5);
           	 pensionAdjOB=(Long)obList.get(6);
             pfAdjOB=(Long)obList.get(7);
             empSubOB=(Long)obList.get(8);
             adjPensionContri=(Long)obList.get(9);
             }
          
  		}else{
  		adjPensionContri=new Long(0);
  		}
    	//System.out.println("adjPensionContri=============="+adjPensionContri);
    	monthYear=commonUtil.converDBToAppFormat(cardInfo.getMonthyear(),"dd-MMM-yyyy","MMM-yyyy");
		form7NarrationRemarks=cardInfo.getForm7Narration();
    	if(!seperationMnth.equals("---") && seperationMnth.equals(monthYear)){
	   		 seperationFlag=true;
	    }
       	System.out.println("seperationMnth============="+seperationMnth+"monthYear"+monthYear+seperationFlag+"Contribution Amount"+cardInfo.getPensionContribution());
    	
    	if(!cardInfo.getPensionContribution().equals("0.0")){
    		if(!remarks.equals("---") && seperationFlag==true){
    				remarks=pensionRemarks;
    			}else{
    				remarks="---";
    			}
    	}else{
    	
    			if(seperationFlag==true){
    				remarks=remarks;
    			}else if(seperationFlag==false && !remarks.equals("---")){
    				remarks=pensionRemarks;
    			System.out.println("pensionRemarkspensionRemarkspensionRemarks::"+seperationFlag);
    			}else if(!remarks.equals("---") && seperationFlag==true){
    			remarks=pensionRemarks;
    			}else{
    				remarks="---";
    			}
    			
    	}
    	if(!remarks.equals("---")){
    		finalRemarks=form7NarrationRemarks+","+remarks;
    	}else{
    		finalRemarks=form7NarrationRemarks;
    	}
		previsedEmoluments=Math.round(Double.parseDouble(cardInfo.getEmoluments()));
		previsedContri=Math.round(Double.parseDouble(cardInfo.getPensionContribution()));
		monthlyDueEmolumens=Math.round(Double.parseDouble(cardInfo.getDueemoluments()));
		monthlyPensionContri=Double.parseDouble(cardInfo.getDuepensionamount());
    	if(cardInfo.getTransArrearFlag().equals("Y")){
    		arrearEmoluemntsAmount=Double.parseDouble(cardInfo.getOringalArrearAmnt());
    		arrearContriAmount=Double.parseDouble(cardInfo.getOringalArrearContri());
    		previsedEmoluments=previsedEmoluments-arrearEmoluemntsAmount;
    		previsedContri=previsedContri-arrearContriAmount;
     		arrearflags=true;
    		finalRemarks=finalRemarks+" "+cardInfo.getOringalArrearAmnt()+","+cardInfo.getOringalArrearContri();
    	}
		dueTotalEmoluments=previsedEmoluments+monthlyDueEmolumens;
		dueTotalPension=previsedContri+monthlyPensionContri;
    	
    %>

      <tr>
        <td class="Data" width="13%"><%=shnMonthYear%></td>
        <%if(monthYear.equals("Apr-1995")){%>
         <td class="Data" width="30%" align="right">0</td>
         <%}else{%>
       		 <td class="Data" width="30%" align="right"><%=previsedEmoluments%></td>
      	<%}%>
      
         <td class="Data" width="30%" align="right"><%=monthlyDueEmolumens%></td>
        
         <td class="Data" width="30%" align="right"><%=dueTotalEmoluments%></td>
      
        <td class="Data" width="23%" align="right"><%=previsedContri%></td>

         <td class="Data" width="30%" align="right"><%=monthlyPensionContri%></td>
        
        <td class="Data" width="30%" align="right"><%=dueTotalPension%></td>
         <td class="Data" width="23%"><%=0%></td>
        <td class="Data" width="34%" nowrap="nowrap"><%=finalRemarks%></td>
      </tr>
      <%
      	remarks="";
      	if(monthYear.equals("Apr-1995")){
      	   	 totalEmoluments=0;
      	}else{
      	      		 totalEmoluments=totalEmoluments+previsedEmoluments;
      		}
  		 totalPension=totalPension+previsedContri;
  		 dueEmoluments=dueEmoluments+monthlyDueEmolumens;
  		 duePension=duePension+monthlyPensionContri;
  		 dueGrandTotalEml=(dueGrandTotalEml)+dueTotalEmoluments;
  		 dueGrandTotalPension=(dueGrandTotalPension)+dueTotalPension;
  		  dispTotalPension=totalPension;
      
      }
     
      
      
      
      
      %>
   

  <tr>
    <td>&nbsp;</td>
    <td class="Data"><%=totalEmoluments%></td>
    <td class="Data"><%=dueEmoluments%></td>
    <td class="Data"><%=dueGrandTotalEml%></td>
    <td class="Data"><%=totalPension%></td>
    <td class="Data"><%=duePension%></td>
    <td class="Data"><%=dueGrandTotalPension%></td>
    <td><%=0%></td>
    <td>---</td>
  </tr>

 
  <tr  bordercolor="white" >
  <td colspan="10">
  <table width="100%" cellpadding="1"  cellspacing="1" >
   <tr  bordercolor="white">
  <td colspan="10"">
 	Certified that the total amount of contribution indicated in  his / her  card's col.(7)i.e.Rs.<%=dueGrandTotalPension%>  has already been remitted in full in 
  	 F.P. Fund A/C No.10.<br/>
  </td>
    
  </tr>
 <%
  			yearTotalEmoluments=yearTotalEmoluments+totalEmoluments+Math.round(adjPensionContri.longValue()*100/8.33);
  			yearTotalDueEmoluments=yearTotalDueEmoluments+dueEmoluments;
  			yearTotalDuePension=yearTotalDuePension+duePension;
            yearTotalPension=yearTotalPension+adjPensionContri.longValue()+totalPension;
  			totalEmoluments=0;dueEmoluments=0;dueGrandTotalEml=0;totalPension=0;duePension=0;dueGrandTotalPension=0;%>
 <tr  bordercolor="white">
 <td colspan="10"">Certified that the difference between the total of the contribution shown under col.(7) of the above table and that
   	arrived at on the total wages shown in<br/> column (4) at the prescribed rate is solely due to the rounding off of
   	contribution to the nearest rupee Under the rules.</td>
    
  </tr>
   <tr bordercolor="white">
    <td  colspan="10"">&nbsp;</td>

  
  </tr>
    <tr bordercolor="white">
    <td class="Data">Dated :</td>
    <td colspan="6">&nbsp;</td>
    <td align="right" class="Data" nowrap="nowrap">Signature of the employer<br/>with office seal</td>
  </tr>
  </table>
 
    
  </tr>
    <tr  bordercolor="white">
  <td colspan="10" class="Data">
 	(*) PAY REVISION ARREARS WITH EFFECT FROM 01.01.2007, PENSION CONTRIBUTION REMITTED DURING 2009-10 (EXECUTIVES)/ 2010-11 (NON-EXECUTIVES).
  </td>
    
  </tr>
 
   </table>
	
</td>
  </tr>
</table>
</td>
</tr>

</table>
  <%if(size-1!=i){%>
						<br style='page-break-after:always;'>
	<%}%>	
<%totalEmoluments=0.0;totalPension=0.0;seperationFlag=false;remarks="";}%>
				
						<%}}}%>
						
							<table width="100%" border="1" cellspacing="0" cellpadding="0" bordercolor="gray">
					<tr>
					<td colspan="8" align="center" style="label">Year Grand Totals
					</td>
	<tr>
     <td class="label" rowspan="2" align="center">No.Of Subscribers</td>
    <td class="label" colspan="3" align="center">Amount of wages, retaining allowance<br />
          if any &amp; DA paid during the month</td>
    
    <td class="label" colspan="3" align="center">Contribution to Pension Fund</td>
   
    
  </tr>
  <tr>
      	 	<td   align="center" class="label">Pre-revised </td>
      	  	<td   align="center" class="label">Arrears </td>
      	   	<td   align="center" class="label">Total </td>
      	   	<td   align="center" class="label">Pre-revised </td>
      	  	<td   align="center" class="label">Arrears </td>
      	  	<td   align="center" class="label">Total </td>
      </tr>
						      <tr>
   <td class="Data"><%=count%></td>
    <td class="Data"><%=yearTotalEmoluments%></td>
    <td class="Data"><%=yearTotalDueEmoluments%></td>
      <td class="Data"><%=yearTotalEmoluments+yearTotalDueEmoluments%></td>
    <td class="Data"><%=yearTotalPension%></td>
     <td class="Data"><%=yearTotalDuePension%></td>
    <td class="Data"><%=yearTotalPension+yearTotalDuePension%></td>
  </tr>
  </table>				
						
						<%}%>
						
					
						<%%>
	</body>
</html>
