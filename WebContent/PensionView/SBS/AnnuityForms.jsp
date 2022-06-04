
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
<!--  <link rel="stylesheet" href="<%=basePath%>assets/css/themes/base/jquery-ui.css">-->

  <%  
  
  ArrayList nomineeList=new ArrayList();
  ArrayList nomineeAppointeeList=new ArrayList();
  SBSNomineeBean nomineeBean=null;
  LoginInfo userinfo= (LoginInfo)request.getSession(false).getAttribute("user");
			
  String errorMessage=request.getAttribute("error")!=null?request.getAttribute("error").toString():"";
  
  if(errorMessage!=""){
  errorMessage="Form not saved !...the error code is "+errorMessage;
  }
  EmployeePersonalInfo empPerinfo=null ;
  empPerinfo=(EmployeePersonalInfo)request.getAttribute("empInfo")!=null?(EmployeePersonalInfo)request.getAttribute("empInfo"):new EmployeePersonalInfo() ;
  LicBean bean=null;
  bean=(LicBean)request.getAttribute("licBean")!=null?(LicBean)request.getAttribute("licBean"):new LicBean() ;
  String form=request.getAttribute("form")!=null?request.getAttribute("form").toString():"";
  String memberName=request.getAttribute("memberName")!=null?request.getAttribute("memberName").toString():"";
  String appId=request.getAttribute("appId")!=null?request.getAttribute("appId").toString():"";
  String pfid=request.getAttribute("pfid")!=null?request.getAttribute("pfid").toString():"";
  System.out.println(":::::::"+bean.getAppId()+errorMessage+pfid);
  String nomineedDetails=bean.getNomineeName()+"#"+bean.getMemberPerAdd()+"#"+bean.getNomineeDob()+"#"+bean.getRelationtoMember()+"#"+"";
  System.out.println(":::::::"+nomineedDetails);
  //nomineeList=request.getAttribute("nomineelist")!=null?(ArrayList)request.getAttribute("nomineelist"):new ArrayList();
  //nomineeAppointeeList=request.getAttribute("nomineeAppointeelist")!=null?(ArrayList)request.getAttribute("nomineeAppointeelist"):new ArrayList();
  //request.setAttribute("nomineelist",nomineeList);
  //request.setAttribute("nomineeAppointeelist",nomineeAppointeeList);
  LoginInfo user=null;
   if(session.getAttribute("user")!=null){
            user=(LoginInfo)session.getAttribute("user");
            }
   %>


<head>
	
	<!--  <script src="https://code.jquery.com/jquery-1.12.4.js"></script>
	<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>-->
