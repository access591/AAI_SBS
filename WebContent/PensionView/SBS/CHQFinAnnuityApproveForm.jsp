<%@ page language="java" import="java.util.*,aims.bean.LicBean" pageEncoding="ISO-8859-1"%>
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
<script type="text/javascript">
function validate(){

if(!this.approve.chqFinVerified.checked){
alert("Please select the Form verification");
document.approve.chqFinVerified.focus();
		return false;
}
if(document.approve.approveStatus.value=="R"){
if(document.approve.rejectedremarks.value==""){
alert("Please Enter Rejected Remarks ");
document.approve.rejectedremarks.focus();
return false;
}

}  
  var url="<%=basePath%>SBSAnnuityServlet?method=chqFinApproveUpdate&&ApproveLevel=chqFin&&menu=<%=menu%>";
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
		}

if(option=='C' || option=='D' ){
		$('#optionCD').show();
		$('#optionAB').hide();
		}

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
</script>
  </head>

  <body onload="return load();">
  <form name="approve" action="">
  <div class="page-content-wrapper">
		<div class="page-content">
			<div class="row">
			    <div class="col-md-12">
				<h3 class="page-title">Annuity Approve Form [CHQ Finance Level]</h3>
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
                                            </div>
                                            <div class="col-md-2">
                                            <img style="width:40px" alt="download report" src="assets/img/download.jpg" onclick="getReport('<%=bean.getAppId() %>');">
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
                                                   Employee No <span class="required"></span>
                                                    :
                                                </label>
                      <div class="col-md-6"> <input name="pfId" maxlength="40" value="<%=bean.getEmployeeNo() %>" class="form-control" readonly/>
                                                    
                                                </div>
                                            </div>
                                        </div>
                            
                                        <div class="col-md-6">
                                            <div class="form-group ">
                                                <label class="control-label col-md-6">
                                                  AAI EDCP Option <span class="required"></span>
                                                    :
                                                </label>
                      <div class="col-md-6">
                                                    <input name="Option"  id="Option" class="form-control" value="<%=bean.getAaiEDCPSoptionDesc() %>" type="text" readonly>
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
															Rejected and Send to Employee
														</option>
													<option value="hr">
															Rejected and Send to HR
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
									<div class="col-md-3">
									</div>
										<div class="col-md-9">
											<div class="form-group ">
												
												<div class="col-md-9">
												<b> Form Verified </b>
													<input name="chqFinVerified" type="checkbox" >
													
													<span class="required"></span>
													</div>
											</div>
											</div>
									</div>
								</div>
                                
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
