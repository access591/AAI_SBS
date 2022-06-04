<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    
    <%@page import="java.util.ArrayList,aims.bean.UnitBean"    %>
    <%@ taglib uri="/WEB-INF/c.tld" prefix="c" %>
<% 
ArrayList ulist=null;
if(session.getAttribute("unitList")!=null){
ulist=(ArrayList)session.getAttribute("unitList");


}
ArrayList userList=null;
if(session.getAttribute("userList")!=null){
userList=(ArrayList)session.getAttribute("userList");


}
 %>
<html>
<jsp:include page="/SBSHeader.jsp"></jsp:include>
<jsp:include page="/PensionView/SBS/AdminMenu.jsp"></jsp:include>
<head>

<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Aircraft Management</title>
</head>
<body >

<form action="/userSearch?method=searchResult" method="post" >
<div class="page-content-wrapper">
		<div class="page-content">
			<div class="row">
			    <div class="col-md-12">
				<h3 class="page-title">User Information</h3>
				<ul class="page-breadcrumb breadcrumb"></ul>
			    </div>
			</div>
			
			<div class="row">
						<div class="col-md-6">
							<div class="form-group">
								<label class="control-label col-md-6">User Name<font color=red></font>
									
								 : </label>
								
								<div class="col-md-6">
								
								
								<input type="text" class="form-control" name="username" id="username" placeholder="User Name"/>
									
									
									
								
								
										
								</div>
							</div>
						</div>
						<div class="col-md-6">
							<div class="form-group">
								<label class="control-label col-md-4">PF ID<font color=red></font>:
									
								  </label>
								
								<div class="col-md-6">
										<input type="text" class="form-control" name="PFID" id="PFID" placeholder="PF ID"/>
										
								
								</div>
							</div>
						</div>
					</div>


<div class="row">
						<div class="col-md-6">
							<div class="form-group">
								<label class="control-label col-md-6">User Type<font color=red></font>
									
								 : </label>
								
								<div class="col-md-6">
								
								
								<SELECT  id="userType" name="userType" class="form-control" >
									
									<option value="user">User</option>
									<option value="nodalOfficer">Nodal Officer</option>
									<option value="admin">Admin</option>
									
								</SELECT>
								
										
								</div>
							</div>
						</div>
						<div class="col-md-6">
							<div class="form-group">
								<label class="control-label col-md-4">Profile Type<font color=red></font>:
									
								  </label>
								
								<div class="col-md-6">
										<SELECT NAME="profileType" id="profileType" class="form-control">
							<option value="NO-SELECT">
								[Select One]
							</option>
							<option value="M">
								Member Level
							</option>
							<option value="U">
								Unit Level
							</option>
							<option value="R">
								RHQ Level
							</option>
							<option value="C">
								CHQ Level
							</option>
					    
						</SELECT>
										
								
								</div>
							</div>
						</div>
					</div>
					
					
					<div class="row">
						<div class="col-md-6">
							<div class="form-group">
								<label class="control-label col-md-6">Unit<font color=red></font>
									
								 : </label>
								
								<div class="col-md-6">
								<select id="food" name="fooditems" class="form-control">
								<option value="NO-SELECT">
								[Select One]
							</option>
							
								
								<%
								for(int i=0;i<ulist.size();i++){
								UnitBean ub=(UnitBean)ulist.get(i);
								 %>
								 
								 <option value="<%=ub.getUnitName() %>">
								<%=ub.getUnitName() %>
							</option>
							<%} %>
    
</select>
								
							
										
								</div>
							</div>
						</div>
						<div class="col-md-6">
							<div class="form-group">
								<label class="control-label col-md-4">Status<font color=red></font>:
									
								  </label>
								
								<div class="col-md-6">
										<SELECT NAME="status" id="status" class="form-control">
							<option value="NO-SELECT">
								[Select One]
							</option>
							<option value="active">
								Active
							</option>
							<option value="inActive">
								In-Active
							</option>
					    
						</SELECT>
										
								
								</div>
							</div>
						</div>
					</div>
	<div class="col-md-12">
									<div class="col-md-4">&nbsp;</div>
									<div class="col-md-8">
										<input type="submit" value="Search" class="btn green" onclick="Search();"></input>
										<input type="button" class="btn blue" value="Reset" onclick="javascript:resetMaster()" class="btn">
										<input type="button" class="btn dark" value="Back" onclick="javascript:history.back(-1)" class="btn">
						
									</div>
								
								</div>

	<script type="text/javascript">
	$(document).ready(function(){
	
	    var dataset  = ${userList}; //
	    
	   alert(dataset);
	  
	    var table = $('#example').DataTable( {
	    	 data: dataset,
	          columns: [
	        	  { title: "Aircraft Keyno"},
	            { title: "Aircraft Type"},
	          
	            { title: "Registration Number"}
	           
	          ],
	          "paging":true,
	          "pageLength":10,
	          "ordering":true
	        });
	});
	</script>

<div id="demo_jui">
	<table  class="display nowrap responsive jqueryDataTable" id="example" class="display" width="100%"></table>
	</div>
 
 
 </div>
 </div>
 
			
</form>


</body>
</html>