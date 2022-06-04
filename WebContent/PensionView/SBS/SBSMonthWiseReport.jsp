
<%@ page
	import="aims.bean.TempPensionTransBean,aims.bean.EmployeePersonalInfo,java.util.ArrayList,java.util.HashMap"%>
<%@ page import="java.text.DecimalFormat"%>

<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>



<%
	ArrayList dataList = new ArrayList();
	String reportType = "", region = "", fileName = "", type = "", airport = "";

	if (request.getAttribute("penContrList") != null) {
		dataList = (ArrayList) request.getAttribute("penContrList");
	}
	if (request.getAttribute("airport") != null) {
		airport = request.getAttribute("airport").toString();
	}
	if ("NO-SELECT".equals(airport)) {
		airport = "All_Airports";
	}
	if (request.getAttribute("region") != null) {
		region = request.getAttribute("region").toString();
	}
	if ("NO-SELECT".equals(region)) {
		region = "All_Regions";
	}

	if (request.getAttribute("reportType") != null) {
		reportType = (String) request.getAttribute("reportType");
		if (region.equals("")) {
			region = "All_Regions";
		}
		if (reportType.equals("Excel Sheet")
				|| reportType.equals("ExcelSheet")) {

			fileName = "SBSMonthWiseReport.xls";
			response.setContentType("application/vnd.ms-excel");
			response.setHeader("Content-Disposition",
					"attachment; filename=" + fileName);
		}
	}
	HashMap taxwithIntt=new HashMap();
	HashMap taxwithOutIntt=new HashMap();
	
	long taxvalWithInt=0l,taxvalWithOutIntt=0l;
	
	if (request.getAttribute("taxval") != null) {
	ArrayList taxvalList = (ArrayList) request.getAttribute("taxval");
	
	EmployeePersonalInfo empInfo=null;
	
				
				for(int x=0;x<taxvalList.size();x++){
				
					empInfo = (EmployeePersonalInfo) taxvalList.get(x);
					taxwithIntt.put(empInfo.getFinyear(),empInfo.getTaxValwithIntt());
					
					taxvalWithInt=taxvalWithInt+Long.parseLong(empInfo.getTaxValwithIntt()) ;
					
					taxwithOutIntt.put(empInfo.getFinyear(),empInfo.getTaxValwithoutIntt());
					
					taxvalWithOutIntt=taxvalWithOutIntt+Long.parseLong(empInfo.getTaxValwithoutIntt()) ;
				
					
					}
	
	}
	
	
	//System.out.println("ghjghjghjg"+dataList.size() );
%>

<!DOCTYPE>
<html>

	<HEAD>
		<LINK rel="stylesheet" href="<%=basePath%>PensionView/css/aai.css"
			type="text/css">
		<script type="text/javascript">
   
