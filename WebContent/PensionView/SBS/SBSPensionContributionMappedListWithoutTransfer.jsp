
<%@ page language="java" import="java.util.*,aims.common.*"%>
<%@ page isErrorPage="true"%>
<%@ page import="aims.bean.PensionBean"%>

<%String path = request.getContextPath();
            String basePath = request.getScheme() + "://"
                    + request.getServerName() + ":" + request.getServerPort()
                    + path + "/";
            String region = "";
            CommonUtil common = new CommonUtil();

            HashMap hashmap = new HashMap();
            hashmap = common.getRegion();

            Set keys = hashmap.keySet();
            Iterator it = keys.iterator();
             String transferStatus="",adjPfidChkFlag="",statemntRevisdChkFlag="",frmName="",pcReportChkFlag="false";
            if(request.getParameter("transferStatus")!=null){
             transferStatus=request.getParameter("transferStatus").toString();
           // out.println("transferStatus "+transferStatus);
            }else{
            transferStatus="";
            }
             if(request.getParameter("region")!=null){
             region=request.getParameter("region").toString();
           // out.println("region "+region);
            }else{
            	if(request.getAttribute("region")!=null){
            		 region=(String)request.getAttribute("region");
            	}else{
            		 region="";
            	}
           
            }  
            if(request.getParameter("adjPfidChkFlag")!=null){
             adjPfidChkFlag=request.getParameter("adjPfidChkFlag").toString();
           // out.println("transferStatus "+transferStatus);
            }else{
            adjPfidChkFlag="";
            }  
            if(request.getParameter("statemntRevisdChkFlag")!=null){
             statemntRevisdChkFlag=request.getParameter("statemntRevisdChkFlag").toString();
          // out.println("statemntRevisdChkPfid "+statemntRevisdChkPfid);
            }else{
            statemntRevisdChkFlag="";
            }            
           if(request.getParameter("frmName")!=null){
             frmName=request.getParameter("frmName").toString();           
            }else{
            frmName="";
            }  
          if(request.getParameter("pcReportChkFlag")!=null){
             pcReportChkFlag=request.getParameter("pcReportChkFlag").toString();
          
            }else{
            pcReportChkFlag="";
            }  
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<base href="<%=basePath%>">

		<title>AAI</title>
		<LINK rel="stylesheet" href="<%=basePath%>PensionView/css/aai.css" type="text/css">
		<link href="<%=basePath%>../assets/plugins/font-awesome/css/font-awesome.min.css"
			rel="stylesheet" type="text/css" />
		<link href="<%=basePath%>../assets/plugins/bootstrap/css/bootstrap.min.css"
			rel="stylesheet" type="text/css" />
		<link href="<%=basePath%>../assets/plugins/uniform/css/uniform.default.css"
			rel="stylesheet" type="text/css" />
		<!-- END GLOBAL MANDATORY STYLES -->
		<!-- BEGIN THEME STYLES -->
		<link href="<%=basePath%>../assets/css/style-metronic.css" rel="stylesheet"
			type="text/css" />
		<link href="<%=basePath%>../assets/css/style.css" rel="stylesheet" type="text/css" />
		<link href="<%=basePath%>../assets/css/style-responsive.css" rel="stylesheet"
			type="text/css" />
		<link href="<%=basePath%>../assets/css/plugins.css" rel="stylesheet" type="text/css" />
		<link href="<%=basePath%>../assets/css/themes/default.css" rel="stylesheet"
			type="text/css" id="style_color" />
		<link href="<%=basePath%>../assets/css/custom.css" rel="stylesheet" type="text/css" />
		<!-- END THEME STYLES -->
