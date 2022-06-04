/**
  * File       : PensionContBean.java
  * Date       : 08/07/2007
  * Author     : AIMS 
  * Description: 
  * Copyright (2007) by the Navayuga Infotech, all rights reserved.
  */
package aims.bean;

import java.io.Serializable;
import java.util.ArrayList;

public class PensionContBean implements Serializable{
	

	public String getFinalSettlementDate() {
		return finalSettlementDate;
	}

	public void setFinalSettlementDate(String finalSettlementDate) {
		this.finalSettlementDate = finalSettlementDate;
	}
int noOfMonths=0;
	public int getNoOfMonths() {
	return noOfMonths;
}

public void setNoOfMonths(int noOfMonths) {
	this.noOfMonths = noOfMonths;
}
	String cpfacno="",employeeNM="",empDOB="",empDOJ="",empSerialNo="",empRegion="",gender="",employeeNO="",fhName="",newEmpCode="",docofEDCR="";
	String designation="",whetherOption="",dateOfEntitle="",finyear="";
	String pensionNo="",maritalStatus="",pfID="",department="",empCpfaccno="",pfSettled="",finalSettlementDate="";
	String interestCalUpto="",dateofSeperationDt="",separationReason="",contriPer="",sactionflag="";
	ArrayList obList=null;
	public String getNtIncrement2017() {
		return ntIncrement2017;
	}

	public void setNtIncrement2017(String ntIncrement2017) {
		this.ntIncrement2017 = ntIncrement2017;
	}
	ArrayList adjOBList=null;
	String adjob="",fy2016_17="",ntIncrement2017="",adjObnt="";
	
	public String getAdjObnt() {
		return adjObnt;
	}

	public void setAdjObnt(String adjObnt) {
		this.adjObnt = adjObnt;
	}

	public String getAdjob() {
		return adjob;
	}

	public void setAdjob(String adjob) {
		this.adjob = adjob;
	}

	public String getFy2016_17() {
		return fy2016_17;
	}

	public void setFy2016_17(String fy2016_17) {
		this.fy2016_17 = fy2016_17;
	}

	public String getSactionflag() {
		return sactionflag;
	}

	public void setSactionflag(String sactionflag) {
		this.sactionflag = sactionflag;
	}

	public ArrayList getAdjOBList() {
		return adjOBList;
	}

	public void setAdjOBList(ArrayList adjOBList) {
		this.adjOBList = adjOBList;
	}

	public ArrayList getObList() {
		return obList;
	}

	public void setObList(ArrayList obList) {
		this.obList = obList;
	}

	public String getContriPer() {
		return contriPer;
	}

	public void setContriPer(String contriPer) {
		this.contriPer = contriPer;
	}

	public String getSeparationReason() {
		return separationReason;
	}

	public void setSeparationReason(String separationReason) {
		this.separationReason = separationReason;
	}

	String sbsMergeFlag="",sbsNTIncrement="";
	
	
	public String getSbsNTIncrement() {
		return sbsNTIncrement;
	}

	public void setSbsNTIncrement(String sbsNTIncrement) {
		this.sbsNTIncrement = sbsNTIncrement;
	}

	public String getSbsMergeFlag() {
		return sbsMergeFlag;
	}

	public void setSbsMergeFlag(String sbsMergeFlag) {
		this.sbsMergeFlag = sbsMergeFlag;
	}

	public String getDocofEDCR() {
		return docofEDCR;
	}

	public void setDocofEDCR(String docofEDCR) {
		this.docofEDCR = docofEDCR;
	}

	public String getFinyear() {
		return finyear;
	}

	public void setFinyear(String finyear) {
		this.finyear = finyear;
	}

	public String getNewEmpCode() {
		return newEmpCode;
	}

	public void setNewEmpCode(String newEmpCode) {
		this.newEmpCode=newEmpCode;
	}

	public String getDateofSeperationDt() {
		return dateofSeperationDt;
	}

