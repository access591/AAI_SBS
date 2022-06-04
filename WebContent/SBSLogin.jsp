<html>
	<head>
		<%
			String path = request.getContextPath();
			String basePath = request.getScheme() + "://"
					+ request.getServerName() + ":" + request.getServerPort()
					+ path + "/";
		%>

		<meta charset="utf-8" />
		<title>SBS</title>
		<meta http-equiv="X-UA-Compatible" content="IE=edge">
		<meta content="width=device-width, initial-scale=1.0" name="viewport" />
		<meta content="" name="description" />
		<meta content="" name="author" />
		<meta name="MobileOptimized" content="320">
		<META HTTP-EQUIV="CACHE-CONTROL" CONTENT="NO-CACHE">

		<link
			href="<%=basePath%>Content/font-awesome/css/font-awesome.min.css"
			rel="stylesheet" type="text/css" />
		<link href="<%=basePath%>Content/Styles/bootstrap.minhome.css"
			rel="stylesheet" type="text/css" />
		<link
			href="<%=basePath%>Content/Login-CSS/Content/Styles/style-metronic.css"
			rel="stylesheet" type="text/css" />
		<link href="<%=basePath%>Content/Styles/style home.css"
			rel="stylesheet" type="text/css" />
            
		<link
			href="<%=basePath%>Content/Login-CSS/Content/Styles/style-responsive.css"
			rel="stylesheet" type="text/css" />
		<link href="<%=basePath%>Content/Login-CSS/Content/Styles/default.css"
			rel="stylesheet" type="text/css" id="style_color" />
		<link
			href="<%=basePath%>Content/Login-CSS/Content/Styles/defaulthome.css"
			rel="stylesheet" type="text/css" id="style_color" />
		<link href="<%=basePath%>Scripts/Login/login-soft.css"
			rel="stylesheet" type="text/css" />
		<script src="<%=basePath%>Scripts/Login/jquery.validate.min.js"></script>
		<script src="<%=basePath%>Scripts/Login/login-soft.js"></script>
		<script src="<%=basePath%>Scripts/Login/jquery.backstretch.min.js"
			type="text/javascript"></script>

		



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
		<script language="javascript">
