<%@ page language="java" import="java.util.*" pageEncoding="ISO-8859-1"%>


<%!public String checkMenu(Object str) {
	if(str == null)
		return "";
	else
		return str.toString().trim();
}
String varpath="";

%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";



String menu =checkMenu(request.getParameter("menu"));
String L1="";
String L2="";
if(!menu.equals("")){
	 L1=menu.substring(0,2); 
	
	 
	 if(menu.length()>2){
		 
	 L2=menu;
	 }
	 }
%>
<div class="page-sidebar-wrapper">
				<div class="page-sidebar navbar-collapse collapse">

					<ul class="page-sidebar-menu">
						<li class="sidebar-toggler-wrapper">

							<div class="sidebar-toggler hidden-phone">
							</div>

						</li>
						
					<li <% if("M1".equals(L1)){  %> class="active open" <% }%>>
							<a href="javascript:;"> <i class="fa fa-cogs"></i> <span
								class="title">  Masters </span> <span class="arrow "> </span> </a>
							<ul class="sub-menu">
									<li <% if("M1L1".equals(L2)){  %> class="active" <% }%>>
									<a href="<%=basePath%>sbssearch?method=loadPerMstr&&menu=M1L1"> 
									<!--<span class="badge badge-roundless badge-important"></span>-->
										<i class="fa fa-arrow-circle-o-right" aria-hidden="true"></i> Search</a>
								</li>
								
							</ul>
						</li>
						<li <% if("M2".equals(L1)){  %> class="active open" <% }%>>
							
						<a href="<%=basePath%>userSearch?method=search"> 
						 <i class="fa fa-bookmark-o"></i> <span
								class="title">   User </a>
						
						</li>
						
						
						
						
						<li class="">
							<a href="javascript:;"> <i class="fa fa-bookmark-o"></i> <span
								class="title">   Access Rights </a>
					
						</li>
						
					
						<li class="">
							<a href="javascript:;"> <i class="fa fa-th"></i> <span
								class="title"> Change/Reset Password </a>
							
						</li>
						
						
					</ul>

				</div>
			</div>