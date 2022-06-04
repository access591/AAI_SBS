<%@ page import="java.util.*,aims.common.*"%>
<%@ page import="aims.bean.EmpMasterBean"%>
<%@ page import="aims.bean.*"%>
<%String path = request.getContextPath();
			String basePath = request.getScheme() + "://"
					+ request.getServerName() + ":" + request.getServerPort()
					+ path + "/";
			String arrearInfoString1 = "";
			String regionFlag = "false";
%>


<html>

<jsp:include page="/SBSHeader.jsp"></jsp:include>
<jsp:include page="/PensionView/SBS/Menu.jsp"></jsp:include>

	<head>
		<title>AAI</title>

		
		<SCRIPT type="text/javascript"
			src="<%=basePath%>PensionView/scripts/CommonFunctions.js"></SCRIPT>
		<SCRIPT type="text/javascript"
			src="<%=basePath%>PensionView/scripts/DateTime1.js"></SCRIPT>
		<script type="text/javascript">
	
</script>

<style type="text/css">
.col-xs-1, .col-sm-1, .col-md-1, .col-lg-1, .col-xs-2, .col-sm-2, .col-md-2, .col-lg-2, .col-xs-3, .col-sm-3, .col-md-3, .col-lg-3, .col-xs-4, .col-sm-4, .col-md-4, .col-lg-4, .col-xs-5, .col-sm-5, .col-md-5, .col-lg-5, .col-xs-6, .col-sm-6, .col-md-6, .col-lg-6, .col-xs-7, .col-sm-7, .col-md-7, .col-lg-7, .col-xs-8, .col-sm-8, .col-md-8, .col-lg-8, .col-xs-9, .col-sm-9, .col-md-9, .col-lg-9, .col-xs-10, .col-sm-10, .col-md-10, .col-lg-10, .col-xs-11, .col-sm-11, .col-md-11, .col-lg-11, .col-xs-12, .col-sm-12, .col-md-12, .col-lg-12 {
    position: relative;
    min-height: 1px;
  
}
</style>



	</head>

	<body onload="javascript:frmload()">
		<form name="personalMaster" action="<%=basePath%>psearch?method=personalUpdate" method="post">			
			<div class="page-content-wrapper">
				<div class="page-content">
				<div></div>
					<div class="row">
						<div class="col-md-12">
							<h3 class="page-title">
								SBS MASTER 
							</h3>
							<ul class="page-breadcrumb breadcrumb"></ul>
						</div>
					</div>



					<%if (request.getAttribute("ArrearInfo") != null) {
				arrearInfoString1 = (String) request.getAttribute("ArrearInfo");
				request.setAttribute("ArrearInfo", arrearInfoString1);
				System.out.println("arrearInfoString1****  "
						+ arrearInfoString1);

			}%>
					<%if (request.getAttribute("recordExist") != null) {%>
					<font color="red"><%=request.getAttribute("recordExist")%></font>
					<%}%>

					<%String pensionNumber = "", editFrom = "";
			if (request.getAttribute("pensionNumber") != null) {
				pensionNumber = request.getAttribute("pensionNumber")
						.toString();
			}

			%>
					<%if (request.getAttribute("EditBean") != null) {
				EmpMasterBean bean1 = (EmpMasterBean) request
						.getAttribute("EditBean");
				String form2 = bean1.getForm2Nomination().trim();
				if (request.getAttribute("AirportList") != null) {
					ArrayList AirportList = (ArrayList) request
							.getAttribute("AirportList");
				}
				if (request.getAttribute("editFrom") != null) {
					editFrom = (String) request.getAttribute("editFrom");
				}

				%>


					<div class="row">
						<div class="col-md-6">
							<div class="form-group">
								<label class="control-label col-md-6">
									PF ID  :
								</label>

								<div class="col-md-6">
									<input type="text" readonly="true" name="pfid"
										class="form-control" readonly="true" maxlength="35"
										tabindex="1" readonly="true" value='<%=bean1.getPfid()%>' />
									<input type="hidden" name="setEmpSerialNo" class="form-control"
										readonly="true" maxlength="35" tabindex="1"
										value='<%=bean1.getEmpSerialNo()%>' />



								</div>
							</div>
						</div>
						<div class="col-md-6">
							<div class="form-group">
								<label class="control-label col-md-5">
									Employee Name: :
								</label>

								<div class="col-md-6">
									<input type="text" readonly="true" name="empName"
										class="form-control" maxlength="50" tabindex="5"
										onblur="getPensionNumber();" value='<%=bean1.getEmpName()%>'
										onkeyup=
	return limitlength(this, 50);
>



								</div>
							</div>
						</div>
					</div>
		

					<div class="row">
						<div class="col-md-6">
							<div class="form-group">
								<label class="control-label col-md-6">
									Old CPFACC.NO:
								</label>

								<div class="col-md-6">
									<input type="text" readonly="true" name="cpfacnoNew"
										class="form-control" maxlength="25" tabindex="2"
										onBlur="charsCapsNumOnly();getPensionNumber();"
										value='<%=bean1.getCpfAcNo()%>' />



								</div>
							</div>
						</div>
						<div class="col-md-6">
							<div class="form-group">
								<label class="control-label col-md-5">
									Old / New Airport Code:
								</label>
<div class="col-md-6 input-group">
								<div class="col-md-6">
									<input type="text" readonly="true" name="oldAirportCode"
										size="5" class="form-control" readonly="true"
										value='<%= bean1.getStation()%>'%></div>
									<div class="col-md-6">	
									<select name="airPortCode" disabled="disabled" tabindex="3"
										class="form-control">
										<option value="">
											[Select One]
										</option>
										<%if (request.getAttribute("AirportList") != null) {
					ArrayList airpors = (ArrayList) request
							.getAttribute("AirportList");
					for (int i = 0; i < airpors.size(); i++) {
						boolean exist = false;
						EmpMasterBean airportBean = (EmpMasterBean) airpors
								.get(i);
						if (airportBean.getStation().equalsIgnoreCase(
								bean1.getStation()))
							exist = true;

						%>

										<%if (exist) {%>

										<option value="<%= bean1.getStation()%>" selected>
											<%=airportBean.getStationWithRegion()%>
										</option>

										<%} else {

							%>

										<option value="<%= airportBean.getStation()%>">
											<%=airportBean.getStationWithRegion()%>
										</option>

										<%}
					}
				}%>


									</select></div>
									<input type="hidden" name="airportSerialNumber"
										value='<%=bean1.getAirportSerialNumber()%>'
										onkeyup=
	return limitlength(this, s0);
>
									<input type="hidden" name="region"
										value='<%=bean1.getRegion()%>'
										onkeyup=
	return limitlength(this, s0);
>
									<input type="hidden" name="editFrom" value='<%=editFrom%>' />

								</div>
							</div>
						</div>
					</div>
				

					<div class="row">
						<div class="col-md-6">
							<div class="form-group">
								<label class="control-label col-md-6">
									Employee Code:

								</label>

								<div class="col-md-6">
									<input type="text" readonly="true" name="employeeCode"
										maxlength="20" class="form-control" tabindex="4"
										value='<%=bean1.getEmpNumber()%>'
										onkeyup=
	return limitlength(this, 20);
>



								</div>
							</div>
						</div>
						<div class="col-md-6">
							<div class="form-group">
								<label class="control-label col-md-5">
									New Employee Code:
								</label>

								<div class="col-md-6">
									<input type="text" readonly="true" name="employeeCode"
										class="form-control" maxlength="50" tabindex="5"
										onblur="getNewEmployeeNumber();"
										value='<%=bean1.getNewEmployeeNumber()%>'
										onkeyup=
	return limitlength(this, 50);
>


								</div>
							</div>
						</div>
					</div>
				


					<div class="row">
						<div class="col-md-6">
							<div class="form-group">
								<label class="control-label col-md-6">
									Father's / Husband's Name:

								</label>
	<div class="col-md-6 input-group">
								<div class="col-md-6">
									<select name="select_fhname" disabled="disabled" tabindex="6"
										class="form-control">
										<option value='F'
											<%if(bean1.getFhFlag().trim().equals("F")){ out.println("selected");}%>>
											Father
										</option>
										<option value='H'
											<%if(bean1.getFhFlag().trim().equals("H")){ out.println("selected");}%>>
											Husband
										</option>
									</select></div>
										<div class="col-md-6">
									<input type="text" readonly="true" name="fhname"
										class="form-control" readonly="true" 
										tabindex="7"
										value='<%=bean1.getFhName()%>'
										onkeyup=return limitlength(this, 50);/>
</div>
								</div>
							</div>
						</div>
						<div class="col-md-6">
							<div class="form-group">
								<label class="control-label col-md-5">
									Sex:
								</label>

								<div class="col-md-6">
									<select name="sex" disabled="disabled" readonly="true"
										tabindex="8" class="form-control">
										<%String sex = bean1.getSex().trim();%>
										<option value="">
											[Select One]
										</option>
										<option value="M"
											<%if(sex.equals("M")){ out.println("selected");}%>>
											Male
										</option>
										<option value="F"
											<%if(sex.equals("F")){ out.println("selected");}%>>
											Female
										</option>

									</select>

								</div>
							</div>
						</div>
					</div>
			

					<div class="row">
						<div class="col-md-6">
							<div class="form-group">
								<label class="control-label col-md-6">
									Date of Birth:
								</label>

								<div class="col-md-6">
									<input type="text" readonly="true" name="dateofbirth"
										class="form-control" tabindex="9"
										onblur="retrimentDate();getPensionNumber();"
										value='<%=bean1.getDateofBirth()%>'
										onkeyup=
	return limitlength(this, 20);
>

								</div>
							</div>
						</div>
						<div class="col-md-6">
							<div class="form-group">
								<label class="control-label col-md-5">
									Date of Joining:
								</label>

								<div class="col-md-6">
									<input type="text" readonly="true" name="dateofjoining"
										class="form-control" tabindex="10"
										value='<%=bean1.getDateofJoining()%>'
										onkeyup=
	return limitlength(this, 20);
>

								</div>
							</div>
						</div>
					</div>
		

					<div class="row">
						<div class="col-md-6">
							<div class="form-group">
								<label class="control-label col-md-6">
									Employee Level:
								</label>

								<div class="col-md-6">
									<%String emplevel = bean1.getEmpLevel().trim();%>
									<select name="emplevel" disabled="disabled" tabindex="11"
										class="form-control"
										onchange="getDesegnation(document.forms[0].emplevel.value)">
										<option value="">
											[Select One]
										</option>
										<option value='E-9'
											<%if(emplevel.equals("E-9")){ out.println("selected");}%>>
											E-9,Executive Directior
										</option>
										<option value='E-8'
											<%if(emplevel.equals("E-8")){ out.println("selected");}%>>
											E-8,General Manager
										</option>
										<option value='E-7'
											<%if(emplevel.equals("E-7")){ out.println("selected");}%>>
											E-7,Jt. General Manager
										</option>
										<option value='E-6'
											<%if(emplevel.equals("E-6")){ out.println("selected");}%>>
											E-6,Deputy General Manager
										</option>
										<option value='E-5'
											<%if(emplevel.equals("E-5")){ out.println("selected");}%>>
											E-5,Asst. General Manager
										</option>
										<option value='E-4'
											<%if(emplevel.equals("E-4")){ out.println("selected");}%>>
											E-4,Senior Manager
										</option>
										<option value='E-3'
											<%if(emplevel.equals("E-3")){ out.println("selected");}%>>
											E-3,Manager
										</option>
										<option value='E-2'
											<%if(emplevel.equals("E-2")){ out.println("selected");}%>>
											E-2,Assistant Manager
										</option>
										<option value='E-1'
											<%if(emplevel.equals("E-1")){ out.println("selected");}%>>
											E-1,Junior Executive
										</option>
										<option value='NE-1'
											<%if(emplevel.equals("NE-1")){ out.println("selected");}%>>
											NE-1,Jr. Attendant
										</option>
										<option value='NE-2'
											<%if(emplevel.equals("NE-2")){ out.println("selected");}%>>
											NE-2,Attendant
										</option>
										<option value='NE-3'
											<%if(emplevel.equals("NE-3")){ out.println("selected");}%>>
											NE-3,Senior Attendant
										</option>
										<option value='NE-4'
											<%if(emplevel.equals("NE-4")){ out.println("selected");}%>>
											NE-4,Jr. Assistant
										</option>
										<option value='NE-5'
											<%if(emplevel.equals("NE-5")){ out.println("selected");}%>>
											NE-5,Assistant
										</option>
										<option value='NE-6'
											<%if(emplevel.equals("NE-6")){ out.println("selected");}%>>
											NE-6,Senior Assistant
										</option>
										<option value='NE-7'
											<%if(emplevel.equals("NE-7")){ out.println("selected");}%>>
											NE-7,Supervisor
										</option>
										<option value='NE-8'
											<%if(emplevel.equals("NE-8")){ out.println("selected");}%>>
											NE-8,Superintendent
										</option>
										<option value='NE-9'
											<%if(emplevel.equals("NE-9")){ out.println("selected");}%>>
											NE-9,Sr. Superintendent
										</option>
										<option value='NE-10'
											<%if(emplevel.equals("NE-10")){ out.println("selected");}%>>
											NE-10,Sr. Superintendent(SG)
										</option>
										<option value='B1'
											<%if(emplevel.equals("B1")){ out.println("selected");}%>>
											B1,Chairman
										</option>
										<option value='B2'
											<%if(emplevel.equals("B2")){ out.println("selected");}%>>
											B2,Member
										</option>
									</select>
								</div>
							</div>
						</div>
						<div class="col-md-6">
							<div class="form-group">
								<label class="control-label col-md-5">
									Designation:
								</label>

								<div class="col-md-6">
									<input type="text" name="desegnation" readonly="true"
										class="form-control" readonly="true" tabindex="12"
										value='<%=bean1.getDesegnation()%>'
										onkeyup=
	return limitlength(this, 20);
>

								</div>
							</div>
						</div>
					</div>
				
				




					<div class="row">
						<div class="col-md-6">
							<div class="form-group">
								<label class="control-label col-md-6">
									Discipline:
								</label>

								<div class="col-md-6">
									<%String department = bean1.getDepartment().trim();

				%>
									<select name="department" disabled="disabled" tabindex="13"
										class="form-control" style="display: inline;">
										<option value="">
											[Select One]
										</option>
										<%if (request.getAttribute("DepartmentList") != null) {
					ArrayList deptList = (ArrayList) request
							.getAttribute("DepartmentList");
					for (int i = 0; i < deptList.size(); i++) {
						boolean exist = false;
						EmpMasterBean deptBean = (EmpMasterBean) deptList
								.get(i);
						if (deptBean.getDepartment().equalsIgnoreCase(
								bean1.getDepartment().trim()))
							exist = true;
						if (exist) {

							%>
										<option value="<%=bean1.getDepartment().trim()%>"
											<% out.println("selected");%>>
											<%=bean1.getDepartment().trim()%>
										</option>
										<%} else {%>
										<option value="<%= deptBean.getDepartment()%>">
											<%=deptBean.getDepartment()%>
										</option>

										<%}
					}
				}%>

									</select>

								</div>
							</div>
						</div>
						<div class="col-md-6">
							<div class="form-group">
								<label class="control-label col-md-5">
									Division:
								</label>

								<div class="col-md-6">
									<%String division = bean1.getDivision().trim();

				%>
									<select name="division" disabled="disabled" tabindex="14"
										class="form-control">
										<option value="">
											[Select One]
										</option>
										<option value='NAD'
											<%if(division.equals("NAD")){ out.println("selected");}%>>
											NAD
										</option>
										<option value='IAD'
											<%if(division.equals("IAD")){ out.println("selected");}%>>
											IAD
										</option>
										<option value='Government Pension Optee'
											<%if(division.equals("Government Pension Optee")){ out.println("selected");}%>>
											Government Pension Optee
										</option>
									</select>
								</div>
							</div>
						</div>
					</div>
					<div style="height: 5px;">
					</div>

					<%ArrayList regionList = new ArrayList();
				String rgnName = "", region = "";
				HashMap map = new HashMap();
				CommonUtil commonUtil = new CommonUtil();
				String[] regionLst = null;
				Iterator regionIterator1 = null;
				// ArrayList airportList1=null;
				if (session.getAttribute("region") != null) {
					regionLst = (String[]) session.getAttribute("region");
				}

				for (int i = 0; i < regionLst.length; i++) {
					rgnName = regionLst[i];

					if (rgnName.equals("ALL-REGIONS")
							&& session.getAttribute("usertype").toString()
									.equals("Admin")) {
						map = new HashMap();
						map = commonUtil.getRegion();
						break;
					} else {
						map.put(new Integer(i), rgnName);

					}

				}
				Set keys = map.keySet();
				regionIterator1 = keys.iterator();

				%>


					<div class="row">
						<div class="col-md-6">
							<div class="form-group">
								<label class="control-label col-md-6">
									Separation Reason:
								</label>

								<div class="col-md-6">
									<select name="reason" disabled="disabled" tabindex="15"
										id="mySelect" onChange="swap();" class="form-control"
										style="display: inline;">
										<%String reason = bean1.getSeperationReason().trim();

				%>
										<option value="">
											[Select One]
										</option>
										<option value='Retirement'
											<%if(reason.equals("Retirement")){ out.println("selected");}%>>
											Retirement
										</option>
										<option value='Death'
											<%if(reason.equals("Death")){ out.println("selected");}%>>
											Death
										</option>
										<option value='Resignation'
											<%if(reason.equals("Resignation")){ out.println("selected");}%>>
											Resignation
										</option>
										<option value='Termination'
											<%if(reason.equals("Termination")){ out.println("selected");}%>>
											Termination
										</option>
										<option value='Option for Early Pension'
											<%if(reason.equals("Option for Early Pension")){ out.println("selected");}%>>
											Option for Early Pension
										</option>
										<option value='VRS'
											<%if(reason.equals("VRS")){ out.println("selected");}%>>
											VRS
										</option>
										<option value='REMOVED'
											<%if(reason.equals("REMOVED")){ out.println("selected");}%>>
											REMOVED
										</option>
										<option value='Other'
											<%if(reason.equals("Other")){ out.println("selected");}%>>
											Other
										</option>
									</select>
								</div>
							</div>
						</div>
						<div class="col-md-6">
							<div class="form-group">
								<label class="control-label col-md-5">
									Date of Separation:
								</label>

								<div class="col-md-6">
									<input type="text" name="seperationDate" readonly="true"
										class="form-control" tabindex="16"
										value='<%=bean1.getDateofSeperationDate()%>'
										onkeyup=
	return limitlength(this, 20);
>

								</div>
							</div>
						</div>
					</div>
					<div style="height: 5px;">
					</div>






					<div class="row">
						<div class="col-md-6">
							<div class="form-group">
								<label class="control-label col-md-6">
									Permanent Address:
								</label>

								<div class="col-md-6">
									<TEXTAREA name="paddress" tabindex="18" readonly="true"
										class="form-control" <%=bean1.getPermanentAddress()%>>
							</TEXTAREA>
								</div>
							</div>
						</div>
						<div class="col-md-6">
							<div class="form-group">
								<label class="control-label col-md-5">
									Temporary Address::
								</label>

								<div class="col-md-6">
									<TEXTAREA name="taddress" readonly="true" size="150"
										maxlength="150" class="form-control" tabindex="19">	<%=bean1.getTemporatyAddress()%>
												</TEXTAREA>
								</div>
							</div>
						</div>
					</div>
					<div style="height: 5px;">
					</div>



					<div class="row">
						<div class="col-md-6">
							<div class="form-group">
								<label class="control-label col-md-6">
									Pension Option Received:
								</label>

								<div class="col-md-6">
									<input type="text" name="wetherOption" readonly="true"
										class="form-control"
										value='<%=bean1.getWetherOption().trim()%>' tabindex="20"
										readonly="true">

								</div>
							</div>
						</div>
						<div class="col-md-6">
							<div class="form-group">
								<label class="control-label col-md-5">
									Whether Form2 Nomination Received:
								</label>

								<div class="col-md-6">
									<select name="form1" disabled="disabled" tabindex="21"
										class="form-control" onchange="show()">

										<%String form1 = bean1.getForm2Nomination().trim();

				%>
										<option value="">
											[Select One]
										</option>
										<option value="Yes"
											<%if(form1.equals("Yes")){ out.println("selected");}%>>
											Yes
										</option>
										<option value="No"
											<%if(form1.equals("No")){ out.println("selected");}%>>
											No
										</option>

									</select>
								</div>
							</div>
						</div>
					</div>
					<div style="height: 5px;">
					</div>
					<input type="hidden" name="cpfacno" value='<%=bean1.getCpfAcNo()%>'>
					<input type="hidden" name="empOldName"
						value='<%=bean1.getEmpName()%>'>
					<input type="hidden" name="empOldNumber"
						value='<%=bean1.getEmpNumber()%>'>


					<div class="row">
						<div class="col-md-6">
							<div class="form-group">
								<label class="control-label col-md-6">
									Date of Retirement:
								</label>

								<div class="col-md-6">
									<input type="text" name="dateOfAnnuation" readonly="true"
										class="form-control" tabindex="23"
										value='<%=bean1.getDateOfAnnuation()%>'>

								</div>
							</div>
						</div>
						<div class="col-md-6">
							<div class="form-group">
								<label class="control-label col-md-5">
									Email Id:
								</label>

								<div class="col-md-6">
									<input type="text" name="emailId" readonly="true"
										maxlength="50" class="form-control"
										onkeyup=
	return limitlength(this, 50);
value='<%=bean1.getEmailId()%>' tabindex="24">

								</div>
							</div>
						</div>
					</div>
					<div style="height: 5px;">
					</div>



					<div class="row">
						<div class="col-md-6">
							<div class="form-group">
								<label class="control-label col-md-6">
									Date of Super Annuation:
								</label>

								<div class="col-md-6">
									<input type="text" name="dateOfRetirement" readonly="true"
										class="form-control" tabindex="27"
										value='<%=bean1.getDateOfRetirement()%>'>

								</div>
							</div>
						</div>
						<div class="col-md-6">
							<div class="form-group">
								<label class="control-label col-md-5">
									Other Reason:
								</label>

								<div class="col-md-6">
									<input type="text" readonly="true" name="otherrearson"
										maxlength="20" class="form-control" tabindex="4"
										value='<%=bean1.getOtherReason()%>'
										onkeyup=
	return limitlength(this, 20);>

								</div>
							</div>
						</div>
					</div>
					<div style="height: 5px;">
					</div>



					<div class="row">
						<div class="col-md-6">
							<div class="form-group">
								<label class="control-label col-md-6">
									Remarks:
								</label>

								<div class="col-md-6">
									<TEXTAREA NAME="remarks" readonly="true" tabindex="25"
										class="form-control">
													<%=bean1.getRemarks()%>
												</TEXTAREA>
									<input type="hidden" name="ArrearInfo"
										value="<%=arrearInfoString1%>">
								</div>
							</div>
						</div>
						<div class="col-md-6">
							<div class="form-group">
								<label class="control-label col-md-5">
									Marital Status:
								</label>

								<div class="col-md-6">
									<%String maritalStatus = bean1.getMaritalStatus().trim();

				%>
									<select name="maritalStatus" disabled="disabled" tabindex="10"
										class="form-control">
										<option value="">
											[Select One]
										</option>
										<option value='Yes'
											<%if(maritalStatus.equals("Yes")){ out.println("selected");}%>>
											Yes
										</option>
										<option value='No'
											<%if(maritalStatus.equals("No")){ out.println("selected");}%>>
											No
										</option>
									</select>
								</div>
							</div>
						</div>
					</div>
					<div style="height: 5px;">
					</div>




		<div class="row">
						<div class="col-md-6">
							<div class="form-group">
								<label class="control-label col-md-6">Fresh Option
									
								 : </label>
								
								<div class="col-md-6">
								
									<input type="text" name="wetherOption" readonly="true" class="form-control" value='<%=bean1.getFreshPenOption().trim()%>' tabindex="20" readonly="true">
						
									</div>
							</div>
						</div>
						<div class="col-md-6">
							<div class="form-group">
								<label class="control-label col-md-5"> Deferement: 
								 : </label>
								
								<div class="col-md-6">
												<input type="text" name="deferement" class="form-control" readonly="true" value='<%=bean1.getDeferement().trim()%>' tabindex="20" readonly="true">
						
						</div>
							</div>
						</div>
					</div>
						<div style="height: 5px;">
		</div>
		
		
		
		
		<div class="row">
						<div class="col-md-6">
							<div class="form-group">
								<label class="control-label col-md-6">SBS Option
									
								 : </label>
								
								<div class="col-md-6">
								
									<input type="text" name="sbsflag" readonly="true" class="form-control" value='<%=bean1.getSbsflag().trim()%>' tabindex="20" readonly="true">
						
									</div>
							</div>
						</div>
						
					</div>
						<div style="height: 5px;">
		</div>




<% if(bean1.getDeferement().equals("Y")){ %>
		<div class="row">
						<div class="col-md-6">
							<div class="form-group">
								<label class="control-label col-md-6">	Deferement Pension
									
								 : </label>
								
								<div class="col-md-6">
								
									<select name="deferementpension" disabled="disabled" tabindex="10" class="form-control">
													<option value='WithContribution' <%if(bean1.getDeferementpension().equals("Y")){ out.println("selected");}%>>
														With Contribution
													</option>
													<option value='withOutContribution ' <%if(bean1.getDeferementpension().equals("N")){ out.println("selected");}%>>
														With Out Contribution
													</option>
												</select>			</div>
							</div>
						</div>
						<div class="col-md-6">
							<div class="form-group">
								<label class="control-label col-md-5"> Deferement Age: 
								 : </label>
								
								<div class="col-md-6">
												<input type="text" name="deferementage" class="form-control" readonly="true" value='<%=bean1.getDeferementage().trim()%>' tabindex="20" readonly="true">
									
						</div>
							</div>
						</div>
					</div>
						<div style="height: 20px;">
		</div>




<% }%>

<div class="row">
			<div class="col-md-12 background">
				<div class="form-group  col-md-12" style="padding: 12px;">
				<label class="control-label" style="text-decoration: underline;"><b>Family Details</b></label>
				</div>
			</div>
		 
		</div>




					
										
										<tr>
					<td>
					<div id="no-more-tables">
							<div class="row">
								<div class="col-md-12">
									<div class="form-group">
								<table class='col-md-12 table-bordered table-striped table-condensed cf'><thead class='cf'>
								<tr>
								<th class="" style="width: 33% !important;">Name</th>
								<th class="" style="width: 34% !important;">Date of Birth</th>
								<th class="" style="width: 33% !important;">Relation with member</th>
</tr></thead>
											

										<%int count = 0;
				String familyrows = bean1.getFamilyRow();

				ArrayList familyList = commonUtil.getTheList(familyrows, "***");

				String tempInfo[] = null;
				String tempData = "";
				String fMemberName = "", fDateofBirth = "", frelation = "", rowid = "";
				for (int i = 0; i < familyList.size(); i++) {

					tempData = familyList.get(i).toString();
					tempInfo = tempData.split("@");

					fMemberName = tempInfo[0];
					fDateofBirth = tempInfo[1];
					if (fDateofBirth.equals("xxx")) {
						fDateofBirth = "";
					}
					frelation = tempInfo[2];
					if (frelation.equals("xxx")) {
						frelation = "";
					}
					rowid = tempInfo[3];
					if (rowid.equals("xxx")) {
						rowid = "";
					}

					%>
					
					<tbody><TR id="name1<%=i%>">
										
											<td style="width: 33% !important;">
											

												<input type="text" readonly="readonly" name="FName" tabindex="24"  class="form-control" value='<%=fMemberName%>'>
												<input type="hidden" readonly="readonly" name="empOldFRName" value='<%=fMemberName%>'  class="form-control">
											</td>


											<td style="width: 34% !important;">
												
												<input type="text" readonly="readonly" name="Fdob" value='<%=fDateofBirth%>' tabindex="25"  class="form-control">
											</td>
											<td style="width: 33% !important;">
												
												<select name="Frelation" disabled="disabled" tabindex="26" class="form-control">

													<option value="">
														[Select One]
													</option>
													<option value='SPOUSE' <%if(frelation.equals("SPOUSE")){ out.println("selected");}%>>
														SPOUSE
													</option>
													<option value='SON' <%if(frelation.equals("SON")){ out.println("selected");}%>>
														SON
													</option>
													<option value='DAUGHTER' <%if(frelation.equals("DAUGHTER")){ out.println("selected");}%>>
														DAUGHTER
													</option>
													<option value='MOTHER' <%if(frelation.equals("MOTHER")){ out.println("selected");}%>>
														MOTHER
													</option>
													<option value='FATHER' <%if(frelation.equals("FATHER")){ out.println("selected");}%>>
														FATHER
													</option>
													<option value='SONS WIDOW' <%if(frelation.equals("SONS WIDOW")){ out.println("selected");}%>>
														SON'S WIDOW
													</option>
													<option value='WIDOWS DAUGHTER' <%if(frelation.equals("WIDOWS DAUGHTER")){ out.println("selected");}%>>
														WIDOW'S DAUGHTER
													</option>

													<option value='MOTHER-IN-LOW' <%if(frelation.equals("MOTHER-IN-LOW")){ out.println("selected");}%>>
														MOTHER-IN-LOW
													</option>
													<option value='FATHER-IN-LOW' <%if(frelation.equals("FATHER-IN-LOW")){ out.println("selected");}%>>
														FATHER-IN-LOW
													</option>

												</select>
											</td>
											<td>
												&nbsp;<b><img alt="Delete" src="<%=basePath%>PensionView/images/cancelIcon.gif" tabindex="27"></b>
											</td>
										</tr>


										<%}

				%>
								</tbody>	</table>
									</div></div></div></div></td></tr>
									<div id="divFamily1">
										<div id="no-more-tables">
							<div class="row">
								<div class="col-md-12">
									<div class="form-group">
								<table class='col-md-12 table-bordered table-striped table-condensed cf'>
											<tr>
												
												<td>
																<input type="text" readonly="readonly" name="FName"  class="form-control" tabindex="27">
												</td>
												<input type="hidden" readonly="readonly" name="empOldFRName" value=""  class="form-control">
												<td>
													
													<input type="text" name="Fdob" id="Fdob0" readonly="readonly" tabindex="28"  class="form-control">
												</td>
												<td>
												
													<select name="Frelation" disabled="disabled" tabindex="29"  class="form-control">
														<option value="">
															[Select One]
														</option>
														<option value='SPOUSE'>
															SPOUSE
														</option>
														<option value='SON'>
															SON
														</option>
														<option value='DAUGHTER'>
															DAUGHTER
														</option>
														<option value='MOTHER'>
															MOTHER
														</option>
														<option value='FATHER'>
															FATHER
														</option>
														<option value='SONS WIDOW'>
															SON'S WIDOW
														</option>
														<option value='WIDOWS DAUGHTER'>
															WIDOW'S DAUGHTER
														</option>
														<option value='MOTHER-IN-LOW'>
															MOTHER-IN-LOW
														</option>
														<option value='FATHER-IN-LOW'>
															FATHER-IN-LOW
														</option>

													</select>
												</td>

											</tr>
									</table></div>
									</div>
<div style="height: 20px;"></div>
									<div id="divFamily2"></div>

									<div id="divNomineeHead">
										
										
	<div style="height: 20px;"></div>					
<div class="row">
			<div class="col-md-12" style="padding: 12px">
				<div class="form-group col-md-12">
				<label class="control-label " style="text-decoration: underline;"><b>Nomination for PF</b></label>
				</div>
			</div>
		 
		</div>
										
									

						
						<div id="no-more-tables">
							<div class="row">
								<div class="col-md-12">
									<div class="form-group">
								<table class='col-md-12 table-bordered table-striped table-condensed cf'><thead class='cf'>
								<tr>
								
								<th class="" style="width:12%!important;">Name</th>
								<th class="" style="width:13%!important;">Address</th>
								<th class="" style="width:12%!important;">Dateof Birth</th>
								<th class="" style="width:15%!important;">Relation with Member</th>
								<th class="" style="width:18%!important;">Name of Guardian Status</th>
								<th class="" style="width:15%!important;">Address of Guardian  </th>
								<th class="" style="width:15%!important;" >Total Share 
payable in % </th>
												</tr></thead>

											<%int count1 = 0;
				String nomineeRows = bean1.getNomineeRow();

				CommonUtil commonUtil1 = new CommonUtil();
				ArrayList nomineeList = commonUtil.getTheList(nomineeRows,
						"***");

				String tempInfo1[] = null;
				String tempData1 = "";
				String nomineeAddress = "", nomineeDob = "", nomineeRelation = "", nameofGuardian = "", totalShare = "", addressofGuardian = "";
				for (int i = 0; i < nomineeList.size(); i++) {
					count1++;
					tempData = nomineeList.get(i).toString();
					tempInfo = tempData.split("@");
					String nomineeName = tempInfo[0];
					nomineeAddress = tempInfo[1];
					nomineeDob = tempInfo[2];
					nomineeRelation = tempInfo[3];
					nameofGuardian = tempInfo[4];
					addressofGuardian = tempInfo[5];
					totalShare = tempInfo[6];
					if (nomineeAddress.equals("xxx")) {
						nomineeAddress = "";
					}

					if (nomineeDob.equals("xxx")) {
						nomineeDob = "";
					}
					if (nomineeRelation.equals("xxx")) {
						nomineeRelation = "";
					}

					if (nameofGuardian.equals("xxx")) {
						nameofGuardian = "";
					}
					if (addressofGuardian.equals("xxx")) {
						addressofGuardian = "";
					}
					if (totalShare.equals("xxx")) {
						totalShare = "";
					}
					rowid = tempInfo[7];
					if (rowid.equals("xxx")) {
						rowid = "";
					}

					%>
											<tbody><tr id="name<%=i%>">
												<td style="width:12%!important;">
													<input type="text"  readonly="readonly" class="form-control" name="Nname" value='<%=nomineeName%>' tabindex="31">
													<input type="hidden" readonly="readonly" name="empOldNname" value='<%=nomineeName%>'>
												</td>
												<td style="width:13%!important;">
													<input type="text"  readonly="readonly" class="form-control" name="Naddress" value='<%=nomineeAddress%>' tabindex="32">
												</td>
												<td style="width:12%!important;">
													<input type="text" readonly="readonly" class="form-control"  name="Ndob" value='<%=nomineeDob%>' tabindex="33">
												</td>
												<td style="width:15%!important;">
													<select name="Nrelation" tabindex="34" class="form-control" disabled="disabled">
														<option value="">
															[Select One]
														</option>
														<option value='SPOUSE' <%if(nomineeRelation.equals("SPOUSE")){ out.println("selected");}%>>
															SPOUSE
														</option>
														<option value='SON' <%if(nomineeRelation.equals("SON")){ out.println("selected");}%>>
															SON
														</option>
														<option value='DAUGHTER' <%if(nomineeRelation.equals("DAUGHTER")){ out.println("selected");}%>>
															DAUGHTER
														</option>
														<option value='MOTHER' <%if(nomineeRelation.equals("MOTHER")){ out.println("selected");}%>>
															MOTHER
														</option>
														<option value='FATHER' <%if(nomineeRelation.equals("FATHER")){ out.println("selected");}%>>
															FATHER
														</option>
														<option value='SONS WIDOW' <%if(nomineeRelation.equals("SONS WIDOW")){ out.println("selected");}%>>
															SON'S WIDOW
														</option>
														<option value='WIDOWS DAUGHTER' <%if(nomineeRelation.equals("WIDOWS DAUGHTER")){ out.println("selected");}%>>
															WIDOW'S DAUGHTER
														</option>

														<option value='MOTHER-IN-LOW' <%if(nomineeRelation.equals("MOTHER-IN-LOW")){ out.println("selected");}%>>
															MOTHER-IN-LOW
														</option>
														<option value='FATHER-IN-LOW' <%if(nomineeRelation.equals("FATHER-IN-LOW")){ out.println("selected");}%>>
															FATHER-IN-LOW
														</option>
													</select>
												</td>
												<td style="width:18%!important;">
													<input type="text" class="form-control" readonly="true" name="guardianname"  value='<%=nameofGuardian%>' tabindex="35">
												</td>
												<td style="width:15%!important;">
													<input type="text"  class="form-control" readonly="true" name="gaddress"  value='<%=addressofGuardian%>' tabindex="36">
												</td>
												<td style="width:15%!important;">
													<input type="text"  class="form-control" readonly="true" name="totalshare" value='<%=totalShare%>' onkeypress="numsDotOnly()" tabindex="37">
												</td>
												<!-- <td>
													<b><img alt="Delete" src="<%=basePath%>PensionView/images/cancelIcon.gif" tabindex="27"></b>
												</td>-->


											</tr>
											<%}

			%>
											<%}

			%>

										
										<div>
											<div id="divNominee1">
												<div class="row">
								<div class="col-md-12">
									<div class="form-group">
								<table class='col-md-12 table-bordered table-striped table-condensed cf'>
													<tr>
														<td style="width:12%!important;">
															
															<input type="text"  name="Nname" readonly="readonly" class="form-control" onblur="dispOff()">
														
															
															<input type="hidden" name="empOldNname" value="">
														</td>

														<td style="width:13%!important;">
															<input type="text" readonly="readonly" name="Naddress"  class="form-control" tabindex="40">
														</td>
														<td style="width:12%!important;">
														
															<input type="text" readonly="readonly" class="form-control"  name="Ndob" tabindex="41">
														

														</td>
														<td style="width:15%!important;">
															<select name="Nrelation" tabindex="40" class="form-control" disabled="disabled">
																<option value="">
																	[Select One]
																</option>
																<option value='SPOUSE'>
																	SPOUSE
																</option>
																<option value='SON'>
																	SON
																</option>
																<option value='DAUGHTER'>
																	DAUGHTER
																</option>
																<option value='MOTHER'>
																	MOTHER
																</option>
																<option value='FATHER'>
																	FATHER
																</option>
																<option value='SONS WIDOW'>
																	SON'S WIDOW
																</option>
																<option value='WIDOWS DAUGHTER'>
																	WIDOW'S DAUGHTER
																</option>
																<option value='MOTHER-IN-LOW'>
																	MOTHER-IN-LOW
																</option>
																<option value='FATHER-IN-LOW'>
																	FATHER-IN-LOW
																</option>

															</select>
														</td>
														<td style="width:18%!important;">
															
															<input type="text" name="guardianname" class="form-control" readonly="true" tabindex="42">
														</td>
														<td style="width:15%!important;">
														
															<input type="text" readonly="true"  class="form-control" name="gaddress"  tabindex="43">
														
														</td>
														<td style="width:15%!important;">
															
															<input type="text" readonly="true"  name="totalshare"  class="form-control" onkeypress="numsDotOnly()" tabindex="44">
														</td>
														

													</tr>
												
											</div>

											<div id="divNominee2"></div>

											<input type="hidden" name="flagData" value="<%=request.getAttribute("flag")%>">
							
						
					</tbody></table>
			<div style="height: 20px;">
		</div>			
			<div class="col-md-12"  style="margin-top: 20px;">
									<div class="col-md-6">&nbsp;</div>
									<div class="col-md-6">
													<input type="button" class="btn green"  value="Back" onclick="javascript:history.back(-1)" />
						
									</div>
								
								</div>
						
							</div>
						</div>

					</div>
		</form>
	</body>
</html>



