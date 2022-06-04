

<%@ page language="java" import="java.util.*,aims.common.CommonUtil,aims.common.Constants" contentType="text/html;charset=utf-8" pageEncoding="UTF-8"%>

<%@ page import="aims.bean.FinancialYearBean"%>
<%@ page import="aims.bean.adjcrnt.SuppPCBean"%>
<%@ page import="aims.service.FinancialService"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="java.text.DecimalFormat"%>
<% String path = request.getContextPath();
            String basePath = request.getScheme() + "://"
                    + request.getServerName() + ":" + request.getServerPort()
                    + path + "/";
                    
                    String[] year = {"2012-13","2013-14","2014-15","2015-16","2016-17","2017-18","2018-19"};
                    String[] userYears = {"2012-13","2013-14","2014-15","2015-16","2016-17","2017-18","2018-19"};
                    String selYear="";			
                    String accountType="",region1="",monthyear="",monthmm1="",selRegion="";
                    if(request.getAttribute("monthYear")!=null){
                    monthyear=request.getAttribute("monthYear").toString();
                    System.out.println("list"+request.getAttribute("monthYear").toString());
                    }
                    if(request.getAttribute("month")!=null){
                    monthmm1=request.getAttribute("month").toString();
                    System.out.println("month"+request.getAttribute("month").toString());
                    }
                    if(request.getAttribute("region")!=null){
                    selRegion=request.getAttribute("region").toString();
                    System.out.println("selRegion"+request.getAttribute("region").toString());
                    }
                   String userType=session.getAttribute("userid").toString();
                   String AirportName="";
							  if(session.getAttribute("station")!=null){
                             AirportName =session.getAttribute("station").toString(); 
							  }
							  
						  if(request.getAttribute("year")!=null){
                    selYear=request.getAttribute("year").toString();
                    System.out.println("selYear"+request.getAttribute("year").toString());
                    }	  
            
            %>
<html>
	<HEAD>
	<style>
.black_overlay {
	display: none;
	position: fixed;
	top: 0%;
	left: 0%;
	width: 100%;
	height: 3000px;
	background-color: black;
	z-index: 1001;
	-moz-opacity: 0.8;
	opacity: .80;
	filter: alpha(opacity = 80);
}

.white_content {
	display: none;
	position: fixed;
	top: 25%;
	left: 25%;
	width: 50%;
	height: 50%;
	padding: 16px;
	border: 16px solid orange;
	background-color: white;
	z-index: 1002;
	overflow: auto;
}
</style>
		
    <meta http-equiv="pragma" content="no-cache">
    <meta http-equiv="cache-control" content="no-cache">
    <meta http-equiv="expires" content="0">
    <meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
    <meta http-equiv="description" content="This is my page">
    <link rel="stylesheet" href="<%=basePath%>PensionView/css/aai.css" type="text/css" />    	 
		<script type="text/javascript" src="<%=basePath%>PensionView/scripts/calendar.js"></script>
		<script type="text/javascript" src="<%=basePath%>PensionView/scripts/CommonFunctions.js"></script>
		<SCRIPT type="text/javascript" src="<%=basePath%>PensionView/scripts/DateTime.js"></SCRIPT>
		<SCRIPT type="text/javascript" src="<%=basePath%>PensionView/scripts/DateTime1.js"></SCRIPT>
		<script type="text/javascript">
		
	function validateForm() {

	
	var yearId='',url='',userType='';
	userType='<%=userType%>';
	//if(userType.indexOf('FIN')==-1){
	//alert("You Don't Have Privileges To Access");
	//return false;
	//}
		yearId=document.forms[0].select_year.options[document.forms[0].select_year.selectedIndex].value;
		//alert("yearId"+yearId);
	if(yearId=='NO-SELECT'){
	alert("Please Select The Year");
	document.forms[0].select_year.focus();
	return false;
	}
	monthId=document.forms[0].select_month.options[document.forms[0].select_month.selectedIndex].value;
	//alert("monthId"+monthId);
	if(monthId=='NO-SELECT'){
	alert("Please Select The Month");
	document.forms[0].select_month.focus();
	return false;
	}
	regionId=document.forms[0].select_region.options[document.forms[0].select_region.selectedIndex].value;
	//alert("regionId"+regionId);
	url = "<%=basePath%>pcreportservlet?method=loadStationWiseRemittance&year="+yearId+"&month="+monthId+"&region="+regionId+"&flag=F&form=chq";
		document.forms[0].action=url;
		document.forms[0].method="post";
		document.forms[0].submit();

	}
	function  GenareteForm4(id,pensionno){ 
 var url="",report="";
 var pfFlag="true";
 var swidth=screen.Width-10;
 var sheight=screen.Height-150;
 	url ="<%=basePath%>pcreportservlet?method=generateform4report2&id="+id+"&pensionno="+pensionno;
	 	//alert(url);
   	 				 		wind1 = window.open(url,"PFCard","toolbar=yes,statusbar=yes,scrollbars=yes,menubar=yes,resizable=yes,width="+swidth+",height="+sheight+",top=0,left=0");
							winOpened = true;
							wind1.window.focus();		  
 }
 	
	function createXMLHttpRequest()
	{
	if(window.ActiveXObject)
	 {
		xmlHttp = new ActiveXObject("Microsoft.XMLHTTP");
	 }
	else if (window.XMLHttpRequest)
	 {
		xmlHttp = new XMLHttpRequest();
	 }
	 }


