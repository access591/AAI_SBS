package aims.action;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import aims.bean.ActiveInactivBean;
import aims.bean.EmpMasterBean;
import aims.bean.PensionContBean;
import aims.common.CommonUtil;
import aims.common.InvalidDataException;
import aims.common.Log;
import aims.common.OptionCahngeProcess;
import aims.dao.AdjCrtnDAO;
import aims.dao.CommonDAO;
import aims.dao.FinancialReportDAO;
import aims.service.AdjCrtnService;
import aims.service.DashBoardService;
import aims.service.FinancialReportService;
import aims.service.FinancialService;
import aims.service.PensionService;
import aims.service.PersonalService;

public class ReportServlet2 extends HttpServlet {
	private static final int BYTES_DOWNLOAD = 1024;

	Log log = new Log(ReportServlet2.class);

	FinancialService financeService = new FinancialService();

	PersonalService personalService = new PersonalService();

	FinancialReportService finReportService = new FinancialReportService();

	PensionService pensionService = new PensionService();
	DashBoardService dbService = new DashBoardService();
	
	AdjCrtnService  adjCrtnService = new AdjCrtnService();
	CommonUtil commonUtil = new CommonUtil();

	CommonDAO commonDAO = new CommonDAO();
	
	AdjCrtnDAO adjCrtnDAO = new AdjCrtnDAO();
	
	FinancialReportDAO financeDAO = new FinancialReportDAO();

	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		
		
