<%@ page language="java" import="java.util.*" pageEncoding="ISO-8859-1"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE>
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>SBS</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	
		
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
		<link href="<%=basePath%>Content/Styles/datepicker.css" rel="stylesheet" type="text/css" />
		<!-- END THEME STYLES -->
<!-- <link rel="shortcut icon" href="favicon.ico" /> -->
		<link href="<%=basePath%>assets/plugins/data-tables/DT_bootstrap.css"
			rel="stylesheet" type="text/css" />
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

	<style type="text/css">
	
	body {
	font-family: font-family: 'Varela Round', sans-serif !important;
}

	</style>

  </head>
  
  <body>
  <div class="header navbar navbar-inverse navbar-fixed-top">
	<!-- BEGIN TOP NAVIGATION BAR -->
	<div class="header-inner" style="font-family:'Varela Round', sans-serif;">
		<!-- BEGIN LOGO -->
		<a class="navbar-brand"> <span style="margin-top: -5px;"><img src="assets/img/aai-logo.png" ></span>
	<b> <span style="color:#eaa302; font-family: 'Varela Round', sans-serif !important;">  </span><span >AAIEDCP Scheme</span></b>
		</a>
		<!-- END LOGO -->
		<!-- BEGIN RESPONSIVE MENU TOGGLER -->
		<a href="javascript:;" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-collapse">
		<img src="assets/img/menu-toggler.png" alt=""/>
		</a>
		<!-- END RESPONSIVE MENU TOGGLER -->
		<!-- BEGIN TOP NAVIGATION MENU -->
		<ul class="nav navbar-nav pull-right">
			<!-- BEGIN NOTIFICATION DROPDOWN -->
				<!--<li class="dropdown" id="header_modules">
				<a href="#" class="dropdown-toggle" data-toggle="dropdown" data-hover="dropdown" data-close-others="true">
				<!-- <i class="fa fa-warning"></i> -->
				<!--<img src="Content/Images/modules.png" alt=""/>
				<span class="badge">
					<%=2 %>		</span>				</a>
					<ul class="dropdown-menu extended notification">
					<li><p>Modules</p></li>
					<%
					
					
			
			//System.out.println("MODULE_CD::"+rs.getString("MODULE_CD"));
 		%>		
			  
			    <li class="external"><A name='mainpage' href='<%=basePath%>PensionView/SBSMenu.jsp?mcd=AM' >
			    
			    <Font>Admin</Font></A></li>
			    
	
					
					
					<li class="external">
						
					</li> 
				</ul>
			</li>-->
			
			<li class="dropdown user">
				<a href="/SBSIndex.jsp" class="dropdown-toggle" data-toggle="dropdown"
							data-hover="dropdown" data-close-others="true"> <img alt=""
								src="assets/img/avatar1_small.jpg" /> <span class="username">
								<%= session.getAttribute("username") %> </span> <i class="fa fa-angle-down"></i> </a>
				<ul class="dropdown-menu">
					<li>
						<a href="javascript:;"><i class="fa fa-user" style="color:#09a28d"></i> My Profile</a>
					</li>
					<li>
						<a href="<%=basePath%>PensionLogin?method=changepassword&flag=checkusername"><i class="fa fa-calendar" style="color:#09a28d"></i> Change Password</a>
					</li>
					<!-- <li>
						<a href="inbox.html"><i class="fa fa-envelope"></i> My Inbox
						<span class="badge badge-danger">
							3
						</span>
						</a>
					</li>
					<li>
						<a href="#"><i class="fa fa-tasks"></i> My Tasks
						<span class="badge badge-success">
							7
						</span>
						</a>
					</li> -->
					<li class="divider">
					</li>
					<li>
						<a href="javascript:;" id="trigger_fullscreen"><i class="fa fa-move" style="color:#09a28d"></i> Full Screen</a>
					</li>
					<li>
						<a href="extra_lock.html"><i class="fa fa-lock" style="color:#09a28d"></i> Lock Screen</a>
					</li>
					<li>
						
							<a 	href="<%=basePath%>SBSLogin?method=logoff" > <i class="fa fa-sign-out" aria-hidden="true" style="color:#09a28d"></i>Log Out</a>
								
							</li>
					</li>
				</ul>
			
	</div>
	<!-- END TOP NAVIGATION BAR -->
