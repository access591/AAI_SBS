package aims.service;


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
import aims.bean.EmployeePersonalInfo;
import aims.bean.LicBean;
import aims.common.SBSException;
import aims.dao.SBSAnnuityDAO;

public class SBSAnnuityService {
	SBSAnnuityDAO annuityDao=new SBSAnnuityDAO();

	public EmployeePersonalInfo getPersonalInfo(String pensionNo) {
		EmployeePersonalInfo info=annuityDao.getPersonalInfo(pensionNo);
		return info;
	}

	public String addLic1(LicBean bean) throws SBSException {
		String appId=annuityDao.addLic1(bean);
		return appId;
	}
	public String addSbi(LicBean bean) throws SBSException {
		String appId=annuityDao.addSbi(bean);
		return appId;
	}
	public String addHdfc(LicBean bean) throws SBSException {
		String appId=annuityDao.addHdfc(bean);
		return appId;
	}

	public String addBajaj(LicBean bean) throws SBSException {
		String appId=annuityDao.addBajaj(bean);
		return appId;
	}
	public String addRefundCurps(LicBean bean) throws SBSException {
		System.out.println("Service : addRefundCurps");
		String appId=annuityDao.addRefundCurps(bean);
		return appId;
	}
	public String addNominee(String nomineeName, String address,
			String relationShip, String nomineeDob, String percentage,
			String appId,String gender) {
		
		 appId=annuityDao.addNominee(nomineeName,address,relationShip,nomineeDob,percentage,appId,gender);
		return appId;
	}
	public String addNomineeAppointee(int sno,String appointeeNameAdress, String appointeeRelationShip,
			String appointeeDob,
			String appId,String nomineeName,String appointeeAdress,String appointeeMobileNo) {
		
		 appId=annuityDao.addNomineeAppointee(sno,appointeeNameAdress,appointeeRelationShip,appointeeDob,appId,nomineeName,appointeeAdress,appointeeMobileNo);
		return appId;
	}

	public void updateFormSubmit(String appId) {
		annuityDao.updateFormSubmit(appId);
		
	}

