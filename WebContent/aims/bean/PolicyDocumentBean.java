package aims.bean;

public class PolicyDocumentBean {
private String pensionno;
private String appid;
private String AnnuityProvider;
private String policynumber="",policydate="",policyAmount="",gst="",purchaseamt="",credit="",debit="";
private String region="",airport="",newEmpCode="",employeeName="";


public String getEmployeeName() {
	return employeeName;
}
public void setEmployeeName(String employeeName) {
	this.employeeName = employeeName;
}
public String getRegion() {
	return region;
}
public void setRegion(String region) {
	this.region = region;
}
public String getAirport() {
	return airport;
}
public void setAirport(String airport) {
	this.airport = airport;
}
public String getNewEmpCode() {
	return newEmpCode;
}
public void setNewEmpCode(String newEmpCode) {
	this.newEmpCode = newEmpCode;
}
public String getPolicynumber() {
	return policynumber;
}
public void setPolicynumber(String policynumber) {
	this.policynumber = policynumber;
}
public String getPolicydate() {
	return policydate;
}
public void setPolicydate(String policydate) {
	this.policydate = policydate;
}
public String getPolicyAmount() {
	return policyAmount;
}
public void setPolicyAmount(String policyAmount) {
	this.policyAmount = policyAmount;
}
public String getGst() {
	return gst;
}
public void setGst(String gst) {
	this.gst = gst;
}
public String getPurchaseamt() {
	return purchaseamt;
}
public void setPurchaseamt(String purchaseamt) {
	this.purchaseamt = purchaseamt;
}
public String getCredit() {
	return credit;
}
public void setCredit(String credit) {
	this.credit = credit;
}
public String getDebit() {
	return debit;
}
public void setDebit(String debit) {
	this.debit = debit;
}
public String getPensionno() {
	return pensionno;
}
public void setPensionno(String pensionno) {
	this.pensionno = pensionno;
}
public String getAppid() {
	return appid;
}
public void setAppid(String appid) {
	this.appid = appid;
}
public String getAnnuityProvider() {
	return AnnuityProvider;
}
public void setAnnuityProvider(String annuityProvider) {
	AnnuityProvider = annuityProvider;
}
public String toString() {
	return "['" + pensionno + "','" + appid + "','" + AnnuityProvider + "']";
}

}