</script>
	</HEAD>



	<body>


		<form action="method">
			<table width="100%" border="0" align="center" cellpadding="0"
				cellspacing="0">
				<tr>
					<td colspan="2">
						<table width="100%">
							<tr>
								<td style="width: 40%; text-align: right">
									<img src="<%=basePath%>PensionView/images/logoani.gif">
								</td>
								<td style="width: 60%; text-align: left;">
									<table border=0 cellpadding=3 cellspacing=0 width="100%">
										<tr>
											<td>

											</td>
											<td class="label" align="left" valign="top" nowrap="nowrap"
												style="font-family: serif; font-size: 21px; color: #33419a">
												AIRPORTS AUTHORITY OF INDIA
											</td>
										</tr>
										<tr>
											<tr>
												<td colspan="2" style="font-size: 15px; color: #33419a">
													<b>AAl Employees Defined Contribution Pension Trust</b>
												</td>
											</tr>
									</table>
								</td>
							</tr>
						</table>
					</td>
				</tr>
				<tr>
			</table>
			<table width="100%" border="0" align="center" cellpadding="0"
				cellspacing="0">
				<tr>
					<td colspan="2">

					</td>
				</tr>
				<tr>
					<td>
						<div style="overflow: auto !important; width: 100% !important">
							<table class="sample" cellpadding="2" cellspacing="0"
								width="1205px" align="center">
								<tr>
									<td colspan="12" style="" class="ReportHeading">
										SBS Month Wise Report
									</td>
								</tr>

								<tr>


									<th class="label" style="width: 120px">
										Month Year
									</th>
									<th class="label" style="width: 120px">
										Emoluments
									</th>
									<th class="label" style="width: 180px">
										AAI SBS Contribution
									</th>
									<th class="label" style="width: 200px">
										Notational Additional Increment Recovery
									</th>
									<th class="label" style="width: 130px">
										Adjusted SBS Contri
									</th>
								
									<th class="label" style="width: 120px">
										Interest
									</th>
									<th class="label" style="width: 120px">
										Gross Contribution
									</th>

									<th class="label" style="width: 120px">
										Fin Year
									</th>

									<th class="label" style="width: 120px">
										RateOfInt
									</th>
									<th class="label" style="width: 120px">
										Taxable Value of Perquisite Value after relief u/s 89 (with intt)
									</th>
									<th class="label" style="width: 120px">
										Taxable Value of Perquisite Value after relief u/s 89 (without intt)
									</th>

								</tr>

								<%
									double emolumentsTotal = 0.0, adjSbsContriTotal = 0.0, sbsContriTotal = 0.0,grossContriTot=0.0,sbsNoincrement=0.0, sbsInterestTotal = 0.0, sbsContriIntTotal = 0.0, totCount = 0.0;
									long yearEmolumentsTotal = 0l, yearadjSbsContriTotal = 0l,yearGrossContriTotal=0l, yearsbsContriTotal = 0l,yearSbsnoincrementTot=0l, yearsbsInterestTotal = 0l, yearsbsContriIntTotal = 0l, yeartotCount = 0l;
									DecimalFormat df = new DecimalFormat("#########0");
									long grossContri=0l;
									long yearcummiTotal = 0l;
									if (dataList.size() != 0) {
										int count = 0;

										TempPensionTransBean sbsPerBean = null;
										String styleClass = "";

					
						
						
							HashMap intrestrate=new HashMap();
						intrestrate.put("2006-2007","7.98");
						intrestrate.put("2007-2008","7.96");
						intrestrate.put("2008-2009","7.01");
						intrestrate.put("2009-2010","7.83");
						intrestrate.put("2010-2011","7.99");
						intrestrate.put("2011-2012","8.54");
						intrestrate.put("2012-2013","7.96");
						intrestrate.put("2013-2014","8.80");
						intrestrate.put("2014-2015","7.74");
						intrestrate.put("2015-2016","7.47");
						intrestrate.put("2016-2017","6.68");
						intrestrate.put("2017-2018","7.40");
						intrestrate.put("2018-2019","7.35");
						intrestrate.put("2019-2020","0");
						intrestrate.put("2020-2021","0");
						intrestrate.put("2021-2022","0");
						
						
										String dispFinYear = "";
										for (int k = 0; k < dataList.size(); k++) {

											count++;
											sbsPerBean = (TempPensionTransBean) dataList.get(k);
											if (k == 0) {
												dispFinYear = sbsPerBean.getFinYear();
											}

											double interest = Math.round((Double.parseDouble(sbsPerBean
													.getAdjSbsContri())
													* Double.parseDouble(intrestrate.get(
															sbsPerBean.getFinYear()).toString())/100)
													* (Double.parseDouble(sbsPerBean.getNoofMonths())
														/ 12));
											long obint = 0l;
											emolumentsTotal = emolumentsTotal
													+ Double.parseDouble(sbsPerBean.getEmoluments());
											//sbsInterestTotal=sbsInterestTotal+interest;
											sbsContriTotal = sbsContriTotal
													+ Double.parseDouble(sbsPerBean.getPensionContr());
											sbsNoincrement=sbsNoincrement+ Double.parseDouble(sbsPerBean.getNoIncrement());
											adjSbsContriTotal = adjSbsContriTotal
													+ Double.parseDouble(sbsPerBean.getAdjSbsContri());
											totCount = count;

											//lastActive=beans.getDateofJoining();

											if (sbsPerBean.getMonthyear().equals("01-Apr-2021")) {
												sbsPerBean.setFinYear("2020-2021");
											}
								%>
								<%
									if (k != 0) {
												if (!dispFinYear.equals(sbsPerBean.getFinYear())) {
													
															yearcummiTotal = yearcummiTotal
															+ yearadjSbsContriTotal + yearsbsInterestTotal;
															
															
														

													obint = new Double(Math.round((yearcummiTotal)
															* (Double
																	.parseDouble(intrestrate.get(
																			sbsPerBean.getFinYear())
																			.toString())) / 100))
															.longValue();
															
															System.out.println("yearcummiTotal:::"+yearcummiTotal);
								%>

								<tr class="HighlightData">

									<td>
										Total
									</td>


									<td><%=yearEmolumentsTotal%></td>
									<td><%=yearsbsContriTotal%></td>
									<td>
										<%=yearSbsnoincrementTot %>
									</td>
									
									<td><%=yearadjSbsContriTotal%></td>
									

									<td><%=yearsbsInterestTotal%></td>
									<td>
										<%=yearGrossContriTotal %>
									</td>

									<td></td>
									<td></td>
									<td> <%=taxwithIntt.get(dispFinYear) %></td>
									<td> <%=taxwithOutIntt.get(dispFinYear) %></td>

								</tr>
								<tr class="HighlightData">

									<td>
										Cumulative Closing Balance <%=dispFinYear %>
									</td>


									<td>
										0
									</td>
									<td>
										0
									</td>
									<td>
										0
									</td>
									<td>
										0
									</td>
									<td></td>
									<td><%=yearcummiTotal%></td>

									

									<td></td>
									<td></td>
									<td> </td>
									<td></td>

								</tr>
								<tr class="HighlightData">

									<td>
										Interest on Cumulative Closing Balance <%=dispFinYear %>
									</td>


									<td>
										0
									</td>
									<td>
										0
									</td>
									<td>
										0
									</td>
									<td>
										0
									</td>
									<td><%=obint%></td>

									<td><%=obint%></td>

									<td><%=sbsPerBean.getFinYear() %></td>
									<td><%=intrestrate.get(sbsPerBean.getFinYear())%></td>
									<td> </td>
									<td></td>

								</tr>


								<%
									sbsInterestTotal = sbsInterestTotal
															+ yearsbsInterestTotal;
															
															grossContriTot=grossContriTot+yearGrossContriTotal;

													yearEmolumentsTotal = 0;
													yearadjSbsContriTotal = 0;
													yearsbsContriTotal = 0;
													yearsbsInterestTotal = 0;
													yearSbsnoincrementTot=0;
													yearGrossContriTotal=0;
												}
											}

											yearEmolumentsTotal = yearEmolumentsTotal
													+ Long.parseLong(sbsPerBean.getEmoluments());
											yearadjSbsContriTotal = yearadjSbsContriTotal
													+ Long.parseLong(sbsPerBean.getAdjSbsContri());
											yearsbsContriTotal = yearsbsContriTotal
													+ Long.parseLong(sbsPerBean.getPensionContr());
													yearSbsnoincrementTot=yearSbsnoincrementTot
													+Long.parseLong(sbsPerBean.getNoIncrement());
											yearsbsInterestTotal = yearsbsInterestTotal
													+ (new Double(interest).longValue()) + obint;
													
													
													grossContri=Long.parseLong(sbsPerBean.getAdjSbsContri())+new Double(interest).longValue();
													yearGrossContriTotal=yearGrossContriTotal+grossContri+obint;
													
								%>


								<tr>



									<td><%=sbsPerBean.getMonthyear()%></td>
									<td><%=sbsPerBean.getEmoluments()%></td>
									<td><%=sbsPerBean.getPensionContr()%></td>
									<td>
										<%=sbsPerBean.getNoIncrement()%>
									</td>
									<td>
										<%=sbsPerBean.getAdjSbsContri()%>
									</td>
									
									<td><%=new Double(interest).longValue()%></td>
									<td><%=grossContri %></td>
									


									<td><%=sbsPerBean.getFinYear()%></td>
									<td><%=intrestrate.get(sbsPerBean.getFinYear())%></td>
							<td></td>
							<td></td>
								</tr>

								<%
									//System.out.println(dispFinYear+":::hkhjkhjkjhkjhkhjk:"+sbsPerBean.getFinYear());

											dispFinYear = sbsPerBean.getFinYear();

											if (sbsPerBean.getMonthyear().equals("01-Apr-2020")) {}
										}
									} else {
								%>

								<tr>
									<td colspan="8" style="color: red" align="center">
										No Records Found!
									</td>
								</tr>


								<%
									}
								%>
								<tr>




									<td colspan="1" style="font-weight: bold">
										Total
									</td>
									<td style="font-weight: bold"><%=df.format(emolumentsTotal)%></td>
									<td style="font-weight: bold"><%=df.format(sbsContriTotal)%></td>
									<td style="font-weight: bold">
										<%=df.format(sbsNoincrement) %>
									</td>
									
									<td style="font-weight: bold"><%=df.format(adjSbsContriTotal)%></td>
									
									
									<td style="font-weight: bold"><%=df.format(sbsInterestTotal)%></td>
									<td style="font-weight: bold">
										<%=df.format(adjSbsContriTotal+sbsInterestTotal) %>
									</td>

									<td colspan="2" style="font-weight: bold"></td>
									<td colspan="1" style="font-weight: bold"><%=taxvalWithInt %></td>
									<td colspan="1" style="font-weight: bold"><%=taxvalWithOutIntt %></td>


								</tr>
							</table>









							</form>
	</body>
</html>