
<%@ page language="java" import="java.util.*,aims.common.CommonUtil" pageEncoding="UTF-8"%>
<%@ page import="aims.bean.*"%>
<%@ page import="aims.bean.epfforms.*"%>
<%@ page import="aims.service.FinancialReportService"%>
<%@ page import="java.text.DecimalFormat"%>
<%@ page import="java.util.ArrayList" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<title>AAI</title>
 <LINK rel="stylesheet" href="<%=basePath%>PensionView/css/aai.css" type="text/css">
</head>

<body>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td><table width="100%" border="0" cellspacing="0" cellpadding="0">
     <tr>
        <td>&nbsp;</td>
        <td width="7%" rowspan="2"><img src="<%=basePath%>PensionView/images/logoani.gif" width="100" height="50" /></td>
        <td>AIRPORTS AUTHORITY OF INDIA</td>
      </tr>
       <tr>
        <td width="38%">&nbsp;</td>
        <td width="55%">&nbsp;</td>
      </tr>
    
      <tr>
        <td colspan="3" align="center" class="reportlabel">MONTHLY SCHEDULE OF EMPLOYEE-WISE PENSION CONTRIBUTION FOR THE MONTH <font style="text-decoration: underline"><%=request.getAttribute("dspMonth")%></font> (FY<%=request.getAttribute("dspYear")%>.)</td>
      </tr>
    </table></td>
  </tr>
  <tr>
    <td>&nbsp;</td>
  </tr>
  <%
    	ArrayList cardReportList=new ArrayList();
    	ArrayList missingPFIDsList=new ArrayList();
    	
  	String reportType="",fileName="",region="",stationName="",filePrefix="",filePostfix="";
  	CommonUtil commonUtil=new CommonUtil();
  	 DecimalFormat df = new DecimalFormat("#########0");
  	
  	if(request.getAttribute("regionDesc")!=null){
  		region=(String)request.getAttribute("regionDesc");
  	}
  	if(request.getAttribute("airportcode")!=null){
  		stationName=(String)request.getAttribute("airportcode");
  	}
  	if("NO-SELECT".equals(stationName)){
  		stationName=region;
  		filePostfix=stationName;
  	}else{
  		filePostfix=region+"_"+stationName;
  	}%>
 
    <%

  	  double nonCPFEmolumentTotal=0,nonCPFContGrandTotal=0,emolumentTotal=0,EPFTotal=0,VPFTotal=0,PFAdvTotal=0,PFAdvIntTotal=0,subGrandTotal=0,PFNetTotal=0,PFContTotal=0,contGrandTotal=0,outstandGrandTotal=0,addContriGrandTotal=0;
  	  
  	if(request.getAttribute("cardList")!=null){
  			if (request.getAttribute("reportType") != null) {
				reportType = (String) request.getAttribute("reportType");
				if (reportType.equals("Excel Sheet")
						|| reportType.equals("ExcelSheet")) {
				
					filePrefix = "AAI_ECHallan-6A_Report";
					fileName=filePrefix+filePostfix+".xls";
					response.setContentType("application/vnd.ms-excel");
					response.setHeader("Content-Disposition",
							"attachment; filename=" + fileName);
				}
			}
  	cardReportList=(ArrayList)request.getAttribute("cardList");
  	
		
	
  %>
  <tr>
  	<td>&nbsp;</td>
  </tr>
    <tr>
  	<td>&nbsp;</td>
  </tr>
  <tr>
    <td><table width="100%" border="1" cellspacing="0" cellpadding="0">
      <tr>
     
        <td width="3%"  class="reportsublabel">Sl.No</td>
        <td width="8%"  class="reportsublabel">MEMBER ID </td>
		<td width="8%"  class="reportsublabel" nowrap="nowrap">MEMBER NAME</td>
        <td width="8%"  class="reportsublabel">EPF WAGES</td>
        <td width="12%"  class="reportsublabel">EPS WAGES</td>
        <td width="8%"  class="reportsublabel">EPF CONT. (EE) DUE</td>
        <td width="8%"  class="reportsublabel">EPF CONT. (EE) REMITTED</td>
        <td width="8%"  class="reportsublabel">EPS CONTRIBUTION<br/> DUE</td>
		<td width="12%"  class="reportsublabel">EPS CONT.<br/> BEING REMITTED</td>
		<td width="8%"  class="reportsublabel">DIFF. EPF &<br/> EPS CONT.</td>
		<td width="8%"  class="reportsublabel">DIFF. EPF & EPS CONT.<br/> BEING REMITTED</td>
		<td width="4%"  class="reportsublabel" nowrap="nowrap">NCP DAYS</td>
		<td width="4%"  class="reportsublabel">REFUND OF ADVANCES</td>
		<td width="4%"  class="reportsublabel" nowrap="nowrap">ARREAR EPF WAGES</td>
		<td width="4%"  class="reportsublabel">ARREAR EPF<br/> EE SHARE</td>
		<td width="4%"  class="reportsublabel">ARREAR EPF <br/>ER SHARE</td>
		<td width="4%"  class="reportsublabel" nowrap="nowrap">ARREAR EPS SHARE</td>
		<td width="4%"  class="reportsublabel" nowrap="nowrap">Additional Contri</td>
		<td width="4%"  class="reportsublabel" nowrap="nowrap">Father's Name/ <br/> Husband name</td>
        <td width="4%"  class="reportsublabel">RELATIONSHIP<br/> WITH MEMBER </td>
        <td width="4%"  class="reportsublabel">DATE OF BIRTH</td>
        <td align="center"  class="reportsublabel">GENDER</td>
        <td align="center"  class="reportsublabel">DATE OF JOINING<br/> EPF</td>
        <td align="center"  class="reportsublabel">DATE OF JOINING<br/> EPS</td>
          <td align="center"  class="reportsublabel">DATE OF EXIT<br/> FROM EPF</td>
        <td align="center"  class="reportsublabel">DATE OF EXIT<br/> FROM EPS</td>
          <td align="center"  class="reportsublabel">REASON FOR LEAVING- <br/>(C-CESSATION, S-SUPERANNUATION,<br/> R(RETIREMENT,<br/> D-DEATH IN SERVICE, <br/>P- PERMANENT DISABLEMENT)</td>
           <td align="center"  class="reportsublabel">Pension Option</td>   
           <td align="center"  class="reportsublabel">Fresh Option</td>           
          <td align="center"  class="reportsublabel">Airport Code</td>
           <td align="center"  class="reportsublabel">Region</td>
      </tr>

  
     <tr></tr>
     <%
     	AaiEpfform3Bean epfForm3Bean=new AaiEpfform3Bean();
     	int srlno=0;
     	double diff=0,grandDiffe=0,emolumentsByEpf=0,emolBypensionContri=0,pensionContri=0,epf=0,noofDays=0;
     	String[] dobList=null;
     	String  recoveryStatus="",seperationReason="";
     	for(int cardList=0;cardList<cardReportList.size();cardList++){
		epfForm3Bean=(AaiEpfform3Bean)cardReportList.get(cardList);
		srlno++;
		//System.out.println(epfForm3Bean.getPfID()+epfForm3Bean.getFormDifference());
		
		diff=Double.parseDouble(epfForm3Bean.getFormDifference());
		if(epfForm3Bean.getWetherOption().trim().equals("A")){
		if((Double.parseDouble(epfForm3Bean.getPensionAge())>58) && (epfForm3Bean.getSeperationreason().equals("Death") || epfForm3Bean.getSeperationreason().equals("Resignation") || epfForm3Bean.getSeperationreason().equals("Retirement") || epfForm3Bean.getSeperationreason().equals("VRS"))){
		epf=0;
		pensionContri=0;
		} else{
		epf =Double.parseDouble(epfForm3Bean.getEmppfstatury()); 
		pensionContri =Double.parseDouble(epfForm3Bean.getPensionContribution());
		} 
		if(Double.parseDouble(epfForm3Bean.getPensionAge())==58 && !epfForm3Bean.getDateOfBirth().equals("---")){
		dobList = epfForm3Bean.getDateOfBirth().split("-");
		noofDays = Integer.parseInt(dobList[0])-1;
		epf= Math.round(Double.parseDouble(epfForm3Bean.getEmppfstatury())* noofDays / Double.parseDouble(epfForm3Bean.getDaysBymonth()));
		pensionContri= Double.parseDouble(epfForm3Bean.getPensionContribution());
		} 
		
		
		}
		//System.out.println("========option====="+epfForm3Bean.getWetherOption().trim()+"=====");
		if( epfForm3Bean.getWetherOption().trim().equals("B")|| epfForm3Bean.getWetherOption().toLowerCase().trim().equals("no")){
		    epf =Double.parseDouble(epfForm3Bean.getEmppfstatury()); 
			if(Double.parseDouble(epfForm3Bean.getPensionContribution())==541){ 
				pensionContri=541.45;
			}else{
			pensionContri =Double.parseDouble(epfForm3Bean.getPensionContribution());
			}
		}  
		
		/* if( 
		
		commonUtil.leadingZeros(5,epfForm3Bean.getPensionno()).equals("23245")){
		System.out.println("pensionno=="+commonUtil.leadingZeros(5,epfForm3Bean.getPensionno())+"==Normal=="+epfForm3Bean.getEmoluments()+"======emolBypensionContri=="+emolBypensionContri+"==diff=="+(emolBypensionContri-Double.parseDouble(epfForm3Bean.getEmoluments()))+"-pensionContri-"+pensionContri);
		System.out.println("======emolumentsByEpf=="+emolumentsByEpf+"=Normal=="+epfForm3Bean.getEmoluments()+"==diff=="+(emolumentsByEpf-Double.parseDouble(epfForm3Bean.getEmoluments()))+"==epf=="+epf);
		} */
		emolumentsByEpf=Math.round((epf)*100 /12);			
		emolBypensionContri = Math.round((pensionContri)*100 /8.33);
		 if(!epfForm3Bean.getRecoveryStatus().equals("")){
		 recoveryStatus = epfForm3Bean.getRecoveryStatus();	
		 seperationReason = epfForm3Bean.getSeperationreason()+"-"+recoveryStatus;	
		 if(!epfForm3Bean.getSeperationreason().equals("---")){
		  seperationReason = epfForm3Bean.getSeperationreason()+"-"+recoveryStatus;
		 }else{
		 seperationReason = recoveryStatus;
		 }
		 }else{
		  seperationReason = epfForm3Bean.getSeperationreason();
		  }
		//System.out.println("======emolumentsByEpf=="+emolumentsByEpf+"=Normal=="+epfForm3Bean.getEmoluments()+"==diff=="+(emolumentsByEpf-Double.parseDouble(epfForm3Bean.getEmoluments())));
	  	// System.out.println("pensionno=="+commonUtil.leadingZeros(5,epfForm3Bean.getPensionno())+"==Normal=="+epfForm3Bean.getEmoluments()+"======emolBypensionContri=="+emolBypensionContri+"==diff=="+(emolBypensionContri-Double.parseDouble(epfForm3Bean.getEmoluments()))+"--"+epfForm3Bean.getPensionContribution());
	 
     %>
      
      <tr <%=epfForm3Bean.getHighlightedColor()%>>
        <td  class="NumData"><%=srlno%></td>
        <td class="Data"><%=commonUtil.leadingZeros(5,epfForm3Bean.getPensionno())%></td>
        <td class="Data" nowrap="nowrap"><%=epfForm3Bean.getEmployeeName()%></td>
        <td class="Data">---</td>       
         <%if(((emolumentsByEpf-Double.parseDouble(epfForm3Bean.getEmoluments()))>20  ||  (Double.parseDouble(epfForm3Bean.getEmoluments())-emolumentsByEpf)>20 )&& epfForm3Bean.getWetherOption().trim().equals("A")){%>
        <td class="NumData" nowrap="nowrap" bgcolor="orange"><%=epfForm3Bean.getEmoluments()%></td>              
         <%
 			 }else{ %>
  		<td class="NumData" nowrap="nowrap" bgcolor="white"><%=epfForm3Bean.getEmoluments()%></td> 
			  <%} %> 
			    
        <td class="NumData" nowrap="nowrap">0</td>
        <td class="NumData" nowrap="nowrap">0</td>
          <%if((emolBypensionContri-Double.parseDouble(epfForm3Bean.getEmoluments()))>20 ||   (Double.parseDouble(epfForm3Bean.getEmoluments())-emolBypensionContri)>20){%>
        <td class="NumData" nowrap="nowrap" bgcolor="pink"><%=epfForm3Bean.getPensionContribution()%></td>
        <td class="NumData" nowrap="nowrap" bgcolor="pink"><%=epfForm3Bean.getPensionContribution()%></td>
        	 <%}else{ %>
        	 <td class="NumData" nowrap="nowrap" bgcolor="white"><%=epfForm3Bean.getPensionContribution()%></td>
        <td class="NumData" nowrap="nowrap" bgcolor="white"><%=epfForm3Bean.getPensionContribution()%></td>
        	
        	 <%} %>  
        <td class="NumData" nowrap="nowrap">0</td>
         <td class="NumData" nowrap="nowrap">0</td>
        <td class="NumData" nowrap="nowrap"><%=epfForm3Bean.getNCPDays()%></td>
    <td class="NumData" nowrap="nowrap">0</td>
        <td class="NumData" nowrap="nowrap"><%=epfForm3Bean.getNonCPFEmoluments()%></td>
         <td class="NumData" nowrap="nowrap">0</td>
          <td class="NumData" nowrap="nowrap">0</td>
        <td class="NumData" nowrap="nowrap"><%=epfForm3Bean.getNonCPFPC()%></td>
        <td class="NumData" nowrap="nowrap"><%=epfForm3Bean.getAdditionalContri()%></td>

        
        <td class="Data" nowrap="nowrap"><%=epfForm3Bean.getFhName()%></td>
        <td class="Data" nowrap="nowrap"><%=epfForm3Bean.getFhflag()%></td>
         <%if (!epfForm3Bean.getDateOfBirth().equals("---")){%>
        <td class="Data" nowrap="nowrap"><%=epfForm3Bean.getDateOfBirth()%></td>
        <%}else{%> 
         <td class="NumData">---</td>
        <%}%>
        <td class="Data"><%=epfForm3Bean.getGender()%></td>
              <%if (!epfForm3Bean.getDateofentitle().equals("---")){%>
        <td class="NumData"><%=epfForm3Bean.getDateofentitle()%></td>
        <%}else{%> 
         <td class="NumData">---</td>
        <%}%>
           <%if (!epfForm3Bean.getDateofentitle().equals("---")){%>
        <td class="NumData"><%=epfForm3Bean.getDateofentitle()%></td>
        <%}else{%> 
         <td class="NumData">---</td>
        <%}%>
            <%if (!epfForm3Bean.getSeperationDate().equals("---")){%>
        <td class="Data" nowrap="nowrap"><%=epfForm3Bean.getSeperationDate()%></td>
        <%}else{%> 
            <td class="Data" nowrap="nowrap">---</td>
        <%}%>
          <%if (!epfForm3Bean.getSeperationDate().equals("---")){%>
        <td class="Data" nowrap="nowrap"><%= epfForm3Bean.getSeperationDate() %></td>
        <%}else{%> 
            <td class="Data" nowrap="nowrap">---</td>
        <%}%>
        <td class="Data" nowrap="nowrap"><%=seperationReason%></td>
         <td class="Data" nowrap="nowrap"><%=epfForm3Bean.getWetherOption()%></td>
         <td class="Data" nowrap="nowrap"><%=epfForm3Bean.getFreshOption() %></td>
           <td class="Data" nowrap="nowrap"><%=epfForm3Bean.getStation()%></td>
 <td class="Data" nowrap="nowrap"><%=epfForm3Bean.getRegion()%></td>
      </tr>
	<%
	
	 emolumentTotal+=Double.parseDouble(epfForm3Bean.getEmoluments());
	
	 contGrandTotal+=Double.parseDouble(epfForm3Bean.getPensionContribution());
	 nonCPFEmolumentTotal+=Double.parseDouble(epfForm3Bean.getNonCPFEmoluments());
	 addContriGrandTotal+=Double.parseDouble(epfForm3Bean.getAdditionalContri());
		
	 nonCPFContGrandTotal+=Double.parseDouble(epfForm3Bean.getNonCPFPC());
	 grandDiffe+=diff;   
	
	}%>
	
    <tr>
    <td class="Data" colspan="3" align="right">Grand Total</td>   
      <td class="Data">0</td>         
    <td class="Data"><%=Math.round(emolumentTotal)%></td>
     <td class="Data">0</td>  
      <td class="Data">0</td>  
    <td class="Data"><%=Math.round(contGrandTotal)%></td>  
      <td class="Data"><%=Math.round(contGrandTotal)%></td>  
        <td class="Data">0</td>
          <td class="Data">0</td>
       <td class="Data">0</td>  
        <td class="Data">0</td>  
        <td class="Data"><%=Math.round(nonCPFEmolumentTotal)%></td>  
         <td class="Data">0</td>  
          <td class="Data">0</td>  
          <td class="Data"><%=Math.round(nonCPFContGrandTotal)%></td> 
             <td class="Data"><%=Math.round(addContriGrandTotal)%></td>
         
    <td class="Data" colspan="13">&nbsp;</td> 
    
   
    
    </tr>
      
    </table></td>
  </tr>
  <%}%>


  
  <tr>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td>&nbsp;</td>
  </tr>
    <tr>
    <td>Note:-This report shown upto  58 Years</td>
    </tr>
    <tr>    
    <td>Note:-Orange Color Highlights Emoluments Agianst Epf to  Emoluments submitted</td>
     </tr>
      <tr>
    <td>Note:-Pink Color Highlights Emoluments Agianst PC to  Emoluments submitted</td>
  </tr>           
</table>
</body>
</html>
