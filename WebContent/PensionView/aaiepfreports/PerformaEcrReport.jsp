
<%@ page language="java"%>
<%@ page import="java.util.*,aims.common.*,aims.bean.EcrTotal"%>
<%@ page
	import="aims.bean.DatabaseBean,aims.bean.SearchInfo,aims.bean.BottomGridNavigationInfo"%>
<%@ page import="aims.bean.FinacialDataBean"%>
<%@ page
	import="aims.bean.PensionBean,aims.bean.StationWiseRemittancebean,aims.bean.EmpMasterBean"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
	CommonUtil common = new CommonUtil();
%>
<%
	System.out.println("========================venkatesh");

	String monthyear = "", month = "", year = "";

	if (request.getAttribute("monthYear") != null) {
		monthyear = request.getAttribute("monthYear").toString();
	}
			
	
			
%>



<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"
"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
	<head>
		<title>AAI</title>
		<meta http-equiv="pragma" content="no-cache">
			<meta http-equiv="cache-control" content="no-cache">
				<meta http-equiv="expires" content="0">
					<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
						<meta http-equiv="description" content="This is my page">
							<link rel="stylesheet"	href="<%=basePath%>PensionView/css/aai.css" type="text/css">
	</head>
	<body>
		<form>

			<table width="100%" border="0" align="center" cellpadding="0"
				cellspacing="0">
				<tr>
					<td colspan="2">
						<table width="100%" border="0" cellspacing="0" cellpadding="0">
							<tr>
								<td width="100%" rowspan="1" align="center" class="reportlabel">
									<img src="<%=basePath%>PensionView/images/logoani.gif" />
									&nbsp;AIRPORTS AUTHORITY OF INDIA
								</td>
							</tr>
							<tr>

								<td colspan="3" class="reportlabel" align="center">
									PERFORMA FOR NUMBER OF EMPLOYEES DURING THE MONTH 
									<U><%=month%></U> in
									<U><%=year%></U>
								</td>
							</tr>


						</table>
					</td>
				</tr>
				
		
				<tr>

					<td width="85%" colspan="3" class="Data" align="right">
						Date:<%=common.getCurrentDate("dd-MMM-yyyy HH:mm:ss")%></td>

				</tr>


						<tr>

							<td>
								<table align="center">
									<tr>
										<td colspan="3"></td>
										<td colspan="2" align="right">
											<%
												if (request.getAttribute("reportType") != null) {
													String reportType = (String) request.getAttribute("reportType");

													if (reportType.equals("Excel Sheet")
															|| reportType.equals("ExcelSheet")) {

														String fileName = "StationWiseRemittanceReport.xls";
														response.setContentType("application/vnd.ms-excel");
														response.setHeader("Content-Disposition",
																"attachment; filename=" + fileName);
													}
												}
											%>
										</td>
									</tr>
								</table>
							</td>
						</tr>
						<tr>
							<td colspan="4">
								<table width="100%" align="center" cellpadding=2 cellspacing="0"
									border="1" color="red" bordercolor="gray">
									<tr>
										<td width="50%">
											<table width="100%" border="1" cellpadding="5"
												cellspacing="1">

												<tr>
													<td width="4%" colspan="4" class="label">
														TOTAL NUMBER OF EMPLOYEES AS PER DATA UPLOADED
													</td>
												</tr>
												<tr>
													<td width="4%" colspan="4" class="label">
														LESS NON MEMBERS OF EPFO
													</td>
												</tr>
												<tr>
													<td width="4%" colspan="4" class="label">
														BREAK UP OF EMPLOYEES
													</td>
												</tr>
												<tr>
													<td width="4%" colspan="4" class="label">
														ATTAINED 58 YEARS WITHOUT CONTRIBUTION
													</td>
												</tr>
												<tr>
													<td width="4%" colspan="4" class="label">
														ATTAINED 58 YEARS WITH CONTRIBUTION
													</td>
												</tr>
												<tr>
													<td width="4%" colspan="4" class="label">
														CONTRIBUTRIES WITH PENSION CONTRIBUTION DURING THE MONTH
													</td>
												</tr>
												<tr>
													<td width="4%" colspan="4" class="label">
														CONTRIBUTRIES WITH PENSION CONTRIBUTION ZERO DURING THE
														MONTH
													</td>
												</tr>

												<tr>
													<td width="4%" colspan="4" class="label">
														BREAK UP OF EMPLOYEES OPTION WISE
													</td>
												</tr>
												<tr>
													<td width="4%" colspan="4" class="label">
														NUMBER OF EMPLOYEES WITH OPTION A
													</td>
												</tr>
												<tr>
													<td width="4%" colspan="4" class="label">
														NUMBER OF EMPLOYEES WITH OPTION B
													</td>
												</tr>

											</table>
										</td>


										<td width="50%" valign="top">
											<table width="100%" border="1" cellpadding="5"
												cellspacing="1">
												<%
													System.out.println("========================aaaaaaaaaaaaaaaaaaa");

													Map totalMap = null;
													String totalnoemployees = "", totalnonnoemployees = "";
													System.out.println("========================bbbbbbbbbbbbbbbbbbbbb");

													totalMap = (Map) request.getAttribute("Total");

													System.out
															.println("========================cccccccccccccccccccccc");

													Iterator keySet = totalMap.keySet().iterator();

													System.out
															.println("========================ddddddddddddddddddddddd"
																	+ keySet.hasNext());

													while (keySet.hasNext()) {
												%>
												<tr>
													<td class="label" align="left"><%=totalMap.get(keySet.next())%></td>
												</tr>

												<%
													}
												%>
											</table>
										</td>

									</tr>
								</table>
							</td>
						</tr>
					
			</table>
		</form>
	</body>
</html>