function testSS()
		{ 
			if(document.forms[0].username.value=="")
			{
				alert("Please Enter User Name");
				document.forms[0].username.focus();
				return false;
			}
			document.forms[0].username.value=parseInt(document.forms[0].username.value);
			 if(document.forms[0].password.value=="")
			{
				alert("Please Enter Password");
				document.forms[0].password.focus();
				return false;
			}
			 else{ 
			 	document.login.action="<%=basePath%>SBSLogin?method=Sbsloginpage" 
				document.login.method="post";
				document.login.submit();
			}
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
		
		</script>

		<link rel="stylesheet" type="text/css" href="<%=basePath%>Content/Styles/demo.css" />
		<script type="text/javascript" src="js/modernizr.custom.js"></script>
	</head>

	<body onLoad="document.forms[0].username.focus();" >
		<header class="header navbar navbar-inverse navbar-fixed-top">
		<div class="header-inner" style="margin-top: 4px;">
		<span class="name-inner" style="margin-left:-50px">
			<!--<img src="<%=basePath%>Content/Images/aai-logo.png" alt="">-->	<img src="assets/img/aai-logo.png" ><b>AAIEDCP  Scheme </b> </span>
		

		</div>
		</header>
		


		<div class="row">
			<div class="col-md-12" style="height: 60px;">
			</div>
		</div>
		<div class="col-md-12"  >
		</div>
		<div class="row">
		<div class="col-md-9"></div>
			<!--<div class="col-md-9">


				<fieldset style="padding: 10px !important">
					<legend>
						<font
							style="text-shadow: 3px 3px 4px #000; font-family: verdana !important; font-weight: bold; font-size: 13px; padding: 5px;">
							EPIS Applications</font>
					</legend>

					<div class="row" style="margin-top:-20px;">
                    	<div class="col-md-2"></div>
						<div class="col-md-4">
							<div class="dashboard-stat red">
								<div class="visual">
									<i class="fa fa-plane"></i>
								</div>
								<div class="details">
									<div class="number">

									</div>
									<div class="desc" style="margin-top: 8px; text-align: justify;">
										<a
											href="#"
											style="color: #fff">EPIS 1</a>
									</div>
								</div>
								<div class="more">
									&nbsp;
									<i class="m-icon-swapright m-icon-white"></i>
								</div>
							</div>
						</div>

						<div class=" col-md-4">
							<div class="dashboard-stat bluee">
								<div class="visual">
									<i class="fa fa-plane"></i>
								</div>
								<div class="details">
									<div class="number">

									</div>
									<div class="desc" style="text-align: center;">
										<a href="#" style="color: #fff">EPIS
											2</a>
									</div>
								</div>
								<div class="more">
									&nbsp;
									<i class="m-icon-swapright m-icon-white"></i>
								</div>
							</div>
							<div class="col-md-2"></div>
						</div>


					</div>
					<div class="row">
                    <div class="col-md-2"></div>
						<div class="col-md-4">
							<div class="dashboard-stat yellow">
								<div class="visual">
									<i class="fa fa-plane"></i>
								</div>
								<div class="details">
									<div class="number">

									</div>
									<div class="desc"
										style="text-align: center;">
										<a href="#"	style="color: #fff"> PENSION 1
											
										</a>
									</div>
								</div>
								<div class="more">
									&nbsp;
									<i class="m-icon-swapright m-icon-white"></i>
								</div>
							</div>
						</div>

						<div class=" col-md-4">
							<div class="dashboard-stat pink">
								<div class="visual">
									<i class="fa fa-plane"></i>
								</div>
								<div class="details">
									<div class="number">

									</div>
									<div class="desc"
										style="text-align: center;">
										<a
											href="#"
											style="color: #fff"> PENSION 2</a>
									</div>
								</div>
								<div class="more">
									&nbsp;
									<i class="m-icon-swapright m-icon-white"></i>
								</div>
							</div>

						</div>
<div class="col-md-2"></div>

					</div>

				</fieldset>
			</div>
			
			--><div class="col-md-3">
				<!--<fieldset style="padding: 10px !important;">
					<legend>
						<font
							style="text-shadow: 3px 3px 4px #000; font-family: verdana !important; font-weight: bold; font-size: 13px; padding: 5px;">Please
							Login Here</font>
					</legend>
					--><div class="row" style="vertical-align: top">
						<div class="col-md-12"  >

							
							<div class="more">
								&nbsp;
								<i class="m-icon-swapright m-icon-white"></i>
							</div>
						</div>
					</div>
					<!--</fieldset>
			--></div>

		</div>
	<div class="details">
								<section class="login" style="float:right">
								<article class="content">

								<form  name="login" class="login-form"  method="post">
								
								<p style="color:#ffffff;font-size:16px;font-weight: bold; height: 35px; vertical-align: bottom;">AAIEDCP Individual Login
								
								</p>
								<br/>
							<div style="height: 20px;">
									<%
										System.out.println(request.getAttribute("message"));
										if (request.getAttribute("message") != null) {
									%>

									<font color="red" size="2"><%=request.getAttribute("message")%></font>
									<%
										}
									%>
									</div>
									<p
										style="text-align: center; font-family: verdana; font-size: 14px;">
										
									</p>
									<div class="alert alert-danger display-hide">
										<button class="close" data-close="alert"></button>
										<br />
										<br />
										<span> </span>
									</div>
									<div class="form-group">
										<div class="input-icon">
											<i class="fa fa-user"></i>
											<input class="form-control placeholder-no-fix" type="text" required 
												autocomplete="on" placeholder="Username" name="username"
												id="username" />
										</div>
									</div>
									<div class="form-group">
										<div class="input-icon">
											<i class="fa fa-lock"></i>
											<input class="form-control placeholder-no-fix"
												type="password" autocomplete="off" placeholder="Password" 
												name="password" id="password" required />
												<input type="hidden" id="mode" name="mode" value="M" />
										</div>
									</div>
									
									<div class="form-actions">
										<label class="checkbox">
											<input type="checkbox" name="remember" value="1" />
											Remember me
										</label>
										<button type="submit" onclick="testSS()"
											class="btn green pull-right">
											Login
										</button>
									</div>
									
										<div class="form-actions">
										<a href="ForgotPassword.jsp" ><font color="yellow">Forgot my password?</font></a>
									</div>
									<div style="height: 30px;"></div>
								</form>
								<!--  <form class="forget-form" action="index.html" method="post"
									novalidate="novalidate" style="display: none;">
									<h4>
										Forget Password ?
									</h4>
									<p>
										Enter "Username" below to reset your password.
									</p>
									<div class="form-group">
										<div class="input-icon">
											<i class="fa fa-user"></i>
											<input class="form-control placeholder-no-fix"
												autocomplete="off" placeholder="Username" name="fusername"
												type="text">
										</div>
									</div>
									<div class="form-actions">
										<button type="button" id="back-btn" class="btn">
											<i class="fa fa-arrow-circle-o-left"></i> Back
										</button>
										<button type="submit" class="btn blue pull-right">
											Submit
											<i class="fa fa-arrow-circle-o-right"></i>
										</button>
									</div>
								</form>-->
								</article>
								</section>
							</div>



		
	</body>



</html>
