
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


	<script src="<%=basePath%>assets/plugins/jquery.cokie.min.js"
			type="text/javascript"></script>
			<script
			src="<%=basePath%>assets/plugins/jquery-slimscroll/jquery.slimscroll.min.js"
			type="text/javascript"></script>

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
  function frmload(){
  }
  function print(appid,status){

				var formType="N";
			var swidth=screen.Width-10;
			var sheight=screen.Height-150;
			
			 if(status!='A'){
  alert("Print will be available after approved only");
  return false;
  }
			
			var url="<%=basePath%>SBSAnnuityServlet?method=annuityReport&&ApproveLevel=HRLevel1&&appid="+appid;
			wind1 = window.open(url,"winComps","toolbar=yes,statusbar=yes,scrollbars=yes,menubar=yes,resizable=yes,width="+swidth+",height="+sheight+",top=0,left=0");
	   	 	winOpened = true;
			wind1.window.focus();
			
		
		
  }
  
  function goToApprove(appid,status){
 
  //alert();
  if(status=='A'){
  alert("Already Approved");
  return false;
  }
 
  
  var url="<%=basePath%>SBSAnnuityServlet?method=Approve&&ApproveLevel=CHQHRLevel1&&menu=<%=menu%>&&appid="+appid;
		//alert(url);
					document.AnnitySearch.action=url;
					document.AnnitySearch.method="post";
					document.AnnitySearch.submit();
  }
  
  </script> 
   
<script type="text/javascript">
var dataSet =<%=ss%>;
  // var dataSet =[ ['<button name=Approve class=btn-success value=Approve onclick=goToApprove("3","A")>Approve</button>','3', 'INDU PARAMESHWARAN PILLAI', '2255', 'A','04-Dec-2019'],  ['<button name=Approve class=btn-success value=Approve onclick=goToApprove(4,A)>Approve</button>','4', 'INDU PARAMESHWARAN PILLAI', '2255', 'A','04-Dec-2019']];
 //var dataSet = [['<a  onclick=javascript:goToApprove("8","A")><i class="fas fa-edit"></i></a>','ANNUITY/LIC/8', 'ALOK KUMAR MISRA', '54', 'A','09-Jan-2020','<button name=report class="btn btn-primary" onclick=javascript:print("8","A")>Print</button>'], ['<a  onclick=javascript:goToApprove("3","A")><i class="fas fa-edit"></i></a>','ANNUITY/LIC/3', 'AJAY KUMAR', '60', 'A','08-Jan-2020','<button name=report class="btn btn-primary" onclick=javascript:print("3","A")>Print</button>'], ['<a  onclick=javascript:goToApprove("5","A")><i class="fas fa-edit"></i></a>','ANNUITY/LIC/5', 'A.A.KHATANA', '58', 'A','09-Jan-2020','<button name=report class="btn btn-primary" onclick=javascript:print("5","A")>Print</button>'], ['<a  onclick=javascript:goToApprove("13","")><i class="fas fa-edit"></i></a>','ANNUITY/LIC/13', 'R.KASTURI RANGAN', '1234', '','28-Jan-2020','<button name=report class="btn btn-primary" onclick=javascript:print("13","")>Print</button>'], ['<a  onclick=javascript:goToApprove("14","")><i class="fas fa-edit"></i></a>','ANNUITY/LIC/14', 'TARUN KUMAR NATH', '5345', '','28-Jan-2020','<button name=report class="btn btn-primary" onclick=javascript:print("14","")>Print</button>'], ['<a  onclick=javascript:goToApprove("15","")><i class="fas fa-edit"></i></a>','ANNUITY/LIC/15', 'RAM NIWAS', '567', '','28-Jan-2020','<button name=report class="btn btn-primary" onclick=javascript:print("15","")>Print</button>']];
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
  <style>
  body{
  font-size: 13px !important;}
  </style>
  </head>
 
  
  <body onload="javascript:frmload()">
  
   <form name="AnnitySearch" action="" method="post">
  
   	<div class="page-content-wrapper">
		<div class="page-content">
			<div class="row">
			    <div class="col-md-12">
				<h3 class="page-title">Annuity Document Receipt Ack(Pending Scrutiny)</h3>
				<ul class="page-breadcrumb breadcrumb"></ul>
			    </div>
			</div>
			
		<table id="example" class="display" width="100%" style="font-size: 13px !important; color: #444 !important;"></table>
		
	</div></div>

		</form>
	
		
  
		
  </body>
</html>
