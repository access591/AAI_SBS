<%@ page language="java" import="java.util.*,aims.bean.*" pageEncoding="ISO-8859-1"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
LicBean bean=null;
LoginInfo user=null;
   if(session.getAttribute("user")!=null){
            user=(LoginInfo)session.getAttribute("user");
            }
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    <jsp:include page="/SBSHeader.jsp"></jsp:include>
<jsp:include page="/PensionView/SBS/Menu.jsp"></jsp:include>
    <title>My JSP 'SBIForm.jsp' starting page</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
<script>
var detailArray = new Array();
		var detailArray1 = new Array();
			var srno,nomineename,nomineeaddress,nomineeDOB,nomineerelation,gardianname,gardianaddress,totalshare,nomineeflag;
function frmload(){
		$('#spouseDetails').hide();
		$('#documentCheckList').hide();
 	getSpouse();
	}
	
	function showValues() {    
		 
	 var heading1='Nominee Name';
	var heading2='Nominee Gender';
	var heading3='Nominee DOB';	
	var heading4='RelationShip With Primary Annuitant';	
	var heading5='Distribution Percentage';
	var heading6='Save/Clear';
				
var str='<div ><table class="col-md-12 table-bordered table-striped table-condensed cf" >';			
 str+=' <thead class="cf"><TR><th nowrap>'+heading1+'</th><th>'+heading2+'</th><th>'+heading3+'</th><th nowrap>'+heading4+'</th><th>'+heading5+'</th><th>'+heading6+'</th></TR></thead><tbody> ';		 
	for(var i=0;i<detailArray.length;i++) {
		
		str+='<TR >';
		str+='<TD >'+detailArray[i][0]+'</TD>';
		str+='<TD >'+detailArray[i][1]+'</TD>';
		str+='<TD >'+detailArray[i][2]+'</TD>';
        str+='<TD >'+detailArray[i][3]+'</TD>';
		
		str+='<TD align="center" class="tb" width=20%>'+detailArray[i][4]+'</TD>';
		str+='<TD align=right nowrap  style=width:40px><a href=javascript:void(0) onclick=del('+i+')>';
		str+='<i class="fa fa-trash-o"></i></TD>';
		str+='</TR>';
		
	}
	str+='<tr>';


str+='<TD data-title='+heading1+'> <input type="text"  name="nomineeName" id="nomineeName"   class="form-control" ></TD>';
		
str+='<TD data-title='+heading2+'> <input type="text"  name="nomineeAddress" id="nomineeAddress"   class="form-control" ></TD>';
		
		str+='<TD data-title='+heading3+'> <div class="input-icon"><i class="fa fa-calendar"></i> <input class="form-control date-picker" size="16" placeholder="dd-Mon-yyyy" NAME="nDOB"  id="nDOB" data-date-format="dd-M-yyyy" data-date-viewmode="years" readonly type="text"></div></TD>';
	 str+='<TD data-title='+heading4+'> <input type="text"  name="relationShip" id="relationShip"  class="form-control" ></TD>';
		
		str+='<TD data-title='+heading5+'> <input type="text"  name="percentage" id="percentage"     class="form-control" ></TD>';
		 str+='<TD data-title='+heading6+'> <a href="javascript:void(0)" onclick="saveDetails();"> <i class="fa fa-check" ></i></a> <a href="javascript:void(0)" onClick="clearDetails();"><i class="fa fa-times" ></i></a></TD>';
str+='</tr>';	
	str+='</tbody></TABLE></div>';
	document.all['detailsTable'].innerHTML = str;


	 $(".date-picker").datepicker({autoclose:true});



}
function setValues() {
	var temp;
	for(var i=0;i<detailArray.length;i++) {
		temp = detailArray[i][0]+'|'+detailArray[i][1]+'|'+detailArray[i][2]+'|'+detailArray[i][3]+'|'+detailArray[i][4];
		document.SBIForm.nomineeDetails.options[document.SBIForm.nomineeDetails.options.length]=new Option('x',temp);
		document.SBIForm.nomineeDetails.options[document.SBIForm.nomineeDetails.options.length-1].selected=true;
	}
}
function setValues1() {
	var temp;
	for(var i=0;i<detailArray1.length;i++) {
		temp = detailArray1[i][0]+'|'+detailArray1[i][1]+'|'+detailArray1[i][2]+'|'+detailArray1[i][3]+'|'+detailArray1[i][4]+'|'+detailArray1[i][5];
		document.SBIForm.nomineeDetailsChild.options[document.SBIForm.nomineeDetailsChild.options.length]=new Option('x',temp);
		document.SBIForm.nomineeDetailsChild.options[document.SBIForm.nomineeDetailsChild.options.length-1].selected=true;
	}
}

