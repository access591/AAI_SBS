
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>


<%@ page language="java"
	import="java.util.*,aims.common.CommonUtil,aims.common.Constants"
	pageEncoding="UTF-8"%>
<%@ page import="aims.bean.EmployeePersonalInfo"%>
<%@ page import="aims.bean.*"%>
<%@ page import="aims.bean.FinancialYearBean"%>
<%@ page import="aims.service.FinancialService"%>
<%@ page import="java.util.ArrayList"%>

<html>
	<jsp:include page="/SBSHeader.jsp"></jsp:include>
	<jsp:include page="/PensionView/SBS/Menu.jsp"></jsp:include>
	<HEAD>
		

		<script type="text/javascript">
	function yearSelect(){

				var date = new Date();
				var year = parseInt(date.getFullYear());
				
				//for(cnt=2020;cnt<=2021;cnt++){
				for(cnt=2020;cnt<=2021;cnt++){
					var yearEnd = (""+(cnt+1)).substring(0,4);
					document.forms[0].finyear.options.add(new Option(cnt+"-"+yearEnd,cnt+"-"+yearEnd)) ;				
				}				
			
			}
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
		
	function resetReportParams(){
		document.forms[0].action="<%=basePath%>SBSAnnuityServlet?method=RefundJV";
		document.forms[0].method="post";
		document.forms[0].submit();
	}	
	function popupWindow(mylink, windowname)
		{		
		//var transfer=document.forms[0].transferStatus.value;
		var transfer="";
		var regionID="",adjPfidChkFlag="true",pcReportChkFlag="true";
		
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

		var regionID="",airportcode="",reportType="",yearID="",monthID="",yearDesc="",formType="",toYearID="",finalairportcode="";
		var swidth=screen.Width-10;
		var sheight=screen.Height-150;
		var transferFlag="",pfidStrip="";	
		var formType="";
		var finyear="";
		
		
		formType=document.forms[0].select_formType.options[document.forms[0].select_formType.selectedIndex].text;
		
		//alert(formType);
		
		
		reportType=document.forms[0].select_reportType.options[document.forms[0].select_reportType.selectedIndex].text;
		
		
		
		var empserialNO=document.forms[0].empserialNO.value;
		if(empserialNO=='' ){
			pfidStrip=document.forms[0].select_pfidlst.options[document.forms[0].select_pfidlst.selectedIndex].value;
			
		}
		//alert(empserialNO+','+pfidStrip);
	//	var	page="PensionContribution";
		var mappingFlag="false";
		var params = "&formType="+formType+"&frm_reportType="+reportType+"&frm_formType"+formType+"&empserialNO="+empserialNO;
		var url ="",params1="";
		 
		
		
		url="<%=basePath%>SBSAnnuityServlet?method=Refundpaymentvocher"+params;
	
		if(reportType=='html' || reportType=='Html'){
	   	 			 LoadWindow(url);
   		}else if(reportType=='Excel Sheet' || reportType=='ExcelSheet' ){
   		
   	 				 		wind1 = window.open(url,"winComps","toolbar=yes,statusbar=yes,scrollbars=yes,menubar=yes,resizable=yes,width="+swidth+",height="+sheight+",top=0,left=0");
   	 				 		winOpened = true;
							wind1.window.focus();
      	}
		
	}


	
	
	function getNodeValue(obj,tag)
   	{
		return obj.getElementsByTagName(tag)[0].firstChild.nodeValue;
   	}
	
	function frmload(){
		 process.style.display="none";
	}
	</script>
	</HEAD>
	<body class="BodyBackground"
		onload="javascript:frmload()">
		<%

			
			LoginInfo user = null;
			HashMap hashmap = new HashMap();
			
			if (session.getAttribute("user") != null) {
				user = (LoginInfo) session.getAttribute("user");
			}
		%>
		<form action="post">
			<div class="page-content-wrapper">
				<div class="page-content">
					<div class="row">
						<div class="col-md-12">
							<h3 class="page-title">
								 payment Voucher
							</h3>
							<ul class="page-breadcrumb breadcrumb"></ul>
						</div>
					</div>
					<fieldset>						


						<div class="row">
							<div class="col-md-10">
								<div class="form-group">
									<label class="control-label col-md-6">
										Employee Name
										<font color=red></font> :
									</label>

									<div class="col-md-4">
										<%
											if (!user.getProfile().equals("M")) {
										%>
										<input type="text" name="empName" id="empName" readonly="true"
											class="form-control" tabindex="3">
									</DIV>

									<div class="col-md-1">
										<img src="<%=basePath%>/PensionView/images/search1.gif"
											onclick="popupWindow('<%=basePath%>PensionView/SBS/SBSPensionContributionMappedListWithoutTransfer.jsp','AAI');"
											alt="Click The Icon to Select EmployeeName" />
										<input type="hidden" name="empserialNO" id="empserialNO"
											readonly="true" tabindex="3" />
										<%
											} else {
										%>
										<input type="text" name="empName" id="empName"
											value='<%=user.getUserName()%>' readonly="true"
											class="form-control" tabindex="3">
									</DIV>
									<div class="col-md-1">
										<input type="hidden" name="empserialNO" id="empserialNO"
											value='<%=user.getPensionNo()%>' readonly="true" tabindex="3" />


										<%
											}
										%>
										
									</div>
								</div>
							</div>
						</div>

						<div class="row">
							<div class="col-md-10">
								<div class="form-group">
									<label class="control-label col-md-6">
										Form Type
										<font color=red>*</font>:
									</label>

									<div class="col-md-4">
										<SELECT NAME="select_formType" id="select_formType"
											class="form-control">

											<option value="SBSCARD">
												payment Voucher
											</option>


										</SELECT>
									</div>
								</div>
							</div>
						</div>


						<div class="row">
							<div class="col-md-10">
								<div class="form-group">
									<label class="control-label col-md-6">
										Report Type
										<font color=red></font>:
									</label>

									<div class="col-md-4">
										<SELECT NAME="select_reportType" id="select_reportType"
											class="form-control"
											onChange="javascript:getAirports('pfid')">

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

						<div style="height: 20px;">
						</div>




						<div class="col-md-12">
							<div class="col-md-5">
								&nbsp;
							</div>
							<div class="col-md-7">
								<input type="button" value="Submit" name="Submit"
									class="btn green" onclick="javascript:validateForm()"></input>
								<input type="button" class="btn blue" value="Reset"
									onclick="javascript:resetReportParams()" class="btn">
								<input type="button" class="btn dark" value="Cancel"
									onclick="javascript:history.back(-1)" class="btn">
							</div>

						</div>







					</fieldset>
				</div>
			</div>





		</form>
		<div id="process"
			style="position: fixed; width: auto; height: 35%; top: 200px; right: 0; bottom: 100px; left: 10em;"
			align="center">
			<img src="<%=basePath%>PensionView/images/Indicator.gif" border="no"
				align="middle" />
			<SPAN class="label">Processing.......</SPAN>
		</div>

	</body>
</html>
