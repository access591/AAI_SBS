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

	









	function test(airportCode,serationreason,region,pensionNumber,employeeName,dateofbirth,empSerialNo,dateofseperation,dateofJoining,designation){
			document.SBIForm.priAnnuitName.value=employeeName;
			document.SBIForm.memberempno.value=empSerialNo;
		  	document.SBIForm.dos.value=dateofseperation;
			document.SBIForm.designation.value=designation;
			document.SBIForm.select_airport.value=airportCode;
		  	document.SBIForm.airport.value=airportCode;
			document.SBIForm.select_region.value=region;
		  	document.SBIForm.region.value=region;
		  	//alert(airportCode);		  		
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
		
	    progress=window.open(href, windowname, 'width=700,height=500,statusbar=yes,scrollbars=yes,resizable=yes');
		return true;
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
		alert("Please enter the PF ID of the Employee");
		document.SBIForm.memberempno.focus();
		return false;
		}

	
	if(document.SBIForm.priAnnuitName.value==""){
		alert("Please enter the  Name of Employee");
		document.SBIForm.priAnnuitName.focus();
		return false;
		}
	if(document.SBIForm.designation.value==""){
		alert("Please enter the Designation");
		document.SBIForm.designation.focus();
		return false;
		}
	
	if(document.SBIForm.dos.value==""){
		alert("Please enter the  Date of Separation/Death ");
		document.SBIForm.dos.focus();
		return false;
		}
	

	
		if(document.SBIForm.sapempcode.value==""){
		alert("Please enter the ERP SAP Employee Code (copy of AAI Identity Card attached) ");
		document.SBIForm.sapempcode.focus();
		return false;
		}
		
	
	if(document.SBIForm.mobileno.value==""){
		alert("Please enter the  Mobile No. of the Employee");
		document.SBIForm.mobileno.focus();
		return false;
		}
	

	if(document.SBIForm.emailid.value==""){
		alert("Please enter the  E-mail id of the Employee");
		document.SBIForm.emailid.focus();
		return false;
		}
	
	if(document.SBIForm.nomineename.value==""){
		alert("Please enter the   In case of deceased employee name of Nominee");
		document.SBIForm.nomineename.focus();
		return false;
		}
	
	if(document.SBIForm.empname.value==""){
		alert("Please enter the   Name of Employee/ In Case of deceased Employee-Name of Nominee (As per Saving Bank Account)");
		document.SBIForm.empname.focus();
		return false;
		}
	
	if(document.SBIForm.accountno.value==""){
		alert("Please enter the ACCOUNT No");
		document.SBIForm.accountno.focus();
		return false;
		}
	
	if(document.SBIForm.bankname.value==""){
		alert("Please enter the  Name of Bank");
		document.SBIForm.bankname.focus();
		return false;
		}
	
	if(document.SBIForm.Micrcode.value==""){
		alert("Please enter the Branch Code & MICR Code");
		document.SBIForm.Micrcode.focus();
		return false;
		}
	
	if(document.SBIForm.branchaddr.value==""){
		alert("Please enter the  Branch Address");
		document.SBIForm.branchaddr.focus();
		return false;
		}
	if(document.SBIForm.ifsccode.value==""){
		alert("Please enter the  IFSC Code");
		document.SBIForm.ifsccode.focus();
		return false;
		}
	
	if(document.SBIForm.cdate.value==""){
		alert("Please enter the  Dated ");
		document.SBIForm.cdate.focus();
		return false;
		}
	
	var url="<%=basePath%>SBSAnnuityServlet?method=addRefundCurps&&menu=M5L11&&formType=RCForm";
		//alert(url);
					document.SBIForm.action=url;
					document.SBIForm.method="post";
					document.SBIForm.submit();
}


		
</script>
  </head>
  <%  EmployeePersonalInfo empPerinfo=null ;
  empPerinfo=(EmployeePersonalInfo)request.getAttribute("empInfo")!=null?(EmployeePersonalInfo)request.getAttribute("empInfo"):new EmployeePersonalInfo() ;
   %>
 <body >
  
  <form name="SBIForm"  method="post">
  
   	<div class="page-content-wrapper">
		<div class="page-content">
			<div class="row">
			    <div class="col-md-12">
				<h3 class="page-title">Request of Refund of Corpus with AAI EDCP Trust</h3>
				<ul class="page-breadcrumb breadcrumb"></ul>
			    </div>
			</div>
    <div class="row">
                    <div class="col-md-12">
                        <!-- BEGIN PORTLET-->
                        <div class="portlet box blue">
                            <div class="portlet-title">
                                <div class="caption">
                                    <i class="fa fa-reorder"></i>Request of Refund of Corpus with AAI EDCP Trust
                                </div>
                            </div>
                            <div class="portlet-body form">
                            	 <div class="row">
                                    <div class="col-md-12"  style="margin-top:10px;"><h4 class="form-section" style="text-align:left; font-weight:400 !important;"> &nbsp; <i class="fa fa-info-circle" aria-hidden="true" style="font-size:25px;"></i>  PERSONAL INFORMATION OF Superannuated/Retired/Deceased Employee</h4>
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
                                                    Name of Employee <span class="required">*</span> :
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
                                                    Region<span class="required">*</span>
                                                    :
                                                </label>
                                                <div class="col-md-6">
                        <input type="text" NAME="select_region"   class="form-control">
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-md-6">
                                            <div class="form-group ">
                                                <label class="control-label col-md-6">
                                                   Airport Name
                                                    <span class="required">*</span> :
                                                </label>
                                                <div class="col-md-6">
                                                   <input type="text" NAME="select_airport" id="select_airport" class="form-control"   >
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
                                                  Designation <span class="required">*</span>
                                                    :
                                                </label>
                                                <div class="col-md-6">
                                                     <input name="designation" maxlength="40" class="form-control" type="text" value="">
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-md-6">
                                            <div class="form-group ">
                                                <label class="control-label col-md-6">
                                                    Date of Separation/Death  <span class="required">*</span> :
                                                </label>
                                                <div class="col-md-6">
                                                    <div class="input-group input-medium date date-picker col-md-12"  data-date-format="dd-M-yyyy" data-date-viewmode="years" data-date-minviewmode="months">
                                                        <input type="text" name="dos" class="form-control" readonly>
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
                                                  ERP SAP Employee Code (copy of AAI Identity Card attached) <span class="required">*</span>
                                                    :
                                                </label>
                                                <div class="col-md-6">
                                                     <input name="sapempcode" maxlength="40" class="form-control" type="text" value="">
                                                </div>
                                            </div>
                                        </div>
									</div>


                               <div class="row">
                                    <div class="col-md-12">

                                        <div class="col-md-6">
                                            <div class="form-group ">
                                                <label class="control-label col-md-6">
                                                    Reason for Request of Refund<span class="required">*</span>
                                                    :
                                                </label>
                                                <div class="col-md-6">
                        <input type="text" name="refundreason" value="Total Corpus appearing in SBS Card  is less than  Rs 2 lakhs" class="form-control">
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-md-6">
                                            <div class="form-group ">
                                                <label class="control-label col-md-6">
                                                    Mobile No. of the Employee
                                                    <span class="required">*</span> :
                                                </label>
                                                <div class="col-md-6">
                                                    <input name="mobileno" maxlength="40" class="form-control" type="text">
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
                                                    E-mail id of the Employee <span class="required">*</span>
                                                    :
                                                </label>
                                                <div class="col-md-6">
                                                    <input name="emailid" maxlength="40" class="form-control" type="text">
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-md-6">
                                            <div class="form-group ">
                                                <label class="control-label col-md-6">
                                                    In case of deceased employee name of Nominee  <span class="required">*</span> :
                                                </label>
                                                <div class="col-md-6">
                                                    <input name="nomineename" maxlength="40" class="form-control" type="text">
													 <input type="hidden" name="aaiedcpsOption" id="aaiedcpsOption" value="E" >
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
                                                    Name of Nominee2 <span class="required">*</span>
                                                    :
                                                </label>
                                                <div class="col-md-6">
                                                    <input name="nomineename2" maxlength="40" class="form-control" type="text">
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-md-6">
                                            <div class="form-group ">
                                                <label class="control-label col-md-6">
                                                    Name of Nominee3  <span class="required">*</span> :
                                                </label>
                                                <div class="col-md-6">
                                                    <input name="nomineename3" maxlength="40" class="form-control" type="text">
													 <input type="hidden" name="aaiedcpsOption" id="aaiedcpsOption" value="E" >
                                                </div>
                                            </div>
                                        </div>

                                    </div>
                                </div>


                               
                               

                                
                                <div class="row">
                                    <div class="col-md-12"  style="margin-top:10px;">
            <h4 class="form-section" style="text-align:left; font-weight:400 !important;"> 
            &nbsp; <i class="fa fa-cog" aria-hidden="true" style="font-size:23px;"></i>	EMPLOYEE/Beneficiary  BANK INFORMATION </h4>