function numsDotOnly()
	{
    if(((event.keyCode>=48)&&(event.keyCode<=57))||(event.keyCode==46) ||(event.keyCode>=44 && event.keyCode<47))
        {
           event.keyCode=event.keyCode;
        }
        else
        {
			 event.keyCode=0;
        }
  }
  function validDate(monthyear,dateOfReceipt)
  {
	   var dt1   = monthyear.substring(0,2);
	   var mon1  = monthyear.substring(3,6);
	   //alert(monthyear);
	   var year1=monthyear.substring(7,monthyear.length);
	  if(mon1 == "JAN" ||mon1 == "Jan") month = 1;
   	else if(mon1 == "FEB" ||mon1 == "Feb") month = 2;
	else if(mon1 == "MAR" ||mon1 ==  "Mar") month = 3;
	else if(mon1 == "APR" || mon1 == "Apr") month = 4;
	else if(mon1 == "MAY" || mon1 == "May" ) month = 5;
	else if(mon1 == "JUN" || mon1 == "Jun") month = 6;
	else if(mon1 == "JUL" || mon1 == "Jul") month = 7;
	else if(mon1 == "AUG" || mon1 == "Aug") month = 8;
	else if(mon1 == "SEP" || mon1 == "Sep" ) month =9;
	else if(mon1 == "OCT" || mon1 == "Oct" ) month = 10;
	else if(mon1 == "NOV" || mon1 == "Nov") month = 11;
	else if(mon1 == "DEC" || mon1 == "Dec") month = 12;
	var month1;
	if(month!=1){
	 month1=month-1;
	}else{
	month1=12;
	year1=year1-1;
	}
	var monthyear1="25/"+month1+"/"+year1;
	
	 // alert("monthyear1"+monthyear1+"dateOfReceipt"+dateOfReceipt); 
    	var result = compareDates(monthyear1,dateOfReceipt);		 
			 if(result=="larger")
			{ 	alert("DateOfReceipt should  be greater than "+monthyear1);
				document.getElementById(dateOfReceiptTextBoxNo).focus();
				return false;
			}
			return true;	 	 
			}

 function frmload(){
		

	}
	var prevPf='',prevInsp='',prevPc='',prevPfRemitDate='',prevInspRemitDate='',prevPcRemitDate='',monthyear='';
