<%@ page language="java" import="aims.service.FinancialService,java.util.HashMap,aims.service.SBSFinancialReportService" pageEncoding="UTF-8"%>
<%
 FinancialService finance = new FinancialService();
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
ArrayList a=new ArrayList();
String dispDesignation="";
System.out.println("this is starting...");
 //String interestCalc=request.getAttribute("interestCalcfinal").toString();
 //System.out.println("the values...."+interestCalc);
 //String finalintrdate=request.getAttribute("finalintdate").toString();
 //System.out.println("the values...."+finalintrdate);
 //String reIntrestcalcDate=request.getAttribute("reIntrestcalcDate").toString();
 //System.out.println("reIntrestcalcDate"+reIntrestcalcDate);
 //String station=request.getAttribute("regionStr").toString();
 //String region=request.getAttribute("regionStr").toString();
 //String ComputerName = session.getAttribute("computername").toString();
 //String username = session.getAttribute("userid").toString();
%>
<%@ page import="aims.common.*"%>
<%@ page import="java.text.DecimalFormat"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="aims.bean.*"%>
<%@ page import="aims.action.FinanceServlet" %>

<html>
  <head>
   <LINK rel="stylesheet" href="<%=basePath%>PensionView/css/aai.css" type="text/css">
    <script type="text/javascript">
    function deleteTransaction(monthyear,cpfaccno,region,airportcode){
  //	alert("month year"+monthyear +"cpfaccno " +cpfaccno +"region" +region +"airportcode"+airportcode);
    var answer =confirm('Are you sure, do you want  delete this record');
    var pfid=document.forms[0].pfid.value;
    var page="PensionContribution";
   
    var mappingFlag="true";
	if(answer){
	//alert("inside true");
    document.forms[0].action="<%=basePath%>reportservlet?method=deleteTransactionData&cpfaccno="+cpfaccno+"&monthyear="+monthyear+"&region="+region+"&pfid="+pfid+"&page="+page+"&airportcode="+airportcode+"&mappingFlag="+mappingFlag;;
	document.forms[0].method="post";
	//document.forms[0].submit();
    }
    }  
    function showIntrest(intrest,pensionno,employeenm,employeeno,designation,difftotals,revisedpc,difcontri){
    alert("hiiiii");
    
     document.forms[0].action="<%=basePath%>reportservlet?method=saveIntrest&intrest="+intrest+"&pensionno="+pensionno+"&employeenm="+employeenm+"&designation="+designation+"&station="+station+"&region="+region+"&interestCalc="+interestCalc+"&difftotals="+difftotals+"&revisedpc="+revisedpc+"&difcontri="+difcontri;
	document.forms[0].method="post";
	document.forms[0].submit();
    }   
    function test(){
       //alert('This pension contribution report');
    }
  
    </script>
  </head>
  <body onload="javascript:test()">
<%!
	ArrayList blockList=new ArrayList();
	String breakYear="";
