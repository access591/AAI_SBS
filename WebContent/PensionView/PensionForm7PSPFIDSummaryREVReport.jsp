
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page import="aims.bean.*,aims.common.CommonUtil,java.text.DecimalFormat"%>
<%@ page import="aims.common.*" %>
<%@ page import="aims.common.StringUtility" %>


<%			String path = request.getContextPath();
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
	
		String region="",fileHead="",reportType="",fileName="";
		if (request.getAttribute("region") != null) {
			region=(String)request.getAttribute("region");
			if(region.equals("NO-SELECT")){
			fileHead="ALL_REGIONS";
			}else{
			fileHead=region;
			}
		}
		
		if (request.getAttribute("reportType") != null) {
				reportType = (String) request.getAttribute("reportType");
				if (reportType.equals("Excel Sheet")
						|| reportType.equals("ExcelSheet")) {
				
					fileName = "Form_7(PS)_Report_"+fileHead+".xls";
					response.setContentType("application/vnd.ms-excel");
					response.setHeader("Content-Disposition",
							"attachment; filename=" + fileName);
				}
			}
	
	%>
	

		<table width="100%" border="0" cellspacing="0" cellpadding="0">
	    <tr>
			<td>
				<table width="90%" border="0" cellspacing="0" cellpadding="0" align="center">

	
 
  <tr>
    <td>&nbsp;</td>
	
    <td colspan="3"  align="center" class="reportsublabel">FORM-7 PS</td>
  </tr>

    <tr>
    <td>&nbsp;</td>
	
    <td colspan="3"  align="center" class="reportsublabel">YEAR-WISE SUMMARY OF FAMILY PENSION FUND & PENSION CONTRIBUTION</td>
  </tr>
  <tr>
    <td>&nbsp;</td>
    <td width="27%">&nbsp;</td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
  </tr>
  		<%	
		String dispYear="";
		CommonUtil commonUtil=new CommonUtil();
		if(request.getAttribute("dspYear")!=null){
		dispYear=request.getAttribute("dspYear").toString();
		}
		
						ArrayList totalList=new ArrayList();
						ArrayList revisedList=new ArrayList();
						ArrayList dataList=new ArrayList();
						ArrayList pensionDataList=new ArrayList();
						List lsts=new ArrayList();
						HashMap map=new HashMap();
						boolean seperationFlag=false,bifurcatedflag=false;
						int count=0,size=0;
						String pensionno="",dateOfBirth="",bifurcatedYears="",tempbifurcatedYears="",employeeNumber="",arreardispMnthyear="",employeeName="",statutoryRate="",fhname="",dateOfEntitle="",unitRegion="";
						EmployeePersonalInfo personalInfo=new EmployeePersonalInfo();
						String remarks="",arrearRemarks="",monthYear="",temRevisedMnthyear="",shnMonthYear="",pensionRemarks="",rstchkYear="",seperationMnth="";
						DecimalFormat df = new DecimalFormat("#########0");
						if(request.getAttribute("chkYear")!=null){
							rstchkYear=(String)request.getAttribute("chkYear");
						}else{
							rstchkYear="1995";
						}
						 Form7MultipleYearBean form7MulBean=null;
						double totalEmoluments=0.0,totalPension=0.0,tempArrearContriAmount=0.0,dispTotalPension=0.0,dueEmoluments=0.0,duePension=0.0,totalFpfFund=0.0,totEmployeerContri=0.0;
						ArrayList allYearForm8List=new ArrayList();
						if(request.getAttribute("form8List")!=null){
						allYearForm8List=(ArrayList)request.getAttribute("form8List");
							for(int cntYear=0;cntYear<allYearForm8List.size();cntYear++){
							arrearRemarks="";
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
								pensionRemarks=remarks;
								remarks="";
								
							}
							if(personalInfo.getSeperationDate().equals("---"))
							personalInfo.setSeperationDate(personalInfo.getLastatteained());
							if(!personalInfo.getSeperationDate().equals("---")){
								seperationMnth=commonUtil.converDBToAppFormat(personalInfo.getSeperationDate(),"dd-MMM-yyyy","MMM-yyyy");
							}else{
								seperationMnth="---";
							}
						
							pensionno=personalInfo.getPensionNo();
							employeeNumber=personalInfo.getEmployeeNumber();
							employeeName=personalInfo.getEmployeeName().toUpperCase();
							if(rstchkYear.equals("1995")){
	       					    statutoryRate="1.16% and 8.33%";
							}else if (!rstchkYear.equals("1995")){
								statutoryRate="8.33%";
							}
							fhname=personalInfo.getFhName().toUpperCase();
							if(!personalInfo.getDateOfEntitle().equals("---")){
							dateOfEntitle=personalInfo.getDateOfEntitle();
							}else{
							dateOfEntitle="01-Apr-1995";
							}
							dateOfBirth=personalInfo.getDateOfBirth();
							unitRegion=personalInfo.getRegion().toUpperCase()+"/"+personalInfo.getAirportCode().toUpperCase();
							pensionDataList=personalInfo.getPensionList();
							boolean revisedflag=false;	
							StringBuffer buffer=null;
							String mnthofDOE="",yearOfDOE="";
							mnthofDOE=commonUtil.converDBToAppFormat(dateOfEntitle,"dd-MMM-yyyy","MM");
							yearOfDOE=commonUtil.converDBToAppFormat(dateOfEntitle,"dd-MMM-yyyy","yyyy");
							if(pensionDataList.size()!=0){
    							EmployeePensionCardInfo cardInfo=new EmployeePensionCardInfo();
    							String form7NarrationRemarks="",finalRemarks="";
    							int lstcurrentYear=0;
    							String displyMnthYear="",currentYear="",nextYear="";
    							boolean flag=false;
    							buffer=new StringBuffer();
    							 	Long cpfAdjOB=null,pensionAdjOB=null,pfAdjOB=null,empSubOB=null,adjPensionContri=null;
									ArrayList obList=new ArrayList();
  									String obFlag="",calYear="",currentmonth="";
  									double arrearEmoluemntsAmount=0.00,arrearContriAmount=0.00;
     								boolean arrearflags=false;
    							for(int j=0;j<pensionDataList.size();j++){
									    	cardInfo=(EmployeePensionCardInfo)pensionDataList.get(j);
									    	monthYear=commonUtil.converDBToAppFormat(cardInfo.getMonthyear(),"dd-MMM-yyyy","MMM-yyyy");
									    	
									    	if(flag==false){
									    		
									    		currentYear=commonUtil.converDBToAppFormat(cardInfo.getMonthyear(),"dd-MMM-yyyy","yyyy");
									    		currentmonth=commonUtil.converDBToAppFormat(cardInfo.getMonthyear(),"dd-MMM-yyyy","MM");
									    		if(Integer.parseInt(yearOfDOE)==Integer.parseInt(currentYear) && ((Integer.parseInt(mnthofDOE)==Integer.parseInt(currentmonth))&& (Integer.parseInt(mnthofDOE)>=1 && Integer.parseInt(mnthofDOE)<=3)) ){
									    			currentYear=Integer.toString(Integer.parseInt(currentYear)-1);
									    		}
									    		nextYear=Integer.toString(Integer.parseInt(currentYear)+1);
									    		displyMnthYear=currentYear+"-"+commonUtil.converDBToAppFormat(nextYear,"yyyy","yy");
									    		lstcurrentYear=Integer.parseInt(currentYear);
									    		flag=true;
									    	}
    										
    										
											form7NarrationRemarks=cardInfo.getForm7Narration();
											
									    	if(!seperationMnth.equals("---") && seperationMnth.equals(monthYear)){
										   		 seperationFlag=true;
										    }
									       
									    	shnMonthYear=cardInfo.getShnMnthYear();
									    	//System.out.println("cardInfo.getPensionContribution()===="+cardInfo.getPensionContribution()+"cardInfo.getForm7Narration()"+cardInfo.getForm7Narration());
									    	if(!cardInfo.getPensionContribution().equals("0.0")){
									    	//System.out.println("cardInfo.getForm7Narration()1"+cardInfo.getForm7Narration());
									    		if(!remarks.equals("---") && seperationFlag==true){
									    				remarks=pensionRemarks;
									    			}else{
									    				remarks="---";
									    			}
									    	}else{
									    	//System.out.println("cardInfo.getForm7Narration()2"+cardInfo.getForm7Narration());
									    			if(seperationFlag==true){
									    				remarks=pensionRemarks;
									    				//System.out.println("cardInfo.getForm7Narration()3"+cardInfo.getForm7Narration());
									    			}else if(seperationFlag==false && !remarks.equals("---")){
									    				remarks=pensionRemarks;
									    			//System.out.println("cardInfo.getForm7Narration()4"+cardInfo.getForm7Narration()+"pensionRemarks"+pensionRemarks);
									    			}else{
									    			//System.out.println("cardInfo.getForm7Narration()5"+cardInfo.getForm7Narration());
									    				remarks="---";
									    			}
									    			
									    	}
									    	
									    	if(!remarks.equals("---")){
									    	
									    	
									    boolean remarksFlag = false;
									    if(!personalInfo.getSeperationDate().equals("---")){
									    //System.out.println("seperationMnth:"+seperationMnth+personalInfo.getSeperationDate()+monthYear);
									    //System.out.println("finalRemarks::::::::::::::"+finalRemarks+form7NarrationRemarks+remarks);
									    if(seperationMnth.equals(monthYear)){
									     System.out.println("finalRemarks::::::::::::::==============.......;"+"finalRemarks"+finalRemarks+"form7NarrationRemarks"+form7NarrationRemarks+"remarks"+remarks);
									    	 finalRemarks=finalRemarks+" "+form7NarrationRemarks+","+remarks;
									    	 }else{
									    	 //finalRemarks=finalRemarks+" "+form7NarrationRemarks;
									    	 remarks="---";
									    	 }
									    }
									     if((remarks.indexOf("Death Case & PF settled")!=-1 ||remarks.indexOf("Retirement Case & PF settled")!=-1||remarks.indexOf("Retirement Case & PF settled")!=-1||remarks.indexOf("Attained 58 years")!=-1)){
									    	     remarksFlag=true;
									    	//finalRemarks=form7NarrationRemarks+","+remarks;
									    	}
									    	//else{
									    	 if(!remarksFlag ){
									    	 //System.out.println("remarks======="+remarks);
									    	 if(remarks.equals("---"))
									    	 remarks="";
									    	 //if(form7NarrationRemarks.equals("---"))
									    	 //form7NarrationRemarks=" ";
									    	 //if(finalRemarks.indexOf("---")!=-1)
									    	 //finalRemarks="";
									    	 //if(seperationMnth.equals(monthYear)){
									    	 finalRemarks=finalRemarks+" "+form7NarrationRemarks+","+remarks;
									    	// }else{
									    	 //finalRemarks=finalRemarks+" "+form7NarrationRemarks;
									    	// }
									    		}
									    		//}
									    		
									    	}else{
									    	System.out.println("cardInfo.getForm7Narration()7"+cardInfo.getForm7Narration());
									    			if(form7NarrationRemarks.equals("---")){
									    				form7NarrationRemarks="";
									    			}
									    			if(finalRemarks.equals("")){
									    				finalRemarks=form7NarrationRemarks;
									    			}else{
									    				finalRemarks=finalRemarks+","+form7NarrationRemarks;
									    			}
									    			
									    	}
    								
    										obFlag=cardInfo.getObFlag();
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
									      	remarks="";
									      	if(monthYear.equals("Apr-1995")){
									      	   	 totalEmoluments=0;
									      	}else{
									      		 totalEmoluments=totalEmoluments+Math.round(Double.parseDouble(cardInfo.getEmoluments()));
									      	}
									      	if(revisedflag==false && Double.parseDouble(cardInfo.getDueemoluments())!=0.00){
									      		revisedflag=true;
									      		temRevisedMnthyear=displyMnthYear;
									      	}
									      			
									      	 
									  		totalPension=totalPension+Math.round(Double.parseDouble(cardInfo.getPensionContribution()));
									  		  //ArrearBreakUp to be accepted from Jan 2007 onwards Only
									  		  //ArrearBreakUp to be accepted from 95 onwards  request of Sehgal Jul2013
									  		   	if((Integer.parseInt(currentYear)>=1998) &&cardInfo.getTransArrearFlag().equals("Y")){
    												arrearEmoluemntsAmount=arrearEmoluemntsAmount+Double.parseDouble(cardInfo.getOringalArrearAmnt());
    												arrearContriAmount=arrearContriAmount+Double.parseDouble(cardInfo.getOringalArrearContri());
    												totalPension=totalPension-Double.parseDouble(cardInfo.getOringalArrearContri());
     												arrearflags=true;
    												arrearRemarks=arrearRemarks+cardInfo.getOringalArrearAmnt()+",   "+cardInfo.getOringalArrearContri()+"<br/> Pension contribution of Rs."+cardInfo.getOringalArrearContri()+"/- deducted from Pay arrear <br/>in "+monthYear+"(shown in Pre-revised Col.4) bifurcated in <br/>";
    												}
									  		dueEmoluments=dueEmoluments+Math.round(Double.parseDouble(cardInfo.getDueemoluments()));
									   	    duePension=duePension+Math.round(Double.parseDouble(cardInfo.getDuepensionamount()));
									  		totalFpfFund=totalFpfFund+Math.round(Double.parseDouble(cardInfo.getFpfFund()));
									  		dispTotalPension=totalPension;
									  		
      
      }
 		if (adjPensionContri.longValue()!=0.00) {
 			totalEmoluments=totalEmoluments+Math.round(adjPensionContri.longValue()*100/8.33);
 			totalPension=totalPension+adjPensionContri.longValue();
 			dispTotalPension=dispTotalPension+adjPensionContri.longValue();
 		}
 
	
        
 	    if(arrearflags==true){
 	    	arreardispMnthyear=displyMnthYear;
 	    	tempArrearContriAmount=arrearContriAmount;
      		totalEmoluments=totalEmoluments-arrearEmoluemntsAmount;
    		dispTotalPension=dispTotalPension-arrearContriAmount;
    		
    		finalRemarks=finalRemarks+arrearRemarks;
    		tempbifurcatedYears="";
        }
        

        
   
      buffer.append(displyMnthYear);
      buffer.append("@");
      buffer.append(totalEmoluments+dueEmoluments);
      buffer.append("@");
      buffer.append(dispTotalPension+duePension);
      buffer.append("@");
      if(finalRemarks.equals("")){
	      finalRemarks="---";
      }
      System.out.println("totalFpfFund"+totalFpfFund+finalRemarks);
      buffer.append(finalRemarks);
      buffer.append("@");
      buffer.append(totalFpfFund);
      buffer.append("@");
      buffer.append(totEmployeerContri=totalPension-totalFpfFund*2);
      buffer.append("@");
      buffer.append(dueEmoluments);
      buffer.append("@");
      buffer.append(duePension);
      
	  totalEmoluments=0.0;totalPension=0.0;dueEmoluments=0.00;duePension=0.00;seperationFlag=false;remarks="";pensionRemarks="";totalFpfFund=0.0;finalRemarks="";form7NarrationRemarks="";
	  totalList.add(buffer.toString());
	  bifurcatedflag=false;
	  map.put(Integer.toString(lstcurrentYear),buffer.toString());
	  buffer=null;
	}
	
  
	
	}} 	  
	}
	
		HashMapComparable mapcomp=new HashMapComparable();
		lsts=mapcomp.sortingHashMap(map);
		totalList.clear();
		totalList.addAll(lsts);
	%>
			
  <tr>
    <td colspan="4"><table width="95%" border="1" bordercolor="gray" cellspacing="0" cellpadding="0" align="center">
      <tr>
        <td  class="label">1. Account No.: </td>
        <td  class="Data">DL/36478/<%=pensionno%></td>
       	<td  class="label">6. Emp No.: </td>
        <td  class="Data"><%=employeeNumber%></td>
      </tr>
 	  <tr>
        <td nowrap="nowrap" class="label">2. Name/Surname:</td>
        <td class="Data"><%=employeeName%></td>
        <td class="label">7. Statutory Rate of Contribution </td>
        <td class="Data"><%=statutoryRate%></td>
      </tr>
      <tr>
        <td class="label">3. Father's/Husband's Name:</td>
        <td class="Data"><%=fhname%></td>
        <td class="label">8. Date of Commencement of<br/> membership of EPS :</td>
        <td class="Data"><%=dateOfEntitle%></td>
      </tr>
       <tr>
        
        <td nowrap="nowrap" class="label">4. Date Of Birth:</td>
        <td class="Data"><%=dateOfBirth%></td>
         <td class="label">9.Unit:</td>
        <td class="Data" nowrap="nowrap"><%=unitRegion%></td>
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
    <td colspan="4"><table width="95%" border="1" bordercolor="gray" cellpadding="2" cellspacing="0" align="center">
 
      <tr>
        <td width="10%" align="center" class="label" rowspan="2" >Year</td>
        <td width="20%" align="center" class="label" colspan="2" >Family Pension Fund</td>
       	 <td width="20%" align="center" colspan="2"class="label">Pension Contribution</td>
          <td width="10%" align="center" rowspan="2" class="label">Total</td>
         <td width="40%" align="center" rowspan="2" class="label">Remarks</td>
      </tr>
      <tr>
      	<td>Employee</td>
      	<td>Employer</td>
      	<td>Pre-revised</td>
      	<td>Arrears</td>
      </tr>
      <tr>
        <td class="label" width="10%" align="center">1</td>
        <td class="label" width="10%" align="center">2</td>
        <td class="label" width="10%" align="center">3</td>
        <td class="label" width="10%" align="center">4</td>
        <td class="label" width="10%"  align="center">5</td>
         <td class="label" width="10%"  align="center">6</td>
        <td class="label" width="40%"  align="center">7</td>
      </tr>
      <%
      String informat="";
      String formattedYear="",dispFinalremarks="",bifurcatedYear="";
      String[] finalYearDataStr=null;
      double grandFpfEmployeeContr=0.0,grandArrearsEmpContr=0.0,grandFpfEmployerContr=0.0,grandPensionContribution=0.0,grandTotalPC=0.0;
      boolean arrearData=false;
      double grandDuePensionContr=0.0,grandEmoluments=0.0;
      	for(int lst=0;lst<totalList.size();lst++){
      		Object o=(Object)totalList.get(lst);
      		informat=o.toString();
      		
      		finalYearDataStr=informat.split("@");
      		if(finalYearDataStr[0].indexOf("=")!=-1){
      			String[] finalYearDataLst=finalYearDataStr[0].split("=");
      			formattedYear=finalYearDataLst[1];
      		}else{
      				formattedYear=finalYearDataStr[0];
      		}
      		if(arreardispMnthyear.equals(formattedYear)){
      		arrearData=true;
      		}
      		grandFpfEmployeeContr=grandFpfEmployeeContr+Double.parseDouble(finalYearDataStr[4]);
      		grandFpfEmployerContr=grandFpfEmployerContr+Double.parseDouble(finalYearDataStr[4]);
      		grandPensionContribution=grandPensionContribution+Double.parseDouble(finalYearDataStr[5]);
      		
      		 grandArrearsEmpContr=grandArrearsEmpContr+Double.parseDouble(finalYearDataStr[7]);
      		
      		grandTotalPC=(grandFpfEmployeeContr+grandFpfEmployeeContr+grandPensionContribution+grandArrearsEmpContr);
      		
      		        if(Double.parseDouble(finalYearDataStr[7].trim())!=0.0){
      		       
            				if(bifurcatedYears.equals("")){
        		  				bifurcatedYears=formattedYear;
        		  				
        					}else{
        	      				bifurcatedYears=bifurcatedYears+" ,"+formattedYear;
        				}

        			}
      
        if(arrearData==true){
        	dispFinalremarks=finalYearDataStr[3];
        }else{
        	dispFinalremarks=finalYearDataStr[3];
        }
        
      
        System.out.println(finalYearDataStr[4]+finalYearDataStr[5]+finalYearDataStr[7]);
      %>
    <tr>
        <td class="label" width="10%"><%=formattedYear%></td>
      
         <td class="NumData" width="10%"><%=finalYearDataStr[4]%></td>
      
        <td class="NumData" width="10%" ><%=finalYearDataStr[4]%></td>
         <td class="NumData" width="10%" ><%=finalYearDataStr[5]%></td>
         
          <td class="NumData" width="10%" ><%=finalYearDataStr[7]%></td>
         
        <td class="Data" width="10%"><%=Double.parseDouble(finalYearDataStr[4])+Double.parseDouble(finalYearDataStr[4])+Double.parseDouble(finalYearDataStr[5])+Double.parseDouble(finalYearDataStr[7])%></td>
        <td class="Data" width="40%" style="font-size:9px" ><%=StringUtility.replace(dispFinalremarks.toCharArray(),",".toCharArray(),"")%></td>
      </tr>
 <%}%>

      	 <td class="Data" width="10%">Total</td>
         <td class="Data" width="10%" align="right" > <%=df.format(grandFpfEmployeeContr)%></td>
      
        <td class="Data" width="10%" align="right"><%=df.format(grandFpfEmployerContr)%></td>
         <td class="Data" width="10%"><%=df.format(grandPensionContribution)%></td>
          <td class="Data" width="10%"><%=df.format(grandArrearsEmpContr)%></td>
        <td class="Data" width="50%" colspan="2"><%=df.format(grandTotalPC)%></td>
       
      </tr>

    

   </table>
	
						
					
</td>
  </tr>
  	<%}%>
  	<tr>
  		<td colspan="5">&nbsp;</td>
  	</tr>
  	 <tr>
    <td colspan="4"><table width="95%" border="0"  cellspacing="0" cellpadding="0" align="center">
     
    <tr bordercolor="white">
    <td class="Data">Dated :</td>
    <td colspan="2">&nbsp;</td>
    <td align="right" class="Data" nowrap="nowrap">Signature of the employer<br/>with office seal</td>
  </tr>
  </table>
  </td>
  </tr>
</table>
</td>
</tr>

</table>

	</body>
</html>
