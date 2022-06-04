
<%@ page language="java" import="java.util.*,aims.common.*"%>
<%@ page isErrorPage="true"%>
<%@ page import="aims.bean.*"%>

<%String path = request.getContextPath();
            String basePath = request.getScheme() + "://"
                    + request.getServerName() + ":" + request.getServerPort()
                    + path + "/";
            String region = "",chkpfid="",statemntRevisdChkPfid="",PCAftrSepFlag="";
            CommonUtil common = new CommonUtil();

            HashMap hashmap = new HashMap();
            
            hashmap = common.getRegion();
            String fndRegion="";
			if(request.getAttribute("fndregion")!=null){
				fndRegion=(String)request.getAttribute("fndregion");
			}else{
				fndRegion="";
			}
			if(request.getAttribute("chkpfid")!=null){
				chkpfid=(String)request.getAttribute("chkpfid");
			} 
			if(request.getAttribute("statemntRevisdChkPfid")!=null){
				statemntRevisdChkPfid=(String)request.getAttribute("statemntRevisdChkPfid");
			} 
			if(request.getAttribute("PCAftrSepFlag")!=null){
				PCAftrSepFlag=(String)request.getAttribute("PCAftrSepFlag");
			} 
            Set keys = hashmap.keySet();
            Iterator it = keys.iterator();
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
		
		<LINK rel="stylesheet" href="<%=basePath%>PensionView/css/aai.css" type="text/css">
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
  	 if(document.forms[0].empName.value=="" && document.forms[0].pfId.value==""){
  		 alert("Please Enter EmployeeName or PFID");
  		  document.forms[0].empName.focus();
  		  return false;
  	  }
  	 
   		var empName=document.forms[0].empName.value;
   		var pfId = document.forms[0].pfId.value;
   		var transferStatus="",pcreport="pcreport";
   		var url ="<%=basePath%>sbssearch?method=getEmployeeMappedList&region="+region1+"&empName="+empName+"&transferType="+transferStatus+"&pfId="+pfId+"&screen="+pcreport;
   		
   		
   		statusdisplay();       
	    document.forms[0].action=url;
	    document.forms[0].method="post";
		document.forms[0].submit();
	}
	
	
	 function editPensionMaster(cpfaccno,region,pensionNumber,employeeName,dateofbirth,empSerialNo,dateofJoining,pcreportverified){
	 
	 var mappedInfo=cpfaccno+"@"+region+"@"+pensionNumber+"@"+employeeName+"@"+dateofbirth+"@"+empSerialNo+"@"+dateofJoining;
	// var url="<%=basePath%>PensionView/UniquePensionNumberGeneration.jsp?mappedInfo="+mappedInfo;
	// alert("url"+url);
	//document.forms[0].action=url;
	//document.forms[0].method="post";
	//document.forms[0].submit();
	var chkpfid='<%=chkpfid%>';
	var statemntRevisdChkPfid ='<%=statemntRevisdChkPfid%>';
	var PCAftrSepFlag='<%=PCAftrSepFlag%>';
	 window.opener.test(cpfaccno,region,pensionNumber,employeeName,dateofbirth,empSerialNo,chkpfid,dateofJoining,pcreportverified,statemntRevisdChkPfid,PCAftrSepFlag);	
	 window.close();
	 
	}
	 </script>
	 <style type="text/css">
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
									<SELECT NAME="region1"  class="form-control">
						<%if (session.getAttribute("usertype").equals("Admin")) {

                      %>
							<option value="">[Select One]</option>
							<%int j = 0;
                boolean exist = false;
                while (it.hasNext()) {
                    region = hashmap.get(it.next()).toString();
                    j++;

                    {%>
							<option value="<%=region%>">
								<%=region%>
							</option>

							<%}
                }

            %>

							<%}else{%>           
            <option value="<%=fndRegion%>">
								<%=fndRegion%>
							</option>
    <%if(!region.equals("AllRegions")){%>
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
									<input type="text" size=15 name="empName" onkeyup="return limitlength(this, 20)" class="form-control">
								</div>
							</div>
						</div>
					</div>
					<div class="row">
						<div class="col-md-6">
							<div class="form-group">
								<label class="control-label col-md-6">
									UAN NO :
								</label>

								<div class="col-md-6">
									<input type="text" size=12 name="uanNo" onkeyup="return limitlength(this, 20)" class="form-control">
								</div>
							</div>
						</div>
						<div class="col-md-6">
							<div class="form-group">
								<label class="control-label col-md-5">
									PF ID :
								</label>

								<div class="col-md-6">
									<input type="text" size=8 name="pfId" onkeyup="return limitlength(this, 20)" class="form-control">
								</div>
							</div>
						</div>
					</div>
					<div class="col-md-12" >
									<div class="col-md-6">&nbsp;</div>
									<div class="col-md-6">
												<input type="button"   value="Search" class="btn green"  onclick="testSS();">	
						
									</div>
								
			</div>
			
	         <div id="suggestions"></div>
			<%PensionBean dbBeans = new PensionBean();		
            if (request.getAttribute("MappedList") != null) {
                ArrayList datalist = new ArrayList();  
                 ArrayList emplist = new ArrayList();             
                int totalData = 0;
                datalist = (ArrayList) request.getAttribute("MappedList");
                emplist = (ArrayList) request.getAttribute("EmpInfoList");
                System.out.println("emplist----- " + emplist.size());
                if (datalist.size() == 0) {
               %>
		<table width="100%">	<tr>

				<td>
					<table align="center" id="norec" width="100%">
						<tr>
						
							<td align="center">
						
						<img alt="" src="../images/info.gif">		<b> No Records Found </b>
							</td>
						</tr>
					</table>
				</td>
			</tr>

			<%} else if (datalist.size() != 0) {%>
			<tr>
				<td height="25%">
					<table align="center" width="97%" cellpadding=2 class="sample" cellspacing="0" border="0">
						<tr>
						<th>
								Serial No
							</th>
							<th>
								CPF NO
							</th>
							<th>
								Region
							</th>
							
							<th>
								Pension Number&nbsp;&nbsp;
							</th>
							<th>
								UAN Number&nbsp;&nbsp;
							</th>
							<th>
								Emp Name&nbsp;&nbsp;
							</th>
							<th>
								D.O.B
							</th>
							<th>
								Pension Option
							</th>							
							<th>
						<i class="fa fa-pencil-square" aria-hidden="true"></i>
								</th>
						</tr>
						<%}%>
						<%int count = 0;
                String airportCode = "", employeeName = "", cpfacno = "", pensionNumber = "",uanNumber="";
                String dateofBirth = "", empSerialNo = "", dateofJoining = "",pensionOption="",pcreportverified="";             
                for (int i = 0; i < datalist.size(); i++) {
                                    count++;
                    PensionBean beans = (PensionBean) datalist.get(i);                    
         if(emplist.size()==0)
                {                	
                	 dateofJoining = "";
                }else{
                EmpMasterBean bean =(EmpMasterBean) emplist.get(i);
                 dateofJoining = bean.getDateofJoining();
                  pcreportverified = bean.getPcverified();
                }
                    cpfacno = beans.getCpfAcNo();
                    employeeName = beans.getEmployeeName();
                    pensionNumber = beans.getPensionnumber();
                    uanNumber = beans.getUanNo();
                    dateofBirth = beans.getDateofBirth();
                    region = beans.getRegion();
                    empSerialNo = beans.getEmpSerialNumber();
                    pensionOption = beans.getPensionOption();
                   
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
							<td class="Data" width="15%">
								<%=region%>
							</td>
							<td class="Data" width="12%">
								<%=empSerialNo%>
							</td>
							<td class="Data">
								<%=uanNumber%>
							</td>
							<td class="Data" width="17%">
								<%=employeeName%>
							</td>
							<td class="Data" width="17%">
								<%=dateofBirth%>
							</td>
							<td class="Data">
								<%=pensionOption%>
							</td>                            
							<td>
								<input type="checkbox" name="cpfno" value="<%=cpfacno%>" onclick="javascript:editPensionMaster('<%=cpfacno%>','<%=region%>','<%=pensionNumber%>','<%=employeeName%>','<%=dateofBirth%>','<%=empSerialNo%>','<%=dateofJoining%>','<%=pcreportverified%>')" />
							</td>

						</tr>
						<%}%>


						<%}%>

					</table>
				</td>

			</tr>
</table>
</form>
	</body>
</html>
