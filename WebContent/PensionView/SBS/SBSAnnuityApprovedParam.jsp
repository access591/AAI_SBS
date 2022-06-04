
<%@ page language="java" import="java.util.*,aims.common.CommonUtil,aims.common.Constants,java.lang.*,aims.dao.CommonDAO" contentType="text/html;charset=utf-8" pageEncoding="UTF-8"%>

<%@ page import="aims.bean.EmployeePersonalInfo" %>
<%@ page import="aims.bean.*" %>

<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<html lang="en" class="no-js">
<jsp:include page="/SBSHeader.jsp"></jsp:include>
<jsp:include page="/PensionView/SBS/Menu.jsp"></jsp:include>
<head>
	<script type="text/javascript"> 
  
     var swidth=screen.Width-10;
	var sheight=screen.Height-150;
    
 
 
 function createXMLHttpRequest()
{
if (window.XMLHttpRequest) {    
	xmlHttp = new XMLHttpRequest();   
} else if(window.ActiveXObject) {    
      try {     
       xmlHttp = new ActiveXObject("Msxml2.XMLHTTP");    
       } catch (e) {     
       		try {      
       			xmlHttp = new ActiveXObject("Microsoft.XMLHTTP");     
       		} catch (e) {      
       			xmlHttp = false;     
       		}    
       	}          		
 } 
 }

		function getNodeValue(obj,tag)
		   {
			return obj.getElementsByTagName(tag)[0].firstChild.nodeValue;
		   }
		
	function getAirports(){	
		var regionID;
		regionID=document.forms[0].select_region.options[document.forms[0].select_region.selectedIndex].text;
		createXMLHttpRequest();	
		var url ="<%=basePath%>SBSAnnuityServlet?method=getAirports&region="+regionID;
		//alert("url==="+url);
		xmlHttp.open("post", url, true);
		xmlHttp.onreadystatechange = getAirportsList;
		xmlHttp.send(null);
    }
	function getAirportsList()
	 {
		if(xmlHttp.readyState ==4)
		{
			//alert("xmlHttp.status===="+xmlHttp.status);
		 if(xmlHttp.status == 200)
			{ 
			 var stype = xmlHttp.responseXML.getElementsByTagName('ServiceType');
			  if(stype.length==0){
			 	var obj1 = document.getElementById("select_airport");
			   	obj1.options.length=0; 
			   	obj1.options[obj1.options.length]=new Option('Select One','','true');
			  }else{
			   	var obj1 = document.getElementById("select_airport");
			   	obj1.options.length = 0;
			  	for(i=0;i<stype.length;i++){
			  if(i==0){	obj1.options[obj1.options.length]=new Option('Select One','','true');
			}
		obj1.options[obj1.options.length] = new Option(getNodeValue(stype[i],'airPortName'),getNodeValue(stype[i],'airPortName'));
		  	}
			  
				  }
			}
		}
	}
	
	
		
	function frmload(){
 		process.style.display="none";
 		
	}
	 function Search(){

		process.style.display="none";
   		 var empNameCheak="",airportID="",sortColumn="EMPLOYEENAME",day="",month="",year="",pfid="";
	var fromdate = document.forms[0].fromdate.value;
	var todate = document.forms[0].todate.value;
	var reportType=document.forms[0].select_reportType.options[document.forms[0].select_reportType.selectedIndex].text;
   	//var formType=document.forms[0].select_formType.options[document.forms[0].select_formType.selectedIndex].text;
   	var formType= document.forms[0].select_formType.value;
	//pfid=document.forms[0].empserialNO.value;

   		var regionID;
   		regionID=document.forms[0].select_region.options[document.forms[0].select_region.selectedIndex].text;
   		airportID=document.forms[0].select_airport.options[document.forms[0].select_airport.selectedIndex].text;
   		//alert(regionID);
		var url='';
		url="<%=basePath%>SBSAnnuityServlet?method=AnnuityApprovedReport&region="+regionID+"&airPortCode="+airportID+"&frm_reportType="+reportType+"&formType="+formType+"&fromdate="+fromdate+"&todate="+todate;
		if(reportType=='html' || reportType=='Html'){
	   	 			 LoadWindow(url);
   		}else if(reportType=='Excel Sheet' || reportType=='ExcelSheet' ){
   		//alert("url "+url);	
   	 				 		wind1 = window.open(url,"winComps","toolbar=yes,statusbar=yes,scrollbars=yes,menubar=yes,resizable=yes,width="+swidth+",height="+sheight+",top=0,left=0");
   	 				 		winOpened = true;
							wind1.window.focus();
      	}
			}

	function LoadWindow(params){
	var newParams ="<%=basePath%>PensionView/Report.jsp?"+params
	winHandle = window.open(newParams,"Utility","menubar=yes,toolbar = yes,scrollbars=yes,resizable=yes");
	winOpened = true;
	winHandle.window.focus();
}
	
   
    
     
		function resetMaster(){
     				document.forms[0].action="<%=basePath%>SBSAnnuityServlet?method=AnnuityApprovedReportParam&&menu=M4L6";
					document.forms[0].method="post";
					document.forms[0].submit();
			
		}
		
		
		
	
		
		
		
    </script>
  
  </head>
  <%
  	HashMap hashmap=new HashMap();
  	String region="";
  	Iterator regionIterator=null;
  	if(request.getAttribute("regionHashmap")!=null){
  	hashmap=(HashMap)request.getAttribute("regionHashmap");
  	Set keys = hashmap.keySet();
	regionIterator = keys.iterator();
  	}
  %>
  
  <body onload="javascript:frmload()">
  
   <form name="personalMaster"  method="post">
  
   	<div class="page-content-wrapper">
		<div class="page-content">
			<div class="row">
			    <div class="col-md-12">
				<h3 class="page-title">Annuity Approved Report Params</h3>
				<ul class="page-breadcrumb breadcrumb"></ul>
			    </div>
			</div>
		<fieldset>   
		                        <div class="row">
                                    <div class="col-md-10">
                                            <div class="form-group ">
                                                <label class="control-label col-md-6">
                                                  From Date<span class="required"></span>
                                                    :
                                                </label>
                                                <div class="col-md-6">
                                                    <div class="input-group input-medium date date-picker col-md-12"  data-date-format="dd-M-yyyy" data-date-viewmode="years" data-date-minviewmode="months">
                                                        <input type="text" name="fromdate" class="form-control" " readonly>
                                                        <span class="input-group-btn">
                                                            <button class="btn default" type="button" style="padding: 4px 14px;"><i class="fa fa-calendar"></i></button>
                                                        </span>
                                                    </div>
                                                </div>
                                            </div>
                                        
                                        </div>
                                        </div>
										 <div class="row">
                                    <div class="col-md-10">
                                            <div class="form-group ">
                                                <label class="control-label col-md-6">
                                                  To Date<span class="required"></span>
                                                    :
                                                </label>
                                                <div class="col-md-6">
                                                    <div class="input-group input-medium date date-picker col-md-12"  data-date-format="dd-M-yyyy" data-date-viewmode="years" data-date-minviewmode="months">
                                                        <input type="text" name="todate" class="form-control" " readonly>
                                                        <span class="input-group-btn">
                                                            <button class="btn default" type="button" style="padding: 4px 14px;"><i class="fa fa-calendar"></i></button>
                                                        </span>
                                                    </div>
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
									 <SELECT NAME="select_region" onChange="javascript:getAirports()"  class="form-control">
							<option value="NO-SELECT">[Select One]</option>
								<%
						     	  while(regionIterator.hasNext()){
							 	  region=hashmap.get(regionIterator.next()).toString();
							 	%>
							  	<option value="<%=region%>" ><%=region%></option>
	                       		<%}%>
							</SELECT>
									
										
								</div>
							</div>
						</div>
						</div>
						<div class="row">
						<div class="col-md-10">
							<div class="form-group">
								<label class="control-label col-md-6">Airport Code
								 : </label>
								
								<div class="col-md-4">
								<select name="select_airport" id="select_airport" class="form-control" >
								<option value="NO-SELECT">[Select One]</option>
						    </select>
										
								
								</div>
							</div>
						</div>
					</div>
		
		
		
		
			<div class="row">
						<div class="col-md-10">
							<div class="form-group">
								<label class="control-label col-md-6">Report Type<font color=red></font>
									
								 : </label>
								
								<div class="col-md-4">
								
								
								<SELECT NAME="select_reportType"  id="select_reportType" class="form-control" >
									
									<option value="html">Html</option>
									<option value="ExcelSheet">Excel Sheet</option>
									
								</SELECT>
								
										
								</div>
							</div>
						</div>
						</div>
						<div class="row">
						<div class="col-md-10">
							<div class="form-group">
								<label class="control-label col-md-6">Form Type<font color=red></font>:
									
								  </label>
								
								<div class="col-md-4">
										<SELECT NAME="select_formType" id="select_formType" class="form-control">
							
							<option value="SBI">
								SBI Annuity Approved Report
							</option>
						<option value="HDFC">
								HDFC Annuity Approved Report
							</option>

						<option value="LIC">
								LIC Annuity Approved Report
							</option>
							<option value="RCForm">
								RCForm Annuity Approved Report
							</option>
					    
						</SELECT>
										
								
								</div>
							</div>
						</div>
					</div>
		
	
		
		
		
		
		
			<div class="col-md-12">
									<div class="col-md-4">&nbsp;</div>
									<div class="col-md-8">
										<input type="button" value="Search" class="btn green" onclick="Search();"></input>
										<input type="button" class="btn blue" value="Reset" onclick="javascript:resetMaster()" class="btn">
										<input type="button" class="btn dark" value="Cancel" onclick="javascript:history.back(-1)" class="btn">
						
									</div>
								
								</div>
				</fieldset>
							
			</div>
			</div>
			</form>
					
		<div id="process" style="position: fixed;width: auto;height:35%;top: 200px;right: 0;bottom: 100px;left: 10em;" align="center" >
			<img src="<%=basePath%>PensionView/images/Indicator.gif" border="no" align="middle"/>
			<SPAN class="label" >Processing.......</SPAN>
		</div>
  </body>
</html>