<!-- <link rel="shortcut icon" href="favicon.ico" /> -->
		<link href="<%=basePath%>../assets/plugins/data-tables/DT_bootstrap.css"
			rel="stylesheet" type="text/css" />
		<script src="<%=basePath%>../assets/plugins/jquery-1.10.2.min.js"
			type="text/javascript"></script>
		<script src="<%=basePath%>../assets/plugins/jquery-1.10.2.min.js"
			type="text/javascript"></script>
		<script src="<%=basePath%>../assets/plugins/jquery-migrate-1.2.1.min.js"
			type="text/javascript"></script>
		<script src="<%=basePath%>../assets/plugins/bootstrap/js/bootstrap.min.js"
			type="text/javascript"></script>
		<script
			src="<%=basePath%>../assets/plugins/bootstrap-hover-dropdown/twitter-bootstrap-hover-dropdown.min.js"
			type="text/javascript"></script>
		<script
			src="<%=basePath%>../assets/plugins/jquery-slimscroll/jquery.slimscroll.min.js"
			type="text/javascript"></script>
		<script src="<%=basePath%>../assets/plugins/jquery.blockui.min.js"
			type="text/javascript"></script>
		<script src="<%=basePath%>../assets/plugins/jquery.cokie.min.js"
			type="text/javascript"></script>
		<script src="<%=basePath%>../assets/plugins/uniform/jquery.uniform.min.js"
			type="text/javascript"></script>

		<script src="<%=basePath%>../assets/scripts/app.js"></script>
		<script type="text/javascript" src="<%=basePath%>../assets/plugins/bootstrap-datepicker/js/bootstrap-datepicker.js"></script>
		<script type="text/javascript" src="<%=basePath%>../assets/plugins/bootstrap-datetimepicker/js/bootstrap-datetimepicker.js"></script>
	
		<script type="text/javascript"> 
		
  
  	
  	function statusdisplay(){
  	
  		  document.getElementById("suggestions").style.display="block";
		  document.getElementById("suggestions").innerHTML="";
		   var str="";
		   str+="<table>"; 
   		  
   		   str+="<tr><td>&nbsp;</td></tr><tr><td colspan='5' id='status'><img src='<%=basePath%>PensionView/images/loading1.gif'></td></tr><tr><td>&nbsp;</td></tr>";
		   str+="</table>";
		  document.getElementById("suggestions").innerHTML=str;
		 
  	
  	}
	function testSS(){
	
  	  var region1= document.forms[0].region1[document.forms[0].region1.options.selectedIndex].text;
  	  if(document.forms[0].empName.value=="" && document.forms[0].pfId.value=="" && document.forms[0].uanNo.value==""){
  		 alert("Please Enter EmployeeName or PFID or UAN Number");
  		  document.forms[0].empName.focus();
  		  return false;
  	  }
        
   		var empName=document.forms[0].empName.value;
   		//var transferType="no";
   		var transferType="";
   		var pfId = document.forms[0].pfId.value;
   		var uanNo = document.forms[0].uanNo.value;
   		statusdisplay();   
   		var pcreport="pcreport";
   		var url ="<%=basePath%>sbssearch?method=getEmployeeMappedList&region="+region1+"&empName="+empName+"&uanNo="+uanNo+"&transferType="+'<%=transferStatus%>'+"&pfId="+pfId+"&screen="+pcreport+"&adjPfidChkFlag="+'<%=adjPfidChkFlag%>'+"&statemntRevisdChkFlag="+'<%=statemntRevisdChkFlag%>'+"&frmName="+'<%=frmName%>'+"&pcReportChkFlag="+'<%=pcReportChkFlag%>';
   		//alert(url);
   		    
	    document.forms[0].action=url;
	    document.forms[0].method="post";
		document.forms[0].submit();
		
	}	
	 function editPensionMaster(cpfaccno,region,pensionNumber,employeeName,dateofbirth,empSerialNo){
	 var mappedInfo=cpfaccno+"@"+region+"@"+pensionNumber+"@"+employeeName+"@"+dateofbirth+"@"+empSerialNo;
	// var url="<%=basePath%>PensionView/UniquePensionNumberGeneration.jsp?mappedInfo="+mappedInfo;
	// alert("url"+url);
	//document.forms[0].action=url;
	//document.forms[0].method="post";
	//document.forms[0].submit();
	alert("old");
	 //window.opener.test(cpfaccno,region,pensionNumber,employeeName,dateofbirth,empSerialNo);	
	 window.close();	 
	}
	 </script>
	 <style type="text/css">.btn.green {
    color: white;
    text-shadow: none;
    background-color: #35aa47;
}
body {
	background: #fff !important;
}
</style>
	</head>

	<body>
		<form>
		<div class="row" style="margin-top: 50px;">
						<div class="col-md-6">
							<div class="form-group">
								<label class="control-label col-md-6">
									Region :
								</label>

								<div class="col-md-6">
									<SELECT NAME="region1" class="form-control">
					
							<%if (session.getAttribute("usertype").equals("SBSUser")) {%>
							<option value="">[Select One]</option>
              				<%int j = 0;
							boolean exist = false;
							while (it.hasNext()) {
							String region1 = hashmap.get(it.next()).toString();
							j++;
							if (region1.equalsIgnoreCase(region))
							exist = true;
							if (region1.equalsIgnoreCase(region)) {
							%>
							
							<option value="<%=region%>" <% out.println("selected");%>>
								<%=region%>
							</option>
							<%} else {%>
							<option value="<%=region1%>">
								<%=region1%>
							</option>

							<%}}}else{%>
                             
							<option value="<%=region%>"><%=region%></option>
                            <%if(!region.equals("AllRegions")) {%>
							<option value="AllRegions">AllRegions</option>
                             <%}%>
							<%}%>
						</SELECT>

								</div>
							</div>
						</div>
						<div class="col-md-6">
							<div class="form-group">
								<label class="control-label col-md-5">
									Employee Name: :
								</label>

								<div class="col-md-6">
									<input type="text"  name="empName" onkeyup="return limitlength(this, 20)" class="form-control">



								</div>
							</div>
						</div>
					</div>
					<div class="row">
						<div class="col-md-6">
							<div class="form-group">
								<label class="control-label col-md-6">
									UAN NO:
								</label>

								<div class="col-md-6">
									<input type="text" name="uanNo" onkeyup="return limitlength(this, 20)" class="form-control">

								</div>
							</div>
						</div>
						<div class="col-md-6">
							<div class="form-group">
								<label class="control-label col-md-5">
									PF ID :
								</label>

								<div class="col-md-6">
									<input type="text" name="pfId" onkeyup="return limitlength(this, 20)" class="form-control">



								</div>
							</div>
						</div>
					</div>
		<div class="col-md-12" >
									<div class="col-md-6">&nbsp;</div>
									<div class="col-md-6">
													<input type="button" class="btn green" value="Search"   onclick="testSS();">
						
									</div>
								
			</div>
				<div id="suggestions"></div>

			<%PensionBean dbBeans = new PensionBean();

            if (request.getAttribute("MappedList") != null) {
                ArrayList datalist = new ArrayList();
                int totalData = 0;
                datalist = (ArrayList) request.getAttribute("MappedList");
                System.out.println("dataList " + datalist.size());

                if (datalist.size() == 0) {

                %>
			<div class="row">
											<div class="col-md-6">&nbsp;</div>
									<div class="col-md-6">
			<font color="blue">No Records Found</font>
			</div>
</div>
			<%} else if (datalist.size() != 0) {%>
			<tr>
				<td height="25%">
					<table align="center" width="97%" cellpadding=2 class="tbborder" cellspacing="0" border="0">
						<tr class="tbheader">
						<td class="tblabel">Serial No
							</td>
							<td class="tblabel">
								CPF NO
							</td>
							<td class="tblabel">
								Region
							</td>
							<td class="tblabel">
								PFID
								<br>
								No&nbsp;&nbsp;
							</td>
							<td class="tblabel">
								Pension Number&nbsp;&nbsp;
							</td>
							<td class="tblabel">
								Employee Name&nbsp;&nbsp;
							</td>
							<td class="tblabel">
								UAN Number&nbsp;&nbsp;
							</td>
							<td class="tblabel">
								D.O.B
							</td>

							<td>
								<img src="./PensionView/images/page_edit.png" alt="edit" />
								&nbsp;

							</td>


						</tr>

						<%}%>
						<%int count = 0;
                String airportCode = "", employeeName = "", cpfacno = "", pensionNumber = "",uanNumber="";
                String dateofBirth = "", empSerialNo = "", dateofJoining = "";
                for (int i = 0; i < datalist.size(); i++) {
                    count++;
                    PensionBean beans = (PensionBean) datalist.get(i);

                    cpfacno = beans.getCpfAcNo();
                    employeeName = beans.getEmployeeName();
                    pensionNumber = beans.getPensionnumber();
                    uanNumber = beans.getUanNo();
                    dateofBirth = beans.getDateofBirth();
                    dateofJoining = beans.getDateofJoining();
                    region = beans.getRegion();
                    empSerialNo = beans.getEmpSerialNumber();
                    if (count % 2 == 0) {

                    %>
						<tr>
							<%} else {%>
						<tr>
							<%}%>
							
							<td class="Data" width="12%">
								<%=count%>
							</td>
							<td class="Data" width="12%">
								<%=cpfacno%>
							</td>
							<td class="Data" width="12%">
								<%=region%>
							</td>
							<td class="Data" width="12%">
								<%=empSerialNo%>
							</td>
							<td class="Data">
								<%=pensionNumber%>
							</td>
                            <td class="Data">
								<%=uanNumber%>
							</td>
							<td class="Data" width="12%">
								<%=employeeName%>
							</td>
							<td class="Data">
								<%=dateofBirth%>
							</td>

							<td>
								<input type="checkbox" name="cpfno" value="<%=cpfacno%>" onclick="javascript:editPensionMaster('<%=cpfacno%>','<%=region%>','<%=pensionNumber%>','<%=employeeName%>','<%=dateofBirth%>','<%=empSerialNo%>')" />
							</td>

						</tr>
						<%}%>


						<%}%>

					</table>
				</td>

			</tr>
</form>
	</body>
</html>
