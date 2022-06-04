<%@ page language="java" import="java.util.*,aims.bean.LicBean,aims.bean.SBSRejectedRemarksBean" pageEncoding="ISO-8859-1"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<html>
<jsp:include page="/SBSHeader.jsp"></jsp:include>
<jsp:include page="/PensionView/SBS/Menu.jsp"></jsp:include>
  <head>
    <base href="<%=basePath%>">
    
    <title>My JSP 'AnnuityApproveForm.jsp' starting page</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
	
	 <% String menu=request.getParameter("menu")!=null?request.getParameter("menu"):""; %>
	   <%
  LicBean bean=null;
  
  bean=request.getAttribute("licBean")!=null?(LicBean)request.getAttribute("licBean"):new LicBean();
  
  System.out.println("App id:::::::::"+bean.getAppId());
   %>
   		<style>
#customers {
  font-family: Arial, Helvetica, sans-serif;
  border-collapse: collapse;
  width: 100%;
}

#customers td, #customers th {
  border: 1px solid #ddd;
  padding: 8px;
}

#customers tr:nth-child(even){background-color: #f2f2f2;}

#customers tr:hover {background-color: #ddd;}

#customers th {
  padding-top: 12px;
  padding-bottom: 12px;
  text-align: left;
  background-color: #328ee8;
  color: white;
}
</style>
<script type="text/javascript">
var detailArray = new Array();
var srno,depFromDate,depToDate,nomineeflag;
function showValues() {    
		 
	 var heading1='Deputation From Date';
	var heading2='Deputation To Date';
	
	var heading3='Save/Clear';
				
var str='<div ><table  width="50%" class="col-md-12 table-bordered table-striped table-condensed cf" >';			
 str+=' <thead class="cf"><TR><th nowrap>'+heading1+'</th><th>'+heading2+'</th><th>'+heading3+'</th></TR></thead><tbody> ';		 
	for(var i=0;i<detailArray.length;i++) {
		
		str+='<TR >';
		str+='<TD >'+detailArray[i][0]+'</TD>';
		str+='<TD >'+detailArray[i][1]+'</TD>';
		
		str+='<TD align=right nowrap  style=width:40px><a href=javascript:void(0) onclick=del('+i+')>';
		str+='<i class="fa fa-trash-o"></i></TD>';
		str+='</TR>';
		
	}
	str+='<tr>';


str+='<TD data-title='+heading1+'> <div class="input-icon"><i class="fa fa-calendar"></i> <input class="form-control date-picker" size="16" placeholder="dd-Mon-yyyy" NAME="nDOB"  id="depFromDate" data-date-format="dd-M-yyyy" data-date-viewmode="years" type="text"></div></TD>';
		
str+='<TD data-title='+heading2+'> <div class="input-icon"><i class="fa fa-calendar"></i> <input class="form-control date-picker" size="16" placeholder="dd-Mon-yyyy" NAME="nDOB"  id="depToDate" data-date-format="dd-M-yyyy" data-date-viewmode="years" type="text"></div></TD>';
		
	
		 str+='<TD data-title='+heading3+'> <a href="javascript:void(0)" onclick="saveDetails();"> <i class="fa fa-check" ></i></a> <a href="javascript:void(0)" onClick="clearDetails();"><i class="fa fa-times" ></i></a></TD>';
str+='</tr>';	
	str+='</tbody></TABLE></div>';
	document.all['detailsTable'].innerHTML = str;


	 $(".date-picker").datepicker({autoclose:true});



}
function setValues() {

	var temp;
	for(var i=0;i<detailArray.length;i++) {
		temp = detailArray[i][0]+'|'+detailArray[i][1];
		document.approve.depDetails.options[document.approve.depDetails.options.length]=new Option('x',temp);
		document.approve.depDetails.options[document.approve.depDetails.options.length-1].selected=true;
	}
}
function saveDetails() {   

	


	 
    save();
  // alert(save)
	showValues();
	clearDetails();
   

	return true;
}
function save()	{  
//alert(document.approve.nDOB.value);
	detailArray[detailArray.length]=[document.approve.depFromDate.value,document.approve.depToDate.value];

}


