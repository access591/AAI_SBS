

<%@ page language="java"%>
<%@ page import="java.util.*,aims.common.*"%>
<%@ page import="java.util.ArrayList" %>
<%@ page import="aims.bean.LoginInfo"%>

<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>


	  <% 
						  LoginInfo user=(LoginInfo)session.getAttribute("user");     
						      String userId="",oldpass="";
						       userId=user.getUserName();
						       oldpass=user.getPassword();
						       
						       String mesg=request.getParameter("errormsg"); 
						       System.out.println("e----msg"+mesg);
						       
						       
						       %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"
"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
  <head> 
	    <title>Airports Authority of india</title>
    	
		<link href="<%=basePath%>assets/plugins/font-awesome/css/font-awesome.min.css"
			rel="stylesheet" type="text/css" />
		<link href="<%=basePath%>assets/plugins/bootstrap/css/bootstrap.min.css"
			rel="stylesheet" type="text/css" />
		<link href="<%=basePath%>assets/plugins/uniform/css/uniform.default.css"
			rel="stylesheet" type="text/css" />
		<!-- END GLOBAL MANDATORY STYLES -->
		<!-- BEGIN THEME STYLES -->
		<link href="<%=basePath%>assets/css/style-metronic.css" rel="stylesheet"
			type="text/css" />
			
		<link href="<%=basePath%>assets/css/style.css" rel="stylesheet" type="text/css" />
		<link href="<%=basePath%>assets/css/style-responsive.css" rel="stylesheet"
			type="text/css" />
		<link href="<%=basePath%>assets/css/plugins.css" rel="stylesheet" type="text/css" />
		<link href="<%=basePath%>assets/css/themes/default.css" rel="stylesheet"
			type="text/css" id="style_color" />
		<link href="<%=basePath%>assets/css/custom.css" rel="stylesheet" type="text/css" />
		<!-- END THEME STYLES -->
<!-- <link rel="shortcut icon" href="favicon.ico" /> -->
		<link href="<%=basePath%>assets/plugins/data-tables/DT_bootstrap.css"
			rel="stylesheet" type="text/css" />
		<script src="<%=basePath%>assets/plugins/jquery-1.10.2.min.js"
			type="text/javascript"></script>
		<script src="<%=basePath%>assets/plugins/jquery-1.10.2.min.js"
			type="text/javascript"></script>
		<script src="<%=basePath%>assets/plugins/jquery-migrate-1.2.1.min.js"
			type="text/javascript"></script>
		<script src="<%=basePath%>assets/plugins/bootstrap/js/bootstrap.min.js"
			type="text/javascript"></script>
		<script
			src="<%=basePath%>assets/plugins/bootstrap-hover-dropdown/twitter-bootstrap-hover-dropdown.min.js"
			type="text/javascript"></script>
		<script
			src="<%=basePath%>assets/plugins/jquery-slimscroll/jquery.slimscroll.min.js"
			type="text/javascript"></script>
		<script src="<%=basePath%>assets/plugins/jquery.blockui.min.js"
			type="text/javascript"></script>
		<script src="<%=basePath%>assets/plugins/jquery.cokie.min.js"
			type="text/javascript"></script>
		<script src="<%=basePath%>assets/plugins/uniform/jquery.uniform.min.js"
			type="text/javascript"></script>

		<script src="<%=basePath%>assets/scripts/app.js"></script>
		<script type="text/javascript" src="<%=basePath%>assets/plugins/bootstrap-datepicker/js/bootstrap-datepicker.js"></script>
		<script type="text/javascript" src="<%=basePath%>assets/plugins/bootstrap-datetimepicker/js/bootstrap-datetimepicker.js"></script>
    	
		<script language="javascript">


       function validate(){		   
		   if(document.forms[0].oldpwd.value=="")
		   {
			    alert("Please Enter Old Password");
				document.forms[0].oldpwd.focus();
				return false;
		   }
		   if(document.forms[0].newpwd.value=="")
		   {
			    alert("Please Enter New Password");
				document.forms[0].newpwd.focus();
				return false;
		   }
		   
		   	      if(document.forms[0].newpwd.value.length<8 )
		   {
			    alert("Password Length should be 8 Character Minimum");
				document.forms[0].newpwd.focus();
				return false;
		   }
		   var strongRegex = new RegExp("^(?=.*[a-z])(?=.*[A-Z])(?=.*[0-9])(?=.*[!@#\$%\^&\*])(?=.{8,})");
		   if(document.forms[0].newpwd.value.match(strongRegex)){
		   
		  // alert("true");
		   
		   }else{
		   alert(" The Password must contain at least 1 lowercase, 1 uppercase alphabetical character,1 numaric character,1 special charecter and length must be 8 character or longer");
		   document.forms[0].newpwd.focus();
		   
		   return false;
		   }
		   if(document.forms[0].confirmpwd.value=="")
		   {
			    alert("Please Enter Confirm Password");
				document.forms[0].confirmpwd.focus();
				return false;
		   }
		    if((document.forms[0].newpwd.value)!=(document.forms[0].confirmpwd.value)){
				alert("New and Confirm Password should be same");
				document.forms[0].newpwd.select();
				return false;

			}
		   return true;
		}
