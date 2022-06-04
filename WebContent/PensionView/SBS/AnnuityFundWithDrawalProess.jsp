<%@ page language="java" import="java.util.*,aims.bean.LicBean"
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

		<title>My JSP 'AnnuityFundWithDrawalProcess.jsp' starting page</title>

		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
		<meta http-equiv="description" content="This is my page">
	
		<%
			String menu = request.getParameter("menu") != null ? request
					.getParameter("menu") : "";
		%>
		
	<%
		LicBean bean = new LicBean();

		ArrayList list =request.getAttribute("list")!=null?(ArrayList)request.getAttribute("list"): null;
	%>	
		
		<script type="text/javascript">


$(document).ready(function() {
    function updateSum() {
      var total = 0;
      var ids='';
      $(".sum:checked").each(function(i, n) {total += parseInt($(n).val());})
      $("#total").val(total);
      
      $(".sum:checked").each(function(i, n) {ids =ids+(ids!=''?',':'')+ $(this).attr("id");})
       $("#ids").val(ids);
    }
    // run the update on every checkbox change and on startup
    $("input.sum").change(updateSum);
    updateSum();
})


</script>
	</head>
	
	<body >
		<form name="approve" action="">
			<div class="page-content-wrapper">
				<div class="page-content">
					<div class="row">
						<div class="col-md-12">
							<h3 class="page-title">
								Fund Withdrawal Process Form
							</h3>
							<ul class="page-breadcrumb breadcrumb"></ul>
						</div>
					</div>
					<fieldset>
					<div class="row">
					<table class="table table-bordered">
  <thead><tr>
					<th>S.No</th><th>Application ID</th><th>Member Name</th><th>PF ID</th><th>App Date</th><th>Station</th>
					<th>Corpus Amount</th><th>Select</th></tr></thead><tbody>
					
					
					<% if(list!=null){
					
					for(int i=0;i<list.size();i++){ 
					bean=(LicBean)list.get(i);
					%>
					
					<tr>
					<td><%=(i+1) %>)</td>
					<td>Annuity/<%=bean.getFormType()%>/<%=bean.getAppId() %></td>
					<td><%=bean.getMemberName() %></td>
					<td><%=bean.getEmployeeNo() %></td>
					<td><%=bean.getAppDate() %></td>
					<td></td>
					<td><%=bean.getCorpusAmt() %></td>
					<td><input type="checkbox" name="<%=bean.getAppId()%>" id="<%=bean.getAppId()%>"class="sum"  value="<%=bean.getCorpusAmt() %>" data-toggle="checkbox"/></td>
					</tr>
				
				
					
					<%}%>
					
					<tr>
					<td colspan="6">Total</td><td colspan="1"><input type="text" name="total" id="total" class="form-control"  /></td><td></td></tr>
					</tbody></table></div>
				
						<div class="row">
					<div class="col-md-12">
					<div class="form-group">
					<div class="col-md-8">Id's</div><div class="col-md-2"><input type="text" name="ids" id="ids" class="form-control"  /></div>
					</div>
					</div>
					</div>
					
					<% }else{ %>
						<div class="row">
					<div class="col-md-12">
					<div class="form-group">
					NO Records Found
					</div>
					</div>
					</div>
					<%} %>

						<div class="row">
							<div class="col-md-12">
								<div style="text-align: center">
									<button type="submit" class="btn blue"
										onclick="return validate()">
										<i class="fa fa-undo"></i> Reset
									</button>
									<button type="submit" class="btn green"
										onclick="return validate()">
										<i class="fa fa-check"></i> Generate Voucher
									</button>
								</div>
							</div>
						</div>

					</fieldset>

				</div>
			</div>

		</form>
	</body>
</html>
