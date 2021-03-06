package aims.bean;

import java.util.ArrayList;

public class LicBean {
	private String memberName="",employeeNo="",empsapCode="",dob="",doj="",exitReason="",dateOfexit="",chosenOp="",aaiEDCPSoption="",aaiEDCPSoptionDesc="";
	private String spouseName="",spouseAdd="",spouseDob="",spouseRelation="",paymentMode="";
	private String memberAddress="",memberPerAdd="",nomineeName="",relationtoMember="",nomineeDob="",panNo="",adharno="",mobilNo="",email="",mobilNo1="",nomineeName2="",nomineeName3="";
	private String customerName="",bankName="",branch="",ifscCode="",accType="",accNo="",micrCode="";
	private String customerName2="",bankName2="",branch2="",ifscCode2="",accType2="",accNo2="",micrCode2="";
	private String claimForm="",identityCard="",paySlip="",panCard="",adharCard="",cancelCheque="",photograph="",percentage="",deceasedemployee="",nominationdoc="",nomineeproof="",totcorpus2lakhs="",deathcertficate="";
	private ArrayList nomineeList=null;
	private ArrayList nomineeAppointeeList=null;
	private ArrayList depList=null;
	private String airport="",region="",dos="",policyStartDate="",policyNo="",policyPensionAmt="";
	private String unitType="",userName="",rhqHrDesignation="",rhqFinDesignation="",chqHrApprovedate="",chqhrDesig="",chqHrDisp="",EdcpApproveDate2="";
	private String month="",year="",finYear="";
	private ArrayList rejectedList=null;
	
	
	public ArrayList getRejectedList() {
		return rejectedList;
	}
	public void setRejectedList(ArrayList rejectedList) {
		this.rejectedList = rejectedList;
	}
	public String getEmpsapCode() {
		return empsapCode;
	}
	public void setEmpsapCode(String empsapCode) {
		this.empsapCode = empsapCode;
	}
	public String getMonth() {
		return month;
	}
	public void setMonth(String month) {
		this.month = month;
	}
	public String getYear() {
		return year;
	}
	public void setYear(String year) {
		this.year = year;
	}
	public String getFinYear() {
		return finYear;
	}
	public void setFinYear(String finYear) {
		this.finYear = finYear;
	}
	
	public String getDesignation() {
		return designation;
	}
	public void setDesignation(String designation) {
		this.designation = designation;
	}
	
	public String getCustomerName() {
		return customerName;
	}
	public void setCustomerName(String customerName) {
		this.customerName = customerName;
	}
	public String getCustomerName2() {
		return customerName2;
	}
	public void setCustomerName2(String customerName2) {
		this.customerName2 = customerName2;
	}
	public String getBankName2() {
		return bankName2;
	}
	public void setBankName2(String bankName2) {
		this.bankName2 = bankName2;
	}
	public String getBranch2() {
		return branch2;
	}
	public void setBranch2(String branch2) {
		this.branch2 = branch2;
	}
	public String getIfscCode2() {
		return ifscCode2;
	}
	public void setIfscCode2(String ifscCode2) {
		this.ifscCode2 = ifscCode2;
	}
	public String getAccType2() {
		return accType2;
	}
	public void setAccType2(String accType2) {
		this.accType2 = accType2;
	}
	public String getAccNo2() {
		return accNo2;
	}
	public void setAccNo2(String accNo2) {
		this.accNo2 = accNo2;
	}
	