function clearDetails()	{
	 
  document.approve.depFromDate.value="";
  document.approve.depToDate.value="";
  
}

function del(index) {
	var temp=new Array();
	for(var i=0;i<detailArray.length;i++) {
		if(i!=index)
			temp[temp.length]=detailArray[i];
	}
	detailArray=temp;
	showValues();
	return false;
}


function getReport(appid){

				var formType="N";
			var swidth=screen.Width-10;
			var sheight=screen.Height-150;
			

			
			var url="<%=basePath%>SBSAnnuityServlet?method=annuityReportDownload&&appid="+appid;
			//alert(url);
			wind1 = window.open(url,"winComps","toolbar=yes,statusbar=yes,scrollbars=yes,menubar=yes,resizable=yes,width="+swidth+",height="+sheight+",top=0,left=0");
	   	 	winOpened = true;
			wind1.window.focus();
			
		
		
  }
function validate(){

//alert();
if(document.approve.approveStatus.value=="A"){
if(!this.approve.servicebook.checked){
alert("Please select the Service Book");
document.approve.servicebook.focus();
		return false;
}

if(document.approve.notational.value==""){
alert("Please select the 1)Whether Notional Increment was given or not");
document.approve.notational.focus();
		return false;
}if(document.approve.notationalappearCard.value==""){
alert("please select the 2)If Yes then whether recovery on notional increment is appearing in Corpus card");
document.approve.notationalappearCard.focus();
		return false;
}
if(document.approve.notational.value=='Y' && document.approve.notationalappearCard.value=='N' ){

if(document.approve.obremarks.value==""){
alert("Please Enter the OB remarks Details");
document.approve.obremarks.focus();
		return false;
}
if(document.approve.corpusobadj.value==""){
alert("Please Enter the Corpus OB Adjustment Details");
document.approve.corpusobadj.focus();
		return false;
}
}
if(document.approve.arrear.value==""){
alert("Please select the 3) Whether any arrear iro period prior to 01.01.2007 was paid to employee during 1.1.2007 to till date");
document.approve.arrear.focus();
		return false;
}


if(document.approve.arrear.value=="Y"){
if(document.approve.obadjustment.value==""){
alert("Please Enter the OB Adjustment Details");
document.approve.obadjustment.focus();
		return false;
}




}
if(document.approve.deputationaaitoother.value==""){
alert("Please select the 4) AAI Employee on  deputation from AAI to Other Organization?");
document.approve.deputationaaitoother.focus();
		return false;
}
if(document.approve.approveStatus.value=="A"){
if(document.approve.cad.value=="Y"){
alert("You can't approve CAD Optees ");
document.approve.cad.focus();
return false;
}
if(document.approve.cpse.value=="Y"){
alert("You can't approve CPSE Employees ");
document.approve.cpse.focus();
return false;
}
if(document.approve.crs.value=="Y"){
alert("You can't approve Termination, Dismissal, disciplinary proceedings, lispendens, or due to sudden disappearance (missing) and CRS cases");
document.approve.crs.focus();
return false;
}
if(document.approve.resign.value=="Y"){
alert("You can't approve  Resignation cases ");
document.approve.resign.focus();
return false;
}
if(document.approve.vrs.value=="Y"){
alert("You can't approve Cases of VRS/VSS-officials who take VRS before 50 years of age ");
document.approve.vrs.focus();
return false;
}
if(document.approve.deputation.value=="Y"){
alert("You can't approve Employees coming on deputation to AAI ");
document.approve.deputation.focus();
return false;
}
}
var EDCPoption='<%=bean.getAaiEDCPSoption()%>';
if(EDCPoption=="E"){
if(document.approve.totcorpus2lakhs.value==""){
alert("Please Select Total SBS corpus less than Rs. 2 lakhs as Yes ");
document.approve.totcorpus2lakhs.focus();
return false;
}if(document.approve.deathcertficate.value==""){
alert("Please Select  Wherever employee has expired-Death certificate and Nominee details verified and certified as yes");
document.approve.deathcertficate.focus();
return false;
}
if(document.approve.totcorpus2lakhs.value=="N"){
alert("Please Select Total SBS corpus less than Rs. 2 lakhs as Yes ");
document.approve.totcorpus2lakhs.focus();
return false;
}if(document.approve.deathcertficate.value=="N"){
alert("Please Select  Wherever employee has expired-Death certificate and Nominee details verified and certified as yes");
document.approve.deathcertficate.focus();
return false;
}
}
if(document.approve.uploaddocuments.value==""){
alert("Please upload documents");
document.approve.uploaddocuments.focus();
return false;
}

}else{
if(document.approve.rejectedremarks.value==""){
alert("Please Enter Rejected Remarks ");
document.approve.rejectedremarks.focus();
return false;
}

}


setValues();
  //alert(document.approve.depDetails.value);
  var appid=document.approve.appid.value;
  var remarks=document.approve.remarks.value;
   var approveStatus=document.approve.approveStatus.value;
    var rejectedremarks=document.approve.rejectedremarks.value;
     var rejectedtype=document.approve.rejectedtype.value;
      var eligibleStatus=document.approve.eligibleStatus.value;
  var servicebook=document.approve.servicebook.value;
   var cpse=document.approve.cpse.value;
    var cad=document.approve.cad.value;
     var crs=document.approve.crs.value;
     var resign=document.approve.resign.value;
   var vrs=document.approve.vrs.value;
    var deputation=document.approve.deputation.value;
     var notational=document.approve.notational.value;
        var notationalappearCard=document.approve.notationalappearCard.value;
   var arrear=document.approve.arrear.value;
    var obadjustment=document.approve.obadjustment.value;
     var deputationaaitoother=document.approve.deputationaaitoother.value;
      var obremarks=document.approve.obremarks.value;
    var corpusobadj=document.approve.corpusobadj.value;
     var pfId=document.approve.pfId.value;
     var depDetails=document.approve.depDetails.value;
    //alert("depDetails"+depDetails);
	 var totcorpus2lakhs='';
	 var deathcertficate='';
	
if(EDCPoption=="E"){
 totcorpus2lakhs=document.approve.totcorpus2lakhs.value;
 deathcertficate=document.approve.deathcertficate.value;
}
	 //alert("totcorpus2lakhs"+totcorpus2lakhs);
	 //alert("deathcertficate"+deathcertficate);
  var url="<%=basePath%>SBSAnnuityServlet?method=Approve3&&ApproveLevel=CHQHRLevel2&&menu=<%=menu%>&&appid="+appid+"&&remarks="+remarks+"&&approveStatus="+approveStatus+"&&rejectedremarks="+rejectedremarks+"&&rejectedtype="+rejectedtype+"&&eligibleStatus="+eligibleStatus+"&&servicebook="+servicebook+"&&cpse="+cpse+"&&cad="+cad+"&&crs="+crs+"&&resign="+resign+"&&vrs="+vrs+"&&deputation="+deputation+"&&notational="+notational+"&&notationalappearCard="+notationalappearCard+"&&arrear="+arrear+"&&obadjustment="+obadjustment+"&&deputationaaitoother="+deputationaaitoother+"&&obremarks="+obremarks+"&&corpusobadj="+corpusobadj+"&&pfId="+pfId+"&&depDetails="+depDetails+"&&totcorpus2lakhs="+totcorpus2lakhs+"&&deathcertficate="+deathcertficate;
		//alert(url);
					document.approve.action=url;
					document.approve.method="post";
					document.approve.submit();
}
function dispDep(){
if(document.approve.deputationaaitoother.value=="Y"){
showValues();
$('#no-more-tables').show();
}else{
$('#no-more-tables').hide();
}

}
function load(){
var option='<%=bean.getAaiEDCPSoption()%>';
//alert(option);
$('#optionAB').hide();
$('#optionCD').hide();

if(option=='A' || option=='B' ){
		$('#optionAB').show();
		$('#optionCD').hide();
		}

if(option=='C' || option=='D' ){
		$('#optionCD').show();
		$('#optionAB').hide();
		}

}
function dispOB(){
if(document.approve.arrear.value=='Y'){
$('#ob').show();
}
if(document.approve.arrear.value=='N'){
$('#ob').hide();
}
}
function dispCorpusOB(){
if(document.approve.notational.value=='Y' && document.approve.notationalappearCard.value=='N' ){
$('#corpusob').show();
}else{

$('#corpusob').hide();
}
}
function changeStatus(){
if(document.approve.cpse.value=='Y' ||document.approve.cad.value=='Y' ||document.approve.crs.value=='Y' ||document.approve.resign.value=='Y'|| document.approve.vrs.value=='Y' || document.approve.deputation.value=='Y'){
document.approve.approveStatus.value='R';
}else{

document.approve.approveStatus.value='A';
}

}
function getrejectedrow(){
//alert(document.getElementById("approveStatus"));
if(document.getElementById("approveStatus").value=='R'){
$('#dispreject').show();

}else{
$('#dispreject').hide();
}

}
  function print(appid,status){

				var formType="N";
			var swidth=screen.Width-10;
			var sheight=screen.Height-150;
			
			 if(status!='A'){
  alert("Print will be available after approved only");
  return false;
  }
			
			var url="<%=basePath%>SBSAnnuityServlet?method=annuityReport&&ApproveLevel=HRLevel1&&appid="+appid;
			wind1 = window.open(url,"winComps","toolbar=yes,statusbar=yes,scrollbars=yes,menubar=yes,resizable=yes,width="+swidth+",height="+sheight+",top=0,left=0");
	   	 	winOpened = true;
			wind1.window.focus();
			
		
		
  }