function editPc(pfRemitDateTextBoxNo,inspRemitDateTextBoxNo,pcRemitDateTextBoxNo,pfTextBoxNo,inspTextBoxNo,pcTextBoxNo,editid,stationTextBoxNo,regionTextBoxNo,accTypeTextBoxNo,imgId1,imgId2,imgId3,chqPfTextBoxNo,chqInspTextBoxNo,chqPcTextBoxNo,totPfTextBoxNo,totInspTextBoxNo,totPcTextBoxNo,remarksTextBoxNo,TextBoxNo){
	var chqpf=document.getElementById(chqPfTextBoxNo).value;
	var chqinsp=document.getElementById(chqInspTextBoxNo).value;
	var chqpc=document.getElementById(chqPcTextBoxNo).value;
	if(chqpf!=0 || chqinsp!=0 || chqpc!=0){
	//alert("chqpf"+chqpf+"chqinsp"+chqinsp+"chqpc"+chqpc);
	//alert("Already Remitted by CHQ,So You  Can't Process.");
	//return false;
	}
	//alert(pfRemitDateTextBoxNo);
	var pfRemitDate=document.getElementById(pfRemitDateTextBoxNo).value;
	var inspRemitDate=document.getElementById(inspRemitDateTextBoxNo).value;
	var pcRemitDate=document.getElementById(pcRemitDateTextBoxNo).value;
	var pf=document.getElementById(pfTextBoxNo).value;
	var insp=document.getElementById(inspTextBoxNo).value;
	var pc=document.getElementById(pcTextBoxNo).value;
	//alert(pc);
	
		var totpf=document.getElementById(totPfTextBoxNo).value;
		var totinsp=document.getElementById(totInspTextBoxNo).value;
		var totpc=document.getElementById(totPcTextBoxNo).value;
		var remarks=document.getElementById(remarksTextBoxNo).value;
		//alert(totpf);
	
	var station=document.getElementById(stationTextBoxNo).value;
	var region=document.getElementById(regionTextBoxNo).value;
	var acctype=document.getElementById(accTypeTextBoxNo).value;
	//var upPenContri=document.getElementById(upPcTextBoxNo).value;
	var airportName='<%=AirportName%>';
	var userType='<%=userType%>';
		 if(acctype=='SAU'){
		 
		//alert("acctype"+acctype+airportName);
		
		 if(station!=airportName && station!='CHQNAD'){
			 alert("You Can't Process "+station);
			 return false;
		 }
		 if(userType.indexOf('PERS')!=-1){
		  alert("You Can't Process..");
		 return false;
		 }
		 }else if(acctype=='RAU' && (userType.indexOf('FIN')==-1)){
		 if(airportName!=''){
			 alert("You Can't Process "+station);
			 return false;
		 }
		  alert("You Can't Process "+station);
		 return false;
		 }
	
	
	//alert("region"+region);
	//alert("region"+document.getElementsByName(regionTextBoxNo)[0].value);
	 document.getElementsByName(remarksTextBoxNo)[0].readOnly=false;
	 document.getElementsByName(remarksTextBoxNo)[0].style.background='#FFFFCC';
	 document.getElementsByName(imgId1)[0].style.display='inline';
	 document.getElementsByName(imgId2)[0].style.display='inline';
	 document.getElementsByName(imgId3)[0].style.display='inline';
	 document.getElementsByName(pfRemitDateTextBoxNo)[0].readOnly=false;
	 document.getElementsByName(pfRemitDateTextBoxNo)[0].focus();
	 document.getElementsByName(pfRemitDateTextBoxNo)[0].style.background='#FFFFCC';
	 
	 document.getElementsByName(pfTextBoxNo)[0].readOnly=false;
	 document.getElementsByName(pfTextBoxNo)[0].style.background='#FFFFCC';
	 document.getElementsByName(inspRemitDateTextBoxNo)[0].readOnly=false;
	 document.getElementsByName(inspRemitDateTextBoxNo)[0].style.background='#FFFFCC';
	 document.getElementsByName(inspTextBoxNo)[0].readOnly=false;
	 document.getElementsByName(inspTextBoxNo)[0].style.background='#FFFFCC';
	 document.getElementsByName(pcRemitDateTextBoxNo)[0].readOnly=false;
	 document.getElementsByName(pcRemitDateTextBoxNo)[0].style.background='#FFFFCC';
	 document.getElementsByName(pcTextBoxNo)[0].readOnly=false;
	 document.getElementsByName(pcTextBoxNo)[0].style.background='#FFFFCC';
	
	 

	 var buttonName=document.getElementsByName(editid)[0].value;
	  //alert(buttonName);
	 if(buttonName=="S")
	 {
	 prevPf=pf;
	 prevInsp=insp;
	 prevPc=pc;
	 prevPfRemitDate=pfRemitDate;
	 prevInspRemitDate=inspRemitDate;
	 prevPcRemitDate=pcRemitDate;
	 monthyear='<%=monthyear%>';
	 //alert(monthyear);
	
	}
	document.getElementsByName(editid)[0].value="S";
	createXMLHttpRequest();
	if(buttonName=="S"){
	if(!document.getElementById(pfRemitDateTextBoxNo).value==""){
	  		     
	date1=document.getElementById(pfRemitDateTextBoxNo);
	//alert("date1"+date1+"date1.value.length"+date1.value.length);
	var val1=convert_date(date1);		   	   
	   		    if(val1==false)
	   		     {
	   		      return false;
	   		     } 	
	   		     }
	   pfRemitDate=document.getElementById(pfRemitDateTextBoxNo).value;
	   if(pfRemitDate!=""){
	   validDate(monthyear,pfRemitDate);
	   }
	  if(!document.getElementById(inspRemitDateTextBoxNo).value==""){ 
	   date2=document.getElementById(inspRemitDateTextBoxNo);
	//alert("date1"+date1+"date1.value.length"+date1.value.length);
	var val2=convert_date(date2);		   	   
	   		    if(val2==false)
	   		     {
	   		      return false;
	   		     } 	
	   		     }
	   inspRemitDate=document.getElementById(inspRemitDateTextBoxNo).value;
	   if(inspRemitDate!=""){
	   validDate(monthyear,inspRemitDate);
	   }
	   if(!document.getElementById(pcRemitDateTextBoxNo).value==""){ 
	   date3=document.getElementById(pcRemitDateTextBoxNo);
	//alert("date1"+date1+"date1.value.length"+date1.value.length);
	var val3=convert_date(date3);		   	   
	   		    if(val3==false)
	   		     {
	   		      return false;
	   		     } 	
	   		     }
	   pcRemitDate=document.getElementById(pcRemitDateTextBoxNo).value;
	   if(pcRemitDate!=""){
	   validDate(monthyear,pcRemitDate);
	   }

	 var diffpf=totpf-pf;
	 var diffinsp=totinsp-insp;
	 var diffpc=totpc-pc;
	if((diffpf!=0)  && (remarks.length<5)){
	alert("Please Justify the Difference of PF Amt "+diffpf+" in Notes");
	document.getElementsByName(remarksTextBoxNo)[0].focus();
	return false;
	}
	if((diffinsp!=0) && (remarks.length<5)){
	alert("Please Justify the Difference of INSP Charges Amt "+diffinsp+" in Notes");
	document.getElementsByName(remarksTextBoxNo)[0].focus();
	return false;
	}
	if((diffpc!=0) && (remarks.length<5)){
	alert("Please Justify the Difference of PC Amt "+diffpc+" in Notes");
	document.getElementsByName(remarksTextBoxNo)[0].focus();
	return false;
	}
	
	
	 document.getElementById("dpf"+TextBoxNo).value=diffpf;
	 document.getElementById("dinsp"+TextBoxNo).value=diffinsp;
	 document.getElementById("dpc"+TextBoxNo).value=diffpc;
	   
		  
		 document.getElementById('fade').style.display='block'; 
		 document.getElementById('update').style.display='block'; 
		 var url='';
		 var url="<%=basePath%>pcreportservlet?method=updateStationWiseRemittance&pfRemitDate="+pfRemitDate+"&inspRemitDate="+inspRemitDate+"&pcRemitDate="+pcRemitDate+"&pf="+pf+"&insp="+insp+"&pc="+pc+"&editid="+editid+"&monthyear="+monthyear+"&station="+station+"&region="+region+"&acctype="+acctype+"&flag=R"+"&remarks="+remarks;
 		 //alert(url);
	 	xmlHttp.open("post", url, true);
		xmlHttp.onreadystatechange = updateStationWiseRemittance;
		xmlHttp.send(null);
	}
	}
	function updateStationWiseRemittance(){	
	
	if(xmlHttp.readyState ==4)
  	{
	 var buttonupdate=xmlHttp.responseText;
	 process.style.display="none";
	 document.getElementById('process').style.display='none';
	 document.getElementById('fade').style.display='none';
	 document.getElementsByName(buttonupdate)[0].value="E";	
	 var rownum=buttonupdate.substring(4, buttonupdate.length);
	 var pfRemitDateTextBoxNo="pfRemitDate"+rownum;
	 var inspRemitDateTextBoxNo="inspRemitDate"+rownum;
	 var pcRemitDateTextBoxNo="pcRemitDate"+rownum;
	 var pfTextBoxNo="pf"+rownum;
	 var inspTextBoxNo="insp"+rownum;
	 var pcTextBoxNo="pc"+rownum;
	 var imgId1="myimage1"+rownum;
	 var imgId2="myimage2"+rownum;
	 var imgId3="myimage3"+rownum;
	 var remarks="remarks"+rownum;
	 
	 
	
	
	 document.getElementsByName(imgId1)[0].style.display='none';
	 document.getElementsByName(imgId2)[0].style.display='none';
	 document.getElementsByName(imgId3)[0].style.display='none';	
	 document.getElementById(pfRemitDateTextBoxNo).readOnly=true;
	 document.getElementById(pfRemitDateTextBoxNo).style.background='none';
	 document.getElementById(inspRemitDateTextBoxNo).readOnly=true;
	 document.getElementById(inspRemitDateTextBoxNo).style.background='none';
	 document.getElementById(pcRemitDateTextBoxNo).readOnly=true;
	 document.getElementById(pcRemitDateTextBoxNo).style.background='none';
	 document.getElementById(pfTextBoxNo).readOnly=true;
	 document.getElementById(pfTextBoxNo).style.background='none';
	 document.getElementById(inspTextBoxNo).readOnly=true;
	 document.getElementById(inspTextBoxNo).style.background='none';
	 document.getElementById(pcTextBoxNo).readOnly=true;
	 document.getElementById(pcTextBoxNo).style.background='none';
	 document.getElementById(remarks).readOnly=true;
	 document.getElementById(remarks).style.background='none';
	 document.getElementsByName(buttonupdate)[0].focus();
	 
	 
	}
	}
	function LoadWindow(params){
	var newParams ="<%=basePath%>PensionView/Report.jsp?"+params
	winHandle = window.open(newParams,"Utility","menubar=yes,toolbar = yes,scrollbars=yes,resizable=yes");
	winOpened = true;
	winHandle.window.focus();
    }
	function callReport(){
	var url='',monthYear='',region='';
	monthYear='<%=monthyear%>';
	region='<%=selRegion%>';
	formtype=document.forms[0].formType.options[document.forms[0].formType.selectedIndex].value;
	if(formtype==''){
	return false;
	}
	var swidth=screen.Width-10;
	var sheight=screen.Height-150;
	//alert(formtype);
	url = "<%=basePath%>pcreportservlet?method=loadStationWiseRemittanceReport&monthYear="+monthYear+"&region="+region+"&formtype="+formtype;
		if(formtype=='html' || formtype=='Html'){
	   	 			 LoadWindow(url);
   	 			}else if(formtype=='Excel Sheet' || formtype=='ExcelSheet'){
   	 				 		wind1 = window.open(url,"Report","toolbar=yes,statusbar=yes,scrollbars=yes,menubar=yes,resizable=yes,width="+swidth+",height="+sheight+",top=0,left=0");
							winOpened = true;
							wind1.window.focus();
   	 			}
	}
	
	
	//....................//
	function ChangeCalSpan(){
	if(document.getElementById("upvie").colSpan==3){
	document.getElementById("upvie").colSpan="6";
	}else if(document.getElementById("upvie").colSpan==6){
	document.getElementById("upvie").colSpan="9";
	}else if(document.getElementById("upvie").colSpan==9){
	document.getElementById("upvie").colSpan="12";
	}
	}
	function extend(s){
	//alert(document.getElementById("upvie").colSpan);
	ChangeCalSpan();
     
     document.getElementById("pfac").colSpan="4";
    document.getElementsByName("pfb")[0].style.display='none';
	//document.getElementsByName("upvie")[0].colspan='12';
	//document.getElementsByName("pfac")[0].colspan='4';
	document.getElementsByName("getpc1")[0].style.display='inline';
	document.getElementsByName("getpc2")[0].style.display='inline';
	document.getElementsByName("getpc3")[0].style.display='inline';
	for(var i=0;i<=s;i++){
	document.getElementsByName("getpfc"+i)[0].style.display='inline';
	document.getElementsByName("getpfs"+i)[0].style.display='inline';
	document.getElementsByName("getpfa"+i)[0].style.display='inline';
	}
	return true;
	
	}
	function extend1(s){
	ChangeCalSpan();
    
     document.getElementById("insp").colSpan="4";
    document.getElementsByName("inspb")[0].style.display='none';
	document.getElementsByName("getin1")[0].style.display='inline';
	document.getElementsByName("getin2")[0].style.display='inline';
	document.getElementsByName("getin3")[0].style.display='inline';
	for(var i=0;i<=s;i++){
	document.getElementsByName("getinc"+i)[0].style.display='inline';
	document.getElementsByName("getins"+i)[0].style.display='inline';
	document.getElementsByName("getina"+i)[0].style.display='inline';
	}
	return true;
	}
	function extend2(s){
	ChangeCalSpan();
	
     // document.getElementById("upvie").colSpan="12";
     document.getElementById("pnc").colSpan="4";
     document.getElementsByName("pcb")[0].style.display='none';
    
	//document.getElementsByName("upvie")[0].colspan='12';
	//document.getElementsByName("pfac")[0].colspan='4';
	document.getElementsByName("getp1")[0].style.display='inline';
	document.getElementsByName("getp2")[0].style.display='inline';
	document.getElementsByName("getp3")[0].style.display='inline';
	for(var i=0;i<=s;i++){
	document.getElementsByName("getpcc"+i)[0].style.display='inline';
	document.getElementsByName("getpcs"+i)[0].style.display='inline';
	document.getElementsByName("getpca"+i)[0].style.display='inline';
	}
	return true;
	}