	public String getMicrCode2() {
		return micrCode2;
	}
	public void setMicrCode2(String micrCode2) {
		this.micrCode2 = micrCode2;
	}
	
	
	
	
	
	
	
	
	public String getRhqHrDesignation() {
		return rhqHrDesignation;
	}
	public String getEdcpApproveDate2() {
		return EdcpApproveDate2;
	}
	public void setEdcpApproveDate2(String edcpApproveDate2) {
		EdcpApproveDate2 = edcpApproveDate2;
	}
	public String getChqHrApprovedate() {
		return chqHrApprovedate;
	}
	public void setChqHrApprovedate(String chqHrApprovedate) {
		this.chqHrApprovedate = chqHrApprovedate;
	}
	public String getChqhrDesig() {
		return chqhrDesig;
	}
	public void setChqhrDesig(String chqhrDesig) {
		this.chqhrDesig = chqhrDesig;
	}
	public String getChqHrDisp() {
		return chqHrDisp;
	}
	public void setChqHrDisp(String chqHrDisp) {
		this.chqHrDisp = chqHrDisp;
	}
	public void setRhqHrDesignation(String rhqHrDesignation) {
		this.rhqHrDesignation = rhqHrDesignation;
	}
	public String getRhqFinDesignation() {
		return rhqFinDesignation;
	}
	public void setRhqFinDesignation(String rhqFinDesignation) {
		this.rhqFinDesignation = rhqFinDesignation;
	}
	public String getUnitType() {
		return unitType;
	}
	public void setUnitType(String unitType) {
		this.unitType = unitType;
	}
	public String getUserName() {
		return userName;
	}
	public void setUserName(String userName) {
		this.userName = userName;
	}
	public String getPolicyStartDate() {
		return policyStartDate;
	}
	public void setPolicyStartDate(String policyStartDate) {
		this.policyStartDate = policyStartDate;
	}
	public String getPolicyNo() {
		return policyNo;
	}
	public void setPolicyNo(String policyNo) {
		this.policyNo = policyNo;
	}
	public String getPolicyPensionAmt() {
		return policyPensionAmt;
	}
	public void setPolicyPensionAmt(String policyPensionAmt) {
		this.policyPensionAmt = policyPensionAmt;
	}
	private String intcalcdate="",edcpCorpusAmt="",edcpCorpusint="",tdsrec="",edcpApproveDate="",designation="",ackApproveDate="",hrApproveDate="",finApproveDate="",rhqHrApproveDate="",rhqFinApproveDate="";
	private String hr1designation="",hr2designation="",findesignation="",hr1displayname="",hr2displayname="",findisplayname="",rhqHrDisplayname="",rhqFinDisplayname="";
	public String getRhqHrApproveDate() {
		return rhqHrApproveDate;
	}
	public void setRhqHrApproveDate(String rhqHrApproveDate) {
		this.rhqHrApproveDate = rhqHrApproveDate;
	}
	public String getRhqFinApproveDate() {
		return rhqFinApproveDate;
	}
	public void setRhqFinApproveDate(String rhqFinApproveDate) {
		this.rhqFinApproveDate = rhqFinApproveDate;
	}
	public String getRhqHrDisplayname() {
		return rhqHrDisplayname;
	}
	public void setRhqHrDisplayname(String rhqHrDisplayname) {
		this.rhqHrDisplayname = rhqHrDisplayname;
	}
	public String getRhqFinDisplayname() {
		return rhqFinDisplayname;
	}
	public void setRhqFinDisplayname(String rhqFinDisplayname) {
		this.rhqFinDisplayname = rhqFinDisplayname;
	}
	private String edcpApproveDate1="",edcpDisplayname1="",edcpDesignation1="",eligibleStatus="",newEmpCode="";
	private String rhqHrIntDate="",rhqHrPurchaseAmt="",rhqFinIntDate="",rhqFinPurchaseAmt="";
	
