package aims.action;

import java.io.DataInputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.LinkedHashMap;
import java.util.Map;
import java.util.ResourceBundle;
import java.util.Set;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import aims.bean.DatabaseBean;
import aims.bean.EmpMasterBean;
import aims.bean.EmployeeAdlPensionInfo;
import aims.bean.EmployeeFreshOptionBean;
import aims.bean.EmployeePersonalInfo;
import aims.bean.FinacialDataBean;
import aims.bean.LoginInfo;
import aims.bean.NomineeBean;
import aims.bean.NomineeForm2Info;
import aims.bean.PensionBean;
import aims.bean.RPFCForm9Bean;
import aims.bean.SearchInfo;
import aims.common.CommonUtil;
import aims.common.InvalidDataException;
import aims.common.Log;
import aims.dao.CommonDAO;
import aims.service.AdjCrtnService;
import aims.service.FinancialReportService;
import aims.service.FinancialService;
import aims.service.PensionService;
import aims.service.PersonalService;
import aims.service.SBSFinancialReportService;

public class SBSSearchServlet extends HttpServlet {

	Log log = new Log(SearchPensionMasterServlet.class);
	FinancialService financeService = new FinancialService();

	PersonalService personalService = new PersonalService();
	FinancialReportService finReportService = new FinancialReportService();
	SBSFinancialReportService SBSfinReportService = new SBSFinancialReportService();
	PensionService pensionService = new PensionService();
	AdjCrtnService adjCrtnService = new AdjCrtnService();
	CommonDAO commonDAO = new CommonDAO();