</script>
  </head>

<body onload="return load();">
  <form name="approve" enctype="multipart/form-data" action="">
  <div class="page-content-wrapper">
		<div class="page-content">
		
			<div class="row">
			    <div class="col-md-12">
				<h3 class="page-title">Annuity Form Approved By HR</h3>
				<ul class="page-breadcrumb breadcrumb"></ul>
			    </div>
			</div>
			<fieldset>
			   <div class="row">
                                    <div class="col-md-12">

                                        <div class="col-md-6">
                                            <div class="form-group ">
                                                <label class="control-label col-md-6">
                                                 Application No <span class="required"></span>
                                                    :
                                                </label>
                                                <div class="col-md-4">
                                    <input name="appId" maxlength="40" class="form-control" type="text" value="Annuity/<%=bean.getFormType() %>/<%=bean.getAppId() %>"  readonly/> </div>
                                                <div class="col-md-2">
                                            <!--  <img style="width:40px" alt="download report" src="assets/img/download.jpg" onclick="getReport('<%=bean.getAppId() %>');">-->
                                            <a onclick=javascript:print(<%=bean.getAppId() %>,'A')><i class="fa fa-file-text" aria-hidden="true"   style="color:#378fe7;font-size:25px"></i></a></div>
                                         
                                            </div>
                                       </div>
                                        
                       

                                        <div class="col-md-6">
                                            <div class="form-group ">
                                                <label class="control-label col-md-6">
                                                   Employee Name <span class="required"></span>
                                                    :
                                                </label>
                      <div class="col-md-6"><input name="memberName" maxlength="40" class="form-control" type="text" value="<%=bean.getMemberName() %>" readonly>
                                                    
                                                </div>
                                            </div>
                                        </div>
                                        
                                    </div>
                                </div>  
                                 <div class="row">
                                    <div class="col-md-12">

                                        <div class="col-md-6">
                                            <div class="form-group ">
                                                <label class="control-label col-md-6">
                                                  PF ID of Employee <span class="required"></span>
                                                    :
                                                </label>
                      <div class="col-md-6"> <input name="pfId" maxlength="40" value="<%=bean.getEmployeeNo() %>" class="form-control" readonly/>
                                                    
                                                </div>
                                            </div>
                                        </div>
                            

                                        <div class="col-md-6">
                                            <div class="form-group ">
                                                <label class="control-label col-md-6">
                                                   Annuity Option form Selected <span class="required"></span>
                                                    :
                                                </label>
                      <div class="col-md-6"><input name="Option" type="text" value="<%=bean.getAaiEDCPSoptionDesc()%>" readonly class="form-control">
                                                    
                                                </div>
                                            </div>
                                        </div>
                                        
                                    </div>
                                </div> 
                                
                                <div class="row">
									<div class="col-md-12">
										<div class="col-md-12">
											<div class="form-group ">
												
												<div class="col-md-12">
												<label class="control-label">
												<b>a) All fields in the form verified from Service Books</b>
												<span class="required">*</span></label>
													<input name="servicebook" type="checkbox" >
													
													
													</div>
											</div>
											</div>
									</div>
								</div>
								 <div class="row">
                                    <div class="col-md-12">
                                        <div class="form-group " align="center">  &nbsp;</div>
                                    </div>
                                    <div>
                                    </div>
                                </div>
								 <div class="row">
                                    <div class="col-md-12">
                                    <div class="form-group ">
                                        <div class="col-md-9" align="left" style="text-decoration:underline; font-weight:600;">b) Further verification of EDCP Eligibility Condition of Employee  : </div>
                                    </div>
                                    <div class="col-md-3">
                                    <select name="eligibleStatus" id="eligibleStatus"  class="form-control">
                                                        <option value="Y">Eligible </option>
                                                        <option value="N">InEligible </option>
                                                 
                                                    </select>
                                    </div>
                                    </div>
                                    <div>
                                    </div>
                                </div>
                                
                                 <div class="row">
                                    <div class="col-md-12">
                                        <div class="form-group " align="center" >  &nbsp; </div>
                                    </div>
                                    <div>
                                    </div>
                                </div>
                                     <div class="row">
									<div class="col-md-12">
										<div class="col-md-12">
											<div class="form-group ">
												<div class="col-md-9"><label class="control-label">1) CAD Pension Optees(less than 10 years) <span class="required">*</span></label></div>
												
												<div class="col-md-3">
													<input name="cad" type="radio" value="Y" onclick="changeStatus();"> Yes
													<input name="cad" type="radio" checked value="N" onclick="changeStatus();"> NO
													
												
													</div>
											</div>
											</div>
									</div>
								</div>
                                	<div class="row">
                                    <div class="col-md-12">
                                        <div class="form-group " align="center" >  &nbsp; </div>
                                    </div>
                                    <div>
                                    </div>
                                </div>
                                
                                  <div class="row">
									<div class="col-md-12">
										<div class="col-md-12">
											<div class="form-group">
												<div class="col-md-9"><label class="control-label">2) Separation Reason- If less than 15 years of service in CPSE for employees superannuating from 01.01.2007 to 02.08.2017<span class="required">*</span></label></div>
												<div class="col-md-3">
													<input name="cpse" type="radio" value="Y" onclick="changeStatus();"> Yes
													<input name="cpse" type="radio" checked value="N" onclick="changeStatus();"> NO
													
													
													</div>
											</div>
											</div>
									</div>
								</div>
							
                             
								<div class="row">
                                    <div class="col-md-12">
                                        <div class="form-group " align="center" >  &nbsp; </div>
                                    </div>
                                    <div>
                                    </div>
                                </div>
                                 <div class="row">
									<div class="col-md-12">
										<div class="col-md-12">
											<div class="form-group ">
												<div class="col-md-9"><label class="control-label">3) Separation Reason-  Termination, Dismissal, disciplinary proceedings, lispendens, or due to sudden disappearance (missing), CRS<span class="required">*</span></label></div>
												<div class="col-md-3" >
													<input name="crs" type="radio"  class="redio" value="Y" onclick="changeStatus();"> Yes
													<input name="crs" type="radio" class="redio" checked value="N" onclick="changeStatus();"> NO
													
													
													</div>
											</div>
											</div>
									</div>
								</div>
								<div class="row">
                                    <div class="col-md-12">
                                        <div class="form-group " align="center" >  &nbsp; </div>
                                    </div>
                                    <div>
                                    </div>
                                </div>
                                 <div class="row">
									<div class="col-md-12">
										<div class="col-md-12">
											<div class="form-group ">
												<div class="col-md-9"><label class="control-label">4) Separation Reason- Resignation<span class="required">*</span></label></div>
												<div class="col-md-3" >
													<input name="resign" type="radio"  class="redio" value="Y" onclick="changeStatus();"> Yes
													<input name="resign" type="radio" class="redio" checked value="N" onclick="changeStatus();"> NO
													
													<span class="required"></span>
													</div>
											</div>
											</div>
									</div>
								</div>
								<div class="row">
                                    <div class="col-md-12">
                                        <div class="form-group" align="center">  &nbsp; </div>
                                    </div>
                                    <div>
                                    </div>
                                </div>
								<%if(!bean.getAaiEDCPSoptionDesc().equals("Refund Application (fifth option)")){%>
                                 <div class="row">
									<div class="col-md-12">
										<div class="col-md-12">
											<div class="form-group ">
												<div class="col-md-9"><label class="control-label">5) Cases of VRS/VSS-officials who take VRS before 50 years of age<span class="required">*</span></label></div>
												<div class="col-md-3" >
													<input name="vrs" type="radio"  class="redio" value="Y" onclick="changeStatus();"> Yes
													<input name="vrs" type="radio" class="redio" checked value="N" onclick="changeStatus();"> NO
													
													<span class="required"></span>
													</div>
											</div>
											</div>
									</div>
								</div>
								<%}else{%>
                                  <input name="vrs" type="hidden" class="redio" checked value="N" onclick="changeStatus();">
								<%}%>
								<div class="row">
                                    <div class="col-md-12">
                                        <div class="form-group" align="center" >  &nbsp; </div>
                                    </div>
                                    <div>
                                    </div>
                                </div>
                                 <div class="row">
									<div class="col-md-12">
										<div class="col-md-12">
											<div class="form-group ">
												<div class="col-md-9"><label class="control-label">6) Employees coming on deputation to AAI<span class="required">*</span></label></div>
												<div class="col-md-3" >
													<input name="deputation" type="radio"  class="redio" value="Y" onclick="changeStatus();"> Yes
													<input name="deputation" type="radio" checked class="redio"  value="N" onclick="changeStatus();"> NO
													
													<span class="required"></span>
													</div>
											</div>
											</div>
									</div>
								</div>
								<div class="row">
                                    <div class="col-md-12">
                                        <div class="form-group " align="center" >  &nbsp; </div>
                                    </div>
                                    <div>
                                    </div>
                                </div>
                                 <div class="row">
                                    <div class="col-md-12">
                                        <div class="form-group" align="left" style="text-decoration:underline; font-weight:600;">c) Verification of Corpus:- </div>
                                    </div>
                                    <div>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-md-12">
                                        <div class="form-group " align="center" >  &nbsp; </div>
                                    </div>
                                    <div>
                                    </div>
                                </div>
                             
								  <div class="row">
									<div class="col-md-12">
										<div class="col-md-12">
											<div class="form-group ">
												
												<div class="col-md-9">
												<label class="control-label">
												1)Whether Notional Increment was given or not<span class="required">*</span></label>
													
													</div>
													<div class="col-md-3" >
													<input name="notational" type="radio" onclick="dispCorpusOB()"  class="redio" value="Y"> Yes
													<input name="notational" type="radio" class="redio" onclick="dispCorpusOB()"  value="N"> NO
													
													<span class="required"></span>
													</div>
													
											</div>
											</div>
									</div>
								</div>
									<div class="row">
                                    <div class="col-md-12">
                                        <div class="form-group " align="center" >  &nbsp; </div>
                                    </div>
                                    <div>
                                    </div>
                                </div>
                             
								  <div class="row">
									<div class="col-md-12">
										<div class="col-md-12">
											<div class="form-group ">
												
												<div class="col-md-9">
												<label class="control-label">
												2) If yes then whether recovery in respect of notional increment to be recovered for the period 2007 onwards or not ?<span class="required">*</span></label>
													
													</div>
													<div class="col-md-3" >
													<input name="notationalappearCard" type="radio" onclick="dispCorpusOB()" class="redio" value="Y"> Yes
													<input name="notationalappearCard" type="radio" onclick="dispCorpusOB()" class="redio"  value="N"> NO
													
													<span class="required"></span>
													</div>
													
											</div>
											</div>
									</div>
								</div>
								<div id="corpusob" style="display:none">
								
								<div class="row">
                                    <div class="col-md-12">

                                        <div class="col-md-6">
                                            <div class="form-group ">
                                                <label class="control-label col-md-6">
                                                 OB Remarks<span class="required">*</span>
                                                    :
                                                </label>
                      <div class="col-md-6">
                                                   <input type="text" class="form-control" name="obremarks"  />
                                                  
                                                </div>
                                            </div>
                                        </div>
                                
                                        <div class="col-md-6">
                                            <div class="form-group ">
                                                <label class="control-label col-md-6">
                                                  Corpus OB Adjustment<span class="required">*</span>
                                                    :
                                                </label>
                      <div class="col-md-6">
                                                   <input type="text" class="form-control" name="corpusobadj"  />
                                                </div>
                                            </div>
                                        </div>
                                        
                                    </div>
                                </div>
								
								</div>
								<div class="row">
                                    <div class="col-md-12">
                                        <div class="form-group " align="center" >  &nbsp; </div>
                                    </div>
                                    <div>
                                    </div>
                                </div>
                             
								  <div class="row">
									<div class="col-md-12">
										<div class="col-md-12">
											<div class="form-group ">
												
												<div class="col-md-9">
												<label class="control-label">
												3) Whether any arrear iro period prior to 01.01.2007 was paid to employee during 1.1.2007 to till date?<span class="required">*</span></label>
													
													</div>
													<div class="col-md-3" >
													<input name="arrear" type="radio"  class="redio" onclick="dispOB();" value="Y"> Yes
													<input name="arrear" type="radio" class="redio" onclick="dispOB();" value="N"> NO
													
													<span class="required"></span>
													</div>
													
											</div>
											</div>
									</div>
								</div>
								
								 
								        <div class="row" id="ob" style="display:none">
                                    <div class="col-md-12">

                                        <div class="col-md-12">
                                            <div class="form-group ">
                                                <label class="control-label col-md-8">
                                                If yes details may be mentioned and shared with Finance for OB adjustment <span class="required">*</span>
                                                    :
                                                </label>
                      <div class="col-md-3"> <input name="obadjustment" type="text"  class="form-control" />
                                                    
                                                </div>
                                            </div>
                                        </div>
                            

                                        <div class="col-md-1">
                                            <div class="form-group ">
                                                <label class="control-label col-md-1">
                                                 
                                                </label>
                      <div class="col-md-1">
                                                    
                                                </div>
                                            </div>
                                        </div>
                                        
                                    </div>
                                </div>
                              <div class="row">
									<div class="col-md-12">
										<div class="col-md-12">
											<div class="form-group ">
												
												<div class="col-md-9">
												<label class="control-label">
												 4) AAI Employee on  deputation from AAI to Other Organization?<span class="required">*</span></label>
													
													</div>
													<div class="col-md-3" >
													<input name="deputationaaitoother" type="radio"  class="redio" onclick="dispDep();" value="Y"> Yes
													<input name="deputationaaitoother" type="radio" class="redio" onclick="dispDep();" value="N"> NO
													
													<span class="required"></span>
													</div>
													
											</div>
											</div>
									</div>
								</div>
								<%if(bean.getAaiEDCPSoptionDesc().equals("Refund Application (fifth option)")){%>
								<div class="row">
									<div class="col-md-12">
										<div class="col-md-12">
											<div class="form-group ">
												
												<div class="col-md-9">
												<label class="control-label">
												 5) Total SBS corpus   less than Rs. 2 lakhs<span class="required">*</span></label>
													
													</div>
													<div class="col-md-3" >
													<input name="totcorpus2lakhs" type="radio"  class="redio"  value="Y"> Yes
													<input name="totcorpus2lakhs" type="radio" class="redio"  value="N"> NO
													
													<span class="required"></span>
													</div>
													
											</div>
											</div>
									</div>
								</div>
								<div class="row">
									<div class="col-md-12">
										<div class="col-md-12">
											<div class="form-group ">
												
												<div class="col-md-9">
												<label class="control-label">
												 6) Wherever employee has expired-Death certificate and Nominee details verified and certified <span class="required">*</span></label>
													
													</div>
													<div class="col-md-3" >
													<input name="deathcertficate" type="radio"  class="redio"  value="Y"> Yes
													<input name="deathcertficate" type="radio" class="redio"  value="N"> NO
													<input name="deathcertficate" type="radio" class="redio"  value="L"> Not Applicable –employee is alive 
													
													<span class="required"></span>
													</div>
													
											</div>
											</div>
									</div>
								</div>
								<%}%>
																			<div id="no-more-tables">
	<div class="row"  style="display:block"  align="center">
	<div class="col-md-1"></div>
       <div class="col-md-10">
             <div class="form-group">
                   <div  id=detailsTable>   
                    </div>
                </div>
           </div> 
           <div class="col-md-1"></div> 
      </div>  