	public String getRhqFinIntDate() {
		return rhqFinIntDate;
	}
	public void setRhqFinIntDate(String rhqFinIntDate) {
		this.rhqFinIntDate = rhqFinIntDate;
	}
	public String getRhqFinPurchaseAmt() {
		return rhqFinPurchaseAmt;
	}
	public void setRhqFinPurchaseAmt(String rhqFinPurchaseAmt) {
		this.rhqFinPurchaseAmt = rhqFinPurchaseAmt;
	}
	public String getRhqHrIntDate() {
		return rhqHrIntDate;
	}
	public void setRhqHrIntDate(String rhqHrIntDate) {
		this.rhqHrIntDate = rhqHrIntDate;
	}
	public String getRhqHrPurchaseAmt() {
		return rhqHrPurchaseAmt;
	}
	public void setRhqHrPurchaseAmt(String rhqHrPurchaseAmt) {
		this.rhqHrPurchaseAmt = rhqHrPurchaseAmt;
	}
	public String getNewEmpCode() {
		return newEmpCode;
	}
	public void setNewEmpCode(String newEmpCode) {
		this.newEmpCode = newEmpCode;
	}
	public String getEligibleStatus() {
		return eligibleStatus;
	}
	public void setEligibleStatus(String eligibleStatus) {
		this.eligibleStatus = eligibleStatus;
	}
	public String getEdcpApproveDate1() {
		return edcpApproveDate1;
	}
	public void setEdcpApproveDate1(String edcpApproveDate1) {
		this.edcpApproveDate1 = edcpApproveDate1;
	}
	public String getEdcpDisplayname1() {
		return edcpDisplayname1;
	}
	public void setEdcpDisplayname1(String edcpDisplayname1) {
		this.edcpDisplayname1 = edcpDisplayname1;
	}
	public String getEdcpDesignation1() {
		return edcpDesignation1;
	}
	public void setEdcpDesignation1(String edcpDesignation1) {
		this.edcpDesignation1 = edcpDesignation1;
	}
	public String getHr1designation() {
		return hr1designation;
	}
	public void setHr1designation(String hr1designation) {
		this.hr1designation = hr1designation;
	}
	public String getHr2designation() {
		return hr2designation;
	}
	public void setHr2designation(String hr2designation) {
		this.hr2designation = hr2designation;
	}
	public String getFindesignation() {
		return findesignation;
	}
	public void setFindesignation(String findesignation) {
		this.findesignation = findesignation;
	}
	public String getHr1displayname() {
		return hr1displayname;
	}
	public void setHr1displayname(String hr1displayname) {
		this.hr1displayname = hr1displayname;
	}
	public String getHr2displayname() {
		return hr2displayname;
	}
	public void setHr2displayname(String hr2displayname) {
		this.hr2displayname = hr2displayname;
	}
	public String getFindisplayname() {
		return findisplayname;
	}
	public void setFindisplayname(String findisplayname) {
		this.findisplayname = findisplayname;
	}
	public String getAaiEDCPSoptionDesc() {
		return aaiEDCPSoptionDesc;
	}
	public void setAaiEDCPSoptionDesc(String aaiEDCPSoptionDesc) {
		this.aaiEDCPSoptionDesc = aaiEDCPSoptionDesc;
	}
	public String getAckApproveDate() {
		return ackApproveDate;
	}
	public void setAckApproveDate(String ackApproveDate) {
		this.ackApproveDate = ackApproveDate;
	}
	public String getHrApproveDate() {
		return hrApproveDate;
	}
	public void setHrApproveDate(String hrApproveDate) {
		this.hrApproveDate = hrApproveDate;
	}
	public String getFinApproveDate() {
		return finApproveDate;
	}
	public void setFinApproveDate(String finApproveDate) {
		this.finApproveDate = finApproveDate;
	}
	public String getDos() {
		return dos;
	}
	public void setDos(String dos) {
		this.dos = dos;
	}
	public String getEdcpApproveDate() {
		return edcpApproveDate;
	}
	public void setEdcpApproveDate(String edcpApproveDate) {
		this.edcpApproveDate = edcpApproveDate;
	}
	