<script type="text/javascript" src="<%=basePath%>PensionView/scripts/calendar.js"></script>
		<script type="text/javascript" src="<%=basePath%>PensionView/scripts/CommonFunctions.js"></script>
		<SCRIPT type="text/javascript" src="<%=basePath%>PensionView/scripts/DateTime.js"></SCRIPT>
		<SCRIPT type="text/javascript" src="<%=basePath%>PensionView/scripts/DateTime1.js"></SCRIPT>	
		<script type="text/javascript"> 
		var detailArray = new Array();
		var detailArray1 = new Array();
		var srno,nomineename,nomineeaddress,nomineeDOB,nomineerelation,gardianname,gardianaddress,totalshare,nomineeflag;
		var i;
		var emplshare=0,emplrshare=0,pensioncontribution=0;
		var ex=/^[0-9.-]+$/;
		var remarksFlag='N';
		function hide(focusFlag) {
			
		   	if(focusFlag!='true'){
		   		document.forms[0].pfid.focus();
		   	}else{
		   	    document.forms[0].seperationreason.focus();
		   	}		  
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

		function test(airportCode,serationreason,region,pensionNumber,employeeName,dateofbirth,empSerialNo,dateofseperation,dateofJoining,designation){
			document.lic.memberName.value=employeeName;
			document.lic.pfId.value=empSerialNo;
		  	document.lic.dob.value = dateofbirth;
		  	document.lic.doj.value=dateofJoining;
		  	document.lic.sepDate.value=dateofseperation;
		  	document.lic.sepReason.value=serationreason;
		  	document.lic.airport.value=airportCode;
		  	document.lic.region.value=region;
		  	//alert(airportCode);		  		
		}
function checkNum(obj) {
	
	
    if(obj=='qtyKL')   
	if(!ValidateFloatPoint(document.form0.qtyKL.value,13,3)) {
		document.form0.qtyKL.focus();
		document.form0.qtyKL.select();
		return false;
	}
	totalThput();
}
		
function setValues() {
	var temp;
	for(var i=0;i<detailArray.length;i++) {
		temp = detailArray[i][0]+'|'+detailArray[i][1]+'|'+detailArray[i][2]+'|'+detailArray[i][3]+'|'+detailArray[i][4];
		document.nomineeForm.nomineeDetails.options[document.nomineeForm.nomineeDetails.options.length]=new Option('x',temp);
		document.nomineeForm.nomineeDetails.options[document.nomineeForm.nomineeDetails.options.length-1].selected=true;
	}
}
function setValues1() {
	var temp;
	for(var i=0;i<detailArray1.length;i++) {
		temp = detailArray1[i][0]+'|'+detailArray1[i][1]+'|'+detailArray1[i][2];
		document.nomineeForm.nomineeDetailsChild.options[document.nomineeForm.nomineeDetailsChild.options.length]=new Option('x',temp);
		document.nomineeForm.nomineeDetailsChild.options[document.nomineeForm.nomineeDetailsChild.options.length-1].selected=true;
	}
}


function saveRecord() {
	if(detailArray.length == 0)	{
		alert("Please select the Contractor (Mandatory)");
		document.forms[0].contractor.focus();
		return(false);
	}
	
	return true;
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
//alert(document.nomineeForm.percentage.value);
var per=document.nomineeForm.percentage.value;
if (per.indexOf('%')!=-1)
{

per=per.substr(0,per.length-1);
document.nomineeForm.percentage.value=per;
  //alert("Please remove % symbol in percentage.")
  //document.nomineeForm.percentage.focus();
  //return false;
}
	detailArray[detailArray.length]=[document.nomineeForm.nomineeName.value,document.nomineeForm.nomineeAddress.value,document.nomineeForm.nDOB.value,document.nomineeForm.relationShip.value,document.nomineeForm.percentage.value];

}
function save1()	{  

	detailArray1[detailArray1.length]=[document.nomineeForm.apponteeNameAdress.value,document.nomineeForm.appointeeRelationShip.value,document.nomineeForm.appointeeDOB.value];

}

function clearDetails()	{
	 
  document.nomineeForm.nomineeName.value="";
  document.nomineeForm.nomineeAddress.value="";
  document.nomineeForm.nDOB.value="";
  document.nomineeForm.relationShip.value="";
  document.nomineeForm.percentage.value="";
}
function clearDetails1()	{
	 
  document.nomineeForm.apponteeNameAdress.value="";
  document.nomineeForm.appointeeRelationShip.value="";
  document.nomineeForm.appointeeDOB.value="";

}
	
		
		
function showValues() {    
		 
	 var heading1='Nominee Name';
	var heading2='Nominee Adress';
	var heading3='Nominee DOB';	
	var heading4='RelationShip';	
	var heading5='Percentage';
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
		
		str+='<TD data-title='+heading3+'> <div class="input-icon"><i class="fa fa-calendar"></i> <input class="form-control date-picker" size="16" placeholder="dd/Mon/yyyy" NAME="nDOB"  id="nDOB" data-date-format="dd/M/yyyy" data-date-viewmode="years" readonly type="text"></div></TD>';
	 str+='<TD data-title='+heading4+'> <input type="text"  name="relationShip" id="relationShip"  class="form-control" ></TD>';
		
		str+='<TD data-title='+heading5+'> <input type="text"  name="percentage" id="percentage"     class="form-control" ></TD>';
		 str+='<TD data-title='+heading6+'> <a href="javascript:void(0)" onclick="saveDetails();"> <i class="fa fa-check" ></i></a> <a href="javascript:void(0)" onClick="clearDetails();"><i class="fa fa-times" ></i></a></TD>';
str+='</tr>';	
	str+='</tbody></TABLE></div>';
	document.all['detailsTable'].innerHTML = str;


	 $(".date-picker").datepicker({autoclose:true});



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

		function loadValues(){
		
		<% if(nomineeList.size()>0){
	for(int i=0;i<nomineeList.size();i++){
		nomineeBean=(SBSNomineeBean)nomineeList.get(i);
		
		
		%>
		
		
		detailArray[detailArray.length]=['<%=nomineeBean.getNomineename()%>','<%=nomineeBean.getNomineeAdd()%>','<%=nomineeBean.getNomineeDOB()%>','<%=nomineeBean.getNomineeRelation()%>','<%=nomineeBean.getPercentage()%>'];
		<%}} else{ %>
  document.nomineeForm.nomineeName.value='<%=bean.getNomineeName()%>';
  document.nomineeForm.nomineeAddress.value='<%=bean.getMemberPerAdd()%>';
  document.nomineeForm.nDOB.value='<%=bean.getNomineeDob()%>';
  document.nomineeForm.relationShip.value='<%=bean.getRelationtoMember()%>';
  document.nomineeForm.percentage.value='0';
		<%}%>
		
		}
		function showValues1() {    
		 
	 var heading1='Name & Address of the Appointee';
	var heading2='Relationship With Nominee';
	var heading3='Date of Birth';	
	var heading4='Signature of the appointee';	

	var heading5='Save/Clear';
				
var str='<div ><table class="col-md-12 table-bordered table-striped table-condensed cf" >';			
 str+=' <thead class="cf"><TR><th nowrap>'+heading1+'</th><th>'+heading2+'</th><th>'+heading3+'</th><th nowrap>'+heading4+'</th><th>'+heading5+'</th></TR></thead><tbody> ';		 
	for(var i=0;i<detailArray1.length;i++) {
		
		str+='<TR >';
		str+='<TD >'+detailArray1[i][0]+'</TD>';
		str+='<TD >'+detailArray1[i][1]+'</TD>';
		str+='<TD >'+detailArray1[i][2]+'</TD>';
        str+='<TD ></TD>';
		
	
		str+='<TD align=right nowrap  style=width:40px><a href=javascript:void(0) onclick=del1('+i+')>';
		str+='<i class="fa fa-trash-o"></i></TD>';
		str+='</TR>';
		
	}
	str+='<tr>';


str+='<TD data-title='+heading1+'> <input type="text"  name="apponteeNameAdress" id="apponteeNameAdress"   class="form-control" ></TD>';
		
str+='<TD data-title='+heading2+'> <input type="text"  name="appointeeRelationShip" id="appointeeRelationShip"   class="form-control" ></TD>';
		
		str+='<TD data-title='+heading3+'> <div class="input-icon"><i class="fa fa-calendar"></i> <input class="form-control date-picker" size="16" placeholder="dd-Mon-yyyy" NAME="appointeeDOB"  id="appointeeDOB" data-date-format="dd-M-yyyy" data-date-viewmode="years" type="text"></div></TD>';
	 str+='<TD data-title='+heading4+'> <input type="text"  name="appionteeSign" id="appionteeSign" value=" " readonly class="form-control" ></TD>';
		
		
		 str+='<TD data-title='+heading5+'> <a href="javascript:void(0)" onclick="saveDetails1();"> <i class="fa fa-check" ></i></a> <a href="javascript:void(0)" onClick="clearDetails1();"><i class="fa fa-times" ></i></a></TD>';
str+='</tr>';	
	str+='</tbody></TABLE></div>';
	document.all['detailsTable1'].innerHTML = str;


	 $(".date-picker").datepicker({autoclose:true});



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
		
		
		
	
	
	function frmload(){
		$('#spouseDetails').hide();
		$('#documentCheckList').hide();
 	getSpouse();
	}
	 function Search(){

		
   		 var empNameCheak="",airportID="",sortColumn="EMPLOYEENAME",day="",month="",year="",pfid="";
	
		
   	
	//pfid=document.forms[0].empserialNO.value;

   		var regionID;
   		regionID=document.forms[0].select_region.options[document.forms[0].select_region.selectedIndex].text;
   		airportID=document.forms[0].select_airport.options[document.forms[0].select_airport.selectedIndex].text;
   		var sbsoption=document.forms[0].select_formType.options[document.forms[0].select_formType.selectedIndex].text;
		var url='';
		url="<%=basePath%>sbssearch?method=searchPersonalEligible&region="+regionID+"&airPortCode="+airportID+"&frm_sortingColumn="+sortColumn+"&sbsoption="+sbsoption+"&pfid="+pfid;
		
			wind1 = window.open(url,"winComps","toolbar=yes,statusbar=yes,scrollbars=yes,menubar=yes,resizable=yes,width="+swidth+",height="+sheight+",top=0,left=0");
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
     				document.forms[0].action="<%=basePath%>sbssearch?method=sbseligible&&menu=M4L1";
					document.forms[0].method="post";
					document.forms[0].submit();
			
		}
		
		
		
	
		window.onload=function(){
			populatedropdown("daydropdown", "monthdropdown", "yeardropdown");
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
			var exp=/^\w+([\.-]?\w+)*@\w+([\.-]?\w+)*(\.\w{2,4})+$/;
			

		function validateLicForm(){
		
		
		if(document.lic.memberName.value==""){
		alert("Please enter the Member/Bebeficiary name");
		document.lic.memberName.focus();
		return false;
		}
		if(document.lic.pfId.value==""){
		alert("Please enter the Employee No");
		document.lic.pfId.focus();
		return false;
		}
		if(document.lic.dob.value==""){
		alert("Please enter the Date of Birth");
		document.lic.dob.focus();
		return false;
		}
		if(document.lic.doj.value==""){
		alert("Please enter the Date of Joining");
		document.lic.doj.focus();
		return false;
		}
		if(document.lic.aaiedcpsOption.value==""){
		alert("Please select the AAIEDCPS Option");
		document.lic.aaiedcpsOption.focus();
		return false;
		}
		if(document.lic.aaiedcpsOption.value=="C" || document.lic.aaiedcpsOption.value=="D"){
		if(document.lic.spouseName.value==""){
		alert("Please Enter the Spouse Name");
		document.lic.spouseName.focus();
		return false;
		}
		if(document.lic.spouseAdd.value==""){
		alert("Please Enter the Spouse Address");
		document.lic.spouseAdd.focus();
		return false;
		}
		if(document.lic.spouseDob.value==""){
		alert("Please Enter the Spouse Dateofbirth");
		document.lic.spouseDob.focus();
		return false;
		}
		if(document.lic.spouseType.value==""){
		alert("Please Select the Relationship");
		document.lic.spouseType.focus();
		return false;
		}
		
		
		}
		if(document.lic.apaymentMode.value==""){
		alert("Please Enter the Mode of Anniuty Payment");
		document.lic.apaymentMode.focus();
		return false;
		}
		//alert(document.lic.address.value);
		//Member/Beneficiary validations
		if(document.lic.aaiedcpsOption.value=="B" || document.lic.aaiedcpsOption.value=="D"){
		
		if(document.lic.address.value==""){
		alert("Please select the Residential Address");
		document.lic.address.focus();
		return false;
		}
		
		if(document.lic.paddress.value==""){
		alert("Please select the Permenent Address");
		document.lic.paddress.focus();
		return false;
		}
		if(document.lic.nominee.value==""){
		alert("Please select the Nominee Name");
		document.lic.nominee.focus();
		return false;
		}
		if(document.lic.relation.value==""){
		alert("Please enter the Relationship with Member/Beneficiary");
		document.lic.relation.focus();
		return false;
		}
		if(document.lic.nomineeDob.value==""){
		alert("Please enter the Nominee Date Of Birth");
		document.lic.nomineeDob.focus();
		return false;
		}
		
		
		if(document.lic.pan.value==""){
		alert("Please enter the PAN No");
		document.lic.pan.focus();
		return false;
		}
		if(document.lic.adhar.value==""){
		alert("Please enter the Adhar No");
		document.lic.adhar.focus();
		return false;
		}
		if(document.lic.phoneNo.value==""){
		alert("Please enter the Phone No");
		document.lic.phoneNo.focus();
		return false;
		}
		if(document.lic.email.value==""){
		
		//alert("Please enter the Email Id");
		//document.lic.email.focus();
		//return false;
		}
		if(document.lic.email.value!=""){
 	if (!exp.test(document.lic.email.value))
  {
   alert("You have entered an invalid email address!");
    document.lic.email.focus();
    return (false);
  }
   
   
}
}		
		
		//ValidateEmail(document.lic.email.value);
		
		//Bank deatils
		if(document.lic.bankName.value==""){
		alert("Please enter the Bank Name");
		document.lic.bankName.focus();
		return false;
		}
		if(document.lic.branchAdd.value==""){
		alert("Please enter the Branch Address");
		document.lic.branchAdd.focus();
		return false;
		}
		if(document.lic.ifsc.value==""){
		alert("Please enter the IFSC Code");
		document.lic.ifsc.focus();
		return false;
		}
		if(document.lic.accType.value==""){
		alert("Please selet the Account Type");
		document.lic.accType.focus();
		return false;
		}
		if(document.lic.accNo.value==""){
		alert("Please Enter the Account No");
		document.lic.accNo.focus();
		return false;
		}
		
		
		
		
		
		var url="<%=basePath%>SBSAnnuityServlet?method=lic1&&menu=M5L1&&formType=LIC";
		//alert(url);
			document.lic.action=url;
					document.lic.method="post";
					document.lic.submit();
			
		
		}
		function validateLicFormDraft(){
		var url="<%=basePath%>SBSAnnuityServlet?method=lic1&&menu=M5L1&&formType=LIC&&savemode=Draft";
		//alert(url);
					document.lic.action=url;
					document.lic.method="post";
					document.lic.submit();
		}
		function validateDirForm(){
		var url="<%=basePath%>SBSAnnuityServlet?method=dir&&menu=M5L1";
		//alert(url);
					document.dir.action=url;
					document.dir.method="post";
					document.dir.submit();
			
		
		}
		function validateNominee(){
		//if(document.nomineeForm.nomineeName.value!=""||document.nomineeForm.nomineeAddress.value!=""|| document.nomineeForm.nDOB.value!=""){
		//alert("Please save the Nominee Details");
		//document.nomineeForm.nomineeName.focus();
		//return false;
		
		//}
		setValues();
		setValues1();
		
		var url="<%=basePath%>SBSAnnuityServlet?method=nominee&&menu=M5L1";
		//alert(url);
					document.nomineeForm.action=url;
					document.nomineeForm.method="post";
					document.nomineeForm.submit();
			
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
  <style type="text/css">
  .radio input[type="radio"], .radio-inline input[type="radio"], .checkbox input[type="checkbox"], .checkbox-inline input[type="checkbox"] {
    float: left;
    margin-left: 0px !important; 
}
  </style>
  <style type="text/css">
.table-bordered.table-striped.table-condensed .info input ~ a i {
    position: relative;
    margin-top: -20px;
    padding: 2px 8px;
    margin-left:165px !important;
  }
</style>
  </head>

  
  <body onload="javascript:frmload(),showValues(),loadValues(),showValues1()">
  

  
   	<div class="page-content-wrapper">
		<div class="page-content">
			<div class="row">
			    <div class="col-md-12">
				<h3 class="page-title">LIC Form</h3>
				<ul class="page-breadcrumb breadcrumb"></ul>
			    </div>
			</div>
			
				
		<div class="row">
				<div class="col-md-12">
					<div class="tabbable tabbable-custom boxless">
						<ul class="nav nav-tabs">
						<% if(form.equals("")) {%>
							<li <%=(form.equals("dir") || form.equals("nomineeForm"))? "":"class='active'" %>>
								<a href="#tab_0" data-toggle="tab">LIC NGSCA</a>
							</li>
							<%} %>
							<% if(form.equals("dir")){%>
							<li <%=form.equals("dir")? "class='active'":"" %>>
							<a href="#tab_1" data-toggle="tab">Discharge Receipt</a>
							</li>
							<%} %>
							<% if(form.equals("nomineeForm")){%>
							<li <%=form.equals("nomineeForm")? "class='active'":"" %>>
								<a href="#tab_2" data-toggle="tab">Nomination</a>
							</li>
							<%} %>
							
						</ul>
						<div class="tab-content">
							<div class="tab-pane <%=(form.equals("dir") || form.equals("nomineeForm"))? "":" active" %>" id="tab_0">
								<div class="portlet box green ">
									<div class="portlet-title">
										<div class="caption">
											<i class="fa fa-reorder"></i>LIC Form
										</div>
										<div class="tools">
											
										</div>
									</div>
									
									<div class="portlet-body form">
									<fieldset>
										<!-- BEGIN FORM-->
										<form   method="post" name="lic" class="form-horizontal">
										          <div class="row">
                                        <div class="col-md-12">
                                        <div class="col-md-2" style="margin:35px 40px;"><img src="assets/img/lic-logo.png" ></div>
                                         <div class="col-md-7">
                                        <span style="font-size:20px; font-weight:600; text-align:center !important;"> <center>P&GS DEPARTMENT, DELHI DIVISIONAL OFFICE-I<br>
6TH FLOOR, JEEVAN PRAKASH;<br>
25 K G MARG, NEW DELHI -110001 <br>
<font style="color:blue">Bo_g103gsca@licindia.com </font></center> </span></div>
                                        </div>                                        
                                        </div>
                                        <div class="row">
                                        <div class="col-md-12">
                                        <center>
                                       ===================================================================</center>
                                        </div>
                                        </div>
										  
                                        						<div class="form-body">
												<h4 class="form-section" style="text-align:center; font-weight:400 !important;">Intimation of Retirement/Death/Leaving Services
</h4>
											
                          
		                 <div class="row">
                                    <div class="col-md-12" style="color:red">

                                       
                                      <%=errorMessage %>
                                        
                                        
                                    </div>
                                </div>
                                    <div class="row">
                                    <div class="col-md-12">

                                        <div class="col-md-6">
                                            <div class="form-group ">
                                                <label class="control-label col-md-6">
                                                  <b> Type of Scheme </b><span class="required"></span>
                                                    :
                                                </label>
                                                <div class="col-md-6">
                                    <label class=" control-label col-md-12" style="text-align:left;"><b>  NGSCA </b></label> </div>
                                   
                                            </div>
                                        </div>
                                        
                                    </div>
                                </div>
                            
                                 
                                <div class="row">
                                    <div class="col-md-12">

                                        <div class="col-md-6">
                                            <div class="form-group ">
                                                <label class="control-label col-md-6">
                                                 <b> Master Policy No. </b><span class="required"></span>
                                                    :
                                                </label>
                                                <div class="col-md-6">
                                    <label class=" control-label col-md-12" style="text-align:left;"><b> 103006297 </b> </label> </div>
                                            </div>
                                        </div>
                                        
                                    </div>
                                </div>
                                   
                                            <div class="row">
                                            <div class="col-md-12">
                                            <p style="padding: 20px 80px ">We would like to submit our claim for payment of the benefit under the superannuation scheme in respect of the following member, who has exited the services of the organization by way of Superannuation/Voluntary Retirement/Resignation/Death. The details of the member are given below for your perusal. </p>
                                            </div>
                                            </div>
                                            
											 <div class="row">
                                    <div class="col-md-12" style="margin-top:20px;">

                                        <div class="col-md-6">
                                            <div class="form-group">
                                                <label class="control-label col-md-6">
                                                    Name of Member/Beneficiary <span class="required">*</span>
                                                    :
                                                </label>
                                                <div class="col-md-6">
                                                    <input name="memberName" value="<%=bean.getMemberName()%>" maxlength="40" class="form-control" type="text">
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-md-6">
                                            <div class="form-group ">
                                                <label class="control-label col-md-6">
                                                    LIC ID Number <span class="required"></span> :
                                                </label>
                                                <div class="col-md-6">
                                                    <input name="licId" maxlength="40"  readonly class="form-control" type="text">
                                                <input type=hidden name="formType" value="LIC"/>
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
                                                    Employee Number(PF ID) <span class="required">*</span>
                                                    :
                                                </label>
                                                <div class="col-md-5">
                                                			<% if(!user.getProfile().equals("M")){ %>
					<input name="pfId" maxlength="40" class="form-control"  type="text"></div>
						
						<div class="col-md-1"><img src="<%=basePath%>/PensionView/images/search1.gif" onclick="popupWindow('<%=basePath%>PensionView/SBS/SBSAnnuityHelp.jsp','AAI');" alt="Click The Icon to Select EmployeeName" />
						<input name="airport" type="hidden"/>
                                                <input name="region" type="hidden"/>
						<%}else{ %>
					   <input name="pfId" maxlength="40" onkeypress="return enterNumOnly(event);" class="form-control" value='<%=empPerinfo.getPensionNo() %>' type="text">
                                                  <input name="airport" value='<%=empPerinfo.getAirportCode() %>' type="hidden"/>
                                                <input name="region" value='<%=empPerinfo.getRegion() %>' type="hidden"/>
						<% }%>
                                                
                                                
                                                
                                                 
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
                                                        <input type="text" name="dob" class="form-control" value='<%=empPerinfo.getDateOfBirth() %>' >
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
                                                    Date of Joining<span class="required">*</span>
                                                    :
                                                </label>
                                                <div class="col-md-6">
                                                <div class="input-group input-medium date date-picker col-md-12" data-date-format="dd-M-yyyy" data-date-viewmode="years" data-date-minviewmode="months">
                                                      
                                                    <input  name="doj" maxlength="40" value='<%=empPerinfo.getDateOfJoining() %>' id="datepicker" class="form-control" type="text" >
 													<span class="input-group-btn">
                                                            <button class="btn default" type="button" style="padding: 4px 14px;"><i class="fa fa-calendar"></i></button>
                                                        </span>
                                                </div>
                                            </div>
                                        </div>
                                        </div>
                                        <div class="col-md-6">
                                            <div class="form-group">
                                                <label class="control-label col-md-6">
                                                    Cause of Exit
                                                    In case of Death (Original Death Certificate
                                                    to be attached)
                                                    <span class="required"></span> :
                                                </label>
                                                <div class="col-md-6">
                                                    
                                                
                                                
                                               
                                                    <select name="sepReason" class="form-control">
                                                    <option value="" >Select </option>
                                                        <option value="Death" <%=(empPerinfo.getSeperationReason().equals("Death")) ? "selected='selected'":"" %>>Death </option>
                                                        <option value="VRS" <%=(empPerinfo.getSeperationReason().equals("VRS")) ? "selected='selected'":"" %>>VRS  </option>
                                                        <option value="Retirement" <%=(empPerinfo.getSeperationReason().equals("Retirement")) ? "selected='selected'":"" %>>Retirement  </option>
                                                        
                                                    </select>
                                             
                                                
                                                
                                                
                                                
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
                                                    Date of Exit <span class="required"></span>
                                                    :
                                                </label>
                                                <div class="col-md-6">
                                                    <input name="sepDate" maxlength="40" id="datepicker" value='<%=empPerinfo.getDateOfSaparation() %>'class="form-control" type="text">

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
                                                    Final Contribution, if any, on cassation of services <span class="required"></span>
                                                    :
                                                </label>
                                                <div class="col-md-6">
                                                    <input name="fcservice" maxlength="40" readonly class="form-control" type="text">
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-md-6">
                                            <div class="form-group ">
                                                <label class="control-label col-md-6">
                                                    Whether option to commute part of pension exercised or not <span class="required">*</span> :
                                                </label>
                                                <div class="col-md-6">
                                                   NOT APPLICABLE AS PER AAIEDCPS RULES
                                                </div>
                                            </div>
                                        </div>

                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-md-12">

                                        <div class="col-md-12">
                                            <div class="form-group ">
                                                <label class="control-label col-md-10">
                                                    Type of pension Option elected (Initials of the member against the pension option exercised).
                                                    Option available (As decided by AAIEDCPS)
                                                </label>

                                            </div>
                                        </div>


                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-md-12">

                                        <div class="col-md-6">
                                            <div class="form-group ">
                                                <label class="control-label col-md-6">
                                                    Option Chosen<span class="required"></span>
                                                    :
                                                </label>
                                                <div class="col-md-6">
                                                    <input name="Option"  id="Option" value="<%=bean.getAaiEDCPSoption() %>" class="form-control" readonly type="text" >
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-md-6">
                                            <div class="form-group ">
                                                <label class="control-label col-md-6">
                                                    Sign/Initials of the member <span class="required"></span> :
                                                </label>
                                                <div class="col-md-6">
                                                   <input name="sign" type="text" value="" readonly>
                                                </div>
                                            </div>
                                        </div>

                                    </div>
                                </div>
                         
                                <div class="row">
                                    <div class="col-md-12">
                                        <div class="form-group" align="center" style="text-decoration:underline; font-weight:600;">Option available(As decided by AAIEDCPS) </div>
                                    </div>
                                    <div>
                                    </div>
                                </div>
                                <div class="row">
                                <div class="col-md-12">
                                <p style="text-align: left"  class="radio"> <input id="aaiedcpsOption" name="aaiedcpsOption"   <%=(bean.getAaiEDCPSoption().equals("A"))?"checked":"" %> type="radio" value="A" class="redio" onclick="getoption(),getSpouse()">
                                <span class="">  a)	Life Pension</span></p>
                                <p style="text-align: left"  class="radio"><input id="aaiedcpsOption" name="aaiedcpsOption" <%=(bean.getAaiEDCPSoption().equals("B"))?"checked":"" %> type="radio" value="B"   class="redio" onclick="getoption(),getSpouse()">
                                <span class=""> b)	Life Pension With Return Of Corpus </span></p>
                                 <p style="text-align: left"  class="radio"><input name="aaiedcpsOption" id="aaiedcpsOption" <%=(bean.getAaiEDCPSoption().equals("C"))?"checked":"" %> type="radio" value="C" class="redio"  onclick="getoption(),getSpouse()">
                                <span class="">  c)	Annuity for life with a provision for 100% of the annuity payable to the spouse on death of the annuitant WITHOUT return of corpus thereafter </span></p>
                                 <p style="text-align: left"  class="radio"><input name="aaiedcpsOption" id="aaiedcpsOption" <%=(bean.getAaiEDCPSoption().equals("D"))?"checked":"" %> type="radio" value="D" class="redio" onclick="getoption(),getSpouse()">
                                <span class="">  d)	Annuity for life with a provision for 100% of the annuity payable to the spouse on death of the annuitant WITH return of corpus to Nominee therafter</span></p>
                                </div>
                                </div>
                                
                               <div id="spouseDetails" > 
                                <div class="row">
                                    <div class="col-md-12">
                                        <div class="form-group " align="center" style="text-decoration:underline; font-weight:600;">   If joint life pension is opted, furnish the following details : </div>
                                    </div>
                                    <div>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-md-12" style="padding:30px;">

                                        <table width="100%" border="1" cellspacing="0" cellpadding="0" class="col-lg-12">
                                            <tr>
                                                <th class="col-md-3"> Name of the spouse </th>
                                                <th class="col-md-3">Address </th>
                                                <th class="col-md-3">Date of Birth</th>
                                                <th class="col-md-3">Relationship (Husband/Wife) </th>

                                            </tr>
                                            <tr style="padding:3px;">
                                                <td class="col-md-3"><input name="spouseName" type="text" value="<%=bean.getSpouseName() %>" class="form-control"> </td>
                                                <td class="col-md-3"><input name="spouseAdd" type="text" value="<%=bean.getSpouseAdd() %>" class="form-control"> </td>
                                                <td class="col-md-3"><div class="input-group input-medium date date-picker col-md-12"  data-date-format="dd-M-yyyy" data-date-viewmode="years" data-date-minviewmode="months">
                                                        <input type="text" class="form-control" value="<%=bean.getSpouseDob() %>" name="spouseDob" readonly>
                                                        <span class="input-group-btn">
                                                            <button class="btn default" type="button" style="padding: 4px 14px;"><i class="fa fa-calendar"></i></button>
                                                        </span>
                                                    </div></td>
                                                <td class="col-md-3">
                                                    <select name="spouseType" class="form-control">
                                                        <option value="">Select </option>
                                                        <option value="husband" <%=bean.getSpouseRelation().equals("husband") ? "selected='selected'":"" %>>Husband </option>
                                                        <option value="wife" <%=bean.getSpouseRelation().equals("wife") ? "selected='selected'":"" %>>Wife </option>
                                                    </select>
                                                </td>
                                            </tr>
                                        </table>

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
                                <div class="row">
                                    <div class="col-md-12">

                                        <div class="col-md-6">
                                            <div class="form-group ">
                                                <label class="control-label col-md-6">
                                                    Mode of Annuity Payment <span class="required">*</span>
                                                    :
                                                </label>
                                                <div class="col-md-6">
                                                    <select name="apaymentMode" class="form-control">
                                                        <option value="">Select </option>
                                                        <option value="monthly" <%=(bean.getPaymentMode().equals("monthly")) ? "selected='selected'":"" %>>Monthly </option>
                                                        <option value="qly" <%=(bean.getPaymentMode().equals("qly")) ? "selected='selected'":"" %>>QLY  </option>
                                                        <option value="hly" <%=(bean.getPaymentMode().equals("hly")) ? "selected='selected'":"" %>>HLY  </option>
                                                        <option value="yearly" <%=(bean.getPaymentMode().equals("yearly")) ? "selected='selected'":""%>>Yearly </option>
                                                    </select>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>


                                <div class="row">
                                    <div class="col-md-12">
                                        <div class="form-group" align="center" style="text-decoration:underline; font-weight:600">   Particulars of Member/Beneficiary  :</div>
                                    </div>
                                    <div>
                                    </div>
                                </div>

                                <div class="row">
                                    <div class="col-md-12">

                                        <div class="col-md-6">
                                            <div class="form-group ">
                                                <label class="control-label col-md-6">
                                                    Complete Residential Address of correspondence <span class="required">*</span>
                                                    :
                                                </label>
                                                <div class="col-md-6">
                                                    <textarea name="address" cols="" rows="" class="form-control"> <%=bean.getMemberAddress() %> </textarea>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-md-6">
                                            <div class="form-group ">
                                                <label class="control-label col-md-6">
                                                    Permanent Residential Address <span class="required">*</span>
                                                    :
                                                </label>
                                                <div class="col-md-6">
                                                    <textarea name="paddress" cols="" rows="" class="form-control"><%=bean.getMemberPerAdd() %>  </textarea>
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
                                                    Name of the Nominee <span class="required">*</span>
                                                    :
                                                </label>
                                                <div class="col-md-6">
                                                    <input name="nominee" type="text" value="<%=bean.getNomineeName() %>" class="form-control">
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-md-6">
                                            <div class="form-group ">
                                                <label class="control-label col-md-6">
                                                    Relationship with Member/Beneficiary <span class="required">*</span>
                                                    :
                                                </label>
                                                <div class="col-md-6">
                                                    <input name="relation" type="text" value="<%=bean.getRelationtoMember() %>" class="form-control">
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
                                                    Date of Birth of Nominee <span class="required">*</span>
                                                    :
                                                </label>
                                                <div class="col-md-6"> <div class="input-group input-medium date date-picker col-md-12"  data-date-format="dd-M-yyyy" data-date-viewmode="years" data-date-minviewmode="months">
                                                        <input type="text" class="form-control" name="nomineeDob" value="<%=bean.getNomineeDob() %>" readonly>
                                                        <span class="input-group-btn">
                                                            <button class="btn default" type="button" style="padding: 4px 14px;"><i class="fa fa-calendar"></i></button>
                                                        </span>
                                                    </div></div>
                                            </div>
                                        </div>
                                        <div class="col-md-6">
                                            <div class="form-group ">
                                                <label class="control-label col-md-6">
                                                    PAN NO(pl attach a copy) <span class="required">*</span>
                                                    :
                                                </label>
                                                <div class="col-md-6">
                                                    <input name="pan" type="text" value="<%=bean.getPanNo() %>" class="form-control">
                                                    
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
                                                    Adhar No(attach a copy)<span class="required">*</span>
                                                    :
                                                </label>
                                                <div class="col-md-6">
                                                    <input name="adhar" type="text" value="<%=bean.getAdharno() %>"  class="form-control">
                                                    
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-md-6">
                                            <div class="form-group ">
                                                <label class="control-label col-md-6">
                                                    Mobile/Phone no<span class="required">*</span>
                                                    :
                                                </label>
                                                <div class="col-md-6">
                                                    <input name="phoneNo" type="text" value="<%=bean.getMobilNo() %>"  class="form-control">
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
                                                    Email id <span class="required">*</span>
                                                    :
                                                </label>
                                                <div class="col-md-6">
                                                    <input name="email" type="text" value="<%=bean.getEmail() %>"  class="form-control">
                                                </div>
                                            </div>
                                        </div>

                                    </div>
                                    </div>

                                    <div class="row">
                                        <div class="col-md-12">
                                            <div class="form-group " align="center" style="text-decoration:underline; font-weight:600">
                                                Bank account details to which pension is
                                                to be credited :
                                            </div>
                                        </div>
                                        <div>
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-md-12">

                                            <div class="col-md-6">
                                                <div class="form-group ">
                                                    <label class="control-label col-md-6">
                                                        Name Of the Bank <span class="required">*</span>
                                                        :
                                                    </label>
                                                    <div class="col-md-6">
                                                        <input name="bankName" type="text" value="<%=bean.getBankName() %>"  class="form-control">
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-md-6">
                                                <div class="form-group ">
                                                    <label class="control-label col-md-6">
                                                        Address of Bank Branch <span class="required">*</span>
                                                        :
                                                    </label>
                                                    <div class="col-md-6">
                                                        <input name="branchAdd" type="text" value="<%=bean.getBranch() %>"  class="form-control">
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
                                                        IFSC Code(11 Characters of the Bank Branch-As appearing in your cheque book)
                                                        
                                                        <span class="required">*</span>
                                                        :
                                                    </label>
                                                    <div class="col-md-6">
                                                        <input name="ifsc" type="text" value="<%=bean.getIfscCode() %>"  class="form-control">
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-md-6">
                                                <div class="form-group ">
                                                    <label class="control-label col-md-6">
                                                        MICR Code  <span class="required">*</span>
                                                        :
                                                    </label>
                                                    <div class="col-md-6">
                                                        <input name="micrCode" type="text" value="<%=bean.getMicrCode() %>"  class="form-control">
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
                                                        Type of Account(Saving/Current)  <span class="required">*</span>
                                                        :
                                                    </label>
                                                    <div class="col-md-6">
                                                        <select name="accType" class="form-control">
                                                            <option value="">Select </option>
                                                            <option value="savings" <%=bean.getAccType().equals("savings")?"selected='selected'":"" %>>Savings Account</option>
                                                            <option value="current" <%=bean.getAccType().equals("current")?"selected='selected'":"" %>>Current account </option>
                                                        </select>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-md-6">
                                                <div class="form-group">
                                                    <label class="control-label col-md-6">
                                                        Account Number ( Pl attach a copy of the cancelled cheque leaf / passbook)
                                                        <span class="required">*</span>
                                                        :
                                                    </label>
                                                    <div class="col-md-6">
                                                        <input name="accNo" type="text" value="<%=bean.getAccNo()%>" class="form-control">
                                                        
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
                                        <div class="col-md-12">

                                            <div class="col-md-10">
                                                <div class="form-group ">
                                                    <label class="control-label col-md-6" style="text-decoration:underline; font-weight:600">
                                                     For Self and Co-Trustees of _AAIEDCPS_Superannuation Scheme.
                                                                                                 </label>
                                                  
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
                                    <div style="height:70px;"></div>
                                    <div class="row">
                                        <div class="col-md-12">

                                            <div class="col-md-6">
                                                <div class="form-group ">
                                                    <label class="control-label col-md-6" style="font-weight:600">
                                                       (Sign. Of Member/Beneficiary )
                                                      
                                                    </label>
                                                    <div class="col-md-6">
                                                    
                                                       
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-md-6">
                                                <div class="form-group ">
                                                    <label class="control-label col-md-6">
                                                    </label>
                                                    <div class="col-md-6" style="font-weight:600">
Signature of The Trustee
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                     <div style="height:70px;"></div>
                                    <div class="row">
                                        <div class="col-md-12">

                                            <div class="col-md-6">
                                                <div class="form-group ">
                                                    <label class="control-label col-md-6" style="font-weight:600">
                                                      
                                                      
                                                    </label>
                                                    <div class="col-md-6">
                                                    
                                                       
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-md-6">
                                                <div class="form-group ">
                                                    <label class="control-label col-md-6">
                                                    </label>
                                                    <div class="col-md-6" style="font-weight:600">
(Name & Stamp)
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-md-12">

                                            <div class="col-md-12">
                                                <div class="form-group ">
                                                    <label class="control-label col-md-8" style="font-weight:600">
                                     Note: - It very important that appropriate answers are given. Without which the settlement will not be possible.
 
                 
                                                      
                                                    </label>
                                                    <div class="col-md-4">
                                                    
                                                       
                                                    </div>
                                                </div>
                                            </div>
                                            
                                        </div>
                                  
                                    
											
											<div class="">
												<div class="col-md-12" style="text-align:center">
												<% if(userinfo.getProfile().equals("M")){%>
												<button type="button" class="btn blue" onclick="return validateLicFormDraft()">Save Draft</button>
												<%} %>
													<button type="button" class="btn green" onclick="return validateLicForm()">Save</button>
													<button type="button" class="btn default">Cancel</button>
												</div>
											</div>
                                            </div>
                                              </div>
                                              
										</form>
										</fieldset>
										<!-- END FORM-->
									</div>
								</div>
								
							</div>
							<div class="tab-pane <%=form.equals("dir")? " active":"" %>" id="tab_1">
								<div class="portlet box blue">
									<div class="portlet-title">
										<div class="caption">
											<i class="fa fa-reorder"></i>Discharge Receipt
										</div>
										<div class="tools">
											
										</div>
									</div>
									<div class="portlet-body form" style="background:#FFF">
									<form name="dir" method="post">"
                                    <div class="invoice">
				
				<div class="row">
					<div class="col-xs-12">
						<div class="form-body">
												<h4 class="form-section" style="text-align:center; font-weight:400 !important;">Discharge Receipt <br>
(To be completed by the Member/Beneficiary)
</h4>
												<div class="row">
													<div class="col-md-12">
														<div class="form-group">
													<p style="padding:30px 20px	30px 70px; ">I, Shri/Smt.  <U>&nbsp;&nbsp;&nbsp;&nbsp; <%= memberName%>  &nbsp;&nbsp;&nbsp;&nbsp;</U>      received from the Life Insurance Corporation of India the sum of Rs. ____________________ (Rupees________________________________________________________________________________) in full satisfaction and discharge of my under mentioned claims and demand under Master Policy No- 103006297 </p>		
														</div>
													</div>
													<!--/span-->
													
													<!--/span-->
												</div>
                                                <div class="row">
                                    <div class="col-md-12">

                                        <div class="col-md-6">
                                            <div class="form-group ">
                                                <label class="control-label col-md-4">
                                                   Commuted Value 
                                                    
                                                </label>
                                                <div class="col-md-8">
                                                 <input type="hidden" name="appId" value='<%=appId %>'> 
                                                 <input type="hidden" name="bname" value='<%=memberName %>'>
                                                 <input type="hidden" name="pfid" value='<%=pfid%>'/>"
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-md-6">
                                            <div class="form-group ">
                                                <label class="control-label col-md-7">
                                                  
                                                </label>
                                                <div class="col-md-5">
                                                     Rs._____________
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="row">
													<div class="col-md-12">
														<div class="form-group">
													<p style="padding:30px 20px	30px 70px; "> MLY/QLY/HLY/YLY/ pension Installment due ( _________________ .to  _________________)Rs. _________________ </p>		
														</div>
													</div>
													<!--/span-->
													
													<!--/span-->
												</div>
                                                <div class="row">
                                    <div class="col-md-12">

                                        <div class="col-md-6">
                                            <div class="form-group ">
                                                <label class="control-label col-md-4">
                                                   TOTAL
                                                    
                                                </label>
                                                <div class="col-md-8">
                                                  
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-md-6">
                                            <div class="form-group ">
                                                <label class="control-label col-md-7">
                                                  
                                                </label>
                                                <div class="col-md-5">
                                                     Rs._____________
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-md-12">

                                        <div class="col-md-6">
                                            
                                             <table width="100%" border="0" cellspacing="0" cellpadding="0">
                                  <tr>
                                   <td class="col-md-2">Signature  : </td>  <td class="col-md-10"> ___________________________</td> 
                                  </tr>
                                  <tr>
                                   <td class="col-md-2">Name  : </td>  <td class="col-md-10"> ___________________________</td> 
                                  </tr>
                                  <tr>
                                   <td class="col-md-2">Address  : </td> 
                                    <td class="col-md-10"> ___________________________</td> 
                                  </tr>
                                </table>
                                        </div>
                                        <div class="col-md-6">
                 <table width="100%" border="0" cellspacing="0" cellpadding="0">
                                  <tr>
                                   <td class="col-md-5"></td> <td class="col-md-2" style="height:98px !important; width:80px !important; border: solid 1px; border-color:#808080" align="center">
                                    Across<br> Rs.1/- <br>Revenue<br> Stamp
                                    </td> <td class="col-md-5"></td>
                                  </tr>
                                   <tr>
                                   <td class="col-md-12" align="center" colspan="3">
                                  Signature of the Member/Beneficiary
                                   </td>
                                  </tr>
                                </table>

                                        </div>
                                    </div>
                                </div>
                                
                                
                                
                                
											<div class="" style="text-align:center">
												<a class="btn blue hidden-print" onclick="javascript:window.print();">Print <i class="fa fa-print"></i></a>
												<button type="button" class="btn green" onclick="return validateDirForm()"><i class="fa fa-check"></i> Save</button>
											</div>
										
									</div>
					</div>
				</div>
				
			</div>
			</form>
                                    
                                    	<!-- BEGIN FORM-->
										
											
								</div>
							</div>
							
							
						</div>
                        
                        <div class="tab-pane <%=form.equals("nomineeForm")? "active":"" %>" id="tab_2">
								<div class="portlet box blue">
									<div class="portlet-title">
										<div class="caption">
											<i class="fa fa-reorder"></i>Nomination
										</div>
										<div class="tools">
											
										</div>
									</div>
									<div class="portlet-body form">
									<form name="nomineeForm" >
                                    <div class="invoice">
				
				<div class="row">
					<div class="col-xs-12">
						<div class="form">
                        
												<h4 class="form-section" style="text-align:center; font-weight:400 !important;">
( To be completed by the Annuitant and kept/Preserved with the Trustee )
</h4>
												<div class="row">
													<div class="col-md-12">
														<div class="form-group">
													<p style="padding:30px 20px	9px 70px; ">I,  Shri/Smt <u>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <%=memberName %>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</u> 	a member of AAIEDCPS Superannuation Scheme hereby appoint nominees in terms of the Nomination Rules governing the fund to received the Pension in the event of my death during the guaranteed period as per the rules of the fund or to receive the Capital refund under Return of Capital Scheme in the event of my death as given below: </p>		
														</div>
													</div>
													<!--/span-->
													
													<!--/span-->
												</div>
												
												 <div id="nomineetables" style="display:none">   
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
											
												
												
												
                                                
                             
                                
                               <div class="row" style="margin-top:20px;">
                                        <div class="col-md-12">

                                            <div class="col-md-6">
                                                <div class="form-group ">
                                                    <label class="control-label col-md-8" style="text-decoration:underline; font-weight:600">
                                            If the nominee is minor, furnish the details of appointee:
                                                                                                 </label>
                                                  
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
                              
  </div>                            
                              
            <input type="hidden" name="appId" value='<%=appId %>'> 
                                                 <input type="hidden" name="bname" value='<%=memberName %>'>
                                                 <input type="hidden" name="pfid" value='<%=pfid%>'/>	                  
                              
                              
                                <div class="row">
													<div class="col-md-12">
														<div class="form-group">
													<p style="padding:30px 20px	9px 70px; ">I further agree and declare that upon such PENSION payment or RETURN OF CAPITAL amount, the Corporation will be discharged of all liability in this respect under the Master Policy No 103006297 </p>		
														</div>
													</div>
													<!--/span-->
													
													<!--/span-->
												</div>
                                    <div class="row">
                                        <div class="col-md-12">

                                            <div class="col-md-6">
                                                <div class="form-group ">
                                                    <label class="control-label col-md-2" style=" font-weight:600">
                                            Place  :
                                                                                                 </label>
                                                  
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
                                    <div class="row" >
                                        <div class="col-md-12">

                                            <div class="col-md-6">
                                                <div class="form-group ">
                                                    <label class="control-label col-md-2" style="font-weight:600">
                                          Date  :
                                                                                                 </label>
                                                  
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
                                    
                                    <div class="row" style="margin-top:50px;">
					<div class="col-xs-6 invoice-block" style="text-align:center">
						<ul class="list-unstyled amounts">
							<li>
							<strong>Signature of Member / Annuitant  :</strong>
							
							</li>
						</ul>
						
					</div>
					<div class="col-xs-6 invoice-block" style="text-align:center">
						<ul class="list-unstyled amounts">
							<li>
								<strong>Counter Signature by the Trustee<br/>
Seal of the Truste</strong>
							
							</li>
						</ul>
						
					</div>
				</div>
                                    
                     <div class="row" style="display:none">
      <div class="col-md-6">
          <div class="form-group">   
                <select name="nomineeDetails" multiple></select>
            </div>
      </div>
  </div>  
                  <div class="row" style="display:none">
      <div class="col-md-6">
          <div class="form-group">   
                <select name="nomineeDetailsChild" multiple></select>
            </div>
      </div>
  </div>             
                                            
                                                
											<div  style="text-align:center">
												<a class="btn blue hidden-print" onclick="javascript:window.print();">Print <i class="fa fa-print"></i></a>
												<button type="submit" class="btn green" onclick="return validateNominee()"><i class="fa fa-check"></i> Save</button>
											</div>
										
									</div>
					</div>
				</div>
				
			</div>
            </form>                        
                                    	<!-- BEGIN FORM-->
										
											
								</div>
							</div>
							
							
						</div>
					</div>
				</div>
			</div>
			<!-- END PAGE CONTENT-->
		</div>
	</div>
	<!-- END CONTENT -->
</div>
							
			
			
					
		
  </body>
  <!--  <script>
  $( function() {
		$( "#datepicker" ).datepicker({
			changeMonth: true,
			changeYear: true
		});
		
	} );
	</script>-->
</html>