</div>



<div class="row">


                  <div class="row" style="display:none">
      <div class="col-md-6">
          <div class="form-group">   
                <select name="depDetails" multiple></select>
            </div>
      </div>
  </div>
  
                 
                                </div>
                             
                                 <div class="row">
                                    <div class="col-md-12">

                                        <div class="col-md-6">
                                            <div class="form-group ">
                                                <label class="control-label col-md-6">
                                                  Authorised Remarks<span class="required"></span>
                                                    :
                                                </label>
                      <div class="col-md-6">
                                                   <input type="text" class="form-control" name="remarks"  />
                                                  <input type="hidden" name="appid" value="<%=bean.getAppId()%>"/>
                                                </div>
                                            </div>
                                        </div>
                                
                                        <div class="col-md-6">
                                            <div class="form-group ">
                                                <label class="control-label col-md-6">
                                                  Approve<span class="required"></span>
                                                    :
                                                </label>
                      <div class="col-md-6">
                                                   <select name="approveStatus" id="approveStatus" onchange="getrejectedrow()" class="form-control">
                                                        <option value="A">Accept </option>
                                                        <option value="R">Reject </option>
                                                 
                                                    </select>
                                                </div>
                                            </div>
                                        </div>
                                        
                                    </div>
                                </div>
                                <div id="dispreject" style="display:none">
								<div class="row">
									<div class="col-md-12">

										<div class="col-md-6">
											<div class="form-group ">
												<label class="control-label col-md-6">
													Rejected Remarks
													<span class="required">*</span> :
												</label>
												<div class="col-md-6">
													<input type="text" class="form-control" name="rejectedremarks" />
													
												</div>
											</div>
										</div>

										<div class="col-md-6">
											<div class="form-group ">
												<label class="control-label col-md-6">
													Rejected Type
													<span class="required">*</span> :
												</label>
												<div class="col-md-6">
													<select name="rejectedtype" class="form-control">
														<option value="employee">
															 Send to Previous Level
														</option>
													

													</select>
												</div>
											</div>
										</div>

									</div>
								</div>
								</div>
								<div class="row">
									<div class="col-md-12">

										<div class="col-md-6">
											<div class="form-group ">
												<label class="control-label col-md-6">
													Documents Upload
													<span class="required">*</span> :
												</label>
												<div class="col-md-6">
													<input type="file" class="form-control" name="uploaddocuments"
														/>
												</div>
											</div>
										</div>
										</div>
										</div>
                               
                                <%ArrayList rejectedList=(ArrayList)bean.getRejectedList();

		System.out.println("App id:::::::::" + rejectedList.size());
if(rejectedList.size()>0){ %>
<div class="row">
									<div class="col-md-12">
										<div class="col-md-12">
											<div class="form-group ">
												<div class="col-md-12">
													<table id="customers">
  <tr>
    <th width="10%">S.No</th>
    <th width="60%" align="center" >Rejected Remarks</th>
    <th width="30%">Rejected By</th>
  </tr>
  <% SBSRejectedRemarksBean rbean=null;
  
  for(int i=0;i<rejectedList.size();i++){ 
  rbean=(SBSRejectedRemarksBean)rejectedList.get(i);

  %>
  <tr>
    <td><%=rbean.getSno() %></td>
    <td><%=rbean.getRemarks() %></td>
    <td><%=rbean.getRejecteBy() %></td>
  </tr>
  <%} %>
  

</table>
													
													
													</div>
											</div>
											</div>
									</div>
								</div>
								<%} %>
                                	<div class="">
												<div class="col-md-12" style="text-align:center">
												
													<button type="button" class="btn green" onclick="return validate()">Save</button>
													<button type="button" class="btn default" onclick="history.back(-1)">Cancel</button>
												</div>
											</div>
                                
                                </fieldset>
                                </div>
                                </div>
  
  </form>
  </body>
</html>
