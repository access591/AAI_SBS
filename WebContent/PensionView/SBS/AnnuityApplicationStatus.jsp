<%@ page language="java" import="java.util.*,aims.bean.LicBean" pageEncoding="ISO-8859-1"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<html>
  <head>
  <jsp:include page="/SBSHeader.jsp"></jsp:include>
<jsp:include page="/PensionView/SBS/Menu.jsp"></jsp:include>
    <base href="<%=basePath%>">
    
    
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
<script type="text/javascript">
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

</script>
  </head>
  <% String appId=request.getAttribute("appId")!=null?request.getAttribute("appId").toString():"";
  ArrayList al=request.getAttribute("al")!=null?(ArrayList)request.getAttribute("al"):new ArrayList();
  LicBean bean=null;
   %>
  <body>
    	<div class="page-content-wrapper">
		<div class="page-content">
			<div class="row">
			    <div class="col-md-12">
				<h3 class="page-title">Annuity Application Status </h3>
				<ul class="page-breadcrumb breadcrumb"></ul>
			    </div>
			</div>
		<%  if(al.size()>0){
		
		for(int i=0;i<al.size();i++){
	bean=(LicBean)al.get(i);
		
		 %>
			   <div class="row">
                                    <div class="col-md-12">
 <div class="form-group ">
                                        <div class="col-md-6">
                                           
                                            <div class="col-md-1">
                                            <%=(i+1) %>.
                                            </div>
                                                <label class="control-label col-md-5">App No:
                                                  <b> Annuity/<%=bean.getFormType()%>/<%=bean.getAppId() %></b><span class="required"></span>
                                                    
                                                </label>
                                                </div>
                                                <div class="col-md-6">
                                                <div class="col-md-2">
                                     <label class="control-label col-md-12" style="text-align:left;"><img style="width:40px" alt="download report" src="assets/img/download.jpg" onclick="getReport('<%=bean.getAppId() %>');"></label></div>
                                            
                                            <div class="col-md-4">
                                            App Date:<%=bean.getAppDate() %>
                                            </div>
                                        </div>
                                        </div>
                                    </div>
                                </div>
                               
                                    <table border="1" cellpadding="2px" cellspacing="3px" align="center" width="60%"><tr style="background:#1976d2;color:#ffffff"><th align="center">Approval Level</th><th align="center">Status </th></tr>
                                    <tr><td >HR Acknowledgment</td><td><%=bean.getAckApprove().equals("A")?"Approved":(bean.getAckApprove().equals("R")?"Rejected":"")%> </td></tr>
                                    <tr><td >HR Nodal Officer</td><td><%=bean.getHrNodalApprove().equals("A")?"Approved":(bean.getHrNodalApprove().equals("R")?"Rejected":"")%> </td></tr>
                                    <tr><td >Finance </td><td><%=bean.getFinApprove().equals("A")?"Approved":(bean.getFinApprove().equals("R")?"Rejected":"")%> </td></tr>
                                    <tr><td >RHQ HR</td><td><%=bean.getRhqHrApprove().equals("A")?"Approved":(bean.getRhqHrApprove().equals("R")?"Rejected":"")%> </td></tr>
                                    <tr><td >RHQ Finance</td><td><%=bean.getRhqFinApprove().equals("A")?"Approved":(bean.getRhqFinApprove().equals("R")?"Rejected":"")%> </td></tr>
                                    <tr><td >CHQ HR</td><td><%=bean.getChqHrApprove().equals("A")?"Approved":(bean.getChqHrApprove().equals("R")?"Rejected":"")%> </td></tr>
                                    <tr><td >CHQ Finance</td><td><%=bean.getChqFinApprove().equals("A")?"Approved":(bean.getChqFinApprove().equals("R")?"Rejected":"")%> </td></tr>
                                    <tr><td >EDCP </td><td><%=bean.getEdcpApprove().equals("A")?"Approved":(bean.getEdcpApprove().equals("R")?"Rejected":"")%> </td></tr>
                                    
                                    </table>
                               
                                
                                 <div class="row">
                                    <div class="col-md-12">

                                        <div class="col-md-6">
                                            <div class="form-group ">
                                                <label class="control-label col-md-12">
                                                 
                                                    
                                                </label>
                                       </div>
                                        </div>
                                        
                                    </div>
                                </div>
                               
                          
			<%} }else{%>
			
			 <div class="row">
                                    <div class="col-md-12">

                                        <div class="col-md-6">
                                            <div class="form-group ">
                                                <label class="control-label col-md-12">
                                                  <b>  No Data Found </b><span class="required"></span>
                                                    
                                                </label>
                                       </div>
                                        </div>
                                        
                                    </div>
                                </div>
                                
                                <%} %>
			
			</div>
			</div>
  </body>
</html>