	public String getIntcalcdate() {
		return intcalcdate;
	}
	public void setIntcalcdate(String intcalcdate) {
		this.intcalcdate = intcalcdate;
	}
	public String getEdcpCorpusAmt() {
		return edcpCorpusAmt;
	}
	public void setEdcpCorpusAmt(String edcpCorpusAmt) {
		this.edcpCorpusAmt = edcpCorpusAmt;
	}
	public String getEdcpCorpusint() {
		return edcpCorpusint;
	}
	public void setEdcpCorpusint(String edcpCorpusint) {
		this.edcpCorpusint = edcpCorpusint;
	}
	public String getTdsrec() {
		return tdsrec;
	}
	public void setTdsrec(String tdsrec) {
		this.tdsrec = tdsrec;
	}
	public String getMobilNo1() {
		return mobilNo1;
	}
	public void setMobilNo1(String mobilNo1) {
		this.mobilNo1 = mobilNo1;
	}
	private String ddDate="",ddNo="";
	public String getDdDate() {
		return ddDate;
	}
	public void setDdDate(String ddDate) {
		this.ddDate = ddDate;
	}
	public String getDdNo() {
		return ddNo;
	}
	public void setDdNo(String ddNo) {
		this.ddNo = ddNo;
	}
	public String getAirport() {
		return airport;
	}
	public void setAirport(String airport) {
		this.airport = airport;
	}
	public String getRegion() {
		return region;
	}
	public void setRegion(String region) {
		this.region = region;
	}
	private String ctv="",state="",pinCode="",fatherName="",nationality="",gender="",secAnnuitantPAN="",corpusAmt="";
	
	private String ackApprove="",hrNodalApprove="",finApprove="",rhqHrApprove="",rhqFinApprove="",chqHrApprove="",chqFinApprove="",edcpApprove="";

	
	public String getAckApprove() {
		return ackApprove;
	}
	public void setAckApprove(String ackApprove) {
		this.ackApprove = ackApprove;
	}
	public String getHrNodalApprove() {
		return hrNodalApprove;
	}
	public void setHrNodalApprove(String hrNodalApprove) {
		this.hrNodalApprove = hrNodalApprove;
	}
	public String getFinApprove() {
		return finApprove;
	}
	public void setFinApprove(String finApprove) {
		this.finApprove = finApprove;
	}
	public String getRhqHrApprove() {
		return rhqHrApprove;
	}
	public void setRhqHrApprove(String rhqHrApprove) {
		this.rhqHrApprove = rhqHrApprove;
	}
	public String getRhqFinApprove() {
		return rhqFinApprove;
	}
	public void setRhqFinApprove(String rhqFinApprove) {
		this.rhqFinApprove = rhqFinApprove;
	}
	public String getChqHrApprove() {
		return chqHrApprove;
	}
	public void setChqHrApprove(String chqHrApprove) {
		this.chqHrApprove = chqHrApprove;
	}
	public String getChqFinApprove() {
		return chqFinApprove;
	}
	public void setChqFinApprove(String chqFinApprove) {
		this.chqFinApprove = chqFinApprove;
	}
	public String getEdcpApprove() {
		return edcpApprove;
	}
	public void setEdcpApprove(String edcpApprove) {
		this.edcpApprove = edcpApprove;
	}
	private String serviceBook="",cpse="",cad="",crs="",resign="",vrs="",deputation="",arrear="",notionalIncrement="",notionaldisplay="",obadjustment="";
	private String finNoIncrement="",finArrear="",finPreOBadj="",obOtherReason="",finOBadjCorpusCard="",finCorpusVerified="";
	private String corpusOBAdjustment="",obRemarks="",depaaiToOtherorg="",secAnnuitantGender="";
	public String getSecAnnuitantGender() {
		return secAnnuitantGender;
	}
	public void setSecAnnuitantGender(String secAnnuitantGender) {
		this.secAnnuitantGender = secAnnuitantGender;
	}
	public String getCorpusAmt() {
		return corpusAmt;
	}
	public void setCorpusAmt(String corpusAmt) {
		this.corpusAmt = corpusAmt;
	}
	public String getSecAnnuitantPAN() {
		return secAnnuitantPAN;
	}
	public void setSecAnnuitantPAN(String secAnnuitantPAN) {
		this.secAnnuitantPAN = secAnnuitantPAN;
	}
	public String getGender() {
		return gender;
	}
	public void setGender(String gender) {
		this.gender = gender;
	}
	public String getCtv() {
		return ctv;
	}
	public void setCtv(String ctv) {
		this.ctv = ctv;
	}
	public String getState() {
		return state;
	}
	public void setState(String state) {
		this.state = state;
	}
	public String getPinCode() {
		return pinCode;
	}
	public void setPinCode(String pinCode) {
		this.pinCode = pinCode;
	}
	public String getFatherName() {
		return fatherName;
	}
	public void setFatherName(String fatherName) {
		this.fatherName = fatherName;
	}
	public String getNationality() {
		return nationality;
	}
	public void setNationality(String nationality) {
		this.nationality = nationality;
	}
	
