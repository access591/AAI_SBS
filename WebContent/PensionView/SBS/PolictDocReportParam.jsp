
<%@ page language="java" import="java.util.*,aims.common.CommonUtil,aims.common.Constants" pageEncoding="UTF-8"%>
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
  
	 function Search(){

		
   		 var empNameCheak="",airportID="",sortColumn="EMPLOYEENAME",day="",month="",year="",pfid="";
	
		var reportType=document.forms[0].select_reportType.options[document.forms[0].select_reportType.selectedIndex].text;
   	
	//pfid=document.forms[0].empserialNO.value;

   		
   		var fromdate,todate;
   		fromdate=document.forms[0].fromdate.value;
   		todate=document.forms[0].todate.value;
		var url='';
		url="<%=basePath%>SBSAnnuityServlet?method=policyDocReport&r&fromdate="+fromdate+"&todate="+todate+"&frm_reportType="+reportType;
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
     				document.forms[0].action="<%=basePath%>SBSAnnuityServlet?method=policyDocReportParam&&menu=M7L3";
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
  
  <body >
  
   <form name="personalMaster"  >
  
   	<div class="page-content-wrapper">
		<div class="page-content">
			<div class="row">
			    <div class="col-md-12">
				<h3 class="page-title">Policy Document Report Params</h3>
				<ul class="page-breadcrumb breadcrumb"></ul>
			    </div>
			</div>
		<fieldset>
		 <div class="row">
                                    <div class="col-md-10">

                                       
                                            <div class="form-group ">
                                                <label class="control-label col-md-6">
                                               Policy  From Date<span class="required"></span>
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
                                               Policy   To Date<span class="required"></span>
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
							
							<option value="Eligible">
Policy DOcument							</option>
						
					    
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
					
		
  </body>
</html>

