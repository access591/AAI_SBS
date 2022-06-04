
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
<head>
<script src="<%=basePath%>assets/plugins/jquery-1.10.2.min.js" type="text/javascript">
<script src="../../assets/plugins/data-tables/jquery.dataTables.js"></script>
<script src="../../assets/plugins/data-tables/jquery.dataTables.min.js"></script>

 <link href="../../assets/plugins/data-tables/DT_bootstrap.css"></link>
  <%
 
 ArrayList list=(ArrayList)request.getAttribute("list");
 System.out.println(list);
 //String ss="[[ 'Tiger Nixon', 'System Architect', 'Edinburgh', '5421', '2011/04/25', '$320,800' ],[ 'Tiger Nixon', 'System Architect', 'Edinburgh', '5421', '2011/04/25', '$320,800' ]]";
   
   String ss=list.toString();
   String menu=request.getParameter("menu")!=null?request.getParameter("menu"):"";
   %>
   
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
  
  function goToApprove(appid,status){
  
  if(status=='A'){
  alert("Already Apprved");
  return false;
  
  }
  
  var url="<%=basePath%>SBSAnnuityServlet?method=Approve2&&ApproveLevel=CHQHRLevel2&&menu=<%=menu%>&&appid="+appid;
		
					document.AnnitySearch.action=url;
					document.AnnitySearch.method="post";
					document.AnnitySearch.submit();
  }
  
  </script> 
   
<script type="text/javascript">
var dataSet =<%=ss%>;
    
 
$(document).ready(function() {
    $('#example').DataTable( {
        data: dataSet,
        columns: [
         	{ title: "Approve" },
            { title: "ApplicationID" },
            { title: "Employee Name" },
            { title: "PFID" },
             { title: "Region" },
            { title: "Status" },
           
            { title: "App Date" },
            { title: "Report" }
        ]
    } );
} );
  </script>
  </head>
 
  
  <body onload="javascript:frmload()">
  
   <form name="AnnitySearch" action="" method="post">
  
   	<div class="page-content-wrapper">
		<div class="page-content">
			<div class="row">
			    <div class="col-md-12">
				<h3 class="page-title">Annuity Form Approved By HR</h3>
				<ul class="page-breadcrumb breadcrumb"></ul>
			    </div>
			</div>
			
		<table id="example" class="display" width="100%"  style="font-size: 13px !important; color: #444 !important;" ></table>
		
	</div></div>

		</form>
	
		
  
		
  </body>
</html>
