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


if(document.approve.intcalcdate.value==""){
alert("Please enter the interest date");
document.approve.intcalcdate.focus();
		return false;
}

  
  var url="<%=basePath%>SBSAnnuityServlet?method=edcpApproveUpdate3&&ApproveLevel=edcp&&menu=<%=menu%>";
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
//function getReport(appid){
            //var formType="N";
			//var swidth=screen.Width-10;
			//var sheight=screen.Height-150;
			//var url="<%=basePath%>SBSAnnuityServlet?method=annuityReportDownload&&appid="+appid;
			//alert(url);
			//wind1 = window.open(url,"winComps","toolbar=yes,statusbar=yes,scrollbars=yes,menubar=yes,resizable=yes,width="+swidth+",height="+sheight+",top=0,left=0");
	   	 	//winOpened = true;
			//wind1.window.focus();
//}
function print(appid,status){

				var formType="N";
			var swidth=screen.Width-10;
			var sheight=screen.Height-150;
			
			 if(status!='A'){
  alert("Print will be available after approved only");
  return false;
  }
			
			var url="<%=basePath%>SBSAnnuityServlet?method=annuityReport&&ApproveLevel=chqHr&&appid="+appid;
			wind1 = window.open(url,"winComps","toolbar=yes,statusbar=yes,scrollbars=yes,menubar=yes,resizable=yes,width="+swidth+",height="+sheight+",top=0,left=0");
	   	 	winOpened = true;
			wind1.window.focus();
			
		
		
  }
</script>
  </head>

  <body onload="return load();">
  <form name="approve" action="">
  <div class="page-content-wrapper">
		<div class="page-content">
			<div class="row">
			    <div class="col-md-12">
				<h3 class="page-title">EDCP Approve Form </h3>
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
                                           <a onclick=javascript:print(<%=bean.getAppId() %>,'A')><i class="fa fa-file-text" aria-hidden="true"   style="color:#378fe7;font-size:25px"></i></a>
                                         
                                            </div>
                                            <!--  <div class="col-md-2">
                                            <img style="width:40px" alt="download report" src="assets/img/download.jpg" onclick="getReport('<%=bean.getAppId() %>');">
                                            </div>-->
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
                                                  Amount Admitted by AAI EDCP Trust with Interest upto<span class="required"></span>
                                                    :
                                                </label>
                      <div class="col-md-6">
                                                     <input type="text" name="intcalcdate" value="<%=bean.getIntcalcdate()  %>" class="form-control" readonly>
                                                        
                                                    
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-md-6">
                                            <div class="form-group ">
                                                <label class="control-label col-md-6">
                                                  <span class="required"></span>
                                                  Date of Separation  :
                                                </label>
                      <div class="col-md-6">
                                                   <input type="text" class="form-control" name="dos" value="<%=bean.getDos()%>" />
                                                  
                                                </div>
                                            </div>
                                        </div>
                                        
                                        </div>
                                        </div> 
                                        <%if(!bean.getAaiEDCPSoption().equals("E")){%>    
                                        <div class="row">
									<div class="col-md-12">
										<div class="col-md-12">
											<div class="form-group ">
												
												<div class="col-md-9">
													<label class="control-label">
												a) Bank details verified and other conditions verified by HR?	
													</div>
													<div class="col-md-3" >
													<input name="hrVeri" type="radio" checked class="redio" value="Y" > Yes
													<input name="hrVeri" type="radio" class="redio"  value="N" > NO
													
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
												b) Cash Section has confirmed regarding recovery of TDS if any?
													</div>
													<div class="col-md-3" >
													<select name="tdsrec" class="form-control">
                                                        <option value="N" <%=bean.getTdsrec().equals("N")?"selected='selected'":"" %>>No </option>
                                                        <option value="Y" <%=bean.getTdsrec().equals("Y")?"selected='selected'":"" %>>Yes </option>
                                                 
                                                    </select>
													<span class="required"></span>
													</div>
													
											</div>
											</div>
									</div>
								</div> 
								<%}%>
								
								       <div class="row">
                                    <div class="col-md-12">

                                        <div class="col-md-6">
                                            <div class="form-group ">
                                                <label class="control-label col-md-6">
                                                  Corpus amount as on <%=bean.getIntcalcdate() %><span class="required"></span>
                                                    :
                                                </label>
                      <div class="col-md-6">
                                                   <input type="text" class="form-control" name="corpusamt" value="<%=bean.getEdcpCorpusAmt() %>"  readonly/>
                                                  
                                                </div>
                                            </div>
                                        </div>
                                    

                                        <div class="col-md-6">
                                            <div class="form-group ">
                                                <label class="control-label col-md-6">
                                                 interest  amount <span class="required"></span>
                                                    :
                                                </label>
                      <div class="col-md-6">
                                                   <input type="text" class="form-control" name="corpusint" value="<%=bean.getEdcpCorpusint() %>"  readonly/>
                                                  
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
                                                   <select name="approveStatus" class="form-control">
                                                        <option value="A">Accept </option>
                                                        <option value="R">Reject </option>
                                                 
                                                    </select>
                                                </div>
                                            </div>
                                        </div>
                                        
                                    </div>
                                </div>
                                
                                
                                   <!--  <div class="row">
									<div class="col-md-12">
									
										<div class="col-md-6">
											<div class="form-group ">
												 <label class="control-label col-md-6">
                                                 <span class="required"></span>
                                                    
                                                </label>
                                                                         
                      <div class="col-md-6">
                                                 <b> Form Verified </b>
													<input name="edcpVerified" type="checkbox" >
                                                  
                                                </div>
												
											</div>
											</div>
											<div class="col-md-6">
                                            <div class="form-group ">
                                                <label class="control-label col-md-6">
                                                  Corpus Taken Till Last Month<span class="required"></span>
                                                    :
                                                </label>
                      <div class="col-md-6">
                                                   <input type="text" class="form-control" name="corpusamount"  />
                                                 
                                                </div>
                                            </div>
                                        </div>
									</div>
								</div>-->
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
                                
                                	<div class="">
												<div class="col-md-12" style="text-align:center">
												
													<button type="button" class="btn green" onclick="return validate()">Save</button>
													<button type="button" class="btn default">Cancel</button>
												</div>
											</div>
                                
                                </fieldset>
                                </div>
                                </div>
  
  
  </form>
  </body>
</html>