var old='<%=oldpass%>';

		function testSS(){
			if(!validate()){
				 return false;
			}
			var url="<%=basePath%>SBSLogin?method=changePassword";
			//alert(url);
		document.forms[0].action=url
								document.forms[0].method="post";
								document.forms[0].submit();
			
		}	

  </script>

  </head>
  <body >
  <div class="row">
                                    <div class="col-md-12"  style="margin-top:10px;">
            <h4 class="form-section" style="text-align:center; font-weight:400 !important;"> 
            &nbsp;<i class="fa fa-user" aria-hidden="true" style="font-size:23px;"></i> Change Password </h4>
</div></div>

  	<form>
  	<% if(mesg!=null) {%>
  		<div class="row">
  			<div class="col-md-10">
  			<div class="form-group ">
  			<label class="control-label col-md-6"> </label>
  			<div class="col-md-3"><Font color="red">
  		<%= mesg%></font>
  		</div>
  			</div>
  			
  			</div>
  			</div>
  	<%} %>
  			<div class="row">
  			<div class="col-md-10">
  			<div class="form-group ">
  		<label class="control-label col-md-6">User Name  : </label>
  			
  			<div class="col-md-3">
  		
						
						  <input type="text" name="username" value="<%=userId%>" readonly="true" class="form-control"/>
  			</div>
  			</div>
  			
  			</div>
  			</div>
  					<div class="row">
  			<div class="col-md-10">
  			<div class="form-group ">
  		<label class="control-label col-md-6">Old password  : </label>
  			
  			<div class="col-md-3">
  			  <% 
						     // String userId="";
						       //userId=(String) session.getAttribute("userid");
						       %>
						
						  <input type="password" name="oldpwd"   class="form-control" />
  			</div>
  			</div>
  			
  			</div>
  			</div>
  			
  					<div class="row">
  			<div class="col-md-10">
  			<div class="form-group ">
  		<label class="control-label col-md-6">New Password  : </label>
  			
  			<div class="col-md-3">
  			 
						
						  <input TYPE="password" name="newpwd"   class="form-control"/>
  			</div>
  			</div>
  			
  			</div>
  			</div>
  					<div class="row">
  			<div class="col-md-10">
  			<div class="form-group ">
  		<label class="control-label col-md-6">Conform Password  : </label>
  			
  			<div class="col-md-3">
  			 
						
						  <input TYPE="password" name="confirmpwd"  class="form-control"/>
  			</div>
  			</div>
  			
  			</div>
  			</div>
  			
  			<div class="row"> <div class="col-md-12" style="text-align: center;">
  			<input type="button" class="btn green"  value="Update"  onClick="testSS();">						
								<input type="button" class="btn blue" value="Reset" onclick="javascript:document.forms[0].reset()" ></div>
								</div>
   					</form>
	
  </body>
</html>