	protected void doPost(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		PensionService ps = new PensionService();
		FinancialService fs = new FinancialService();
		CommonUtil commonUtil = new CommonUtil();
		HttpSession session = request.getSession();
		PersonalService personalService = new PersonalService();
		int gridLength =10;
		if (session.getAttribute("gridlength") != null) {
		
			gridLength=Integer.parseInt((String) session
				.getAttribute("gridlength"));
		}

		if (request.getParameter("method").equals("loadPerMstr")) {
			ArrayList regionList = new ArrayList();
			String rgnName = "";
			HashMap map = new HashMap();
			String[] regionLst = null;
			if (session.getAttribute("region") != null) {
				regionLst = (String[]) session.getAttribute("region");
			}
			log.info("Regions List" + regionLst.length);
			for (int i = 0; i < regionLst.length; i++) {
				rgnName = regionLst[i];
				if (rgnName.equals("ALL-REGIONS")
						&& session.getAttribute("usertype").toString().equals(
								"SBSUser")) {
					map = new HashMap();
					map = commonUtil.getRegion();
					break;
				} else {
					map.put(new Integer(i), rgnName);
				}

			}

			request.setAttribute("regionHashmap", map);
			RequestDispatcher rd = null;
			String menu=request.getParameter("menu")!=null?request.getParameter("menu"):"";
			if (request.getParameter("method").equals("loadPerMstr")) {
				rd = request
						.getRequestDispatcher("./PensionView/SBS/SBSMaster.jsp?menu="+menu);
			}
			rd.forward(request, response);
		} else if (request.getParameter("method") != null
				&& request.getParameter("method").equals("searchPersonal")) {

			System.out.println("Enter in to method======================");
			String rgnName = "", sortingColumn = "", page = "";
			HashMap map = new HashMap();
			String[] regionLst = null;
			EmployeePersonalInfo empBean = new EmployeePersonalInfo();
			if (request.getParameter("airPortCode") != null) {
				empBean.setAirportCode(request.getParameter("airPortCode")
						.toString().trim());
				if (empBean.getAirportCode().equals("NO-SELECT")) {
					empBean.setAirportCode("");
				}
			}
			if (request.getParameter("empName") != null) {
				empBean.setEmployeeName(request.getParameter("empName")
						.toString().trim());
			}
			if (request.getParameter("frm_sortingColumn") != null) {
				sortingColumn = request.getParameter("frm_sortingColumn");
			}
			log
					.info("pensionno"
							+ request.getParameter("pensionNO").toString());
			if (request.getParameter("pensionNO") != null) {
				empBean.setPensionNo(commonUtil.getSearchPFID(request
						.getParameter("pensionNO").toString().trim()));
			} else {
				empBean.setPensionNo("");
			}
			log.info("pensionno " + empBean.getPensionNo());
			if (request.getParameter("page") != null) {
				page = request.getParameter("page").toString();
			}
			if (request.getParameter("frm_dateOfBirth") != null
					|| request.getParameter("frm_dateOfBirth") != "") {
				empBean.setDateOfBirth(request.getParameter("frm_dateOfBirth")
						.toString().trim());
			} else {
				empBean.setDateOfBirth("");
			}
			log.info("Date Of Birth====" + empBean.getDateOfBirth());
			if (request.getParameter("region") != null) {
				empBean.setRegion(request.getParameter("region").toString()
						.trim());
				if (empBean.getRegion().equals("NO-SELECT")) {
					empBean.setRegion("");
				}
			} else {
				empBean.setRegion("");
			}
			if (request.getParameter("doj") != null) {
				empBean.setDateOfJoining(request.getParameter("doj").toString()
						.trim());
			} else {
				empBean.setDateOfJoining("");
			}
			if (request.getParameter("cpfaccno") != null) {
				empBean.setCpfAccno(request.getParameter("cpfaccno").toString()
						.trim());
			} else {
				empBean.setCpfAccno("");
			}
			if (request.getParameter("employeeNo") != null) {
				empBean.setEmployeeNumber(request.getParameter("employeeNo")
						.toString().trim());
			} else {
				empBean.setEmployeeNumber("");
			}

			if (request.getParameter("uan") != null) {
				empBean.setUanno(request.getParameter("uan").toString().trim());
			} else {
				empBean.setUanno("");
			}

			if (request.getParameter("sbsflag") != null) {
				empBean.setSbsflag(request.getParameter("sbsflag").toString()
						.trim());
			} else {
				empBean.setSbsflag("");
			}

			// code added for empname blanks search
			SearchInfo getSearchInfo = new SearchInfo();
			SearchInfo searchBean = new SearchInfo();
			boolean flag = true;
			try {

				searchBean = personalService.searchPersonalMaster(empBean,
						getSearchInfo, flag, gridLength, sortingColumn, "");
			} catch (Exception e) {
				log.printStackTrace(e);
			}
			if (session.getAttribute("region") != null) {
				regionLst = (String[]) session.getAttribute("region");
			}
			for (int i = 0; i < regionLst.length; i++) {
				rgnName = regionLst[i];
				if (rgnName.equals("ALL-REGIONS")
						&& session.getAttribute("usertype").toString().equals(
								"Admin")) {
					map = new HashMap();
					map = commonUtil.getRegion();
					break;
				} else {
					map.put(new Integer(i), rgnName);
				}

			}
			request.setAttribute("regionHashmap", map);
			request.setAttribute("searchBean", searchBean);
			request.setAttribute("searchInfo", empBean);
			if (page != "") {

				System.out.println("page1================>" + page);

				RequestDispatcher rd = request
						.getRequestDispatcher("./PensionView/EmpPfcardEdit.jsp");
				rd.forward(request, response);
			} else {

				System.out.println("page2--------------------->" + page);

				RequestDispatcher rd = request
						.getRequestDispatcher("./PensionView/SBS/SBSMaster.jsp?menu=M1L1");
				rd.forward(request, response);
			}

		} else if (request.getParameter("method") != null
				&& request.getParameter("method").equals("personalEdit")) {

			String empName = "", empCode = "", region = "";
			String editFrom = "";
			String empSerailNumber1 = "", dateofbirth1 = "", dob1 = "", view = "";
			String employeeSearchName = "";
			String arrearInfo = "", cpfacno = "";
			String pfid = "";
			pfid = request.getParameter("pfid").toString();
			cpfacno = request.getParameter("cpfacno").trim();
			String startIndex = "", totalData = "";
			startIndex = request.getParameter("startIndex");
			totalData = request.getParameter("totalData");
			if (request.getParameter("view") != null) {
				view = request.getParameter("view");
			}
			if (request.getParameter("arrearInfo") != null) {
				arrearInfo = request.getParameter("arrearInfo").toString();
			} else {
				arrearInfo = "";
			}
			if (request.getParameter("empSerailNumber") != null) {
				empSerailNumber1 = request.getParameter("empSerailNumber");
				session.setAttribute("empSerailNumber1", empSerailNumber1);
			}
			if (request.getParameter("dateofbirth") != null) {
				dateofbirth1 = request.getParameter("dateofbirth");
				session.setAttribute("dateofbirth1", dateofbirth1);
			}
			if (request.getParameter("empName") != null) {
				employeeSearchName = request.getParameter("empName");
				session.setAttribute("employeeSearchName", employeeSearchName);
			}
			if (request.getParameter("dob1") != null) {
				dob1 = request.getParameter("dob1");
				session.setAttribute("dob1", dob1);
			}
			if (session.getAttribute("empBean1") != null) {
				log.info("session " + session.getAttribute("empBean1"));
			}
			if (request.getParameter("name") != null) {
				empName = request.getParameter("name");
			}
			if (request.getParameter("empCode") != null) {
				empCode = request.getParameter("empCode");
			}
			if (request.getParameter("region") != null) {
				region = request.getParameter("region").trim();
			}
			if (request.getParameter("editFrom") != null) {
				editFrom = request.getParameter("editFrom");
			}

			boolean flag;
			if (request.getParameter("flag") != null
					&& request.getParameter("flag").equals("invflag")) {
				flag = false;

			} else {
				flag = true;
			}
			if (request.getParameter("recordExist") != null) {
				request.setAttribute("recordExist", request.getParameter(
						"recordExist").toString());
			}
			ArrayList airportList = new ArrayList();
			ArrayList departmentList = new ArrayList();
			EmpMasterBean editBean = new EmpMasterBean();
			try {
				editBean = personalService.empPersonalEdit(cpfacno, empName,
						flag, empCode, region.trim(), pfid);

				airportList = commonUtil.getAirports(region);
				departmentList = ps.getDepartmentList();
			} catch (Exception e) {
				System.out.println(e.getMessage());
			}
			request.setAttribute("EditBean", editBean);
			request.setAttribute("AirportList", airportList);
			request.setAttribute("DepartmentList", departmentList);
			request.setAttribute("flag", Boolean.toString(flag));
			request.setAttribute("startIndex", startIndex);
			request.setAttribute("TotalData", totalData);
			request.setAttribute("editFrom", editFrom);
			request.setAttribute("ArrearInfo", arrearInfo);
			if (!view.equals("true")) {
				RequestDispatcher rd = request
						.getRequestDispatcher("./PensionView/personal/EmployeePersonalMasterEditRevised.jsp");
				rd.forward(request, response);
			} else {
				RequestDispatcher rd = request
						.getRequestDispatcher("./PensionView/SBS/SBSEmployeePersonalMasterView.jsp?menu=M1L1");
				rd.forward(request, response);

			}

		} else if (request.getParameter("method") != null
				&& request.getParameter("method").equals("sbspersonalnav")) {
			String navgationBtn = "";
			String rgnName = "", sortingColumn = "";
			HashMap map = new HashMap();
			String[] regionLst = null;
			SearchInfo navSearchBean = new SearchInfo();
			int strtIndex = 0, totalRecords = 0;
			SearchInfo searchListBean = new SearchInfo();
			EmployeePersonalInfo personalInfo = new EmployeePersonalInfo();

			if (request.getParameter("frm_sortingColumn") != null) {
				sortingColumn = request.getParameter("frm_sortingColumn");
			}
			if (request.getParameter("navButton") != null) {
				navgationBtn = request.getParameter("navButton").toString();
				searchListBean.setNavButton(navgationBtn);
				session.setAttribute("navButton", navgationBtn);
			} else {
				navgationBtn = (String) session.getAttribute("navButton");
				searchListBean.setNavButton(navgationBtn);
			}

			if (request.getParameter("strtindx") != null) {

				strtIndex = Integer.parseInt(request.getParameter("strtindx")
						.toString());
				System.out.println("strtIndex" + strtIndex);
				searchListBean.setStartIndex(strtIndex);
			}
			if (request.getParameter("total") != null) {
				totalRecords = Integer.parseInt(request.getParameter("total")
						.toString());
				searchListBean.setTotalRecords(totalRecords);
			}
			if (session.getAttribute("getSearchBean1") != null) {
				personalInfo = (EmployeePersonalInfo) session
						.getAttribute("getSearchBean1");
			}
			try {
				navSearchBean = personalService.navigationPersonalData(
						personalInfo, searchListBean, gridLength,
						sortingColumn, "");
			} catch (Exception e) {
				log.printStackTrace(e);
			}
			if (session.getAttribute("region") != null) {
				regionLst = (String[]) session.getAttribute("region");
			}
			log.info("Regions List" + regionLst.length);
			for (int i = 0; i < regionLst.length; i++) {
				rgnName = regionLst[i];
				if (rgnName.equals("ALL-REGIONS")
						&& session.getAttribute("usertype").toString().equals(
								"Admin")) {
					map = new HashMap();
					map = commonUtil.getRegion();
					break;
				} else {
					map.put(new Integer(i), rgnName);
				}

			}
			request.setAttribute("regionHashmap", map);
			request.setAttribute("searchBean", navSearchBean);
			request.setAttribute("searchInfo", personalInfo);
			RequestDispatcher rd = null;
			rd = request
					.getRequestDispatcher("./PensionView/SBS/SBSMaster.jsp");
			rd.forward(request, response);
		}

		else if (request.getParameter("method") != null
				&& request.getParameter("method")
						.equals("SBSpersonalEmpReport")) {
			EmployeePersonalInfo personal = new EmployeePersonalInfo();
			ArrayList personalReportList = new ArrayList();
			String reportType = "", region = "", sortingColumn = "";
			if (session.getAttribute("getSearchBean1") != null) {
				personal = (EmployeePersonalInfo) session
						.getAttribute("getSearchBean1");
			}
			if (request.getParameter("reportType") != null) {
				reportType = request.getParameter("reportType");
			}
			if (!personal.getRegion().equals("")) {
				if (personal.getRegion().equals("NO-SELECT")) {
					region = "All Regions";
				} else {
					region = personal.getRegion();
				}
			}
			if (request.getParameter("frm_sortcolumn") != null) {
				sortingColumn = request.getParameter("frm_sortcolumn");
			}
			personalReportList = personalService.personalReport(personal,
					sortingColumn, reportType);
			request.setAttribute("reportList", personalReportList);
			request.setAttribute("reportType", reportType);
			request.setAttribute("region", region);
			RequestDispatcher rd = null;
			if (reportType.equals("DBF")) {
				rd = request
						.getRequestDispatcher("./PensionView/SBS/SBSEmployeePersonalInfoReportDBF.jsp");
			} else {
				rd = request
						.getRequestDispatcher("./PensionView/SBS/SBSEmployeePersonalInfoReport.jsp");
			}
			rd.forward(request, response);
		}

		else if ( request.getParameter("method").equals("sbsloadFinContri")
				|| request.getParameter("method").equals("loadSBSCard")
				) {
			Map yearMap = new LinkedHashMap();
			Map monthMap = new LinkedHashMap();
			Iterator yearIterator = null;
			Iterator monthIterator = null;
			Iterator monthIterator1 = null;
			ArrayList penYearList = new ArrayList();
			ArrayList pfidList = new ArrayList();
			/*
			 * yearMap=financeService.getPensionYearList(); Set yearSet =
			 * yearMap.entrySet(); yearIterator = yearSet.iterator();
			 */

			if (request.getParameter("method").equals("sbsloadFinContri")
					|| request.getParameter("method").equals("loadSBSCard")) {
				penYearList = finReportService.getFinanceYearList();
				request.setAttribute("yearList", penYearList);
			} else {
				request.setAttribute("yearIterator", yearIterator);

			}
			monthMap = commonUtil.getMonthsList();
			Set monthset = monthMap.entrySet();
			monthIterator = monthset.iterator();
			monthIterator1 = monthset.iterator();
			request.setAttribute("monthIterator", monthIterator);
			request.setAttribute("monthToIterator", monthIterator1);
			HashMap regionHashmap = new HashMap();

			if (request.getParameter("method").equals("loadForm6Cmp")) {
				regionHashmap = commonUtil.getRegion();
			} else {
				if (request.getParameter("method").equals(
								"sbsloadFinContri")
						|| request.getParameter("method").equals(
								"loadSBSCard")
						) {
					String[] regionLst = null;
					String rgnName = "";
					if (session.getAttribute("region") != null) {
						regionLst = (String[]) session.getAttribute("region");
					}
					LoginInfo user=(LoginInfo)session.getAttribute("user"); 
					//log.info("Regions List" + regionLst.length);
					if(!user.getProfile().equals("M")){
					for (int i = 0; i < regionLst.length; i++) {
						rgnName = regionLst[i];
						log.info("rgnName==================" + rgnName);
						if (rgnName.equals("ALL-REGIONS")
								&& (session.getAttribute("usertype").toString()
										.equals("Admin") ||session.getAttribute("usertype").toString()
										.equals("SBSUser"))) {
							regionHashmap = new HashMap();
							regionHashmap = commonUtil.getRegion();
							break;
						} else {
							regionHashmap.put(new Integer(i), rgnName);
						}

					}
					}
				} else {
					regionHashmap = commonUtil.getRegion();

				}

			}

			if (request.getParameter("method").equals("loadform8params")) {
				int pereachpage = 0;
				ResourceBundle bundle = ResourceBundle
						.getBundle("aims.resource.ApplicationResouces");
				int totalSize = 0;
				if (bundle.getString("common.pension.pagesize") != null) {
					totalSize = Integer.parseInt(bundle
							.getString("common.pension.pagesize"));
				} else {
					totalSize = 100;
				}
				pereachpage = commonDAO.getPFIDsNaviagtionListSize(totalSize);
				log.info("pereachpage==========" + pereachpage);
				int startIndex = 1, endIndex = totalSize;
				for (int i = 0; i < pereachpage; i++) {
					String name = "";
					if (i != 0) {
						startIndex = startIndex + totalSize;
						endIndex = endIndex + totalSize;
					}
					if (i == pereachpage - 1) {
						name = Integer.toString(startIndex) + " - END";
					} else {
						name = Integer.toString(startIndex) + " - "
								+ Integer.toString(endIndex);
					}
					pfidList.add(name);
				}
			}
			request.setAttribute("regionHashmap", regionHashmap);
			RequestDispatcher rd = null;
			if (request.getParameter("method").equals("loadform3")) {
				rd = request
						.getRequestDispatcher("./PensionView/PensionForm3ReportInputParms.jsp");
			} else if (request.getParameter("method").equals("loadform3params")) {
				rd = request
						.getRequestDispatcher("./PensionView/Form3ReportInputParms.jsp");

			} else if (request.getParameter("method").equals("loadpcsummary")) {
				rd = request
						.getRequestDispatcher("./PensionView/pcsummary/PCReportInputParms.jsp");
			} else if (request.getParameter("method").equals("loadform8params")) {
				request.setAttribute("pfidList", pfidList);
				String frmName = "", empSerialNo = "", empName = "", accessCode = "", rptformType = "";
				if (request.getParameter("frmName") != null) {
					frmName = request.getParameter("frmName");
				} else {
					frmName = "";
				}

				if (request.getParameter("employeeNo") != null) {
					empSerialNo = request.getParameter("employeeNo");
				} else {
					empSerialNo = "";
				}
				if (request.getParameter("empName") != null) {
					empName = request.getParameter("empName");
				} else {
					empName = "";
				}

				if (request.getParameter("accessCode") != null) {
					accessCode = request.getParameter("accessCode");
				}
				if (request.getParameter("form_type") != null) {
					rptformType = request.getParameter("form_type");
				} else {
					rptformType = "---";
				}

				if (empName.equals("")) {
					// empName= commonDAO.getEmployeeName(employeeNo);
					ArrayList empList = new ArrayList();
					try {
						PensionBean bean = new PensionBean();
						empList = pensionService.getEmployeeMappedList("", "",
								"", empSerialNo, "");
						for (int i = 0; i < empList.size(); i++) {
							bean = (PensionBean) empList.get(i);
						}
						empName = bean.getEmployeeName();
					} catch (Exception e) {
						// TODO Auto-generated catch block
						e.printStackTrace();
					}
				}

				request.setAttribute("rptformType", rptformType);
				request.setAttribute("empSerialNo", empSerialNo);
				request.setAttribute("empName", empName);
				request.setAttribute("frmName", frmName);
				request.setAttribute("accessCode", accessCode);
				rd = request
						.getRequestDispatcher("./PensionView/Form8ReportInputParms.jsp");
			} else if (request.getParameter("method").equals("loaduserforms")) {
				rd = request
						.getRequestDispatcher("./PensionView/FormReportInputParmsUser.jsp");
			} else if (request.getParameter("method").equals(
					"loadpersonalreport")) {
				rd = request
						.getRequestDispatcher("./PensionView/PersonalReportInputParams.jsp");
			} else if (request.getParameter("method").equals("loadob")) {
				if (request.getParameter("message") != null) {
					request.setAttribute("success", request
							.getParameter("message"));
				}
				rd = request
						.getRequestDispatcher("./PensionView/OBPFCardInputParms.jsp");

			} else if (request.getParameter("method").equals("loadUpdatePC")) {
				if (request.getParameter("message") != null) {
					request.setAttribute("success", request
							.getParameter("message"));
				}
				rd = request
						.getRequestDispatcher("./PensionView/UpdatePCInputParams.jsp");
			} else if (request.getParameter("method")
					.equals("sbsloadFinContri")) {				
				String menu=request.getParameter("menu")!=null?request.getParameter("menu"):"";
				rd = request
						.getRequestDispatcher("./PensionView/SBS/SBSPensionContributionInputParams.jsp?menu="+menu);
			} else if (request.getParameter("method")
					.equals("loadSBSCard")) {
				rd = request
						.getRequestDispatcher("./PensionView/sbscard/SBSCardInputParams.jsp");
			} 
			rd.forward(request, response);
		} else if (request.getParameter("method") != null
				&& request.getParameter("method")
						.equals("SBSgetPFCardAirports")) {
			String region = "", stationName = "";
			region = request.getParameter("region");
			ArrayList ServiceType = null;
			System.out.println("111111111111");
			if (session.getAttribute("station") != null) {
				stationName = (String) session.getAttribute("station");
				System.out.println("22222222" + stationName);

			}
			if (!stationName.equals("")) {
				ServiceType = new ArrayList();
				EmpMasterBean masterBean = new EmpMasterBean();
				masterBean.setStation(stationName);
				ServiceType.add(masterBean);
			} else {
				ServiceType = commonDAO.getAirportsByBulkPFIDSTbl(region);
			}
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

		}

		else if (request.getParameter("method") != null
				&& request.getParameter("method").equals(
						"SBSgetPFIDBulkPrintingList")) {
			String region = "", monthYear = "", airportcode = "", lastmonthFlag = "", month = "", fromYear = "", toYear = "", year = "";
			int totalSize = 0;
			ArrayList rangeList = new ArrayList();
			if (request.getParameter("frm_region") != null) {
				region = request.getParameter("frm_region");
			}
			if (request.getParameter("frm_airportcode") != null) {
				airportcode = request.getParameter("frm_airportcode");
			}

			if (request.getParameter("frm_ltstmonthflag") != null) {
				lastmonthFlag = request.getParameter("frm_ltstmonthflag");
			}
			if (request.getParameter("frm_month") != null) {
				month = request.getParameter("frm_month");
			}
			if (request.getParameter("frm_year") != null) {
				year = request.getParameter("frm_year");
			} else {
				year = "2008";
			}
			if (request.getParameter("frm_pagesize") != null) {
				totalSize = Integer.parseInt(request
						.getParameter("frm_pagesize"));
			} else {
				totalSize = 100;
			}
			if (year.indexOf("-") != -1) {
				String[] sltedYear = year.split("-");
				if (sltedYear.length == 2) {
					fromYear = sltedYear[0];
					toYear = Integer.toString(Integer.parseInt(fromYear) + 1);
				}
			} else {
				fromYear = year;
				toYear = Integer.toString(Integer.parseInt(fromYear) + 1);
			}
			String finyear = fromYear + "-" + toYear;
			/*
			 * String[] sltedYear = year.split("-"); if (sltedYear.length == 2)
			 * { fromYear = sltedYear[0]; toYear = sltedYear[1]; String
			 * prefixFrmYear = fromYear.substring(0, 2); if
			 * (prefixFrmYear.equals("19") &&
			 * Integer.parseInt(fromYear.substring(0, 2)) -
			 * Integer.parseInt(toYear) == 1) { toYear = prefixFrmYear + toYear;
			 * } else { toYear = "20" + toYear; }
			 * log.info("==getPFIDListWthoutTrnFlag=region=" + region +
			 * "airportcode===" + airportcode + "lastmonthFlag" + lastmonthFlag
			 * + "month" + month + "year" + year);
			 * log.info("==getPFIDListWthoutTrnFlag=fromYear=" + fromYear +
			 * "toYear===" + toYear); } else { fromYear = sltedYear[0]; toYear =
			 * Integer.toString(Integer.parseInt(fromYear) + 1); } if
			 * (!month.equals("NO-SELECT")) { if (Integer.parseInt(month) >= 4
			 * && Integer.parseInt(month) <= 12) { monthYear = "-" + month + "-"
			 * + fromYear; } else if (Integer.parseInt(month) >= 1 &&
			 * Integer.parseInt(month) <= 3) { monthYear = "-" + month + "-" +
			 * toYear; } } else { monthYear =
			 * commonDAO.getLatestTrnsDate(region); }
			 */
			log.info("==getPFIDListWthoutTrnFlag=fromYear=" + fromYear
					+ "toYear===" + toYear);
			ArrayList ServiceType = null;
			ResourceBundle bundle = ResourceBundle
					.getBundle("aims.resource.ApplicationResouces");
			rangeList = commonDAO.bulkNavgtionPFIDsList(region, airportcode,
					Integer.toString(totalSize), monthYear, lastmonthFlag,
					finyear);

			log.info("getPFIDListWthoutTrnFlag::Total List Size "
					+ rangeList.size());
			StringBuffer sb = new StringBuffer();
			sb.append("<ServiceTypes>");
			String rangeString = "";
			for (int i = 0; i < rangeList.size(); i++) {
				rangeString = (String) rangeList.get(i);
				sb.append("<ServiceType>");
				sb.append("<airPortName>");
				sb.append(rangeString);
				sb.append("</airPortName>");
				sb.append("</ServiceType>");
			}
			sb.append("<PARAMSTR>");
			sb.append("<PARAM1>");
			sb.append(monthYear);
			sb.append("</PARAM1>");
			sb.append("</PARAMSTR>");
			sb.append("</ServiceTypes>");
			response.setContentType("text/xml");
			PrintWriter out = response.getWriter();
			out.write(sb.toString());

		} else if (request.getParameter("method")
				.equals("SBSgetReportPenContr")) {

			

			String region = "", finYear = "", reportType = "", airportCode = "", formType = "", selectedMonth = "", empserialNO = "";
			String cpfAccno = "", page = "", toYear = "", transferFlag = "", pfidString = "", chkBulkPrint = "";
			String recoverieTable = "";
			String interestCalc = "", reinterestcalcdate = "";
			String getEditedPensionno = "";
			ArrayList pensionContributionList = null;
			pensionContributionList=new ArrayList();

			if (request.getParameter("frm_pfids") != null) {
				pfidString = request.getParameter("frm_pfids");
			}
			if (request.getParameter("interestcalcUpto") != null) {
				interestCalc = request.getParameter("interestcalcUpto");
			}
			if (request.getParameter("reinterestcalc") != null) {
				reinterestcalcdate = request.getParameter("reinterestcalc");
			}
			log.info("reinterestcalc" + reinterestcalcdate);
			if (request.getParameter("frm_pfids") != null) {
				pfidString = request.getParameter("frm_pfids");
			}
			log.info("Search Servlet" + pfidString);
			if (request.getParameter("cpfAccno") != null) {
				cpfAccno = request.getParameter("cpfAccno");
			}
			if (request.getParameter("transferStatus") != null) {
				transferFlag = request.getParameter("transferStatus");
			}
			String mappingFlag = "true";
			if (request.getParameter("mappingFlag") != null) {
				mappingFlag = request.getParameter("mappingFlag");

			}
			if (request.getParameter("page") != null) {
				page = request.getParameter("page");
			}
			if (request.getParameter("frm_region") != null) {
				region = request.getParameter("frm_region");
				// region="NO-SELECT";
			} else {
				region = "NO-SELECT";
			}
			log.info("region in servelt ***** "
					+ request.getParameter("frm_year"));
			if (request.getParameter("frm_year") != null) {
				finYear = request.getParameter("frm_year");
			}
			/*
			 * if (request.getParameter("frm_formType") != null) { formType =
			 * request.getParameter("frm_formType"); }
			 */
			if (request.getParameter("frm_month") != null) {
				selectedMonth = request.getParameter("frm_month");
			}
			if (request.getParameter("empserialNO") != null) {
				empserialNO = commonUtil.getSearchPFID1(request.getParameter(
						"empserialNO").toString().trim());
			}
			// /
			// empserialNO=commonUtil.trailingZeros(empserialNO.toCharArray());
			if (request.getParameter("frm_reportType") != null) {
				reportType = request.getParameter("frm_reportType");
			}
			if (request.getParameter("frm_airportcode") != null) {
				airportCode = request.getParameter("frm_airportcode");

			} else {
				airportCode = "NO-SELECT";
			}
			if (request.getParameter("frm_toyear") != null) {
				toYear = request.getParameter("frm_toyear");

			} else {
				toYear = "";
			}
			System.out.println("toYear=========="+request.getParameter("toYear"));
			System.out.println("formType============"+request.getParameter("formType"));
			if (request.getParameter("formType") != null) {
				formType = request.getParameter("formType");

			} else {
				formType = "";
			}

			if (request.getParameter("frm_bulkprint") != null) {

				chkBulkPrint = request.getParameter("frm_bulkprint");
			}
			// for cheking flag for which recoverie table to hit
			if (request.getParameter("finalrecoverytableFlag") != null) {
				recoverieTable = request.getParameter("finalrecoverytableFlag");
			}
			if(formType.equals("Employee Year wise OB Corpus form-Dec 2016")){
				pensionContributionList=SBSfinReportService.getSBSEmpWiseYearWiseList(region,airportCode,empserialNO);
				request.setAttribute("penContrList", pensionContributionList);
				request.setAttribute("airport", airportCode);
				request.setAttribute("region", region);
			}else
			if(formType.equals("EmployeeWiseTotal") || formType.equals("EmployeeWiseTotalNormal")){

				
				
				pensionContributionList=SBSfinReportService.getSBSEmpWiseList(region,airportCode,empserialNO);
				request.setAttribute("penContrList", pensionContributionList);
				request.setAttribute("airport", airportCode);
				request.setAttribute("region", region);
				
			}else if(formType.equals("YearWiseTotalForALL") || formType.equals("YearWiseTotal")|| formType.equals("Year wise Summary Total form-Dec 2016")){
				pensionContributionList=SBSfinReportService.getSBSYearWiseForAll(region,airportCode,empserialNO);
				request.setAttribute("penContrList", pensionContributionList);
				request.setAttribute("airport", airportCode);
				request.setAttribute("region", region);
				if(formType.equals("YearWiseTotal")){
				ArrayList personalList = SBSfinReportService
				.getPensionContributionReport(toYear, finYear, region,
						airportCode, selectedMonth, empserialNO, cpfAccno,
						transferFlag, mappingFlag, pfidString,
						chkBulkPrint, recoverieTable,"");
				request.setAttribute("personalList", personalList);
				}else if(formType.equals("Year wise Summary Total form-Dec 2016")){
					ArrayList personalList = SBSfinReportService
					.getPensionContributionReport(toYear, finYear, region,
							airportCode, selectedMonth, empserialNO, cpfAccno,
							transferFlag, mappingFlag, pfidString,
							chkBulkPrint, recoverieTable,"");
					request.setAttribute("personalList", personalList);	
				}
				
			}else if(formType.equals("monthWise")){
				pensionContributionList=SBSfinReportService.getmonthWise();
				request.setAttribute("penContrList", pensionContributionList);
				ArrayList taxval=SBSfinReportService.getSBSYearWiseForAll("","","");
				request.setAttribute("taxval", taxval);
			}
			else{
				if (formType.equals("Processing")) {
					transferFlag=formType;
				}
			pensionContributionList = SBSfinReportService
					.getPensionContributionReport(toYear, finYear, region,
							airportCode, selectedMonth, empserialNO, cpfAccno,
							transferFlag, mappingFlag, pfidString,
							chkBulkPrint, recoverieTable,formType);

			//double interestforNoofMonths = SBSfinReportService
				//	.getInterestforNoofMonths(interestCalc);
			//String reIntrestDate = SBSfinReportService
				//	.reIntrestDate(empserialNO);
			//double interestforfinalsettleMonths = SBSfinReportService
				//	.interestforfinalsettleMonths(reinterestcalcdate,
					//		empserialNO);
			//String finalintrestdate = SBSfinReportService.finalintrestdate(
					//reinterestcalcdate, empserialNO);
			//String reSettlementdate = SBSfinReportService
					//.reSettlementdate(empserialNO);

			//double pctotal = 0.0;
			//double intrest = 0.0;
			String retireddate = "";
			if (recoverieTable.equals("true")) {
				//pctotal = financeService
					//	.getPensionContributionTotal(empserialNO);
				//intrest = financeService.getfinalrevoveryintrest(empserialNO);
			//	getEditedPensionno = financeService
				//		.getEditedPensionno(empserialNO);
			}
			log.info("pensionContributionList "
					+ pensionContributionList.size());

			request.setAttribute("penContrList", pensionContributionList);
			
			request.setAttribute("blkprintflag", chkBulkPrint);
			request.setAttribute("stationStr", airportCode);
			request.setAttribute("regionStr", region);
			//request.setAttribute("pctotal", new Double(pctotal));
			//request.setAttribute("intrest", new Double(intrest));
			request.setAttribute("recoverieTable", recoverieTable);
			request.setAttribute("interestCalcfinal", interestCalc);
			//request.setAttribute("finalintdate", finalintrestdate);
		//	request.setAttribute("reIntrestcalcDate", reIntrestDate);
			//request.setAttribute("getEditPenno", getEditedPensionno);
			//request.setAttribute("resettledate", reSettlementdate);
		//	request.setAttribute("interestforNoofMonths", String
			//		.valueOf(interestforNoofMonths));
			//request.setAttribute("interestforfinalsettleMonths", String
				//	.valueOf(interestforfinalsettleMonths));
			
			}
			request.setAttribute("reportType", reportType);
			request.setAttribute("formType", formType);
			if (formType.equals("CorpusFormwithIntt")) {
				RequestDispatcher rd = request
						.getRequestDispatcher("./PensionView/SBS/SBSPensionContributionReport.jsp");
				rd.forward(request, response);
			}if (formType.equals("NormalCorpusForm")) {
				RequestDispatcher rd = request
				.getRequestDispatcher("./PensionView/SBS/SBSNormalCorpusReportWithOutIntt.jsp");
				rd.forward(request, response);
			}if (formType.equals("Normal OB Corpus form-Dec 2016")) {
				RequestDispatcher rd = request
				.getRequestDispatcher("./PensionView/SBS/SBSNormalCorpusReportDec2016.jsp");
				rd.forward(request, response);
			} else if (formType.equals("YearWiseBreakup")) {
				RequestDispatcher rd = request
						.getRequestDispatcher("./PensionView/SBS/SBSPCYearWiseBreakupReport.jsp");
				rd.forward(request, response);
			} else if (formType.equals("Employee Year wise OB Corpus form-Dec 2016")) {
				RequestDispatcher rd = request
				.getRequestDispatcher("./PensionView/SBS/SBSEmpWiseYearWiseTotReportNormal2016.jsp");
				
				rd.forward(request, response);
			}else if (formType.equals("EmployeeWiseTotal")) {
				RequestDispatcher rd = request
				.getRequestDispatcher("./PensionView/SBS/SBSEmpWiseTotReport.jsp");
				
				rd.forward(request, response);
			}else if (formType.equals("EmployeeWiseTotalNormal")) {
				RequestDispatcher rd = request
				.getRequestDispatcher("./PensionView/SBS/SBSEmpWiseTotReportNormal.jsp");
				
				rd.forward(request, response);
				
			}else if (formType.equals("Year wise Summary Total form-Dec 2016")) {
				RequestDispatcher rd = request
				.getRequestDispatcher("./PensionView/SBS/SBSYearWiseSummaryTotReport2016.jsp");
				rd.forward(request, response);
			
			}else if (formType.equals("YearWiseTotal")) {
				RequestDispatcher rd = request
				.getRequestDispatcher("./PensionView/SBS/SBSYearWiseTotReport.jsp");
				rd.forward(request, response);
			
			}else if (formType.equals("YearWiseTotalForALL")) {
			RequestDispatcher rd = request
			.getRequestDispatcher("./PensionView/SBS/SBSYearWiseTotReportForALL.jsp");
			rd.forward(request, response);
		}else if (formType.equals("monthWise")) {
			RequestDispatcher rd = request
			.getRequestDispatcher("./PensionView/SBS/SBSMonthWiseReport.jsp");
			rd.forward(request, response);
		}
			else if (formType.equals("Processing")) {
			RequestDispatcher rd = request
			.getRequestDispatcher("./PensionView/SBS/SBSPCEmpWiseTotalReport.jsp");
	rd.forward(request, response);
		}

		} else if (request.getParameter("method") != null
				&& request.getParameter("method").equals(
						"getEmployeeMappedList")) {
			log.info("getEmployeeMappedList () ");
			String path = "", screen = "";
			String region = request.getParameter("region").toString();
			if (region.equals("[Select One]")) {
				region = "";
			}
			String empName = request.getParameter("empName").toString().trim();
			String pfId = request.getParameter("pfId").toString().trim();
			String uanNo = request.getParameter("uanNo").toString().trim();
			if (request.getParameter("screen") != null) {
				screen = request.getParameter("screen").toString().trim();
			}
			pfId = commonUtil.getSearchPFID1(pfId.toString().trim());
			String transferType = "", adjPfidChkFlag = "", chkpfid = "", statemntRevisdChkFlag = "", statemntRevisdChkPfid = "", frmName = "", PCAftrSepFlag = "", pcReportChkFlag = "";
			if (request.getParameter("transferType") != null) {
				transferType = request.getParameter("transferType").toString();
			}
			if (request.getParameter("adjPfidChkFlag") != null) {
				adjPfidChkFlag = request.getParameter("adjPfidChkFlag")
						.toString();
			}
			if (request.getParameter("statemntRevisdChkFlag") != null) {
				statemntRevisdChkFlag = request.getParameter(
						"statemntRevisdChkFlag").toString();
			}
			if (request.getParameter("frmName") != null) {
				frmName = request.getParameter("frmName").toString();
			}
			if (request.getParameter("pcReportChkFlag") != null) {
				pcReportChkFlag = request.getParameter("pcReportChkFlag")
						.toString();
			}

			ArrayList mappedList = new ArrayList();
			ArrayList employeeinfolist = new ArrayList();
			boolean flag = true;

			try {
				mappedList = ps.getEmployeeMappedList(region, empName.trim(),
						transferType, pfId, uanNo);
				PensionBean empData = null;
				for (int i = 0; i < mappedList.size(); i++) {
					empData = (PensionBean) mappedList.get(i);
				}
				if (screen.equals("pcreport")) {
					employeeinfolist = ps.getEmployeeinfoMappedList(pfId);

					request.setAttribute("EmpInfoList", employeeinfolist);
					System.out.println("employeeinfolist----"
							+ employeeinfolist.size());

				}
				log.info("adjPfidChkFlag----" + adjPfidChkFlag);
				log.info("screen----" + screen);
				if (adjPfidChkFlag.equals("true")) {
					if (pcReportChkFlag.equals("true")) {
						if (screen.equals("pcreport")) {
							chkpfid = adjCrtnService
									.chkPfidStatusInAdjCrtnForPCReport1(pfId);
						} else {
							// For Checking exact Corrections in 1995-2008
							// period
							chkpfid = adjCrtnService
									.chkPfidStatusInAdjCrtnForPCReport(pfId);
						}
					} else {
						chkpfid = adjCrtnService.chkPfidStatusInAdjCrtn(pfId);
					}
				}

				if (chkpfid.equals("Approved")) {
					chkpfid = "Exists";
				} else {
					chkpfid = "NotExists";
				}
				// For 12 Mnth Statement Chking purpose
				log.info("statemntRevisdChkFlag----" + statemntRevisdChkFlag);
				if (statemntRevisdChkFlag.equals("true")) {
					statemntRevisdChkPfid = adjCrtnService
							.chkPfidinAdjCrtn78PSTracking(pfId, "");
				}

				if (frmName.equals("form7ps") || frmName.equals("form8ps")) {
					PCAftrSepFlag = finReportService
							.chkPfidHavngPCAfterSeperation(pfId, empData);
				}
				request.setAttribute("MappedList", mappedList);

				request.setAttribute("ArrearInfo", "");
				request.setAttribute("transferType", transferType);
				request.setAttribute("fndregion", region);
				request.setAttribute("chkpfid", chkpfid);
				request.setAttribute("statemntRevisdChkPfid",
						statemntRevisdChkPfid);
				request.setAttribute("PCAftrSepFlag", PCAftrSepFlag);
				log.info("transferType " + transferType);
				log.info("Mapped LIst " + mappedList.size());
				log.info("chkpfid " + chkpfid);
				log.info("statemntRevisdChkPfid " + statemntRevisdChkPfid);
				log.info("PCAftrSepFlag " + PCAftrSepFlag);
				if (request.getParameter("pagename") != null) {
					if (request.getParameter("pagename").equals("processInfo")) {
						path = "./PensionView/dashboard/ProcessInfo.jsp";
					}else{
						path = "./PensionView/SBS/SBSAnnuityHelp.jsp";	
					}
				} else {
					path = "./PensionView/SBS/SBSPensionContributionMappedList.jsp";
				}
				RequestDispatcher rd = request.getRequestDispatcher(path);
				rd.forward(request, response);
			} catch (Exception e) {
				log.printStackTrace(e);
			}
		} else if (request.getParameter("method").equals("sbseligible")) {
			ArrayList regionList = new ArrayList();
			String rgnName = "";
			HashMap map = new HashMap();
			String[] regionLst = null;
			if (session.getAttribute("region") != null) {
				regionLst = (String[]) session.getAttribute("region");
			}
			log.info("Regions List" + regionLst.length);
			for (int i = 0; i < regionLst.length; i++) {
				rgnName = regionLst[i];
				if (rgnName.equals("ALL-REGIONS")
						&& session.getAttribute("usertype").toString().equals(
								"SBSUser")) {
					map = new HashMap();
					map = commonUtil.getRegion();
					break;
				} else {
					map.put(new Integer(i), rgnName);
				}

			}

			request.setAttribute("regionHashmap", map);
			RequestDispatcher rd = null;
			if (request.getParameter("method").equals("sbseligible")) {
				rd = request
						.getRequestDispatcher("./PensionView/SBS/SBSEligibleorInElgibleParam.jsp");
			}
			rd.forward(request, response);

		} else

		if (request.getParameter("method") != null
				&& request.getParameter("method").equals(
						"searchPersonalEligible")) {

			String region = "", airport = "", pfid = "", sbsOption = "", sbsvalue = "",reportType="";

			ArrayList sbsList = new ArrayList();

			if (request.getParameter("pfid") != null ) {
				pfid = request.getParameter("pfid");
			}
			
			if (request.getParameter("region") != null && !request.getParameter("region").equals("[Select One]")) {
				region = request.getParameter("region");
			}
			
			if (request.getParameter("airPortCode") != null && !request.getParameter("airPortCode").equals("[Select One]")) {
				airport = request.getParameter("airPortCode");
			}
			
			if (request.getParameter("sbsoption") != null) {
				sbsOption = request.getParameter("sbsoption");
			}
			if(request.getParameter("frm_reportType") != null){
				reportType=request.getParameter("frm_reportType");
			}
			
			if (sbsOption.equals("Eligible")) {
				sbsvalue = "Y";
			}else if (sbsOption.equals("InElgible")) {
				sbsvalue = "N";
			}else
				sbsvalue = "P";
			
			log.info("region:::::::"+region);

			sbsList = SBSfinReportService.getSBSEmpList(region, airport, pfid,
					sbsvalue);

			request.setAttribute("sbsList", sbsList);
			request.setAttribute("SBSOption", sbsvalue);
			request.setAttribute("region", region);
			request.setAttribute("airport", airport);
			request.setAttribute("reportType", reportType);

			RequestDispatcher rd = request
					.getRequestDispatcher("./PensionView/SBS/SBSEmployeePersonalInfoEligibleReport.jsp?menu=M4L1");
			rd.forward(request, response);

		}else if (request.getParameter("method").equals("retirementEmployeesReport")) {
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
					e1.printStackTrace();
				}
						
			ArrayList retdList = new ArrayList();
			try{
			retdList = SBSfinReportService.retdListReportByPFID(monthYear,
					region, airportcode );
			
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
					.getRequestDispatcher("./PensionView/RetirementEmployeesInfo.jsp");
			
			
			rd.forward(request, response);
		}

	}

	protected void doGet(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		this.doPost(request, response);
	}

}
