<%@ page language="java" import="java.util.*,aims.bean.LicBean,aims.bean.SBSRejectedRemarksBean"
	pageEncoding="ISO-8859-1"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
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
		<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
		<%
			String menu = request.getParameter("menu") != null ? request
					.getParameter("menu") : "";
		%>
		
	<%
		 
		LicBean bean = null;

		bean = request.getAttribute("licBean") != null ? (LicBean) request
				.getAttribute("licBean") : new LicBean();
				

	%>	
		
		<script type="text/javascript">
function validate(){

var option='<%=bean.getAaiEDCPSoption()%>';
if(document.getElementById("approveStatus").value=='R'){
if(document.approve.rejectedremarks.value==""){
alert("Please Enter the Rejected Remarks");
document.approve.rejectedremarks.focus();
		return false;
}

}
if(option=='A' || option=='B' ){
if(!this.approve.claimform.checked){
alert("Please select the Claim form");
document.approve.claimform.focus();
		return false;
}
if(!this.approve.identitycard.checked){
alert("Please select the identitycard");
document.approve.identitycard.focus();
		return false;
}
if(!this.approve.payslip.checked){
alert("Please select the payslip");
document.approve.payslip.focus();
		return false;
}
if(!this.approve.pancard.checked){
alert("Please select the pancard");
document.approve.pancard.focus();
		return false;
}
if(!this.approve.adharcard.checked){
alert("Please select the adharcard");
document.approve.adharcard.focus();
		return false;
}
if(!this.approve.cancelcheque.checked){
alert("Please select the cancelcheque");
document.approve.cancelcheque.focus();
		return false;
}
if(!this.approve.photograph.checked){
alert("Please select the photograph");
document.approve.photograph.focus();
		return false;
}
}
if(option=='C' || option=='D' ){
if(!this.approve.claimform1.checked){
alert("Please select the Claim form");
document.approve.claimform11.focus();
return false;
}
if(!this.approve.identitycard1.checked){
alert("Please select the identitycard");
document.approve.identitycard1.focus();
return false;
}
if(!this.approve.payslip1.checked){
alert("Please select the payslip");
document.approve.payslip1.focus();
return false;
}
if(!this.approve.pancard1.checked){
alert("Please select the pancard");
document.approve.pancard1.focus();
		return false;
}
if(!this.approve.adharcard1.checked){
alert("Please select the adharcard");
document.approve.adharcard1.focus();
		return false;
}
if(!this.approve.cancelcheque1.checked){
alert("Please select the cancelcheque");
document.approve.cancelcheque1.focus();
		return false;
}
if(!this.approve.photograph1.checked){
alert("Please select the photograph");
document.approve.photograph1.focus();
		return false;
}
}
if(option=='E'){
	
if(!this.approve.claimform3.checked){
alert("Please select the One Set of Claim form (in original) ");
document.approve.claimform3.focus();
return false;
}

if(!this.approve.identitycard3.checked){
alert("Please select the Self-Attested Copy of AAI Identity Card ");
document.approve.identitycard3.focus();
return false;
}

if(!this.approve.payslip3.checked){
alert("Please select Self-Attested Copy of Last Pay Slip ");
document.approve.payslip3.focus();
return false;
}

if(!this.approve.cancelcheque3.checked){
alert("Please select Cancelled Cheque (Printed name of the Annuitant) ");
document.approve.cancelcheque3.focus();
return false;
}

 

if(this.approve.deceasedemp.value=='Y'){
if(!this.approve.nomindoc.checked){
alert("Please select the For deceased employee case-Nomination Documents");
document.approve.nomindoc.focus();
return false;
}

if(!this.approve.nominproof.checked){
alert("Please select the If yes,ID Proof of Nominee ");
document.approve.nominproof.focus();
return false;
}
}
}
//if(document.approve.uploaddocuments.value==""){
//alert("Please upload documents");
//document.approve.uploaddocuments.focus();
//return false;
//}
 var appid=document.approve.appid.value;
 var remarks=document.approve.remarks.value;
 var approveStatus=document.approve.approveStatus.value;
 var rejectedremarks=document.approve.rejectedremarks.value;
 var rejectedtype=document.approve.rejectedtype.value;
 var deceasedemployee=document.forms[0].deceasedemployee.value;
 var nominationdoc=document.forms[0].nominationdoc.value;
 var nomineeproof=document.forms[0].nomineeproof.value;
  var url="<%=basePath%>SBSAnnuityServlet?method=Approve1&&ApproveLevel=CHQHRLevel2&&menu=<%=menu%>&&appid="+appid+"&&remarks="+remarks+"&&approveStatus="+approveStatus+"&&rejectedremarks="+rejectedremarks+"&&rejectedtype="+rejectedtype+"&&deceasedemployee="+deceasedemployee+"&&nominationdoc="+nominationdoc+"&&nomineeproof="+nomineeproof;
		//alert(url);
document.approve.action=url;
document.approve.method="post";
document.approve.submit();
}

