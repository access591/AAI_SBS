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
		
		str+='<TD data-title='+heading3+'> <div class="input-icon"><i class="fa fa-calendar"></i> <input class="form-control date-picker" size="16" placeholder="dd-Mon-yyyy" NAME="nDOB"  id="nDOB" data-date-format="dd-M-yyyy" data-date-viewmode="years" type="text"></div></TD>';
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
//alert(document.SBIForm.nDOB.value);
	detailArray[detailArray.length]=[document.SBIForm.nomineeName.value,document.SBIForm.nomineeAddress.value,document.SBIForm.nDOB.value,document.SBIForm.relationShip.value,document.SBIForm.percentage.value];

}
function save1()	{  

	detailArray1[detailArray1.length]=[document.SBIForm.nameofNominee.value,document.SBIForm.appointeeName.value,document.SBIForm.appointeeDOB.value,document.SBIForm.appointeeRelation.value,document.SBIForm.appointeeMobileNo.value,document.SBIForm.appointeeAdress.value];

}

	function test(formtype,region,gst,empname,corpusamt,empSerialNo,appid){
			document.PolicyForm.formtype.value=formtype;
			document.PolicyForm.corpusamt.value=corpusamt;
		  	document.PolicyForm.gst.value=gst;
		  	document.PolicyForm.pfid.value=empSerialNo;
		  document.PolicyForm.appid.value=appid;
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
		
		str+='<TD data-title='+heading3+'> <div class="input-icon"><i class="fa fa-calendar"></i> <input class="form-control date-picker" size="16" placeholder="dd-Mon-yyyy" NAME="appointeeDOB"  id="appointeeDOB" data-date-format="dd-M-yyyy" data-date-viewmode="years" type="text"></div></TD>';
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

	if(document.PolicyForm.pfid.value==""){
		alert("Please enter the PFID number");
		document.PolicyForm.pfid.focus();
		return false;
		}
	if(document.PolicyForm.formtype.value==""){
		alert("Please enter the  Annuity provider Name");
		document.PolicyForm.formtype.focus();
		return false;
		}
	if(document.PolicyForm.corpusamt.value==""){
		alert("Please enter the corpus Amount");
		document.PolicyForm.corpusamt.focus();
		return false;
		}
	//if(document.PolicyForm.policyuploaddocument.value==""){
//alert("Please upload  policy  documents");
//document.PolicyForm.policyuploaddocument.focus();
//return false;
//}
	var pfid=document.PolicyForm.pfid.value;
	var appid=document.PolicyForm.appid.value;
	var formtype=document.PolicyForm.formtype.value;
	var corpusamt=document.PolicyForm.corpusamt.value;
	var gst=document.PolicyForm.gst.value;
	var policyno=document.PolicyForm.policyno.value;
	var policydate=document.PolicyForm.policydate.value;
	var policyamt=document.PolicyForm.policyamt.value;
	var debit=document.PolicyForm.debit.value;
	var credit=document.PolicyForm.credit.value;
	
	var url="<%=basePath%>SBSAnnuityServlet?method=insertPolicydoc&&menu=M7L1&&pfid="+pfid+"&&appid="+appid+"&&formtype="+formtype+"&&corpusamt="+corpusamt+"&&gst="+gst+"&&policyno="+policyno+"&&policydate="+policydate+"&&policyamt="+policyamt+"&&debit="+debit+"&&credit="+credit;
		//alert(url);
					document.PolicyForm.action=url;
					document.PolicyForm.method="post";
					document.PolicyForm.submit();
	
	
	
	
	
	
	
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
 <body >
  
  <form name="PolicyForm" enctype="multipart/form-data" method="post">
  
   	<div class="page-content-wrapper">
		<div class="page-content">
			<div class="row">
			    <div class="col-md-12">
				<h3 class="page-title">Policy Document</h3>
				<ul class="page-breadcrumb breadcrumb"></ul>
			    </div>
			</div>
    <div class="row">
                    <div class="col-md-12">
                        <!-- BEGIN PORTLET-->
                        <div class="portlet box blue">
                            <div class="portlet-title">
                                <div class="caption">
                                    <i class="fa fa-reorder"></i>Policy Document Form
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
                                    <div class="col-md-12" style="margin-top:20px;">

                                        <div class="col-md-6">
                                            <div class="form-group">
                                                <label class="control-label col-md-6">
                                                  PF ID <span class="required">*</span>
                                                    :
                                                </label>
                                                <div class="col-md-5">
                                                <% if(!user.getProfile().equals("M")){ %>
                                                <input name="pfid"  maxlength="40" class="form-control" onkeypress="return enterNumOnly(event);" type="text"></div>

						
						<div class="col-md-1"><img src="<%=basePath%>/PensionView/images/search1.gif" onclick="popupWindow('<%=basePath%>PensionView/SBS/SBSAnnuityAppHelp.jsp','AAI');" alt="Click The Icon to Select EmployeeName" />
						<input name="appid" type="hidden"/>
                                                <input name="region" type="hidden"/>
						<%}else{ %>
						 <input name="appid" type="hidden"/>
                                                    <input name="pfid"  maxlength="40" class="form-control" onkeypress="return enterNumOnly(event);" type="text">
                                                
                                                <%} %>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-md-6">
                                            <div class="form-group ">
                                                <label class="control-label col-md-6">
                                                  Annuity Provider<span class="required">*</span> :
                                                </label>
                                                <div class="col-md-6">
                                                    <input name="formtype" maxlength="40" class="form-control" type="text">
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
                                                    Total Annuity Purchase Amount <span class="required">*</span>
                                                    :
                                                </label>
                                                <div class="col-md-6">
                                                    <input name="corpusamt" maxlength="40" class="form-control" type="text">
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-md-6">
                                            <div class="form-group ">
                                                <label class="control-label col-md-6">
                                                    GST <span class="required">*</span> :
                                                </label>
                                                <div class="col-md-6">
                                                    <input name="gst" maxlength="40" class="form-control" type="text">
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
                                                  Policy Number <span class="required">*</span>
                                                    :
                                                </label>
                                                <div class="col-md-6">
                                                    <input name="policyno" maxlength="40" class="form-control" type="text">
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-md-6">
                                            <div class="form-group ">
                                                <label class="control-label col-md-6">
                                                    Annuity Start Date <span class="required">*</span> :
                                                </label>
                                                <div class="col-md-6">
                                                    <div class="input-group input-medium date date-picker col-md-12"  data-date-format="dd-M-yyyy" data-date-viewmode="years" data-date-minviewmode="months">
                                                        <input type="text" name="policydate" "class="form-control" readonly>
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
                                                  Annuity Pension Amount<span class="required">*</span>
                                                    :
                                                </label>
                                                <div class="col-md-6">
                                                    <input name="policyamt" maxlength="40" class="form-control" type="text">
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-md-6">
                                            <div class="form-group ">
                                                <label class="control-label col-md-6">
                                                    
                                                    <span class="required"></span> 
                                                </label>
                                                <div class="col-md-6">
                                                    
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
                                                   Debit LIC/SBI/HDFC/BAJAJ ANNUITY Final Settlement AMOUNT  <span class="required">*</span>
                                                    :
                                                </label>
                                                <div class="col-md-6">
                                                    <input name="debit" maxlength="40" class="form-control" type="text">
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-md-6">
                                            <div class="form-group ">
                                                <label class="control-label col-md-6">
                                                   Credit LIC/SBI/HDFC/BAJAJ ANNUITY Final Settlement AMOUNT <span class="required">*</span> :
                                                </label>
                                                <div class="col-md-6">
                                                    <input name="credit" maxlength="40" class="form-control" type="text">
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
												Policy	Document Upload
													<span class="required">*</span> :
												</label>
												<div class="col-md-6">
													<input type="file" class="form-control" name="policyuploaddocument"
														/>
												</div>
											</div>
										</div>
										</div>
										</div>   
                                
                                        <div class="row">
                                        <div class="col-md-12">
                                        <div  style="text-align:center">
												<input type="button" class="btn dark" value="Cancel" onclick="javascript:history.back(-1)">
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




