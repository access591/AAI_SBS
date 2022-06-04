<%@ page language="java" import="aims.service.FinancialService,java.util.HashMap,aims.service.SBSFinancialReportService" pageEncoding="UTF-8"%>
<%
 FinancialService finance = new FinancialService();
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
ArrayList a=new ArrayList();
String dispDesignation="";
System.out.println("this is starting...");
 
 String station=request.getAttribute("regionStr").toString();
 String region=request.getAttribute("regionStr").toString();

String username = session.getAttribute("userid").toString();
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
    
    var station='<%=station%>';
    var region='<%=region%>';
     document.forms[0].action="<%=basePath%>reportservlet?method=saveIntrest&intrest="+intrest+"&pensionno="+pensionno+"&employeenm="+employeenm+"&designation="+designation+"&station="+station+"&region="+region+"&interestCalc="+interestCalc+"&difftotals="+difftotals+"&revisedpc="+revisedpc+"&difcontri="+difcontri;
	document.forms[0].method="post";
	document.forms[0].submit();
    }   
    function test(){
       //alert('This pension contribution report');
    }
  
    </script>
  </head>
  <body onLoad="javascript:test()">
<%!
	ArrayList blockList=new ArrayList();
	String breakYear="";
%>
  <form action="method">
			<table width="100%" border="0" 	 align="center" cellpadding="0" cellspacing="0">
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
  	 String getEditpensionno="",dateofSeparation="",dateofSeparationReason="";
  	 double pctotal=0.0,recoverydifftotals=0.0;
  	  String recoverieTable="";
	  	 if (request.getAttribute("reportType") != null) {
				reportType = (String) request.getAttribute("reportType");
				if (reportType.equals("Excel Sheet")
						|| reportType.equals("ExcelSheet")) {
				
					fileName = "Opening Corpus Report Normal.xls";
					response.setContentType("application/vnd.ms-excel");
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
		dateofSeparation=contr.getDateofSeperationDt();
		dateofSeparationReason=contr.getSeparationReason();
	
		
			
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
			 System.out.println("size======================"+size);
  			if(size!=0){
  			boolean signatureFlag=false;
  			//   if(chkBulkPrint.equals("true")){
  			   signatureFlag=true;
   	    				dispSignStation="";
   	    				mangerName="(Nodal Officer)";
   	     				dispDesignation="";
		    			dispSignPath=basePath+"PensionView/images/signatures/Mohapatra.gif";
  			  // }
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
								<td align="center" class="ReportHeading" colspan="2"> <%=headingsub%>  <%=commonUtil.converDBToAppFormat(docofEDCR,"dd-MMM-yyyy","dd.MM.yyyy") %> To 31.03.2021</td>	
								</tr>
								</table>
								</td>
							</tr>
							
							
							
				<tr >
					<td>
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
								<td class="reportsublabel">Date of Separation & Reason</td>
								<td class="reportdata"><%=dateofSeparation%>&<%=dateofSeparationReason%></td>
									
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
					<td  colspan="5" >
					
						<table  class="sample"    cellpadding="2" cellspacing="0" width="100%" align="center" >
							
							<tr>
								<th class="label" width="10%" align="center">Month(payble)</th>
								<th class="label" width="10%" align="center">Salary Month</th>
								<th class="label" width="10%" align="center">Emolument(A)</th>
								<th class="label" width="10%" align="center">SBS Rate (%)</th>
								<th class="label" width="10%" align="center">AAI SBS Contribution @ 10% (B=A*10%)</th>
								
								
								<th class="label" width="10%" align="center">Notional Additional Increment Recovery </th>
								<th class="label" width="10%" align="center">Adjusted SBS Contribution (D=B-C)</th>
								
							
								<th class="label" width="10%" align="center">Interest</th>
								<th class="label" width="10%" align="center">Gross Contribution</th>
								
								<th class="label" width="10%" align="center">Station</th>
								<th class="label" width="8%" align="center">Deputation (Y/N)</th>
								
								<th class="label" width="12%" align="center" nowrap>Financial Year</th>
								<th class="label" width="10%" align="center">Interest Rate</th>
								<th class="label" width="10%" align="center">Taxable Value of Perquisite Value after relief u/s 89 (with intt)</th>
								<th class="label" width="10%" align="center">Taxable Value of Perquisite Value after relief u/s 89 (without intt)</th>
								
								
							
							</tr>
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
						intrestrate.put("2021-2022","0");
						
						
						
						
							
							double totalEmoluments=0.0,pfStaturary=0.0,totalPension=0.0,empVpf=0.0,principle=0.0,interest=0.0,pfContribution=0.0,adjustmentemoluments=0.0,totSbsContr=0.0,totNTIRecovery=0.0,totAdjSbsContri=0.0,totGrossContri=0.0,totintrest=0.0,totTaxIncome=0.0,totTaxIncomeSBS=0.0,totcl=0.0,totClIntrest=0.0,totAprList=0.0,grandpercentageintrest=0.0,grandpercentageadj=0.0;
							double obIntrest=0.0;
							String monthProduct="0";
							double grandEmoluments=0.0,grandCPF=0.0,grandPension=0.0,grandPFContribution=0.0,intrestvalue=0.0,sbscont=0.0,NTIRecovery=0.0,taxbleIncome=0.0,taxbleIncomeSBS=0.0,adjSbsContri=0.0,grossSbsContri=0.0,grandAdjuscontr=0.0,grandSbsContr=0.0,grandtotintrest=0.0,grandNoIncrement=0.0;
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
						        System.out.println("::::::::::::::::::::"+bean.getDeputationFlag());
								finTotalYear=bean.getFinYear();
						        if(finTotalYear.equals("2019-2020")){ 
						       sbscont= Math.round(Double.parseDouble(bean.getEmoluments())*0.07);
								}else if(finTotalYear.equals("2020-2021")){ 
						       sbscont= Math.round(Double.parseDouble(bean.getEmoluments())*0);
								}else{
                                sbscont= Math.round(Double.parseDouble(bean.getEmoluments())*0.1);
								}
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
								  	
								  	
						if(Double.parseDouble(bean.getEmoluments())!=0.0){
							  	   intrestvalue=Math.round(((adjSbsContri)*Double.parseDouble((intrestrate.get(finTotalYear)).toString())/100)*(Double.parseDouble(product.get(monthYear.substring(0,3)).toString())/12));
						      
						   //  System.out.println("intrest value===================="+Math.round(((Double.parseDouble(bean.getEmoluments())*0.1)*Double.parseDouble((intrestrate.get(finTotalYear)).toString())/100)*(Double.parseDouble(product.get(monthYear.substring(0,3)).toString())/12)));
						      
						      
						      monthProduct=product.get(monthYear.substring(0,3)).toString();
						      }
						     // grossSbsContri=adjSbsContri+intrestvalue;
								 if(bean.getDeputationFlag().equals("Y") || sbscont==0){
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
					   System.out.println("=================="+bean.getMonthyear()+bean.getRecordCount().equals("Single"));
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
  			<tr bgcolor="white">
			  <%} %>
							    <td class="Data" align="center"><%=bean.getPayblemonth() %></td>
								<td class="Data" align="center"><%=monthYear%></td>
								<td class="Data" align="right"><%=Math.round(Double.parseDouble(bean.getEmoluments()))%></td>
								<%if(finTotalYear.equals("2019-2020")){  sbsRate=7;%>
								<td class="Data" align="right"><%=df.format(sbsRate)%></td>
								<%}else if(finTotalYear.equals("2020-2021")){  sbsRate=0;%>
								<td class="Data" align="right"><%=df.format(sbsRate)%></td>
								<%}else{sbsRate=10;%>
								<td class="Data" align="right"><%=df.format(sbsRate)%></td>
								<%}%>
								<td class="Data" align="right"><%=df.format(sbscont)%></td>
								<td class="Data" align="right"><%=df.format(NTIRecovery)%></td>
								<td class="Data" align="right"><%=df.format(adjSbsContri)%></td>
								
							
								<td class="Data" width="12%" align="right"><%=df.format(intrestvalue)%></td>
								<td class="Data" width="12%" align="right"><%=df.format(grossSbsContri)%></td>
								
								
								<td class="Data" width="12%" align="center"><%=bean.getStation()%></td>
								<td class="Data" width="12%" align="center"><%=bean.getDeputationFlag()%></td>
								
								<td class="Data" width="12%" align="center"><%=finTotalYear%></td>
							    
								<td class="Data" align="center"><%=intrestrate.get(finTotalYear)%></td>
								<td class="Data" align="center"></td>
								<td class="Data" align="center"></td>
							</tr>
							
							<%
							//System.out.println(monthYear+"zzzzzzzzzzzzzzzzzzzzzzzzzzz:::::::::::::"+bean.getMonthyear()+bean.getAprList().size());
						
							
					
							}else if(bean.getRecordCount().equals("Duplicate")){%>
								<tr bgcolor="yellow" >
								<td class="Data"  width="12%" align="center"><font color="red"><%=monthYear%></font></td>
								<td class="Data" width="12%" align="right"><font color="red"><%=Math.round(Double.parseDouble(bean.getEmoluments()))%></font></td>
								<td class="Data" width="12%" align="right"><font color="red"><%=Math.round(Double.parseDouble(bean.getCpf()))%></font></td>
								<td class="Data" width="12%" align="right"><font color="red"><%=Math.round(Double.parseDouble(bean.getDbPensionCtr()))%></font></td>
								<td class="Data" width="12%" align="right"><font color="red"><%=Math.round(Double.parseDouble(bean.getAaiPFCont()))%></font></td>
								<td class="Data" width="12%"><font color="red"><%=bean.getStation()%></font></td>
								<td class="Data" width="12%"><font color="red"><%=bean.getForm7Narration()%></font></td>
							    
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
							  	}else if(finTotalYear.equals("2016-2017")||finTotalYear.equals("2017-2018")||finTotalYear.equals("2018-2019")||finTotalYear.equals("2019-2020")||finTotalYear.equals("2020-2021")){
								taxbleIncome=0;
							  	taxbleIncomeSBS=0;
							  	if(totGrossContri-150000>0){
							  	taxbleIncome=totGrossContri-150000;
								}
							  	System.out.println("taxbleIncome===="+taxbleIncome);
								System.out.println("totAdjSbsContri===="+totAdjSbsContri);
							  	if(totAdjSbsContri-150000>0){
							  	taxbleIncomeSBS=totAdjSbsContri-150000;
								}
								System.out.println("taxbleIncomeSBS===="+taxbleIncomeSBS);
							  	
							  	}else{
									taxbleIncome=0;
							  	taxbleIncomeSBS=0;
									System.out.println("totGrossContri in else===="+totGrossContri);
							  		if(totGrossContri-100000>0){
							  	taxbleIncome=totGrossContri-100000;
									}
									System.out.println("taxbleIncome in else===="+taxbleIncome);
									System.out.println("totAdjSbsContri==in else=="+totAdjSbsContri);
							  	if(totAdjSbsContri-100000>0){
							  	taxbleIncomeSBS=totAdjSbsContri-100000;
								}
								System.out.println("taxbleIncomeSBS==in else=="+taxbleIncomeSBS);
							  	}
							  	
							  	
							  %>
							 <tr>
								<td class="HighlightData" align="center">Total <%=finTotalYear%></td>
								<td class="HighlightData" align="right"></td>
								<td class="HighlightData" align="right"><%=df.format(totalEmoluments)%></td>
								<td class="HighlightData" align="right"></td>
								<td class="HighlightData" align="right"><%=df.format(totSbsContr)%></td>
								<td class="HighlightData" align="right"><%=df.format(totNTIRecovery)%></td>
								<td class="HighlightData"  align="right"><%=df.format(totAdjSbsContri)%></td>
							
								<td class="HighlightData"  align="right"><%=df.format(totClIntrest)%></td>
								<td class="HighlightData" align="right"><%=df.format(totGrossContri) %></td>
								<td class="HighlightData"></td>
								<td class="HighlightData"></td>
								<td class="HighlightData"></td>
								<td class="HighlightData"></td>
								<td class="HighlightData"><%=df.format(taxbleIncome) %></td>
								<td class="HighlightData"><%=df.format(taxbleIncomeSBS) %></td>
							
							
							</tr>
							
								<%
								SBSFinancialReportService service= new SBSFinancialReportService();
								
								//service.saveYearWiseSBS(empSerialNo,finTotalYear,totalEmoluments,adjustmentemoluments,totSbsContr,totClIntrest,"");
									//System.out.println("rateOfInterest"+rateOfInterest+"No of months"+noofmonths);
								    if(noofmonths<12){
								    	cpfInterest=Math.round((cumPFStatury*rateOfInterest/100)/12)+Math.round((cpfOpeningBalance*rateOfInterest/100)*noofmonths/12);
										pensionInterest=Math.round((cumPension*rateOfInterest/100)/12)+Math.round((penOpeningBalance*rateOfInterest/100)*noofmonths/12);
										pfContributionInterest=Math.round((cumPfContribution*rateOfInterest/100)/12)+Math.round((pfOpeningBalance*rateOfInterest/100)*noofmonths/12);
								    }else{
								    	cpfInterest=Math.round((cumPFStatury*rateOfInterest/100)/12)+Math.round(cpfOpeningBalance*rateOfInterest/100);
										pensionInterest=Math.round((cumPension*rateOfInterest/100)/12)+Math.round(penOpeningBalance*rateOfInterest/100);
										pfContributionInterest=Math.round((cumPfContribution*rateOfInterest/100)/12)+Math.round(pfOpeningBalance*rateOfInterest/100);
							  		}
								  //  System.out.println("cumPFStatury"+cumPFStatury+"cumPension"+cumPension);
								
								
								
									grandEmoluments=grandEmoluments+totalEmoluments;
									grandSbsContr=grandSbsContr+totSbsContr;
									grandAdjuscontr=grandAdjuscontr+totAdjSbsContri;
									grandNoIncrement=grandNoIncrement+totNTIRecovery;
									grandtotintrest=grandtotintrest+totClIntrest;
								
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
						
								<td class="HighlightData" align="center">Cumulative Closing Balance<%=bean.getFinYear() %></td>
							<td class="HighlightData" align="right"></td>
								<td class="HighlightData" align="right"><%=df.format(grandEmoluments)%></td>
								<td class="HighlightData" align="right"></td>
								<td class="HighlightData" align="right"><%=df.format(grandSbsContr) %></td>
								<td class="HighlightData" align="right"><%=df.format(grandNoIncrement) %></td>
									<td class="HighlightData" align="right"><%=df.format(grandAdjuscontr) %></td>
									<%if(!finTotalYear.equals("2018-2019")){ %>
							
								<%
								
								
								if(finTotalYear.length()>=9){
								 nextFinYear=(Integer.parseInt(finTotalYear.substring(0,4))+1)+"-"+ (Integer.parseInt(finTotalYear.substring(5,9))+1);
								
								if(!nextFinYear.equals("2021-2022"))
								{
								obIntrest=Math.round(totcl*Double.parseDouble(intrestrate.get(nextFinYear).toString())/100);
								}
								
								
								
								}
								 %>
								<td class="HighlightData" align="right"><%=df.format(grandtotintrest) %></td>
								<%}else{ %>
							
								<td class="HighlightData"><%=df.format(grandtotintrest) %></td>
								<% }%>
								<td class="HighlightData"><%=df.format(totcl) %></td>
								<td class="HighlightData"></td>
								<td class="HighlightData"></td>
								<td class="HighlightData"></td>
								
							
							<td class="HighlightData"></td>
								
								<%if( finTotalYear.equals("2020-2021") ){ %>
								<td class="HighlightData"><%=df.format(totTaxIncome) %></td>
								<td class="HighlightData"><%=df.format(totTaxIncomeSBS) %></td>
								<%}else{ %>
							<td class="HighlightData"></td>
							<td class="HighlightData"></td>
								<% }%>
								
							</tr>
							<%if( !finTotalYear.equals("2020-2021")){ %>
							<tr><td class="HighlightData" align="center">Interest on Cumulative Closing Balance<%=bean.getFinYear() %></td>
							<td class="HighlightData"></td>
								<td class="HighlightData"></td>
								<td class="HighlightData" align="right"></td>
								<td class="HighlightData" align="right"></td>
								<td class="HighlightData" align="right"></td>
									<td class="HighlightData" align="right"></td>
									<%if( !finTotalYear.equals("2020-2021")){ %>
							
								<%
								
								
								if(finTotalYear.length()>=9){
								 nextFinYear=(Integer.parseInt(finTotalYear.substring(0,4))+1)+"-"+ (Integer.parseInt(finTotalYear.substring(5,9))+1);
								
								if(!nextFinYear.equals("2021-2022"))
								{
								//if(finTotalYear.equals("2017-2018")){
								//obIntrest=Math.round(totcl*(Double.parseDouble(intrestrate.get(nextFinYear).toString())/100)*(0.99178));
								//}else{
								obIntrest=Math.round(totcl*Double.parseDouble(intrestrate.get(nextFinYear).toString())/100);
								//}
								}
								}
								 %>
								<td class="HighlightData" align="right"><%=df.format(obIntrest) %></td>
								<td class="HighlightData" align="right"><%=df.format(obIntrest) %></td>
								<%}else{ %>
							
								<td class="HighlightData"></td>
								<td class="HighlightData"></td>
								<% }%>
								<td class="HighlightData"></td>
								<td class="HighlightData"></td>
								
								<td class="HighlightData" align="center"><%=nextFinYear %></td>
								
								<%if(!finTotalYear.equals("2018-2019")){ %>
								<td class="HighlightData" ><%=intrestrate.get(nextFinYear) %></td>
							<%}else{ %>
							<td class="HighlightData"></td>
								<% }%>
								<td class="HighlightData"></td>
								<td class="HighlightData"></td>
							</tr>
							
							<%
							}else{
							
							
							
							
							%>
							<tr><td class="HighlightData" colspan="6"><b>Less: TDS deducted  by AAI (Upload file will be recd. From AAI)</b> </td><td colspan="1" class="HighlightData" >Pending</td><td></td><td class="HighlightData"></td><td colspan="6"></td>
							</tr>
							<tr><td class="HighlightData" colspan="6"><b>  Net Amount Received from AAI</b> </td><td colspan="1" class="HighlightData" >Pending</td><td></td><td class="HighlightData"><b> <%=df.format(totcl) %></b>  </td><td colspan="6"></td>
							
							</tr>
							
							<%
							}
							
							
						
							
							
							
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
							
							
							}%>
							<%	  	dispYearFlag=false;}}%>
						
							<!--  <tr>
								<td colspan="18">
									<table align="center" width="100%" cellpadding="0" cellspacing="0" class="sample">
							<tr>
								<td class="HighlightData" ></td>
								<td class="HighlightData">Emolument</td>
								<td class="HighlightData">Adjusted Emoluments </td>
								<td class="HighlightData">AAI SBS Contribution </td>
							
								<td class="HighlightData">Interest</td>
								<td class="HighlightData">Total Interest and SBS Contribution  </td>
								
							</tr><tr>
								<td class="HighlightData" align="right">Grand Total</td>
								<td class="HighlightData" align="right"><%=df.format(grandEmoluments)%></td>
								<td class="HighlightData" align="right"><%=df.format(grandAdjuscontr)%></td>
								<td class="HighlightData" align="right"><%=df.format(grandSbsContr)%></td>
								<td class="HighlightData" align="right"><%=df.format(grandtotintrest)%></td>
								
								<td class="HighlightData"   align="right"><%=df.format(grandSbsContr+grandtotintrest)%></td>
							
								
							</tr>
							
							
							<tr>
								<td class="HighlightData" align="right"></td>
							
								<td colspan="3" class="HighlightData" style="font-weight: bold;" align="right"><%=df1.format(grandpercentageadj)%>%</td>
								<td class="HighlightData" style="font-weight: bold;" align="right"><%=df1.format(grandpercentageintrest)%>%</td>
								
								<td class="HighlightData"   align="right"></td>
							
								
							</tr>
					
    </table></td>
							</tr>-->