		HttpSession session = request.getSession();
		if (request.getParameter("method") != null
				&& request.getParameter("method").equals("getAirports")) {
			String region = "";
			region = request.getParameter("region");
			CommonUtil commonUtil = new CommonUtil();
			ArrayList ServiceType = null;
			ServiceType = commonUtil.getAirportsByFinanceTbl(region);
			StringBuffer sb = new StringBuffer();
			sb.append("<ServiceTypes>");

			for (int i = 0; ServiceType != null && i < ServiceType.size(); i++) {
				String name = "";
				EmpMasterBean bean = (EmpMasterBean) ServiceType.get(i);
				sb.append("<ServiceType>");
				sb.append("<airPortName>");
				if (bean.getStation() != null)
					name = bean.getStation().replaceAll("<", "&lt;")
							.replaceAll(">", "&gt;");
				sb.append(name);
				sb.append("</airPortName>");
				sb.append("</ServiceType>");
			}
			sb.append("</ServiceTypes>");
			response.setContentType("text/xml");
			PrintWriter out = response.getWriter();
			log.info(sb.toString());
			out.write(sb.toString());
		} else if (request.getParameter("method").equals(
				"optionrevisedmulitple")) {
			try {
				OptionCahngeProcess.runOptionchangeProcess();
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			request.setAttribute("message",
					"Option revised completed successfully");
			RequestDispatcher rd = null;
			rd = request.getRequestDispatcher("./PensionView/Message.jsp");
			rd.forward(request, response);
		} else if (request.getParameter("method").equals("loadfinalempscreen")) {
			log.info("finalpayment pending Screen");

			RequestDispatcher rd = null;
			rd = request
					.getRequestDispatcher("./PensionView/AAIFinalPaymentsProcessing.jsp");
			rd.forward(request, response);
		} else if (request.getParameter("method").equals("saveempscreen")) {
			log.info("finalpayment pending Screen");
			String pfidstrip = "", finanaceYear = "", empactivity = "N", deletedList = "";
			int count = 0, deletecount = 0;
			String message = "";
			if (request.getParameter("pfidstrips") != null) {
				pfidstrip = request.getParameter("pfidstrips");
			}
			if (request.getParameter("frm_financeyear") != null) {
				finanaceYear = request.getParameter("frm_financeyear");
			}
			if (request.getParameter("frm_active_flag") != null) {
				empactivity = request.getParameter("frm_active_flag");
			}
			if (request.getParameter("frm_deletedlist") != null) {
				deletedList = request.getParameter("frm_deletedlist");
			}
			log.info("servlet" + deletedList);
			if (!pfidstrip.equals("")) {
				count = finReportService.insertedDeactiveEmp(pfidstrip,
						finanaceYear);
			}
			if (!(deletedList.equals("") || deletedList.trim().equals(","))) {
				try {
					deletecount = finReportService.deleteDeactiveEmp(
							deletedList, finanaceYear);
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}

			message = "Total " + count + " are updated for " + finanaceYear;
			message = message + " " + "Total  " + deletecount
					+ "re deleted for" + finanaceYear;
			request.setAttribute("finanaceYear", finanaceYear);
			request.setAttribute("empactivity", empactivity);
			request.setAttribute("message", message);
			RequestDispatcher rd = null;
			rd = request
					.getRequestDispatcher("./PensionView/AAIFinalPaymentsProcessing.jsp");
			rd.forward(request, response);
		} else if (request.getParameter("method").equals("finalempscreen")) {
			log.info("finalpayment pending Screen");
			ActiveInactivBean activeList = new ActiveInactivBean();
			String finanaceYear = "", empactivity = "N", chkedList = "";
			if (request.getParameter("frm_financeyear") != null) {
				finanaceYear = request.getParameter("frm_financeyear");
			}
			if (request.getParameter("frm_active_flag") != null) {
				empactivity = request.getParameter("frm_active_flag");
			}
			List list = new ArrayList();
			activeList = finReportService.getFinalPaymentPendingReport(
					empactivity, finanaceYear);
			list = activeList.getActivInativeList();
			chkedList = activeList.getChecklist();
			request.setAttribute("emplist", list);

			request.setAttribute("chkedList", chkedList);
			request.setAttribute("finanaceYear", finanaceYear);
			request.setAttribute("empactivity", empactivity);
			RequestDispatcher rd = null;
			rd = request
					.getRequestDispatcher("./PensionView/AAIFinalPaymentsProcessing.jsp");
			rd.forward(request, response);
		} else if (request.getParameter("method")
				.equals("finalpaymentspending")) {
			log.info("finalpayment pending calling");
			String finanaceYear = "", empactivity = "N", checklistPfdis = "";
			ActiveInactivBean activeInactiveBean = new ActiveInactivBean();
			if (request.getParameter("frm_financeyear") != null) {
				finanaceYear = request.getParameter("frm_financeyear");
			}
			if (request.getParameter("frm_active_flag") != null) {
				empactivity = request.getParameter("frm_active_flag");
			}
			log.info("finalpaymentspending::finanaceYear" + finanaceYear);
			List list = new ArrayList();
			activeInactiveBean = finReportService.getFinalPaymentPendingReport(
					empactivity, finanaceYear);
			list = activeInactiveBean.getActivInativeList();
			checklistPfdis = activeInactiveBean.getChecklist();
			request.setAttribute("paymentlist", list);
			request.setAttribute("reportType", "");
			RequestDispatcher rd = null;
			rd = request
					.getRequestDispatcher("./PensionView/AAIFinalPaymentsPending.jsp");
			rd.forward(request, response);
		}
		else
		 if (request.getParameter("method").equals("retirementEmployeesFullInfo"))
	
		 {
			 Map yearMap = new LinkedHashMap();
				Map monthMap = new LinkedHashMap();
				Iterator yearIterator = null;
				Iterator monthIterator = null;
				Iterator monthIterator1 = null;
				ArrayList penYearList = new ArrayList();
				
				
				monthMap = commonUtil.getMonthsList();
				Set monthset = monthMap.entrySet();
				monthIterator = monthset.iterator();
				monthIterator1 = monthset.iterator();
				ArrayList pfidList = new ArrayList();
				
				request.setAttribute("monthIterator", monthIterator);
				request.setAttribute("monthToIterator", monthIterator1);
				HashMap regionHashmap = new HashMap();
		
				if (request.getParameter("method").equals("retirementEmployeesFullInfo"))	
						 {
					String[] regionLst = null;
					String rgnName = "";
					if (session.getAttribute("region") != null) {
						regionLst = (String[]) session.getAttribute("region");
					}
					log.info("Regions List" + regionLst.length);
					for (int i = 0; i < regionLst.length; i++) {
						rgnName = regionLst[i];
						log.info("rgnName==================" + rgnName);
						if (rgnName.equals("ALL-REGIONS")
								&& session.getAttribute("usertype").toString()
										.equals("Admin")) {
							regionHashmap = new HashMap();
							regionHashmap = commonUtil.getRegion();
							break;
						} else {
							regionHashmap.put(new Integer(i), rgnName);
						}

					}
				} 
				else {
					regionHashmap = commonUtil.getRegion();

				}
				
				request.setAttribute("regionHashmap", regionHashmap);
				RequestDispatcher rd = null;
				
				if (request.getParameter("method").equals(
				"retirementEmployeesFullInfo")) {
					//log.info("AAAAAAAAAAAAAAAAAAAAAAAA"  );
					
					rd = request
					.getRequestDispatcher("./PensionView/RetirementEmployeesFullInfoInputParams.jsp");
					
					//log.info(" BBBBBBBBBBBBBBBBBBBBBBBBBB==================" );
				}	
				rd.forward(request, response);
		 }
				
			
				
				//	----------------------------venkatesh-----------------------------------------------------------
				
		 else if (request.getParameter("method").equals("retirementEmployeesFullReport")) {
				 
			//	 log.info("retirementEmployeesFullInfo venkatesh==================CCCCCCCCCCCCCCCCCCCCCC" );
				 
					String region = "", year = "", month = "" ;
					String  reportType = "", airportcode = "";

					if (request.getParameter("frm_year") != null) {
						year = request.getParameter("frm_year");
					}

					if (request.getParameter("frm_month") != null) {
						month = request.getParameter("frm_month");
					}
					if (request.getParameter("frm_region") != null) {
						region = request.getParameter("frm_region");
					}

					if (request.getParameter("frm_reportType") != null) {
						reportType = request.getParameter("frm_reportType");
					}
					
					if (request.getParameter("frm_airportcd") != null) {
						airportcode = request.getParameter("frm_airportcd");
					}
					if (airportcode.equals("[Select One]")) {
						airportcode = "";
					} else if (airportcode.equals("NO-SELECT")) {
						airportcode = "";
					}
					if (region.equals("[Select One]")) {
						region = "";
					} else if (region.equals("NO-SELECT")) {
						region = "";
					}
					
					
					String monthYear = "";
					String monthYear1 = "";
						
						
							if(!month.equals("NO-SELECT")){	
								monthYear = "02-"+month + "-" + year;
								monthYear1 = "02-"+month + "-" + year;
							}else{
								monthYear = "02-01-" + year;
								monthYear1 = "02-12-" + year;
							}
								try {
									monthYear=	commonUtil.converDBToAppFormat(monthYear,
											"dd-MM-yyyy", "dd-MMM-yyyy");
									monthYear1=	commonUtil.converDBToAppFormat(monthYear1,
											"dd-MM-yyyy", "dd-MMM-yyyy");
								} catch (InvalidDataException e1) {
									// TODO Auto-generated catch block
									e1.printStackTrace();
								}
								
					ArrayList retdList = new ArrayList();
					try{
					retdList = finReportService.retdListReportByFullPFID(monthYear,monthYear1,region, airportcode );
					log.info("selectedDate=================" + monthYear);
					}catch(Exception e){
						e.printStackTrace();
					}
					
					request.setAttribute("displayDate", monthYear);
				
					
					request.setAttribute("reportType", reportType);
					request.setAttribute("region", region);
					request.setAttribute("airportCode", airportcode);
					request.setAttribute("retdList", retdList);
					
					RequestDispatcher rd = null;
					rd = request
							.getRequestDispatcher("./PensionView/RetirementFullEmployeesInfo.jsp");
					 log.info("===DDDDDDDDDDDDDDDDDDD" );
					
					rd.forward(request, response);
				}
			
				
				
				
		 }
	
				
public PensionContBean copyToBean(EmpMasterBean empBean,PensionContBean pBean){
		
		pBean.setEmpSerialNo(empBean.getEmpSerialNo());
		pBean.setEmpCpfaccno(empBean.getCpfAcNo());
		pBean.setEmployeeNO(empBean.getEmpNumber());
		pBean.setEmployeeNM(empBean.getEmpName());
		pBean.setDesignation(empBean.getDesegnation());
		pBean.setEmpDOB(empBean.getDateofBirth());
		pBean.setEmpDOJ(empBean.getDateofJoining());
		pBean.setFhName(empBean.getFhName());
		return pBean;
		
	}
	protected void doGet(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		this.doPost(request, response);
	}

}