function saveDetails() {   

	


	 
    save();
  // alert(save)
	showValues();
	clearDetails();
   

	return true;
}
function saveDetails1() {   

	


	 
    save1();
  // alert(save)
	showValues1();
	clearDetails1();
   

	return true;
}

function save()	{  
var per=document.SBIForm.percentage.value;
if (per.indexOf('%')!=-1)
{

per=per.substr(0,per.length-1);
document.SBIForm.percentage.value=per;
  //alert("Please remove % symbol in percentage.")
  //document.nomineeForm.percentage.focus();
  //return false;
}
	detailArray[detailArray.length]=[document.SBIForm.nomineeName.value,document.SBIForm.nomineeAddress.value,document.SBIForm.nDOB.value,document.SBIForm.relationShip.value,document.SBIForm.percentage.value];

}
function save1()	{  

	detailArray1[detailArray1.length]=[document.SBIForm.nameofNominee.value,document.SBIForm.appointeeName.value,document.SBIForm.appointeeDOB.value,document.SBIForm.appointeeRelation.value,document.SBIForm.appointeeMobileNo.value,document.SBIForm.appointeeAdress.value];

}

	function test(airportCode,serationreason,region,pensionNumber,employeeName,dateofbirth,empSerialNo,dateofseperation,dateofJoining,designation){
			document.SBIForm.priAnnuitName.value=employeeName;
			document.SBIForm.memberempno.value=empSerialNo;
		  	document.SBIForm.dob.value=dateofbirth;
		  	document.SBIForm.airport.value=airportCode;
		  	document.SBIForm.region.value=region;
		  	//alert(airportCode);		  		
		}