	public void updateFormApprove1(String appId, String remarks, String approveStatus, String transCd, String transDescreption,String claimForm,String identityCard,String paySlip,String panCard,String adharCard,String cancelCheque,String photograph,String deceasedemployee,String nominationdoc,String nomineeproof,String rejectedRemarks,String rejectedType,String userid,String designation) {
		annuityDao.updateFormApprove1(appId,remarks,approveStatus,transCd,transDescreption,claimForm,identityCard,paySlip,panCard,adharCard,cancelCheque,photograph,deceasedemployee,nominationdoc,nomineeproof,rejectedRemarks,rejectedType,userid,designation);
		
	}
	public void updateFormApprove2(String appId, String remarks, String approveStatus, String transCd, String transDescreption,String serviceBook,String cpse,String cad,String crs,String resign,String vrs,String deputation,String notational,String notationalappearCard,String arrear,String obadjustment,String depAAItoOther,String totcorpus2lakhs,String deathcertficate,String obRemarks,String corpusOBAdj,String rejectedRemarks,String rejectedType,String userid,String designation,String eligibleStatus) {
		annuityDao.updateFormApprove2(appId,remarks,approveStatus,transCd,transDescreption,serviceBook,cpse,cad,crs,resign,vrs,deputation,notational,notationalappearCard,arrear,obadjustment,depAAItoOther,totcorpus2lakhs,deathcertficate,obRemarks,corpusOBAdj,rejectedRemarks,rejectedType,userid,designation,eligibleStatus);
		
	}
	public void updateFormApprove3(String appId, String remarks, String approveStatus, String transCd, String transDescreption,String finNoIncrement,String finArrear,String finPreOBadj,String obOtherReason,String finOBadjCorpusCard,String finCorpusVerified,String tds,String userid,String designation,String totsbscorps2lakhs) {
		annuityDao.updateFormApprove3(appId,remarks,approveStatus,transCd,transDescreption,finNoIncrement,finArrear,finPreOBadj,obOtherReason,finOBadjCorpusCard,finCorpusVerified,tds,userid,designation,totsbscorps2lakhs);
		
	}
	public void rhqUpdateFormApprove(String appId, String remarks, String approveStatus, String transCd, String transDescreption,String formVerified,String userid,String designation,String intDate,String purchaseAmt) {
		annuityDao.rhqUpdateFormApprove(appId,remarks,approveStatus,transCd,transDescreption,formVerified,userid,designation,intDate,purchaseAmt);
		
	}public void chqUpdateFormApprove(String appId, String remarks, String approveStatus, String transCd, String transDescreption,String formVerified,String userid,String designation,String region) {
		annuityDao.chqUpdateFormApprove(appId,remarks,approveStatus,transCd,transDescreption,formVerified,userid,designation,region);
		
	}
	public void edcpUpdateFormApprove(String appId, String remarks, String approveStatus, String transCd, String transDescreption,String tdsrec,String corpusamt,String corpusint,String userid,String designation) {
		annuityDao.edcpUpdateFormApprove(appId,remarks,approveStatus,transCd,transDescreption,tdsrec,corpusamt,corpusint,userid,designation);
		
	}
	public void edcpUpdateFormApprove2(String appId, String remarks, String approveStatus, String transCd, String transDescreption,String formVerified,String userid,String designation) {
		annuityDao.edcpUpdateFormApprove2(appId,remarks,approveStatus,transCd,transDescreption,formVerified,userid,designation);
		
	}
	public void edcpUpdateFormApprove3(String appId, String remarks, String approveStatus, String transCd, String transDescreption,String formVerified,String userid,String designation) {
		annuityDao.edcpUpdateFormApprove3(appId,remarks,approveStatus,transCd,transDescreption,formVerified,userid,designation);
		
	}
	public void chqFinUpdateFormApprove(String appId, String remarks, String approveStatus, String transCd, String transDescreption,String formVerified,String userid,String designation) {
		annuityDao.chqFinUpdateFormApprove(appId,remarks,approveStatus,transCd,transDescreption,formVerified,userid,designation);
		
	}
	public void rhqFinUpdateFormApprove(String appId, String remarks, String approveStatus, String transCd, String transDescreption,String formVerified,String userid,String designation,String intDate,String purchaseAmt) {
		annuityDao.rhqFinUpdateFormApprove(appId,remarks,approveStatus,transCd,transDescreption,formVerified,userid,designation,intDate,purchaseAmt);
		
	}

	public ArrayList getAnniutyForms(String unitcd,String unittype,String airport,String region) {
		ArrayList list=annuityDao.getAnniutyForms(unitcd,unittype,airport,region);
		return list;
		
	}
	public ArrayList getAnniutySearchLevel2(String unitcd,String unittype,String airport,String region) {
		ArrayList list=annuityDao.getAnniutySearchLevel2(unitcd,unittype,airport,region);
		return list;
		
	}
	public ArrayList getAnniutySearchLevel3(String unitcd,String unittype,String airport,String region) {
		ArrayList list=annuityDao.getAnniutySearchLevel3(unitcd,unittype,airport,region);
		return list;
		
	}
	public ArrayList getAnniutySearchRHQHR(String unitcd,String unittype,String airport,String region) {
		ArrayList list=annuityDao.getAnniutySearchRHQHR(unitcd,unittype,airport,region);
		return list;
		
	}
	public ArrayList getAnniutySearchRHQFin(String unitcd,String unittype,String airport,String region) {
		ArrayList list=annuityDao.getAnniutySearchRHQFin(unitcd,unittype, airport, region);
		return list;
		
	}
	public ArrayList getAnniutySearchCHQHR(String unitcd,String unittype,String airport,String region) {
		ArrayList list=annuityDao.getAnniutySearchCHQHR(unitcd,unittype, airport, region);
		return list;
		
	}
	public ArrayList getAnniutySearchCHQFin() {
		ArrayList list=annuityDao.getAnniutySearchCHQFin();
		return list;
		
	}
	public ArrayList getAnniutyEDCPApproval(String unitcd,String unittype) {
		ArrayList list=annuityDao.getAnniutyEDCPApproval(unitcd,unittype);
		return list;
		
	}
	public ArrayList getAnniutyEDCPApproval2(String unitcd,String unittype) {
		ArrayList list=annuityDao.getAnniutyEDCPApproval2(unitcd,unittype);
		return list;
		
	}
	public ArrayList getAnniutyEDCPApproval3(String unitcd,String unittype) {
		ArrayList list=annuityDao.getAnniutyEDCPApproval3(unitcd,unittype);
		return list;
		
	}
	public ArrayList getAnniutyCoverLetter(String unitcd,String unittype) {
		ArrayList list=annuityDao.getAnniutyCoverLetter(unitcd,unittype);
		return list;
		
	}
	