	public ArrayList getDepList() {
		return depList;
	}
	public void setDepList(ArrayList depList) {
		this.depList = depList;
	}
	public String getCorpusOBAdjustment() {
		return corpusOBAdjustment;
	}
	public void setCorpusOBAdjustment(String corpusOBAdjustment) {
		this.corpusOBAdjustment = corpusOBAdjustment;
	}
	public String getObRemarks() {
		return obRemarks;
	}
	public void setObRemarks(String obRemarks) {
		this.obRemarks = obRemarks;
	}
	public String getDepaaiToOtherorg() {
		return depaaiToOtherorg;
	}
	public void setDepaaiToOtherorg(String depaaiToOtherorg) {
		this.depaaiToOtherorg = depaaiToOtherorg;
	}
	
	public String getFinNoIncrement() {
		return finNoIncrement;
	}
	public void setFinNoIncrement(String finNoIncrement) {
		this.finNoIncrement = finNoIncrement;
	}
	public String getFinArrear() {
		return finArrear;
	}
	public void setFinArrear(String finArrear) {
		this.finArrear = finArrear;
	}
	public String getFinPreOBadj() {
		return finPreOBadj;
	}
	public void setFinPreOBadj(String finPreOBadj) {
		this.finPreOBadj = finPreOBadj;
	}
	public String getObOtherReason() {
		return obOtherReason;
	}
	public void setObOtherReason(String obOtherReason) {
		this.obOtherReason = obOtherReason;
	}
	public String getFinOBadjCorpusCard() {
		return finOBadjCorpusCard;
	}
	public void setFinOBadjCorpusCard(String finOBadjCorpusCard) {
		this.finOBadjCorpusCard = finOBadjCorpusCard;
	}
	public String getFinCorpusVerified() {
		return finCorpusVerified;
	}
	public void setFinCorpusVerified(String finCorpusVerified) {
		this.finCorpusVerified = finCorpusVerified;
	}
	public String getServiceBook() {
		return serviceBook;
	}
	public void setServiceBook(String serviceBook) {
		this.serviceBook = serviceBook;
	}
	public String getCpse() {
		return cpse;
	}
	public void setCpse(String cpse) {
		this.cpse = cpse;
	}
	public String getCad() {
		return cad;
	}
	public void setCad(String cad) {
		this.cad = cad;
	}
	public String getCrs() {
		return crs;
	}
	public void setCrs(String crs) {
		this.crs = crs;
	}
	public String getResign() {
		return resign;
	}
	public void setResign(String resign) {
		this.resign = resign;
	}
	public String getVrs() {
		return vrs;
	}
	public void setVrs(String vrs) {
		this.vrs = vrs;
	}
	public String getDeputation() {
		return deputation;
	}
	public void setDeputation(String deputation) {
		this.deputation = deputation;
	}
	public String getArrear() {
		return arrear;
	}
	public void setArrear(String arrear) {
		this.arrear = arrear;
	}
	public String getNotionalIncrement() {
		return notionalIncrement;
	}
	public void setNotionalIncrement(String notionalIncrement) {
		this.notionalIncrement = notionalIncrement;
	}
	public String getNotionaldisplay() {
		return notionaldisplay;
	}
	public void setNotionaldisplay(String notionaldisplay) {
		this.notionaldisplay = notionaldisplay;
	}
	public String getObadjustment() {
		return obadjustment;
	}
	public void setObadjustment(String obadjustment) {
		this.obadjustment = obadjustment;
	}
	public ArrayList getNomineeList() {
		return nomineeList;
	}
	public void setNomineeList(ArrayList nomineeList) {
		this.nomineeList = nomineeList;
	}
	public ArrayList getNomineeAppointeeList() {
		return nomineeAppointeeList;
	}
	public void setNomineeAppointeeList(ArrayList nomineeAppointeeList) {
		this.nomineeAppointeeList = nomineeAppointeeList;
	}
	public String getPercentage() {
		return percentage;
	}
	public void setPercentage(String percentage) {
		this.percentage = percentage;
	}
	public String getClaimForm() {
		return claimForm;
	}
	public void setClaimForm(String claimForm) {
		this.claimForm = claimForm;
	}
	public String getIdentityCard() {
		return identityCard;
	}
	public void setIdentityCard(String identityCard) {
		this.identityCard = identityCard;
	}
	public String getPaySlip() {
		return paySlip;
	}
	public void setPaySlip(String paySlip) {
		this.paySlip = paySlip;
	}
	public String getPanCard() {
		return panCard;
	}
	public void setPanCard(String panCard) {
		this.panCard = panCard;
	}
	public String getAdharCard() {
		return adharCard;
	}
	public void setAdharCard(String adharCard) {
		this.adharCard = adharCard;
	}
	public String getCancelCheque() {
		return cancelCheque;
	}
	public void setCancelCheque(String cancelCheque) {
		this.cancelCheque = cancelCheque;
	}
	public String getPhotograph() {
		return photograph;
	}
	public void setPhotograph(String photograph) {
		this.photograph = photograph;
	}
	public String getDeceasedemployee() {
		return deceasedemployee;
	}
	public void setDeceasedemployee(String deceasedemployee) {
		this.deceasedemployee = deceasedemployee;
	}
	public String getNominationdoc() {
		return nominationdoc;
	}
	public void setNominationdoc(String nominationdoc) {
		this.nominationdoc = nominationdoc;
	}
	