function clearDetails()	{
	 
  document.SBIForm.nomineeName.value="";
  document.SBIForm.nomineeAddress.value="";
  document.SBIForm.nDOB.value="";
  document.SBIForm.relationShip.value="";
  document.SBIForm.percentage.value="";
}
function clearDetails1()	{
	 
  document.SBIForm.nameofNominee.value="";
  document.SBIForm.appointeeName.value="";
  document.SBIForm.appointeeDOB.value="";
  document.SBIForm.appointeeRelation.value="";
  document.SBIForm.appointeeMobileNo.value="";
  document.SBIForm.appointeeAdress.value="";

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
function showValues1() {    
		 
	 var heading1='Nominee Name';
	var heading2='Appointee Name';
	var heading3='Appointee Date of Birth';	
	var heading4='Relationship of the appointee';	
	var heading5='Appointee Mobile No';
	var heading6='Appointee Adress';

	var heading7='Save/Clear';
				
var str='<div ><table class="col-md-12 table-bordered table-striped table-condensed cf" >';			
 str+=' <thead class="cf"><TR><th nowrap>'+heading1+'</th><th>'+heading2+'</th><th>'+heading3+'</th><th nowrap>'+heading4+'</th><th>'+heading5+'</th><th>'+heading6+'</th><th>'+heading7+'</th></TR></thead><tbody> ';		 
	for(var i=0;i<detailArray1.length;i++) {
		
		str+='<TR >';
		str+='<TD >'+detailArray1[i][0]+'</TD>';
		str+='<TD >'+detailArray1[i][1]+'</TD>';
		str+='<TD >'+detailArray1[i][2]+'</TD>';
		str+='<TD >'+detailArray1[i][3]+'</TD>';
		str+='<TD >'+detailArray1[i][4]+'</TD>';
		str+='<TD >'+detailArray1[i][5]+'</TD>';
       
		
	
		str+='<TD align=right nowrap  style=width:40px><a href=javascript:void(0) onclick=del1('+i+')>';
		str+='<i class="fa fa-trash-o"></i></TD>';
		str+='</TR>';
		
	}
	str+='<tr>';


str+='<TD data-title='+heading1+'> <input type="text"  name="nameofNominee" id="nameofNominee"   class="form-control" ></TD>';
		
str+='<TD data-title='+heading2+'> <input type="text"  name="appointeeName" id="appointeeName"   class="form-control" ></TD>';
		
		str+='<TD data-title='+heading3+'> <div class="input-icon"><i class="fa fa-calendar"></i> <input class="form-control date-picker" size="16" placeholder="dd-Mon-yyyy" NAME="appointeeDOB"  id="appointeeDOB" data-date-format="dd-M-yyyy" data-date-viewmode="years" readonly type="text"></div></TD>';
	 str+='<TD data-title='+heading4+'> <input type="text"  name="appointeeRelation" id="appointeeRelation"   class="form-control" ></TD>';
	 str+='<TD data-title='+heading5+'> <input type="text"  name="appointeeMobileNo" id="appointeeMobileNo"   class="form-control" ></TD>';
	 str+='<TD data-title='+heading6+'> <input type="text"  name="appointeeAdress" id="appointeeAdress"  class="form-control" ></TD>';
		
		
		 str+='<TD data-title='+heading7+'> <a href="javascript:void(0)" onclick="saveDetails1();"> <i class="fa fa-check" ></i></a> <a href="javascript:void(0)" onClick="clearDetails1();"><i class="fa fa-times" ></i></a></TD>';
str+='</tr>';	
	str+='</tbody></TABLE></div>';
	document.all['detailsTable1'].innerHTML = str;


	 $(".date-picker").datepicker({autoclose:true});



}
function popupWindow(mylink, windowname)
		{		
		//var transfer=document.forms[0].transferStatus.value;
		var transfer="";
	
		var regionID="",adjPfidChkFlag="true",pcReportChkFlag="false";
		
	
	var pagename="annuity";
	
		
		
	
		if (! window.focus)return true;
		var href;
		if (typeof(mylink) == 'string')
		   href=mylink+"?transferStatus="+transfer+"&region="+regionID+"&adjPfidChkFlag="+adjPfidChkFlag+"&pcReportChkFlag="+pcReportChkFlag+"&pagename="+pagename;
		   
		else
		href=mylink.href+"?transferStatus="+transfer+"&region="+regionID+"&adjPfidChkFlag="+adjPfidChkFlag+"&pcReportChkFlag="+pcReportChkFlag+"&pagename="+pagename;
		
		//alert(href);
	    progress=window.open(href, windowname, 'width=700,height=500,statusbar=yes,scrollbars=yes,resizable=yes');
		/*retricting loading pfids list*/
		//document.forms[0].select_region.value = "NO-SELECT";
		//document.forms[0].select_airport.length = 1;
		//document.forms[0].select_pfidlst.length=1;
		return true;
		}

		
function del1(index) {
	var temp1=new Array();
	for(var i=0;i<detailArray1.length;i++) {
		if(i!=index)
			temp1[temp1.length]=detailArray1[i];
	}
	detailArray1=temp1;
	showValues1();
	return false;
}

function enterNumOnly(e)
			{
			var key=0;

			if(window.event)
			{
					key = e.keyCode; 
				//alert(key)
			}
				

				 if((key>=48)&&(key<=57)||key==8||key==9)
				 {
					key=key;
					return true;
				 }
				 else
				 {
				   key=0;
				   return false;
				 }
				 
			}
	
function validate(){

	if(document.SBIForm.memberempno.value==""){
		alert("Please enter the Member employee number");
		document.SBIForm.memberempno.focus();
		return false;
		}
	if(document.SBIForm.priAnnuitName.value==""){
		alert("Please enter the  Primary Annuitant's Name");
		document.SBIForm.priAnnuitName.focus();
		return false;
		}
	if(document.SBIForm.gender.value==""){
		alert("Please enter the Gender");
		document.SBIForm.gender.focus();
		return false;
		}
	
	if(document.SBIForm.dob.value==""){
		alert("Please enter the  Date of Birth");
		document.SBIForm.dob.focus();
		return false;
		}
	

	if(document.SBIForm.annuadd.value==""){
		alert("Please enter the  Annuitant's Address");
		document.SBIForm.annuadd.focus();
		return false;
		}
	
	if(document.SBIForm.ctv.value==""){
		alert("Please enter the   City/Town/Village");
		document.SBIForm.ctv.focus();
		return false;
		}
	
	if(document.SBIForm.state.value==""){
		alert("Please enter the   State");
		document.SBIForm.state.focus();
		return false;
		}
	
	if(document.SBIForm.pc.value==""){
		alert("Please enter the Pin Code");
		document.SBIForm.pc.focus();
		return false;
		}
	
	if(document.SBIForm.mno.value==""){
		alert("Please enter the  Mobile Number");
		document.SBIForm.mno.focus();
		return false;
		}
	if(document.SBIForm.eid.value==""){
		//alert("Please enter the   E-Mail I'd");
		//document.SBIForm.eid.focus();
		//return false;
		}
	if(document.SBIForm.panno.value==""){
		alert("Please enter the PAN Number");
		document.SBIForm.panno.focus();
		return false;
		}
	
	if(document.SBIForm.nation.value==""){
		alert("Please enter the  Nationality");
		document.SBIForm.nation.focus();
		return false;
		}
	if(document.SBIForm.FName.value==""){
		alert("Please enter the  Father's Name");
		document.SBIForm.FName.focus();
		return false;
		}
	
	if(document.SBIForm.acno.value==""){
		alert("Please enter the  Bank Account Number ");
		document.SBIForm.acno.focus();
		return false;
		}
	
	if(document.SBIForm.bname.value==""){
		alert("Please enter the   Bank Name");
		document.SBIForm.bname.focus();
		return false;
		}
	
	
	if(document.SBIForm.badd.value==""){
		alert("Please enter the  Branch Address");
		document.SBIForm.badd.focus();
		return false;
		}
	
	if(document.SBIForm.acctype.value==""){
		alert("Please enter the  Account Type");
		document.SBIForm.acctype.focus();
		return false;
		}
	
	if(document.SBIForm.ifscode.value==""){
		alert("Please enter the   IFSC Code");
		document.SBIForm.ifscode.focus();
		return false;
		}
	
	//if(document.SBIForm.corpusamt.value==""){
		//alert("Please enter the  Corpus Amount/Purchase");
		//document.SBIForm.corpusamt.focus();
		//return false;
		//}

		if(document.SBIForm.apaymentMode.value==""){
		alert("Please select the Frequency of Payouts");
		document.SBIForm.apaymentMode.focus();
		return false;
		}
		if(document.SBIForm.aaiedcpsOption.value==""){
		alert("Please select the AAIEDCPS Option");
		document.SBIForm.aaiedcpsOption.focus();
		return false;
		}
		
		if( document.SBIForm.nomineeName.value!=""|| document.SBIForm.nomineeAddress.value!=""||  document.SBIForm.nDOB.value!="" ||  document.SBIForm.relationShip.value!=""){
		alert("Please Save the Nominee Details ");
		document.SBIForm.nomineeName.focus();
		return false;
		}
	setValues();
	setValues1();
	
	var url="<%=basePath%>SBSAnnuityServlet?method=addSBI&&menu=M5L2&&formType=SBI";
		//alert(url);
					document.SBIForm.action=url;
					document.SBIForm.method="post";
					document.SBIForm.submit();
	
	
	
	
	
	
	
}

function getoption(){
	var option=$('#aaiedcpsOption:checked').val();
		$('#Option').val(option);
		}
		function getSpouse(){
		
	var option=$('#aaiedcpsOption:checked').val();

		
		if(option=='C' || option=='D' || option=='A' || option=='B'){
		$('#documentCheckList').show();
		}else{
		$('#documentCheckList').hide();
		}
		if(option=='C' || option=='D'){
		$('#spouseDetails').show();
		
		}else{
		$('#spouseDetails').hide();
		}
		if(option=='A'){
		$('#optionA').show();
		$('#optionAB').show();
		$('#optionB').hide();
		$('#optionC').hide();
		$('#optionD').hide();
		$('#optionCD').hide();
		$('#nomineetables').hide();
		
		} 
		if(option=='B'){
		$('#optionB').show();
		$('#optionAB').show();
		$('#optionA').hide();
		$('#optionC').hide();
		$('#optionD').hide();
		$('#optionCD').hide();
		$('#nomineetables').show();
		}
		if(option=='C'){
		$('#optionC').show();
		$('#optionCD').show();
		$('#optionA').hide();
		$('#optionB').hide();
		$('#optionD').hide();
		$('#optionAB').hide();
		$('#nomineetables').hide();
		}
		if(option=='D'){
		$('#optionD').show();
		$('#optionCD').show();
		$('#optionA').hide();
		$('#optionC').hide();
		$('#optionB').hide();
		$('#optionAB').hide();
		$('#nomineetables').show();
		}
		}

</script>
  </head>
  <%  EmployeePersonalInfo empPerinfo=null ;
  empPerinfo=(EmployeePersonalInfo)request.getAttribute("empInfo")!=null?(EmployeePersonalInfo)request.getAttribute("empInfo"):new EmployeePersonalInfo() ;
   %>
 <body onload="javascript:frmload(),showValues(),showValues1()">
  
  <form name="SBIForm"  method="post">
  
   	<div class="page-content-wrapper">
		<div class="page-content">
			<div class="row">
			    <div class="col-md-12">
				<h3 class="page-title">SBI Form</h3>
				<ul class="page-breadcrumb breadcrumb"></ul>
			    </div>
			</div>
    <div class="row">
                    <div class="col-md-12">
                        <!-- BEGIN PORTLET-->
                        <div class="portlet box blue">
                            <div class="portlet-title">
                                <div class="caption">
                                    <i class="fa fa-reorder"></i>SBI FORM
                                </div>
                                <!--<div class="tools">
                                    <a href="javascript:;" class="collapse"></a>
                                    <a href="#portlet-config" data-toggle="modal" class="config"></a>
                                    <a href="javascript:;" class="reload"></a>
                                    <a href="javascript:;" class="remove"></a>
                                </div>-->
                            </div>
                            <div class="portlet-body form">
                            	 <div class="row">
                                    <div class="col-md-12"  style="margin-top:10px;"><h4 class="form-section" style="text-align:left; font-weight:400 !important;"> &nbsp; <i class="fa fa-info-circle" aria-hidden="true" style="font-size:25px;"></i>   Intimation of Retirement/Death/Leaving Services</h4>
</div></div>
                                <div class="row">
                                    <div class="col-md-12" style="margin-top:20px;">

                                        <div class="col-md-6">
                                            <div class="form-group">
                                                <label class="control-label col-md-6">
                                                  Member Employee Number(PF ID) <span class="required">*</span>
                                                    :
                                                </label>
                                                <div class="col-md-5">
                                                <% if(!user.getProfile().equals("M")){ %>
                                                <input name="memberempno"  maxlength="40" class="form-control" onkeypress="return enterNumOnly(event);" type="text"></div>

						
						<div class="col-md-1"><img src="<%=basePath%>/PensionView/images/search1.gif" onclick="popupWindow('<%=basePath%>PensionView/SBS/SBSAnnuityHelp.jsp','AAI');" alt="Click The Icon to Select EmployeeName" />
						<input name="airport" type="hidden"/>
                                                <input name="region" type="hidden"/>
						<%}else{ %>
                                                    <input name="memberempno" value="<%=empPerinfo.getPensionNo() %>" maxlength="40" class="form-control" onkeypress="return enterNumOnly(event);" type="text">
                                                <input name="airport" value='<%=empPerinfo.getAirportCode() %>' type="hidden"/>
                                                <input name="region" value='<%=empPerinfo.getRegion() %>' type="hidden"/>
                                                <%} %>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-md-6">
                                            <div class="form-group ">
                                                <label class="control-label col-md-6">
                                                    Primary Annuitant's Name <span class="required">*</span> :
                                                </label>
                                                <div class="col-md-6">
                                                    <input name="priAnnuitName" maxlength="40" class="form-control" type="text">
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
                                                  Gender <span class="required">*</span>
                                                    :
                                                </label>
                                                <div class="col-md-6">
                                                     <select name="gender" class="form-control"><option value="">Select </option> <option value="Male">Male </option><option value="Female">Female</option></select> 
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-md-6">
                                            <div class="form-group ">
                                                <label class="control-label col-md-6">
                                                    Date of Birth <span class="required">*</span> :
                                                </label>
                                                <div class="col-md-6">
                                                    <div class="input-group input-medium date date-picker col-md-12"  data-date-format="dd-M-yyyy" data-date-viewmode="years" data-date-minviewmode="months">
                                                        <input type="text" name="dob" value="<%=empPerinfo.getDateOfBirth() %>"class="form-control" readonly>
                                                        <span class="input-group-btn">
                                                            <button class="btn default" type="button" style="padding: 4px 14px;"><i class="fa fa-calendar"></i></button>
                                                        </span>
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
                                                    Annuitant's Address<span class="required">*</span>
                                                    :
                                                </label>
                                                <div class="col-md-6">
                        <textarea name="annuadd" cols="" rows="" class="form-control"></textarea>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-md-6">
                                            <div class="form-group ">
                                                <label class="control-label col-md-6">
                                                    City/Town/Village
                                                    <span class="required">*</span> :
                                                </label>
                                                <div class="col-md-6">
                                                    <input name="ctv" maxlength="40" class="form-control" type="text">
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
                                                    State <span class="required">*</span>
                                                    :
                                                </label>
                                                <div class="col-md-6">
                                                    <input name="state" maxlength="40" class="form-control" type="text">
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-md-6">
                                            <div class="form-group ">
                                                <label class="control-label col-md-6">
                                                    Pin Code <span class="required">*</span> :
                                                </label>
                                                <div class="col-md-6">
                                                    <input name="pc" maxlength="40" class="form-control" type="text">
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
                                                    Mobile Number <span class="required">*</span>
                                                    :
                                                </label>
                                                <div class="col-md-6">
                                                    <input name="mno" maxlength="40" class="form-control" type="text">
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-md-6">
                                            <div class="form-group ">
                                                <label class="control-label col-md-6">
                                                    E-Mail I'd <span class="required">*</span> :
                                                </label>
                                                <div class="col-md-6">
                                                    <input name="eid" maxlength="40" class="form-control" type="text">
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
                                                   PAN Number <span class="required">*</span>
                                                    :
                                                </label>
                                                <div class="col-md-6">
                                                    <input name="panno" maxlength="40" class="form-control" type="text">
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-md-6">
                                            <div class="form-group ">
                                                <label class="control-label col-md-6">
                                                    Nationality <span class="required">*</span> :
                                                </label>
                                                <div class="col-md-6">
                                                    <input name="nation" maxlength="40" class="form-control" type="text">
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
                                                  Father's Name <span class="required">*</span>
                                                    :
                                                </label>
                                                <div class="col-md-6">
                                                    <input name="FName" maxlength="40" class="form-control" type="text">
                                                </div>
                                            </div>
                                        </div>
                                        

                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-md-12"  style="margin-top:10px;">
            <h4 class="form-section" style="text-align:left; font-weight:400 !important;"> 
            &nbsp; <i class="fa fa-cog" aria-hidden="true" style="font-size:23px;"></i> Bank Details </h4>
</div></div>
<div class="row">
                                    <div class="col-md-12">

                                        <div class="col-md-6">
                                            <div class="form-group ">
                                                <label class="control-label col-md-6">
                                                    Bank Account Number <span class="required">*</span>
                                                    :
                                                </label>
                                                <div class="col-md-6">
                                                    <input name="acno" maxlength="40" class="form-control" type="text">
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-md-6">
                                            <div class="form-group ">
                                                <label class="control-label col-md-6">
                                                  Bank Name <span class="required">*</span> :
                                                </label>
                                                <div class="col-md-6">
                                                    <input name="bname" maxlength="40" class="form-control" type="text">
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
                                                   Branch Address <span class="required">*</span>
                                                    :
                                                </label>
                                                <div class="col-md-6">
                                                    
                                                    <textarea name="badd"  class="form-control" ></textarea>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-md-6">
                                            <div class="form-group ">
                                                <label class="control-label col-md-6">
                                                  Account Type <span class="required">*</span> :
                                                </label>
                                                <div class="col-md-6">
                                                   <select name="acctype" class="form-control"><option value="">Select </option> <option value="SavingsAccount">Savings Account </option><option value="CurrentAccount">Current Account</option></select> 
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
                                                  IFSC Code <span class="required">*</span>
                                                    :
                                                </label>
                                                <div class="col-md-6">
                                                    <input name="ifscode" maxlength="40" class="form-control" type="text">
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-md-6">
                                            <div class="form-group ">
                                                <label class="control-label col-md-6">
                                                 Corpus Amount/Purchase
Price (In Rs)<span class="required"></span> :
                                                </label>
                                                <div class="col-md-6">
                                                    <input name="corpusamt" maxlength="40" class="form-control" type="text">
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
                                                  Name of the Annuity Service Provider <span class="required"></span>
                                                    :
                                                </label>
                                                <div class="col-md-6">
                      <label class="control-label"> <b>SBI Life Insurance Company Ltd</b></label>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-md-6">
                                            <div class="form-group ">
                                                <label class="control-label col-md-6">
                                              </label>
                                     	           <div class="col-md-6">
                                                  
                                                </div>
                                            </div>
                                        </div>

                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-md-12"  style="margin-top:10px;">
            <h4 class="form-section" style="text-align:left; font-weight:400 !important;"> 
            &nbsp; <i class="fa fa-cog" aria-hidden="true" style="font-size:23px;"></i> Frequency of Payouts </h4>
</div></div>

<div class="col-md-12">

                                        <div class="col-md-6">
                                            <div class="form-group ">
                                                <label class="control-label col-md-6">
                                                    Frequency of Payouts <span class="required">*</span>
                                                    :
                                                </label>
                                                <div class="col-md-6">
                                                    <select name="apaymentMode" class="form-control">
                                                        <option value="">Select </option>
                                                        <option value="monthly">Monthly </option>
                                                        <option value="qly">QLY  </option>
                                                        <option value="hly">HLY  </option>
                                                        <option value="yearly">Yearly </option>
                                                    </select>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                
                                <div class="row">
                                    <div class="col-md-12"  style="margin-top:10px;">
            <h4 class="form-section" style="text-align:left; font-weight:400 !important;"> 
            &nbsp; <i class="fa fa-cog" aria-hidden="true" style="font-size:23px;"></i> Annuity Option </h4>
</div></div>

<div class="row">
                                    <div class="col-md-12">
                                        <div class="col-md-12">
                                            <div class="form-group ">
                                  <div class="col-md-2">
                     				
                                                </div>
                                                <div class="col-md-4">
                     				Life Annuity &nbsp; 
                                                </div>
                                                 <div class="col-md-6">
                     			 <input name="aaiedcpsOption" id="aaiedcpsOption" type="radio" value="A" class="redio" onclick="getoption(),getSpouse()">
                                                </div>
                                                
                                            </div>
                                        </div>
                                        
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-md-12">
                                        <div class="col-md-12">
                                            <div class="form-group ">
                                  <div class="col-md-2">
                     				
                                                </div>
                                                <div class="col-md-4">
                     				Life Annuity With Return Of Purchase Price &nbsp; 
                                                </div>
                                                 <div class="col-md-6">
                     			 <input name="aaiedcpsOption" id="aaiedcpsOption" type="radio" value="B" class="redio" onclick="getoption(),getSpouse()"">
                                                </div>
                                                
                                            </div>
                                        </div>
                                        
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-md-12">
                                        <div class="col-md-12">
                                            <div class="form-group ">
                                  <div class="col-md-2">
                     				
                                                </div>
                                                <div class="col-md-4">
                     				Joint Life Annuity &nbsp; 
                                                </div>
                                                 <div class="col-md-6">
                     			 <input name="aaiedcpsOption" id="aaiedcpsOption" type="radio" value="C" class="redio" onclick="getoption(),getSpouse()"">
                                                </div>
                                                
                                            </div>
                                        </div>
                                        
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-md-12">
                                        <div class="col-md-12">
                                            <div class="form-group ">
                                  <div class="col-md-2">
                     				
                                                </div>
                                                <div class="col-md-4">
                     				Joint Life Annuity with Return of Purchase Price &nbsp; 
                                                </div>
                                                 <div class="col-md-6">
                     			 <input name="aaiedcpsOption" id="aaiedcpsOption" type="radio" value="D" class="redio" onclick="getoption(),getSpouse()"">
                                                </div>
                                                
                                            </div>
                                        </div>
                                        
                                    </div>
                                </div>
                               <div id="spouseDetails" > 
                                <div class="row">
                                    <div class="col-md-12"  style="margin-top:10px;">
            <h4 class="form-section" style="text-align:left; font-weight:400 !important;"> 
            &nbsp; <i class="fa fa-cog" aria-hidden="true" style="font-size:23px;"></i> In case the option chosen is 'Joint Life Annuity with Return of Purchase Price', please fill the below details : </h4>
</div></div>
<div class="row">
                                    <div class="col-md-12">

                                        <div class="col-md-6">
                                            <div class="form-group ">
                                                <label class="control-label col-md-6">
                                                 Name of secondary annuitant <span class="required">*</span>
                                                    :
                                                </label>
                                                <div class="col-md-6">
                                                    <input name="secannuityname" maxlength="40" class="form-control" type="text">
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-md-6">
                                            <div class="form-group ">
                                                <label class="control-label col-md-6">
                                                  Date of birth of secondary annuitant <span class="required">*</span> :
                                                </label>
                                                <div class="col-md-6">
                                                <div class="input-group input-medium date date-picker col-md-12"  data-date-format="dd-M-yyyy" data-date-viewmode="years" data-date-minviewmode="months">
                                                        <input type="text" name="secannuitydob" class="form-control" readonly>
                                                        <span class="input-group-btn">
                                                            <button class="btn default" type="button" style="padding: 4px 14px;"><i class="fa fa-calendar"></i></button>
                                                        </span>
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
                                                 Relationship with Primary Annuitant <span class="required">*</span>
                                                    :
                                                </label>
                                                <div class="col-md-6">
                                                    <input name="secannuityrelation" maxlength="40" class="form-control" type="text">
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-md-6">
                                            <div class="form-group ">
                                                <label class="control-label col-md-6">
                                                  PAN number of secondary annuitant <span class="required">*</span> :
                                                </label>
                                                <div class="col-md-6">
                                                   <input name="secannuitypan" maxlength="40" class="form-control" type="text">
                                                </div>
                                            </div>
                                        </div>

                                    </div>
                                </div>
                                </div> 
                             
                 <div class="row">
                                    <div class="col-md-12">
                                        <div class="form-group " align="center" style="text-decoration:underline; font-weight:600;">   Documents Checklist : </div>
                                    </div>
                                    <div>
                                    </div>
                                </div>
                                <div id="documentCheckList" > 
                                <div class="row">
                                    <div class="col-md-12" style="padding:30px;">

                                        <table width="100%" border="1" cellspacing="0" cellpadding="0" class="col-lg-12">
                                            <tr>
                                                <th class="col-md-3"> Annuity Plan Selected </th>
                                               
                                               
                                                <th class="col-md-3">Documents Required </th>

                                            </tr>
																		<tr style="padding: 3px;">
																			<td class="col-md-3" id="optionA">
																				Annuity for Life
																			</td>
																			<td class="col-md-3" id="optionB">
																				Life Annuity with Return of Purchase Price
																			</td>
																			<td class="col-md-3" id="optionC">
																				Joint Life Annuity
																			</td>
																			<td class="col-md-3" id="optionD">
																				Joint Life Annuity with Return of Purchase Price
																			</td>
																			<td class="col-md-3" id="optionAB">
																				<table>
																					<tr>
																						<td class="col-md-3">
																							One Set of Claim form (in original)
																						</td>
																					</tr>

																					<tr>
																						<td class="col-md-3">
																							Self-Attested Copy of AAI Identity Card
																						</td>
																					</tr>
																					<tr>
																					<td class="col-md-3">Self-Attested Copy of Last Pay Slip
																					</td>
																					
																					</tr>

																					<tr>
																						<td class="col-md-3">
																							Self-Attested copy of PAN card of primary
																							Annuitant
																						</td>
																					</tr>

																					<tr>
																						<td class="col-md-3">
																							Self-Attested copy of Aadhar card of primary
																							Annuitant
																						</td>
																					</tr>

																					<tr>
																						<td class="col-md-3">
																							Cancelled Cheque (Printed name of the Annuitant)
																						</td>
																					</tr>

																					<tr>
																						<td class="col-md-3">
																							Photograph of primary Annuitant
																						</td>
																					</tr>
																				</table>
																			</td>
																			<td class="col-md-3" id="optionCD">
																				<table>
																					<tr>
																						<td class="col-md-3">
																							Four Sets of Claim form (in original)
																						</td>
																					</tr>

																					<tr>
																						<td class="col-md-3">
																							Self-Attested Copy of AAI Identity Card
																						</td>
																					</tr>
																					<tr>
																					<td class="col-md-3">Self-Attested Copy of Last Pay Slip
																					</td>
																					
																					</tr>
																					<tr>
																						<td class="col-md-3">
																							Self-Attested copy of PAN card of primary
Annuitant and secondary Annuitant
																						</td>
																					</tr>

																					<tr>
																						<td class="col-md-3">
																							Self-Attested copy of Aadhar card of primary
Annuitant and secondary Annuitant
																						</td>
																					</tr>

																					<tr>
																						<td class="col-md-3">
																							Cancelled Cheque (Printed name of the Annuitant)
																						</td>
																					</tr>

																					<tr>
																						<td class="col-md-3">
																							Photograph of primary Annuitant and secondary
Annuitant
																						</td>
																					</tr>
																				</table>
																			</td>
																		</tr>
																		
																	</table>

                                    </div>
                                </div>
                                </div>
                               
                                
                    <div id="nomineetables" style="display:none">            
 <div class="row">
                                    <div class="col-md-12"  style="margin-top:10px;">
            <h4 class="form-section" style="text-align:center; font-weight:400 !important;"> 
            &nbsp; <i class="fa fa-cog" aria-hidden="true" style="font-size:23px;"></i> Nominee Details  : </h4>
</div></div>


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
                <select name="nomineeDetails" multiple></select>
            </div>
      </div>
  </div>
  
                 
                                </div>
                                <div class="row">
                                    <div class="col-md-12"  style="margin-top:10px;">
            <h4 class="form-section" style="text-align:left; font-weight:400 !important;"> 
            &nbsp; <i class="fa fa-cog" aria-hidden="true" style="font-size:23px;"></i> In case the nominee is a minor, kindly fill the appointee details : </h4>
</div></div>
<div class="row">
     <div id="no-more-tables">
	<div class="row"  style="display:block"  align="center">
	<div class="col-md-1"></div>
       <div class="col-md-10">
             <div class="form-group">
                   <div  id=detailsTable1>   
                    </div>
                </div>
           </div> 
           <div class="col-md-1"></div> 
      </div>  
</div> 

<div class="row" style="display:none">
      <div class="col-md-6">
          <div class="form-group">   
                <select name="nomineeDetailsChild" multiple></select>
            </div>
      </div>
  </div>                                 
                                </div>
                                </div>
                                <div style="height:10px;">
                                </div>
                                <div class="row">
                                 <div class="col-md-12">
                                        <table width="100%" border="0.5px" cellspacing="0" cellpadding="0" class="col-lg-12">
                                        <tr><td class="col-md-4">Signature of primary annuitant </td>
                                                <td class="col-md-8"> </td>
                                        </tr>
                             <tr><td class="col-md-4">Name of primary annuitant </td>
                                                <td class="col-md-8"> </td>
                                        </tr>    
                                        
                                        <tr><td class="col-md-4">Signature of officer representing Airports Authority of India </td>
                                                <td class="col-md-8"> </td>
                                        </tr>     
                                         <tr><td class="col-md-4">Name of the officer representing Airports Authority of India
 </td>
                                                <td class="col-md-8"> </td>
                                        </tr>   
                                         <tr><td class="col-md-4">Stamp and seal of the organization/trust making the payment
 </td>
                                                <td class="col-md-8"><br><br><br><br></td>
                                        </tr>               
                                        </table>
                                        </div>
                                        </div>
                                        <div class="row">
                                        <div class="col-md-12">
                                        <div  style="text-align:center">
												<a class="btn blue hidden-print" onclick="javascript:window.print();">Print <i class="fa fa-print"></i></a>
												<button type="submit" class="btn green" onclick="return validate()"><i class="fa fa-check"></i> Save</button>
											</div>
											</div>
											</div>
                                    <!-- ******************************-->
                                    <!-- END PAGE CONTENT-->
                                </div>
                            </div>
                            <!-- END CONTENT -->
                        </div>
                    </div>
                    </div></div></form>
      
  </body>
</html>
