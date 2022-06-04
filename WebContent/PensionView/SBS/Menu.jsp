<%@ page language="java" import="java.util.*,aims.bean.LoginInfo,aims.bean.SBSScreenBean,aims.common.DBUtils,java.sql.*" pageEncoding="ISO-8859-1"%>




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
String screenCode =checkMenu(request.getParameter("screenCode"));
String L1="";
String L2="";
if(!menu.equals("")){
	 L1=menu.substring(0,2); 
	
	 
	 if(menu.length()>2){
		 
	 L2=menu;
	 }
	 }
	 
	 
	 
	 
	 
	 
	 
	LoginInfo user=(LoginInfo)session.getAttribute("user"); 
	String username=user.getUserName();
	
	  

%>
	

	
<%
 

	
	String annuityOP=session.getAttribute("AnnuityOption").toString(); 
	String annuityOPFlag="Y";
	System.out.println(user.getModules());
	String [] modules=user.getModules().split(",");
	System.out.println("modules::"+modules+user.getDisplayName());
	
	if(user.getProfile().equals("M")){
	
	
	
	
	
	Connection con=null;
	Statement stmt=null;
	ResultSet rs=null;
	String sqlQuery="select 'N' as flag from sbs_annuity_forms u where u.pensionno='"+user.getPensionNo()+"' and u.approve1='A'";
	try{
	 con=DBUtils.getConnection();
	 stmt=con.createStatement();
	 rs=stmt.executeQuery(sqlQuery);
	 if(rs.next()){
	 annuityOPFlag=rs.getString("flag")!=null?rs.getString("flag"):"Y";
	 annuityOP=annuityOPFlag;
	 }
	 
	}catch(Exception e){
	e.printStackTrace();
	}finally{
	con.close();
	}
	
	} 
	
