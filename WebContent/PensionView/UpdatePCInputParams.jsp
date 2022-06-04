
<%@ page language="java" import="java.util.*,aims.common.CommonUtil,aims.common.Constants" contentType="text/html;charset=utf-8" pageEncoding="UTF-8"%>
<%@ page import="aims.bean.FinancialYearBean"%>
<%@ page import="aims.service.FinancialService"%>
<%@ page import="java.util.ArrayList"%>
<%String path = request.getContextPath();
            String basePath = request.getScheme() + "://"
                    + request.getServerName() + ":" + request.getServerPort()
                    + path + "/";
  String[] year = {"1995-2008","2008-2009","2009-2010"};      
            %>
<html>
	<HEAD>
		<LINK rel="stylesheet" href="<%=basePath%>PensionView/css/aai.css" type="text/css">

		<script type="text/javascript">

 function LoadWindow(params){
	var newParams ="<%=basePath%>PensionView/Report.jsp?"+params
	winHandle = window.open(newParams,"Utility","menubar=yes,toolbar = yes,scrollbars=yes,resizable=yes");
	winOpened = true;
	winHandle.window.focus();
}
 
 	function test(cpfaccno,region,pensionNumber,employeeName,dateofbirth,empSerialNo){
			document.forms[0].empName.value=employeeName;
			document.forms[0].empserialNO.value=empSerialNo;
		  			
		}
	
	function resetReportParams(){
		document.forms[0].action="<%=basePath%>reportservlet?method=loadUpdatePC";
		document.forms[0].method="post";
		document.forms[0].submit();
	}
	
	function popupWindow(mylink, windowname)
		{
		
		//var transfer=document.forms[0].transferStatus.value;
		var transfer="";
	
		var regionID="";
		if(document.forms[0].select_region.selectedIndex>0){
			regionID=document.forms[0].select_region.options[document.forms[0].select_region.selectedIndex].text;
		}else{
			regionID=document.forms[0].select_region.value;
		}
		if (! window.focus)return true;
		var href;
		if (typeof(mylink) == 'string')
		   href=mylink+"?transferStatus="+transfer+"&region="+regionID;
		   
		else
		href=mylink.href+"?transferStatus="+transfer+"&region="+regionID;
	    
		progress=window.open(href, windowname, 'width=700,height=500,statusbar=yes,scrollbars=yes,resizable=yes');
		
		return true;
		}

	
	function validateForm() {
		var regionID="",airportcode="",reportType="",yearID="",monthID="",yearDesc="",formType="",chkMappingFlag="";
		var swidth=screen.Width-10;
		var sheight=screen.Height-150;
		var transferFlag="",pfidStrip="";	
		if(document.forms[0].select_region.selectedIndex>0){
			regionID=document.forms[0].select_region.options[document.forms[0].select_region.selectedIndex].text;
		}else{
			regionID=document.forms[0].select_region.value;
		}
		
      	if(document.forms[0].select_airport.length>1){
			airportcode=document.forms[0].select_airport.options[document.forms[0].select_airport.selectedIndex].value;
		}else{
			airportcode=document.forms[0].select_airport.value;
		}


		
		transferFlag=document.forms[0].transferStatus.options[document.forms[0].transferStatus.selectedIndex].value;
		
		if(document.forms[0].select_year.selectedIndex>0){
		yearID=document.forms[0].select_year.options[document.forms[0].select_year.selectedIndex].value;
		}else{
		yearID=document.forms[0].select_year.value;
		}
		if(document.forms[0].select_month.selectedIndex>0){
		monthID=document.forms[0].select_month.options[document.forms[0].select_month.selectedIndex].value;
		}else{
		monthID=document.forms[0].select_month.value;
		}
		
			if (document.forms[0].chk_mapFlag.checked==true){
	              chkMappingFlag="true";
       	}else{
	       		  chkMappingFlag="false";
       	}
	
		//monthID=document.forms[0].select_month.selectedIndex;
		if(monthID<10){
			monthID="0"+monthID;
		}
		var empserialNO=document.forms[0].empserialNO.value;

		var params = "&frm_region="+regionID+"&frm_airportcode="+airportcode+"&frm_year="+yearID+"&frm_month="+monthID+"&frm_formType"+formType+"&empserialNO="+empserialNO+"&transferStatus="+transferFlag+"&frm_pfids="+pfidStrip+"&frm_chkMappingFlag="+chkMappingFlag;
		var url="<%=basePath%>reportservlet?method=updatePCReport"+params;
			document.forms[0].action=url;
			document.forms[0].method="post";
			document.forms[0].submit();
		
		
	}
	 function LoadWindow(params){
    var newParams =params;
	winHandle = window.open(newParams,"Utility","menubar=yes,toolbar= yes,statusbar=1,scrollbars=yes,resizable=yes");
	winOpened = true;
	winHandle.window.focus();
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
		var transferFlag,airportcode;
		regionID=document.forms[0].select_region.options[document.forms[0].select_region.selectedIndex].text;
		createXMLHttpRequest();	
		if(param=='airport'){
			var url ="<%=basePath%>psearch?method=getAirports&region="+regionID;
			xmlHttp.open("post", url, true);
			xmlHttp.onreadystatechange = getAirportsList;
		}
		
		
		
		xmlHttp.send(null);
    }
	function getNodeValue(obj,tag)
   	{
		return obj.getElementsByTagName(tag)[0].firstChild.nodeValue;
   	}
	function getAirportsList()
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
		 	var obj1 = document.getElementById("select_airport");
		 
		 	
		  	obj1.options.length=0; 
		  	obj1.options[obj1.options.length]=new Option('[Select One]','NO-SELECT','true');
		 
		  
		  }else{
		   	var obj1 = document.getElementById("select_airport");
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

	function frmload(){
		 process.style.display="none";
	}
	function generateForm(){
		var formType;
		formType=document.forms[0].select_formType.options[document.forms[0].select_formType.selectedIndex].text;
		if(formType=='Employee Wise'){
		}
	}
</script>
	</HEAD>
	<body class="BodyBackground" onload="javascript:frmload()">
		<%String monthID = "", yearDescr = "", region = "", monthNM = "";

            ArrayList yearList = new ArrayList();
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
            if (request.getAttribute("yearList") != null) {
                yearList = (ArrayList) request.getAttribute("yearList");
            }

            %>
		<form action="post">
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

			<table width="75%" border="0" align="center" cellpadding="0" cellspacing="0" class="tbborder">
				<tr>
					<td height="5%" colspan="2" align="center" class="ScreenMasterHeading">
						Adj in Opening Balances PF Card Params
					</td>
				</tr>
				<tr>
					<td>
						&nbsp;
					</td>
				</tr>
				<%
							String successMessage="";
							if(request.getAttribute("success")!=null){
            				successMessage=(String)request.getAttribute("success");
            				}
						%>
            		<tr>
					<td>
				
						<%=successMessage%>
					</td>
				</tr>
								<tr>
					<td class="label" align="right">
						Year:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					</td>
					<td>
						<Select name='select_year' Style='width:100px'>
							<option value='NO-SELECT'>
								Select One
							</option>
					<%for (int j = 0; j < year.length; j++) {%>
																			<option value='<%=year[j]%>'>
																				<%=year[j]%>
																			</option>
																			<%}%>
						</SELECT>
										<input type="checkbox" name="chk_mapFlag">
					</td>
				</tr>
				<tr>
					<td class="label" align="right">
						Month:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					</td>
					<td>
						<select name="select_month" style="width:100px">
							<Option Value='NO-SELECT'>
								Select One
							</Option>

							<%while (monthIterator.hasNext()) {
                Map.Entry mapEntry = (Map.Entry) monthIterator.next();
                monthID = mapEntry.getKey().toString();
                monthNM = mapEntry.getValue().toString();

                %>

							<option value="<%=monthID%>">
								<%=monthNM%>
							</option>
							<%}%>
						</select>
					</td>
				</tr>
				<!-- 	<TR>
							<td class=label align="right" nowrap > Pension Form Type: <font color=red>*</font>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
							<td>
								<SELECT NAME="select_formType" style="width:88px" onchange="generateForm()">
	                       					<option ="yearwise">Year Wise</option>
	                       					<option ="monthwise">Month Wise</option>
	                       					<option ="employeewise">Employee Wise</option>
								</SELECT>
										
							</td>&nbsp;&nbsp;
						</TR>-->
				<tr>
					<td class="label" align="right">
						Region:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					</td>
					<%if (session.getAttribute("usertype").equals("Admin")) {

                %>
					<td>
						<SELECT NAME="select_region" style="width:130px" onChange="javascript:getAirports('airport')">
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

							<%}

            %>
						</SELECT>
					</td>
				</tr>
				<tr>
							<td class="label" align="right">Aiport Name:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </td>
							<td>									
								<SELECT NAME="select_airport" style="width:120px" >
								
							  	<option value='NO-SELECT' Selected>[Select One]</option>
	                       		
								</SELECT>
							</td>
						</tr>
				<tr>
					<td class="label" align="right">
						Employee Transfer Status:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					</td>
					<td>
						<SELECT NAME="transferStatus" style="width:88px" >
							
							<option value="Y">
								Yes
							</option>
							<option value="N">
								No
							</option>
						</SELECT>
					</td>

				</tr>

				<tr>
					<td class="label" align="right">
						Employee Name:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					</td>
					<td>
						<input type="text" name="empName" readonly="true" tabindex="3">
						<img src="<%=basePath%>/PensionView/images/search1.gif" onclick="popupWindow('<%=basePath%>PensionView/PensionContributionMappedListWithoutTransfer.jsp','AAI');" alt="Click The Icon to Select EmployeeName" />
					</td>

				</tr>
				
			
				<tr>
				<tr>
					<td align="center">
						&nbsp;&nbsp;&nbsp;&nbsp;
					</td>
				</tr>

				<input type="hidden" name="empserialNO" readonly="true" tabindex="3">




				<tr>
					<td align="right">
						<input type="button" class="btn" name="Submit" value="Submit" onclick="javascript:validateForm()">
						<input type="button" class="btn" name="Reset" value="Reset" onclick="javascript:resetReportParams()">
						<input type="button" class="btn" name="Submit" value="Cancel" onclick="javascript:history.back(-1)">
					</td>
				</tr>
				<tr>
					<td align="center"></td>
				</tr>
			</table>



		</form>
<div id="process" style="position: fixed;width: auto;height:35%;top: 200px;right: 0;bottom: 100px;left: 10em;" align="center" >
			<img src="<%=basePath%>PensionView/images/Indicator.gif" border="no" align="middle"/>
			<SPAN class="label" >Processing.......</SPAN>
		</div>

	</body>
</html>