</div></div>
<div class="row">
                                    <div class="col-md-12">

                                        <div class="col-md-6">
                                            <div class="form-group ">
                                                <label class="control-label col-md-6">
                                                    Name of Employee/ In Case of deceased Employee-Name of Nominee (As per Saving Bank Account) <span class="required">*</span>
                                                    :
                                                </label>
                                                <div class="col-md-6">
                                                    <input name="empname" maxlength="40" class="form-control" type="text">
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-md-6">
                                            <div class="form-group ">
                                                <label class="control-label col-md-6">
                                                  ACCOUNT No <span class="required">*</span> :
                                                </label>
                                                <div class="col-md-6">
                                                    <input name="accountno" maxlength="40" class="form-control" type="text">
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
                                                   Name of Bank <span class="required">*</span>
                                                    :
                                                </label>
                                                <div class="col-md-6">
                                                    <input type="text" name="bankname"  class="form-control" >
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-md-6">
                                            <div class="form-group ">
                                                <label class="control-label col-md-6">
                                                  Branch Code & MICR Code <span class="required">*</span> :
                                                </label>
                                                <div class="col-md-6">
                                                   <input type="text" name="Micrcode"  class="form-control" >
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
                                                  Branch Address <span class="required">*</span>:
                                                </label>
                                                <div class="col-md-6">
												<textarea name="branchaddr"  class="form-control" ></textarea>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-md-6">
                                            <div class="form-group ">
                                                <label class="control-label col-md-6">
                                                 IFSC Code <span class="required"></span> :
                                                </label>
                                                <div class="col-md-6">
                                                    <input name="ifsccode" maxlength="40" class="form-control" type="text">
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
                                                  Cancelled Cheque attached <span class="required"></span>
                                                    :
                                                </label>
                                                <div class="col-md-6">
                                                 <label class="control-label"> <b>Yes</b></label>
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
            &nbsp; <i class="fa fa-cog" aria-hidden="true" style="font-size:23px;"></i>	Beneficiary 2  BANK INFORMATION:-(wherever multiple beneficiary is there iro deceased employee) </h4>
