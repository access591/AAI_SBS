<%@ page language="java" import="java.util.*,aims.bean.LicBean,aims.bean.SBSRejectedRemarksBean" pageEncoding="ISO-8859-1"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
String corpusamt=request.getAttribute("corpusamt")!=null?request.getAttribute("corpusamt").toString():"0";
String corpusintamt=request.getAttribute("corpusintamt")!=null?request.getAttribute("corpusintamt").toString():"0";
String intDate=request.getAttribute("intDate")!=null?request.getAttribute("intDate").toString():"";
System.out.println("corpusamt"+corpusamt);
String purchaseAmount=String.valueOf(Double.parseDouble(corpusamt)+Double.parseDouble(corpusintamt));
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
if(document.approve.purchaseamt.value==""){
alert("Please Enter the Purchase Amount");
document.approve.purchaseamt.focus();
		return false;
}
if(document.approve.intcalcdate.value==""){
alert("Please Enter the interest upto month");
document.approve.intcalcdate.focus();
		return false;
}
if(!this.approve.rhqHrVerified.checked){
alert("Please select the Form verification");
document.approve.rhqHrVerified.focus();
		return false;
}
if(document.approve.approveStatus.value=="R"){
if(document.approve.rejectedremarks.value==""){
alert("Please Enter Rejected Remarks ");
document.approve.rejectedremarks.focus();
return false;
}

}
  
  var url="<%=basePath%>SBSAnnuityServlet?method=rhqApproveUpdate&&ApproveLevel=rhqHr&&menu=<%=menu%>";
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
function print(appid,status){

				var formType="N";
			var swidth=screen.Width-10;
			var sheight=screen.Height-150;
			
			 if(status!='A'){
  alert("Print will be available after approved only");
  return false;
  }
			
			var url="<%=basePath%>SBSAnnuityServlet?method=annuityReport&&ApproveLevel=Finance&&appid="+appid;
			wind1 = window.open(url,"winComps","toolbar=yes,statusbar=yes,scrollbars=yes,menubar=yes,resizable=yes,width="+swidth+",height="+sheight+",top=0,left=0");
	   	 	winOpened = true;
			wind1.window.focus();
			
		
		
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
				<h3 class="page-title">RHQ HR Regional Committee </h3>
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
                                                 Purchase Amount<span class="required">*</span>
                                                    :
                                                </label>
                      <div class="col-md-6">
                                                   <input type="text" class="form-control" value='<%=purchaseAmount %>' name="purchaseamt"  />
                                                 
                                                </div>
                                            </div>
                                        </div>
                                
                                        <div class="col-md-6">
                                            <div class="form-group ">
                                                <label class="control-label col-md-6">
                                                  Interest upto Month<span class="required">*</span>
                                                    :
                                                </label>
                      <div class="col-md-6">
                                                   <div class="input-group input-medium date date-picker col-md-12"  data-date-format="dd-M-yyyy" data-date-viewmode="years" data-date-minviewmode="months">
                                                        <input type="text" value='<%=intDate %>' name="intcalcdate" class="form-control"  readonly>
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
                                                   <select name="approveStatus" id="approveStatus" onchange="getrejectedrow()"  class="form-control">
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
									<div class="col-md-3">
									</div>
										<div class="col-md-9">
											<div class="form-group ">
												
												<div class="col-md-9">
												<b> Form Verified </b>
													<input name="rhqHrVerified" type="checkbox" >
													
													<span class="required"></span>
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
													Download Personal Documents
													<span class="required"></span> :
												</label>
												<div class="col-md-6">
													<a href="PensionView/SBS/Download.jsp?filename=<%=filename%>&&doctype=ack"><b>For Download Click Here</b></a>
													
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
													Download Finance Documents
													<span class="required"></span> :
												</label>
												<div class="col-md-6">
													<a href="PensionView/SBS/Download.jsp?filename=<%=filename%>&&doctype=fin"><b>For Download Click Here</b></a>
													
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