	public String getNomineeproof() {
		return nomineeproof;
	}
	public void setNomineeproof(String nomineeproof) {
		this.nomineeproof = nomineeproof;
	}
	
	public String getTotcorpus2lakhs() {
		return totcorpus2lakhs;
	}
	public void setTotcorpus2lakhs(String totcorpus2lakhs) {
		this.totcorpus2lakhs = totcorpus2lakhs;
	}
	
	public String getDeathcertficate() {
		return deathcertficate;
	}
	public void setDeathcertficate(String deathcertficate) {
		this.deathcertficate = deathcertficate;
	}
	
	public String getMicrCode() {
		return micrCode;
	}
	public void setMicrCode(String micrCode) {
		this.micrCode = micrCode;
	}
	private String appId="",appDate="",formType="",status="";
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	public String getFormType() {
		return formType;
	}
	public void setFormType(String formType) {
		this.formType = formType;
	}
	
	public String toString() {
		String RetunStr="";
		if(jvNumber.equals("")) {
		String icon=status.equals("A")?"<i class=\"fa fa-lock\" aria-hidden=\"true\" style=\"color:#378fe7;font-size:15px\"></i>":"<i class=\"fa fa-edit\" style=\"color:#378fe7;font-size:15px\"></i>";
		RetunStr= "['<a  onclick=javascript:goToApprove(\""+appId+"\",\""+status+"\")>"+icon+"</a>'" +
				//"['<button name=Approve class=\"btn btn-success\" value=Approve onclick=javascript:goToApprove(\""+appId+"\",\""+status+"\")>Approve</button>'" +
				"" +
				",'ANNUITY/" + formType+"/"+ appId + "     <a onclick=javascript:getReport(\""+appId+"\")><i class=\"fa fa-print\" aria-hidden=\"true\" style=\"color:#378fe7;font-size:15px\"  title=\"View Application\"></i></a> ', '" + memberName
				+ "', '" + employeeNo + "','" + region + "', '" + status
				+ "','" + appDate + "','<a onclick=javascript:print(\""+appId+"\",\""+status+"\")><i class=\"fa fa-file-text\" aria-hidden=\"true\" style=\"color:#378fe7;font-size:15px\"></i></a>']";
	}
		else {
			RetunStr= "[ '" + jvNumber+"' , '" + memberName
					+ "', '" + empsapCode + "','" + appId + "','" + appDate + "','<a onclick=javascript:print(\""+jvId+"\")><i class=\"fa fa-file-text\" aria-hidden=\"true\" style=\"color:#378fe7;font-size:15px\"></i></a>']";
		
			
		}
		return RetunStr;
	}	
	public String toString1() {
		String icon=status.equals("A")?"<i class=\"fa fa-lock\" aria-hidden=\"true\" style=\"color:#378fe7;font-size:15px\"></i>":"<i class=\"fa fa-edit\" style=\"color:#378fe7;font-size:15px\"></i>";
		return "['<a  onclick=javascript:goToApprove(\""+appId+"\",\""+status+"\")>"+icon+"</a>'" +
				//"['<button name=Approve class=\"btn btn-success\" value=Approve onclick=javascript:goToApprove(\""+appId+"\",\""+status+"\")>Approve</button>'" +
				"" +
				",'ANNUITY/" + formType+"/"+ appId + "     <a onclick=javascript:getReport(\""+appId+"\")><i class=\"fa fa-print\" aria-hidden=\"true\" style=\"color:#378fe7;font-size:15px\"  title=\"View Application\"></i></a> ', '" + memberName
				+ "','" + region + "', '" + employeeNo + "', '" + status
				+ "','" + appDate + "','<a onclick=javascript:print(\""+appId+"\",\""+status+"\")><i class=\"fa fa-file-text\" aria-hidden=\"true\" style=\"color:#378fe7;font-size:15px\"></i></a>']";
	}
	