%>
  <form action="method">
			<table width="100%" border="0" 	 align="center" cellpadding="0" cellspacing="0">
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
               String headingsub="Opening Corpus -FOR MEMBERS FOR THE YEAR ";
                %>
							<tr>
						<td>
								<table border="0"    cellpadding="2" cellspacing="0" width="100%" align="center">
								<tr>
								<td align="center" class="ReportHeading" colspan="2"> <%=headingsub%>  01.01.2007 To 31.03.2019</td>	
								</tr>
								</table>
								</td>
							</tr>
							
							
							
				
				
				
				<tr>
					<td  colspan="5" >
					
						<table  class="sample"    cellpadding="2" cellspacing="0" width="100%" align="center" >
						<tr>
								<td colspan="18">
									<table align="center" width="100%" cellpadding="0" cellspacing="0" class="sample">
							<tr>
								<td class="HighlightData" > PFID</td>
								<td class="HighlightData">Emolument</td>
								<td class="HighlightData">Adjusted Emoluments </td>
								<td class="HighlightData">AAI SBS Contribution </td>
							
								<td class="HighlightData">Interest</td>
								<td class="HighlightData">Total Interest and SBS Contribution  </td>
								
							</tr>
							
	  <%
  	 ArrayList PensionContributionList=new ArrayList();
  	 ArrayList pensionList=new ArrayList();
  	 CommonUtil commonUtil=new CommonUtil();
  	 boolean countFlag=true;
  	 double sbsRate=10;
	 String fullWthrOptionDesc="",genderDescr="",mStatusDec="";
  	 String employeeNm="",pensionNo="",doj="",dob="",cpfacno="",employeeNO="",designation="",fhName="",gender="",fileName="",mStatus="",discipline="",newemployeecode="",docofEDCR="";
  	 String reportType ="",chkRegionString="",dispSignPath="",dispSignStation="",chkStationString="",chkBulkPrint="",whetherOption="",dateOfEntitle="",empSerialNo="";
  	String mangerName="",ntIncrement="";
  	 String getEditpensionno="";
  	 double pctotal=0.0,recoverydifftotals=0.0;
  	  String recoverieTable="";
	  	 if (request.getAttribute("reportType") != null) {
				reportType = (String) request.getAttribute("reportType");
				if (reportType.equals("Excel Sheet")
						|| reportType.equals("ExcelSheet")) {
				
					fileName = "Pension_Contribution_report.xls";
					response.setContentType("application/vnd.ms-excel");
					response.setHeader("Content-Disposition",
							"attachment; filename=" + fileName);
				}
                if (reportType.equals("DBF")) {
			
					fileName = "Pension_Contribution_report.dbf";
					response.setContentType("application/x-wais-source");
					response.setHeader("Content-Disposition",
							"attachment; filename=" + fileName);
				}
			}
		 if (request.getAttribute("pctotal") != null) {
			 pctotal=Double.parseDouble(request.getAttribute("pctotal").toString());
		 }
		 if (request.getAttribute("intrest") != null) {
			 recoverydifftotals=Double.parseDouble(request.getAttribute("intrest").toString());
		 }
		 if (request.getAttribute("recoverieTable") != null) {
			 recoverieTable=request.getAttribute("recoverieTable").toString();
			 }
		 double interestforNoofMonths=0;
		 if (request.getAttribute("interestforNoofMonths") != null) {
			 interestforNoofMonths=Double.parseDouble(request.getAttribute("interestforNoofMonths").toString());
			 System.out.println(interestforNoofMonths);
		 }
		 if (request.getAttribute("getEditPenno") != null) {
			 getEditpensionno=request.getAttribute("getEditPenno").toString();			 
		 }else{
		 getEditpensionno="";
		 }
		 double interestforfinalsettleMonths=0;
		 if (request.getAttribute("interestforfinalsettleMonths") != null) {
			 interestforfinalsettleMonths=Double.parseDouble(request.getAttribute("interestforfinalsettleMonths").toString());
			 System.out.println(interestforfinalsettleMonths);
		 }
	 int size=0;
 	 PensionContributionList=(ArrayList)request.getAttribute("penContrList");
 	 String cntFlag="",buildFinyear="",tempBuildFinYear="";
 	  if(request.getAttribute("blkprintflag")!=null){
      chkBulkPrint=(String)request.getAttribute("blkprintflag");
    }
     if(request.getAttribute("regionStr")!=null){
    	chkRegionString=(String)request.getAttribute("regionStr");
    }
    if(request.getAttribute("stationStr")!=null){
      chkStationString=(String)request.getAttribute("stationStr");
    }
    if(PensionContributionList.size()>0){
 	 for(int i=0;i<PensionContributionList.size();i++){
			PensionContBean contr=(PensionContBean)PensionContributionList.get(i);
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
			tempBuildFinYear=commonUtil.converDBToAppFormat(dateOfEntitle,"dd-MMM-yyyy","yyyy");
			buildFinyear=tempBuildFinYear+"-"+commonUtil.converDBToAppFormat(Integer.toString(Integer.parseInt(tempBuildFinYear)+1),"yyyy","yy");
			discipline=contr.getDepartment();
			cntFlag=contr.getCountFlag();
			pensionList=contr.getEmpPensionList();
			
			blockList=contr.getBlockList();
			 size=pensionList.size();
			// System.out.println("size======================"+size);
  			if(size!=0){
  			boolean signatureFlag=false;
  			   if(chkBulkPrint.equals("true")){
   		   			 if(chkRegionString.equals("North Region")){
   		   			signatureFlag=true;
   	    				dispSignStation="";
   	    				mangerName="(Anil Kumar Jain)";
   	     				dispDesignation="Asstt.General Manager(Fin), AAI, NR";
		    			dispSignPath=basePath+"PensionView/images/signatures/AKJain.gif";
		    		 }else if(chkRegionString.equals("South Region")){
		    			signatureFlag=true;
		    			dispSignStation="South Region";
		    			dispDesignation="Deputy General Manager(F&A)";
		    			dispSignPath=basePath+"PensionView/images/signatures/Parimala.gif";	
		    		 }else if(chkRegionString.equals("North-East Region")){
		    			signatureFlag=true;
		    			dispSignStation="";
		    			mangerName="(G.S Mohapatra)";
		     			dispDesignation="Joint General Manager(Fin), AAI, NER,Guwahati";
		    			dispSignPath=basePath+"PensionView/images/signatures/G.SMohapatra.gif";
		    		 }else if(chkRegionString.equals("RAUSAP")){
		      			signatureFlag=true;
		      			dispSignStation="";
		      			mangerName="(Monika Dembla)";
		      			dispDesignation="Manager(F & A), AAI, RAU,SAP ";
		      			dispSignPath=basePath+"PensionView/images/signatures/Monika Dembla.gif";	
   		 			}else if(chkRegionString.equals("West Region")){
		    			signatureFlag=true;
		    			dispSignStation="";
		    			mangerName="(Shri S H Kaswankar)";
     					dispDesignation="Sr. Manager(Fin), AAI, WR, Mumbai";
		    			dispSignPath=basePath+"PensionView/images/signatures/Kaswankar.gif";	
   		 			}else if(chkRegionString.equals("CHQIAD")){
    					if(chkStationString.toLowerCase().equals("IGICargo IAD".toLowerCase())){
     						signatureFlag=true;
     						dispSignStation="";
     						mangerName="(Arun Kumar)";
     						dispDesignation="Sr. Manager(F&A), AAI,IGICargo IAD";
     						dispSignPath=basePath+"PensionView/images/signatures/IAD_Arun Kumar.gif";	
    		 			}else if(chkStationString.toLowerCase().equals("IGI IAD".toLowerCase())){
		     				signatureFlag=true;
		     				dispSignStation="";
		     				mangerName="(Arun Kumar)";
		     				dispDesignation="Sr. Manager(F&A), AAI,IGI IAD";
		     				dispSignPath=basePath+"PensionView/images/signatures/IAD_Arun Kumar.gif";	
    		 			}
    			  }
   		 		}
  %>
    <%!
		String getBlockYear(String year)
		{
		String bYear="";
		
		for(int by=0;by<blockList.size();by++){
			bYear=(String)blockList.get(by);
			String[] bDate=bYear.split(",");
			
			if(year.equals(bDate[1])){
				breakYear=bDate[1];
				breakYear=bYear;
				break;
			}else{
				breakYear="03-96";
			}
		}
	//	System.out.println("breakYear"+breakYear);
		//blockList.remove(breakYear);
		return breakYear;
		}
%>
					
							<%
							
							HashMap product=new HashMap();
							product.put("APR","11");
							product.put("MAY","10");
							product.put("JUN","9");
							product.put("JUL","8");
							product.put("AUG","7");
							product.put("SEP","6");
							product.put("OCT","5");
							product.put("NOV","4");
							product.put("DEC","3");
							product.put("JAN","2");
							product.put("FEB","1");
							product.put("MAR","0");
							
							
						HashMap intrestrate=new HashMap();
						intrestrate.put("2006-2007","7.98");
						intrestrate.put("2007-2008","7.96");
						intrestrate.put("2008-2009","7.01");
						intrestrate.put("2009-2010","7.83");
						intrestrate.put("2010-2011","7.99");
						intrestrate.put("2011-2012","8.54");
						intrestrate.put("2012-2013","7.96");
						intrestrate.put("2013-2014","8.80");
						intrestrate.put("2014-2015","7.74");
						intrestrate.put("2015-2016","7.47");
						intrestrate.put("2016-2017","6.68");
						intrestrate.put("2017-2018","7.40");
						intrestrate.put("2018-2019","7.35");
						intrestrate.put("2019-2020","0");
						intrestrate.put("2020-2021","0");
						
						
						
						
							
								double totalEmoluments=0.0,pfStaturary=0.0,totalPension=0.0,empVpf=0.0,principle=0.0,interest=0.0,pfContribution=0.0,adjustmentemoluments=0.0,totSbsContr=0.0,totNTIRecovery=0.0,totAdjSbsContri=0.0,totGrossContri=0.0,totintrest=0.0,totTaxIncome=0.0,totTaxIncomeSBS=0.0,totcl=0.0,totClIntrest=0.0,totAprList=0.0,grandpercentageintrest=0.0,grandpercentageadj=0.0;
							double obIntrest=0.0;
							String monthProduct="0";
							double grandEmoluments=0.0,grandCPF=0.0,grandPension=0.0,grandPFContribution=0.0,intrestvalue=0.0,sbscont=0.0,NTIRecovery=0.0,taxbleIncome=0.0,taxbleIncomeSBS=0.0,adjSbsContri=0.0,grossSbsContri=0.0,grandAdjuscontr=0.0,grandSbsContr=0.0,grandtotintrest=0.0;
							double cpfInterest=0.0,pensionInterest=0.0,pfContributionInterest=0.0;
							double grandCPFInterest=0.0,grandPensionInterest=0.0,grandPFContributionInterest=0.0;
							double cumPFStatury=0.0,cumPension=0.0,cumPfContribution=0.0;
							double cpfOpeningBalance=0.0,penOpeningBalance=0.0,pfOpeningBalance=0.0;
							double percentage=0.0;
							double aprlEmoluments=0.0,adjaprEmoluments=0.0,aprSbscont=0.0,aprNTIrecovery=0.0,aprAdjSbscontri=0.0,aprGrossConri=0.0;
							boolean openFlag=false;
							int count=0;
							int chkMnths=0;
							boolean flag=false;
							String findMnt="";
							int countMnts=0;
							DecimalFormat df = new DecimalFormat("#########0");
							DecimalFormat df1 = new DecimalFormat("#########0.00");
							String dispFromYear="",dispToYear="",totalYear="";
							String finTotalYear="";
							boolean dispYearFlag=false;
							double rateOfInterest=0;
							String monthInfo="",getMnthYear="";
							int noofmonths=0;
							for(int j=0;j<pensionList.size();j++){
								TempPensionTransBean bean=(TempPensionTransBean)pensionList.get(j);
								if(bean!=null){
								String dateMontyYear=bean.getMonthyear();
								
								//System.out.println("================="+dateMontyYear+":::::::::::::"+dispFromYear);
								
								if(dispYearFlag==false){
									if(dispFromYear.equals("")){
										dispFromYear=commonUtil.converDBToAppFormat(dateMontyYear,"dd-MMM-yyyy","yy");
										
									}
								
									getMnthYear=commonUtil.converDBToAppFormat(dateMontyYear,"dd-MMM-yyyy","MM-yy");
								
									String monthInterestInfo=getBlockYear(getMnthYear);
									String [] monthInterestList=monthInterestInfo.split(",");
									if(monthInterestList.length==2){
											monthInfo=monthInterestList[1];
									
									rateOfInterest=new Double(monthInterestList[0]).doubleValue();
									
									}
							
									dispYearFlag=true;
								
									breakYear="";
								}
								
								noofmonths++;
						        String monthYear=bean.getMonthyear().substring(dateMontyYear.indexOf("-")+1,dateMontyYear.length());
						       sbscont= Math.round(Double.parseDouble(bean.getEmoluments())*0.1);
						       if(ntIncrement.equals("Yes")){
						       NTIRecovery=Math.round(Double.parseDouble(bean.getEmoluments())*0.01);
						      }
						      adjSbsContri=sbscont-NTIRecovery;
						       // if(bean.getInterestRate()!=null || !bean.getInterestRate().equals(" ")){
						   //     	rateOfInterest=new Double(bean.getInterestRate()).doubleValue();
						     //   }
						        findMnt=commonUtil.converDBToAppFormat(bean.getMonthyear(),"dd-MMM-yyyy","MM-yy");
						     
						 //       System.out.println("findMnt==="+findMnt+"monthInfo==="+monthInfo+"dispYearFlag***********************"+dispYearFlag);
						       
								if(findMnt.equals(monthInfo)){
									flag=true;
								
									breakYear="";
								}
						
								count++;
								  	finTotalYear=bean.getFinYear();
								  	
						if(Double.parseDouble(bean.getEmoluments())!=0.0){
							  	   intrestvalue=Math.round(((adjSbsContri)*Double.parseDouble((intrestrate.get(finTotalYear)).toString())/100)*(Double.parseDouble(product.get(monthYear.substring(0,3)).toString())/12));
						      
						   //  System.out.println("intrest value===================="+Math.round(((Double.parseDouble(bean.getEmoluments())*0.1)*Double.parseDouble((intrestrate.get(finTotalYear)).toString())/100)*(Double.parseDouble(product.get(monthYear.substring(0,3)).toString())/12)));
						      
						      
						      monthProduct=product.get(monthYear.substring(0,3)).toString();
						      }
						       // grossSbsContri=adjSbsContri+intrestvalue;
								 if(bean.getDeputationFlag().equals("Y")){
						       sbscont=0;
						       intrestvalue=0;
						       adjSbsContri=0;
						       NTIRecovery=0;
						       }
						       grossSbsContri=adjSbsContri+intrestvalue;
								totalEmoluments= new Double(df.format(totalEmoluments+Math.round(Double.parseDouble(bean.getEmoluments())))).doubleValue();
							//	pfStaturary= new Double(df.format(pfStaturary+Math.round(Double.parseDouble(bean.getCpf())))).doubleValue();
							//	cumPFStatury=cumPFStatury+pfStaturary;
								adjustmentemoluments=new Double(df.format(adjustmentemoluments+Math.round(Double.parseDouble(bean.getEmoluments())))).doubleValue();
								totSbsContr=new Double(df.format(totSbsContr+sbscont)).doubleValue();
								totNTIRecovery=new Double(df.format(totNTIRecovery+NTIRecovery)).doubleValue();
								totAdjSbsContri=new Double(df.format(totAdjSbsContri+adjSbsContri)).doubleValue();
								totintrest=new Double(df.format(totintrest+intrestvalue)).doubleValue();
								totGrossContri=new Double(df.format(totGrossContri+grossSbsContri)).doubleValue();
							//	empVpf = new Double(df.format(empVpf+Math.round(Double.parseDouble(bean.getEmpVPF())))).doubleValue();
							//	principle =new Double(df.format(principle+Math.round(Double.parseDouble(bean.getEmpAdvRec())))).doubleValue();
								interest =new Double(df.format(interest+Math.round(Double.parseDouble(bean.getEmpInrstRec())))).doubleValue();
								totalPension=new Double(df.format(totalPension+Math.round(Double.parseDouble(bean.getPensionContr())))).doubleValue();
								//cumPension=cumPension+totalPension;
						      //  pfContribution= new Double(df.format(pfContribution+Math.round( Double.parseDouble(bean.getAaiPFCont())))).doubleValue();
						      //  cumPfContribution=cumPfContribution+pfContribution;
						       
						   
							
							%>
						
					         <% 
					   //      System.out.println(bean.getRecordCount());
					   //System.out.println("=================="+bean.getMonthyear()+bean.getRecordCount().equals("Single"));
					       if(bean.getRecordCount().equals("Single")){
					       
					   
					      // finToYear=commonUtil.converDBToAppFormat(dateMontyYear,"dd-MMM-yyyy","yy");
							  	//System.out.println("dispFromYear=="+dispFromYear+"flag==="+flag+"dispToYear"+dispToYear+"rateOfInterest"+rateOfInterest);
							  	//if(finFromYear.substring(2,4).equals(finToYear)){
							  	//if(finFromYear.equals("2000")){
							  		// 	finFromYear="1999";
							  	//}
							 
							  //	if(finFromYear.trim().length()<2){
							  	//finFromYear="0"+finFromYear;
							  	//}
							  	//finToYear=Integer.toString(Integer.parseInt(finToYear)+1);
							  	//if(finToYear.trim().length()<2){
							  		//finToYear="0"+finToYear;
							  	//}
							  	//}
							
							  ///finFromYear="";
					       
								%>
								
								
							
							<% 
							System.out.println("=================="+bean.getMonthyear()+bean.getEditedDate().trim().equals("N")+recoverieTable.equals("true"));
							if(!bean.getEditedDate().trim().equals("N")&& (recoverieTable.equals("true"))){
							
							    
							
							%>
         				
         				
          			<tr bgcolor="orange" >
 			 <%
 			 }else{ %>
  		
			  <%} %>
							
								<%
							//System.out.println("zzzzzzzzzzzzzzzzzzzzzzzzzzz:::::::::::::"+bean.getMonthyear()+bean.getAprList().size());
					
							
					
							}else if(bean.getRecordCount().equals("Duplicate")){%>
								<tr bgcolor="yellow" >
								<td class="Data"  width="12%" align="center"><font color="red">DUplicate</font></td>
							
							</tr>
								<%
								
								}%>
								
							 	  <%
							 	  
							totalEmoluments=(totalEmoluments+Math.round(aprlEmoluments));
							adjustmentemoluments=(adjustmentemoluments+Math.round(adjaprEmoluments));
							totSbsContr=(totSbsContr+Math.round(aprSbscont));
							totNTIRecovery=(totNTIRecovery+Math.round(aprNTIrecovery));
							totAdjSbsContri=(totAdjSbsContri+Math.round(aprAdjSbscontri));
							totGrossContri=(totGrossContri+Math.round(aprGrossConri));
							
							
							//System.out.println("totAprList============"+(totalEmoluments+Math.round(Double.parseDouble((AprList.get(0)).toString()))));
							
							
							 	  
							  intrestvalue=0;
							 monthProduct="0";
							  	if(flag==true){
							     if(noofmonths>12){
							    	 noofmonths=12;
							     }
							  	dispToYear=commonUtil.converDBToAppFormat(dateMontyYear,"dd-MMM-yyyy","yy");
							  	//System.out.println("dispFromYear=="+dispFromYear+"flag==="+flag+"dispToYear"+dispToYear+"rateOfInterest"+rateOfInterest);
							  	if(dispFromYear.equals(dispToYear)){
							  	if(dispFromYear.equals("00")){
							  		 	dispFromYear="99";
							  	}
							 
							  	if(dispFromYear.trim().length()<2){
							  	dispFromYear="0"+dispFromYear;
							  	}
							  	dispToYear=Integer.toString(Integer.parseInt(dispToYear)+1);
							  	if(dispToYear.trim().length()<2){
							  		dispToYear="0"+dispToYear;
							  	}
							  	}
							  	totalYear=dispFromYear+"-"+dispToYear;
						
							  	
							  	dispFromYear="";
							  	totClIntrest=totintrest+obIntrest;
							  	totGrossContri=totGrossContri+obIntrest;
							  	if(finTotalYear.equals("2006-2007")||finTotalYear.equals("2007-2008")||finTotalYear.equals("2008-2009")){
							  	taxbleIncome=0;
							  	taxbleIncomeSBS=0;
							  	}else if(finTotalYear.equals("2016-2017")||finTotalYear.equals("2017-2018")||finTotalYear.equals("2018-2019")||finTotalYear.equals("2019-2020")){
							  	if(totGrossContri-150000>0)
							  	taxbleIncome=totGrossContri-150000;
							  	
							  	if(totAdjSbsContri-150000>0)
							  	taxbleIncomeSBS=totAdjSbsContri-150000;
							  	
							  	}else{
							  		if(totGrossContri-100000>0)
							  	taxbleIncome=totGrossContri-100000;
							  	if(totAdjSbsContri-100000>0)
							  	taxbleIncomeSBS=totAdjSbsContri-100000;
							  	}
							  	
							  %>
							
							
								<%
								
									SBSFinancialReportService service= new SBSFinancialReportService();
								
								service.saveYearWiseSBS(empSerialNo,finTotalYear,totalEmoluments,totSbsContr,totNTIRecovery,totAdjSbsContri,totClIntrest,"",taxbleIncome,taxbleIncomeSBS);
									System.out.println("finYear:::::"+finTotalYear+"totClIntrest:::"+totClIntrest);
								   
								  //  System.out.println("cumPFStatury"+cumPFStatury+"cumPension"+cumPension);
								
								%>
								
								
							<tr>
								<%
									flag=false;
									openFlag=true;
									noofmonths=0;
									cpfOpeningBalance=Math.round(pfStaturary+cpfInterest+Math.round(cpfOpeningBalance));
									penOpeningBalance=Math.round(totalPension+pensionInterest+Math.round(penOpeningBalance));
									pfOpeningBalance=Math.round(pfContribution+pfContributionInterest+Math.round(pfOpeningBalance));
									
									
									
									
									
									totcl=new Double(df.format(totcl+totGrossContri)).doubleValue();
									totTaxIncome=new Double(df.format(totTaxIncome+taxbleIncome)).doubleValue();
									totTaxIncomeSBS=new Double(df.format(totTaxIncomeSBS+taxbleIncomeSBS)).doubleValue();
									String nextFinYear="";
									
								%>
						
							
									<%if(!finTotalYear.equals("2018-2019")){ %>
								 
							
								<%
								
								
								if(finTotalYear.length()>=9){
								 nextFinYear=(Integer.parseInt(finTotalYear.substring(0,4))+1)+"-"+ (Integer.parseInt(finTotalYear.substring(5,9))+1);
								
								if(!nextFinYear.equals("2019-2020"))
								{
								//if(finTotalYear.equals("2017-2018")){
								//obIntrest=Math.round(totcl*(Double.parseDouble(intrestrate.get(nextFinYear).toString())/100)*(0.99178));
								//}else{
								obIntrest=Math.round(totcl*Double.parseDouble(intrestrate.get(nextFinYear).toString())/100);
								//}
								}
								}
								 %>
							
								<%
							}else{ %>
								
								<% }%>
								
							<%if(!finTotalYear.equals("2019-2020")){ %>
							
									<%if(!finTotalYear.equals("2019-2020")){ %>
							
								<%
								
								
								if(finTotalYear.length()>=9){
								 nextFinYear=(Integer.parseInt(finTotalYear.substring(0,4))+1)+"-"+ (Integer.parseInt(finTotalYear.substring(5,9))+1);
								
								if(!nextFinYear.equals("2020-2021"))
								{
								//if(finTotalYear.equals("2017-2018")){
								//obIntrest=Math.round(totcl*(Double.parseDouble(intrestrate.get(nextFinYear).toString())/100)*(0.99178));
								//}else{
								obIntrest=Math.round(totcl*Double.parseDouble(intrestrate.get(nextFinYear).toString())/100);
								//}
								}
								}
								 %>
							
								<%} }%>
							
								
								
							
							
							
							<%
							
							
							
							
							grandEmoluments=grandEmoluments+totalEmoluments;
							grandAdjuscontr=grandAdjuscontr+adjustmentemoluments;
							grandSbsContr=grandSbsContr+totSbsContr;
							grandtotintrest=grandtotintrest+totClIntrest;
							grandpercentageadj=(grandSbsContr/(grandSbsContr+grandtotintrest)*100);
							grandpercentageintrest=(grandtotintrest/(grandSbsContr+grandtotintrest)*100);
							
							
							grandCPF=grandCPF+pfStaturary;
							grandPension=grandPension+totalPension;
							grandPFContribution=grandPFContribution+pfContribution;
							
							grandCPFInterest=grandCPFInterest+cpfInterest;
							grandPensionInterest=grandPensionInterest+pensionInterest;
							grandPFContributionInterest=grandPFContributionInterest+pfContributionInterest;
							cumPFStatury=0.0;cumPension=0.0;cumPfContribution=0.0;
							totalEmoluments=0;pfStaturary=0;totalPension=0;pfContribution=0;
							cpfInterest=0;pensionInterest=0;pfContributionInterest=0;
							adjustmentemoluments=0;totSbsContr=0;totintrest=0;totNTIRecovery=0;totAdjSbsContri=0;totGrossContri=0;taxbleIncome=0;taxbleIncomeSBS=0;
							totClIntrest=0;
							
							}%>
							<%	  	dispYearFlag=false;}}%>
						
							<!--
							<tr>
								<td class="HighlightData" align="center">Grand  Total of <%=count%> months </td>
								<td class="HighlightData"></td>
								<td class="HighlightData" align="right"></td>
								<td class="HighlightData" align="right"></td>
								<td class="HighlightData" align="right"></td>
								<td class="HighlightData" align="right"></td>
								
								
							</tr>
							--><tr>
								<td class="HighlightData" align="right"><%=pensionNo%></td>
								<td class="HighlightData" align="right"><%=df.format(grandEmoluments)%></td>
								<td class="HighlightData" align="right"><%=df.format(grandAdjuscontr)%></td>
								<td class="HighlightData" align="right"><%=df.format(grandSbsContr)%></td>
								<td class="HighlightData" align="right"><%=df.format(grandtotintrest)%></td>
								
								<td class="HighlightData"   align="right"><%=df.format(grandSbsContr+grandtotintrest)%></td>
							
								
							</tr>
							
							
					
   

  <%if(recoverieTable.equals("true")){}%>
 
               <%if(signatureFlag==true){%>
  
<%}else{%>
 
   
<%}%>
         
         
     
						<%if(size-1!=i){%>
					
						<%}%>
				
					
				<%}%>
				
			
				<%}
				}else{%>
				
				
          <table align="center" width="100%">
          <tr>
          <td align="center">
          <strong>No Records Found</strong>
          </td>
          </tr>
          </table>
				<%}%>
			   </table></td>
      </tr>
							
									</table>
								</td>
							</tr>
					</table>
		</form>	
  </body>
</html>
