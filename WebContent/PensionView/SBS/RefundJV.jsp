
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
		 
		
		
		url="<%=basePath%>SBSAnnuityServlet?method=RefundJournalVoucher"+params;
	
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
	function test(empname,empSerialNo,appid){
		document.JVForm.empName.value=empname;
		  document.JVForm.empserialNO.value=empSerialNo;
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
		<form name="JVForm"  action="post">
		<form >
			<div class="page-content-wrapper">
				<div class="page-content">
					<div class="row">
						<div class="col-md-12">
							<h3 class="page-title">
								Refund Journal Voucher
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
										System.out.println("user.getProfile=="+user.getProfile());
											if (!user.getProfile().equals("M")) {
										%>
										<input type="text" name="empName" id="empName" readonly="true"
											class="form-control" tabindex="3">
									</DIV>

									<div class="col-md-1">
										<img src="<%=basePath%>/PensionView/images/search1.gif"
											onclick="popupWindow('<%=basePath%>PensionView/SBS/JVEmployees.jsp','AAI');"
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
												Journal Voucher
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
										<SELECT NAME="select_reportType" id="select_reportType" class="form-control">

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