</div></div>
<div class="row">
                                    <div class="col-md-12">

                                        <div class="col-md-6">
                                            <div class="form-group ">
                                                <label class="control-label col-md-6">
                                                    Name of Employee/ In Case of deceased Employee-Name of Nominee (As per Saving Bank Account) <span class="required">*</span>
                                                    :
                                                </label>
                                                <div class="col-md-6">
                                                    <input name="empname1" maxlength="40" class="form-control" type="text">
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-md-6">
                                            <div class="form-group ">
                                                <label class="control-label col-md-6">
                                                  ACCOUNT No <span class="required">*</span> :
                                                </label>
                                                <div class="col-md-6">
                                                    <input name="accountno1" maxlength="40" class="form-control" type="text">
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
                                                   Name of Bank <span class="required">*</span>
                                                    :
                                                </label>
                                                <div class="col-md-6">
                                                    <input type="text" name="bankname1"  class="form-control" >
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-md-6">
                                            <div class="form-group ">
                                                <label class="control-label col-md-6">
                                                  Branch Code & MICR Code <span class="required">*</span> :
                                                </label>
                                                <div class="col-md-6">
                                                   <input type="text" name="Micrcode1"  class="form-control" >
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
                                                  Branch Address <span class="required">*</span>:
                                                </label>
                                                <div class="col-md-6">
												<textarea name="branchaddr1"  class="form-control" ></textarea>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-md-6">
                                            <div class="form-group ">
                                                <label class="control-label col-md-6">
                                                 IFSC Code <span class="required"></span> :
                                                </label>
                                                <div class="col-md-6">
                                                    <input name="ifsccode1" maxlength="40" class="form-control" type="text">
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
                                                  Cancelled Cheque attached <span class="required"></span>
                                                    :
                                                </label>
                                                <div class="col-md-6">
                                                 <label class="control-label"> <b>Yes</b></label>
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
                                            <p style="padding: 20px 80px ">I certify that particulars given above are correct and complete to the best of my knowledge and I am eligible for AAI EDCP Scheme. I also authorize AAI EDCP Trust to e-transfer the funds to my above-mentioned bank A/c. </p>
                                            </div>
                                            </div>                           
											
                               <div style="height:70px;"></div>
                                    <div class="row">
                                        <div class="col-md-12">

                                            <div class="col-md-6">
                                                <div class="form-group ">
                                                    <label class="control-label col-md-6" style="font-weight:600">
                                                       Dated
                                                      
                                                    </label>
                                                    <div class="col-md-6">
                                                       <div class="input-group input-medium date date-picker col-md-12"  data-date-format="dd-M-yyyy" data-date-viewmode="years" data-date-minviewmode="months">
                                                        <input type="text" name="cdate" value="" class="form-control" readonly>
                                                        <span class="input-group-btn">
                                                            <button class="btn default" type="button" style="padding: 4px 14px;"><i class="fa fa-calendar"></i></button>
                                                        </span>
                                                    </div>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-md-6">
                                                <div class="form-group ">
                                                    <label class="control-label col-md-6">
                                                    </label>
                                                    <div class="col-md-6" style="font-weight:600">
                                                       Name and Signature of the Applicant
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
									<div class="row">
                                            <div class="col-md-12">
                                            <p style="padding: 20px 80px ">Approval by Establishment wherein Service Records are maintained: </p>
                                            </div>
                                            </div> 

											<div class="row">
                                            <div class="col-md-12">
                                            <p style="padding: 20px 80px ">Certified that the above particulars have been verified from Service records and is  correct as per the service records. In case of deceased employee the nominee mentioned hereinabove is  duly verified and certified latest nomination details filed by the employee. </p>
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
                                                    
                                                    <div class="col-md-12" style="font-weight:600">
(Name, Designation  & Signature  of HR Nodal Officer )
                                                    </div>
                                                </div>
                                            </div>
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
