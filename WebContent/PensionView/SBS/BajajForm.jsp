<%@ page language="java" import="java.util.*" pageEncoding="ISO-8859-1"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <jsp:include page="/SBSHeader.jsp"></jsp:include>
<jsp:include page="/PensionView/SBS/Menu.jsp"></jsp:include>
   
    <base href="<%=basePath%>">
    
    <title>My JSP 'BajajForm.jsp' starting page</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
 <style>
        fieldset {
            padding: 20px 4px;
            margin: 10px 10px;
            border: 1px solid #c0c0c0;
            border-radius: 10px;
        }

        .background {
            background-color: #176196;
            margin-bottom: 12px;
            text-align: center;
        }

        legend {
            height: 22px;
            font-weight: 600;
            font-size: 12px;
            padding: 2px 10px;
            margin-bottom: 0;
            color: #fff;
            border: 1px solid #bbb;
            border-radius: 6px;
            background-image: linear-gradient(#122a74, #596eaf);
        }
		.form-section {
    margin: 30px 0px 25px 0px;
    padding-bottom: 5px;
    border-bottom: 21px solid #2d55a9;
}

    </style>
    <script type="text/javascript">
    var detailArray = new Array();
    var detailArray1 = new Array();
    var srno,nomineename,nomineeaddress,nomineeDOB,nomineerelation,gardianname,gardianaddress,totalshare,nomineeflag;
    function frmload(){
    $('#spouseDetails').hide();
    $('#documentCheckList').hide();
    getSpouse();
    }

    function showValues() {    
     
    var heading1='Name & Surname';
    var heading2='Place of Birth';
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

    str+='<TD data-title='+heading2+'> <input type="text"  name="nomineeGender" id="nomineeGender"   class="form-control" ></TD>';

    str+='<TD data-title='+heading3+'> <div class="input-icon"><i class="fa fa-calendar"></i> <input class="form-control date-picker" size="16" placeholder="dd/Mon/yyyy" NAME="nDOB"  id="nDOB" data-date-format="dd-M-yyyy" data-date-viewmode="years" type="text"></div></TD>';
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
    document.BAJAJForm.nomineeDetails.options[document.BAJAJForm.nomineeDetails.options.length]=new Option('x',temp);
    document.BAJAJForm.nomineeDetails.options[document.BAJAJForm.nomineeDetails.options.length-1].selected=true;
    }
    }
    function setValues1() {
    var temp;
    for(var i=0;i<detailArray1.length;i++) {
    temp = detailArray1[i][0]+'|'+detailArray1[i][1]+'|'+detailArray1[i][2];
    document.BAJAJForm.nomineeDetailsChild.options[document.BAJAJForm.nomineeDetailsChild.options.length]=new Option('x',temp);
    document.BAJAJForm.nomineeDetailsChild.options[document.BAJAJForm.nomineeDetailsChild.options.length-1].selected=true;
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
    detailArray[detailArray.length]=[document.BAJAJForm.nomineeName.value,document.BAJAJForm.nomineeGender.value,document.BAJAJForm.nDOB.value,document.BAJAJForm.relationShip.value,document.BAJAJForm.percentage.value];

    }
    function save1()	{  

    detailArray1[detailArray1.length]=[document.BAJAJForm.apponteeNameAdress.value,document.BAJAJForm.appointeeRelationShip.value,document.BAJAJForm.appointeeDOB.value];

    }

    function clearDetails()	{

    document.BAJAJForm.nomineeName.value="";
    document.BAJAJForm.nomineeGender.value="";
    document.BAJAJForm.nDOB.value="";
    document.BAJAJForm.relationShip.value="";
    document.BAJAJForm.percentage.value="";
    }
    function clearDetails1()	{

    document.BAJAJForm.apponteeNameAdress.value="";
    document.BAJAJForm.appointeeRelationShip.value="";
    document.BAJAJForm.appointeeDOB.value="";

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
    function validate(){
    
    setValues();
	setValues1();
    var url="<%=basePath%>SBSAnnuityServlet?method=addBajaj&&menu=M5L3&&formType=BAJAJ";
	//alert(url);
				document.BAJAJForm.action=url;
				document.BAJAJForm.method="post";
				document.BAJAJForm.submit();

    
    }
    
    function frmload(){
		$('#spouseDetails').hide();
		$('#spouseDetails1').hide();
		$('#documentCheckList').hide();
 	getSpouse();
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
		if(option=='B' || option=='D'){
		$('#spouseDetails').show();
		$('#spouseDetails1').show();
		}else{
		$('#spouseDetails').hide();
		$('#spouseDetails1').hide();
	
		}
		if(option=='A'){
		$('#optionA').show();
		$('#optionAB').show();
		$('#optionB').hide();
		$('#optionC').hide();
		$('#optionD').hide();
		$('#optionCD').hide();
		} 
		if(option=='B'){
		$('#optionB').show();
		$('#optionAB').show();
		$('#optionA').hide();
		$('#optionC').hide();
		$('#optionD').hide();
		$('#optionCD').hide();
		}
		if(option=='C'){
		$('#optionC').show();
		$('#optionCD').show();
		$('#optionA').hide();
		$('#optionB').hide();
		$('#optionD').hide();
		$('#optionAB').hide();
		}
		if(option=='D'){
		$('#optionD').show();
		$('#optionCD').show();
		$('#optionA').hide();
		$('#optionC').hide();
		$('#optionB').hide();
		$('#optionAB').hide();
		}
		}
    
    </script>
  </head>
<body onload="javascript:frmload(),showValues(),showValues1()">
  <form name="BAJAJForm"  method="post">
  
   	<div class="page-content-wrapper">
		<div class="page-content">
		<div class="row">
			    <div class="col-md-12">
				<h3 class="page-title">BAJAJ Form</h3>
				<ul class="page-breadcrumb breadcrumb"></ul>
			    </div>
			</div>
			<div class="row">
                    <div class="col-md-12">
                        <!-- BEGIN PORTLET-->
                        <div class="portlet box blue">
                            <div class="portlet-title">
                                <div class="caption">
                                    <i class="fa fa-reorder"></i>Bajaj Allianz Form
                                </div>
                            
                            </div>
			 <div class="portlet-body form">
                                <div class="row">
                                    <div class="col-md-12" style="margin-top:20px;">

                                        <div class="col-md-6">
                                            <div class="form-group ">
                                                <label class="control-label col-md-6">
                                                    Master Policy No  <span class="required"></span>
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
                                                    Mastre Policy Holder Name  :
                                                </label>
                                                <div class="col-md-6">
                                                    <input name="policyholdername" maxlength="40" class="form-control" type="text">
                                                </div>
                                            </div>
                                        </div>

                                    </div>
                                </div>
                                <div class="row">
                                <div class="col-md-6">
                                            <div class="form-group ">
                                                <label class="control-label col-md-6">
                                                   Employee Number(PF ID)  :
                                                </label>
                                                <div class="col-md-6">
                                                    <input name="PFID" maxlength="40" class="form-control" type="text">
                                                </div>
                                            </div>
                                        </div>
                                </div>
                                <div class="row">
                                    <div class="col-md-12" style="margin-top:10px;">
                                        <h3  style="text-align:center; font-weight:400 !important;"> &nbsp;    Enrollment Form for Group Annuity for</h3>
                                 
                                    </div>
                                </div>
  <div class="container">
    <div class="row">
   
     
        <div class="col-md-11">
            <h4 class="bg-blue">Scheme Option</h4>
            
    
</div>
</div>
</div>
   <div class="row">
    <div class="form-group">
     
        <div class="col-md-11">
            <h4>&nbsp;&nbsp;&nbsp;For Group Annuity:</h4>
            
    </div>
    </div>
    
</div>
                                
                                    

                                    <div class="row">
                                        <div class="col-md-12">
                                            <div class="col-md-1">
                                                Option 1
                                            </div>
                                            <div class="col-md-6">
                                                Life Annuity With Return of Purchase  price  &nbsp;
                                            </div>
                                            <div class="col-md-1">
                                                <input name="aaiedcpsOption" id="aaiedcpsOption" type="radio" value="B" class="redio" onclick="getoption(),getSpouse()">
                                            </div>
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-md-12">
                                            <div class="col-md-1">
                                                Option 2
                                            </div>
                                            <div class="col-md-6">
                                                Joint Life , Last Survivor Annuity With Return of Purchase Price
                                            </div>
                                            <div class="col-md-1">
                                           <input name="aaiedcpsOption" id="aaiedcpsOption" type="radio" value="D" class="redio" onclick="getoption(),getSpouse()">
                                            </div>
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-md-12">
                                            <div class="col-md-1">
                                                Option 3
                                            </div>
                                            <div class="col-md-6">
                                                Life Annuity
                                            </div>
                                            <div class="col-md-1">
                                                <input name="aaiedcpsOption" id="aaiedcpsOption" type="radio" value="A" class="redio" onclick="getoption(),getSpouse()">
                                            </div>
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-md-12">
                                            <div class="col-md-1">
                                                Option 4
                                            </div>
                                            <div class="col-md-6">
                                                Joint Life last Survivor Annuity
                                            </div>
                                            <div class="col-md-1">
                                               <input name="aaiedcpsOption" id="aaiedcpsOption" type="radio" value="B" class="redio" onclick="getoption(),getSpouse()">
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
                    

<div class="container">
    <div class="row">
   
     
        <div class="col-md-11">
            <h4 class="bg-blue">Coverage information</h4>
            
    
</div>
</div>
</div>


                               
                                    
                                    <div class="row">
                                        <div class="col-md-12">

                                            <div class="col-md-6">
                                                <div class="form-group ">
                                                    <label class="control-label col-md-6">
                                                        Purchase Price Annuity amt (in Rs) <span class="required">*</span>
                                                        :
                                                    </label>
                                                    <div class="col-md-6">
                                                        <input name="purchaseprice" maxlength="40" class="form-control" type="text">
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-md-6">
                                                <div class="form-group ">
                                                    <label class="control-label col-md-6">
                                                       Check / DD Date <span class="required">*</span> :
                                                    </label>
                                                    <div class="col-md-6">
                                                        <input name="checkdddate" maxlength="40" class="form-control" type="text">
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
                                                    Annuity <span class="required">*</span>
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
                                    
                                            <div class="col-md-6">
                                                <div class="form-group ">
                                                    <label class="control-label col-md-6">
                                                        Check / DD No <span class="required">*</span> :
                                                    </label>
                                                    <div class="col-md-6">
                                                        <input name="checkddno" maxlength="40" class="form-control" type="text">
                                                    </div>
                                                </div>
                                            </div>

                                        </div>
                                    </div>
                              


                                <div class="row">
                                    <div class="col-lg-12">
                                        <div class="col-md-6">
                                            <fieldset>
                                                <legend>Personal Details Of The MAIN MEMBER</legend>
                                                <div class="row">
                                                    <div class="col-md-12">

                                                        <div class="col-md-12">
                                                            <div class="form-group ">
                                                                <label class="control-label col-md-6">
                                                                    Title  Mr/Mrs/Ms/Dr First Name  <span class="required">*</span>
                                                                    :
                                                                </label>
                                                                <div class="col-md-6">
                                                                    <input name="mainfirstname" maxlength="40" class="form-control" type="text">
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="row">
                                                    <div class="col-md-12">

                                                        <div class="col-md-12">
                                                            <div class="form-group ">
                                                                <label class="control-label col-md-6">
                                                                    Middle Name  <span class="required">*</span>
                                                                    :
                                                                </label>
                                                                <div class="col-md-6">
                                                                    <input name="mainmiddlename" maxlength="40" class="form-control" type="text">
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="row">
                                                    <div class="col-md-12">

                                                        <div class="col-md-12">
                                                            <div class="form-group ">
                                                                <label class="control-label col-md-6">
                                                                    Last Name  <span class="required">*</span>
                                                                    :
                                                                </label>
                                                                <div class="col-md-6">
                                                                    <input name="mainlastname" maxlength="40" class="form-control" type="text">
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="row">
                                                    <div class="col-md-12">
                                                        <div class="form-group ">
                                                            <label class="control-label col-md-6">
                                                                Date of Birth  <span class="required">*</span>
                                                                :
                                                            </label>
                                                            <div class="col-md-6">
                                                                <div class="input-group input-medium date date-picker col-md-12"  data-date-format="dd-M-yyyy" data-date-viewmode="years" data-date-minviewmode="months">
                                                                    <input type="text" class="form-control" name="maindob" readonly>
                                                                    <span class="input-group-btn" style="width:0px;">
                                                                        <button class="btn default" type="button" style="padding: 4px 14px;"><i class="fa fa-calendar"></i></button>
                                                                    </span>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="row">
                                                    <div class="col-md-12">
                                                        <div class="form-group ">
                                                            <label class="control-label col-md-6">
                                                                Gender (Sex)  <span class="required">*</span>
                                                                :
                                                            </label>
                                                            <div class="col-md-6">
                                                                <select class="form-control" style="width:95% !important"><option value="">Select </option> <option value="F">Female </option><option value="M">Male</option></select>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>

                                                <div class="row">
                                                    <div class="col-md-12">
                                                        <div class="form-group ">
                                                            <label class="control-label col-md-6">
                                                                Nationality <span class="required">*</span>
                                                                :
                                                            </label>
                                                            <div class="col-md-6">
                                                                <input name="mainNotionality" maxlength="40" class="form-control" type="text">
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="row">
                                                    <div class="col-md-12">
                                                        <div class="form-group ">
                                                            <label class="control-label col-md-6">
                                                                Age  <span class="required">*</span>
                                                                :
                                                            </label>
                                                            <div class="col-md-6">
                                                                <input name="mainage" maxlength="40" class="form-control" type="text">
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="row">
                                                    <div class="col-md-12">
                                                        <div class="form-group ">
                                                            <label class="control-label col-md-6">
                                                                Place of Birth  <span class="required">*</span>
                                                                :
                                                            </label>
                                                            <div class="col-md-6">
                                                                <input name="mainplaceofbirth" maxlength="40" class="form-control" type="text">
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="row">
                                                    <div class="col-md-12">
                                                        <div class="form-group ">
                                                            <label class="control-label col-md-6">
                                                                Age Proof  <span class="required">*</span>
                                                                :
                                                            </label>
                                                            <div class="col-md-6">
                                                                <input name="mainageproof" maxlength="40" class="form-control" type="text">
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="row">
                                                    <div class="col-md-12">
                                                        <div class="form-group ">
                                                            <label class="control-label col-md-6">
                                                                PAN  <span class="required">*</span>
                                                                :
                                                            </label>
                                                            <div class="col-md-6">
                                                                <input name="mainpan" maxlength="40" class="form-control" type="text">
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="row">
                                                    <div class="col-md-12">
                                                        <div class="form-group ">
                                                            <label class="control-label col-md-6">
                                                                Preferred Language <span class="required">*</span>
                                                                :
                                                            </label>
                                                            <div class="col-md-6">
                                                                <input name="mainpreferredlanguage" maxlength="40" class="form-control" type="text">
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>

                                            </fieldset>
                                        </div>
                                        <div id="spouseDetails">
                                        <div class="col-md-6">
                                            <fieldset>
                                                <legend>Personal Details Of JOINT LIFE MEMBER (if joint life option is selected)</legend>

                                                <div class="row">
                                                    <div class="col-md-12">

                                                        <div class="col-md-12">
                                                            <div class="form-group ">
                                                                <label class="control-label col-md-6">
                                                                    Title  Mr/Mrs/Ms/Dr First Name  <span class="required">*</span>
                                                                    :
                                                                </label>
                                                                <div class="col-md-6">
                                                                    <input name="firstname" maxlength="40" class="form-control" type="text">
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="row">
                                                    <div class="col-md-12">

                                                        <div class="col-md-12">
                                                            <div class="form-group ">
                                                                <label class="control-label col-md-6">
                                                                    Middle Name  <span class="required">*</span>
                                                                    :
                                                                </label>
                                                                <div class="col-md-6">
                                                                    <input name="middlename" maxlength="40" class="form-control" type="text">
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="row">
                                                    <div class="col-md-12">

                                                        <div class="col-md-12">
                                                            <div class="form-group ">
                                                                <label class="control-label col-md-6">
                                                                    Last Name  <span class="required">*</span>
                                                                    :
                                                                </label>
                                                                <div class="col-md-6">
                                                                    <input name="lastname" maxlength="40" class="form-control" type="text">
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="row">
                                                    <div class="col-md-12">
                                                        <div class="form-group ">
                                                            <label class="control-label col-md-6">
                                                                Date of Birth  <span class="required">*</span>
                                                                :
                                                            </label>
                                                            <div class="col-md-6">
                                                                <div class="input-group input-medium date date-picker col-md-12"  data-date-format="dd-M-yyyy" data-date-viewmode="years" data-date-minviewmode="months">
                                                                    <input type="text" name="dob" class="form-control" readonly>
                                                                    <span class="input-group-btn" style="width:0px;">
                                                                        <button class="btn default" type="button" style="padding: 4px 14px;"><i class="fa fa-calendar"></i></button>
                                                                    </span>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="row">
                                                    <div class="col-md-12">
                                                        <div class="form-group ">
                                                            <label class="control-label col-md-6">
                                                                Gender (Sex)  <span class="required">*</span>
                                                                :
                                                            </label>
                                                            <div class="col-md-6">
                                                                <select class="form-control" name="gender" style="width:95% !important"><option value="">Select </option> <option value="F">Female </option><option value="M">Male</option></select>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>

                                                <div class="row">
                                                    <div class="col-md-12">
                                                        <div class="form-group ">
                                                            <label class="control-label col-md-6">
                                                                Nationality <span class="required">*</span>
                                                                :
                                                            </label>
                                                            <div class="col-md-6">
                                                                <input name="nationality" maxlength="40" class="form-control" type="text">
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="row">
                                                    <div class="col-md-12">
                                                        <div class="form-group ">
                                                            <label class="control-label col-md-6">
                                                                Age  <span class="required">*</span>
                                                                :
                                                            </label>
                                                            <div class="col-md-6">
                                                                <input name="age" maxlength="40" class="form-control" type="text">
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="row">
                                                    <div class="col-md-12">
                                                        <div class="form-group ">
                                                            <label class="control-label col-md-6">
                                                                Place of Birth  <span class="required">*</span>
                                                                :
                                                            </label>
                                                            <div class="col-md-6">
                                                                <input name="placeofbirth" maxlength="40" class="form-control" type="text">
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="row">
                                                    <div class="col-md-12">
                                                        <div class="form-group ">
                                                            <label class="control-label col-md-3">
                                                                Age Proof <span class="required">*</span>
                                                                :
                                                            </label>
                                                            <div class="col-md-3">
                                                                <span> <input name="birthcertificate" type="checkbox" >  Birth Certificate   </span>
                                                            </div>
                                                            <div class="col-md-3">
                                                                <span> <input name="ssc" type="checkbox" > </span>SSC Certificate
                                                            </div>

                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="row">
                                                    <div class="col-md-12">
                                                        <div class="form-group ">

                                                            <div class="col-md-3">

                                                            </div>
                                                            <div class="col-md-3">
                                                                <span> <input name="drivinglicense" type="checkbox" > </span>Driving License

                                                            </div>
                                                            <div class="col-md-3">
                                                                <span> <input name="passport" type="checkbox" >  Passport </span>
                                                            </div>
                                                            <div class="col-md-3">
                                                                <span> <input name="panageproof" type="checkbox" > </span>  PAN
                                                            </div>

                                                        </div>
                                                    </div>
                                                </div>


                                                <div class="row">
                                                    <div class="col-md-12">
                                                        <div class="form-group ">
                                                            <label class="control-label col-md-7">
                                                                Relation of Member to Counter Member <span class="required">*</span>
                                                                :
                                                            </label>
                                                            <div class="col-md-5">
                                                                <input name="relationtocounter" maxlength="40" class="form-control" type="text">
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </fieldset>
                                        </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-lg-12">
                                        <div class="col-md-6">
                                            <fieldset>
                                                <legend>CURRENT  MAILING ADDRESS</legend>
                                                <div class="row">
                                                    <div class="col-md-12">

                                                        <div class="col-md-12">
                                                            <div class="form-group ">
                                                                <label class="control-label col-md-6">
                                                                    Occupation  <span class="required">*</span>
                                                                    :
                                                                </label>
                                                                <div class="col-md-6">
                                                                    <input name="mainoccupation" maxlength="40" class="form-control" type="text">
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="row">
                                                    <div class="col-md-12">

                                                        <div class="col-md-12">
                                                            <div class="form-group ">
                                                                <label class="control-label col-md-6">
                                                                    Door No  <span class="required">*</span>
                                                                    :
                                                                </label>
                                                                <div class="col-md-6">
                                                                    <input name="maindoorno" maxlength="40" class="form-control" type="text">
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="row">
                                                    <div class="col-md-12">

                                                        <div class="col-md-12">
                                                            <div class="form-group ">
                                                                <label class="control-label col-md-6">
                                                                    Building Name  <span class="required">*</span>
                                                                    :
                                                                </label>
                                                                <div class="col-md-6">
                                                                    <input name="mainbuildingname" maxlength="40" class="form-control" type="text">
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="row">
                                                    <div class="col-md-12">
                                                        <div class="form-group ">
                                                            <label class="control-label col-md-6">
                                                                Plot / Street Name  <span class="required">*</span>
                                                                :
                                                            </label>
                                                            <div class="col-md-6">
                                                                   <input type="text"  name="mainstreetname" class="form-control" >
                                                                 
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                               
                                                <div class="row">
                                                    <div class="col-md-12">
                                                        <div class="form-group ">
                                                            <label class="control-label col-md-6">
                                                                Landmark / Area  <span class="required">*</span>
                                                                :
                                                            </label>
                                                            <div class="col-md-6">
                                                                 <input name="mainlandmark" maxlength="40" class="form-control" type="text">
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>

                                                <div class="row">
                                                    <div class="col-md-12">
                                                        <div class="form-group ">
                                                            <label class="control-label col-md-6">
                                                                Place  <span class="required">*</span>
                                                                :
                                                            </label>
                                                            <div class="col-md-6">
                                                                <input name="mainplace" maxlength="40" class="form-control" type="text">
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="row">
                                                    <div class="col-md-12">
                                                        <div class="form-group ">
                                                            <label class="control-label col-md-6">
                                                                City / District <span class="required">*</span>
                                                                :
                                                            </label>
                                                            <div class="col-md-6">
                                                                <input name="maincity" maxlength="40" class="form-control" type="text">
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="row">
                                                    <div class="col-md-12">
                                                        <div class="form-group ">
                                                            <label class="control-label col-md-6">
                                                                State   <span class="required">*</span>
                                                                :
                                                            </label>
                                                            <div class="col-md-6">
                                                                <input name="mainstate" maxlength="40" class="form-control" type="text">
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="row">
                                                    <div class="col-md-12">
                                                        <div class="form-group ">
                                                            <label class="control-label col-md-6">
                                                                Pin Code  <span class="required">*</span>
                                                                :
                                                            </label>
                                                            <div class="col-md-6">
                                                                <input name="mainpincode" maxlength="40" class="form-control" type="text">
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="row">
                                                    <div class="col-md-12">
                                                        <div class="form-group ">
                                                            <label class="control-label col-md-6">
                                                                Email  <span class="required">*</span>
                                                                :
                                                            </label>
                                                            <div class="col-md-6">
                                                                <input name="mainemail" maxlength="40" class="form-control" type="text">
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="row">
                                                    <div class="col-md-12">
                                                        <div class="form-group ">
                                                            <label class="control-label col-md-6">
                                                                Mobile No <span class="required">*</span>
                                                                :
                                                            </label>
                                                            <div class="col-md-6">
                                                                <input name="mainmobileno" maxlength="40" class="form-control" type="text">
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="row">
                                                    <div class="col-md-12">
                                                        <div class="form-group ">
                                                            <label class="control-label col-md-3">
                                                                Address Proof <span class="required">*</span>
                                                                :
                                                            </label>
                                                            <div class="col-md-3">
                                                                <span> <input name="mainaddresspassport" type="checkbox" >  Passport </span>
                                                            </div>
                                                            <div class="col-md-3">
                                                                <span> <input name="mainadressvoterid" type="checkbox" > </span> Voter ID
                                                            </div>
                                                            <div class="col-md-3">
                                                                <span> <input name="mainadressrationcard" type="checkbox" > </span> Ration Card
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="row">
                                                    <div class="col-md-12">
                                                        <div class="form-group ">

                                                            <div class="col-md-3">

                                                            </div>
                                                            <div class="col-md-3">
                                                                <span> <input name="mainadressdrivinglicence" type="checkbox" > </span>Driving Licence
                                                            </div>
                                                            <div class="col-md-3">
                                                                <span> <input name="mainadressaadharcard" type="checkbox" > Aadhar Card</span>
                                                            </div>
                                                            <div class="col-md-3">
                                                                <span>   <input name="mainadressrechscard" type="checkbox" >  RECHS Card </span>
                                                            </div>

                                                        </div>
                                                    </div>
                                                </div>

                                            </fieldset>
                                        </div>
                                        <div id="spouseDetails1">
                                        <div class="col-md-6">
                                            <fieldset>
                                                <legend>CURRENT  MAILING ADDRESS</legend>
                                                <div class="row">
                                                    <div class="col-md-12">

                                                        <div class="col-md-12">
                                                            <div class="form-group ">
                                                                <label class="control-label col-md-6">
                                                                    Occupation  <span class="required">*</span>
                                                                    :
                                                                </label>
                                                                <div class="col-md-6">
                                                                    <input name="occupation" maxlength="40" class="form-control" type="text">
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="row">
                                                    <div class="col-md-12">

                                                        <div class="col-md-12">
                                                            <div class="form-group ">
                                                                <label class="control-label col-md-6">
                                                                    Door No  <span class="required">*</span>
                                                                    :
                                                                </label>
                                                                <div class="col-md-6">
                                                                    <input name="doorno" maxlength="40" class="form-control" type="text">
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="row">
                                                    <div class="col-md-12">

                                                        <div class="col-md-12">
                                                            <div class="form-group ">
                                                                <label class="control-label col-md-6">
                                                                    Building Name  <span class="required">*</span>
                                                                    :
                                                                </label>
                                                                <div class="col-md-6">
                                                                    <input name="buildingname" maxlength="40" class="form-control" type="text">
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="row">
                                                    <div class="col-md-12">
                                                        <div class="form-group ">
                                                            <label class="control-label col-md-6">
                                                                Plot / Street Name  <span class="required">*</span>
                                                                :
                                                            </label>
                                                            <div class="col-md-6">
                                                                   <input type="text" name="streetname" class="form-control" >
                                                                    
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                
                                                <div class="row">
                                                    <div class="col-md-12">
                                                        <div class="form-group ">
                                                            <label class="control-label col-md-6">
                                                                Landmark / Area  <span class="required">*</span>
                                                                :
                                                            </label>
                                                            <div class="col-md-6">
                                                               <!--   <select class="form-control" style="width:95% !important"><option>Select </option> <option>Female </option><option>Male</option></select>-->
                                                                <input name="landmarkarea" maxlength="40" class="form-control" type="text">
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>

                                                <div class="row">
                                                    <div class="col-md-12">
                                                        <div class="form-group ">
                                                            <label class="control-label col-md-6">
                                                                Place  <span class="required">*</span>
                                                                :
                                                            </label>
                                                            <div class="col-md-6">
                                                                <input name="place" maxlength="40" class="form-control" type="text">
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="row">
                                                    <div class="col-md-12">
                                                        <div class="form-group ">
                                                            <label class="control-label col-md-6">
                                                                City / District <span class="required">*</span>
                                                                :
                                                            </label>
                                                            <div class="col-md-6">
                                                                <input name="city" maxlength="40" class="form-control" type="text">
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="row">
                                                    <div class="col-md-12">
                                                        <div class="form-group ">
                                                            <label class="control-label col-md-6">
                                                                State   <span class="required">*</span>
                                                                :
                                                            </label>
                                                            <div class="col-md-6">
                                                                <input name="state" maxlength="40" class="form-control" type="text">
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="row">
                                                    <div class="col-md-12">
                                                        <div class="form-group ">
                                                            <label class="control-label col-md-6">
                                                                Pin Code  <span class="required">*</span>
                                                                :
                                                            </label>
                                                            <div class="col-md-6">
                                                                <input name="pincode" maxlength="40" class="form-control" type="text">
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="row">
                                                    <div class="col-md-12">
                                                        <div class="form-group ">
                                                            <label class="control-label col-md-6">
                                                                Email  <span class="required">*</span>
                                                                :
                                                            </label>
                                                            <div class="col-md-6">
                                                                <input name="email" maxlength="40" class="form-control" type="text">
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="row">
                                                    <div class="col-md-12">
                                                        <div class="form-group ">
                                                            <label class="control-label col-md-6">
                                                                Mobile No <span class="required">*</span>
                                                                :
                                                            </label>
                                                            <div class="col-md-6">
                                                                <input name="mobileno" maxlength="40" class="form-control" type="text">
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="row">
                                                    <div class="col-md-12">
                                                        <div class="form-group ">
                                                            <label class="control-label col-md-3">
                                                                Address Proof <span class="required">*</span>
                                                                :
                                                            </label>
                                                            <div class="col-md-3">
                                                                <span> <input name="jointpassport" type="checkbox" >  Passport </span>
                                                            </div>
                                                            <div class="col-md-3">
                                                                <span> <input name="jointvotercard" type="checkbox"> </span> Voter ID
                                                            </div>
                                                            <div class="col-md-3">
                                                                <span> <input name="jointrationcard" type="checkbox" > </span> Ration Card
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="row">
                                                    <div class="col-md-12">
                                                        <div class="form-group ">

                                                            <div class="col-md-3">

                                                            </div>
                                                            <div class="col-md-3">
                                                                <span> <input name="jointdrivinglicence" type="checkbox" > </span>Driving Licence
                                                            </div>
                                                            <div class="col-md-3">
                                                                <span> <input name="jointaadhar" type="checkbox" > Aadhar Card</span>
                                                            </div>
                                                            <div class="col-md-3">
                                                                <span>   <input name="jointrechscard" type="checkbox" >  RECHS Card </span>
                                                            </div>

                                                        </div>
                                                    </div>
                                                </div>

                                            </fieldset>
                                        </div>
                                        </div>
                                    </div>
                                </div>
                         
                                
                                
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
                                <div style="height:10px;">
                                </div>
                                 <div style="height:10px;">
                                </div>    
                                
                                
                                
                                
                                
                                
                                
                                
                                
                                <div class="row">
                                    <div class="col-md-12" style="margin-top:10px;">
                                        <h4 class="form-section" style="text-align:left; font-weight:400 !important;">
                                            &nbsp; <i class="fa fa-cog" aria-hidden="true" style="font-size:23px;"></i> Bank Details
                                        </h4>
                                    </div>
                                </div>
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
                                                    <input name="bankname" maxlength="40" class="form-control" type="text">
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
                                                    IFSC Code  <span class="required">*</span>
                                                    :
                                                </label>
                                                <div class="col-md-6">
                                                    <input name="ifsc" maxlength="40" class="form-control" type="text">
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-md-6">
                                            <div class="form-group ">
                                                <label class="control-label col-md-6">
                                                    MICR Code <span class="required">*</span> :
                                                </label>
                                                <div class="col-md-6">
                                                    <input name="micrcode" maxlength="40" class="form-control" type="text">
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
                                                    Branch Address  <span class="required">*</span>
                                                    :
                                                </label>
                                                <div class="col-md-6">
                                                    <input name="branch" maxlength="40" class="form-control" type="text">
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-md-6">
                                            <div class="form-group ">
                                                <label class="control-label col-md-6">
                                                    <span class="required">*</span>
                                                </label>
                                                <div class="col-md-6">

                                                </div>
                                            </div>
                                        </div>

                                    </div>
                                </div>



                                <div class="row">
                                    <div class="col-md-12" style="margin-top:10px;">
                                        <h4 class="form-section" style="text-align:left; font-weight:400 !important;">
                                         
                                        </h4>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-md-12">

                                        <div class="col-md-12">
                                            <div class="form-group ">
                                                <label class="control-label col-md-12" style="text-align:justify">
                                                    I here by declare that the information provided in the above questionnaire is true to the best of my knowledge. Iconfirm that the answers I have given are, to the best of my knowledge. true. and that I have not with held any material information that may influence the assessment or acceptance of this application. I agree that this form will constitute part of my application for insurance (s) and that failure to disclose any material fact know to me may invalidate my insurance (s).
                                                </label>

                                            </div>
                                        </div>


                                    </div>
                                </div>
                                <div class="row" style="margin-top:15PX;">
                                    <div class="col-md-12">
<div class="col-md-1">
                                        <div class="form-group">

                                            <div class="col-md-6">

                                            </div>
                                        </div>
                                    </div>
                                        <div class="col-md-4">
                                            <div class="form-group ">
                                            

                                                    <div style="border:solid 1px; border-color:#c0c0c0; height:50mm; width:40mm; color:#CCC; font-size:20px; text-align:center"> <span style="margin-top:100px;"> Photo of the Main Member</span>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-md-4">
                                        <div class="form-group ">

                                            <div style="border:solid 1px; border-color:#c0c0c0; height:50mm; width:40mm; color:#CCC; font-size:20px; text-align:center"> Photo of the joint life Member
                                            </div>
                                        </div>

                                    </div>
                                    <div class="col-md-2">
                                        <div class="form-group ">

                                            <div class="col-md-6">

                                            </div>
                                        </div>
                                    </div>

                                </div>
                                </div>

                                  <div class="row">
                                    <div class="col-md-12">

                                        <div class="col-md-4">
                                            <div class="form-group" style="padding:10px;">
                                                <textarea name="" cols="" rows="" class="form-control"></textarea>
                                            </div>

                                        </div>
                                        <div class="col-md-4">
                                            <div class="form-group" style="padding:10px;">
                                                <textarea name="" cols="" rows="" class="form-control"></textarea>
                                            </div>

                                        </div>
                                         <div class="col-md-4" style="margin-top: 27px;">
                                          <label class="control-label col-md-2">
                                                    Date:
                                                    
                                                </label>
                                                <div class="col-md-2">
                                                    <div class="input-group input-medium date date-picker col-md-12" data-date="10/10/2012" data-date-format="dd/mm/yyyy" data-date-viewmode="years" data-date-minviewmode="months">
                                                                    <input type="text" class="form-control" readonly="">
                                                                    <span class="input-group-btn" style="width:0px;">
                                                                        <button class="btn default" type="button" style="padding: 4px 14px;"><i class="fa fa-calendar"></i></button>
                                                                    </span>
                                                                </div>
                                                </div>

                                        </div>
                                         

                                    </div>
                                </div>
                             <div class="row">
                                    <div class="col-md-12">

                                        <div class="col-md-4" style="margin-top: -23px;">
                                            <div class="form-group">
                                              <label class="control-label">  Signature or Thumb Impression of MainMember</label>
                                            </div>

                                        </div>
                                        
                                        
                                        
                                        <div class="col-md-4" style="margin-top: -23px !important;">
                                            <div class="form-group">
                                                <label class="control-label">  Signature or Thumb Impression of joint life Member </label>
                                            </div>

                                        </div>
                                        <div class="col-md-4">
                                            <div class="form-group ">
                                               
                                            </div>
                                        </div>

                                    </div>
                                </div>
                            
                                
                             <div class="row">
                                    <div class="col-md-12" style="margin-top:10px;">
                                        <h4 class="form-section" style="text-align:left; font-weight:400 !important;">
                                     
                                        </h4>
                                    </div>
                                </div>
                                <div class="row">
                                       <div class="col-md-12">
                                            <div class="form-group ">
                                                <label class="control-label col-md-12" style="text-align:justify">
                                                    If the signature herein is in vernacular then the proposed insured/proposer should declare below in his/her own handwriting (in the same language in which the Application is signed) that the replies were after and properly understanding the question and declarations mentioned above.
                                                </label>

                                            </div>
                                        </div>


                                    </div>
                                                                 

                                <div class="row">
                                    <div class="col-md-12">

                                        <div class="col-md-4">
                                            <div class="form-group" style="padding:10px;">
                                                <textarea name="" cols="" rows="" class="form-control"></textarea>
                                            </div>

                                        </div>
                                        <div class="col-md-4">
                                            <div class="form-group" style="padding:10px;">
                                                <textarea name="" cols="" rows="" class="form-control"></textarea>
                                            </div>

                                        </div>
                                        <div class="col-md-4" style="margin-top:27px;">
                                            <div class="form-group ">
                                                <label class="control-label col-md-2">
                                                    Date
                                                    :
                                                </label>
                                                <div class="col-md-2">
                                                 <div class="input-group input-medium date date-picker col-md-12" data-date="10/10/2012" data-date-format="dd/mm/yyyy" data-date-viewmode="years" data-date-minviewmode="months">
                                                                    <input type="text" class="form-control" readonly="">
                                                                    <span class="input-group-btn" style="width:0px;">
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

                                        <div class="col-md-4" style="margin-top: -23px;"> 
                                            <div class="form-group">
                                             <label class="control-label">    Signature or Thumb Impression of MainMember</label>
                                            </div>

                                        </div>
                                        <div class="col-md-4" style="margin-top: -23px;">
                                            <div class="form-group">
                                            <label class="control-label">      Signature or Thumb Impression of MainMember</label>
                                            </div>

                                        </div>
                                        

                                    </div>
                                </div>
                                 <div class="row">
                                    <div class="col-md-12">

                                        <div class="col-md-4">
                                            <div class="form-group" style="padding:10px;">
                                                <textarea name="" cols="" rows="" class="form-control"></textarea>
                                            </div>

                                        </div>
                                        <div class="col-md-8">
                                            <div class="form-group" style="padding:10px;">
                                                <textarea name="" cols="" rows="" class="form-control" placeholder="Name & Address of the Witness"></textarea>
                                            </div>

                                        </div>
                                        

                                    </div>
                                </div>
                             <div class="row">
                                    <div class="col-md-12">

                                        <div class="col-md-4">
                                            <div class="form-group" style="margin-top: -23px;">
                                               <label class="control-label"> Signature ofthe witness</label>
                                            </div>

                                        </div>
                                        <div class="col-md-4">
                                            <div class="form-group" style="margin-top: -23px;">
                                               <label class="control-label">  </label>
                                            </div>

                                        </div>
                                        </div>
                                </div>
                                <div class="row">
                                    <div class="col-md-6">

                                        <div class="col-md-2" >
                                            <div class="form-group">
                                               Date  : 
                                            </div>

                                        </div>
                                        <div class="col-md-6">
                                           <div class="input-group input-medium date date-picker col-md-12" data-date="10/10/2012" data-date-format="dd/mm/yyyy" data-date-viewmode="years" data-date-minviewmode="months">
                                                                    <input type="text" class="form-control" readonly="">
                                                                    <span class="input-group-btn" style="width:0px;">
                                                                        <button class="btn default" type="button" style="padding: 4px 14px;"><i class="fa fa-calendar"></i></button>
                                                                    </span>
                                                                </div>

                                        </div>
                                        </div>
                                </div>
                                 <div class="row">
                                       <div class="col-md-12">
                                            <div class="form-group ">
                                                <label class="control-label col-md-12" style="text-align:justify">
                                                    I hereby declare that the contents of the Application form including the declarations have been explained to the proposer and replies have been recorded as per the Information provided by the Counter Member and all the answers have been readout and fully understood by and confirmed by the Counter Member
                                                </label>

                                            </div>
                                        </div>


                                    </div>
                               
                                <div class="row">
                                    <div class="col-md-12">

                                        <div class="col-md-4">
                                            <div class="form-group" style="padding:10px;">
                                                <textarea name="" cols="" rows="" class="form-control"></textarea>
                                            </div>

                                        </div>
                                        <div class="col-md-4">
                                            <div class="form-group" style="padding:10px;">
                                                <textarea name="" cols="" rows="" class="form-control"></textarea>
                                            </div>

                                        </div>
                                         <div class="col-md-4">
                                            <div class="form-group" style="padding:10px;">
                                                <textarea name="" cols="" rows="" class="form-control"></textarea>
                                            </div>

                                        </div>
                                        

                                    </div>
                                </div>
                                <div class="row">
                                <div class="col-lg-12">
                                <div class="form-group">
                                <div class="col-md-4" >
                                            <div class="form-group" style="margin-top: -23px;">
                                              
                                                <div class="col-md-12">
                                                   <label class="control-label">  Signature of person filling up theApplication form </label>
                                                </div>
                                            </div>

                                        </div>
                                        <div class="col-md-4">
                                            <div class="form-group">
                                              <label class="control-label col-md-6">
                                                  
                                                </label>
                                                <div class="col-md-6">
                                                   
                                                </div>
                                            </div>

                                        </div>
                                        <div class="col-md-4" >
                                            <div class="form-group" style="margin-top: -23px;">
                                               <div class="col-md-12">
                                                   <label class="control-label">Master Policy Holder Signature and Seal</label>
                                                </div>
                                            </div>

                                        </div>
                                </div>
                                </div>
                                </div>
                                
                                
                                <div class="row">
                                <div class="col-lg-12">
                                <div class="form-group">
                                <div class="col-md-4" >
                                            <div class="form-group">
                                              <label class="control-label col-md-6">
                                                    
                                                </label>
                                                <div class="col-md-6">
                                                    
                                                </div>
                                            </div>

                                        </div>
                                        <div class="col-md-4">
                                            <div class="form-group">
                                              <label class="control-label col-md-2">
                                                    Date  :
                                                </label>
                                                <div class="col-md-2">
                                                  <div class="input-group input-medium date date-picker col-md-12"  data-date-format="dd/mm/yyyy" data-date-viewmode="years" data-date-minviewmode="months">
                                                                    <input type="text" class="form-control" readonly="">
                                                                    <span class="input-group-btn" style="width:0px;">
                                                                        <button class="btn default" type="button" style="padding: 4px 14px;"><i class="fa fa-calendar"></i></button>
                                                                    </span>
                                                                </div>
                                                </div>
                                            </div>

                                        </div>
                                        <div class="col-md-4" >
                                            <div class="form-group">
                                              <label class="control-label col-md-2">
                                                    Date  :
                                                </label>
                                                <div class="col-md-2">
                                                    <div class="input-group input-medium date date-picker col-md-12" data-date="10/10/2012" data-date-format="dd/mm/yyyy" data-date-viewmode="years" data-date-minviewmode="months">
                                                                    <input type="text" class="form-control" readonly="">
                                                                    <span class="input-group-btn" style="width:0px;">
                                                                        <button class="btn default" type="button" style="padding: 4px 14px;"><i class="fa fa-calendar"></i></button>
                                                                    </span>
                                                                </div>
                                                </div>
                                            </div>

                                        </div>
                                </div>
                                </div>
                                </div>
                                         
                                        
                                        <div class="row">
                                        <div class="col-md-12">
                                        <div class="col-lg-2"></div>
                                     <div class="col-lg-8" style="text-decoration:underline; font-weight:600; text-align:center;">
                                     Note: It is mandatory to submit all the requisite documents pertaining to the Annuity plan selected. Please note incomplete documents will lead to rejection of Annuity forms by the Annuity Service Providers.
                                     </div>                                      <div class="col-lg-2"></div>
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
                                        
                                        
                                        
                              <!--    <div class="row" style="padding:20px;">
												<div class="col-md-12" style="text-align:center">
													<button type="submit" class="btn green">Submit</button>
													<button type="button" class="btn default">Cancel</button>
												</div>
											</div>-->
											</div></div></div>
											
											</div></div></div>
											
											</form>
  </body>
</html>
