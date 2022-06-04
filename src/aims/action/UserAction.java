package aims.action;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;

import aims.bean.LoginInfo;
import aims.bean.SBSUserBean;
import aims.bean.UserBean;
import aims.dataTable.DataTableParameters;
import aims.service.SBSUserService;
import aims.service.UnitService;
import aims.service.UserService;

public class UserAction extends HttpServlet {

	protected void doGet(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		RequestDispatcher rd=null;
		
		if(req.getParameter("method")!=null && req.getParameter("method").equals("search")){
		
			
			try {
				HttpSession session = req.getSession();
				session.setAttribute("unitList",UnitService.getInstance().getUnitList());	
			} catch (Exception e) {
				e.printStackTrace();
			}
			
			rd=req.getRequestDispatcher("PensionView/SBS/UserSearch.jsp");
			rd.forward(req, resp);
		}else
		if(req.getParameter("method")!=null && req.getParameter("method").equals("searchResult")){
		
			
			try {
			
				SBSUserBean user = new SBSUserBean();
				user.setEmployeeId(req.getParameter("employeeId")!=null?req.getParameter("employeeId"):"");
				user.setUserName(req.getParameter("userName")!=null?req.getParameter("userName"):"");
				user.setUserType(req.getParameter("userType")!=null?req.getParameter("userType"):"");
				user.setProfileType(req.getParameter("profileType")!=null?req.getParameter("profileType"):"");
				user.setUnit(req.getParameter("unit")!=null?req.getParameter("unit"):"");
				user.setStatus(req.getParameter("status")!=null?req.getParameter("status"):"");			
				HttpSession session = req.getSession();
			//	LoginInfo info = (LoginInfo) session.getAttribute("loginUserId");
				
				req.setAttribute("userList",SBSUserService.getInstance().getUserList(user,"23259"));
				 DataTableParameters dataTableParam = new DataTableParameters();
	                // Set the list fetched in aaData
	                dataTableParam.setAaData(SBSUserService.getInstance().getUserList(user,"23259"));

	                Gson gson = new GsonBuilder().setPrettyPrinting().create();
	                // Convert Java Object to Json
	                String json = gson.toJson(dataTableParam);

	                resp.getWriter().print(json);
			} catch (Exception e) {
				
				e.printStackTrace();
			}
		}
	
		
	}
	
	protected void doPost(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		this.doGet(req, resp);
	}
}