<tr>
	 <td colspan="15"><table width="100%" border="0" cellspacing="0" cellpadding="0" class="sample">


               
 <tr>
   <tr height="100px">
   <td  style="width:100% !important;">
   
   <table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td style="width:70% !important; border:solid 0px !important;">
    <table width="100%" border="0" cellspacing="0" cellpadding="0">
 <tr>
     <td class="label" align="left" valign="bottom" style=" border:solid 0px !important;">IN CASE OF ANY DISCREPANCY IN THE BALANCES SHOWN ABOVE THE MATTER MAY BE BROUGHT TO THE NOTICE OF  THE SBS CELL <BR>WITHIN 15 DAYS OF ISSUE OF THE STATEMENT, OTHER WISE THE BALANCES WOULD BE PRESUMED TO HAVE BEEN CONFORMED.</td> </tr>
     <tr><td height="20px;"  style=" border:solid 0px !important;"></td></tr>
     	 <tr><td   align="left" valign="bottom"  style="font-family: verdana; font-size: 11px; border:solid 0px !important;">Date:</td></tr>

</table>
</td>
     <td style="width:30% !important; border:solid 0px !important;"><table  width="100%" border="0" >
    			<tr><td style=" border:solid 0px !important;"><img src="<%=dispSignPath%>" /></td></tr>
    			<tr><td style=" border:solid 0px !important;font-family: verdana; font-size: 11px;"><%=mangerName%></td></tr>
    			<tr><td  style=" border:solid 0px !important; font-family: verdana; font-size: 11px;"><%=dispSignStation%></td></tr>
    			<tr><td  style=" border:solid 0px !important; font-family: verdana; font-size: 11px;"><%=dispDesignation%></td></tr>
    			</table></td>
  </tr>
</table>
  
   
</td>
</tr>
     
  
    	
    		
    		
    	</table></td>
            
  </tr>

         
         
        </table></td>
      </tr>
							
									</table>
								</td>
							</tr>
							
						</table>
						<%if(size-1!=i){%>
						<br style='page-break-after:always;'>
						<%}%>
					</td>
				</tr>
					
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
			</table>
		</form>	
  </body>
</html>
