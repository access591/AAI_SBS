<%String path = request.getContextPath();
            String basePath = request.getScheme() + "://"
                    + request.getServerName() + ":" + request.getServerPort()
                    + path + "/";
                    String[] year = {"1995","1996","1997","1998","1999","2000","2001","2002","2003","2004","2005","2006","2007","2008","2009","2010"};
            %>
            
            
 <%@ page language="java" import="java.util.*,aims.common.CommonUtil,aims.common.Constants" pageEncoding="UTF-8"%>
<%@ page import="aims.bean.EmployeePersonalInfo" %>
<%@ page import="aims.bean.*" %>           
<%@ page import="aims.bean.FinancialYearBean"%>
<%@ page import="aims.service.FinancialService"%>
<%@ page import="java.util.ArrayList"%>

<html>
<jsp:include page="/SBSHeader.jsp"></jsp:include>
<jsp:include page="/PensionView/SBS/Menu.jsp"></jsp:include>
	<HEAD>
		

		<script type="text/javascript"><!--

 function LoadWindow(params){
	var newParams ="<%=basePath%>PensionView/Report.jsp?"+params
	winHandle = window.open(newParams,"Utility","menubar=yes,toolbar = yes,scrollbars=yes,resizable=yes");
	winOpened = true;
	winHandle.window.focus();
}
 var chkpfid="";
 	function test(cpfaccno,region,pensionNumber,employeeName,dateofbirth,empSerialNo,chkpfid,dateofJoining,PCReportVerified){
			document.forms[0].empName.value=employeeName;
			document.forms[0].empserialNO.value=empSerialNo;
		  	document.forms[0].chkpfid.value = chkpfid;
		  	document.forms[0].dateofJoining.value=dateofJoining;
		  	document.forms[0].PCReportVerified.value = PCReportVerified;		  		
		}
		 var bulkPrintFlag='false';
	function bulkreport(userID){
		
		var regionID1='',airportcode1='';
		var chkEmpName=document.forms[0].empName.value;
		if(chkEmpName!=''){
				alert('Bulk Print Cannot Process a Individual Records.Please click on Submit Button');
				document.forms[0].empName.focus();
				return false;
		}
		var bulkpfidlist=document.forms[0].select_pfidlst.options[document.forms[0].select_pfidlst.selectedIndex].text;
		if(bulkpfidlist=='[Select One]'){
				alert('Please Select the PFID Printing List');
				document.forms[0].select_pfidlst.focus();
				return false;
		}
		if(document.forms[0].select_region.selectedIndex>0){
			regionID1=document.forms[0].select_region.options[document.forms[0].select_region.selectedIndex].text;
		}else{
			regionID1=document.forms[0].select_region.value;
		}
		if(document.forms[0].select_airport.selectedIndex>0){
			airportcode1=document.forms[0].select_airport.options[document.forms[0].select_airport.selectedIndex].text;
		}else{
			airportcode1=document.forms[0].select_airport.value;
		}
		if(regionID1=='North Region' || regionID1=='South Region'|| regionID1=='North-East Region' || regionID1=='RAUSAP' || regionID1=='West Region'|| (regionID1=='CHQIAD'&&airportcode1=='IGI IAD')|| (regionID1=='CHQIAD'&&airportcode1=='IGICargo IAD')){
			if(!(userID=='NRFIN' || userID=='SRFIN' || userID=='NERFIN'|| userID=='WRFIN' || userID=='SAPFIN'|| userID=='IGIFIN'|| userID=='CARGOFIN')){
				alert('Dont have Privileges for taking bulk print outs Other than Assistant Manager(F)/Manager(F) ');
				return false;
			}
		}
		bulkPrintFlag='true';
		validateForm();
	}
	function resetReportParams(){
		document.forms[0].action="<%=basePath%>sbssearch?method=sbsloadFinContri";
		document.forms[0].method="post";
		document.forms[0].submit();
	}	
	function popupWindow(mylink, windowname)
		{		
		//var transfer=document.forms[0].transferStatus.value;
		var transfer="";
	
		var regionID="",adjPfidChkFlag="true",pcReportChkFlag="true";
		
	
	
	
		
		
		if(document.forms[0].select_region.selectedIndex>0){
			regionID=document.forms[0].select_region.options[document.forms[0].select_region.selectedIndex].text;
		}else{
			regionID=document.forms[0].select_region.value;
		}
		if (! window.focus)return true;
		var href;
		if (typeof(mylink) == 'string')
		   href=mylink+"?transferStatus="+transfer+"&region="+regionID+"&adjPfidChkFlag="+adjPfidChkFlag+"&pcReportChkFlag="+pcReportChkFlag;
		   
		else
		href=mylink.href+"?transferStatus="+transfer+"&region="+regionID+"&adjPfidChkFlag="+adjPfidChkFlag+"&pcReportChkFlag="+pcReportChkFlag;
		
		//alert(href);
	    progress=window.open(href, windowname, 'width=700,height=500,statusbar=yes,scrollbars=yes,resizable=yes');
		/*retricting loading pfids list*/
		document.forms[0].select_region.value = "NO-SELECT";
		document.forms[0].select_airport.length = 1;
		document.forms[0].select_pfidlst.length=1;
		return true;
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
	function getAirports(param){
	//alert("2");	
		var transferFlag,airportcode,regionID,finalairportcode;
		if(document.forms[0].select_region.selectedIndex>0){
			regionID=document.forms[0].select_region.options[document.forms[0].select_region.selectedIndex].text;
		}else{
			regionID=document.forms[0].select_region.value;
		}
		
	
		createXMLHttpRequest();	
		if(param=='airport'){
		//alert("3");
			var url ="<%=basePath%>reportservlet?method=getAirports&region="+regionID;
			//alert("url======="+url);
			xmlHttp.open("post", url, true);
			xmlHttp.onreadystatechange = getAirportsList;
			
			
		}else{
		if(document.forms[0].empserialNO.value==''){
		//alert("4");
			
			if(document.forms[0].select_airport.length>1){
				finalairportcode=document.forms[0].select_airport.options[document.forms[0].select_airport.selectedIndex].value;
			}else{
				finalairportcode=document.forms[0].select_airport.value;
			}
		   if(finalairportcode=='NO-SELECT'){
				airportcode='';
			}else{
				airportcode=finalairportcode;
			}
			var formPageSize=document.forms[0].frmpagesize.value;
			bulkPrintFlag="false";
			var url ="<%=basePath%>sbssearch?method=SBSgetPFIDBulkPrintingList&frm_region="+regionID+"&frm_airportcode="+airportcode+"&frm_transflag="+transferFlag+"&frm_pagesize="+formPageSize;
			//var url ="<%=basePath%>sbssearch?method=SBSgetPFIDList&frm_region="+regionID+"&frm_airportcode="+airportcode+"&frm_transflag="+transferFlag;

				
			xmlHttp.open("post", url, true);
			xmlHttp.onreadystatechange = getPFIDNavigationList;
		}
		}
			xmlHttp.send(null);
    }
    function getAirportsList()
	{
	if(xmlHttp.readyState ==3 ||  xmlHttp.readyState ==2 ||  xmlHttp.readyState ==1){
			 process.style.display="block";
		}
		if(xmlHttp.readyState ==4)
		{     if(xmlHttp.status == 200){ 
			      	var stype = xmlHttp.responseXML.getElementsByTagName('ServiceType');
			      	//alert(stype);
					 process.style.display="none";
					  if(stype.length==0){
		 	var obj1 = document.getElementById("select_airport");
				obj1.options.length=0; 
		  		obj1.options[obj1.options.length]=new Option('[Select One]','NO-SELECT','true');
			}else{
		   	var obj1 = document.getElementById("select_airport");
		  	obj1.options.length = 0;
		  	
		  	for(i=0;i<stype.length;i++){
		  		if(i==0)
					{
				//alert("inside if")
					obj1.options[obj1.options.length]=new Option('[Select One]','NO-SELECT','true');
					}
		          	//alert("in else");
			obj1.options[obj1.options.length] = new Option(getNodeValue(stype[i],'airPortName'),getNodeValue(stype[i],'airPortName'));
			}
		  }
		}
	} 
}
function getPFIDNavigationList()
	{
		if(xmlHttp.readyState ==3 ||  xmlHttp.readyState ==2 ||  xmlHttp.readyState ==1){
			 process.style.display="block";
		}
		if(xmlHttp.readyState ==4)
		{
			if(xmlHttp.status == 200)
				{ 
			      	var stype = xmlHttp.responseXML.getElementsByTagName('ServiceType');
					 process.style.display="none";
					  if(stype.length==0){
		 //	alert("in if");
		 	var obj1 = document.getElementById("select_pfidlst");
		 
		 	
		  	obj1.options.length=0; 
		  	obj1.options[obj1.options.length]=new Option('[Select One]','NO-SELECT','true');
		 
		  
		  }else{
		   	var obj1 = document.getElementById("select_pfidlst");
		  //    alert(stype.length);	
		  	obj1.options.length = 0;
		  	
		  	for(i=0;i<stype.length;i++){
		  		if(i==0)
					{
				//	alert("inside if")
					obj1.options[obj1.options.length]=new Option('[Select One]','NO-SELECT','true');
					}
		          //	alert("in else");
			obj1.options[obj1.options.length] = new Option(getNodeValue(stype[i],'airPortName'),getNodeValue(stype[i],'airPortName'));
			}
		  }
		}
	}

	 
}
	
	function validateForm(){
	//alert("1");
		var regionID="",airportcode="",reportType="",yearID="",monthID="",yearDesc="",formType="",toYearID="",finalairportcode="";
		var swidth=screen.Width-10;
		var sheight=screen.Height-150;
		var transferFlag="",pfidStrip="";	
		var formType="";
		
		
		formType=document.forms[0].select_formType.options[document.forms[0].select_formType.selectedIndex].text;
		
		
		
		
		
		reportType=document.forms[0].select_reportType.options[document.forms[0].select_reportType.selectedIndex].text;
		if(document.forms[0].select_region.selectedIndex>0){
			regionID=document.forms[0].select_region.options[document.forms[0].select_region.selectedIndex].text;
		}else{
			regionID=document.forms[0].select_region.value;
		}
		if(formType=='NormalCorpusForm' || formType=='CorpusFormwithIntt' || formType=='YearWiseBreakup' || formType=='YearWiseTotal' || formType=='Year wise Summary Total form-Dec 2016' ||formType=='Normal OB Corpus form-Dec 2016'){
		//alert(document.forms[0].empName.value);
		//alert(document.forms[0].select_pfidlst.options[document.forms[0].select_pfidlst.selectedIndex].value);
		if(document.forms[0].empName.value=="" && document.forms[0].select_pfidlst.options[document.forms[0].select_pfidlst.selectedIndex].value=='NO-SELECT'){
			alert("Please Select Employee Name or PFID Printing List");
			document.forms[0].empName.focus();
			return false;
	}
	}
	
		if(formType=='YearWiseTotalForALL'){
		
		document.forms[0].empName.value="";
		document.forms[0].empserialNO.value="";
		}
		
		
		
      	if(document.forms[0].select_airport.length>1){
			finalairportcode=document.forms[0].select_airport.options[document.forms[0].select_airport.selectedIndex].value;
		}else{
			finalairportcode=document.forms[0].select_airport.value;
		}
	
			airportcode=finalairportcode;
		
			if(reportType=='[Select One]'){
				alert('Please Select the Report Type');
				document.forms[0].select_reportType.focus();
				return false;
			}
		
		
		
		if(document.forms[0].select_year.selectedIndex>0){
		yearID=document.forms[0].select_year.options[document.forms[0].select_year.selectedIndex].value;
		}else{
		yearID=document.forms[0].select_year.value;
		}
		if(document.forms[0].select_year.selectedIndex>0){
			toYearID=document.forms[0].select_to_year.options[document.forms[0].select_to_year.selectedIndex].value;
		}else{
			toYearID=document.forms[0].select_to_year.value;
		}
		
		if(document.forms[0].select_month.selectedIndex>0){
		monthID=document.forms[0].select_month.options[document.forms[0].select_month.selectedIndex].value;
		}else{
		monthID=document.forms[0].select_month.value;
		}
	
		//monthID=document.forms[0].select_month.selectedIndex;
	//	if(monthID<10){
	//		monthID="0"+monthID;
	//	}
		
		var empserialNO=document.forms[0].empserialNO.value;
		if(empserialNO=='' ){
			pfidStrip=document.forms[0].select_pfidlst.options[document.forms[0].select_pfidlst.selectedIndex].value;
			
		}else{
		document.forms[0].select_region.value = "NO-SELECT";
		document.forms[0].select_airport.length = 1;
		regionID = "NO-SELECT";
		airportcode = "NO-SELECT";
		pfidStrip  = "NO-SELECT";
		document.forms[0].select_pfidlst.length=1;
		pfidStrip='1 - 1'; 
		}
		//alert(empserialNO+','+pfidStrip);
	//	var	page="PensionContribution";
		var mappingFlag="false";
		var params = "&formType="+formType+"&frm_region="+regionID+"&frm_airportcode="+airportcode+"&frm_year="+yearID+"&frm_month="+monthID+"&frm_reportType="+reportType+"&frm_formType"+formType+"&empserialNO="+empserialNO+"&frm_pfids="+pfidStrip+"&frm_toyear="+toYearID+"&mappingFlag="+mappingFlag+"&frm_bulkprint="+bulkPrintFlag;
		var url ="",params1="";
		 
		// alert(document.forms[0].chkpfid.value);
		 
		//if(document.forms[0].chkpfid.value=="Exists"){
		//var comfirmMsg=confirm("");
	//	alert(comfirmMsg);
		//if (comfirmMsg== true){ 
	    //var page = "report",adjOBYear="1995-2008";
	     // params1 = "&frm_reportType="+reportType+"&frm_formType"+formType+"&empserialNO="+empserialNO+"&reportYear="+adjOBYear+"&page="+page;
		 // url="<%=basePath%>reportservlet?method=getReportPenContrForAdjCrtn"+params1;
		 	//url="<%=basePath%>sbssearch?method=SBSgetReportPenContr"+params;
		//}else{
		if(document.forms[0].dateofJoining.value!=""){		
		var doj = document.forms[0].dateofJoining.value;
		var finaldate=getDate(doj);
		var date1=new Date(2019,03,01); 
	
		}
		//if(document.forms[0].dateofJoining.value==""){
	//	alert("This pfid is not mapped with old data");
	//	return false;
	//	}
		
		 // url="<%=basePath%>reportservlet?method=getReportPenContr"+params;	
		 	url="<%=basePath%>sbssearch?method=SBSgetReportPenContr"+params;	
		  //alert("1111"+url);
		//}
		//}else{		
		
	//	if(document.forms[0].dateofJoining.value!=""){
	//	var doj = document.forms[0].dateofJoining.value;
	//	var finaldate=getDate(doj);
	//	var date1=new Date(2019,03,31);		
	//	if(finaldate >= date1){
	//	alert("this pfid have the date of joining "+doj+" so PC Report can not generated");
	//	return false;
	//	}		
	//	}
	//	if(document.forms[0].dateofJoining.value==""){
	//	alert("This PFID  not have mapped records");
	//	return false;
	//	}		 
	 
		/*if(document.forms[0].PCReportVerified.value=="N"){
		alert("PC Report is Disabled by CHQ.Please contact CHQ Officials");
		return false;
		}*/
		url="<%=basePath%>sbssearch?method=SBSgetReportPenContr"+params;
	//	}
	  //alert(url);
		if(reportType=='html' || reportType=='Html'){
	   	 			 LoadWindow(url);
   		}else if(reportType=='Excel Sheet' || reportType=='ExcelSheet' ){
   				 		wind1 = window.open(url,"winComps","toolbar=yes,statusbar=yes,scrollbars=yes,menubar=yes,resizable=yes,width="+swidth+",height="+sheight+",top=0,left=0");
						winOpened = true;
						wind1.window.focus();
      	}
		
	}
	function getDate(date){	 
	  if(date.indexOf('-')!=-1){
		 elem = date.split('-'); 
	  }else{
		  elem = date.split('/'); 
	  }	  
		 day = elem[0];
		 mon1 = elem[1];
		 year = elem[2];
		 var month;
	   	 if((mon1 == "JAN") || (mon1 == "Jan")) month = 0;
        	else if(mon1 == "FEB" ||(mon1 == "Feb")) month = 1;
     	else if(mon1 == "MAR" || (mon1 == "Mar")) month = 2;
     	else if(mon1 == "APR" || (mon1 == "Apr")) month = 3;
     	else if(mon1 == "MAY" ||(mon1 == "May") ) month = 4;
     	else if(mon1 == "JUN" ||(mon1 == "Jun") ) month = 5;
     	else if(mon1 == "JUL"||(mon1 == "Jul")) month = 6;
     	else if(mon1 == "AUG" ||(mon1 == "Aug")) month = 7;
     	else if(mon1 == "SEP" ||(mon1 == "Sep")) month = 8;
     	else if(mon1 == "OCT"||(mon1 == "Oct")) month = 9;
     	else if(mon1 == "NOV" ||(mon1 == "Nov")) month = 10;
     	else if(mon1 == "DEC" ||(mon1 == "Dec")) month = 11;
	  var finaldate=new Date(year,month,day); 
	   return finaldate;	     	
  }
	 function LoadWindow(params){
    var newParams =params;
	winHandle = window.open(newParams,"Utility","menubar=yes,toolbar= yes,statusbar=1,scrollbars=yes,resizable=yes");
	winOpened = true;
	winHandle.window.focus();
}
	
	
	function getNodeValue(obj,tag)
   	{
		return obj.getElementsByTagName(tag)[0].firstChild.nodeValue;
   	}
	
	function frmload(){
		 process.style.display="none";
	}
	function generateForm(){
		var formType;
		formType=document.forms[0].select_formType.options[document.forms[0].select_formType.selectedIndex].text;
		if(formType=='Employee Wise'){
		}
	}
--></script>
	</HEAD>
	<body class="BodyBackground"   onload="javascript:frmload()">
		<%String monthID = "", yearDescr = "", region = "", monthNM = "";

            ArrayList yearList = new ArrayList();
            Iterator regionIterator = null;
            Iterator monthIterator = null;
            LoginInfo user=null;
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
            if (request.getAttribute("yearList") != null) {
                yearList = (ArrayList) request.getAttribute("yearList");
            }
            if(session.getAttribute("user")!=null){
            user=(LoginInfo)session.getAttribute("user");
            }
            

            %>
		<form action="post">
		   	<div class="page-content-wrapper">
		<div class="page-content">
		<div class="row">
			    <div class="col-md-12">
				<h3 class="page-title">Opening Corpus Statement Params</h3>
				<ul class="page-breadcrumb breadcrumb"></ul>
			    </div>
			</div>
		<fieldset > 
		
			
		<div class="row">
						<div class="col-md-10">
							<div class="form-group">
								<label class="control-label col-md-6">Finance From Year
									
								 : </label>
								
								<div class="col-md-4">
								
								<select name="select_year" ID="select_year" READONLY class="form-control" >
									
										<option value="2007" >2007</option>
										
									 </select>
								
								
								
										
								</div>
							</div>
						</div>
						</div>
						<div class="row">
						<div class="col-md-10">
							<div class="form-group">
								<label class="control-label col-md-6">Finance To Year
								 : </label>
								
								<div class="col-md-4">
										
						<Select name='select_to_year' READONLY class="form-control">
						<% if(user.getProfile().equals("M") ||user.getProfile().equals("N")){%>
						<option value='2021' >2016 </option>
						<%}else{ %>
							<option value='2021' >2021 </option> 
							<%} %>
						</SELECT>
								
								</div>
							</div>
						</div>
					</div>
					
					<div class="row">
						<div class="col-md-10">
							<div class="form-group">
								<label class="control-label col-md-6">Finance To Month
								 : </label>
								
								<div class="col-md-4">
										
							<select name="select_month" class="form-control">
							<% if(user.getProfile().equals("M")||user.getProfile().equals("N")){%>
							<Option Value='03' selected="selected">
								December
							</Option> 
							<%}else{ %>
							<Option Value='03' selected="selected">
								March
							</Option>
							<%} %>
						</select>
								</div>
							</div>
						</div>
					</div>
					
					
					<div class="row">
						<div class="col-md-10">
							<div class="form-group">
								<label class="control-label col-md-6">Region
								 : </label>
								
								<div class="col-md-4">
										
							<SELECT NAME="select_region" class="form-control" id="select_region" onChange="javascript:getAirports('airport');">
							<option value="NO-SELECT">
								[Select One]
							</option>
							<option value="AllRegions">
								AllRegions
							</option>
							<%int j = 0;
                boolean exist = false;
                while (regionIterator.hasNext()) {
                    region = hashmap.get(regionIterator.next()).toString();
                    j++;

                    {%>
							<option value="<%=region%>">
								<%=region%>
							</option>

							<%}
                }

            %>

							
						</SELECT>
								</div>
							</div>
						</div>
					</div>
					
						<div class="row">
						<div class="col-md-10">
							<div class="form-group">
								<label class="control-label col-md-6">Airport Name
								 : </label>
								
								<div class="col-md-4">
										
							<SELECT NAME="select_airport" id="select_airport" class="form-control"   >
								
							  	<option value='NO-SELECT' Selected>[Select One]</option>
	                       		
								</SELECT>
								</div>
							</div>
						</div>
					</div>
					
					
					
						<div class="row">
						<div class="col-md-10">
							<div class="form-group">
								<label class="control-label col-md-6">Page Size
								 : </label>
								
								<div class="col-md-4">
										
							<input type="text" name="frmpagesize" class="form-control" tabindex="3" value="100">
								</div>
							</div>
						</div>
					</div>
					
					
					
					<!--  <div class="row">
						<div class="col-md-10">
							<div class="form-group">
								<label class="control-label col-md-6">Employee Transfer Status
								 : </label>
								
								<div class="col-md-4">
										
						<SELECT NAME="transferStatus" class="form-control">
							<option value="NO-SELECT">
								[Select One]
							</option>
							<option value="Y">
								Yes
							</option>
							<option value="N">
								No
							</option>
						</SELECT>
								</div>
							</div>
						</div>
					</div>-->
					
					
					<div class="row">
						<div class="col-md-10">
							<div class="form-group">
							<% if(user.getProfile().equals("M")){%>
								<label class="control-label col-md-6">User Name<font color=red></font>
								 : </label>
								<%}else{ %>
								<label class="control-label col-md-6">Employee Name<font color=red></font>
								 : </label>
								<%} %>
								<div class="col-md-4">
								<% if(!user.getProfile().equals("M")){ %>
						<input type="text" name="empName" id="empName" readonly="true" class="form-control" tabindex="3"></DIV>
						
						<div class="col-md-1"><img src="<%=basePath%>/PensionView/images/search1.gif" onclick="popupWindow('<%=basePath%>PensionView/SBS/SBSPensionContributionMappedListWithoutTransfer.jsp','AAI');" alt="Click The Icon to Select EmployeeName" />
						<input type="hidden" name="empserialNO" id="empserialNO" readonly="true" tabindex="3" />
						<%}else{ %>
						<input type="text" name="empName" id="empName" value='<%=user.getUserName() %>'readonly="true" class="form-control" tabindex="3"></DIV>
						<div class="col-md-1">
						<input type="hidden" name="empserialNO" id="empserialNO" value='<%=user.getPensionNo()%>'readonly="true" tabindex="3" />
						
						
						<% }%>
						
						<input type="hidden" name="chk_frmblkprint" id="" value="false" />
						<input type="hidden" name="chkpfid" id="chkpfid" />
						<input type="hidden" name="dateofJoining" id="dateofJoining" />
						<input type="hidden" name="PCReportVerified" id="PCReportVerified" />
								</div>
							</div>
						</div>
					</div>
					
					<div class="row">
						<div class="col-md-10">
							<div class="form-group">
								<label class="control-label col-md-6">Form Type<font color=red>*</font>:
								 </label>
								
								<div class="col-md-4">
									<SELECT NAME="select_formType" id="select_formType" class="form-control" >
							<% if(user.getProfile().equals("M")){ %>
							<option value="Normal OB Corpus form-Dec 2016">
								Normal OB Corpus form-Dec 2016
							</option>
							<option value="Year wise Summary Total form-Dec 2016">
								Year wise Summary Total form-Dec 2016
							</option>
							
							<!--  <option value="NormalCorpusForm">
								NormalCorpusForm
							</option>
							<option value="YearWiseBreakup">
								YearWiseBreakup
							</option>-->
							<%}else if(user.getProfile().equals("N")){ %>
							
							<option value="EmployeeWiseTotalNormal">
								EmployeeWiseTotalNormal 
							</option>
							<option value="Normal OB Corpus form-Dec 2016">
								Normal OB Corpus form-Dec 2016
							</option>
							<option value="Employee Year wise OB Corpus form-Dec 2016">
								Employee Year wise OB Corpus form-Dec 2016
							</option>
							<option value="Year wise Summary Total form-Dec 2016">
								Year wise Summary Total form-Dec 2016
							</option>
							<%}else { %>
							<option value="CorpusFormwithIntt">
								CorpusFormwithIntt 
							</option>
								<option value="NormalCorpusForm">
								NormalCorpusForm
							</option>
							<option value="Normal OB Corpus form-Dec 2016">
								Normal OB Corpus form-Dec 2016
							</option>
							<option value="EmployeeWiseTotalNormal">
								EmployeeWiseTotalNormal 
							</option>
							 
							<option value="YearWiseBreakup">
								YearWiseBreakup
							</option>
					    <option value="EmployeeWiseTotal">
								EmployeeWiseTotal 
							</option>
						<option value="YearWiseTotal">
								YearWiseTotal 
						</option>
						<option value="YearWiseTotalForALL">
								YearWiseTotalForALL 
						</option>
						<option value="monthWise">
								monthWise 
						</option>
						<option value="Employee Year wise OB Corpus form-Dec 2016">
								Employee Year wise OB Corpus form-Dec 2016
							</option>
							<option value="Year wise Summary Total form-Dec 2016">
								Year wise Summary Total form-Dec 2016
							</option>
						<%
						}
						
						 if(session.getAttribute("userid").toString().equals("SBSAdmin")){ %>
						<option value="Processing">
								Processing 
						</option>
						<% }%>
						</SELECT>
								</div>
							</div>
						</div>
					</div>
					
					
						<div class="row">
						<div class="col-md-10">
							<div class="form-group">
								<label class="control-label col-md-6">Report Type<font color=red></font>:
								 </label>
								
								<div class="col-md-4">
									<SELECT NAME="select_reportType" id="select_reportType" class="form-control" onChange="javascript:getAirports('pfid')">
							
							<option value="html">
								Html
							</option>
							<option value="ExcelSheet">
								Excel Sheet
							</option>
					    
						</SELECT>
								</div>
							</div>
						</div>
					</div>
					
					
					
					
					
					
						
					<div class="row">
						<div class="col-md-10">
							<div class="form-group">
								<label class="control-label col-md-6">PF ID Printing List: </label>
								
								<div class="col-md-4">
									<SELECT NAME="select_pfidlst" id="select_pfidlst" class="form-control" >
								
							  	<option value='NO-SELECT' Selected>[Select One]</option>
	                       		
								</SELECT>
								</div>
							</div>
						</div>
					</div>
					
					
					
					
					
					
					<div style="height: 20px;">
		</div>
		
		
		
		
			<div class="col-md-12">
									<div class="col-md-5">&nbsp;</div>
									<div class="col-md-7">
										<input type="button" value="Submit" name="Submit" class="btn green"  onclick="javascript:validateForm()"></input>
										<input type="button" class="btn blue" value="Reset" onclick="javascript:resetReportParams()" class="btn">
										<input type="button" class="btn dark" value="Cancel" onclick="javascript:history.back(-1)" class="btn">
										<!--<input type="button" class="btn orange" value="Bulk Print" onclick="javascript:bulkreport('<%=session.getAttribute("userid")%>')" class="btn">
						
									--></div>
								
								</div>
				
					
					
					
					
					
					
					</fieldset>
					</div></div>
			




		</form>
<div id="process" style="position: fixed;width: auto;height:35%;top: 200px;right: 0;bottom: 100px;left: 10em;" align="center" >
			<img src="<%=basePath%>PensionView/images/Indicator.gif" border="no" align="middle"/>
			<SPAN class="label" >Processing.......</SPAN>
		</div>

	</body>
</html>