%>
<% if(user.getProfile().equals("S")){ %>

 <div class="page-sidebar-wrapper">
				<div class="page-sidebar navbar-collapse collapse">

					<ul class="page-sidebar-menu">
						<li class="sidebar-toggler-wrapper">

							<div class="sidebar-toggler hidden-phone">
							</div>

						</li>
						
					<li <% if("M1".equals(L1)){  %> class="active open" <% }%>>
							<a href="javascript:;"> <i class="fa fa-cogs"></i> <span
								class="title"> SBS Master </span> <span class="arrow "> </span> </a>
							<ul class="sub-menu">
									<li <% if("M1L1".equals(L2)){  %> class="active" <% }%>>
									<a href="<%=basePath%>sbssearch?method=loadPerMstr&&menu=M1L1"> 
								
										<i class="fa fa-arrow-circle-o-right" aria-hidden="true"></i> Search</a>
								</li>
								
							</ul>
						</li>
						<li <% if("M2".equals(L1)){  %> class="active open" <% }%>>
							
						<a href="<%=basePath%>sbssearch?method=sbsloadFinContri&&menu=M2L1"> 
						 <i class="fa fa-bookmark-o"></i> <span
								class="title">   Opening Corpus Statement </a>
						
						</li>
						
						
						
						
						<li class="">
							<a href="javascript:;"> <i class="fa fa-bookmark-o"></i> <span
								class="title">   CPF Accretions Uploads </a>
					
						</li>
						<li <% if("M4".equals(L1)){  %> class="active open" <% }%>>
							<a href="javascript:;"> <i class="fa fa-folder-open"></i> <span
								class="title"> Reports</span> <span class="arrow "> </span> </a>
							<ul class="sub-menu">
							<li <% if("M4L1".equals(L2)){  %> class="active" <% }%>><a href="<%=basePath%>sbssearch?method=sbseligible&&menu=M4L1"><i class="fa fa-arrow-circle-o-right" aria-hidden="true"></i>  SBS Eligible/InEligible Report </a></li>

							
								<li <% if("M4L2".equals(L2)){  %> class="active" <% }%>><a href="<%=basePath%>reportservlet?method=retirementEmployeesInfo&&menu=M4L2"> <i class="fa fa-arrow-circle-o-right" aria-hidden="true"></i> Monthly Separation Employee Info </a></li>
								<li <% if("M4L3".equals(L2)){  %> class="active" <% }%>><a href="<%=basePath%>sbssearch?method=loadSBSCard&&menu=M4L3"><i class="fa fa-arrow-circle-o-right" aria-hidden="true"></i>  SBS Card </a></li>
								<li <% if("M4L4".equals(L2)){  %> class="active" <% }%>><a href="<%=basePath%>SBSAnnuityServlet?method=finalsettlement&&menu=M4L4"><i class="fa fa-arrow-circle-o-right" aria-hidden="true"></i>  EDCP Trust Final Settlement </a></li>
								<li <% if("M4L5".equals(L2)){  %> class="active" <% }%>><a href="<%=basePath%>SBSAnnuityServlet?method=MISStatusReportParam&&menu=M4L5"><i class="fa fa-arrow-circle-o-right" aria-hidden="true"></i>  MIS Status Report </a></li>
								<li <% if("M4L6".equals(L2)){  %> class="active" <% }%>><a href="<%=basePath%>SBSAnnuityServlet?method=AnnuityApprovedReportParam&&menu=M4L6"><i class="fa fa-arrow-circle-o-right" aria-hidden="true"></i>  Annuity Approved Report </a></li>
								<li <% if("M4L7".equals(L2)){  %> class="active" <% }%>><a href="<%=basePath%>SBSAnnuityServlet?method=NodalOfficerReportParam&&menu=M4L7"><i class="fa fa-arrow-circle-o-right" aria-hidden="true"></i>  Nodal Officer Report </a></li>
							</ul>
						</li>
						<li class="">
							<a href="javascript:;"> <i class="fa fa-user"></i> <span
								class="title"> SBS nomination details </span> <span class="arrow "> </span> </a>
							<ul class="sub-menu">
								<li>
									<a href="javascript:;"> <i class="fa fa-arrow-circle-o-right" aria-hidden="true"></i> New</a>
								</li>
								<li>
									<a href="javascript:;"><i class="fa fa-arrow-circle-o-right" aria-hidden="true"></i> Edit</a>
								</li>
							</ul>
						</li>
						<li class="">
							<a href="javascript:;"> <i class="fa fa-th"></i> <span
								class="title"> SBS online application </a>
							
						</li>
						<li <% if("M5".equals(L1)){  %> class="active open" <% }%> style="border-bottom: solid 3px; border-color: #4aa5a3">
							<a href="javascript:;"> <i class="fa fa-file-text"></i> <span
								class="title"> 	Annuity Forms  </span> <span class="arrow"> </span> </a>
							<ul class="sub-menu">
								<li <% if("M5L1".equals(L2)){  %> class="active" <% }%>>
									<a href="<%=basePath%>SBSAnnuityServlet?method=getForms&menu=M5L1"> <i class="fa fa-arrow-circle-o-right" aria-hidden="true"></i> LIC Form</a>
								</li>
								<li <% if("M5L2".equals(L2)){  %> class="active" <% }%>>
									<a href="<%=basePath%>SBSAnnuityServlet?method=getSBIForm&menu=M5L2"> <i class="fa fa-arrow-circle-o-right" aria-hidden="true"></i> SBI Form</a>
								</li>
								<li <% if("M5L3".equals(L2)){  %> class="active" <% }%>>
									<a href="<%=basePath%>SBSAnnuityServlet?method=getHDFCForm&menu=M5L3"> <i class="fa fa-arrow-circle-o-right" aria-hidden="true"></i> HDFC Form</a>
								</li>
								<li <% if("M5L7".equals(L2)){  %> class="active" <% }%>>
									<a href="<%=basePath%>SBSAnnuityServlet?method=getBajajForm&menu=M5L7"> <i class="fa fa-arrow-circle-o-right" aria-hidden="true"></i> Bajaj Form</a>
								</li>
								<li <% if("M5L11".equals(L2)){  %> class="active" <% }%>>
									<a href="<%=basePath%>SBSAnnuityServlet?method=getRefundofCorpus&menu=M5L11"> <i class="fa fa-arrow-circle-o-right" aria-hidden="true"></i>Refund of Corpus</a>
								</li>
								
								<li <% if("M5L4".equals(L2)){  %> class="active" <% }%>>
									<a href="<%=basePath%>SBSAnnuityServlet?method=getAnnuitySearch&menu=M5L4"> <i class="fa fa-arrow-circle-o-right" aria-hidden="true"></i> Annuity Document Receipt Ack(Pending Scrutiny)</a>
								</li>
								<li <% if("M5L5".equals(L2)){  %> class="active" <% }%>>
									<a href="<%=basePath%>SBSAnnuityServlet?method=getAnnuitySearch2&menu=M5L5"> <i class="fa fa-arrow-circle-o-right" aria-hidden="true"></i> Annuity Form Approved By HR</a>
								</li>
								<li <% if("M5L6".equals(L2)){  %> class="active" <% }%>>
									<a href="<%=basePath%>SBSAnnuityServlet?method=finApprove&menu=M5L6"> <i class="fa fa-arrow-circle-o-right" aria-hidden="true"></i> Annuity Form Scrutiny[Finance]</a>
								</li>
								<li <% if("M5L8".equals(L2)){  %> class="active" <% }%>>
									<a href="<%=basePath%>SBSAnnuityServlet?method=rhqHrApprove&menu=M5L8"> <i class="fa fa-arrow-circle-o-right" aria-hidden="true"></i> RHQ HR Regional Committee</a>
								</li>
								<li <% if("M5L9".equals(L2)){  %> class="active" <% }%>>
									<a href="<%=basePath%>SBSAnnuityServlet?method=rhqFinApprove&menu=M5L9"> <i class="fa fa-arrow-circle-o-right" aria-hidden="true"></i> RHQ FINANCE Regional Committe</a>
								</li>
								<li <% if("M5L10".equals(L2)){  %> class="active" <% }%>>
									<a href="<%=basePath%>SBSAnnuityServlet?method=chqHrApprove&menu=M5L10"> <i class="fa fa-arrow-circle-o-right" aria-hidden="true"></i> SOCIAL SECURITY</a>
								</li>
								
									
							</ul>
						</li>
						<li <% if("M6".equals(L1)){  %> class="active open" <% }%> style="border-bottom: solid 3px; border-color: #4aa5a3">
							<a href="javascript:;"> <i class="fa fa-file-text"></i> <span
								class="title"> 	EDCP Trust   </span> <span class="arrow"> </span> </a>
							<ul class="sub-menu">
								<li <% if("M6L1".equals(L2)){  %> class="active" <% }%>>
									<a href="<%=basePath%>SBSAnnuityServlet?method=edcpApprove&menu=M6L1"> <i class="fa fa-arrow-circle-o-right" aria-hidden="true"></i>  Form Approval-I  </a>
								</li>
									<li <% if("M6L2".equals(L2)){  %> class="active" <% }%>>
									<a href="<%=basePath%>SBSAnnuityServlet?method=edcpApprove2&menu=M6L2"> <i class="fa fa-arrow-circle-o-right" aria-hidden="true"></i>  Form Approval-II </a>
								</li>
								<li <% if("M6L3".equals(L2)){  %> class="active" <% }%>>
									<a href="<%=basePath%>SBSAnnuityServlet?method=edcpApprove3&menu=M6L3"> <i class="fa fa-arrow-circle-o-right" aria-hidden="true"></i>  Form Approval-III </a>
								</li>
								<li <% if("M6L4".equals(L2)){  %> class="active" <% }%>>
									<a href="<%=basePath%>SBSAnnuityServlet?method=coveringletter&menu=M6L4"> <i class="fa fa-arrow-circle-o-right" aria-hidden="true"></i>  Covering Letter </a>
								</li>
								<!--<li <% if("M6L2".equals(L2)){  %> class="active" <% }%>>
									<a href="<%=basePath%>SBSAnnuityServlet?method=fundWithDrawal&menu=M6L2"> <i class="fa fa-arrow-circle-o-right" aria-hidden="true"></i> Fund Withdrawal Process    </a>
								</li>
								<li <% if("M6L3".equals(L2)){  %> class="active" <% }%>>
									<a href="javascript:;"> <i class="fa fa-arrow-circle-o-right" aria-hidden="true"></i> Annuity Purchase Process</a>
								</li> -->
						</ul>
						</li>
						<li <% if("M7".equals(L1)){  %> class="active open" <% }%> style="border-bottom: solid 3px; border-color: #4aa5a3">
							<a href="javascript:;"> <i class="fa fa-file-text"></i> <span
								class="title"> 	Policy Document   </span> <span class="arrow"> </span> </a>
							<ul class="sub-menu">
								<li <% if("M7L1".equals(L2)){  %> class="active" <% }%>>
									<a href="<%=basePath%>SBSAnnuityServlet?method=policydocument&menu=M7L1"> <i class="fa fa-arrow-circle-o-right" aria-hidden="true"></i>  New </a>
								</li>
								<li <% if("M7L2".equals(L2)){  %> class="active" <% }%>>
									<a href="<%=basePath%>SBSAnnuityServlet?method=searchPolicydoc&menu=M7L2"> <i class="fa fa-arrow-circle-o-right" aria-hidden="true"></i>  Search </a>
								</li>
								<li <% if("M7L3".equals(L2)){  %> class="active" <% }%>>
									<a href="<%=basePath%>SBSAnnuityServlet?method=policyDocReportParam&menu=M7L3"> <i class="fa fa-arrow-circle-o-right" aria-hidden="true"></i>  Report </a>
								</li>

								</ul>
								</li>
								
								<li <% if("M8".equals(L1)){  %> class="active open" <% }%> style="border-bottom: solid 3px; border-color: #4aa5a3">
							<a href="javascript:;"> <i class="fa fa-file-text"></i> <span
								class="title"> 	Journal Vouchers  </span> <span class="arrow"> </span> </a>
							<ul class="sub-menu">
								<li <% if("M8L1".equals(L2)){  %> class="active" <% }%>>
									<a href="<%=basePath%>SBSAnnuityServlet?method=RefundJV&menu=M8L1"> <i class="fa fa-arrow-circle-o-right" aria-hidden="true"></i>  New  </a>
								</li>
								<li <% if("M8L2".equals(L2)){  %> class="active" <% }%>>
									<a href="<%=basePath%>SBSAnnuityServlet?method=JournalVocherSRCH&menu=M8L2"> <i class="fa fa-arrow-circle-o-right" aria-hidden="true"></i>  Search </a>
								</li>
								<li <% if("M8L3".equals(L2)){  %> class="active" <% }%>>
									<a href="<%=basePath%>SBSAnnuityServlet?method=JournalVocherRpt&menu=M8L3"> <i class="fa fa-arrow-circle-o-right" aria-hidden="true"></i>  Report </a>
								</li>
								</ul>
								</li>

								<li <% if("M9".equals(L1)){  %> class="active open" <% }%> style="border-bottom: solid 3px; border-color: #4aa5a3">
							<a href="javascript:;"> <i class="fa fa-file-text"></i> <span
								class="title"> 	Payment Voucher </span> <span class="arrow"> </span> </a>
							<ul class="sub-menu">
								<li <% if("M9L2".equals(L2)){  %> class="active" <% }%>>
									<a href="<%=basePath%>SBSAnnuityServlet?method=paymentvocher&menu=M9L2"> <i class="fa fa-arrow-circle-o-right" aria-hidden="true"></i> New </a>
								</li>
								<li <% if("M9L2".equals(L2)){  %> class="active" <% }%>>
									<a href="<%=basePath%>SBSAnnuityServlet?method=paymentvocherSrch&menu=M9L2"> <i class="fa fa-arrow-circle-o-right" aria-hidden="true"></i>  Search </a>
								</li>
								<li <% if("M9L3".equals(L2)){  %> class="active" <% }%>>
									<a href="<%=basePath%>SBSAnnuityServlet?method=paymentvocherRpt&menu=M9L3"> <i class="fa fa-arrow-circle-o-right" aria-hidden="true"></i>  Report </a>
								</li>
								</ul>
								</li>


						 
					</ul>

				</div>
			</div>


<%} else if(user.getProfile().equals("M")){ %>
<div class="page-sidebar-wrapper">
				<div class="page-sidebar navbar-collapse collapse">

					<ul class="page-sidebar-menu">
						<li class="sidebar-toggler-wrapper">

							<div class="sidebar-toggler hidden-phone">
							</div>

						</li>
<li <% if("M2".equals(L1)){  %> class="active open" <% }%>>
							
						<a href="<%=basePath%>sbssearch?method=sbsloadFinContri&&menu=M2L1"> 
						 <i class="fa fa-bookmark-o"></i> <span
								class="title">   Opening Corpus Statement </a>
						
						</li>
						<li <% if("M4L3".equals(L2)){  %> class="active" <% }%>><a href="<%=basePath%>sbssearch?method=loadSBSCard&&menu=M4L3"><i class="fa fa-arrow-circle-o-right" aria-hidden="true"></i>  SBS Card </a></li>
						
						
						<!--  <li <% if("M5".equals(L1)){  %> class="active open" <% }%> style="border-bottom: solid 3px; border-color: #4aa5a3">
							<a href="javascript:;"> <i class="fa fa-file-text"></i> <span
								class="title"> 	Annuity Forms  </span> <span class="arrow"> </span> </a>
							<ul class="sub-menu">
							<% if(annuityOP.equals("Y")){ %>
								<li <% if("M5L1".equals(L2)){  %> class="active" <% }%>>
									<a href="<%=basePath%>SBSAnnuityServlet?method=getForms&menu=M5L1"> <i class="fa fa-arrow-circle-o-right" aria-hidden="true"></i> LIC Form</a>
								</li>
								<li <% if("M5L2".equals(L2)){  %> class="active" <% }%>>
									<a href="<%=basePath%>SBSAnnuityServlet?method=getSBIForm&menu=M5L2"> <i class="fa fa-arrow-circle-o-right" aria-hidden="true"></i> SBI Form</a>
								</li>
								<li <% if("M5L3".equals(L2)){  %> class="active" <% }%>>
									<a href="<%=basePath%>SBSAnnuityServlet?method=getHDFCForm&menu=M5L3"> <i class="fa fa-arrow-circle-o-right" aria-hidden="true"></i> HDFC Form</a>
								</li>
								<li <% if("M5L7".equals(L2)){  %> class="active" <% }%>>
									<a href="<%=basePath%>SBSAnnuityServlet?method=getBajajForm&menu=M5L7"> <i class="fa fa-arrow-circle-o-right" aria-hidden="true"></i> Bajaj Form</a>
								</li>
								<%} %>
								<li <% if("M5L10".equals(L2)){  %> class="active" <% }%>>
									<a href="<%=basePath%>SBSAnnuityServlet?method=getAppStatus&menu=M5L10"> <i class="fa fa-arrow-circle-o-right" aria-hidden="true"></i> Annuity Application Status</a>
								</li>
								
							</ul>
						</li>-->
	
					</ul>

				</div>
			</div>
			
	<%} else if(user.getProfile().equals("Nn")){ %><div class="page-sidebar-wrapper">
				<div class="page-sidebar navbar-collapse collapse">

					<ul class="page-sidebar-menu">
						<li class="sidebar-toggler-wrapper">

							<div class="sidebar-toggler hidden-phone">
							</div>

						</li>
						
					<li <% if("M1".equals(L1)){  %> class="active open" <% }%>>
							<a href="javascript:;"> <i class="fa fa-cogs"></i> <span
								class="title"> SBS Master </span> <span class="arrow "> </span> </a>
							<ul class="sub-menu">
									<li <% if("M1L1".equals(L2)){  %> class="active" <% }%>>
									<a href="<%=basePath%>sbssearch?method=loadPerMstr&&menu=M1L1"> 
								
										<i class="fa fa-arrow-circle-o-right" aria-hidden="true"></i> Search</a>
								</li>
								
							</ul>
						</li>
						<li <% if("M2".equals(L1)){  %> class="active open" <% }%>>
							
						<a href="<%=basePath%>sbssearch?method=sbsloadFinContri&&menu=M2L1"> 
						 <i class="fa fa-bookmark-o"></i> <span
								class="title">   Opening Corpus Statement </a>
						
						</li>
						
						
						
						
						<li class="">
							<a href="javascript:;"> <i class="fa fa-bookmark-o"></i> <span
								class="title">   CPF Accretions Uploads </a>
					
						</li>
						<li <% if("M4".equals(L1)){  %> class="active open" <% }%>>
							<a href="javascript:;"> <i class="fa fa-folder-open"></i> <span
								class="title"> Reports</span> <span class="arrow "> </span> </a>
							<ul class="sub-menu">
							<li <% if("M4L1".equals(L2)){  %> class="active" <% }%>><a href="<%=basePath%>sbssearch?method=sbseligible&&menu=M4L1"><i class="fa fa-arrow-circle-o-right" aria-hidden="true"></i>  SBS Eligible/InEligible Report </a></li>

							
								<li <% if("M4L2".equals(L2)){  %> class="active" <% }%>><a href="<%=basePath%>reportservlet?method=retirementEmployeesInfo&&menu=M4L2"> <i class="fa fa-arrow-circle-o-right" aria-hidden="true"></i> Monthly Separation Employee Info </a></li>
								<li <% if("M4L3".equals(L2)){  %> class="active" <% }%>><a href="<%=basePath%>sbssearch?method=loadSBSCard&&menu=M4L3"><i class="fa fa-arrow-circle-o-right" aria-hidden="true"></i>  SBS Card </a></li>

							
							
							
							
							</ul>
						</li>
						<li class="">
							<a href="javascript:;"> <i class="fa fa-user"></i> <span
								class="title"> SBS nomination details </span> <span class="arrow "> </span> </a>
							<ul class="sub-menu">
								<li>
									<a href="javascript:;"> <i class="fa fa-arrow-circle-o-right" aria-hidden="true"></i> New</a>
								</li>
								<li>
									<a href="javascript:;"><i class="fa fa-arrow-circle-o-right" aria-hidden="true"></i> Edit</a>
								</li>
							</ul>
						</li>
			
						<li <% if("M5".equals(L1)){  %> class="active open" <% }%> style="border-bottom: solid 3px; border-color: #4aa5a3">
							<a href="javascript:;"> <i class="fa fa-file-text"></i> <span
								class="title"> 	Annuity Forms  </span> <span class="arrow"> </span> </a>
							<ul class="sub-menu">
								<li <% if("M5L1".equals(L2)){  %> class="active" <% }%>>
									<a href="<%=basePath%>SBSAnnuityServlet?method=getForms&menu=M5L1"> <i class="fa fa-arrow-circle-o-right" aria-hidden="true"></i> LIC Form</a>
								</li>
								<li <% if("M5L2".equals(L2)){  %> class="active" <% }%>>
									<a href="<%=basePath%>SBSAnnuityServlet?method=getSBIForm&menu=M5L2"> <i class="fa fa-arrow-circle-o-right" aria-hidden="true"></i> SBI Form</a>
								</li>
								<li <% if("M5L3".equals(L2)){  %> class="active" <% }%>>
									<a href="<%=basePath%>SBSAnnuityServlet?method=getHDFCForm&menu=M5L3"> <i class="fa fa-arrow-circle-o-right" aria-hidden="true"></i> HDFC Form</a>
								</li>
								<li <% if("M5L7".equals(L2)){  %> class="active" <% }%>>
									<a href="<%=basePath%>SBSAnnuityServlet?method=getBajajForm&menu=M5L7"> <i class="fa fa-arrow-circle-o-right" aria-hidden="true"></i> Bajaj Form</a>
								</li>
								<li <% if("M5L4".equals(L2)){  %> class="active" <% }%>>
									<a href="<%=basePath%>SBSAnnuityServlet?method=getAnnuitySearch&menu=M5L4"> <i class="fa fa-arrow-circle-o-right" aria-hidden="true"></i> Annuity Document Receipt Ack(Pending Scrutiny)</a>
								</li>
								<li <% if("M5L5".equals(L2)){  %> class="active" <% }%>>
									<a href="<%=basePath%>SBSAnnuityServlet?method=getAnnuitySearch2&menu=M5L5"> <i class="fa fa-arrow-circle-o-right" aria-hidden="true"></i> Annuity Form Approved By HR</a>
								</li>
								<li <% if("M5L6".equals(L2)){  %> class="active" <% }%>>
									<a href="<%=basePath%>SBSAnnuityServlet?method=finApprove&menu=M5L6"> <i class="fa fa-arrow-circle-o-right" aria-hidden="true"></i> Annuity Form Scrutiny[Finance]</a>
								</li>
								<li <% if("M5L8".equals(L2)){  %> class="active" <% }%>>
									<a href="<%=basePath%>SBSAnnuityServlet?method=rhqHrApprove&menu=M5L8"> <i class="fa fa-arrow-circle-o-right" aria-hidden="true"></i> RHQ HR Regional Committee</a>
								</li>
								<li <% if("M5L9".equals(L2)){  %> class="active" <% }%>>
									<a href="<%=basePath%>SBSAnnuityServlet?method=rhqFinApprove&menu=M5L9"> <i class="fa fa-arrow-circle-o-right" aria-hidden="true"></i> RHQ FINANCE Regional Committee</a>
								</li>
								<li <% if("M5L10".equals(L2)){  %> class="active" <% }%>>
									<a href="<%=basePath%>SBSAnnuityServlet?method=chqHrApprove&menu=M5L10"> <i class="fa fa-arrow-circle-o-right" aria-hidden="true"></i> SOCIAL SECURITY</a>
								</li>
									<li <% if("M5L11".equals(L2)){  %> class="active" <% }%>>
									<a href="<%=basePath%>SBSAnnuityServlet?method=chqFinApprove&menu=M5L11"> <i class="fa fa-arrow-circle-o-right" aria-hidden="true"></i> CHQ Finance Search</a>
								</li>
							</ul>
						</li>
						<li <% if("M6".equals(L1)){  %> class="active open" <% }%> style="border-bottom: solid 3px; border-color: #4aa5a3">
							<a href="javascript:;"> <i class="fa fa-file-text"></i> <span
								class="title"> 	EDCP Trust123   </span> <span class="arrow"> </span> </a>
							<ul class="sub-menu">
								<li <% if("M6L1".equals(L2)){  %> class="active" <% }%>>
									<a href="<%=basePath%>SBSAnnuityServlet?method=edcpApprove&menu=M6L1"> <i class="fa fa-arrow-circle-o-right" aria-hidden="true"></i>  Form Approval-I </a>
								</li>
							
								<!--<li <% if("M6L2".equals(L2)){  %> class="active" <% }%>>
									<a href="<%=basePath%>SBSAnnuityServlet?method=fundWithDrawal&menu=M6L2"> <i class="fa fa-arrow-circle-o-right" aria-hidden="true"></i> Fund Withdrawal Process    </a>
								</li>
								<li <% if("M6L3".equals(L2)){  %> class="active" <% }%>>
									<a href="javascript:;"> <i class="fa fa-arrow-circle-o-right" aria-hidden="true"></i> Annuity Purchase Process</a>
								</li>-->
						</ul>
						</li>
					</ul>

				</div>
			</div>


<%} else {  



LinkedHashMap map =new LinkedHashMap();
		List list =new ArrayList();
		Connection connection=null;
		ResultSet rs=null;
		PreparedStatement pstmt=null;	
		SBSScreenBean sbean =null;
		String comSM="";
		String SM="";
		int count=0;
		try{	
			String Qry="";
				Qry="SELECT AR.SCREENCODE,USERID,SCREENNAME,PATH,(select SUBMODULECD||SUBMODNAME from epis_submodules where SUBMODULECD=AC.SUBMODULECD) submodule,(select SORTINGORDER from epis_submodules  where SUBMODULECD = AC.SUBMODULECD) SORTING FROM EPIS_ACCESSCODES_MT AC,epis_accessrights AR WHERE AR.SCREENCODE=AC.SCREENCODE AND AR.USERID=TRIM(?) AND AC.MODULECODE=TRIM('SM')  order by SORTING,SUBMODULECD,AC.SORTINGORDER,SCREENCODE";
		
		System.out.println("Qry:"+Qry);	
			connection=DBUtils.getConnection();
	 
			if(connection!=null){
				pstmt = connection.prepareStatement(Qry);
				
				if(pstmt!=null){
					pstmt.setString(1,username);
					
					rs = pstmt.executeQuery();
					
					
					while(rs.next()){
						sbean=new SBSScreenBean();
						SM=rs.getString("SUBMODULE");
						if(!SM.equals(comSM)){
						if(count!=0)
							map.put(comSM,list);
						comSM=SM;
						list =new ArrayList();
						}
						sbean.setScreenPath(rs.getString("PATH")+"&screenCode="+rs.getString("SCREENCODE"));
						sbean.setScreenName(rs.getString("SCREENNAME"));
						sbean.setScreenCode(rs.getString("SCREENCODE"));
						
						list.add(sbean);
						count++;
					}
					map.put(comSM,list);
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
						
						
						
						
	 
	 <% for (Iterator it = map.entrySet().iterator(); it.hasNext();) {
Map.Entry pairs = (Map.Entry) it.next();
System.out.println(pairs.getKey() + " = " + pairs.getValue());
ArrayList submenulist=new ArrayList();
submenulist=(ArrayList)pairs.getValue();
String menuCode="";
if(!screenCode.equals("")){
if(screenCode.length()>4)
menuCode=screenCode.substring(0,4); 
} 
%>
		
		<li <% if(menuCode.equals(pairs.getKey().toString().substring(0,4))){  %> class="active open" <% }%>>
							<a href="javascript:;">  <span
								class="title"> <%=pairs.getKey().toString().substring(4) %> </span> <span class="arrow "> </span> </a>
							<ul class="sub-menu">
		
		<% SBSScreenBean bean=null;
		for(int x=0;x<submenulist.size();x++){
		bean=(SBSScreenBean)submenulist.get(x);
		
		System.out.println("bean:::path"+bean.getScreenPath());
	 %>
	 <%   if(bean.getScreenCode().equals(screenCode)){ %>
	 
	 
	 
	 
	 <li class="active">
	 
	 <%}else{ %>
	 <li>
	 <%} %>
							<a href="<%=basePath%><%=bean.getScreenPath() %>"><i class="fa fa-arrow-circle-o-right" aria-hidden="true"></i> <%=bean.getScreenName() %> </a>
								
								
							
						</li>
	 
	 
	 
	 
	 
	 
	<% }%>
	
	</ul>
						</li>
	<%  }%>
	
	
	
						</ul>
	</div></div>
	 
	 
	 
	<% }catch(Exception e){
	e.printStackTrace();
	}finally{
	rs.close();
	pstmt.close();
	connection.close();
	}


}


 %>