	public void setDateofSeperationDt(String dateofSeperationDt) {
		this.dateofSeperationDt = dateofSeperationDt;
	}

	public String getInterestCalUpto() {
		return interestCalUpto;
	}

	public void setInterestCalUpto(String interestCalUpto) {
		this.interestCalUpto = interestCalUpto;
	}

	public String getPfSettled() {
		return pfSettled;
	}

	public void setPfSettled(String pfSettled) {
		this.pfSettled = pfSettled;
	}

	public String getEmpCpfaccno() {
		return empCpfaccno;
	}

	public void setEmpCpfaccno(String empCpfaccno) {
		this.empCpfaccno = empCpfaccno;
	}

	public String getDepartment() {
		return department;
	}

	public void setDepartment(String department) {
		this.department = department;
	}

	String countFlag="";
	String prepareString="";
	ArrayList empPensionList=new ArrayList();
	ArrayList blockList=new ArrayList();
	public ArrayList getBlockList() {
		return blockList;
	}

	public void setBlockList(ArrayList blockList) {
		this.blockList = blockList;
	}

	public String getCpfacno() {
		return cpfacno;
	}

	public void setCpfacno(String cpfacno) {
		this.cpfacno = cpfacno;
	}

	public String getEmpDOB() {
		return empDOB;
	}

	public void setEmpDOB(String empDOB) {
		this.empDOB = empDOB;
	}

	public String getEmpDOJ() {
		return empDOJ;
	}

	public void setEmpDOJ(String empDOJ) {
		this.empDOJ = empDOJ;
	}

	public String getEmployeeNM() {
		return employeeNM;
	}

	public void setEmployeeNM(String employeeNM) {
		this.employeeNM = employeeNM;
	}

	public String getEmpSerialNo() {
		return empSerialNo;
	}

	public void setEmpSerialNo(String empSerialNo) {
		this.empSerialNo = empSerialNo;
	}



	public String getEmpRegion() {
		return empRegion;
	}

	public void setEmpRegion(String empRegion) {
		this.empRegion = empRegion;
	}

	public ArrayList getEmpPensionList() {
		return empPensionList;
	}

	public void setEmpPensionList(ArrayList empPensionList) {
		this.empPensionList = empPensionList;
	}

	public String getEmployeeNO() {
		return employeeNO;
	}

	public void setEmployeeNO(String employeeNO) {
		this.employeeNO = employeeNO;
	}

	public String getGender() {
		return gender;
	}

	public void setGender(String gender) {
		this.gender = gender;
	}

	public String getFhName() {
		return fhName;
	}

	public void setFhName(String fhName) {
		this.fhName = fhName;
	}

	public String getDesignation() {
		return designation;
	}

	public void setDesignation(String designation) {
		this.designation = designation;
	}

	public String getWhetherOption() {
		return whetherOption;
	}

	public void setWhetherOption(String whetherOption) {
		this.whetherOption = whetherOption;
	}

	public String getDateOfEntitle() {
		return dateOfEntitle;
	}

	public void setDateOfEntitle(String dateOfEntitle) {
		this.dateOfEntitle = dateOfEntitle;
	}

	public String getPensionNo() {
		return pensionNo;
	}

	public void setPensionNo(String pensionNo) {
		this.pensionNo = pensionNo;
	}

    public String getMaritalStatus() {
        return maritalStatus;
    }

    public void setMaritalStatus(String maritalStatus) {
        this.maritalStatus = maritalStatus;
    }

	public String getPfID() {
		return pfID;
	}

	public void setPfID(String pfID) {
		this.pfID = pfID;
	}

	public String getCountFlag() {
		return countFlag;
	}

	public void setCountFlag(String countFlag) {
		this.countFlag = countFlag;
	}

	public String getPrepareString() {
		return prepareString;
	}

	public void setPrepareString(String prepareString) {
		this.prepareString = prepareString;
	}

	
}