function load(){
var option='<%=bean.getAaiEDCPSoption()%>';
//alert(option);
$('#optionAB').hide();
$('#optionCD').hide();

if(option=='A' || option=='B' ){
		$('#optionAB').show();
		$('#optionCD').hide();
		$('#optionE').hide();
		}

if(option=='C' || option=='D' ){
		$('#optionCD').show();
		$('#optionAB').hide();
		$('#optionE').hide();
		}
if(option=='E'  ){
        $('#optionAB').hide();
		$('#optionCD').hide();
		$('#optionE').show();
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
function changeobreason(){
alert("document.forms[0].deceasedemp.value==="+document.forms[0].deceasedemp.value);
if(document.forms[0].deceasedemp.value=='Y'){
$('#optionFY').show();
$('#optionGY').show();
$('#optionFN').hide();
$('#optionGN').hide();
document.forms[0].deceasedemployee.value='on';
document.forms[0].nominationdoc.value='on';
document.forms[0].nomineeproof.value='on';
}else{
$('#optionFY').hide();
$('#optionFN').show();
$('#optionGY').hide();
$('#optionGN').show();
document.forms[0].deceasedemployee.value='';
document.forms[0].nominationdoc.value='';
document.forms[0].nomineeproof.value='';
}

}

</script>
	</head>
	
	<body onload="return load();">
		<form name="approve" enctype="multipart/form-data" action="">
			<div class="page-content-wrapper">
				<div class="page-content">
					<div class="row">
						<div class="col-md-12">
							<h3 class="page-title">
								Annuity Document Receipt Ack(Pending Scrutiny)
							</h3>
							<ul class="page-breadcrumb breadcrumb"></ul>
						</div>
					</div>
					<fieldset>
					<div class="row">
					<div class="col-md-12 form-section">
					<div class="col-md-3" >
						
					</div>
					<div class="col-md-9">
					<span style="font-size:14px; font-weight:550; color:#1f56a2; text-align:center!important;"><img src="<%=basePath%>PensionView/images/logoani.gif" width="75" height="48" /> AIRPORTS AUTHORITY OF INDIA</span>
					</div>
					</div>
					
					</div>
					
				
					
						<div class="row">
							<div class="col-md-12">

								<div class="col-md-6">
									<div class="form-group ">
										<label class="control-label col-md-6">
											Application No
											<span class="required"></span> :
										</label>
										<div class="col-md-6">
											<input name="appId" maxlength="40" class="form-control"
												type="text"
												value="Annuity/<%=bean.getFormType()%>/<%=bean.getAppId()%>"
												readonly />
										</div>
									</div>
								</div>



								<div class="col-md-6">
									<div class="form-group ">
										<label class="control-label col-md-6">
											Name Of Member/Beneficiary
											<span class="required"></span> :
										</label>
										<div class="col-md-6">
											<input name="memberName" maxlength="40" class="form-control"
												type="text" value="<%=bean.getMemberName()%>" readonly>

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
											Employee Number(PF ID)
											<span class="required"></span> :
										</label>
										<div class="col-md-6">
											<input name="pfId" maxlength="40"
												value="<%=bean.getEmployeeNo()%>" class="form-control" readonly/>

										</div>
									</div>
								</div>
<div class="col-md-6">
									<div class="form-group ">
										<label class="control-label col-md-6">
											AAI EDCP Option
											<span class="required"></span> :
										</label>
										<div class="col-md-6">
											<input name="Option" id="Option" class="form-control"
												value="<%=bean.getAaiEDCPSoptionDesc()%>" type="text" readonly>
										</div>
									</div>
								</div>
								</div>
								</div>
								<div class="row">
							<div class="col-md-12">

								<div class="col-md-6">
									<div class="form-group">
										<label class="control-label col-md-6">
											Airport
											<span class="required"></span> :
										</label>
										<div class="col-md-6">
											<input name="airport" type="text"
												value="<%=bean.getAirport() %>" class="form-control" readonly>

										</div>
									</div>
								</div>
								</div></div>

								<!--  <div class="col-md-6">
									<div class="form-group ">
										<label class="control-label col-md-6">
											Spouse Name
											<span class="required"></span> :
										</label>
										<div class="col-md-6">
											<input name="spouseName" type="text"
												value="<%=bean.getSpouseName()%>" class="form-control">

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
											Spouse Address
											<span class="required"></span> :
										</label>
										<div class="col-md-6">
											<input name="spouseAdd" type="text"
												value="<%=bean.getSpouseAdd()%>" class="form-control">

										</div>
									</div>
								</div>



								<div class="col-md-6">
									<div class="form-group ">
										<label class="control-label col-md-6">
											Spouse Date of Birth
											<span class="required"></span> :
										</label>
										<div class="col-md-6">
											<div
												class="input-group input-medium date date-picker col-md-12"
												data-date-format="dd-M-yyyy" data-date-viewmode="years"
												data-date-minviewmode="months">
												<input type="text" class="form-control" name="spouseDob"
													value="<%=bean.getSpouseDob()%>" readonly>
												<span class="input-group-btn">
													<button class="btn default" type="button"
														style="padding: 4px 14px;">
														<i class="fa fa-calendar"></i>
													</button> </span>
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
											Relationship
											<span class="required"></span> :
										</label>
										<div class="col-md-6">
											<select name="spouseType" class="form-control">
												<option value="">
													Select
												</option>
												<option value="husband"
													<%=bean.getSpouseRelation().equals("husband")
					? "selected='selected'"
					: ""%>>
													Husband
												</option>
												<option value="wife"
													<%=bean.getSpouseRelation().equals("wife")
					? "selected='selected'"
					: ""%>>
													Wife
												</option>
											</select>
										</div>
									</div>
								</div>



								<div class="col-md-6">
									<div class="form-group ">
										<label class="control-label col-md-6">
											Residential Address
											<span class="required"></span> :
										</label>
										<div class="col-md-6">
											<input name="address" value="<%=bean.getMemberAddress()%>"
												class="form-control" />
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
											Mode of Annuity Payment
											<span class="required"></span> :
										</label>
										<div class="col-md-6">
											<select name="apaymentMode" class="form-control">
												<option value="">
													Select
												</option>
												<option value="monthly"
													<%=(bean.getPaymentMode().equals("monthly"))
					? "selected='selected'"
					: ""%>>
													Monthly
												</option>
												<option value="qly"
													<%=(bean.getPaymentMode().equals("qly"))
					? "selected='selected'"
					: ""%>>
													QLY
												</option>
												<option value="hly"
													<%=(bean.getPaymentMode().equals("hly"))
					? "selected='selected'"
					: ""%>>
													HLY
												</option>
												<option value="yearly"
													<%=(bean.getPaymentMode().equals("yearly"))
					? "selected='selected'"
					: ""%>>
													Yearly
												</option>
											</select>

										</div>
									</div>
								</div>



								<div class="col-md-6">
									<div class="form-group ">
										<label class="control-label col-md-6">
											AAI EDCP Option
											<span class="required"></span> :
										</label>
										<div class="col-md-6">
											<input name="Option" id="Option" class="form-control"
												value="<%=bean.getAaiEDCPSoption()%>" type="text">
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
											Permanent Residential Address
											<span class="required"></span> :
										</label>
										<div class="col-md-6">
											<input name="paddress" value="<%=bean.getMemberPerAdd()%>"
												class="form-control" />

										</div>
									</div>
								</div>



								<div class="col-md-6">
									<div class="form-group ">
										<label class="control-label col-md-6">
											Nominee Name
											<span class="required"></span> :
										</label>
										<div class="col-md-6">
											<input name="nominee" type="text" class="form-control"
												value='<%=bean.getNomineeName()%>' />
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
											Relationship with Member/Beneficiary
											<span class="required"></span> :
										</label>
										<div class="col-md-6">
											<input name="relation" type="text" class="form-control"
												value='<%=bean.getRelationtoMember()%>' />
										</div>
									</div>

								</div>
								<div class="col-md-6">
									<div class="form-group ">
										<label class="control-label col-md-6">
											Nominee Date of Birth
											<span class="required"></span> :
										</label>
										<div class="col-md-6">
											<div
												class="input-group input-medium date date-picker col-md-12"
												data-date-format="dd-M-yyyy" data-date-viewmode="years"
												data-date-minviewmode="months">
												<input type="text" class="form-control" name="nomineeDob"
													value='<%=bean.getNomineeDob()%>' readonly>
												<span class="input-group-btn">
													<button class="btn default" type="button"
														style="padding: 4px 14px;">
														<i class="fa fa-calendar"></i>
													</button> </span>

											</div>
										</div>
									</div>

								</div>
								<div class="row">
									<div class="col-md-12">

										<div class="col-md-6">
											<div class="form-group ">
												<label class="control-label col-md-6">
													PAN NO
													<span class="required"></span> :
												</label>
												<div class="col-md-6">
													<input type="text" class="form-control" name="pan"
														value='<%=bean.getPanNo()%>' />
												</div>
											</div>
										</div>



										<div class="col-md-6">
											<div class="form-group ">
												<label class="control-label col-md-6">
													Adhar NO
													<span class="required"></span> :
												</label>
												<div class="col-md-6">
													<input type="text" class="form-control" name="adhar"
														value='<%=bean.getAdharno()%>' />
												</div>
											</div>
										</div>

									</div>
								</div>-->
								<div class="row">
									<div class="col-md-12">

										<div class="col-md-6">
											<div class="form-group ">
												<label class="control-label col-md-6">
													Mobile NO
													<span class="required"></span> :
												</label>
												<div class="col-md-6">
													<input type="text" class="form-control" name="phoneNo"
														value='<%=bean.getMobilNo()%>' readonly/>
												</div>
											</div>
										</div>

										<div class="col-md-6">
											<div class="form-group ">
												<label class="control-label col-md-6">
													Email Id
													<span class="required"></span> :
												</label>
												<div class="col-md-6">
													<input type="text" class="form-control" name="email"
														value='<%=bean.getEmail()%>' readonly/>
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
													Authorised Remarks
													<span class="required"></span> :
												</label>
												<div class="col-md-6">
													<input type="text" class="form-control" name="remarks" />
													<input type="hidden" name="appid"
														value="<%=bean.getAppId()%>" />
												</div>
											</div>
										</div>

										<div class="col-md-6">
											<div class="form-group ">
												<label class="control-label col-md-6">
													Approve
													<span class="required"></span> :
												</label>
												<div class="col-md-6">
													<select name="approveStatus" id="approveStatus" onchange="getrejectedrow()" class="form-control">
														<option value="A">
															Accept
														</option>
														<option value="R">
															Reject
														</option>

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
															Rejected and Send to Employee
														</option>
													

													</select>
												</div>
											</div>
										</div>

									</div>
								</div>
								</div>
								
								<div id="optionAB">
								<div class="row">
									<div class="col-md-12">
									<div class="col-md-12">
											<div class="form-group ">
												<div class="col-md-3"></div>
												<div class="col-md-9">
													<input name="claimform" type="checkbox" value="on" >
													<label class="control-label"> One Set of Claim form (in original)
													<span class="required">*</span></label>
													</div>
											</div>
											</div>
									</div>
								</div>
								<div class="row">
									<div class="col-md-12">
										<div class="col-md-12">
											<div class="form-group ">
												<div class="col-md-3"></div>
												<div class="col-md-9">
													<input name="identitycard" type="checkbox" value="on">
													<label class="control-label">Self-Attested Copy of AAI Identity Card
													<span class="required">*</span></label>
													</div>
											</div>
											</div>
									</div>
								</div>
								<div class="row">
									<div class="col-md-12">
										<div class="col-md-12">
											<div class="form-group ">
												<div class="col-md-3"></div>
												<div class="col-md-9">
													<input name="payslip" type="checkbox" value="on">
													<label class="control-label">Self-Attested Copy of Last Pay Slip
													<span class="required">*</span></label>
													</div>
											</div>
											</div>
									</div>
								</div>
								<div class="row">
									<div class="col-md-12">
										<div class="col-md-12">
											<div class="form-group ">
												<div class="col-md-3"></div>
												<div class="col-md-9">
													<input name="pancard" type="checkbox" value="on">
													<label class="control-label">Self-Attested copy of PAN card of primary Annuitant
													<span class="required">*</span></label>
													</div>
											</div>
											</div>
									</div>
								</div>
								<div class="row">
									<div class="col-md-12">
										<div class="col-md-12">
											<div class="form-group ">
												<div class="col-md-3"></div>
												<div class="col-md-9">
													<input name="adharcard" type="checkbox" value="on">
													<label class="control-label">Self-Attested copy of Aadhar card of primary Annuitant
													<span class="required">*</span></label>
													</div>
											</div>
											</div>
									</div>
								</div>
								<div class="row">
									<div class="col-md-12">
										<div class="col-md-12">
											<div class="form-group ">
												<div class="col-md-3"></div>
												<div class="col-md-9">
													<input name="cancelcheque" type="checkbox" value="on">
													<label class="control-label">Cancelled Cheque (Printed name of the Annuitant)
													<span class="required">*</span></label>
													</div>
											</div>
											</div>
									</div>
								</div>
								<div class="row">
									<div class="col-md-12">
										<div class="col-md-12">
											<div class="form-group ">
												<div class="col-md-3"></div>
												<div class="col-md-9">
													<input name="photograph" type="checkbox" value="on">
													<label class="control-label">Photograph of primary Annuitant
													<span class="required">*</span></label>
													</div>
											</div>
											</div>
									</div>
								</div>
</div>
<div id="optionCD">
								<div class="row">
									<div class="col-md-12">
									<div class="col-md-12">
											<div class="form-group ">
												<div class="col-md-3"></div>
												<div class="col-md-9">
													<input name="claimform1" type="checkbox" >
													<label class="control-label">One Set of Claim form (in original)
													<span class="required">*</span></label>
													</div>
											</div>
											</div>
									</div>
								</div>
								<div class="row">
									<div class="col-md-12">
										<div class="col-md-12">
											<div class="form-group ">
												<div class="col-md-3"></div>
												<div class="col-md-9">
													<input name="identitycard1" type="checkbox" >
														<label class="control-label">Self-Attested Copy of AAI Identity Card
													<span class="required">*</span></label>
													</div>
											</div>
											</div>
									</div>
								</div>
								<div class="row">
									<div class="col-md-12">
										<div class="col-md-12">
											<div class="form-group ">
												<div class="col-md-3"></div>
												<div class="col-md-9">
													<input name="payslip1" type="checkbox" >
												<label class="control-label">	Self-Attested Copy of Last Pay Slip
													<span class="required">*</span></label>
													</div>
											</div>
											</div>
									</div>
								</div>
								<div class="row">
									<div class="col-md-12">
										<div class="col-md-12">
											<div class="form-group ">
												<div class="col-md-3"></div>
												<div class="col-md-9">
													<input name="pancard1" type="checkbox" >
													<label class="control-label">Self-Attested copy of PAN card of primary Annuitant and secondary Annuitant
													<span class="required">*</span></label>
													</div>
											</div>
											</div>
									</div>
								</div>
								<div class="row">
									<div class="col-md-12">
										<div class="col-md-12">
											<div class="form-group ">
												<div class="col-md-3"></div>
												<div class="col-md-9">
													<input name="adharcard1" type="checkbox" >
													<label class="control-label">Self-Attested copy of Aadhar card of primary Annuitant and secondary Annuitant
													<span class="required">*</span></label>
													</div>
											</div>
											</div>
									</div>
								</div>
								<div class="row">
									<div class="col-md-12">
										<div class="col-md-12">
											<div class="form-group ">
												<div class="col-md-3"></div>
												<div class="col-md-9">
													<input name="cancelcheque1" type="checkbox" >
													<label class="control-label">Cancelled Cheque (Printed name of the Annuitant)
													<span class="required">*</span></label>
													</div>
											</div>
											</div>
									</div>
								</div>
								<div class="row">
									<div class="col-md-12">
										<div class="col-md-12">
											<div class="form-group ">
												<div class="col-md-3"></div>
												<div class="col-md-9">
													<input name="photograph1" type="checkbox" >
													<label class="control-label">Photograph of primary Annuitant and secondary Annuitant
													<span class="required">*</span></label>
													</div>
											</div>
											</div>
									</div>
								</div>
								
</div>
<div id="optionE">
								<div class="row">
									<div class="col-md-12">
									<div class="col-md-12">
											<div class="form-group ">
												<div class="col-md-3"></div>
												<div class="col-md-9">
													<input name="claimform3" type="checkbox" value="on" >
													<label class="control-label"> One Set of Claim form (in original)
													<span class="required">*</span></label>
													</div>
											</div>
											</div>
									</div>
								</div>
								<div class="row">
									<div class="col-md-12">
										<div class="col-md-12">
											<div class="form-group ">
												<div class="col-md-3"></div>
												<div class="col-md-9">
													<input name="identitycard3" type="checkbox" value="on">
													<label class="control-label">Self-Attested Copy of AAI Identity Card
													<span class="required">*</span></label>
													</div>
											</div>
											</div>
									</div>
								</div>
								<div class="row">
									<div class="col-md-12">
										<div class="col-md-12">
											<div class="form-group ">
												<div class="col-md-3"></div>
												<div class="col-md-9">
													<input name="payslip3" type="checkbox" value="on">
													<label class="control-label">Self-Attested Copy of Last Pay Slip
													<span class="required">*</span></label>
													</div>
											</div>
											</div>
									</div>
								</div>
								<div class="row">
									<div class="col-md-12">
										<div class="col-md-12">
											<div class="form-group ">
												<div class="col-md-3"></div>
												<div class="col-md-9">
													<input name="cancelcheque3" type="checkbox" value="on">
													<label class="control-label">Cancelled Cheque (Printed name of the Annuitant)
													<span class="required">*</span></label>
													</div>
											</div>
											</div>
									</div>
								</div>
								<div class="row">
									<div class="col-md-12">
										<div class="col-md-12">
											<div class="form-group ">
												<div class="col-md-3"></div>
												<div class="col-md-9">
													
													<label class="control-label">In case of deceased employee, death certificate of employee : <span class="required"></span>
													<input name="deceasedemp" type="radio"  class="redio" value="Y" onclick="changeobreason()"  > Yes
													<input name="deceasedemp" type="radio" class="redio"  value="N" onclick="changeobreason()"  checked> NO
													
													
													</div>
											</div>
											</div>
									</div>
								</div>
								<div class="row">
									<div class="col-md-12">
										<div class="col-md-12">
											<div class="form-group ">
												<div class="col-md-3"></div>
												<div class="col-md-9">
													<div id="optionFY" style="display:none">
													<input name="nomindoc" id="nomindoc" type="checkbox" value="on" checked>
													<label class="control-label">For deceased employee case-Nomination Documents <span class="required">*</span></label>
													</div>
													<div id="optionFN">
													<label class="control-label">For deceased employee case-Nomination Documents <span class="required">*</span></label>
													<font color="blue">Not Applicable</font>
													</div>
													
													</div>
											</div>
											</div>
									</div>
								</div>
								
								<div class="row">
									<div class="col-md-12">
										<div class="col-md-12">
											<div class="form-group ">
												<div class="col-md-3"></div>
												<div class="col-md-9">
												<div id="optionGY" style="display:none">
													<input name="nominproof" id="nominproof" type="checkbox" value="on" checked>
													<label class="control-label">If yes,ID Proof of Nominee  <span class="required">*</span></label>
													</div>
													<div id="optionGN">
													<label class="control-label">If yes,ID Proof of Nominee  <span class="required">*</span></label>
													<font color="blue">Not Applicable</font>
													</div>
													
													</div>
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
									<div class="col-md-12" style="text-align: center">

										<button type="button" class="btn green"
											onclick="return validate()">
											Save
										</button>
										<button type="button" class="btn default" onclick="history.back(-1)">
											Cancel
										</button>
										<input type="hidden" name="deceasedemployee" id="deceasedemployee">
										<input type="hidden" name="nominationdoc" id="nominationdoc">
										<input type="hidden" name="nomineeproof" id="nomineeproof">
									</div>
								</div>
					</fieldset>

				</div>
			</div>

		</form>
	</body>
</html>
