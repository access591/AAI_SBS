package aims.action;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import aims.bean.LoginInfo;
import aims.bean.SearchInfo;
import aims.bean.UserBean;
import aims.common.InvalidDataException;
import aims.common.JspPageConstants;
import aims.common.Log;
import aims.common.SBSException;
import aims.common.StringUtility;
import aims.common.UserAccessRights;
import aims.service.PensionService;
import aims.service.SBSLoginService;
import aims.service.UserService;

public class SBSLoginServlet extends HttpServlet {

	Log log = new Log(LoginServlet.class);

	UserService userService = new UserService();

	PensionService ps = new PensionService();
	public void service(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
	if (request.getParameter("method") != null
				&& request.getParameter("method").equals("Sbsloginpage")) {
		RequestDispatcher rd = null;
		String username="",password="",path="",loginMode="",loginType="";
		username = request.getParameter("username");
		password = request.getParameter("password");
		if(request.getParameter("mode")!=null){
		loginMode = request.getParameter("mode");
		}
		if(loginMode.equals("M")){
			loginType="M";
		}
		LoginInfo user=null;
		System.out.println("Username:::::::::"+loginMode);
		try{
			if(!"".equals(StringUtility.checknull(username))&& !"".equals(StringUtility.checknull(password))){
		 user=SBSLoginService.getInstance().loginValidation(username,password,loginType);
		
		
		 if(user!=null){
			 if("M".equals(user.getProfile()) && user.getSbsOption().equals("Y")){					 
				 if(user.isPasswordChanged()){
					 path = "/PensionView/SBSMenu.jsp?mcd=OC";					 
				 }else{						 
					 path = "PensionLogin?method=changepassword&flag=checkusername";
				 }
			 }else{		
				 if(loginMode.equals("M")){
					 path = "/SBSLogin.jsp";
				 }else{
				 path = "/SbsIndex.jsp";
				 }
			 }
			 
			 
			 if(!"M".equals(user.getProfile())){
				 path = "/PensionView/SBSMenu.jsp?mcd=OC"; 
				 
			 }
			 HttpSession httpsession = request.getSession(false);
			 if(httpsession!=null){
				 
				 if(user.getProfile().equals("S")||user.getProfile().equals("C")){
					 user.setRegion("ALL-REGIONS") ;
				 }
				 
					if (user.getRegion() != null) {
					
						String[] reglist =user.getRegion().split(",");
						httpsession.setAttribute("region", reglist);
					}
					if(user.getUnitName()!=null){
						httpsession.setAttribute("station", user.getUnitName());
					}
				 
				 
					httpsession.setAttribute("usertype", user.getUserType());
					httpsession.setAttribute("userid", user.getUserName());
					httpsession.setAttribute("AnnuityOption", user.getEnableAnnuityOption());
					httpsession.setAttribute("profile", user.getProfile());
	            httpsession.setAttribute("user", user);
	            httpsession.setAttribute("gridlength", ""+user.getGridLength());
			 }
		 }else{
			 request.setAttribute("message","Invalid Username or Password");
			 if(loginMode.equals("M")){
				 path = "/SBSLogin.jsp";
			 }else{
			 path = "/SbsIndex.jsp";
			 }
		 }
			}else{
				if(loginMode.equals("M")){
					 path = "/SBSLogin.jsp";
				 }else{
				 path = "/SbsIndex.jsp";
				 }
			}
		
		
		}catch(InvalidDataException exp ){
			request.setAttribute("message",exp.getMessage());
		}catch(Exception exp ){
			request.setAttribute("message",exp.getMessage());
		}
		
		
		
		
		
		
		
		
		
		
		
		
			rd = request.getRequestDispatcher(path);
			rd.forward(request, response);
		
		
		/*
			HttpSession session = request.getSession();

			SearchInfo navSearchBean = new SearchInfo();
			
			
			String path = "";
			UserService ns = new UserService();
			String loginUserId="",username = "", password = "",computername="",userType ="",gridlength ="",region="",passwordChangeFlag="",airportcode="",privilages="",accountType="",userProfile="";	
			String dashBoardFlag="",userDesignation="";
			username = request.getParameter("username");
			password = request.getParameter("password");
			log.info("in login action username :" + username + " password :"
					+ password);
			
			path = "/SbsIndex.jsp";
			
			RequestDispatcher rd = null;
			
			UserBean ubean=new UserBean();
			computername = request.getRemoteAddr();
				try {
					ubean = ns.checkUser(username, password,computername);
					loginUserId=String.valueOf(ubean.getUserId());
					userType=ubean.getUserType();
					userDesignation=ubean.getDesignation();
					gridlength=ubean.getGridLength();				
					region=ubean.getRegion();	
					airportcode=ubean.getStationName();
					passwordChangeFlag=ubean.getPasswordChangeFlag();
					accountType=ubean.getUserAccType();
					privilages=ubean.getUserPrevilieges();
					userProfile=ubean.getUserProfile();
					dashBoardFlag=ubean.getDbFlag();
				if(userType!=null){
					if(userType.equals("SBSAdmin")||userType.equals("SBSHR")){
						path = "/PensionView/SBSMenu.jsp?mcd=OC";
					}else{
						path = "/PensionView/common/PensionErrorPage.jsp";
					}
					}
					
				    //path = "/PensionView/common/PensionCommon.jsp";
				
					session.setAttribute("gridlength", gridlength);
					if (region != null) {
						log.info("*****USER REGION*******" + region);
						String[] reglist = region.split(",");
						session.setAttribute("region", reglist);
					}
					if(airportcode!=null){
						session.setAttribute("station", airportcode);
					}
					if (userType != null) {
						session.setAttribute("usertype", userType);
					}
					
					session.setAttribute("passwordChangeFlag", passwordChangeFlag);
					session.setAttribute("privilages", privilages);
					session.setAttribute("accountType", accountType);
					session.setAttribute("profileType", userProfile);
					session.setAttribute("loginUserId", loginUserId);
					session.setAttribute("loginUsrRegion", region);
					session.setAttribute("loginUsrDesgn", userDesignation);
					
				} catch (InvalidDataException e) {
					// TODO Auto-generated catch block
					request.setAttribute("message",e.getMessage());
					System.out.println(e.getMessage());
				}
				request.setAttribute("DashBoardFlag",dashBoardFlag);
				request.setAttribute("usernames",username.trim());
				session.setAttribute("computername", computername);
				session.setAttribute("userid", username.trim());
				log.info("Username=============="+ubean.getUsername());
				session.setAttribute("userdata",ubean);
				session.setAttribute("userinfo", username.trim()+"-"+session.getId());
		
			log.info("path " + path);
			log.info("SbsLoginServlet : service() leaving method");
			
			
			rd = request.getRequestDispatcher(path);
			rd.forward(request, response);
		*/}else if (request.getParameter("method") != null
					&& request.getParameter("method").equals("logoff")) {
			HttpSession session = request.getSession();
				String userName = (String)session.getAttribute("userid");
				String profile = (String)session.getAttribute("profile");
				if (session != null) {
					request.getSession().removeAttribute("user"); 
					
					request.getSession().invalidate();
					request.getSession().setMaxInactiveInterval(0);
				}
				System.out.println("Prototcal"+request.getProtocol());;
				response.setHeader("Cache-Control", "no-cache, no-store");
				response.setHeader("Pragma", "no-cache"); 
				response.setDateHeader("Expires", 0); //prevents caching at the proxy server
				System.out.println("LoginServlet::logoof()--sessionId--"+session.getId()+request.isRequestedSessionIdFromCookie()+"ReuquesdValu"+request.isRequestedSessionIdValid());
				System.out.println("User "+userName+" Log Out Successfully");
				/*RequestDispatcher rd = request
						.getRequestDispatcher("./PensionView/PensionIndex.jsp");
				rd.forward(request, response);*/
				if(profile.equals("M")){
					response.sendRedirect("./SBSLogin.jsp");	
				}else{
				response.sendRedirect("./SbsIndex.jsp");
				}
			}else if (request.getParameter("method") != null
					&& request.getParameter("method").equals("changePassword")) {
				RequestDispatcher rd = null;
				String path="./SbsIndex.jsp";
				LoginInfo loginInfo=null;
				String username="",oldpass="",newpass="",confirmpass="";
				loginInfo=new LoginInfo();
				
				username=request.getParameter("username")!=null?request.getParameter("username"):"";
				oldpass=request.getParameter("oldpwd")!=null?request.getParameter("oldpwd"):"";
				newpass=request.getParameter("newpwd")!=null?request.getParameter("newpwd"):"";
				confirmpass=request.getParameter("confirmpwd")!=null?request.getParameter("confirmpwd"):"";
				loginInfo.setUserId(username);
				loginInfo.setOldPassword(oldpass);
				loginInfo.setNewPassword(newpass);
				loginInfo.setConfirmPassword(confirmpass);
				log.info("vdfsdfsdfsdf"+newpass);
				HttpSession session =request.getSession();
				String profile = (String)session.getAttribute("profile");
				
				if(profile.equals("M")){
					path="./SBSLogin.jsp";
				}else{
					path="./SbsIndex.jsp";
				}
				
				
				try {
					SBSLoginService.getInstance().changePassword(loginInfo);
				} catch (SBSException e) {
					log.info("exexexexe"+e.getMessage());
					path="PensionLogin?method=changepassword&flag=checkusername&errormsg="+e.getMessage();
					//request.setAttribute("errormsg", e.getMessage());
					e.printStackTrace();
				}
				rd = request.getRequestDispatcher(path);
				rd.forward(request, response);
			}else if (request.getParameter("method") != null
					&& request.getParameter("method").equals("forgotpassword")) {
				String userName=request.getParameter("user").toString();
				String doj=request.getParameter("doj").toString();
				String msg="";
				HttpSession session = request.getSession();
				try{
				msg=SBSLoginService.getInstance().forgotpassword(userName,doj);
				 session.setAttribute("msg",msg);
				}catch(Exception e){
					log.printStackTrace(e);
				}
				RequestDispatcher rd = request
						.getRequestDispatcher("./ForgotPassword.jsp");
				rd.forward(request, response);
			}
	}

	public void getAiirportName(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		ArrayList airportsList = new ArrayList();
		try {
			airportsList = userService.getAirports();
		} catch (Exception e) {
			log.printStackTrace(e);
		}
		request.setAttribute("AirportsList", airportsList);
		RequestDispatcher rd = request
				.getRequestDispatcher("./PensionView/NewUser.jsp");
		rd.forward(request, response);
	}

	public void getAiirportNames(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		ArrayList airportsList = new ArrayList();
		try {
			airportsList = userService.getAirports();
		} catch (Exception e) {
			log.printStackTrace(e);
		}
		request.setAttribute("AirportsList", airportsList);

	}

	public void getGroupUserNames(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		UserService ns = new UserService();
		SearchInfo searchBean1 = new SearchInfo();
		SearchInfo searchBean2 = new SearchInfo();
		try {
			SearchInfo getSearchIn = new SearchInfo();
			SearchInfo getSearchInfo = new SearchInfo();
			searchBean1 = ns.getGroupNames(getSearchIn);
			searchBean2 = ns.getExistingUserNames(getSearchInfo);
		} catch (Exception e) {
			System.out.println(e);
		}
		request.setAttribute("GroupList", searchBean1);
		request.setAttribute("UserList", searchBean2);
	}


}