	public ArrayList getAnniutyFundWithDrawal() {
		ArrayList list=annuityDao.getAnniutyFundWithDrawal();
		return list;
		
	}
	
	public ArrayList getAnniutyStatus(String pensionno) {
		ArrayList list=annuityDao.getAnniutyStatus(pensionno);
		return list;
		
	}
	
	

	public LicBean getAnniutyForm(String appId) {
		LicBean bean=annuityDao.getAnniutyForm(appId);
		return bean;
	}

	public LicBean getAnniutyFormDraft(String pensionNo,String formtype) {
		LicBean bean=annuityDao.getAnniutyFormDraft(pensionNo,formtype);
		return bean;
	}
	public String addDep(String fromDate, String toDate,int sno,String appId,String pfId) {
		
		 appId=annuityDao.addDep(fromDate,toDate,sno,appId,pfId);
		return appId;
	}

	public void updateFormReject(String appId, String rejectedRemarks,
			String approveStatus, String rejectedType, String approveLevel,String region) {
		annuityDao.updateFormReject(appId,rejectedRemarks,approveStatus,rejectedType,approveLevel,region);
	}

	public int getUpdate(String pensionno, String intcalcdate) {
		
		return annuityDao.getUpdate(pensionno,intcalcdate);
	}

	public ArrayList getFinalsettlementdata(String fromdate, String todate,
			String region, String airport,String month,String year,String finyear) {
		return annuityDao.getFinalsettlementData(fromdate,todate,region,airport,month,year,finyear);
	
	}

	public ArrayList getAnnuityHelp(String empname, String pfId, String appid) {
		
		return annuityDao.getAnnuityHelp(empname,pfId,appid);
	}
public ArrayList getJvHelp(String empname, String pfId, String appid) {
		
		return annuityDao.getJvHelp(empname,pfId,appid);
	}

	public int insertPolicyDoc(String pfId, String appid,
			String annuityprovider, String purchaseamt, String gst,
			String policyno, String policydate, String policyamt, String debit,
			String credit){
		return annuityDao.insertPolicydoc( pfId,  appid,
				 annuityprovider,  purchaseamt,  gst,
				 policyno,  policydate,  policyamt,  debit,
				 credit);
	}

	public ArrayList getPolicySerch() {
		
		return annuityDao.getPolicyDoc();
	}
public ArrayList getPolicySerch(String fromdate,String todate) {
		
		return annuityDao.getPolicyDoc(fromdate,todate);
	}

public ArrayList getMisdata(String region, String airport) {
	return annuityDao.getMisData(region,airport);
}

public ArrayList getMISEmployee(String region, String airport) {
	return annuityDao.getMISEmployee(region,airport);
}
public ArrayList getAnnuityApprovedReport(String fromdate,String todate,String airport,String region,String formType) {
	System.out.println("=== inside getSBIdata==service==");
	return annuityDao.getAnnuityApprovedReport(fromdate,todate,airport,region,formType);
}


public String addJournalVoucher(String pfid,String userName,String unitType) throws SBSException {
	System.out.println("Service : addJournalVoucher");
	String appId=annuityDao.addJournalVoucher(pfid,userName,unitType);
	return appId;
}
public LicBean getJournalVoucher(String jvId) {
	LicBean bean=annuityDao.getJournalVoucher(jvId);
	return bean;
}
public ArrayList getJournalVocherSRCH(String unitcd,String unittype) {
	ArrayList list=annuityDao.getJournalVocherSRCH(unitcd,unittype);
	return list;
	
}
public ArrayList getJournalVocherReport(String region,String airport) {
	ArrayList list= annuityDao.getJournalVocherReport(region,airport);
	System.out.println("list=services="+list.size());
	return list;
}
}
