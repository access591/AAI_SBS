
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
<script src="<%=basePath%>assets/plugins/jquery-1.10.2.min.js" type="text/javascript"></script>

<script src="../../assets/plugins/data-tables/jquery.dataTables.min.js"></script>

 <link href="../../assets/plugins/data-tables/DT_bootstrap.css"></link>
 <%
 
 ArrayList list=(ArrayList)request.getAttribute("list");
 System.out.println(list);
  String ss=list.toString();
   String menu=request.getParameter("menu")!=null?request.getParameter("menu"):"";
   %>
   
  <script type="text/javascript">
  
  function print(Jvno){

				var formType="N";
			var swidth=screen.Width-10;
			var sheight=screen.Height-150;
			
			//alert("jvno"+Jvno);
			 
			var url="<%=basePath%>SBSAnnuityServlet?method=JournalVoucherReport&&jvno="+Jvno;
			wind1 = window.open(url,"winComps","toolbar=yes,statusbar=yes,scrollbars=yes,menubar=yes,resizable=yes,width="+swidth+",height="+sheight+",top=0,left=0");
	   	 	winOpened = true;
			wind1.window.focus();
			
		
		
  }
  
  
  </script> 
   
<script type="text/javascript">
var dataSet =<%=ss%>;
 //alert( "dataSet===="+dataSet); 
 
$(document).ready(function() {
    $('#example').DataTable( {
        data: dataSet,
        columns: [
         	{ title: "JV No" },
            { title: "Employee Name" },
            { title: "PFID" },
            { title: "ApplicationID" },
            { title: "JV Date" },
            { title: "Report" }
        ]
    } );
} );
  </script>
  
  </head>
 
  
  <body onload="javascript:frmload()">
  
   <form name="AnnitySearch"  method="post">
  
   	<div class="page-content-wrapper">
		<div class="page-content">
			<div class="row">
			    <div class="col-md-12">
				<h3 class="page-title">Journal Voucher Search</h3>
				<ul class="page-breadcrumb breadcrumb"></ul>
			    </div>
			</div>
			
		<table id="example" class="display responsive nowrap" width="100%" style="font-size: 13px !important; color: #005d5b !important;"></table>
		
	</div></div>

		</form>
	
		
  
		
  </body>
</html>