</script>
	</HEAD>
	<body class="BodyBackground" onload="javascript:frmload()">
		<% String monthID = "", yearDescr = "", region = "", monthNM = "";

            Iterator regionIterator = null;
            Iterator monthIterator = null;
            HashMap hashmap = new HashMap();
            if (request.getAttribute("regionHashmap") != null) {
                hashmap = (HashMap) request.getAttribute("regionHashmap");
                Set keys = hashmap.keySet();
                regionIterator = keys.iterator();

            }
            if (request.getAttribute("monthIterator") != null) {
                monthIterator = (Iterator) request
                        .getAttribute("monthIterator");
            }
         
            
            %>
		<form >
			<table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
				<tr>
					<td>


						<jsp:include page="/PensionView/PensionMenu.jsp" />


					</td>
				</tr>

				<tr>
					<td>
						&nbsp;
					</td>

				</tr>
			</table>

			<table width="85%" border="0" align="center" cellpadding="0" cellspacing="0" class="tbborder">
				<tr>
					<td height="2%" colspan="2" align="center" class="ScreenMasterHeading">
						 Form4 Report Screen
					</td>
				</tr>
				<tr>
					<td>
				<table height="25%" align="center" border="0">
				<tr>
					<td>
						&nbsp;
					</td>
				</tr>	
				
				<tr>
					<td class="label" align="right">
						Year/Month:<font color=red>*</font>&nbsp;&nbsp;
					</td>
					<td>
						<Select name='select_year' Style='width:65px'>
							
					<%for (int j = 0; j < userYears.length; j++) {%>
																			<option value='<%=userYears[j]%>' <%=userYears[j].equals(selYear)?"selected":""%>>
																				<%=userYears[j]%>
																			</option>
																			<%}%>
						</SELECT>
						<select name="select_month" style="width:65px">
							
							<%while (monthIterator.hasNext()) { 
                Map.Entry mapEntry = (Map.Entry) monthIterator.next();
                monthID = mapEntry.getKey().toString();
                monthNM = mapEntry.getValue().toString();

                %>

							<option value="<%=monthID%>" <%=monthID.equals(monthmm1)?"selected":""%> >
								<%=monthNM%>
							</option>
							
							<%}%>
						</select>
					</td>
					<td>
						&nbsp;
					</td>
			
				<td class="label" align="right">Region:&nbsp;&nbsp;&nbsp;</td>
				<td><SELECT NAME="select_region" style="width: 90px">
				<%if(session.getAttribute("usertype").toString().equals("Admin")){%>
					<option value="All">All Regions</option>
					<%}
					
						int k = 0;
						boolean exist = false;
						while (regionIterator.hasNext()) {
							region = hashmap.get(regionIterator.next()).toString();
							k++;

							if (region.equalsIgnoreCase(region1)) {
					%>
					<option value="<%=region1%>" <%=region1.equals(selRegion)?"selected":""%>>
					<%=region1%></option>
					<%
						} else {
					%>
					<option value="<%=region%>"<%=region.equals(selRegion)?"selected":""%>><%=region%></option>
					<%
						}
					%>
					<%
						}
					%>
				</SELECT> </td>
			
					<td>
						&nbsp;
					</td>
				
					<td align="right" colspan="3">
						<input type="button" class="btn" name="Submit" value="Go" onclick="javascript:validateForm()">
					</td>
				</tr>
				<tr>
					<td align="center"></td>
				</tr>
			</table>
			</td>
			</tr>
			</table>
			<table>
			<tr>
			<td>&nbsp;
			</td>
			</tr>
			</table>
			<%
			
		
			if (request.getAttribute("stationList")!=null){
			 System.out.println("list22"+request.getAttribute("stationList"));
			DecimalFormat df1 = new DecimalFormat("#########0");
			ArrayList list = new ArrayList();
			list=(ArrayList)request.getAttribute("stationList");
			request.setAttribute("list",list);
			int listSize=list.size();
			if(list.size()!=0){
			 %>
			 <div id="process" class="white_content">
		<img src="<%=basePath%>PensionView/images/Indicator.gif" border="0" align="right" />
		<span class="label">Processing.......</span>
        </div>
		<div id="fade" class="black_overlay"></div>
			<table width="85%" border="1" align="center" cellpadding="0" cellspacing="0" class="tbborder">
			<tr>
				<td  colspan="16">

				</td>
			</tr>
			<tr  class="tbheader">
								<td class="tblabel">REGION</td>	
								<td class="tblabel">YEAR</td>								
								<td class="tblabel">PFID</td>
								<td class="tblabel">Apporved By</td>
								<td class="tblabel">Verified By</td>
								<td class="tblabel">ECR Month</td>
								<td class="tblabel">Form4ID</td>
								<td class="tblabel">Form4Status</td>
								<td class="tblabel">Form4Report</td>
		   </tr>
		   			<tr  class="tbheader">
								<td class="tblabel"></td>	
								<td class="tblabel"></td>								
								<td class="tblabel"></td>
								<td class="tblabel"></td>
								<td class="tblabel"></td>
								<td class="tblabel"></td>
								<td class="tblabel"></td>
		   </tr>
			<%
			
			for(int i=0;i<list.size();i++){
			SuppPCBean bean= (SuppPCBean)list.get(i);
			//System.out.println("Region......."+bean.getRegion());
			%>
			<span id="spnTip" style="position: absolute; visibility: hidden; background-color: #ffedc8; border: 1px solid #000000; padding-left: 15px; padding-right: 15px; font-weight: normal; padding-top: 5px; padding-bottom: 5px; margin-left: 25px;"></span>
			
			<tr>
			<td class="Data" width="6%" ><%=bean.getRegion()%></td>
			<td class="Data" width="6%" ><%=bean.getAdjobyear()%></td>
			<td class="Data" width="6%" ><%=bean.getPensionno()%></td>
			<td class="Data" width="6%" ><%=bean.getApporvedby()%></td>
			<td class="Data" width="6%" ><%=bean.getVerifiedby()%></td>
			<td class="Data" width="6%" ><%=bean.getRem_month()%></td>
			<td class="Data" width="6%" ><%=bean.getForm4id()%></td>
			<td class="Data" width="6%" ><%=bean.getForm4flag()%></td>
			<td  class="Data" width="6%"><a href="#" onclick="GenareteForm4('<%=bean.getForm4id()%>','<%=bean.getPensionno()%>') "><img src="./PensionView/images/form4.gif" border="0"  /></a></td> 
			</tr>
			<%
			}%>
		
			</table>
			
			<%}else{%>
			<table width="85%" border="0">
			<tr><td align="center" colspan="16"> No Records Found</td></tr>
			<table/>
			<%}
			}%>
			
		</form>
		</body>
</html>
