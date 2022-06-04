<%@ page language="java" import="java.util.*,aims.bean.LicBean,aims.bean.SBSRejectedRemarksBean" pageEncoding="ISO-8859-1"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
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

function validate(){

if(document.approve.approveStatus.value=="A"){
	if(document.approve.finincrement.value==""){
	alert("Please select the Corpus card");
	document.approve.finincrement.focus();
			return false;	
	}
	if(document.approve.finarrear.value==""){
		alert("Please select the c) Whether any arrear iro period prior to 01.01.2007 was paid to employee during 1.1.2007 to till date?");
		document.approve.finarrear.focus();
				return false;
		}
		if(document.approve.finarrear.value=="Y"){
	if(document.approve.finpreobadj.value==""){
		alert("Please select the OB adjustment");
		document.approve.finpreobadj.focus();
				return false;
		}
		}
	if(document.approve.obotherreason.value==""){
		alert("Please select the reason ");
		document.approve.obotherreason.focus();
				return false;
		}
		if(document.approve.obotherreason.value==""){
	if(document.approve.finobadjcorpuscard.value==""){
		alert("Please select the updated");
		document.approve.finobadjcorpuscard.focus();
				return false;
		}
		}
	if(document.approve.fincorpusverified.value==""){
		alert("Please select the card verified ");
		document.approve.fincorpusverified.focus();
				return false;
		}
		//if(document.approve.tds.value=="" || document.approve.tds.value=="N"){
		//alert("Please First Deduct the Necessary TDS Amount");
		//document.approve.tds.focus();
		//		return false;
		//}


		
	if(document.approve.finincrement.value=="N" || document.approve.fincorpusverified.value=="N"){
		alert("Please first correcting the data in sl. no b and g ");
		document.approve.finincrement.focus();
				return false;
		}
		var EDCPoption='<%=bean.getAaiEDCPSoption()%>';
if(EDCPoption=="E"){
		if(document.approve.totsbscorps2lakhs.value=="N"){
alert("Please Select Total SBS corpus less than Rs. 2 lakhs as Yes ");
document.approve.totsbscorps2lakhs.focus();
return false;
}
}
if(document.approve.remarks.value==""){
alert("Please Enter Authorised Remarks");
document.approve.remarks.focus();
return false;
}
		if(document.approve.finuploaddocuments.value==""){
alert("Please upload documents");
document.approve.finuploaddocuments.focus();
return false;
}
		}else{
if(document.approve.rejectedremarks.value==""){
alert("Please Enter Rejected Remarks ");
document.approve.rejectedremarks.focus();
return false;
}

}

 var appid=document.approve.appid.value;
  var remarks=document.approve.remarks.value;
   var approveStatus=document.approve.approveStatus.value;
   var finincrement=document.approve.finincrement.value;
   
   var finarrear=document.approve.finarrear.value;
   var finpreobadj=document.approve.finpreobadj.value;
   var obotherreason=document.approve.obotherreason.value;
   var finobadjcorpuscard=document.approve.finobadjcorpuscard.value;
   var fincorpusverified=document.approve.fincorpusverified.value;
  
   var tds;
  
    var rejectedremarks=document.approve.rejectedremarks.value;
     var rejectedtype=document.approve.rejectedtype.value;
	 var totsbscorps2lakhs='';
	 if(EDCPoption=="E"){
	  totsbscorps2lakhs=document.approve.totsbscorps2lakhs.value;
	 }
	//alert(document.approve.finincrement.value);
  
  var url="<%=basePath%>SBSAnnuityServlet?method=finApproveUpdate&&ApproveLevel=CHQFinance&&menu=<%=menu%>&&appid="+appid+"&&remarks="+remarks+"&&approveStatus="+approveStatus+"&&finincrement="+finincrement+"&&finarrear="+finarrear+"&&finpreobadj="+finpreobadj+"&&obotherreason="+obotherreason+"&&finobadjcorpuscard="+finobadjcorpuscard+"&&fincorpusverified="+fincorpusverified+"&&tds="+tds+"&&rejectedremarks="+rejectedremarks+"&&rejectedtype="+rejectedtype+"&&totsbscorps2lakhs="+totsbscorps2lakhs;
		//alert(url);
					document.approve.action=url;
					document.approve.method="post";
					document.approve.submit();
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
function getrejectedrow(){
//alert(document.getElementById("approveStatus"));
if(document.getElementById("approveStatus").value=='R'){
$('#dispreject').show();

}else{
$('#dispreject').hide();
}

}

function changeobadj(){

if(document.forms[0].finarrear.value=='Y'){
$('#optionDY').show();
$('#optionDN').hide();
}else{
$('#optionDY').hide();
$('#optionDN').show();

}


}

function changeobreason(){
if(document.forms[0].obotherreason.value=='Y'){
$('#optionFY').show();
$('#optionFN').hide();
}else{
$('#optionFY').hide();
$('#optionFN').show();

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
			
			var url="<%=basePath%>SBSAnnuityServlet?method=annuityReport&&ApproveLevel=HRLevel2&&appid="+appid;
			wind1 = window.open(url,"winComps","toolbar=yes,statusbar=yes,scrollbars=yes,menubar=yes,resizable=yes,width="+swidth+",height="+sheight+",top=0,left=0");
	   	 	winOpened = true;
			wind1.window.focus();
			
		
		
  }
</script>
  </head>

  <body >
  <form name="approve" action="" enctype="multipart/form-data">
  <div class="page-content-wrapper">
		<div class="page-content">
			<div class="row">
			    <div class="col-md-12">
				<h3 class="page-title">Annuity Form Scrutiny[Finance]</h3>
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
                      <div class="col-md-6"> <input name="pfId" maxlength="40" value="<%=bean.getAaiEDCPSoptionDesc() %>" class="form-control" readonly/>
                                                    
                                                </div>
                                            </div>
                                        </div>
                                        </div>
                                        </div>
                            
 <div class="row">
                                    <div class="col-md-12">
                                        <div class="form-group" align="left" style="text-decoration:underline; font-weight:600;">a) Bank details verified from Cancelled Cheque:- </div>
                                    </div>
                                    <div>
                                    </div>
                                </div>
                                        
                                <div class="row">
                                    <div class="col-md-12">

                                        <div class="col-md-6">
                                            <div class="form-group ">
                                                <label class="control-label col-md-6">
                                                  Bank Name<span class="required"></span>
                                                    :
                                                </label>
                      <div class="col-md-6"><input type="text" class="form-control" value='<%=bean.getBankName() %>' name="bankName"   />
                                                    
                                                </div>
                                            </div>
                                        </div>
                            
                                        <div class="col-md-6">
                                            <div class="form-group ">
                                                <label class="control-label col-md-6">
                                                  Bank Branch<span class="required"></span>
                                                    :
                                                </label>
                      <div class="col-md-6"><input type="text" class="form-control" value='<%=bean.getBranch() %>' name="branch"  />
                                                    
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
                                                  IFSC<span class="required"></span>
                                                    :
                                                </label>
                      <div class="col-md-6"><input type="text" class="form-control" value='<%=bean.getIfscCode() %>' name="ifsc"   />
                                                    
                                                </div>
                                            </div>
                                        </div>
                            
                                        <div class="col-md-6">
                                            <div class="form-group ">
                                                <label class="control-label col-md-6">
                                                  Account Type<span class="required"></span>
                                                    :
                                                </label>
                      <div class="col-md-6"><input type="text" class="form-control" value='<%=bean.getAccType() %>' name="acctype"  />
                                                    
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
                                                  Account No<span class="required"></span>
                                                    :
                                                </label>
                      <div class="col-md-6"><input type="text" class="form-control" value='<%=bean.getAccNo() %>' name="accNo"   />
                                                    
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
												b) Whether recovery for  Notional Increment is appearing in Corpus Card correctly?<span class="required">*</span></label>
													
													</div>
													<div class="col-md-3" >
													<input name="finincrement" type="radio"  class="redio" value="Y"> Yes
													<input name="finincrement" type="radio" class="redio"  value="N"> NO
													
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
												c) Whether any arrear iro period prior to 01.01.2007 was paid to employee during 1.1.2007 to till date?<span class="required">*</span></label> 
													
													</div>
													<div class="col-md-3" >
													<input name="finarrear" type="radio"  class="redio" value="Y" onclick="changeobadj()"> Yes
													<input name="finarrear" type="radio" class="redio"  value="N" onclick="changeobadj()"> NO
													
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
												d) If yes then OB adjustment for arrear pertaining to pre 01.01.2007 done in the card?<span class="required"></span></label>
													
													</div>
													<div class="col-md-3" >
													
													<div id="optionDY" style="display:none">
													<input name="finpreobadj" type="radio"  class="redio" value="Y"> Yes
													<input name="finpreobadj" type="radio" class="redio"  value="N"> NO
													</div>
													<div id="optionDN">
													<font color="blue">Not Applicable</font>
													</div>
													<span class="required"></span>
													</div>
													
											</div>
											</div>
									</div>
								</div>
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
												
												<div class="col-md-9">
													<label class="control-label">
												e) OB adjustment for any other reason required?<span class="required">*</span></label>
													
													
													</div>
													<div class="col-md-3" >
													<input name="obotherreason" type="radio"  class="redio" value="Y" onclick="changeobreason()"> Yes
													<input name="obotherreason" type="radio" class="redio"  value="N" onclick="changeobreason()"> NO
													
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
												f) If yes then OB adjustment updated in the Corpus Card?<span class="required">*</span></label>
													
													</div>
													<div class="col-md-3" >
													<div id="optionFY" style="display:none">
													<input name="finobadjcorpuscard" type="radio"  class="redio" value="Y"> Yes
													<input name="finobadjcorpuscard" type="radio" class="redio"  value="N"> NO
													</div>
													<div id="optionFN">
													<font color="blue">Not Applicable</font>
													</div>
													<span class="required"></span>
													</div>
													
											</div>
											</div>
									</div>
								</div> 
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
												
												<div class="col-md-9">
												<label class="control-label">
												g) Corpus card verified and duly signed copy forwarded to RHQ/CHQ/EDCP Trust as the case may be?<span class="required">*</span></label>
													
													</div>
													<div class="col-md-3" >
													<input name="fincorpusverified" type="radio"  class="redio" value="Y"> Yes
													<input name="fincorpusverified" type="radio" class="redio"  value="N"> NO
													
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
												h) Total SBS corpus   less than Rs. 2 lakhs:<span class="required">*</span></label>
													
													</div>
													<div class="col-md-3" >
													<input name="totsbscorps2lakhs" type="radio"  class="redio" value="Y"> Yes
													<input name="totsbscorps2lakhs" type="radio" class="redio"  value="N"> NO
													
													<span class="required"></span>
													</div>
													
											</div>
											</div>
									</div>
								</div>
								<%}%>
								 <div class="row">
                                    <div class="col-md-12">
                                        <div class="form-group " align="center" >  &nbsp; </div>
                                    </div>
                                    <div>
                                    </div>
                                </div>  
									<!--  <div class="row">
									<div class="col-md-12">
										<div class="col-md-12">
											<div class="form-group ">
												
												<div class="col-md-9">
												<label class="control-label">
												i) Necessary  TDS on Corpus Amount has been deducted by AAI? <span class="required">*</span></label>
													
													</div>
													<div class="col-md-3" >
													<input name="tds" type="radio"  class="redio" value="Y"> Yes
													<input name="tds" type="radio" class="redio"  value="N"> NO
													
													<span class="required"></span>
													</div>
													
											</div>
											</div>
									</div>
								</div> -->
								 <div class="row">
                                    <div class="col-md-12">
                                        <div class="form-group " align="center" >  &nbsp; </div>
                                    </div>
                                    <div>
                                    </div>
                                </div>
                                 <div class="row">
                                    <div class="col-md-12">

                                        <div class="col-md-6">
                                            <div class="form-group ">
                                                <label class="control-label col-md-6">
                                                  Authorised Remarks<span class="required">*</span>
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
                                                  Approve<span class="required">*</span>
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
														
													<option value="hr">
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
												Finance	Documents Upload
													<span class="required">*</span> :
												</label>
												<div class="col-md-6">
													<input type="file" class="form-control" name="finuploaddocuments"
														/>
												</div>
											</div>
										</div>
										</div>
										</div>   
                                
            <%
								
							String filename=bean.getAppId()+".pdf"; %>
                                <div class="row">
									<div class="col-md-12">

										<div class="col-md-6">
											<div class="form-group ">
												<label class="control-label col-md-6">
													View/Download Documents
													<span class="required"></span> :
												</label>
												<div class="col-md-6">
													<a href="PensionView/SBS/Download.jsp?filename=<%=filename%>&&doctype=ack"><b>For Download Click Here</b></a>
													
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