	public String getAppId() {
		return appId;
	}
	public void setAppId(String appId) {
		this.appId = appId;
	}
	public String getAppDate() {
		return appDate;
	}
	public void setAppDate(String appDate) {
		this.appDate = appDate;
	}
	public String getMemberName() {
		return memberName;
	}
	public void setMemberName(String memberName) {
		this.memberName = memberName;
	}
	public String getEmployeeNo() {
		return employeeNo;
	}
	public void setEmployeeNo(String employeeNo) {
		this.employeeNo = employeeNo;
	}
	public String getDob() {
		return dob;
	}
	public void setDob(String dob) {
		this.dob = dob;
	}
	public String getDoj() {
		return doj;
	}
	public void setDoj(String doj) {
		this.doj = doj;
	}
	public String getExitReason() {
		return exitReason;
	}
	public void setExitReason(String exitReason) {
		this.exitReason = exitReason;
	}
	public String getDateOfexit() {
		return dateOfexit;
	}
	public void setDateOfexit(String dateOfexit) {
		this.dateOfexit = dateOfexit;
	}
	public String getChosenOp() {
		return chosenOp;
	}
	public void setChosenOp(String chosenOp) {
		this.chosenOp = chosenOp;
	}
	public String getAaiEDCPSoption() {
		return aaiEDCPSoption;
	}
	public void setAaiEDCPSoption(String aaiEDCPSoption) {
		this.aaiEDCPSoption = aaiEDCPSoption;
	}
	public String getSpouseName() {
		return spouseName;
	}
	public void setSpouseName(String spouseName) {
		this.spouseName = spouseName;
	}
	public String getSpouseAdd() {
		return spouseAdd;
	}
	public void setSpouseAdd(String spouseAdd) {
		this.spouseAdd = spouseAdd;
	}
	public String getSpouseDob() {
		return spouseDob;
	}
	public void setSpouseDob(String spouseDob) {
		this.spouseDob = spouseDob;
	}
	public String getSpouseRelation() {
		return spouseRelation;
	}
	public void setSpouseRelation(String spouseRelation) {
		this.spouseRelation = spouseRelation;
	}
	public String getPaymentMode() {
		return paymentMode;
	}
	public void setPaymentMode(String paymentMode) {
		this.paymentMode = paymentMode;
	}
	public String getMemberAddress() {
		return memberAddress;
	}
	public void setMemberAddress(String memberAddress) {
		this.memberAddress = memberAddress;
	}
	public String getMemberPerAdd() {
		return memberPerAdd;
	}
	public void setMemberPerAdd(String memberPerAdd) {
		this.memberPerAdd = memberPerAdd;
	}
	public String getNomineeName() {
		return nomineeName;
	}
	public void setNomineeName(String nomineeName) {
		this.nomineeName = nomineeName;
	}
	public String getNomineeName2() {
		return nomineeName2;
	}
	public void setNomineeName2(String nomineeName2) {
		this.nomineeName2 = nomineeName2;
	}
	
