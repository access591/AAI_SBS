
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
    var monthtext=['--','Jan','Feb','Mar','Apr','May','Jun','Jul','Aug','Sept','Oct','Nov','Dec'];
     var swidth=screen.Width-10;
	var sheight=screen.Height-150;
    
    function getNodeValue(obj,tag){
		return obj.getElementsByTagName(tag)[0].firstChild.nodeValue;
   	}
   	function createXMLHttpRequest(){
		if(window.ActiveXObject){
			xmlHttp = new ActiveXObject("Microsoft.XMLHTTP");
	 	}else if (window.XMLHttpRequest){
			xmlHttp = new XMLHttpRequest();
		 }
	}
	function getAirports(){	
		var regionID;
		regionID=document.forms[0].select_region.options[document.forms[0].select_region.selectedIndex].text;
		createXMLHttpRequest();	
		var url ="<%=basePath%>reportservlet?method=getAirports&region="+regionID;
		xmlHttp.open("post", url, true);
		xmlHttp.onreadystatechange = getAirportsList;
		xmlHttp.send(null);
    }
	function getAirportsList(){
		if(xmlHttp.readyState ==3 ||  xmlHttp.readyState ==2 ||  xmlHttp.readyState ==1){
		 	process.style.display="block";
		}
		if(xmlHttp.readyState ==4){
			if(xmlHttp.status == 200){ 
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
		  				if(i==0){
							obj1.options[obj1.options.length]=new Option('[Select One]','NO-SELECT','true');
						}
						obj1.options[obj1.options.length] = new Option(getNodeValue(stype[i],'airPortName'),getNodeValue(stype[i],'airPortName'));
					}
		  		}
			}
		}
	}
	function form9Report(pensionNo,obj,employeeName,employeeCode,region,airportCode,dateOfBirth,index,totalData){
			
			var flag="true";
			
			var url="<%=basePath%>psearch?method=frmForm9Report&cpfacno="+obj+"&name="+employeeName+"&flag="+flag+"&empCode="+employeeCode+"&region="+region+"&airportCode="+airportCode+"&startIndex="+index+"&totalData="+totalData+"&frm_PensionNo="+pensionNo+"&frm_dateOfBirth="+dateOfBirth;
		
			wind1 = window.open(url,"winComps","toolbar=yes,statusbar=yes,scrollbars=yes,menubar=yes,resizable=yes,width="+swidth+",height="+sheight+",top=0,left=0");
		}
		
	function frmload(){
 		process.style.display="none";
 		populatedropdown("daydropdown", "monthdropdown", "yeardropdown");
	}
	 function Search(){
		
		process.style.display="none";
   		 var empNameCheak="",airportID="",sortColumn="EMPLOYEENAME",day="",month="",year="";
	
		
   		var dob=document.forms[0].dob.value;
		var doj=document.forms[0].doj.value;
		 if(!document.forms[0].dob.value==""){
	   		    var date1=document.forms[0].dob;
	   		   var val1=convert_date(date1);
	   	   
	   		    if(val1==false)
	   		     {
	   		      return false;
	   		     }
	   		    }
		 if(!document.forms[0].doj.value==""){
	   		    var date1=document.forms[0].doj;
	   	        var val1=convert_date(date1);
	   		    if(val1==false)
	   		     {
	   		      return false;
	   		     }
	   		    }
		 var employeeNo=document.forms[0].employeeCode.value;
		 var cpfaccno=document.forms[0].cpfaccno.value;
		// alert("emp no "+employeeNo +"cpfaccno "+cpfaccno +"dob "+dob+"doj"+doj);
   		var regionID;
		if(document.forms[0].select_region.selectedIndex>0){
			regionID=document.forms[0].select_region.options[document.forms[0].select_region.selectedIndex].text;
		}else{
			regionID=document.forms[0].select_region.value;
			
		}
		if(document.forms[0].select_airport.selectedIndex>0){
			airportID=document.forms[0].select_airport.options[document.forms[0].select_airport.selectedIndex].text;
		}else{
			airportID=document.forms[0].select_airport.value;
			
		}
		
		 //alert("in search" +"<%=basePath%>sbssearch?method=searchPersonal&region="+regionID+"&airPortCode="+airportID+"&frm_sortingColumn="+sortColumn+"&frm_dateOfBirth="+dob+"&doj="+doj+"&cpfaccno="+cpfaccno+"&employeeNo="+employeeNo);
		document.forms[0].action="<%=basePath%>sbssearch?method=searchPersonal&region="+regionID+"&airPortCode="+airportID+"&frm_sortingColumn="+sortColumn+"&frm_dateOfBirth="+dob+"&doj="+doj+"&cpfaccno="+cpfaccno+"&employeeNo="+employeeNo;
	  	document.forms[0].method="post";
		document.forms[0].submit();
	}

	
		function callReport(){
   		var reportID="",sortColumn="EMPLOYEENAME";
   	 	reportID=document.forms[0].select_reportType.options[document.forms[0].select_reportType.selectedIndex].text;
   	 	var url="<%=basePath%>sbssearch?method=SBSpersonalEmpReport&reportType="+reportID+"&frm_sortcolumn="+sortColumn;
   	 	wind1 = window.open(url,"winComps","toolbar=yes,statusbar=yes,scrollbars=yes,menubar=yes,resizable=yes,width="+swidth+",height="+sheight+",top=0,left=0");
   	 }

     function editPensionMaster(pfid,obj,employeeName,employeeCode,region,airportCode,index,totalData){

					var flag="true";
					document.forms[0].action="<%=basePath%>psearch?method=personalEdit&cpfacno="+obj+"&name="+employeeName+"&flag="+flag+"&empCode="+employeeCode+"&region="+region+"&airportCode="+airportCode+"&startIndex="+index+"&totalData="+totalData+"&pfid="+pfid;
					document.forms[0].method="post";
					document.forms[0].submit();
			
		}
     function viewPersonalDetails(pfid,obj,employeeName,employeeCode,region,airportCode,index,totalData){

			var flag="true";
			var view="true";
			var url="<%=basePath%>sbssearch?method=personalEdit&cpfacno="+obj+"&name="+employeeName+"&flag="+flag+"&empCode="+employeeCode+"&region="+region+"&airportCode="+airportCode+"&startIndex="+index+"&totalData="+totalData+"&pfid="+pfid+"&view="+view;
			
			//wind1 = window.open(url,"winComps","toolbar=yes,statusbar=yes,scrollbars=yes,menubar=yes,resizable=yes,width="+swidth+",height="+sheight+",top=0,left=0");
	   document.forms[0].action=url;
					document.forms[0].method="post";
					document.forms[0].submit();
	   
	    }
     
		function resetMaster(){
     				document.forms[0].action="<%=basePath%>sbssearch?method=loadPerMstr";
					document.forms[0].method="post";
					document.forms[0].submit();
			
		}
		function form2Report(pensionNo,obj,employeeName,employeeCode,region,airportCode,dateOfBirth,index,totalData){
			var flag="true";
			
			var url="<%=basePath%>psearch?method=frmForm2Report&cpfacno="+obj+"&name="+employeeName+"&flag="+flag+"&empCode="+employeeCode+"&region="+region+"&airportCode="+airportCode+"&startIndex="+index+"&totalData="+totalData+"&frm_PensionNo="+pensionNo+"&frm_dateOfBirth="+dateOfBirth;
			wind1 = window.open(url,"winComps","toolbar=yes,statusbar=yes,scrollbars=yes,menubar=yes,resizable=yes,width="+swidth+",height="+sheight+",top=0,left=0");
		}
		
		
		function populatedropdown(dayfield, monthfield, yearfield){
		var today=new Date();
		var dayfield=document.getElementById(dayfield);
		var monthfield=document.getElementById(monthfield);
		var yearfield=document.getElementById(yearfield);
		for (var i=0; i<=31; i++){
		if(i==0){
		dayfield.options[i]=new Option("--","--")
		}else{
			dayfield.options[i]=new Option(i, i+1)
		}
		
		}
	
		for (var m=0; m<=12; m++){
		monthfield.options[m]=new Option(monthtext[m], monthtext[m]);
		}
	
		//select today's month
		var thisyear=today.getFullYear();
		var beginyear=1939;
		var size=thisyear-beginyear;
		for (var y=0; y<=size; y++){
		yearfield.options[y]=new Option(beginyear, beginyear);
		beginyear+=1
		}
		yearfield.options[0]=new Option("--","--", true, true); //select today's year
		}
		window.onload=function(){
			populatedropdown("daydropdown", "monthdropdown", "yeardropdown");
		}
		
		function redirectPageNav(navButton,index,totalValue){      
		var sortColumn="EMPLOYEENAME";
		document.forms[0].action="<%=basePath%>sbssearch?method=sbspersonalnav&navButton="+navButton+"&strtindx="+index+"&total="+totalValue+"&frm_sortingColumn="+sortColumn;
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
  
   <form name="personalMaster" action="" method="post">
  
   	<div class="page-content-wrapper">
		<div class="page-content">
			<div class="row">
			    <div class="col-md-12">
				<h3 class="page-title">PF ID[Search]</h3>
				<ul class="page-breadcrumb breadcrumb"></ul>
			    </div>
			</div>
			<fieldset>
		
		<div class="row">
						<div class="col-md-6">
							<div class="form-group">
								<label class="control-label col-md-6">Region
									
								 : </label>
								
								<div class="col-md-6">
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
						<div class="col-md-6">
							<div class="form-group">
								<label class="control-label col-md-4">Airport Code
								 : </label>
								
								<div class="col-md-6">
								<select name="select_airport" id="select_airport" class="form-control" >
								<option value="NO-SELECT">[Select One]</option>
						    </select>
										
								
								</div>
							</div>
						</div>
					</div>
		
		<div class="row">
						<div class="col-md-6">
							<div class="form-group">
								<label class="control-label col-md-6">Employee Name
									
								 : </label>
								
								<div class="col-md-6">
									 <input type="text" name="empName" class="form-control" >
										
								</div>
							</div>
						</div>
						<div class="col-md-6">
							<div class="form-group">
								<label class="control-label col-md-4">PF ID
								 : </label>
								
								<div class="col-md-6">
								<input type="text" name="pensionNO" onkeyup="return limitlength(this, 20)"  class="form-control" >
								
								</div>
							</div>
						</div>
					</div>
		
			
		
		<div class="row">
						<div class="col-md-6">
							<div class="form-group">
								<label class="control-label col-md-6">Employee Code
									
								 : </label>
								
								<div class="col-md-6">
									<input type="text" name="employeeCode" class="form-control" >
										
								</div>
							</div>
						</div>
						<div class="col-md-6">
							<div class="form-group">
								<label class="control-label col-md-4">Old CPFACC No
								 : </label>
								
								<div class="col-md-6">
							<input type="text" name="cpfaccno" class="form-control">
								
								</div>
							</div>
						</div>
					</div>
			
		
		<div class="row">
						<div class="col-md-6">
							<div class="form-group">
								<label class="control-label col-md-6">Date Of Birth
									
								 : </label>
								
								<div class="col-md-6">
								
								<div class="input-icon">
											<i class="fa fa-calendar"></i> <input
												class="form-control date-picker" size="16"
												placeholder="dd-Mmm-yyyy" NAME="dob" id="dob"
												data-date-format="dd-M-yyyy" data-date-viewmode="years"
												type="text" >
										</div>
									</div>
							</div>
						</div>
						<div class="col-md-6">
							<div class="form-group">
								<label class="control-label col-md-4"> Date of Joining: 
								 : </label>
								
								<div class="col-md-6">
								<div class="input-icon">
											<i class="fa fa-calendar"></i> <input
												class="form-control date-picker" size="16"
												placeholder="dd-Mmm-yyyy" NAME="doj" id="doj"
												data-date-format="dd-M-yyyy" data-date-viewmode="years"
												type="text" >
										</div>
						</div>
							</div>
						</div>
					</div>
						
				<div class="row">
						<div class="col-md-6">
							<div class="form-group">
								<label class="control-label col-md-6">UAN
									
								 : </label>
								
								<div class="col-md-6">
									<input type="text" name="uan" tabindex="9" class="form-control" onkeyup="return limitlength(this, 20)">	
								</div>
							</div>
						</div>
					
					</div>
					
   
        <script type="text/javascript">
            $(function () {
                $('#doj').datepicker();
                 $('#dob').datepicker();
            });
        </script>
    

				<div style="height: 20px;">
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
			
					
<br/>
<%	EmployeePersonalInfo dbBeans = new EmployeePersonalInfo();
					SearchInfo getSearchInfo = new SearchInfo();
					int totalData = 0,index = 0;
					
					ArrayList globleDataList = new ArrayList();
					
					if (request.getAttribute("searchBean") != null) {
					SearchInfo searchBean = new SearchInfo();
					ArrayList dataList = new ArrayList();
					BottomGridNavigationInfo bottomGrid = new BottomGridNavigationInfo();
					searchBean = (SearchInfo) request.getAttribute("searchBean");
					dbBeans = (EmployeePersonalInfo) request.getAttribute("searchInfo");
					index = searchBean.getStartIndex();
					//out.println("index "+index);
					session.setAttribute("getSearchBean1", dbBeans);
					dataList = searchBean.getSearchList();
					totalData = searchBean.getTotalRecords();
					bottomGrid = searchBean.getBottomGrid();
					globleDataList.add(dataList);
					
					
					
					
					
					
				%>
				
				
				
				
				
				<%	if (dataList.size()!= 0) {

				%>
				
				
				
				
				
				<br/>
				<div style="height: 20px !important;"></div>
				<div id="no-more-tables" style="width:100% !important; overflow: auto; height: 430px;">
							<div class="row">
								<div class="col-md-12">
									<div class="form-group">
								<table class='col-md-12 table-bordered table-striped table-condensed cf'>
								
								<tr><td align="center">
					
								<input class="btn btn-default" type="button"  alt="first" value="|<" name="First" disable=true onClick="javascript:redirectPageNav('|<','<%=index%>','<%=totalData%>')" <%=bottomGrid.getStatusFirst()%>>
								<input class="btn btn-default" type="button"  alt="pre" value="<" name="Pre"  onClick="javascript:redirectPageNav('<','<%=index%>','<%=totalData%>')" <%=bottomGrid.getStatusPrevious()%>>
								<input class="btn btn-default" type="button" alt="next" value=">" name="Next" onClick="javascript:redirectPageNav('>','<%=index%>','<%=totalData%>')" <%=bottomGrid.getStatusNext()%>>
								<input class="btn btn-default" type="button"  alt="last" value=">|" name="Last" onClick="javascript:redirectPageNav('>|','<%=index%>','<%=totalData%>')" <%=bottomGrid.getStatusLast()%>>
								<SELECT NAME="select_reportType" style="width:130px; height: 33px;" onChange="javascript:callReport()">
									<option value="" >[Select Report]</option>
									<option value="html">Html</option>
									<option value="ExcelSheet">Excel Sheet</option>
									<option value="dbf">DBF</option>
								</SELECT>
								</td></tr>
							
					
				<tr>
					<td height="25%">
					<div id="no-more-tables">
							<div class="row">
								<div class="col-md-12">
									<div class="form-group">
								<table class='col-md-12 table-bordered table-striped table-condensed cf'><thead class='cf'>
								<tr>
								<th class="">View</th>
								<th class="">PF ID&nbsp;&nbsp;</th>
								<th class="">Old <br/>CPFACC.No</th>
								<th class="">Employee Code&nbsp;&nbsp;</th>
								<th class="">Employee Name&nbsp;&nbsp;</th>
								<th class="">Designation</th>
								<th class="">D.O.B</th>
								<th class="">Marital <br/>Status</th>
								<th class="">Pension Option&nbsp;</th>
								<th class="">Fresh Option&nbsp;</th>
								<th class="">Division&nbsp;</th>
								<th class="">Airport Code&nbsp;&nbsp;</th>
								<th class="">Region</th>
								<th class="">Status</th>
								<th class="">New<br/>Empcode&nbsp;&nbsp;</th>
								<th class="">UAN</th>
								<th class="">SBS Option</th>
                               
								
							</tr></thead>
							<%	int count = 0;
								for (int i = 0; i < dataList.size(); i++) {
									count++;
									EmployeePersonalInfo personal = (EmployeePersonalInfo) dataList.get(i);
							%>
								<tbody><TR>
								<td class="" width="5%">
								<a href="javascript:" onClick="javascript:viewPersonalDetails('<%=personal.getOldPensionNo()%>','<%=personal.getCpfAccno()%>','<%=personal.getEmployeeName()%>','<%=personal.getEmployeeNumber()%>','<%=personal.getRegion()%>','<%=personal.getAirportCode()%>','<%=index%>','<%=totalData%>')"><i class="fa fa-eye" aria-hidden="true" style="#0b50b1" title="PersonalInfo"></i></a>
								</td>
								<td class=""><%=personal.getPfID()%></td>
								<td  width="12%"><%=personal.getCpfAccno()%></td>
								<td ><%=personal.getEmployeeNumber()%></td>
								<td  width="12%"><%=personal.getEmployeeName()%></td>
								<td ><%=personal.getDesignation()%></td>
								<td  width="10%"><%=personal.getDateOfBirth()%></td>
								<td  width="10%"><%=personal.getMaritalStatus()%></td>
								<td  width="5%"><%=personal.getWetherOption()%></td>
								<td  width="5%"><%=personal.getFreshPensionOption() %></td>
								<td ><%=personal.getDivision()%></td>
								<td ><%=personal.getAirportCode()%></td>
								<td  width="12%"><%=personal.getRegion()%></td>
								<td  width="12%"><%=personal.getStatus()%></td>
								<td  width="12%"><%=personal.getNewEmployeeNumber() %></td>
								<td  width="12%"><%=personal.getUanno()%></td>
								<td  width="12%"><%=personal.getSbsflag()%></td>
							  
								
								
							</tr>
						<%}%>
							<tr>

								<td  colspan="20" align="center">
									<font color="red"><%=index%></font> &nbsp;Of&nbsp;&nbsp;<font color="red"><%=totalData%></font>&nbsp;Records
								</td>
							</tr>
							
							
						<%}else if(dataList.size()==0){%>
						<tr>

					<td  colspan="20">
						<table align="center" id="norec">
							<tr>
								<td>
									<b> No Records Found </b>
								</td>
							</tr>
						</table>
					</td>
				</tr>
						<%}}%>
						
						
						<!--<script type="text/javascript">
	$(document).ready(function(){
	
	    var dataset  = '<%=globleDataList%>';
	    //[["H.A.ANTHONY","4","09347"], ["M.ANJAIAH","989","09427"], ["RATHOD SEVIYA","995","09545"], ["S. VEERA BRAHMAM","344","10376"]];
	     alert(dataset);
	    //;
	    var datarev=dataset.slice(0,-1);
	    //[["apple","ass","asdsad"],["apple","ass","asdsad"]];
	     //
	    
	   alert(datarev);
	  var revdata=[["H.A.ANTHONY","4","09347"], ["M.ANJAIAH","989","09427"], ["RATHOD SEVIYA","995","09545"], ["S. VEERA BRAHMAM","344","10376"]];
	  
	  //datarev.substring(1,datarev.length);
	  
	  
	  alert("bbbbbbbbbbbbbbb"+revdata);
	    var table = $('#example').DataTable( {
	    	 data: revdata,
	          columns: [
	        	  { title: "Aircraft Keyno"},
	            { title: "Aircraft Type"},
	          
	            { title: "Registration Number"}
	           
	          ],
	          "paging":true,
	          "pageLength":40,
	          "ordering":true
	        });
	});
	</script>


				
	-->

</tbody>
</table>
	</div>
	</div>
	</div>
	</div>
	</td>
	</tr>
	</table>
	
	</div></div>
	

	</div></div></div></div>
		</form>
	
		
  
		<div id="process" style="position: fixed;width: auto;height:35%;top: 200px;right: 0;bottom: 100px;left: 10em;" align="center" >
			<img src="<%=basePath%>PensionView/images/Indicator.gif" border="no" align="middle"/>
			<SPAN class="label" >Processing.......</SPAN>
		</div>
  </body>
</html>
