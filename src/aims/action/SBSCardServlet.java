package aims.action;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import aims.service.SBSCardService;

public class SBSCardServlet extends HttpServlet {
	SBSCardService service=new SBSCardService();
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		RequestDispatcher rd=null;
		
		String menu=request.getParameter("menu")!=null?request.getParameter("menu"):"";
		
		if(request.getParameter("method")!=null && request.getParameter("method").equals("SBSCard")){
			
			ArrayList list=new ArrayList();
			String pensionno=request.getParameter("empserialNO")!=null?request.getParameter("empserialNO"):"";
			String finYear=request.getParameter("finyear")!=null?request.getParameter("finyear"):"";
			String reportType=request.getParameter("frm_reportType")!=null?request.getParameter("frm_reportType"):"";
			String formType=request.getParameter("formType")!=null?request.getParameter("formType"):"";
			System.out.print("fm:"+formType);
			if(formType.equals("Employee Wise Total")){
			list = service.getEmployeeWiseTotal(pensionno,finYear);
			}else{
				list = service.getSBSCard(pensionno,finYear);
			}
		request.setAttribute("reportType", reportType);	
		request.setAttribute("empList", list);
		request.setAttribute("finyear", finYear);
		if(formType.equals("Employee Wise Total")){
			rd=request.getRequestDispatcher("./PensionView/sbscard/SBSReportCardEmpWiseTotal.jsp?menu="+menu);
		}else{
		rd=request.getRequestDispatcher("./PensionView/sbscard/SBSReportCard.jsp?menu="+menu);	
		
		}
		}
		rd.forward(request, response);
		
	}
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		this.doPost(request, response);
	}

}