</div>

		
		<!--<script>
jQuery(document).ready(function() {   
  
   App.init();
});
</script>-->
		
		
  </body>
</html>

    <!-- BEGIN PAGE LEVEL PLUGINS -->
     <script type="text/javascript" src="../../assets/plugins/fuelux/js/spinner.min.js"></script>
    <script type="text/javascript" src="../../assets/plugins/ckeditor/ckeditor.js"></script>
    <script type="text/javascript" src="../../assets/plugins/bootstrap-fileupload/bootstrap-fileupload.js"></script>
    <script type="text/javascript" src="../../assets/plugins/select2/select2.min.js"></script>
    <script type="text/javascript" src="../../assets/plugins/bootstrap-wysihtml5/wysihtml5-0.3.0.js"></script>
    <script type="text/javascript" src="../../assets/plugins/bootstrap-wysihtml5/bootstrap-wysihtml5.js"></script>
    <script type="text/javascript" src="../../assets/plugins/bootstrap-datepicker/js/bootstrap-datepicker.js"></script>
    <script type="text/javascript" src="../../assets/plugins/bootstrap-datetimepicker/js/bootstrap-datetimepicker.js"></script>
    <script type="text/javascript" src="../../assets/plugins/clockface/js/clockface.js"></script>
    <script type="text/javascript" src="../../assets/plugins/bootstrap-daterangepicker/moment.min.js"></script>
    <script type="text/javascript" src="../../assets/plugins/bootstrap-daterangepicker/daterangepicker.js"></script>
    <script type="text/javascript" src="../../assets/plugins/bootstrap-colorpicker/js/bootstrap-colorpicker.js"></script>
    <script type="text/javascript" src="../../assets/plugins/bootstrap-timepicker/js/bootstrap-timepicker.js"></script>
    <script type="text/javascript" src="../../assets/plugins/jquery-inputmask/jquery.inputmask.bundle.min.js"></script>
    <script type="text/javascript" src="../../assets/plugins/jquery.input-ip-address-control-1.0.min.js"></script>
    <script type="text/javascript" src="../../assets/plugins/jquery-multi-select/js/jquery.multi-select.js"></script>
    <script type="text/javascript" src="../../assets/plugins/jquery-multi-select/js/jquery.quicksearch.js"></script>
    <script src="../../assets/plugins/jquery.pwstrength.bootstrap/src/pwstrength.js" type="text/javascript"></script>
    <script src="../../assets/plugins/bootstrap-switch/static/js/bootstrap-switch.min.js" type="text/javascript"></script>
    <script src="../../assets/plugins/jquery-tags-input/jquery.tagsinput.min.js" type="text/javascript"></script>
    <script src="../../assets/plugins/bootstrap-markdown/js/bootstrap-markdown.js" type="text/javascript"></script>
    <script src="../../assets/plugins/bootstrap-markdown/lib/markdown.js" type="text/javascript"></script>
    <script src="../../assets/plugins/bootstrap-maxlength/bootstrap-maxlength.min.js" type="text/javascript"></script>
    <script src="../../assets/plugins/bootstrap-touchspin/bootstrap.touchspin.js" type="text/javascript"></script>
    <!-- END PAGE LEVEL PLUGINS -->
    <!-- BEGIN PAGE LEVEL SCRIPTS -->
    <script src="assets/scripts/app.js"></script>
    <script src="assets/scripts/form-components.js"></script>
    <!-- END PAGE LEVEL SCRIPTS -->
    

    
    
    
    
      <script>
        jQuery(document).ready(function () {
            // initiate layout and plugins
            App.init();
            FormComponents.init();
        });
    </script>
    <!-- BEGIN GOOGLE RECAPTCHA -->
    <script type="text/javascript">
        var RecaptchaOptions = {
            theme: 'custom',
            custom_theme_widget: 'recaptcha_widget'
        };
    </script>
