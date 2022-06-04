 
<html >
<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta http-equiv="pragma" content="no-cache">
    <meta http-equiv="cache-control" content="no-cache">
    <meta http-equiv="expires" content="0">
    <meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
    <meta http-equiv="description" content="This is my page">
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";


ServletContext ctx = config.getServletContext();

	basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
	
	String message="";
	if(session.getAttribute("msg")!=null){
	message=session.getAttribute("msg").toString();
	session.invalidate();
	}
	System.out.println("message:"+message);
	
%>
<meta charset="utf-8">

  <meta name="viewport" content="width=device-width, initial-scale=1">
<title>:: AAI - Employees Pension Information System ::</title>
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



		<style>
		@media (min-width: 992px)
.page-content {
		margin-left: 235px;
    margin-top: 43px;
    min-height: 760px;
    padding: 15px 20px 20px 20px;
    font-family: verdana;
fieldset,.portlet.box.blue {
	background-color: #f2f9ff;
	border: 1px solid #eaeaea;
	border-radius: 5px;
	margin-bottom: 10px;
	opacity: .8;
	margin-top: 10px;
}

legend {
	color: #fff;
	background-color: #0360a0 !important;
	border: 1px solid #bbb;
	border-radius: 6px;
	/*background-image: linear-gradient(#0d2d4e, #2562a0);*/
}

.name,.name-inner {
	font-size: 23px;
	color: #fff;
	text-align: center;
	line-height: 43px;
	position: absolute;
	display: inline-block;
	/*left: 75px;*/
	/* text-shadow: 0 2px 3px #888!important; */
}

.header { /*background-color: #004778 !important;
    border-bottom: solid 2px;
    border-color: #0e6daf;
    height: 45px;*/
	background-color: #012352 !important;
	border-bottom: solid 2px;
	border-color: #0e6daf;
	height: 45px;
}

body {
	font-family: "Lato", sans-serif;
}

.sidenav {
	height: 94%;
	width: 0;
	position: fixed;
	z-index: 1;
	top: 40px;
	right: 0;
	background-color: #0666a9;
	overflow-x: hidden;
	transition: 0.5s;
	padding-top: 35px;
	color: #FFF;
}

.sidenav a {
	padding: 5px 0px 0px 14px;
	text-decoration: none;
	font-size: 13px;
	color: #fff;
	display: block;
	transition: 0.3s;
}

.sidenav a:hover {
	color: #f1f1f1;
}

.sidenav .closebtn {
	position: absolute;
	top: 0;
	right: 25px;
	font-size: 25px;
	margin-left: 50px;
}

@media screen and (max-height: 450px) {
	.sidenav {
		padding-top: 15px;
	}
	.sidenav a {
		font-size: 18px;
	}
}

.cb-slideshow,.cb-slideshow:after {
	position: fixed;
	width: 100%;
	height: 100%;
	top: 0px;
	left: 0px;
	z-index: 0;
}

.cb-slideshow:after {
	content: '';
	background: transparent url(../images/pattern.png) repeat top left;
}

.cb-slideshow li span {
	width: 100%;
	height: 100%;
	position: absolute;
	top: 55px;
	left: 0px;
	color: transparent;
	background-size: cover;
	background-position: 50% 50%;
	background-repeat: none;
	opacity: 0;
	z-index: 0;
	-webkit-backface-visibility: hidden;
	-webkit-animation: imageAnimation 36s linear infinite 0s;
	-moz-animation: imageAnimation 36s linear infinite 0s;
	-o-animation: imageAnimation 36s linear infinite 0s;
	-ms-animation: imageAnimation 36s linear infinite 0s;
	animation: imageAnimation 36s linear infinite 0s;
}

.cb-slideshow li div {
	z-index: 1000;
	position: absolute;
	bottom: 30px;
	left: 0px;
	width: 100%;
	text-align: center;
	opacity: 0;
	color: #fff;
	-webkit-animation: titleAnimation 36s linear infinite 0s;
	-moz-animation: titleAnimation 36s linear infinite 0s;
	-o-animation: titleAnimation 36s linear infinite 0s;
	-ms-animation: titleAnimation 36s linear infinite 0s;
	animation: titleAnimation 36s linear infinite 0s;
}

.cb-slideshow li div h3 {
	font-family: 'BebasNeueRegular', 'Arial Narrow', Arial, sans-serif;
	font-size: 24px;
	padding: 0;
	line-height: 200px;
}

.cb-slideshow li:nth-child (1) span {
	background-image: url(<%=basePath%>Content/Images/Background/01.jpg)
}

.cb-slideshow li:nth-child (2) span {
	background-image: url(<%=basePath%>Content/Images/Background/02.jpg);
	-webkit-animation-delay: 6s;
	-moz-animation-delay: 6s;
	-o-animation-delay: 6s;
	-ms-animation-delay: 6s;
	animation-delay: 6s;
}

.cb-slideshow li:nth-child (3) span {
	background-image: url(<%=basePath%>Content/Images/Background/03.jpg);
	-webkit-animation-delay: 12s;
	-moz-animation-delay: 12s;
	-o-animation-delay: 12s;
	-ms-animation-delay: 12s;
	animation-delay: 12s;
}

.cb-slideshow li:nth-child (4) span {
	background-image: url(<%=basePath%>Content/Images/Background/04.jpg);
	-webkit-animation-delay: 18s;
	-moz-animation-delay: 18s;
	-o-animation-delay: 18s;
	-ms-animation-delay: 18s;
	animation-delay: 18s;
}

.cb-slideshow li:nth-child (5) span {
	background-image: url(<%=basePath%>Content/Images/Background/05.jpg);
	-webkit-animation-delay: 24s;
	-moz-animation-delay: 24s;
	-o-animation-delay: 24s;
	-ms-animation-delay: 24s;
	animation-delay: 24s;
}

.cb-slideshow li:nth-child (6) span {
	background-image: url(<%=basePath%>Content/Images/Background/06.jpg);
	-webkit-animation-delay: 30s;
	-moz-animation-delay: 30s;
	-o-animation-delay: 30s;
	-ms-animation-delay: 30s;
	animation-delay: 30s;
}

.cb-slideshow li:nth-child (2) div {
	-webkit-animation-delay: 6s;
	-moz-animation-delay: 6s;
	-o-animation-delay: 6s;
	-ms-animation-delay: 6s;
	animation-delay: 6s;
}

.cb-slideshow li:nth-child (3) div {
	-webkit-animation-delay: 12s;
	-moz-animation-delay: 12s;
	-o-animation-delay: 12s;
	-ms-animation-delay: 12s;
	animation-delay: 12s;
}

.cb-slideshow li:nth-child (4) div {
	-webkit-animation-delay: 18s;
	-moz-animation-delay: 18s;
	-o-animation-delay: 18s;
	-ms-animation-delay: 18s;
	animation-delay: 18s;
}

.cb-slideshow li:nth-child (5) div {
	-webkit-animation-delay: 24s;
	-moz-animation-delay: 24s;
	-o-animation-delay: 24s;
	-ms-animation-delay: 24s;
	animation-delay: 24s;
}

.cb-slideshow li:nth-child (6) div {
	-webkit-animation-delay: 30s;
	-moz-animation-delay: 30s;
	-o-animation-delay: 30s;
	-ms-animation-delay: 30s;
	animation-delay: 30s;
}

</style>
   <script type="text/javascript">
            $(function () {
                $(".date-picker").datepicker({autoclose:true});
            });
        </script>
 <script language="javascript">


function validate()
		{ 
			
			 if(document.forms[0].user.value=="")
			{
				alert("Please Enter User Name");
				document.forms[0].user.focus();
				return false;
			}
			document.forms[0].user.value=parseInt(document.forms[0].user.value);
			 if(document.forms[0].doj.value=="")
			{
				alert("Please Enter Date of Joining");
				document.forms[0].doj.focus();
				return false;
			}
			  
		document.forms[0].action="<%=basePath%>SBSLogin?method=forgotpassword" 
				document.forms[0].method="post";
				document.forms[0].submit();    
   
	}
			
		
		
		
function clock() {
		var date = new Date()
		var year = date.getYear()
		var month = date.getMonth()
		var day = date.getDate()
		var hour = date.getHours()
		var minute = date.getMinutes()
		var second = date.getSeconds()
			var ampm='AM'
		var months = new Array( "January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December")

		var monthname = months[month];

		if (hour > 12) {
		hour = hour - 12
		ampm='PM';
		}

		if (minute < 10) {
		minute = "0" + minute
		}

		if (second < 10) {
		second = "0" + second
		}


		document.getElementById('clocktime').innerHTML =  monthname + " " + day + ", " + year + " - " + hour + ":" + minute + ":" + second+" "+ampm+"&nbsp;&nbsp;";

		setTimeout("clock()", 1000)

}
function show(){
document.getElementById('light4').style.display='block';
document.getElementById('fade').style.display='block'
}
		
		</script>
	<style type="text/css">
	.form-gap {
    padding-top: 70px;
}
fieldset {
    min-width: 100% !important;
    padding: 20px !important;
    margin: 0 !important;
    border: solid 1px #7cb1e6 !important;
    border-radius: 12px !important;
    background: #cfe3f7 !important;
}
label {
    display: inline-block;
    margin-bottom: .5rem;
    text-align: right;
}
.btn.default {
    color: #333333;
    padding: 17px;
    height: 30px;
    text-shadow: none;
    background-color: #e5e5e5;
}
.required
{color:red;}
</style>
		
</head>

<body onLoad="show();document.forms[0].username.focus();" style="background: #fff !important" >
<form>
	<header class="header navbar navbar-inverse navbar-fixed-top">
		<div class="header-inner" style="margin-top: 4px;">
		<span class="name-inner" style="margin-left: 5px; font-size: 21px !important; font-weight: 600;
    color: #ffffff">
			<!--<img src="<%=basePath%>Content/Images/aai-logo.png" alt="">-->	<img src="assets/img/aai-logo.png" ><b>AAIEDCP  Scheme </b> </span>
		

		</div>
		</header>
    
    
    <div class="form-gap"></div>
  
<div class="container">
<fieldset>

<div class="row">
	<div class="col-md-12">
	<div class="col-md-3">
	</div>
	<div class="col-md-6"> 
	
<div class="row"> 
<div class="col-md-12"> <font color="red" style="font-size: 15px; font-weight: 600; letter-spacing: 1px;"> <%=message %></font></div>
</div>
	<div class="row">
	
		<div class="col-md-12 ">
            <div class="panel panel-default">
              <div class="panel-body">
                <div class="text-center">
                  <i class="fa fa-lock fa-4x" style="color:#0567d0;"></i>
                  <h3 class="text-center">Forgot Password?</h3>
                  <p>You can reset your password here.</p>
                  <div class="panel-body">
    
                    <form id="register-form" role="form" autocomplete="off" class="form" method="post">
                    
                    <div class="row">
    <div class="col-md-10">
    
    <label class="control-label col-md-5">User Name <span class="required">*</span> :</label> 
                         <div class="col-md-7">                        
                          <input id="user" name="user" placeholder="User Name" class="form-control"  type="text">
                        </div>
    
    
    </div>
    </div>
        <div class="row">
    <div class="col-md-10">
    
    <label class="control-label col-md-5"> Date of Joining <span class="required">*</span> :</label> 
                         <div class="col-md-6" style="text-align: left !important">                        
                        <div class="input-group input-medium date date-picker"  data-date-format="dd-M-yyyy" data-date-viewmode="years" data-date-minviewmode="months">
                                                        <input type="text" name="doj"  placeholder="Date of Joining" id="doj" class="form-control" readonly>
                                                        <span class="input-group-btn">
                                                            <button class="btn default" type="button" style="padding: 4px 4px;"><i class="fa fa-calendar"></i></button>
                                                        </span>
                                                    </div>
                        </div>
    
    
    </div>
    </div>
                        
                  </form>
    
                  </div>
                </div>
              </div>
              </div></div></div></div>
	<div class=col-md-3></div>
	</div>	
	</div>
              <div class="row">
              <div class="col-md-12" style="text-align: center;">
               <div class="form-group">
               <a  href="<%=basePath%>SBSLogin.jsp" role="button"  class="btn green" style='padding:6px;'>Back</a>
                           
                        <input name="recover-submit" class="btn btn-primary" value="Reset Password" type="submit" onclick="return validate()" style='padding:6px; color: #fff;'>
                      </div>
              </div>
              </div>
              </fieldset>
              </div>
             
       
                          
</form>
</body> 
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
    
</html>