	public String getNomineeName3() {
		return nomineeName3;
	}
	public void setNomineeName3(String nomineeName3) {
		this.nomineeName3 = nomineeName3;
	}
	public String getRelationtoMember() {
		return relationtoMember;
	}
	public void setRelationtoMember(String relationtoMember) {
		this.relationtoMember = relationtoMember;
	}
	public String getNomineeDob() {
		return nomineeDob;
	}
	public void setNomineeDob(String nomineeDob) {
		this.nomineeDob = nomineeDob;
	}
	public String getPanNo() {
		return panNo;
	}
	public void setPanNo(String panNo) {
		this.panNo = panNo;
	}
	public String getAdharno() {
		return adharno;
	}
	public void setAdharno(String adharno) {
		this.adharno = adharno;
	}
	public String getMobilNo() {
		return mobilNo;
	}
	public void setMobilNo(String mobilNo) {
		this.mobilNo = mobilNo;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getBankName() {
		return bankName;
	}
	public void setBankName(String bankName) {
		this.bankName = bankName;
	}
	public String getBranch() {
		return branch;
	}
	public void setBranch(String branch) {
		this.branch = branch;
	}
	public String getIfscCode() {
		return ifscCode;
	}
	public void setIfscCode(String ifscCode) {
		this.ifscCode = ifscCode;
	}
	public String getAccType() {
		return accType;
	}
	public void setAccType(String accType) {
		this.accType = accType;
	}
	public String getAccNo() {
		return accNo;
	}
	public void setAccNo(String accNo) {
		this.accNo = accNo;
	}
	
   private String jvId="",jvNumber="",creditAmount="",debitAmount="",jvType="",jvPrepDate="",jvEnterdBy="",jvEnterdDt="";
   
   public String getJvId() {
		return jvId;
	}
	public void setJvId(String jvId) {
		this.jvId = jvId;
	}
	
	 public String getJvNumber() {
			return jvNumber;
	 }
	public void setJvNumber(String jvNumber) {
			this.jvNumber = jvNumber;
	}
	
	public String getCreditAmount() {
		return creditAmount;
    }
    public void setCreditAmount(String creditAmount) {
		this.creditAmount = creditAmount;
    }
    
    public String getDebitAmount() {
		return debitAmount;
    }
    public void setDebitAmount(String debitAmount) {
		this.debitAmount = debitAmount;
    }
    
    public String getJvType() {
		return jvType;
    }
    public void setJvType(String jvType) {
		this.jvType = jvType;
    }
    
    public String getJvPrepDate() {
		return jvPrepDate;
    }
    public void setJvPrepDate(String jvPrepDate) {
		this.jvPrepDate = jvPrepDate;
    }
    
    public String getJvEnterdBy() {
		return jvEnterdBy;
    }
    public void setJvEnterdBy(String jvEnterdBy) {
		this.jvEnterdBy = jvEnterdBy;
    }
    
    public String getJvEnterdDt() {
		return jvEnterdDt;
    }
    public void setJvEnterdDt(String jvEnterdDt) {
		this.jvEnterdDt = jvEnterdDt;
    }
    
	
}
