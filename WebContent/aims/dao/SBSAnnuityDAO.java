package aims.dao;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.StringTokenizer;

import oracle.jdbc.driver.OracleResultSet;
import oracle.sql.BLOB;

import aims.bean.EmployeePersonalInfo;
import aims.bean.LicBean;
import aims.bean.MisdataBean;
import aims.bean.PolicyDocumentBean;
import aims.bean.SBSDeputationBean;
import aims.bean.SBSNomineeBean;
import aims.bean.SBSRejectedRemarksBean;
import aims.common.CommonUtil;
import aims.common.DBUtils;
import aims.common.Log;
import aims.common.SBSException;

public class SBSAnnuityDAO {
	Log log=new Log(SBSAnnuityDAO.class);

	public String checkNull(Object str) {
	    if(str == null)
	        return "";
	    else
	        return str.toString().trim();
	}

	 

	public String checkNullNum(Object str) {
	    if(str == null)
	        return "0";
	    else
	        return str.toString().trim();
	}
	public EmployeePersonalInfo getPersonalInfo(String pensionNo) {
		
		String sqlQuery="select pensionno,i.employeename,i.desegnation,i.dateofbirth,i.dateofjoining,i.dateofseperation_reason,i.dateofseperation_date,airportcode,region from employee_personal_info i where i.pensionno="+pensionNo;
		Connection con=null;
		Statement st=null;
		ResultSet rs=null;
		EmployeePersonalInfo info=null;
		try{
		con=DBUtils.getConnection();
		st=con.createStatement();
		rs=st.executeQuery(sqlQuery);
	
		if (rs.next()){
			info=new EmployeePersonalInfo();
			if(rs.getString("pensionno")!=null){
				info.setPensionNo(rs.getString("pensionno"));
			}
			if(rs.getString("employeename")!=null){
				info.setEmployeeName(rs.getString("employeename"));
			}
			if(rs.getString("desegnation")!=null){
				info.setDesignation(rs.getString("desegnation"));
			}
			if(rs.getString("dateofbirth")!=null){
				info.setDateOfBirth(CommonUtil
						.converDBToAppFormat(rs.getDate("dateofbirth")));
			}
			if(rs.getString("dateofjoining")!=null){
				info.setDateOfJoining(CommonUtil
						.converDBToAppFormat(rs.getDate("dateofjoining")));
			}
			if(rs.getString("dateofseperation_date")!=null){
				info.setDateOfSaparation(CommonUtil
						.converDBToAppFormat(rs.getDate("dateofseperation_date")));
			}
			if(rs.getString("dateofseperation_reason")!=null){
				info.setSeperationReason(rs.getString("dateofseperation_reason"));
			}
			if(rs.getString("airportcode")!=null){
				info.setAirportCode(rs.getString("airportcode"));
			}
			if(rs.getString("region")!=null){
				info.setRegion(rs.getString("region"));
			}
			
			
			
		}
		
		}catch(Exception e){
			e.printStackTrace();
			
		}finally{
			DBUtils.closeConnection(rs, st, con);
		}
		
		
		
		
		return info;
		
	}

	public String addLic1(LicBean bean) throws SBSException {
		String sqlQueryMainForm="";
		String sqlPersonal="";
		String sqlBank="";
		Connection con=null;
		Statement st=null;
		ResultSet rs=null;
		String appId="";
		
		try{
			con=DBUtils.getConnection();
			con.setAutoCommit(false);
			st=con.createStatement();
			
			rs=st.executeQuery("select nvl(max(Appid),1)+1 as appid from SBS_Annuity_Forms");
			if(rs.next()){
				appId=rs.getString("appid");
			}
			
			sqlQueryMainForm="insert into SBS_Annuity_Forms(Membername,Appid,Pensionno,Member_Dob,Member_Doj,Causeofexit,Dateofexit,Pensionoption,Aaiedcpsoption,Spousename,Spouseaddress,Spousedob,Spouserelation,Modeofpayment,form_type,airport,region,enteredby ,entrylevel )" +
					" values ('"+bean.getMemberName()+"','"+appId+"','"+bean.getEmployeeNo()+"','"+bean.getDob()+"','"+bean.getDoj()+"','"+bean.getExitReason()+"','"+bean.getDateOfexit()+"'," +
							"'"+bean.getChosenOp()+"','"+bean.getAaiEDCPSoption()+"','"+bean.getSpouseName()+"','"+bean.getSpouseAdd()+"','"+bean.getSpouseDob()+"','"+bean.getSpouseRelation()+"','"+bean.getPaymentMode()+"','"+bean.getFormType()+"','"+bean.getAirport()+"','"+bean.getRegion()+"','"+bean.getUserName()+"','"+bean.getUnitType()+"')";
			
			sqlPersonal="insert into SBS_Annuity_personal(Appid,Address,Permentaddress,Nomineename,Relation,Nomineedob,Panno, Adharno, Phoneno,Email)" +
			" values('"+appId+"','"+bean.getMemberAddress()+"','"+bean.getMemberPerAdd()+"','"+bean.getNomineeName()+"','"+bean.getRelationtoMember()+"','"+bean.getNomineeDob()+"','"+bean.getPanNo()+"','"+bean.getAdharno()+"','"+bean.getMobilNo()+"','"+bean.getEmail()+"')";
			
			
			sqlBank="insert into SBS_Annuity_bank(Bankname,Appid, Branch,Ifsc,Account_Type,Account_No,micrcode) " +
					" values('"+bean.getBankName()+"','"+appId+"','"+bean.getBranch()+"','"+bean.getIfscCode()+"','"+bean.getAccType()+"','"+bean.getAccNo()+"','"+bean.getMicrCode()+"')";
					
			st.executeUpdate("delete from SBS_Annuity_bank where appid in (select Appid from SBS_Annuity_Forms where pensionno='"+bean.getEmployeeNo()+"')");
			st.executeUpdate("delete from SBS_Annuity_personal where appid in (select Appid from SBS_Annuity_Forms where pensionno='"+bean.getEmployeeNo()+"')");
			st.executeUpdate("delete from SBS_Annuity_Forms where pensionno='"+bean.getEmployeeNo()+"'");
			st.executeQuery(sqlQueryMainForm);
			st.executeQuery(sqlPersonal);
			st.executeQuery(sqlBank);
			con.setAutoCommit(true);
			
			
	}catch(Exception e){
		e.printStackTrace();
		
		try {
			con.rollback();
		} catch (SQLException e1) {
			throw new SBSException(e1.getMessage());
		}
		throw new SBSException(e.getMessage());
	}finally{
		DBUtils.closeConnection(rs, st, con);
	}
	return appId;
	}
	public String addSbi(LicBean bean) throws SBSException {
		String sqlQueryMainForm="";
		String sqlPersonal="";
		String sqlBank="";
		Connection con=null;
		Statement st=null;
		ResultSet rs=null;
		String appId="";
		
		try{
			con=DBUtils.getConnection();
			con.setAutoCommit(false);
			st=con.createStatement();
			
			rs=st.executeQuery("select nvl(max(Appid),1)+1 as appid from SBS_Annuity_Forms");
			if(rs.next()){
				appId=rs.getString("appid");
			}
			
			sqlQueryMainForm="insert into SBS_Annuity_Forms(Membername,Appid,Pensionno,Member_Dob,Member_Doj,Causeofexit,Dateofexit,Pensionoption,Aaiedcpsoption,Spousename,Spouseaddress,Spousedob,Spouserelation,Modeofpayment,form_type,formsubmit,appdate,corpusamt,airport,region,secannuitantpan,enteredby ,entrylevel)" +
					" values ('"+bean.getMemberName()+"','"+appId+"','"+bean.getEmployeeNo()+"','"+bean.getDob()+"','"+bean.getDoj()+"','"+bean.getExitReason()+"','"+bean.getDateOfexit()+"'," +
							"'"+bean.getChosenOp()+"','"+bean.getAaiEDCPSoption()+"','"+bean.getSpouseName()+"','"+bean.getSpouseAdd()+"','"+bean.getSpouseDob()+"','"+bean.getSpouseRelation()+"','"+bean.getPaymentMode()+"','"+bean.getFormType()+"','Y',sysdate,'"+bean.getCorpusAmt()+"','"+bean.getAirport()+"','"+bean.getRegion()+"','"+bean.getSecAnnuitantPAN()+"','"+bean.getUserName()+"','"+bean.getUnitType()+"')";
			
			sqlPersonal="insert into SBS_Annuity_personal(Appid,Address,Permentaddress,Nomineename,Relation,Nomineedob,Panno, Adharno, Phoneno,Email,gender,FathersName,Nationality,pincode,state,town)" +
			" values('"+appId+"','"+bean.getMemberAddress()+"','"+bean.getMemberPerAdd()+"','"+bean.getNomineeName()+"','"+bean.getRelationtoMember()+"','"+bean.getNomineeDob()+"','"+bean.getPanNo()+"','"+bean.getAdharno()+"','"+bean.getMobilNo()+"','"+bean.getEmail()+"','"+bean.getGender()+"','"+bean.getFatherName()+"','"+bean.getNationality()+"','"+bean.getPinCode()+"','"+bean.getState()+"','"+bean.getCtv()+"')";
			
			
			sqlBank="insert into SBS_Annuity_bank(Bankname,Appid, Branch,Ifsc,Account_Type,Account_No) " +
					" values('"+bean.getBankName()+"','"+appId+"','"+bean.getBranch()+"','"+bean.getIfscCode()+"','"+bean.getAccType()+"','"+bean.getAccNo()+"')";
					
			//st.executeUpdate("delete from SBS_Annuity_bank where appid in (select Appid from SBS_Annuity_Forms where pensionno='"+bean.getEmployeeNo()+"')");
			//st.executeUpdate("delete from SBS_Annuity_personal where appid in (select Appid from SBS_Annuity_Forms where pensionno='"+bean.getEmployeeNo()+"')");
			//st.executeUpdate("delete from SBS_Annuity_Forms where pensionno='"+bean.getEmployeeNo()+"'");
			st.executeQuery(sqlQueryMainForm);
			st.executeQuery(sqlPersonal);
			st.executeQuery(sqlBank);
			con.setAutoCommit(true);
			
			
	}catch(Exception e){
		e.printStackTrace();
		
		try {
			con.rollback();
		} catch (SQLException e1) {
			throw new SBSException(e1.getMessage());
		}
		throw new SBSException(e.getMessage());
	}finally{
		DBUtils.closeConnection(rs, st, con);
	}
	return appId;
	}
	public String addHdfc(LicBean bean) throws SBSException {
		String sqlQueryMainForm="";
		String sqlPersonal="";
		String sqlBank="";
		Connection con=null;
		Statement st=null;
		ResultSet rs=null;
		String appId="";
		
		try{
			con=DBUtils.getConnection();
			con.setAutoCommit(false);
			st=con.createStatement();
			
			rs=st.executeQuery("select nvl(max(Appid),1)+1 as appid from SBS_Annuity_Forms");
			if(rs.next()){
				appId=rs.getString("appid");
			}
			
			sqlQueryMainForm="insert into SBS_Annuity_Forms(Membername,Appid,Pensionno,Member_Dob,Member_Doj,Causeofexit,Dateofexit,Pensionoption,Aaiedcpsoption,Spousename,Spouseaddress,Spousedob,Spouserelation,secannuitantgender,secannuitantpan,Modeofpayment,form_type,formsubmit,appdate,corpusamt,airport,region,enteredby ,entrylevel)" +
					" values ('"+bean.getMemberName()+"','"+appId+"','"+bean.getEmployeeNo()+"','"+bean.getDob()+"','"+bean.getDoj()+"','"+bean.getExitReason()+"','"+bean.getDateOfexit()+"'," +
							"'"+bean.getChosenOp()+"','"+bean.getAaiEDCPSoption()+"','"+bean.getSpouseName()+"','"+bean.getSpouseAdd()+"','"+bean.getSpouseDob()+"','"+bean.getSpouseRelation()+"','"+bean.getSecAnnuitantGender()+"','"+bean.getSecAnnuitantPAN()+"','"+bean.getPaymentMode()+"','"+bean.getFormType()+"','Y',sysdate,'"+bean.getCorpusAmt()+"','"+bean.getAirport()+"','"+bean.getRegion()+"','"+bean.getUserName()+"','"+bean.getUnitType()+"')";
			
			sqlPersonal="insert into SBS_Annuity_personal(Appid,Address,Permentaddress,Nomineename,Relation,Nomineedob,Panno, Adharno, Phoneno,alternatemobile,Email,gender,FathersName,Nationality,pincode,state,town)" +
			" values('"+appId+"','"+bean.getMemberAddress()+"','"+bean.getMemberPerAdd()+"','"+bean.getNomineeName()+"','"+bean.getRelationtoMember()+"','"+bean.getNomineeDob()+"','"+bean.getPanNo()+"','"+bean.getAdharno()+"','"+bean.getMobilNo()+"','"+bean.getMobilNo1()+"','"+bean.getEmail()+"','"+bean.getGender()+"','"+bean.getFatherName()+"','"+bean.getNationality()+"','"+bean.getPinCode()+"','"+bean.getState()+"','"+bean.getCtv()+"')";
			
			
			sqlBank="insert into SBS_Annuity_bank(Bankname,Appid, Branch,Ifsc,Account_Type,Account_No,micrcode) " +
					" values('"+bean.getBankName()+"','"+appId+"','"+bean.getBranch()+"','"+bean.getIfscCode()+"','"+bean.getAccType()+"','"+bean.getAccNo()+"','"+bean.getMicrCode()+"')";
					
			//st.executeUpdate("delete from SBS_Annuity_bank where appid in (select Appid from SBS_Annuity_Forms where pensionno='"+bean.getEmployeeNo()+"')");
			//st.executeUpdate("delete from SBS_Annuity_personal where appid in (select Appid from SBS_Annuity_Forms where pensionno='"+bean.getEmployeeNo()+"')");
			//st.executeUpdate("delete from SBS_Annuity_Forms where pensionno='"+bean.getEmployeeNo()+"'");
			st.executeQuery(sqlQueryMainForm);
			st.executeQuery(sqlPersonal);
			st.executeQuery(sqlBank);
			con.setAutoCommit(true);
			
			
	}catch(Exception e){
		e.printStackTrace();
		
		try {
			con.rollback();
		} catch (SQLException e1) {
			throw new SBSException(e1.getMessage());
		}
		throw new SBSException(e.getMessage());
	}finally{
		DBUtils.closeConnection(rs, st, con);
	}
	return appId;
	}
	public String addBajaj(LicBean bean) throws SBSException {
		String sqlQueryMainForm="";
		String sqlPersonal="";
		String sqlBank="";
		Connection con=null;
		Statement st=null;
		ResultSet rs=null;
		String appId="";
		
		try{
			con=DBUtils.getConnection();
			con.setAutoCommit(false);
			st=con.createStatement();
			
			rs=st.executeQuery("select nvl(max(Appid),1)+1 as appid from SBS_Annuity_Forms");
			if(rs.next()){
				appId=rs.getString("appid");
			}
			
			sqlQueryMainForm="insert into SBS_Annuity_Forms(Membername,Appid,Pensionno,Member_Dob,Member_Doj,Causeofexit,Dateofexit,Pensionoption,Aaiedcpsoption,Spousename,Spouseaddress,Spousedob,Spouserelation,secannuitantgender,Modeofpayment,form_type,formsubmit,appdate,corpusamt,airport,region)" +
					" values ('"+bean.getMemberName()+"','"+appId+"','"+bean.getEmployeeNo()+"','"+bean.getDob()+"','"+bean.getDoj()+"','"+bean.getExitReason()+"','"+bean.getDateOfexit()+"'," +
							"'"+bean.getChosenOp()+"','"+bean.getAaiEDCPSoption()+"','"+bean.getSpouseName()+"','"+bean.getSpouseAdd()+"','"+bean.getSpouseDob()+"','"+bean.getSpouseRelation()+"','"+bean.getSecAnnuitantGender()+"','"+bean.getPaymentMode()+"','"+bean.getFormType()+"','Y',sysdate,'"+bean.getCorpusAmt()+"','"+bean.getAirport()+"','"+bean.getRegion()+"')";
			
			sqlPersonal="insert into SBS_Annuity_personal(Appid,Address,Permentaddress,Nomineename,Relation,Nomineedob,Panno, Adharno, Phoneno,Email,gender,FathersName,Nationality,pincode,state,town)" +
			" values('"+appId+"','"+bean.getMemberAddress()+"','"+bean.getMemberPerAdd()+"','"+bean.getNomineeName()+"','"+bean.getRelationtoMember()+"','"+bean.getNomineeDob()+"','"+bean.getPanNo()+"','"+bean.getAdharno()+"','"+bean.getMobilNo()+"','"+bean.getEmail()+"','"+bean.getGender()+"','"+bean.getFatherName()+"','"+bean.getNationality()+"','"+bean.getPinCode()+"','"+bean.getState()+"','"+bean.getCtv()+"')";
			
			
			sqlBank="insert into SBS_Annuity_bank(Bankname,Appid, Branch,Ifsc,Account_Type,Account_No,micrcode) " +
					" values('"+bean.getBankName()+"','"+appId+"','"+bean.getBranch()+"','"+bean.getIfscCode()+"','"+bean.getAccType()+"','"+bean.getAccNo()+"','"+bean.getMicrCode()+"')";
					
			//st.executeUpdate("delete from SBS_Annuity_bank where appid in (select Appid from SBS_Annuity_Forms where pensionno='"+bean.getEmployeeNo()+"')");
			//st.executeUpdate("delete from SBS_Annuity_personal where appid in (select Appid from SBS_Annuity_Forms where pensionno='"+bean.getEmployeeNo()+"')");
			//st.executeUpdate("delete from SBS_Annuity_Forms where pensionno='"+bean.getEmployeeNo()+"'");
			st.executeQuery(sqlQueryMainForm);
			st.executeQuery(sqlPersonal);
			st.executeQuery(sqlBank);
			con.setAutoCommit(true);
			
			
	}catch(Exception e){
		e.printStackTrace();
		
		try {
			con.rollback();
		} catch (SQLException e1) {
			throw new SBSException(e1.getMessage());
		}
		throw new SBSException(e.getMessage());
	}finally{
		DBUtils.closeConnection(rs, st, con);
	}
	return appId;
	}
	public String addRefundCurps(LicBean bean) throws SBSException {
		String sqlQueryMainForm="";
		String sqlPersonal="";
		String sqlBank="";
		String sqlBank2="";
		Connection con=null;
		Statement st=null;
		ResultSet rs=null;
		String appId="";
		System.out.println("Dao : addRefundCurps");
		try{
			con=DBUtils.getConnection();
			con.setAutoCommit(false);
			st=con.createStatement();
			
			rs=st.executeQuery("select nvl(max(Appid),1)+1 as appid from SBS_Annuity_Forms");
			if(rs.next()){
				appId=rs.getString("appid");
			}
			
			sqlQueryMainForm="insert into SBS_Annuity_Forms(Membername,Appid,Pensionno,Member_Doj,Causeofexit,Dateofexit,Pensionoption,Aaiedcpsoption,Spousename,Spouseaddress,Spousedob,Spouserelation,Modeofpayment,form_type,formsubmit,appdate,corpusamt,airport,region,secannuitantpan,enteredby ,entrylevel,rcformdated)" +
					" values ('"+bean.getMemberName()+"','"+appId+"','"+bean.getEmployeeNo()+"','"+bean.getDoj()+"','"+bean.getExitReason()+"','"+bean.getDos()+"'," +
							"'"+bean.getChosenOp()+"','"+bean.getAaiEDCPSoption()+"','"+bean.getSpouseName()+"','"+bean.getSpouseAdd()+"','"+bean.getSpouseDob()+"','"+bean.getSpouseRelation()+"','"+bean.getPaymentMode()+"','"+bean.getFormType()+"','Y',sysdate,'"+bean.getCorpusAmt()+"','"+bean.getAirport()+"','"+bean.getRegion()+"','"+bean.getSecAnnuitantPAN()+"','"+bean.getUserName()+"','"+bean.getUnitType()+"','"+bean.getPolicyStartDate()+"')";
			
			sqlPersonal="insert into SBS_Annuity_personal(Appid,Address,Permentaddress,Nomineename,Relation,Nomineedob,Panno, Adharno, Phoneno,Email,gender,FathersName,Nationality,pincode,state,town,DESIGNATION,EMPSAPCODE,NOMINEE2NAME,NOMINEE3NAME)" +
			" values('"+appId+"','"+bean.getMemberAddress()+"','"+bean.getMemberPerAdd()+"','"+bean.getNomineeName()+"','"+bean.getRelationtoMember()+"','"+bean.getNomineeDob()+"','"+bean.getPanNo()+"','"+bean.getAdharno()+"','"+bean.getMobilNo()+"','"+bean.getEmail()+"','"+bean.getGender()+"','"+bean.getFatherName()+"','"+bean.getNationality()+"','"+bean.getPinCode()+"','"+bean.getState()+"','"+bean.getCtv()+"','"+bean.getDesignation()+"','"+bean.getEmpsapCode()+"','"+bean.getNomineeName2()+"','"+bean.getNomineeName3()+"')";
			
			
			sqlBank="insert into SBS_Annuity_bank(Bankname,Appid, Branch,Ifsc,MICRCODE,Account_Type,Account_No,CUSTOMERNAME,CUSTOMERNAME2,ACCOUNTNO2,BANKNAME2,MICRCODE2,BRANCHADDR2,IFSCCODE2) " +
					" values('"+bean.getBankName()+"','"+appId+"','"+bean.getBranch()+"','"+bean.getIfscCode()+"','"+bean.getMicrCode()+"','"+bean.getAccType()+"','"+bean.getAccNo()+"','"+bean.getFindisplayname()+"','"+bean.getCustomerName2()+"','"+bean.getAccNo2()+"','"+bean.getBankName2()+"','"+bean.getMicrCode2()+"','"+bean.getBranch2()+"','"+bean.getIfscCode2()+"')";
			
			
			//st.executeUpdate("delete from SBS_Annuity_bank where appid in (select Appid from SBS_Annuity_Forms where pensionno='"+bean.getEmployeeNo()+"')");
			//st.executeUpdate("delete from SBS_Annuity_personal where appid in (select Appid from SBS_Annuity_Forms where pensionno='"+bean.getEmployeeNo()+"')");
			//st.executeUpdate("delete from SBS_Annuity_Forms where pensionno='"+bean.getEmployeeNo()+"'");
			System.out.println("sqlQueryMainForm"+sqlQueryMainForm);
			st.executeQuery(sqlQueryMainForm);
			System.out.println("sqlPersonal"+sqlPersonal);
			st.executeQuery(sqlPersonal);
			System.out.println("sqlBank"+sqlBank);
			st.executeQuery(sqlBank);
			con.setAutoCommit(true);
			
			
	}catch(Exception e){
		e.printStackTrace();
		
		try {
			con.rollback();
		} catch (SQLException e1) {
			throw new SBSException(e1.getMessage());
		}
		throw new SBSException(e.getMessage());
	}finally{
		DBUtils.closeConnection(rs, st, con);
	}
	return appId;
	}
	public String addNominee(String nomineeName, String address,
			String relationShip, String nomineeDob, String percentage,
			String appId,String gender) {
		log.info("addNominee");
		Connection con=null;
		Statement st=null;
		ResultSet rs=null;
		String nomineeInsert="";
		
		
		
		try{
			con=DBUtils.getConnection();
			//con.setAutoCommit(false);
			st=con.createStatement();
			nomineeInsert="insert into SBS_Annuity_Nominee(Appid,Nomineename,Address,Nomineedob,Relationship,Percentage,gender)" +
					" values('"+appId+"','"+nomineeName+"','"+address+"','"+nomineeDob+"','"+relationShip+"','"+percentage+"','"+gender+"')";
				
			st.executeUpdate(nomineeInsert);
			
			
		}catch(Exception e){
			e.printStackTrace();
			/*try {
				con.rollback();
			} catch (SQLException e1) {
				// TODO Auto-generated catch block
				e1.printStackTrace();
			}*/
		}finally{
			DBUtils.closeConnection(rs, st, con);
		}
		
		return appId;
	}
	
	public String addDep(String fromDate, String toDate,int sno,String appId,String pfId) {
		//log.info("Dep");
		Connection con=null;
		Statement st=null;
		ResultSet rs=null;
		String depInsert="";
		
		
		
		try{
			con=DBUtils.getConnection();
			//con.setAutoCommit(false);
			st=con.createStatement();
			depInsert="insert into SBS_ANNUITY_DEPUTATION(appid,fromdate,todate,depid,pensionno)" +
					" values('"+appId+"','"+fromDate+"','"+toDate+"','"+sno+"','"+pfId+"')";
				
			st.executeUpdate(depInsert);
			
			
		}catch(Exception e){
			e.printStackTrace();
			/*try {
				con.rollback();
			} catch (SQLException e1) {
				// TODO Auto-generated catch block
				e1.printStackTrace();
			}*/
		}finally{
			DBUtils.closeConnection(rs, st, con);
		}
		
		return appId;
	}
	public String addNomineeAppointee(int sno,String appointeeNameAdress,String appointeeRelationShip,String appointeeDob,String appId,String nomineeName,String appointeeAdress,String appointeeMobileNo) {
		log.info("addNomineeAppointee");
		Connection con=null;
		Statement st=null;
		ResultSet rs=null;
		String nomineeAppointeeInsert="";
		
		
		
		try{
			con=DBUtils.getConnection();
			//con.setAutoCommit(false);
			st=con.createStatement();
			nomineeAppointeeInsert="insert into SBS_Annuity_Nomineeappointee(appointeeid,Appid,Nameaddress,appointeedob,relationship,nomineename,appointeeAdress,appointeemobileno)" +
					" values("+sno+",'"+appId+"','"+appointeeNameAdress+"','"+appointeeDob+"','"+appointeeRelationShip+"','"+nomineeName+"','"+appointeeAdress+"','"+appointeeMobileNo+"')";
				
			st.executeUpdate(nomineeAppointeeInsert);
			
			
		}catch(Exception e){
			e.printStackTrace();
			/*try {
				con.rollback();
			} catch (SQLException e1) {
				// TODO Auto-generated catch block
				e1.printStackTrace();
			}*/
		}finally{
			DBUtils.closeConnection(rs, st, con);
		}
		
		return appId;
	}

	public void updateFormSubmit(String appId) {
		Connection con=null;
		Statement st=null;
	
		try{
			con=DBUtils.getConnection();
			
			st=con.createStatement();
			st.executeUpdate("update SBS_Annuity_Forms f set f.formsubmit='Y',f.appdate=sysdate where f.appid='"+appId+"'");
		}catch(Exception e){
			e.printStackTrace();
		
		}finally{
			try {
				st.close();
				con.close();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			
			
		}
	}
	
	public void updateFormApprove1(String appId, String remarks, String approveStatus, String transCd, String transDescreption,String claimForm,String identityCard,String paySlip,String panCard,String adharCard,String cancelCheque,String photograph,String deceasedemployee,String nominationdoc,String nomineeproof,String rejectedRemarks,String rejectedType,String userid,String designation) {
		Connection con=null;
		Statement st=null;
		String sqlquery="";
		String transno="";
		ResultSet rs=null;
		String sqlQry1="update SBS_Annuity_Forms f set verfiedby='HR1',remarks='"+remarks+"',approve1='"+approveStatus+"',claimform='"+claimForm+"',identityCard='"+identityCard+"',paySlip='"+paySlip+"',panCard='"+panCard+"',adharCard='"+adharCard+"',cancelCheque='"+cancelCheque+"',photograph='"+photograph+"',deceasedemployee='"+deceasedemployee+"',nominationdoc='"+nominationdoc+"',nomineeproof='"+nomineeproof+"',ack_rejectedremarks='"+rejectedRemarks+"',ack_rejectedtype='"+rejectedType+"' where f.appid='"+appId+"'";
	log.info(sqlQry1);
		try{
			con=DBUtils.getConnection();
			
			st=con.createStatement();
			rs=st.executeQuery("select nvl(max(Transno),0)+1 as Transno from SBS_Annuity_transations");
			if(rs.next()){
				transno=rs.getString("Transno");
			}
			//con.setAutoCommit(false);
			st.executeUpdate(sqlQry1);
		String 	trans_qry="delete from sbs_annuity_transations s where appid='"+appId+"' and transcd='11'" ;
		st.executeUpdate(trans_qry);
			sqlquery="insert into SBS_Annuity_transations(Appid, Transno, Transdate,Transcd,Transdescription,Apptype,Approvedby,approvedbyid,Designation) " +
					"values('"+appId+"','"+transno+"',sysdate,'"+transCd+"','"+transDescreption+"','LIC','chqhr','"+userid+"','"+designation+"')";
		st.executeUpdate(sqlquery);
		//con.setAutoCommit(true);
		
		
		}catch(Exception e){
			e.printStackTrace();
		
		}finally{
			try {
				//con.rollback();
				st.close();
				con.close();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			
			
		}
	}
	public void updateFormApprove2(String appId, String remarks, String approveStatus, String transCd, String transDescreption,String serviceBook,String cpse,String cad,String crs,String resign,String vrs,String deputation,String notational,String notationalappearCard,String arrear,String obadjustment,String depAAItoOther,String totcorpus2lakhs,String deathcertficate,String obRemarks,String corpusOBAdj,String rejectedRemarks,String rejectedType,String userid,String designation,String eligibleStatus) {
		Connection con=null;
		Statement st=null;
		String sqlquery="";
		String transno="";
		ResultSet rs=null;
		String condition="";
		if(approveStatus.equals("R")){
		condition=",approve1='R'";
		}
		try{
			con=DBUtils.getConnection();
			
			st=con.createStatement();
			if(approveStatus.equals("R")){
				st.executeUpdate("update SBS_Annuity_Forms f set verfiedby='HR1',approve1='R' where f.appid='"+appId+"'");
				String rej_qry="insert into sbs_rejected_log(slno,appid,rejected_remarks,rejectedby) values((select nvl(max(slno),0)+1 from sbs_rejected_log where appid='"+appId+"'),'"+appId+"','"+rejectedRemarks+"','HR Nodal Officer') ";
				String trans_qry="delete from sbs_annuity_transations s where appid='"+appId+"' and transcd='11'" ;
				st.executeUpdate(rej_qry);
				st.executeUpdate(trans_qry);
			}else{
			rs=st.executeQuery("select nvl(max(Transno),0)+1 as Transno from SBS_Annuity_transations");
			if(rs.next()){
				transno=rs.getString("Transno");
			}
			//con.setAutoCommit(false);
			st.executeUpdate("update SBS_Annuity_Forms f set eligiblestatus='"+eligibleStatus+"',verfiedby='HR1/HR2',level2_remarks='"+remarks+"',approve2='"+approveStatus+"',servicebook='"+serviceBook+"',cpse='"+cpse+"',cad='"+cad+"',crs='"+crs+"',resign='"+resign+"',vrs='"+vrs+"',deputation='"+deputation+"',notionalincrement='"+notational+"',notionaldisplay='"+notationalappearCard+"',arrear='"+arrear+"',obadjustment='"+obadjustment+"',dep_aai_otherorg='"+depAAItoOther+"',totcorpus2lakhs='"+totcorpus2lakhs+"',deathcertficate='"+deathcertficate+"',obremarks='"+obRemarks+"',corpusobadjustment='"+corpusOBAdj+"',hr_rejectedremarks='"+rejectedRemarks+"',hr_rejectedtype='"+rejectedType+"'"+condition+" where f.appid='"+appId+"'");
			String trans_qry2="delete from sbs_annuity_transations s where appid='"+appId+"' and transcd='12'" ;
			sqlquery="insert into SBS_Annuity_transations(Appid, Transno, Transdate,Transcd,Transdescription,Apptype,Approvedby,approvedbyid,Designation) " +
					"values('"+appId+"','"+transno+"',sysdate,'"+transCd+"','"+transDescreption+"','','chqhr2','"+userid+"','"+designation+"')";
			st.executeUpdate(trans_qry2);
			st.executeUpdate(sqlquery);
		//con.setAutoCommit(true);
			}
		
		}catch(Exception e){
			e.printStackTrace();
		
		}finally{
			try {
				//con.rollback();
				st.close();
				con.close();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			
			
		}
	}
	public void updateFormApprove3(String appId, String remarks, String approveStatus, String transCd, String transDescreption,String finNoIncrement,String finArrear,String finPreOBadj,String obOtherReason,String finOBadjCorpusCard,String finCorpusVerified,String tds,String userid,String designation,String totsbscorps2lakhs) {
		Connection con=null;
		Statement st=null;
		String sqlquery="";
		String transno="";
		ResultSet rs=null;
		String region="";
	
		try{
			con=DBUtils.getConnection();
			
			st=con.createStatement();
			rs=st.executeQuery("select nvl(max(Transno),0)+1 as Transno from SBS_Annuity_transations");
			if(rs.next()){
				transno=rs.getString("Transno");
			}
			rs=st.executeQuery("select region from SBS_Annuity_Forms where appid='"+appId+"'");
			if(rs.next()){
				region=rs.getString("region");
			}
			//con.setAutoCommit(false);
			if(region.equals("CHQNAD")){
			st.executeUpdate("update SBS_Annuity_Forms f set verfiedby='HR1/HR2/CHQHR/Finance',level3_remarks='"+remarks+"',approve3='"+approveStatus+"',finNoIncrement='"+finNoIncrement+"',finArrear='"+finArrear+"',finPreOBadj='"+finPreOBadj+"',obOtherReason='"+obOtherReason+"',finOBadjCorpusCard='"+finOBadjCorpusCard+"',finCorpusVerified='"+finCorpusVerified+"',tds='"+tds+"' where f.appid='"+appId+"'");
			String trans_qry="delete from sbs_annuity_transations s where appid='"+appId+"' and transcd='13'" ;
			st.executeUpdate(trans_qry);
			sqlquery="insert into SBS_Annuity_transations(Appid, Transno, Transdate,Transcd,Transdescription,Apptype,Approvedby,approvedbyid,Designation) " +
					"values('"+appId+"','"+transno+"',sysdate,'"+transCd+"','"+transDescreption+"','LIC','Finance','"+userid+"','"+designation+"')";
		st.executeUpdate(sqlquery);
		
		}else{
			st.executeUpdate("update SBS_Annuity_Forms f set verfiedby='HR1/HR2/Finance',level3_remarks='"+remarks+"',approve3='"+approveStatus+"',finNoIncrement='"+finNoIncrement+"',finArrear='"+finArrear+"',finPreOBadj='"+finPreOBadj+"',obOtherReason='"+obOtherReason+"',finOBadjCorpusCard='"+finOBadjCorpusCard+"',finCorpusVerified='"+finCorpusVerified+"',tds='"+tds+"',totsbscorps2lakhs='"+totsbscorps2lakhs+"' where f.appid='"+appId+"'");
			String trans_qry="delete from sbs_annuity_transations s where appid='"+appId+"' and transcd='13'" ;
			st.executeUpdate(trans_qry);
			sqlquery="insert into SBS_Annuity_transations(Appid, Transno, Transdate,Transcd,Transdescription,Apptype,Approvedby,approvedbyid,Designation) " +
					"values('"+appId+"','"+transno+"',sysdate,'"+transCd+"','"+transDescreption+"','LIC','Finance','"+userid+"','"+designation+"')";
		st.executeUpdate(sqlquery);
		}
		//con.setAutoCommit(true);
		
		
		}catch(Exception e){
			e.printStackTrace();
		
		}finally{
			try {
				//con.rollback();
				st.close();
				con.close();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			
			
		}
	}
	public void rhqUpdateFormApprove(String appId, String remarks, String approveStatus, String transCd, String transDescreption,String formVerified,String userid,String designation,String intDate,String purchaseAmt) {
		Connection con=null;
		Statement st=null;
		String sqlquery="";
		String transno="";
		ResultSet rs=null;
	
		try{
			con=DBUtils.getConnection();
			
			st=con.createStatement();
			rs=st.executeQuery("select nvl(max(Transno),0)+1 as Transno from SBS_Annuity_transations");
			if(rs.next()){
				transno=rs.getString("Transno");
			}
			//con.setAutoCommit(false);
			st.executeUpdate("update SBS_Annuity_Forms f set verfiedby='HR1/HR2/Finance/RHQHR',rhqhr_remarks='"+remarks+"',rhqhrapprove='"+approveStatus+"',rhqhrformverified='"+formVerified+"',rhqhrIntDate='"+intDate+"',rhqhr_PurchaseAmt='"+purchaseAmt+"' where f.appid='"+appId+"'");
			String trans_qry="delete from sbs_annuity_transations s where appid='"+appId+"' and transcd='14'" ;
			st.executeUpdate(trans_qry);
			sqlquery="insert into SBS_Annuity_transations(Appid, Transno, Transdate,Transcd,Transdescription,Apptype,Approvedby,approvedbyid,Designation) " +
					"values('"+appId+"','"+transno+"',sysdate,'"+transCd+"','"+transDescreption+"','LIC','RHQHR','"+userid+"','"+designation+"')";
		st.executeUpdate(sqlquery);
		//con.setAutoCommit(true);
		
		
		}catch(Exception e){
			e.printStackTrace();
		
		}finally{
			try {
				//con.rollback();
				st.close();
				con.close();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			
			
		}
	}
	public void rhqFinUpdateFormApprove(String appId, String remarks, String approveStatus, String transCd, String transDescreption,String formVerified,String userid,String designation,String intDate,String purchaseAmt) {
		Connection con=null;
		Statement st=null;
		String sqlquery="";
		String transno="";
		ResultSet rs=null;
	
		try{
			con=DBUtils.getConnection();
			
			st=con.createStatement();
			rs=st.executeQuery("select nvl(max(Transno),0)+1 as Transno from SBS_Annuity_transations");
			if(rs.next()){
				transno=rs.getString("Transno");
			}
			//con.setAutoCommit(false);
			st.executeUpdate("update SBS_Annuity_Forms f set verfiedby='HR1/HR2/Finance/RHQHR/RHQFIN',rhqfin_remarks='"+remarks+"',rhqfinapprove='"+approveStatus+"',rhqfinformverified='"+formVerified+"',rhqfinintdate ='"+intDate+"',rhqfin_purchseamt='"+purchaseAmt+"' where f.appid='"+appId+"'");
			String  trans_qry="delete from sbs_annuity_transations s where appid='"+appId+"' and transcd='15'" ;
			st.executeUpdate(trans_qry);	
			sqlquery="insert into SBS_Annuity_transations(Appid, Transno, Transdate,Transcd,Transdescription,Apptype,Approvedby,approvedbyid,Designation) " +
					"values('"+appId+"','"+transno+"',sysdate,'"+transCd+"','"+transDescreption+"','LIC','RHQFIN','"+userid+"','"+designation+"')";
		st.executeUpdate(sqlquery);
		//con.setAutoCommit(true);
		
		
		}catch(Exception e){
			e.printStackTrace();
		
		}finally{
			try {
				//con.rollback();
				st.close();
				con.close();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			
			
		}
	}
	public void chqUpdateFormApprove(String appId, String remarks, String approveStatus, String transCd, String transDescreption,String formVerified,String userid,String designation,String region) {
		Connection con=null;
		Statement st=null;
		String sqlquery="";
		String transno="";
		ResultSet rs=null;
	
		try{
			con=DBUtils.getConnection();
			
			st=con.createStatement();
			rs=st.executeQuery("select nvl(max(Transno),0)+1 as Transno from SBS_Annuity_transations");
			if(rs.next()){
				transno=rs.getString("Transno");
			}
			rs=st.executeQuery("select region from SBS_Annuity_Forms where appid="+appId);
			if(rs.next()){
				region=rs.getString("region");
			}
			//con.setAutoCommit(false);
			if(region.equals("CHQNAD")){
				st.executeUpdate("update SBS_Annuity_Forms f set verfiedby='HR1/HR2/CHQHR',chqhr_remarks='"+remarks+"',chqhrapprove='"+approveStatus+"',chqhrformverified='"+formVerified+"' where f.appid='"+appId+"'");
				 String trans_qry="delete from sbs_annuity_transations s where appid='"+appId+"' and transcd='16'" ;
				 st.executeUpdate(trans_qry);
				sqlquery="insert into SBS_Annuity_transations(Appid, Transno, Transdate,Transcd,Transdescription,Apptype,Approvedby,approvedbyid,Designation) " +
						"values('"+appId+"','"+transno+"',sysdate,'"+transCd+"','"+transDescreption+"','LIC','CHQHR','"+userid+"','"+designation+"')";
			st.executeUpdate(sqlquery);
				
			}else{
			st.executeUpdate("update SBS_Annuity_Forms f set verfiedby='HR1/HR2/Finance/RHQHR/RHQFIN/CHQHR',chqhr_remarks='"+remarks+"',chqhrapprove='"+approveStatus+"',chqhrformverified='"+formVerified+"' where f.appid='"+appId+"'");
			 String trans_qry="delete from sbs_annuity_transations s where appid='"+appId+"' and transcd='16'" ;
			 st.executeUpdate(trans_qry);
			sqlquery="insert into SBS_Annuity_transations(Appid, Transno, Transdate,Transcd,Transdescription,Apptype,Approvedby,approvedbyid,Designation) " +
					"values('"+appId+"','"+transno+"',sysdate,'"+transCd+"','"+transDescreption+"','LIC','CHQHR','"+userid+"','"+designation+"')";
		st.executeUpdate(sqlquery);
			}
		//con.setAutoCommit(true);
		
		
		}catch(Exception e){
			e.printStackTrace();
		
		}finally{
			try {
				//con.rollback();
				st.close();
				con.close();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			
			
		}
	}
	public void edcpUpdateFormApprove(String appId, String remarks, String approveStatus, String transCd, String transDescreption,String tdsrec,String corpusamt,String corpusint,String userid,String designation) {
		Connection con=null;
		Statement st=null;
		String sqlquery="";
		String transno="";
		ResultSet rs=null;
	
		try{
			con=DBUtils.getConnection();
			
			st=con.createStatement();
			rs=st.executeQuery("select nvl(max(Transno),0)+1 as Transno from SBS_Annuity_transations");
			if(rs.next()){
				transno=rs.getString("Transno");
			}
			//con.setAutoCommit(false);
			st.executeUpdate("update SBS_Annuity_Forms f set edcpapproval1='"+approveStatus+"',edcpcorpusamt='"+corpusamt+"',edcpcorpusint='"+corpusint+"',edcptdsver='"+tdsrec+"' where f.appid='"+appId+"'");
		String	 trans_qry="delete from sbs_annuity_transations s where appid='"+appId+"' and transcd='18'" ;
		st.executeUpdate(trans_qry);
			sqlquery="insert into SBS_Annuity_transations(Appid, Transno, Transdate,Transcd,Transdescription,Apptype,Approvedby,approvedbyid,Designation) " +
					"values('"+appId+"','"+transno+"',sysdate,'"+transCd+"','"+transDescreption+"','LIC','EDCPapprove1','"+userid+"','"+designation+"')";
		st.executeUpdate(sqlquery);
		//con.setAutoCommit(true);
		
		
		}catch(Exception e){
			e.printStackTrace();
		
		}finally{
			try {
				//con.rollback();
				st.close();
				con.close();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			
			
		}
	}
	public void edcpUpdateFormApprove2(String appId, String remarks, String approveStatus, String transCd, String transDescreption,String tdsVer,String userid,String designation) {
		Connection con=null;
		Statement st=null;
		String sqlquery="";
		String transno="";
		ResultSet rs=null;
	
		try{
			con=DBUtils.getConnection();
			
			st=con.createStatement();
			rs=st.executeQuery("select nvl(max(Transno),0)+1 as Transno from SBS_Annuity_transations");
			if(rs.next()){
				transno=rs.getString("Transno");
			}
			//con.setAutoCommit(false);
			st.executeUpdate("update SBS_Annuity_Forms f set edcpapproval2='"+approveStatus+"',edcptdsver='"+tdsVer+"' where f.appid='"+appId+"'");
		
			sqlquery="insert into SBS_Annuity_transations(Appid, Transno, Transdate,Transcd,Transdescription,Apptype,Approvedby,approvedbyid,Designation) " +
					"values('"+appId+"','"+transno+"',sysdate,'"+transCd+"','"+transDescreption+"','LIC','EDCPapprove2','"+userid+"','"+designation+"')";
		st.executeUpdate(sqlquery);
		//con.setAutoCommit(true);
		
		
		}catch(Exception e){
			e.printStackTrace();
		
		}finally{
			try {
				//con.rollback();
				st.close();
				con.close();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			
			
		}
	}
	public void edcpUpdateFormApprove3(String appId, String remarks, String approveStatus, String transCd, String transDescreption,String tdsVer,String userid,String designation) {
		Connection con=null;
		Statement st=null;
		String sqlquery="";
		String transno="";
		ResultSet rs=null;
	
		try{
			con=DBUtils.getConnection();
			
			st=con.createStatement();
			rs=st.executeQuery("select nvl(max(Transno),0)+1 as Transno from SBS_Annuity_transations");
			if(rs.next()){
				transno=rs.getString("Transno");
			}
			//con.setAutoCommit(false);
			st.executeUpdate("update SBS_Annuity_Forms f set edcpapproval3='"+approveStatus+"',edcptdsver='"+tdsVer+"' where f.appid='"+appId+"'");
		
			sqlquery="insert into SBS_Annuity_transations(Appid, Transno, Transdate,Transcd,Transdescription,Apptype,Approvedby,approvedbyid,Designation) " +
					"values('"+appId+"','"+transno+"',sysdate,'"+transCd+"','"+transDescreption+"','LIC','EDCPapprove3','"+userid+"','"+designation+"')";
		st.executeUpdate(sqlquery);
		//con.setAutoCommit(true);
		
		
		}catch(Exception e){
			e.printStackTrace();
		
		}finally{
			try {
				//con.rollback();
				st.close();
				con.close();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			
			
		}
	}
	public void chqFinUpdateFormApprove(String appId, String remarks, String approveStatus, String transCd, String transDescreption,String formVerified,String userid,String designation) {
		Connection con=null;
		Statement st=null;
		String sqlquery="";
		String transno="";
		ResultSet rs=null;
	
		try{
			con=DBUtils.getConnection();
			
			st=con.createStatement();
			rs=st.executeQuery("select nvl(max(Transno),0)+1 as Transno from SBS_Annuity_transations");
			if(rs.next()){
				transno=rs.getString("Transno");
			}
			//con.setAutoCommit(false);
			st.executeUpdate("update SBS_Annuity_Forms f set verfiedby='HR1/HR2/Finance/RHQHR/RHQFIN/CHQHR/CHQFIN',chqFin_remarks='"+remarks+"',chqfinapprove='"+approveStatus+"',chqFinformverified='"+formVerified+"' where f.appid='"+appId+"'");
		
			sqlquery="insert into SBS_Annuity_transations(Appid, Transno, Transdate,Transcd,Transdescription,Apptype,Approvedby,approvedbyid,Designation) " +
					"values('"+appId+"','"+transno+"',sysdate,'"+transCd+"','"+transDescreption+"','LIC','CHQFIN','"+userid+"','"+designation+"')";
		st.executeUpdate(sqlquery);
		//con.setAutoCommit(true);
		
		
		}catch(Exception e){
			e.printStackTrace();
		
		}finally{
			try {
				//con.rollback();
				st.close();
				con.close();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			
			
		}
	}
	public ArrayList getAnniutyForms(String unitcd,String unitType,String airport,String region) {
		String sqlQuery="";
		log.info("unitType:"+unitType);
		if(unitType.equals("U")){
		 sqlQuery="select s.appid as applicationId,s.pensionno,s.region,o.employeename,o.desegnation,s.form_type as formtype,s.approve1 as status,s.appdate from SBS_Annuity_Forms s,employee_personal_info o  where s.pensionno=o.pensionno and  s.formsubmit='Y' and upper(trim(MEMBERNAME))=upper(trim(EMPLOYEENAME))  and upper(trim(s.airport)) = (select upper(trim(unitname)) from employee_unit_master  where unitcode='"+unitcd+"'and  sbsacctype='SAU') ";
		}else if(unitType.equals("R")){
			if(region.equals("CHQIAD")){
			sqlQuery="select s.appid as applicationId,s.pensionno,s.region,o.employeename,o.desegnation,s.form_type as formtype,s.approve1 as status,s.appdate from SBS_Annuity_Forms s,employee_personal_info o  where s.pensionno=o.pensionno and  s.formsubmit='Y' and s.airport ='"+airport+"' and s.region='CHQIAD'";
			}else{
				//sqlQuery="select s.appid as applicationId,s.pensionno,o.employeename,o.desegnation,s.form_type as formtype,s.approve1 as status,s.appdate from SBS_Annuity_Forms s,employee_personal_info o  where s.pensionno=o.pensionno and  s.formsubmit='Y' and (s.airport in(select unitname from employee_unit_master m where m.region=(select region from employee_unit_master  where unitcode='"+unitcd+"') and m.sbsacctype='RAU') or (s.region=(select region from employee_unit_master  where unitcode='"+unitcd+"') and  entrylevel='R')) ";	
				sqlQuery="select s.appid as applicationId,s.pensionno,s.region,o.employeename,o.desegnation,s.form_type as formtype,s.approve1 as status,s.appdate from SBS_Annuity_Forms s,employee_personal_info o  where s.pensionno=o.pensionno and  s.formsubmit='Y' and s.airport in(select unitname from employee_unit_master m where m.region=(select region from employee_unit_master  where unitcode='"+unitcd+"') and m.sbsacctype='RAU') and s.region!='CHQIAD' ";	
				
			}
			}else if(unitType.equals("C")){
			sqlQuery="select s.appid as applicationId,s.pensionno,s.region,o.employeename,o.desegnation,s.form_type as formtype,s.approve1 as status,s.appdate from SBS_Annuity_Forms s,employee_personal_info o  where s.pensionno=o.pensionno and  s.formsubmit='Y' and s.airport='CHQNAD'";	
		}else{
			sqlQuery="select s.appid as applicationId,s.pensionno,s.region,o.employeename,o.desegnation,s.form_type as formtype,s.approve1 as status,s.appdate from SBS_Annuity_Forms s,employee_personal_info o  where s.pensionno=o.pensionno and  s.formsubmit='Y'";
		}
		 System.out.println("sqlQuery==="+sqlQuery);
		 ArrayList list=new ArrayList();
		Connection con=null;
		Statement st=null;
		ResultSet rs=null;
		LicBean info=null;
		try{
		con=DBUtils.getConnection();
		st=con.createStatement();
		rs=st.executeQuery(sqlQuery);
	
		while (rs.next()){
			info=new LicBean();
			if(rs.getString("applicationId")!=null){
				info.setAppId(rs.getString("applicationId"));
			}
			if(rs.getString("employeename")!=null){
				info.setMemberName(rs.getString("employeename"));
			}
			if(rs.getString("formtype")!=null){
				info.setFormType(rs.getString("formtype"));
			}
			
			if(rs.getString("pensionno")!=null){
				info.setEmployeeNo(rs.getString("pensionno"));
				
			}
			
			if(rs.getString("status")!=null){
				info.setStatus(rs.getString("status"));
			}
			if(rs.getString("region")!=null){
				info.setRegion(rs.getString("region"));
			}
			if(rs.getString("appdate")!=null){
			
				info.setAppDate(CommonUtil
						.converDBToAppFormat(rs.getDate("appdate")));
			}
			list.add(info.toString());
			
		}
		
		}catch(Exception e){
			e.printStackTrace();
			
		}finally{
			DBUtils.closeConnection(rs, st, con);
		}
		
		return list;
	}
	public ArrayList getAnniutySearchLevel2(String unitcd,String unitType,String airport,String region) {
		String sqlQuery="";
		if(unitType.equals("U")){
			 sqlQuery="select s.appid as applicationId,s.pensionno,s.region,o.employeename,o.desegnation,s.form_type as formtype,s.approve2 as status,s.appdate from SBS_Annuity_Forms s,employee_personal_info o  where s.pensionno=o.pensionno and  s.formsubmit='Y' and s.approve1='A' and s.airport=(select unitname from employee_unit_master  where unitcode='"+unitcd+"'and  sbsacctype='SAU') ";
			}else if(unitType.equals("R")){
				if(region.equals("CHQIAD")){
					
					sqlQuery="select s.appid as applicationId,s.pensionno,s.region,o.employeename,o.desegnation,s.form_type as formtype,s.approve2 as status,s.appdate from SBS_Annuity_Forms s,employee_personal_info o  where s.pensionno=o.pensionno and  s.formsubmit='Y' and s.approve1='A' and s.airport ='"+airport+"' and s.region='CHQIAD'";
						
				}else{
				//sqlQuery="select s.appid as applicationId,s.pensionno,o.employeename,o.desegnation,s.form_type as formtype,s.approve2 as status,s.appdate from SBS_Annuity_Forms s,employee_personal_info o  where s.pensionno=o.pensionno and  s.formsubmit='Y' and s.approve1='A' and s.airport in(select unitname from employee_unit_master m where m.region=(select region from employee_unit_master  where unitcode='"+unitcd+"') and m.sbsacctype='RAU') ";
				sqlQuery="select s.appid as applicationId,s.pensionno,s.region,o.employeename,o.desegnation,s.form_type as formtype,s.approve2 as status,s.appdate from SBS_Annuity_Forms s,employee_personal_info o  where s.pensionno=o.pensionno and  s.formsubmit='Y' and s.approve1='A' and s.airport in(select unitname from employee_unit_master m where m.region=(select region from employee_unit_master  where unitcode='"+unitcd+"') and m.sbsacctype='RAU') and s.region!='CHQIAD' ";
				
				}
				
				}else if(unitType.equals("C")){
				sqlQuery="select s.appid as applicationId,s.pensionno,s.region,o.employeename,o.desegnation,s.form_type as formtype,s.approve2 as status,s.appdate from SBS_Annuity_Forms s,employee_personal_info o  where s.pensionno=o.pensionno and  s.formsubmit='Y' and s.approve1='A' and s.airport='CHQNAD'";	
			}else{
				sqlQuery="select s.appid as applicationId,s.pensionno,s.region,o.employeename,o.desegnation,s.form_type as formtype,s.approve2 as status,s.appdate from SBS_Annuity_Forms s,employee_personal_info o  where s.pensionno=o.pensionno and  s.formsubmit='Y' and s.approve1='A' ";
			}
			 
		
	
		ArrayList list=new ArrayList();
		Connection con=null;
		Statement st=null;
		ResultSet rs=null;
		LicBean info=null;
		try{
		con=DBUtils.getConnection();
		st=con.createStatement();
		log.info(sqlQuery);
		rs=st.executeQuery(sqlQuery);
	
		while (rs.next()){
			info=new LicBean();
			if(rs.getString("applicationId")!=null){
				info.setAppId(rs.getString("applicationId"));
			}
			if(rs.getString("employeename")!=null){
				info.setMemberName(rs.getString("employeename"));
			}
			if(rs.getString("formtype")!=null){
				info.setFormType(rs.getString("formtype"));
			}
			
			if(rs.getString("pensionno")!=null){
				info.setEmployeeNo(rs.getString("pensionno"));
				
			}
			
			if(rs.getString("status")!=null){
				info.setStatus(rs.getString("status"));
			}
			if(rs.getString("region")!=null){
				info.setRegion(rs.getString("region"));
			}
			if(rs.getString("appdate")!=null){
			
				info.setAppDate(CommonUtil
						.converDBToAppFormat(rs.getDate("appdate")));
			}
			list.add(info.toString());
			
		}
		
		}catch(Exception e){
			e.printStackTrace();
			
		}finally{
			DBUtils.closeConnection(rs, st, con);
		}
		
		return list;
	}
	public ArrayList getRejectedRemarks(String appid) {
		String sqlQuery="select slno,APPID,REJECTED_REMARKS,REJECTEDBY,REJECTEDDATE from sbs_rejected_log where appid="+appid+" order by slno";
		
	ArrayList list=new ArrayList();
		Connection con=null;
		Statement st=null;
		ResultSet rs=null;
		SBSRejectedRemarksBean rbean=null;
		try{
		con=DBUtils.getConnection();
		st=con.createStatement();
		log.info(sqlQuery);
		rs=st.executeQuery(sqlQuery);
	
		while (rs.next()){
			rbean=new SBSRejectedRemarksBean();
			if(rs.getString("slno")!=null){
				rbean.setSno(rs.getString("slno"));
			}
			if(rs.getString("REJECTED_REMARKS")!=null){
				rbean.setRemarks(rs.getString("REJECTED_REMARKS"));
			}
			if(rs.getString("REJECTEDBY")!=null){
				rbean.setRejecteBy(rs.getString("REJECTEDBY"));
			}
			
			
			list.add(rbean);
			
		}
		
		}catch(Exception e){
			e.printStackTrace();
			
		}finally{
			DBUtils.closeConnection(rs, st, con);
		}
		
		return list;
	}
	public ArrayList getAnniutySearchLevel3(String unitcd,String unitType,String airport,String region) {
		String sqlQuery="";
		//System.out.println("unit cd==="+unitcd);
		//System.out.println("unit Type==="+unitType);
		//System.out.println("airport=="+airport);
		//System.out.println("region==="+region);
		unitType=checkNull(unitType);
		if(unitType.equals("U")){
			 sqlQuery="select s.appid as applicationId,s.pensionno,s.region,o.employeename,o.desegnation,s.form_type as formtype,s.approve3 as status,s.appdate,finNoIncrement,finArrear,finPreOBadj,obOtherReason,finOBadjCorpusCard,finCorpusVerified from SBS_Annuity_Forms s,employee_personal_info o  where s.pensionno=o.pensionno and  s.formsubmit='Y' and s.approve2='A'  and s.airport=(select unitname from employee_unit_master  where unitcode='"+unitcd+"'and  sbsacctype='SAU') ";
			}else if(unitType.equals("R")){
				if(region.equals("CHQIAD")){
					sqlQuery="select s.appid as applicationId,s.pensionno,s.region,o.employeename,o.desegnation,s.form_type as formtype,s.approve3 as status,s.appdate,finNoIncrement,finArrear,finPreOBadj,obOtherReason,finOBadjCorpusCard,finCorpusVerified from SBS_Annuity_Forms s,employee_personal_info o  where s.pensionno=o.pensionno and  s.formsubmit='Y' and s.approve2='A'  and s.airport ='"+airport+"' and s.region='CHQIAD'";
				}else{
					//sqlQuery="select s.appid as applicationId,s.pensionno,o.employeename,o.desegnation,s.form_type as formtype,s.approve3 as status,s.appdate,finNoIncrement,finArrear,finPreOBadj,obOtherReason,finOBadjCorpusCard,finCorpusVerified from SBS_Annuity_Forms s,employee_personal_info o  where s.pensionno=o.pensionno and  s.formsubmit='Y' and s.approve2='A'  and s.airport in(select unitname from employee_unit_master m where m.region=(select region from employee_unit_master  where unitcode='"+unitcd+"') and m.sbsacctype='RAU') ";
					sqlQuery="select s.appid as applicationId,s.pensionno,s.region,o.employeename,o.desegnation,s.form_type as formtype,s.approve3 as status,s.appdate,finNoIncrement,finArrear,finPreOBadj,obOtherReason,finOBadjCorpusCard,finCorpusVerified from SBS_Annuity_Forms s,employee_personal_info o  where s.pensionno=o.pensionno and  s.formsubmit='Y' and s.approve2='A'  and s.airport in(select unitname from employee_unit_master m where m.region=(select region from employee_unit_master  where unitcode='"+unitcd+"') and m.sbsacctype='RAU') and s.region!='CHQIAD' ";
				}
				}else if(unitType.equals("C")){
				sqlQuery="select s.appid as applicationId,s.pensionno,s.region,o.employeename,o.desegnation,s.form_type as formtype,s.approve3 as status,s.appdate,finNoIncrement,finArrear,finPreOBadj,obOtherReason,finOBadjCorpusCard,finCorpusVerified from SBS_Annuity_Forms s,employee_personal_info o  where s.pensionno=o.pensionno and  s.formsubmit='Y' and s.chqhrapprove='A'  and s.airport='CHQNAD'";	
			}else{
				sqlQuery="select s.appid as applicationId,s.pensionno,s.region,o.employeename,o.desegnation,s.form_type as formtype,s.approve3 as status,s.appdate,finNoIncrement,finArrear,finPreOBadj,obOtherReason,finOBadjCorpusCard,finCorpusVerified from SBS_Annuity_Forms s,employee_personal_info o  where s.pensionno=o.pensionno and  s.formsubmit='Y' and s.approve2='A'  ";
			}
		System.out.println("sqlQuery==="+sqlQuery);
		ArrayList list=new ArrayList();
		Connection con=null;
		Statement st=null;
		ResultSet rs=null;
		LicBean info=null;
		try{
		con=DBUtils.getConnection();
		st=con.createStatement();
		rs=st.executeQuery(sqlQuery);
	
		while (rs.next()){
			info=new LicBean();
			if(rs.getString("applicationId")!=null){
				info.setAppId(rs.getString("applicationId"));
			}
			if(rs.getString("employeename")!=null){
				info.setMemberName(rs.getString("employeename"));
			}
			if(rs.getString("formtype")!=null){
				info.setFormType(rs.getString("formtype"));
			}
			
			if(rs.getString("pensionno")!=null){
				info.setEmployeeNo(rs.getString("pensionno"));
				
			}
			
			if(rs.getString("status")!=null){
				info.setStatus(rs.getString("status"));
			}
			if(rs.getString("region")!=null){
				info.setRegion(rs.getString("region"));
			}
			if(rs.getString("appdate")!=null){
			
				info.setAppDate(CommonUtil
						.converDBToAppFormat(rs.getDate("appdate")));
			}
		
			list.add(info.toString());
			
		}
		
		}catch(Exception e){
			e.printStackTrace();
			
		}finally{
			DBUtils.closeConnection(rs, st, con);
		}
		
		return list;
	}
	public ArrayList getAnniutySearchRHQHR(String unitcd,String unitType,String airport,String region) {
		String sqlQuery="";
		if(unitType.equals("R")){ 
			if(region.equals("CHQIAD")){
			sqlQuery="select s.appid as applicationId,s.pensionno,s.region,o.employeename,o.desegnation,s.form_type as formtype,s.rhqhrapprove as status,s.appdate from SBS_Annuity_Forms s,employee_personal_info o  where s.pensionno=o.pensionno and  s.formsubmit='Y' and s.approve3='A' and s.airport ='"+airport+"'";
			}else{
				sqlQuery="select s.appid as applicationId,s.pensionno,s.region,o.employeename,o.desegnation,s.form_type as formtype,s.rhqhrapprove as status,s.appdate from SBS_Annuity_Forms s,employee_personal_info o  where s.pensionno=o.pensionno and  s.formsubmit='Y' and s.approve3='A' and s.region!='CHQIAD' and s.airport in(select unitname from employee_unit_master m where m.region=(select region from employee_unit_master  where unitcode='"+unitcd+"'))";	
			}
			}else{
		 sqlQuery="select s.appid as applicationId,s.pensionno,s.region,o.employeename,o.desegnation,s.form_type as formtype,s.rhqhrapprove as status,s.appdate from SBS_Annuity_Forms s,employee_personal_info o  where s.pensionno=o.pensionno and  s.formsubmit='Y' and s.approve3='A' ";
		
		}
		ArrayList list=new ArrayList();
		Connection con=null;
		Statement st=null;
		ResultSet rs=null;
		LicBean info=null;
		try{
		con=DBUtils.getConnection();
		st=con.createStatement();
		rs=st.executeQuery(sqlQuery);
	
		while (rs.next()){
			info=new LicBean();
			if(rs.getString("applicationId")!=null){
				info.setAppId(rs.getString("applicationId"));
			}
			if(rs.getString("employeename")!=null){
				info.setMemberName(rs.getString("employeename"));
			}
			if(rs.getString("formtype")!=null){
				info.setFormType(rs.getString("formtype"));
			}
			
			if(rs.getString("pensionno")!=null){
				info.setEmployeeNo(rs.getString("pensionno"));
				
			}
			
			if(rs.getString("status")!=null){
				info.setStatus(rs.getString("status"));
			}
			if(rs.getString("region")!=null){
				info.setRegion(rs.getString("region"));
			}
			if(rs.getString("appdate")!=null){
			
				info.setAppDate(CommonUtil
						.converDBToAppFormat(rs.getDate("appdate")));
			}
			list.add(info.toString());
			
		}
		
		}catch(Exception e){
			e.printStackTrace();
			
		}finally{
			DBUtils.closeConnection(rs, st, con);
		}
		
		return list;
	}
	public ArrayList getAnniutySearchRHQFin(String unitcd,String unitType,String airport,String region) {
		String sqlQuery="";
		if(unitType.equals("R")){
			if(region.equals("CHQIAD")){
			sqlQuery="select s.appid as applicationId,s.pensionno,s.region,o.employeename,o.desegnation,s.form_type as formtype,s.rhqfinapprove as status,s.appdate from SBS_Annuity_Forms s,employee_personal_info o  where s.pensionno=o.pensionno and  s.formsubmit='Y' and s.rhqhrapprove='A' and s.airport ='"+airport+"'  and s.region='CHQIAD'";
			System.out.println("CHQIAD==111=="+sqlQuery);
			}else{
				sqlQuery="select s.appid as applicationId,s.pensionno,s.region,o.employeename,o.desegnation,s.form_type as formtype,s.rhqfinapprove as status,s.appdate from SBS_Annuity_Forms s,employee_personal_info o  where s.pensionno=o.pensionno and  s.formsubmit='Y' and s.rhqhrapprove='A' and s.region!='CHQIAD'  and s.airport in(select unitname from employee_unit_master m where m.region=(select region from employee_unit_master  where unitcode='"+unitcd+"') )";	
				System.out.println("Else CHQIAD===="+sqlQuery);
			}
			}else{
		 sqlQuery="select s.appid as applicationId,s.pensionno,s.region,o.employeename,o.desegnation,s.form_type as formtype,s.rhqfinapprove as status,s.appdate from SBS_Annuity_Forms s,employee_personal_info o  where s.pensionno=o.pensionno and  s.formsubmit='Y' and s.rhqhrapprove='A' ";
		 System.out.println("Else unittype R===="+sqlQuery);
		}ArrayList list=new ArrayList();
		Connection con=null;
		Statement st=null;
		ResultSet rs=null;
		LicBean info=null;
		try{
		con=DBUtils.getConnection();
		st=con.createStatement();
		rs=st.executeQuery(sqlQuery);
	
		while (rs.next()){
			info=new LicBean();
			if(rs.getString("applicationId")!=null){
				info.setAppId(rs.getString("applicationId"));
			}
			if(rs.getString("employeename")!=null){
				info.setMemberName(rs.getString("employeename"));
			}
			if(rs.getString("formtype")!=null){
				info.setFormType(rs.getString("formtype"));
			}
			
			if(rs.getString("pensionno")!=null){
				info.setEmployeeNo(rs.getString("pensionno"));
				
			}
			
			if(rs.getString("status")!=null){
				info.setStatus(rs.getString("status"));
			}
			if(rs.getString("region")!=null){
				info.setRegion(rs.getString("region"));
			}
			if(rs.getString("appdate")!=null){
			
				info.setAppDate(CommonUtil
						.converDBToAppFormat(rs.getDate("appdate")));
			}
			list.add(info.toString());
			
		}
		
		}catch(Exception e){
			e.printStackTrace();
			
		}finally{
			DBUtils.closeConnection(rs, st, con);
		}
		
		return list;
	}
	public ArrayList getAnniutySearchCHQHR(String unitcd,String unitType,String airport,String region) {
		String sqlQuery="";
	
		sqlQuery="select s.appid as applicationId,s.pensionno,o.employeename,o.desegnation,s.form_type as formtype,s.chqhrapprove as status,s.appdate,s.airport,s.region from SBS_Annuity_Forms s,employee_personal_info o  where s.pensionno=o.pensionno and  s.formsubmit='Y' and s.approve2='A' and s.airport='CHQNAD' and s.approve3 is null "+ 
			" union select s.appid as applicationId,s.pensionno,o.employeename,o.desegnation,s.form_type as formtype,s.chqhrapprove as status,s.appdate,s.airport,s.region from SBS_Annuity_Forms s,employee_personal_info o  where s.pensionno=o.pensionno and  s.formsubmit='Y' and s.rhqfinapprove='A'";
		
		// sqlQuery="select s.appid as applicationId,s.pensionno,o.employeename,o.desegnation,s.form_type as formtype,s.chqhrapprove as status,s.appdate from SBS_Annuity_Forms s,employee_personal_info o  where s.pensionno=o.pensionno and  s.formsubmit='Y' and s.rhqfinapprove='A' ";
		ArrayList list=new ArrayList();
		Connection con=null;
		Statement st=null;
		ResultSet rs=null;
		LicBean info=null;
		try{
		con=DBUtils.getConnection();
		st=con.createStatement();
		rs=st.executeQuery(sqlQuery);
	
		while (rs.next()){
			info=new LicBean();
			if(rs.getString("applicationId")!=null){
				info.setAppId(rs.getString("applicationId"));
			}
			if(rs.getString("employeename")!=null){
				info.setMemberName(rs.getString("employeename"));
			}
			if(rs.getString("formtype")!=null){
				info.setFormType(rs.getString("formtype"));
			}
			
			if(rs.getString("pensionno")!=null){
				info.setEmployeeNo(rs.getString("pensionno"));
				
			}
			if(rs.getString("region")!=null){
				info.setRegion(rs.getString("region"));
				
			}
			if(rs.getString("status")!=null){
				info.setStatus(rs.getString("status"));
			}
			if(rs.getString("appdate")!=null){
			
				info.setAppDate(CommonUtil
						.converDBToAppFormat(rs.getDate("appdate")));
			}
			list.add(info.toString());
			
		}
		
		}catch(Exception e){
			e.printStackTrace();
			
		}finally{
			DBUtils.closeConnection(rs, st, con);
		}
		
		return list;
	}
	public ArrayList getAnniutySearchCHQFin() {
		String sqlQuery="select s.appid as applicationId,s.pensionno,o.employeename,o.desegnation,s.form_type as formtype,s.chqfinapprove as status,s.appdate from SBS_Annuity_Forms s,employee_personal_info o  where s.pensionno=o.pensionno and  s.formsubmit='Y' and s.chqhrapprove='A' ";
		ArrayList list=new ArrayList();
		Connection con=null;
		Statement st=null;
		ResultSet rs=null;
		LicBean info=null;
		try{
		con=DBUtils.getConnection();
		st=con.createStatement();
		rs=st.executeQuery(sqlQuery);
	
		while (rs.next()){
			info=new LicBean();
			if(rs.getString("applicationId")!=null){
				info.setAppId(rs.getString("applicationId"));
			}
			if(rs.getString("employeename")!=null){
				info.setMemberName(rs.getString("employeename"));
			}
			if(rs.getString("formtype")!=null){
				info.setFormType(rs.getString("formtype"));
			}
			
			if(rs.getString("pensionno")!=null){
				info.setEmployeeNo(rs.getString("pensionno"));
				
			}
			
			if(rs.getString("status")!=null){
				info.setStatus(rs.getString("status"));
			}
			if(rs.getString("appdate")!=null){
			
				info.setAppDate(CommonUtil
						.converDBToAppFormat(rs.getDate("appdate")));
			}
			list.add(info.toString());
			
		}
		
		}catch(Exception e){
			e.printStackTrace();
			
		}finally{
			DBUtils.closeConnection(rs, st, con);
		}
		
		return list;
	}
	public ArrayList getAnniutyFundWithDrawal() {
		String sqlQuery="select s.appid as applicationId,s.pensionno,o.employeename,o.desegnation,s.form_type as formtype,s.edcpapprove as status,s.appdate,(select sum(t.sbscontri)+sum(t.interest) from sbs_yearwise_total t where t.pensionno=o.pensionno) as corpusamt from SBS_Annuity_Forms s,employee_personal_info o  where s.pensionno=o.pensionno and  s.formsubmit='Y' and s.edcpapprove='A' ";
		ArrayList list=new ArrayList();
		Connection con=null;
		Statement st=null;
		ResultSet rs=null;
		LicBean info=null;
		try{
		con=DBUtils.getConnection();
		st=con.createStatement();
		rs=st.executeQuery(sqlQuery);
	
		while (rs.next()){
			info=new LicBean();
			if(rs.getString("applicationId")!=null){
				info.setAppId(rs.getString("applicationId"));
			}
			if(rs.getString("employeename")!=null){
				info.setMemberName(rs.getString("employeename"));
			}
			if(rs.getString("formtype")!=null){
				info.setFormType(rs.getString("formtype"));
			}
			
			if(rs.getString("pensionno")!=null){
				info.setEmployeeNo(rs.getString("pensionno"));
				
			}
			
			if(rs.getString("status")!=null){
				info.setStatus(rs.getString("status"));
			}
			if(rs.getString("corpusamt")!=null){
				info.setCorpusAmt(rs.getString("corpusamt"));
			}
			if(rs.getString("appdate")!=null){
			
				info.setAppDate(CommonUtil
						.converDBToAppFormat(rs.getDate("appdate")));
			}
			list.add(info);
			
		}
		
		}catch(Exception e){
			e.printStackTrace();
			
		}finally{
			DBUtils.closeConnection(rs, st, con);
		}
		
		return list;
	}
	public ArrayList getAnniutyEDCPApproval(String unitcd,String unitType) {
		String sqlQuery="";
		//if(unitType.equals("C")){
			sqlQuery="select s.appid as applicationId,s.pensionno,s.region,o.employeename,o.desegnation,s.form_type as formtype,s.edcpapproval1 as status,s.appdate from SBS_Annuity_Forms s,employee_personal_info o  where s.pensionno=o.pensionno and  s.formsubmit='Y' and s.approve3='A' and s.airport='CHQNAD'"+
		" union select s.appid as applicationId,s.pensionno,s.region,o.employeename,o.desegnation,s.form_type as formtype,s.edcpapproval1 as status,s.appdate from SBS_Annuity_Forms s,employee_personal_info o  where s.pensionno=o.pensionno and  s.formsubmit='Y' and s.chqhrapprove='A' ";
		ArrayList list=new ArrayList();
		Connection con=null;
		Statement st=null;
		ResultSet rs=null;
		LicBean info=null;
		try{
		con=DBUtils.getConnection();
		st=con.createStatement();
		rs=st.executeQuery(sqlQuery);
	
		while (rs.next()){
			info=new LicBean();
			if(rs.getString("applicationId")!=null){
				info.setAppId(rs.getString("applicationId"));
			}
			if(rs.getString("employeename")!=null){
				info.setMemberName(rs.getString("employeename"));
			}
			if(rs.getString("formtype")!=null){
				info.setFormType(rs.getString("formtype"));
			}
			
			if(rs.getString("pensionno")!=null){
				info.setEmployeeNo(rs.getString("pensionno"));
				
			}
			
			if(rs.getString("status")!=null){
				info.setStatus(rs.getString("status"));
			}
			if(rs.getString("region")!=null){
				info.setRegion(rs.getString("region"));
			}
			if(rs.getString("appdate")!=null){
			
				info.setAppDate(CommonUtil
						.converDBToAppFormat(rs.getDate("appdate")));
			}
			list.add(info.toString());
			
		}
		
		}catch(Exception e){
			e.printStackTrace();
			
		}finally{
			DBUtils.closeConnection(rs, st, con);
		}
		
		return list;
	}
	public ArrayList getAnniutyEDCPApproval2(String unitcd,String unitType) {
		String sqlQuery="";
		//if(unitType.equals("C")){
			sqlQuery="select s.appid as applicationId,s.pensionno,s.region,o.employeename,o.desegnation,s.form_type as formtype,s.edcpapproval2 as status,s.appdate from SBS_Annuity_Forms s,employee_personal_info o  where s.pensionno=o.pensionno and  s.formsubmit='Y' and s.edcpapproval1='A' ";
		
	//String sqlQuery="select s.appid as applicationId,s.pensionno,o.employeename,o.desegnation,s.form_type as formtype,s.edcpapprove as status,s.appdate from SBS_Annuity_Forms s,employee_personal_info o  where s.pensionno=o.pensionno and  s.formsubmit='Y' and s.chqFinapprove='A' ";
		ArrayList list=new ArrayList();
		Connection con=null;
		Statement st=null;
		ResultSet rs=null;
		LicBean info=null;
		try{
		con=DBUtils.getConnection();
		st=con.createStatement();
		System.out.println("sqlQuery==="+sqlQuery);
		rs=st.executeQuery(sqlQuery);
	
		while (rs.next()){
			info=new LicBean();
			if(rs.getString("applicationId")!=null){
				info.setAppId(rs.getString("applicationId"));
			}
			if(rs.getString("employeename")!=null){
				info.setMemberName(rs.getString("employeename"));
			}
			if(rs.getString("formtype")!=null){
				info.setFormType(rs.getString("formtype"));
			}
			
			if(rs.getString("pensionno")!=null){
				info.setEmployeeNo(rs.getString("pensionno"));
				
			}
			
			if(rs.getString("status")!=null){
				info.setStatus(rs.getString("status"));
			}
			if(rs.getString("region")!=null){
				info.setRegion(rs.getString("region"));
			}
			if(rs.getString("appdate")!=null){
			
				info.setAppDate(CommonUtil
						.converDBToAppFormat(rs.getDate("appdate")));
			}
			list.add(info.toString());
			
		}
		
		}catch(Exception e){
			e.printStackTrace();
			
		}finally{
			DBUtils.closeConnection(rs, st, con);
		}
		System.out.println("list======DAOprasanthi==="+list);
		return list;
	}
	public ArrayList getAnniutyEDCPApproval3(String unitcd,String unitType) {
		String sqlQuery="";
		//if(unitType.equals("C")){
			sqlQuery="select s.appid as applicationId,s.pensionno,s.region,o.employeename,o.desegnation,s.form_type as formtype,s.edcpapproval3 as status,s.appdate from SBS_Annuity_Forms s,employee_personal_info o  where s.pensionno=o.pensionno and  s.formsubmit='Y' and s.edcpapproval2='A' ";
		
		//String sqlQuery="select s.appid as applicationId,s.pensionno,o.employeename,o.desegnation,s.form_type as formtype,s.edcpapprove as status,s.appdate from SBS_Annuity_Forms s,employee_personal_info o  where s.pensionno=o.pensionno and  s.formsubmit='Y' and s.chqFinapprove='A' ";
		ArrayList list=new ArrayList();
		Connection con=null;
		Statement st=null;
		ResultSet rs=null;
		LicBean info=null;
		try{
		con=DBUtils.getConnection();
		st=con.createStatement();
		rs=st.executeQuery(sqlQuery);
	
		while (rs.next()){
			info=new LicBean();
			if(rs.getString("applicationId")!=null){
				info.setAppId(rs.getString("applicationId"));
			}
			if(rs.getString("employeename")!=null){
				info.setMemberName(rs.getString("employeename"));
			}
			if(rs.getString("formtype")!=null){
				info.setFormType(rs.getString("formtype"));
			}
			
			if(rs.getString("pensionno")!=null){
				info.setEmployeeNo(rs.getString("pensionno"));
				
			}
			
			if(rs.getString("status")!=null){
				info.setStatus(rs.getString("status"));
			}
			if(rs.getString("region")!=null){
				info.setRegion(rs.getString("region"));
			}
			if(rs.getString("appdate")!=null){
			
				info.setAppDate(CommonUtil
						.converDBToAppFormat(rs.getDate("appdate")));
			}
			list.add(info.toString());
			
		}
		
		}catch(Exception e){
			e.printStackTrace();
			
		}finally{
			DBUtils.closeConnection(rs, st, con);
		}
		
		return list;
	}
	public ArrayList getAnniutyCoverLetter(String unitcd,String unitType) {
		String sqlQuery="";
		//if(unitType.equals("C")){
			sqlQuery="select s.appid as applicationId,s.pensionno,s.region,o.employeename,o.desegnation,s.form_type as formtype,s.edcpapproval3 as status,s.appdate from SBS_Annuity_Forms s,employee_personal_info o  where s.pensionno=o.pensionno and  s.formsubmit='Y' and s.edcpapproval3='A' ";
		
		//String sqlQuery="select s.appid as applicationId,s.pensionno,o.employeename,o.desegnation,s.form_type as formtype,s.edcpapprove as status,s.appdate from SBS_Annuity_Forms s,employee_personal_info o  where s.pensionno=o.pensionno and  s.formsubmit='Y' and s.chqFinapprove='A' ";
		ArrayList list=new ArrayList();
		Connection con=null;
		Statement st=null;
		ResultSet rs=null;
		LicBean info=null;
		try{
		con=DBUtils.getConnection();
		st=con.createStatement();
		rs=st.executeQuery(sqlQuery);
	
		while (rs.next()){
			info=new LicBean();
			if(rs.getString("applicationId")!=null){
				info.setAppId(rs.getString("applicationId"));
			}
			if(rs.getString("employeename")!=null){
				info.setMemberName(rs.getString("employeename"));
			}
			if(rs.getString("formtype")!=null){
				info.setFormType(rs.getString("formtype"));
			}
			
			if(rs.getString("pensionno")!=null){
				info.setEmployeeNo(rs.getString("pensionno"));
				
			}
			
			if(rs.getString("status")!=null){
				info.setStatus(rs.getString("status"));
			}
			if(rs.getString("region")!=null){
				info.setRegion(rs.getString("region"));
			}
			if(rs.getString("appdate")!=null){
			
				info.setAppDate(CommonUtil
						.converDBToAppFormat(rs.getDate("appdate")));
			}
			list.add(info.toString());
			
		}
		
		}catch(Exception e){
			e.printStackTrace();
			
		}finally{
			DBUtils.closeConnection(rs, st, con);
		}
		
		return list;
	}
	public ArrayList getAnniutyStatus(String pensionno) {
		String sqlQuery="select s.appid as applicationId,s.pensionno,o.employeename,o.desegnation,s.form_type as formtype,s.verfiedby as status,s.approve1,s.approve2,s.approve3,s.rhqhrapprove,s.rhqfinapprove,s.chqhrapprove,s.chqfinapprove,s.edcpapprove,s.appdate from SBS_Annuity_Forms s,employee_personal_info o  where s.pensionno=o.pensionno and  s.formsubmit='Y' and s.deleteflag='N' and s.pensionno="+pensionno;
		ArrayList list=new ArrayList();
		Connection con=null;
		Statement st=null;
		ResultSet rs=null;
		LicBean info=null;
		try{
		con=DBUtils.getConnection();
		st=con.createStatement();
		rs=st.executeQuery(sqlQuery);
	
		while (rs.next()){
			info=new LicBean();
			if(rs.getString("applicationId")!=null){
				info.setAppId(rs.getString("applicationId"));
			}
			if(rs.getString("employeename")!=null){
				info.setMemberName(rs.getString("employeename"));
			}
			if(rs.getString("formtype")!=null){
				info.setFormType(rs.getString("formtype"));
			}
			
			if(rs.getString("pensionno")!=null){
				info.setEmployeeNo(rs.getString("pensionno"));
				
			}
			
			if(rs.getString("status")!=null){
				info.setStatus(rs.getString("status"));
			}
			if(rs.getString("approve1")!=null){
				info.setAckApprove(rs.getString("approve1"));
			}
			if(rs.getString("approve2")!=null){
				info.setHrNodalApprove(rs.getString("approve2"));
			}
			if(rs.getString("approve3")!=null){
				info.setFinApprove(rs.getString("approve3"));
			}
			if(rs.getString("rhqhrapprove")!=null){
				info.setRhqHrApprove(rs.getString("rhqhrapprove"));
			}
			if(rs.getString("rhqfinapprove")!=null){
				info.setRhqFinApprove(rs.getString("rhqfinapprove"));
			}
			if(rs.getString("chqhrapprove")!=null){
				info.setChqHrApprove(rs.getString("chqhrapprove"));
			}
			if(rs.getString("chqfinapprove")!=null){
				info.setChqFinApprove(rs.getString("chqfinapprove"));
			}
			if(rs.getString("edcpapprove")!=null){
				info.setEdcpApprove(rs.getString("edcpapprove"));
			}
			
			if(rs.getString("appdate")!=null){
			
				info.setAppDate(CommonUtil
						.converDBToAppFormat(rs.getDate("appdate")));
			}
			list.add(info);
			
		}
		
		}catch(Exception e){
			e.printStackTrace();
			
		}finally{
			DBUtils.closeConnection(rs, st, con);
		}
		
		return list;
	}

	public LicBean getAnniutyForm(String appId) {
		
		String sqlQuery="select s.membername,o.desegnation,o.pensionno,o.newempcode,p.EMPSAPCODE,s.eligiblestatus ,to_char(s.intcalcdate,'dd-Mon-yyyy') as intcalcdate,to_char(o.dateofseperation_date,'dd-Mon-yyyy') as dateofseperation_date,to_char(s.RCFORMDATED, 'dd-Mon-yyyy') as RCFORMDATED, s.edcpcorpusamt,s.edcpcorpusint,s.edcptdsver, s.appid as applicationId,to_char(s.dateofexit,'dd-Mon-yyyy') as dateofexit,to_char(s.member_dob,'dd-Mon-yyyy') as member_dob,to_char(s.member_doj,'dd-Mon-yyyy') as member_doj,s.causeofexit,s.form_type as formtype,s.pensionno,o.employeename,o.desegnation,s.approve1 as status,s.appdate,s.corpusobadjustment,s.obremarks,s.dep_aai_otherorg," +
				"to_char(s.rhqhrintdate,'dd-Mon-yyyy') as rhqhrintdate,s.rhqhr_purchaseamt,to_char(s.rhqfinintdate,'dd-Mon-yyyy') as rhqfinintdate,s.rhqfin_purchseamt,s.spousename,s.spouseaddress,to_char(s.spousedob,'dd-Mon-yyyy') as spousedob,s.spouserelation ,decode(s.aaiedcpsoption,'A','Life Annuity','B','Life Annuity With Return Of Purchase Price','C','Joint Life Annuity','D','Joint Life Annuity with Return of Purchase Price','E','Refund Application (fifth option)') as aaiedcpsoptiondesc,s.aaiedcpsoption,s.modeofpayment, s.servicebook,s.cpse,s.cad,s.crs,s.resign,s.vrs,s.deputation,s.arrear,s.totcorpus2lakhs,s.deathcertficate,s.notionalincrement,s.notionaldisplay,s.obadjustment," +
				"  p.address,p.permentaddress, p.nomineename,p.nominee2name,p.nominee3name,p.relation,p.PANNO,to_char(p.nomineedob,'dd-Mon-yyyy') as nomineedob,p.adharno,p.phoneno,p.email,p.alternatemobile, b.bankname,b.branch, b.ifsc,b.account_type,b.account_no,b.micrcode," + 
				"b.customername,b.customername2,b.accountno2,b.bankname2,b.micrcode2,b.branchaddr2,b.ifsccode2,s.claimform,s.identitycard,s.payslip,s.pancard,s.adharcard,s.cancelcheque,s.photograph,s.deceasedemployee,s.nominationdoc,s.nomineeproof,s.totcorpus2lakhs,s.deathcertficate,n.percentage,finNoIncrement,finArrear,finPreOBadj,obOtherReason,finOBadjCorpusCard,finCorpusVerified,town,state,pincode,p.nationality,fathersname,p.gender,s.region,s.airport,s.secannuitantgender,s.secannuitantpan," +
				"(select to_char(transdate,'dd-Mon-yyyy') from sbs_annuity_transations  where appid= s.appid and transdescription='HR Level1 Approval')as ackaprovedate,(select to_char(transdate,'dd-Mon-yyyy') from sbs_annuity_transations  where appid= s.appid and transdescription='HR Level2 Approval')as hraprovedate,(select to_char(transdate,'dd-Mon-yyyy') from sbs_annuity_transations  where appid= s.appid and transdescription='Finance Approval')as finaprovedate,(select to_char(transdate,'dd-Mon-yyyy') from sbs_annuity_transations  where appid= s.appid " +
				"and approvedby='EDCPapprove3')as edcpaprovedate,(select to_char(transdate,'dd-Mon-yyyy') from sbs_annuity_transations  where appid= s.appid " +
				"and approvedby='EDCPapprove2')as edcpaprovedate2,(select to_char(transdate,'dd-Mon-yyyy') from sbs_annuity_transations  where appid= s.appid and approvedby='EDCPapprove1')as edcpaprovedate1,(select to_char(transdate,'dd-Mon-yyyy') from sbs_annuity_transations  where appid= s.appid and approvedby='CHQHR')as chqhraprovedate,(select to_char(transdate,'dd-Mon-yyyy') from sbs_annuity_transations  where appid= s.appid and approvedby='RHQHR')as rhqhraprovedate,(select to_char(transdate,'dd-Mon-yyyy') from sbs_annuity_transations  where appid= s.appid and approvedby='RHQFIN')as rhqfinaprovedate, (select u.displayname from epis_user u where u.userid=(select approvedbyid  from sbs_annuity_transations  where appid = s.appid   and transcd = '18')) as edcpdisplayname1,(select u.displayname from epis_user u where u.userid=(select approvedbyid  from sbs_annuity_transations  where appid = s.appid   and transcd = '16')) as chqhrdisplayname,  (select u.designation from epis_user u where u.userid=(select approvedbyid   from sbs_annuity_transations  where appid = s.appid  and transcd = '18')) as edcpdesignation1,(select u.designation from epis_user u where u.userid=(select approvedbyid   from sbs_annuity_transations  where appid = s.appid  and transcd = '16')) as chqhrdesignation, (select u.designation from epis_user u where u.userid=(select approvedbyid   from sbs_annuity_transations  where appid = s.appid  and transcd = '14')) as rhqhrdesignation, (select u.designation from epis_user u where u.userid=(select approvedbyid   from sbs_annuity_transations  where appid = s.appid  and transcd = '15')) as rhqfindesignation, (select u.displayname from epis_user u where u.userid=(select approvedbyid from sbs_annuity_transations where appid = s.appid and transcd = '12')) as hr2displayname,(select u.displayname from epis_user u where u.userid=(select approvedbyid from sbs_annuity_transations  where appid = s.appid and transcd = '11')) as hr1displayname,  (select u.displayname from epis_user u where u.userid=(select approvedbyid  from sbs_annuity_transations  where appid = s.appid   and transcd = '13')) as findisplayname,  (select u.displayname from epis_user u where u.userid=(select approvedbyid  from sbs_annuity_transations  where appid = s.appid   and transcd = '14')) as rhqhrdisplayname,  (select u.displayname from epis_user u where u.userid=(select approvedbyid  from sbs_annuity_transations  where appid = s.appid   and transcd = '15')) as rhqfindisplayname,  (select u.designation from epis_user u where u.userid=(select approvedbyid   from sbs_annuity_transations  where appid = s.appid  and transcd = '11')) as hr1designation,  (select u.designation from epis_user u where u.userid=(select approvedbyid  from sbs_annuity_transations   where appid = s.appid  and transcd = '12')) as hr2designation,   (select u.designation from epis_user u where u.userid=(select approvedbyid  from sbs_annuity_transations  where appid = s.appid and transcd = '13')) as findesignation, (select u.designation from epis_user u where u.userid=(select approvedbyid  from sbs_annuity_transations  where appid = s.appid and transcd = '14')) as rhqhrdesignation, (select u.designation from epis_user u where u.userid=(select approvedbyid  from sbs_annuity_transations  where appid = s.appid and transcd = '15')) as rhqfindesignation from SBS_Annuity_Forms s,employee_personal_info o,sbs_annuity_personal p,sbs_annuity_bank b,sbs_annuity_nominee n " +
				"where s.pensionno=o.pensionno  and s.appid=p.appid and s.appid=b.appid  and s.appid = n.appid(+)  and s.formsubmit='Y'  and s.appid="+appId;
		
		Connection con=null;
		Statement st=null;
		ResultSet rs=null;
		LicBean info=null;
		try{
		con=DBUtils.getConnection();
		st=con.createStatement();
		System.out.println("sqlQuery===="+sqlQuery);
		rs=st.executeQuery(sqlQuery);
	
		if (rs.next()){
			info=new LicBean();
			
			
			if(rs.getString("edcpaprovedate2")!=null){
				info.setEdcpApproveDate2(rs.getString("edcpaprovedate2"));
			}else {
				info.setEdcpApproveDate2("");
			}
			
			if(rs.getString("chqhraprovedate")!=null){
				info.setChqHrApprovedate(rs.getString("chqhraprovedate"));
			}else {
				info.setChqHrApprovedate("");
			}
			if(rs.getString("chqhrdisplayname")!=null){
				info.setChqHrDisp(rs.getString("chqhrdisplayname"));
			}else {
				info.setChqHrDisp("");
			}
			if(rs.getString("chqhrdesignation")!=null){
				info.setChqhrDesig(rs.getString("chqhrdesignation"));
			}else {
				info.setChqhrDesig("");
			}
			if(rs.getString("newempcode")!=null){
				info.setNewEmpCode(rs.getString("newempcode"));
			}else {
				info.setNewEmpCode("");
			}
			if(rs.getString("RCFORMDATED")!=null){
				info.setPolicyStartDate(rs.getString("RCFORMDATED"));
			}else {
				info.setPolicyStartDate("");
			}
			
			
			
			if(rs.getString("rhqhrintdate")!=null){
				info.setRhqHrIntDate(rs.getString("rhqhrintdate"));
			}else {
				info.setRhqHrIntDate("");
			}
			if(rs.getString("rhqhr_purchaseamt")!=null){
				info.setRhqHrPurchaseAmt(rs.getString("rhqhr_purchaseamt"));
			}else {
				info.setRhqHrPurchaseAmt("");
			}
			if(rs.getString("rhqfinintdate")!=null){
				info.setRhqFinIntDate(rs.getString("rhqfinintdate"));
			}else {
				info.setRhqFinIntDate("");
			}
			if(rs.getString("rhqfin_purchseamt")!=null){
				info.setRhqFinPurchaseAmt(rs.getString("rhqfin_purchseamt"));
			}else {
				info.setRhqFinPurchaseAmt("");
			}
			if(rs.getString("eligiblestatus")!=null){
				info.setEligibleStatus(rs.getString("eligiblestatus"));
			}else {
				info.setEligibleStatus("");
			}
			if(rs.getString("edcpdesignation1")!=null){
				info.setEdcpDesignation1(rs.getString("edcpdesignation1"));
			}else {
				info.setEdcpDesignation1("");
			}
			if(rs.getString("rhqhrdesignation")!=null){
				info.setRhqHrDesignation(rs.getString("rhqhrdesignation"));
			}else {
				info.setRhqHrDesignation("");
			}
			if(rs.getString("rhqfindesignation")!=null){
				info.setRhqFinDesignation(rs.getString("rhqfindesignation"));
			}else {
				info.setRhqFinDesignation("");
			}
			if(rs.getString("edcpdesignation1")!=null){
				info.setEdcpDesignation1(rs.getString("edcpdesignation1"));
			}else {
				info.setEdcpDesignation1("");
			}
			if(rs.getString("edcpaprovedate1")!=null){
				info.setEdcpApproveDate1(rs.getString("edcpaprovedate1"));
			}else {
				info.setEdcpApproveDate1("");
			}
			if(rs.getString("edcpdisplayname1")!=null){
				info.setEdcpDisplayname1(rs.getString("edcpdisplayname1"));
			}else {
				info.setEdcpDisplayname1("");
			}
			if(rs.getString("rhqfindisplayname")!=null){
				info.setRhqFinDisplayname(rs.getString("rhqfindisplayname"));
			}else {
				info.setRhqFinDisplayname("");
			}
			if(rs.getString("rhqhrdisplayname")!=null){
				info.setRhqHrDisplayname(rs.getString("rhqhrdisplayname"));
			}else {
				info.setRhqHrDisplayname("");
			}
			if(rs.getString("rhqfindisplayname")!=null){
				info.setFindisplayname(rs.getString("rhqfindisplayname"));
			}else {
				info.setFindisplayname("");
			}
			if(rs.getString("findisplayname")!=null){
				info.setFindisplayname(rs.getString("findisplayname"));
			}else {
				info.setFindisplayname("");
			}
			if(rs.getString("hr2displayname")!=null){
				info.setHr2displayname(rs.getString("hr2displayname"));
			}else {
				info.setHr2displayname("");
			}
			if(rs.getString("hr1displayname")!=null){
				info.setHr1displayname(rs.getString("hr1displayname"));
			}else {
				info.setHr1displayname("");
			}
			if(rs.getString("findesignation")!=null){
				info.setFindesignation(rs.getString("findesignation"));
			}else {
				info.setFindesignation("");
			}
			if(rs.getString("hr2designation")!=null){
				info.setHr2designation(rs.getString("hr2designation"));
			}else {
				info.setHr2designation("");
			}
			if(rs.getString("hr1designation")!=null){
				info.setHr1designation(rs.getString("hr1designation"));
			}else {
				info.setHr1designation("");
			}
			
			if(rs.getString("aaiedcpsoptiondesc")!=null){
				info.setAaiEDCPSoptionDesc(rs.getString("aaiedcpsoptiondesc"));
			}else {
				info.setAaiEDCPSoptionDesc("");
			}
			if(rs.getString("ackaprovedate")!=null){
				info.setAckApproveDate(rs.getString("ackaprovedate"));
			}else {
				info.setAckApproveDate("");
			}
			if(rs.getString("hraprovedate")!=null){
				info.setHrApproveDate(rs.getString("hraprovedate"));
			}else {
				info.setHrApproveDate("");
			}
			if(rs.getString("finaprovedate")!=null){
				info.setFinApproveDate(rs.getString("finaprovedate"));
			}else {
				info.setFinApproveDate("");
			}
			if(rs.getString("rhqhraprovedate")!=null){
				info.setRhqHrApproveDate(rs.getString("rhqhraprovedate"));
			}else {
				info.setRhqHrApproveDate("");
			}
			if(rs.getString("rhqfinaprovedate")!=null){
				info.setRhqFinApproveDate(rs.getString("rhqfinaprovedate"));
			}else {
				info.setRhqFinApproveDate("");
			}
			if(rs.getString("edcpaprovedate")!=null){
				info.setEdcpApproveDate(rs.getString("edcpaprovedate"));
			}else {
				info.setEdcpApproveDate("");
			}
			if(rs.getString("desegnation")!=null){
				info.setDesignation(rs.getString("desegnation"));
			}
			
			if(rs.getString("intcalcdate")!=null){
				info.setIntcalcdate(rs.getString("intcalcdate"));
			}
			if(rs.getString("edcpcorpusamt")!=null){
				info.setEdcpCorpusAmt(rs.getString("edcpcorpusamt"));
			}else{
				info.setEdcpCorpusAmt("0");
			}
			if(rs.getString("edcpcorpusint")!=null){
				info.setEdcpCorpusint(rs.getString("edcpcorpusint"));
			}else{
				info.setEdcpCorpusint("0");
			}
			if(rs.getString("edcptdsver")!=null){
				info.setTdsrec(rs.getString("edcptdsver"));
			}
			if(rs.getString("region")!=null){
				info.setRegion(rs.getString("region"));
			}
			if(rs.getString("airport")!=null){
				info.setAirport(rs.getString("airport"));
			}
			
			if(rs.getString("applicationId")!=null){
				info.setAppId(rs.getString("applicationId"));
			}
			if(rs.getString("aaiedcpsoption")!=null){
				info.setAaiEDCPSoption(rs.getString("aaiedcpsoption"));
			}
			if(rs.getString("modeofpayment")!=null){
				info.setPaymentMode(rs.getString("modeofpayment"));
			}
			if(rs.getString("membername")!=null){
				info.setMemberName(rs.getString("membername"));
			}
			if(rs.getString("formtype")!=null){
				info.setFormType(rs.getString("formtype"));
			}
			if(rs.getString("dateofexit")!=null){
				info.setDateOfexit(rs.getString("dateofexit"));
			}
			if(rs.getString("member_dob")!=null){
				info.setDob(rs.getString("member_dob"));
			}
			if(rs.getString("member_doj")!=null){
				info.setDoj(rs.getString("member_doj"));
			}
			if(rs.getString("causeofexit")!=null){
				info.setExitReason(rs.getString("causeofexit"));
			}
			
		
			if(rs.getString("pensionno")!=null){
				info.setEmployeeNo(rs.getString("pensionno"));
				
			}
			
			if(rs.getString("status")!=null){
				info.setStatus(rs.getString("status"));
			}
			if(rs.getString("appdate")!=null){
			
				info.setAppDate(CommonUtil
						.converDBToAppFormat(rs.getDate("appdate")));
			}
			//spouse details
			if(rs.getString("spousename")!=null){
				info.setSpouseName(rs.getString("spousename"));
				
			}
			if(rs.getString("spouseaddress")!=null){
				info.setSpouseAdd(rs.getString("spouseaddress"));
				
			}
			if(rs.getString("spousedob")!=null){
				info.setSpouseDob(rs.getString("spousedob"));
				
			}
			if(rs.getString("spouserelation")!=null){
				info.setSpouseRelation(rs.getString("spouserelation"));
				
			}
			//personal
			if(rs.getString("address")!=null){
				info.setMemberAddress(rs.getString("address"));
			}
			if(rs.getString("permentaddress")!=null){
				info.setMemberPerAdd(rs.getString("permentaddress"));
			}
			if(rs.getString("nomineename")!=null){
				info.setNomineeName(rs.getString("nomineename"));
			}
			if(rs.getString("nominee2name")!=null){
				info.setNomineeName2(rs.getString("nominee2name"));
			}
			if(rs.getString("nominee3name")!=null){
				info.setNomineeName3(rs.getString("nominee3name"));
			}
			if(rs.getString("EMPSAPCODE")!=null){
				info.setEmpsapCode(rs.getString("EMPSAPCODE"));
			}
			
			
			
			if(rs.getString("nomineedob")!=null){
				info.setNomineeDob(rs.getString("nomineedob"));
			}
			if(rs.getString("adharno")!=null){
				info.setAdharno(rs.getString("adharno"));
			}
			if(rs.getString("relation")!=null){
				info.setRelationtoMember(rs.getString("relation"));
			}
			if(rs.getString("phoneno")!=null){
				info.setMobilNo(rs.getString("phoneno"));
			}
			if(rs.getString("PANNO")!=null){
				info.setPanNo(rs.getString("PANNO"));
			}
			if(rs.getString("email")!=null){
				info.setEmail(rs.getString("email"));
			}
			
			if(rs.getString("alternatemobile")!=null){
				info.setMobilNo1(rs.getString("alternatemobile"));
				
			}
			if(rs.getString("town")!=null){
				info.setCtv(rs.getString("town"));
			}
			if(rs.getString("state")!=null){
				info.setState(rs.getString("state"));
			}
			if(rs.getString("pincode")!=null){
				info.setPinCode(rs.getString("pincode"));
			}
			if(rs.getString("nationality")!=null){
				info.setNationality(rs.getString("nationality"));
			}
			if(rs.getString("fathersname")!=null){
				info.setFatherName(rs.getString("fathersname"));
			}
			if(rs.getString("gender")!=null){
				info.setGender(rs.getString("gender"));
			}
			if(rs.getString("secannuitantgender")!=null){
				info.setSecAnnuitantGender(rs.getString("secannuitantgender"));
			}
			if(rs.getString("secannuitantpan")!=null){
				info.setSecAnnuitantPAN(rs.getString("secannuitantpan"));
			}
			
			
			
			//bank
			if(rs.getString("bankname")!=null){
				info.setBankName(rs.getString("bankname"));
			}
			if(rs.getString("branch")!=null){
				info.setBranch(rs.getString("branch"));
			}
			if(rs.getString("ifsc")!=null){
				info.setIfscCode(rs.getString("ifsc"));
			}
			if(rs.getString("account_type")!=null){
				info.setAccType(rs.getString("account_type"));
			}
			if(rs.getString("account_no")!=null){
				info.setAccNo(rs.getString("account_no"));
			}
			if(rs.getString("micrcode")!=null){
				info.setMicrCode(rs.getString("micrcode"));
			}
			if(rs.getString("customername")!=null){
				info.setCustomerName(rs.getString("customername"));
			}
			
			if(rs.getString("customername2")!=null){
				info.setCustomerName2(rs.getString("customername2"));
			}
			
			if(rs.getString("bankname2")!=null){
				info.setBankName2(rs.getString("bankname2"));
			}
			
			if(rs.getString("accountno2")!=null){
				info.setAccNo2(rs.getString("accountno2"));
			}
			
			if(rs.getString("micrcode2")!=null){
				info.setMicrCode2(rs.getString("micrcode2"));
			}
			
			if(rs.getString("branchaddr2")!=null){
				info.setBranch2(rs.getString("branchaddr2"));
			}
			
			if(rs.getString("ifsccode2")!=null){
				info.setIfscCode2(rs.getString("ifsccode2"));
			}
			
			
			//checklist
			if(rs.getString("claimform")!=null){
				info.setClaimForm(rs.getString("claimform"));
			}
			if(rs.getString("identitycard")!=null){
				info.setIdentityCard(rs.getString("identitycard"));
			}
			if(rs.getString("payslip")!=null){
				info.setPaySlip(rs.getString("payslip"));
			}
			if(rs.getString("pancard")!=null){
				info.setPanCard(rs.getString("pancard"));
			}
			if(rs.getString("adharcard")!=null){
				info.setAdharCard(rs.getString("adharcard"));
			}
			if(rs.getString("cancelcheque")!=null){
				info.setCancelCheque(rs.getString("cancelcheque"));
			}
			if(rs.getString("photograph")!=null){
				info.setPhotograph(rs.getString("photograph"));
			}
			if(rs.getString("deceasedemployee")!=null){
				info.setDeceasedemployee(rs.getString("deceasedemployee"));
			}
			if(rs.getString("nominationdoc")!=null){
				info.setNominationdoc(rs.getString("nominationdoc"));
			}
			if(rs.getString("nomineeproof")!=null){
				info.setNomineeproof(rs.getString("nomineeproof"));
			}
			if(rs.getString("percentage")!=null){
				info.setPercentage(rs.getString("percentage"));
			}
			
			
			
		//Eligibility List	
			if(rs.getString("servicebook")!=null){
				info.setServiceBook(rs.getString("servicebook"));
			}
			if(rs.getString("cpse")!=null){
				info.setCpse(rs.getString("cpse"));
			}
			if(rs.getString("cad")!=null){
				info.setCad(rs.getString("cad"));
			}
			if(rs.getString("crs")!=null){
				info.setCrs(rs.getString("crs"));
			}
			if(rs.getString("resign")!=null){
				info.setResign(rs.getString("resign"));
			}
			if(rs.getString("vrs")!=null){
				info.setVrs(rs.getString("vrs"));
			}
			if(rs.getString("deputation")!=null){
				info.setDeputation(rs.getString("deputation"));
			}
			if(rs.getString("totcorpus2lakhs")!=null){
				info.setTotcorpus2lakhs(rs.getString("totcorpus2lakhs"));
			}
			if(rs.getString("deathcertficate")!=null){
				info.setDeathcertficate(rs.getString("deathcertficate"));
			}
			if(rs.getString("arrear")!=null){
				info.setArrear(rs.getString("arrear"));
			}
			if(rs.getString("notionalincrement")!=null){
				info.setNotionalIncrement(rs.getString("notionalincrement"));
			}
			if(rs.getString("notionaldisplay")!=null){
				info.setNotionaldisplay(rs.getString("notionaldisplay"));
			}
			if(rs.getString("obadjustment")!=null){
				info.setObadjustment(rs.getString("obadjustment"));
			}
			
			
			
			
			
			//add Nominee List
			info.setNomineeList(this.getNomineeList(appId));
			
			
			//add Nominee Appointee list
			info.setNomineeAppointeeList(this.getNomineeAppointeeList(appId));
			
			//add rejectedremarks
			info.setRejectedList(this.getRejectedRemarks(appId));
			//fin checklist
			if(rs.getString("finNoIncrement")!=null){
				info.setFinNoIncrement(rs.getString("finNoIncrement"));
			}
			if(rs.getString("finArrear")!=null){
				info.setFinArrear(rs.getString("finArrear"));
			}
			if(rs.getString("finPreOBadj")!=null){
				info.setFinPreOBadj(rs.getString("finPreOBadj"));
			}
			if(rs.getString("obOtherReason")!=null){
				info.setObOtherReason(rs.getString("obOtherReason"));
			}
			if(rs.getString("finOBadjCorpusCard")!=null){
				info.setFinOBadjCorpusCard(rs.getString("finOBadjCorpusCard"));
			}
			if(rs.getString("finCorpusVerified")!=null){
				info.setFinCorpusVerified(rs.getString("finCorpusVerified"));
			}
			
			if(rs.getString("obremarks")!=null){
				info.setObRemarks(rs.getString("obremarks"));
			}
			if(rs.getString("corpusobadjustment")!=null){
				info.setCorpusOBAdjustment(rs.getString("corpusobadjustment"));
			}
			if(rs.getString("dep_aai_otherorg")!=null){
				info.setDepaaiToOtherorg(rs.getString("dep_aai_otherorg"));
			}
			if(rs.getString("dateofseperation_date")!=null){
				info.setDos(rs.getString("dateofseperation_date"));
			}
			
			//add Deputation  List
			info.setDepList(this.getDepList(appId));
			
		}
		
		}catch(Exception e){
			e.printStackTrace();
			
		}finally{
			DBUtils.closeConnection(rs, st, con);
		}
		
	return info;
		
	}
	public void getImage(String path, String userName) throws IOException,
	SQLException, SBSException {
FileOutputStream outputFileOutputStream = null;
String sqlText = null;
Statement stmt = null;
ResultSet rset = null;
long blobLength;
long position;
BLOB image = null;
int chunkSize;
byte[] binaryBuffer;
int bytesRead = 0;
int totbytesRead = 0;
int totbytesWritten = 0;
Connection con = null;
try {
	try {
		con = DBUtils.getConnection();
	} catch (Exception e) {
		// TODO Auto-generated catch block
		e.printStackTrace();
	}
	stmt = con.createStatement();
	con.setAutoCommit(false);
	File outputBinaryFile1 = new File(path);
	outputFileOutputStream = new FileOutputStream(outputBinaryFile1);
	sqlText = "SELECT esignatory " + "FROM   epis_user "
			+ "WHERE  USERNAME = '" + userName + "' FOR UPDATE";
	rset = stmt.executeQuery(sqlText);
	rset.next();
	image = ((OracleResultSet) rset).getBLOB("esignatory");
	
	blobLength = image.length();
	chunkSize = image.getChunkSize();
	binaryBuffer = new byte[chunkSize];
	for (position = 1; position <= blobLength; position += chunkSize) {
		bytesRead = image.getBytes(position, chunkSize, binaryBuffer);
		outputFileOutputStream.write(binaryBuffer, 0, bytesRead);
		totbytesRead += bytesRead;
		totbytesWritten += bytesRead;
	}
	outputFileOutputStream.close();
	con.commit();
	rset.close();
	stmt.close();

} catch (IOException e) {
	con.rollback();
	log.error("Caught I/O Exception: (Write BLOB value to file - Get Method).");
	e.printStackTrace();
	throw e;
} catch (SQLException e) {
	con.rollback();
	log.error("Caught SQL Exception: (Write BLOB value to file - Get Method).");
	log.error("SQL:\n" + sqlText);
	e.printStackTrace();
	throw e;
}
}
	/*public String readUserSignatures(String path,String approvedBy) throws SBSException{
		
		String finalPath="",signatureName="";
		try {
			userBean=this.readUserInfo(approvedBy);
			finalPath=path+userBean.getEsignatoryName();
			log.info("finalPath----"+finalPath);
			UserDAO.getInstance().getImage(finalPath,userBean.getUserName());
			signatureName=userBean.getEsignatoryName();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			throw new SBSException(e);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			throw new SBSException(e);
		} catch (SBSException e) {
			// TODO Auto-generated catch block
			throw e;
		}
		return signatureName;
	}*/

	public LicBean getAnniutyFormDraft(String pensionNo,String formtype) {

		
		String sqlQuery="select s.appid as applicationId,s.form_type as formtype,s.pensionno,s.membername,o.employeename,o.desegnation,s.approve1 as status,s.appdate,s.spousename,s.spouseaddress,s.spousedob,s.spouserelation ,s.aaiedcpsoption,s.modeofpayment," +
				"  p.address,p.permentaddress, p.nomineename,p.relation,p.PANNO,to_char(p.nomineedob,'dd-Mon-yyyy') as nomineedob,p.adharno,p.phoneno,p.email, b.bankname,b.branch, b.ifsc,b.account_type,b.account_no,b.micrcode from SBS_Annuity_Forms s,employee_personal_info o,sbs_annuity_personal p,sbs_annuity_bank b  " +
				"where s.pensionno=o.pensionno  and s.appid=p.appid and s.appid=b.appid and s.approve1 is null  and s.pensionno="+pensionNo+" and form_type='"+formtype+"'";
		
		Connection con=null;
		Statement st=null;
		ResultSet rs=null;
		LicBean info=null;
		try{
		con=DBUtils.getConnection();
		st=con.createStatement();
		rs=st.executeQuery(sqlQuery);
	
		if (rs.next()){
			info=new LicBean();
		
			
			if(rs.getString("applicationId")!=null){
				info.setAppId(rs.getString("applicationId"));
			}
			if(rs.getString("membername")!=null){
				info.setMemberName(rs.getString("membername"));
			}
			if(rs.getString("formtype")!=null){
				info.setFormType(rs.getString("formtype"));
			}
			if(rs.getString("aaiedcpsoption")!=null){
				info.setAaiEDCPSoption(rs.getString("aaiedcpsoption"));
			}
			if(rs.getString("modeofpayment")!=null){
				info.setPaymentMode(rs.getString("modeofpayment"));
			}
			
			if(rs.getString("pensionno")!=null){
				info.setEmployeeNo(rs.getString("pensionno"));
				
			}
			
			if(rs.getString("status")!=null){
				info.setStatus(rs.getString("status"));
			}
			if(rs.getString("appdate")!=null){
			
				info.setAppDate(CommonUtil
						.converDBToAppFormat(rs.getDate("appdate")));
			}
			//spouse details
			if(rs.getString("spousename")!=null){
				info.setSpouseName(rs.getString("spousename"));
				
			}
			if(rs.getString("spouseaddress")!=null){
				info.setSpouseAdd(rs.getString("spouseaddress"));
				
			}
			if(rs.getString("spousedob")!=null){
				info.setSpouseDob(rs.getString("spousedob"));
				
			}
			if(rs.getString("spouserelation")!=null){
				info.setSpouseRelation(rs.getString("spouserelation"));
				
			}
			//personal
			if(rs.getString("address")!=null){
				info.setMemberAddress(rs.getString("address"));
			}
			if(rs.getString("permentaddress")!=null){
				info.setMemberPerAdd(rs.getString("permentaddress"));
			}
			if(rs.getString("nomineename")!=null){
				info.setNomineeName(rs.getString("nomineename"));
			}
			if(rs.getString("nomineedob")!=null){
				info.setNomineeDob(rs.getString("nomineedob"));
			}
			if(rs.getString("adharno")!=null){
				info.setAdharno(rs.getString("adharno"));
			}
			if(rs.getString("relation")!=null){
				info.setRelationtoMember(rs.getString("relation"));
			}
			if(rs.getString("phoneno")!=null){
				info.setMobilNo(rs.getString("phoneno"));
			}
			if(rs.getString("PANNO")!=null){
				info.setPanNo(rs.getString("PANNO"));
			}
			if(rs.getString("email")!=null){
				info.setEmail(rs.getString("email"));
			}
			//bank
			if(rs.getString("bankname")!=null){
				info.setBankName(rs.getString("bankname"));
			}
			if(rs.getString("branch")!=null){
				info.setBranch(rs.getString("branch"));
			}
			if(rs.getString("ifsc")!=null){
				info.setIfscCode(rs.getString("ifsc"));
			}
			if(rs.getString("account_type")!=null){
				info.setAccType(rs.getString("account_type"));
			}
			if(rs.getString("account_no")!=null){
				info.setAccNo(rs.getString("account_no"));
			}
			if(rs.getString("micrcode")!=null){
				info.setMicrCode(rs.getString("micrcode"));
			}
			
			//add Nominee List
			info.setNomineeList(this.getNomineeList(info.getAppId()));
			
			
			//add Nominee Appointee list
			info.setNomineeAppointeeList(this.getNomineeAppointeeList(info.getAppId()));
			
		}
		
		}catch(Exception e){
			e.printStackTrace();
			
		}finally{
			DBUtils.closeConnection(rs, st, con);
		}
		
	return info;
		
	
	}
	public ArrayList getNomineeList(String appId) {
		String sqlQuery=" select appid, nomineename,address, to_char(nomineedob,'dd-Mon-yyyy') as nomineedob,relationship,percentage,gender from sbs_annuity_nominee n where n.appid="+appId;
		ArrayList list=new ArrayList();
		Connection con=null;
		Statement st=null;
		ResultSet rs=null;
		SBSNomineeBean info=null;
		try{
		con=DBUtils.getConnection();
		st=con.createStatement();
		rs=st.executeQuery(sqlQuery);
	
		while (rs.next()){
			info=new SBSNomineeBean();
			if(rs.getString("nomineename")!=null){
				info.setNomineename(rs.getString("nomineename"));
			}
			if(rs.getString("address")!=null){
				info.setNomineeAdd(rs.getString("address"));
			}
			if(rs.getString("nomineedob")!=null){
				info.setNomineeDOB(rs.getString("nomineedob"));
			}
			
			if(rs.getString("relationship")!=null){
				info.setNomineeRelation(rs.getString("relationship"));
				
			}
			
			if(rs.getString("percentage")!=null){
				info.setPercentage(rs.getString("percentage"));
			}
			if(rs.getString("gender")!=null){
				info.setGender(rs.getString("gender"));
			}
			list.add(info);
			
		}
		
		}catch(Exception e){
			e.printStackTrace();
			
		}finally{
			DBUtils.closeConnection(rs, st, con);
		}
		
		return list;
	}
	public ArrayList getDepList(String appId) {
		String sqlQuery=" select depid,pensionno,to_char(fromdate,'dd-Mon-yyyy') as fromdate,to_char(todate,'dd-Mon-yyyy') as todate,appid  from SBS_ANNUITY_DEPUTATION where appid="+appId;
		ArrayList list=new ArrayList();
		Connection con=null;
		Statement st=null;
		ResultSet rs=null;
		SBSDeputationBean info=null;
		try{
		con=DBUtils.getConnection();
		st=con.createStatement();
		rs=st.executeQuery(sqlQuery);
	
		while (rs.next()){
			info=new SBSDeputationBean();
			if(rs.getString("depid")!=null){
				info.setDepId(rs.getString("depid"));
			}
			if(rs.getString("pensionno")!=null){
				info.setPensionno(rs.getString("pensionno"));
			}
			if(rs.getString("fromdate")!=null){
				info.setFromDate(rs.getString("fromdate"));
			}
			
			if(rs.getString("todate")!=null){
				info.setToDate(rs.getString("todate"));
				
			}
			
			if(rs.getString("appid")!=null){
				info.setAppId(rs.getString("appid"));
			}
			
			list.add(info);
			
		}
		
		}catch(Exception e){
			e.printStackTrace();
			
		}finally{
			DBUtils.closeConnection(rs, st, con);
		}
		
		return list;
	}
	public ArrayList getNomineeAppointeeList(String appId) {
		String sqlQuery="select nameaddress,to_char(appointeedob,'dd-Mon-yyyy') as appointeedob,relationship,appointeeAdress,appointeemobileno,nomineename from SBS_Annuity_Nomineeappointee n where appid="+appId;
		ArrayList list=new ArrayList();
		Connection con=null;
		Statement st=null;
		ResultSet rs=null;
		SBSNomineeBean info=null;
		try{
		con=DBUtils.getConnection();
		st=con.createStatement();
		rs=st.executeQuery(sqlQuery);
	
		while (rs.next()){
			info=new SBSNomineeBean();
			if(rs.getString("nameaddress")!=null){
				info.setAppointeeName(rs.getString("nameaddress"));
			}
			
			if(rs.getString("appointeedob")!=null){
				info.setNomineeDOB(rs.getString("appointeedob"));
			}
			
			if(rs.getString("relationship")!=null){
				info.setNomineeRelation(rs.getString("relationship"));
				
			}
			if(rs.getString("appointeeAdress")!=null){
				info.setAppointeeAddress(rs.getString("appointeeAdress"));
				
			}
			if(rs.getString("appointeemobileno")!=null){
				info.setAppointeeMobile(rs.getString("appointeemobileno"));
				
			}
			if(rs.getString("nomineename")!=null){
				info.setNomineename(rs.getString("nomineename"));
				
			}
			
			
			
			list.add(info);
			
		}
		
		}catch(Exception e){
			e.printStackTrace();
			
		}finally{
			DBUtils.closeConnection(rs, st, con);
		}
		
		return list;
	}

	public void updateFormReject(String appId, String rejectedRemarks,
			String approveStatus, String rejectedType, String approveLevel,String region) {
		Connection con=null;
		Statement st=null;
		String sqlquery="";
		String transno="";
		ResultSet rs=null;
		String rej_qry="";
		String trans_qry="";
		log.info("rejectedType::"+rejectedType);
		log.info("rejectedType::1111111"+approveStatus);
		try{
			con=DBUtils.getConnection();
			
			st=con.createStatement();
			log.info("rejectedType::1111111"+rejectedType);
			log.info("region::"+region+"approveLevel:"+approveLevel);
			rs=st.executeQuery("select region from SBS_Annuity_Forms where appid="+appId);
			if(rs.next()){
				region=rs.getString("region");
			}
			log.info("rejectedType::1111111"+rejectedType);
			log.info("region::"+region+"approveLevel:"+approveLevel);
			if(approveLevel.equals("Finance")){
				if(region.equals("CHQNAD")){
					st.executeUpdate("update SBS_Annuity_Forms f set verfiedby='HR1/Hr2/CHQHR',chqhrapprove='R',approve3='' where f.appid='"+appId+"'");
					 rej_qry="insert into sbs_rejected_log(slno,appid,rejected_remarks,rejectedby) values((select nvl(max(slno),0)+1 from sbs_rejected_log where appid='"+appId+"'),'"+appId+"','"+rejectedRemarks+"','Finance Nodal Officer') ";
					 trans_qry="delete from sbs_annuity_transations s where appid='"+appId+"' and transcd='16'" ;	
				}else{
			st.executeUpdate("update SBS_Annuity_Forms f set verfiedby='HR1/Hr2',approve2='R',approve3='' where f.appid='"+appId+"'");
			 rej_qry="insert into sbs_rejected_log(slno,appid,rejected_remarks,rejectedby) values((select nvl(max(slno),0)+1 from sbs_rejected_log where appid='"+appId+"'),'"+appId+"','"+rejectedRemarks+"','Finance Nodal Officer') ";
			 trans_qry="delete from sbs_annuity_transations s where appid='"+appId+"' and transcd='12'" ;
				}
				}else if(approveLevel.equals("RHQHR")){
				st.executeUpdate("update SBS_Annuity_Forms f set verfiedby='HR1/HR2/Finance',approve3='R',RHQHRAPPROVE='' where f.appid='"+appId+"'");
				 rej_qry="insert into sbs_rejected_log(slno,appid,rejected_remarks,rejectedby) values((select nvl(max(slno),0)+1 from sbs_rejected_log where appid='"+appId+"'),'"+appId+"','"+rejectedRemarks+"','GM(HR)') ";
				 trans_qry="delete from sbs_annuity_transations s where appid='"+appId+"' and transcd='13'" ;
					
			}if(approveLevel.equals("RHQFIN")){
				st.executeUpdate("update SBS_Annuity_Forms f set verfiedby='HR1/HR2/Finance/RHQHR',RHQHRAPPROVE='R',RHQFINAPPROVE='' where f.appid='"+appId+"'");
				 rej_qry="insert into sbs_rejected_log(slno,appid,rejected_remarks,rejectedby) values((select nvl(max(slno),0)+1 from sbs_rejected_log where appid='"+appId+"'),'"+appId+"','"+rejectedRemarks+"','GM(FIN)') ";
				 trans_qry="delete from sbs_annuity_transations s where appid='"+appId+"' and transcd='14'" ;
					
			}if(approveLevel.equals("CHQHR")){
				if(region.equals("CHQNAD")){
				st.executeUpdate("update SBS_Annuity_Forms f set verfiedby='HR1/HR2',approve2='R',chqhrapprove='' where f.appid='"+appId+"'");
				 rej_qry="insert into sbs_rejected_log(slno,appid,rejected_remarks,rejectedby) values((select nvl(max(slno),0)+1 from sbs_rejected_log where appid='"+appId+"'),'"+appId+"','"+rejectedRemarks+"','SOCIAL SECURITY') ";
				 trans_qry="delete from sbs_annuity_transations s where appid='"+appId+"' and transcd='12'" ;
				}else{
					st.executeUpdate("update SBS_Annuity_Forms f set verfiedby='HR1/HR2/Finance/RHQHR/RHQFIN',RHQFINAPPROVE='R',chqhrapprove='' where f.appid='"+appId+"'");
					 rej_qry="insert into sbs_rejected_log(slno,appid,rejected_remarks,rejectedby) values((select nvl(max(slno),0)+1 from sbs_rejected_log where appid='"+appId+"'),'"+appId+"','"+rejectedRemarks+"','SOCIAL SECURITY') ";
					 trans_qry="delete from sbs_annuity_transations s where appid='"+appId+"' and transcd='15'" ;
						
				}
			}if(approveLevel.equals("EDCP1")){
				if(region.equals("CHQNAD")){
				st.executeUpdate("update SBS_Annuity_Forms f set verfiedby='HR1/HR2/CHQHR/Finance',approve3='R' where f.appid='"+appId+"'");
				 rej_qry="insert into sbs_rejected_log(slno,appid,rejected_remarks,rejectedby) values((select nvl(max(slno),0)+1 from sbs_rejected_log where appid='"+appId+"'),'"+appId+"','"+rejectedRemarks+"','EDCP1') ";
				 trans_qry="delete from sbs_annuity_transations s where appid='"+appId+"' and transcd='13'" ;
				}else{
					st.executeUpdate("update SBS_Annuity_Forms f set verfiedby='HR1/HR2/Finance/RHQHR/RHQFIN/CHQHR',chqhrapprove='R' where f.appid='"+appId+"'");
					 rej_qry="insert into sbs_rejected_log(slno,appid,rejected_remarks,rejectedby) values((select nvl(max(slno),0)+1 from sbs_rejected_log where appid='"+appId+"'),'"+appId+"','"+rejectedRemarks+"','EDCP1') ";
					 trans_qry="delete from sbs_annuity_transations s where appid='"+appId+"' and transcd='16'" ;
					
				}
			}
			
			
			
			
			st.executeUpdate(rej_qry);
			st.executeUpdate(trans_qry);
			
			
			
			
		
		
		}catch(Exception e){
			e.printStackTrace();
		
		}finally{
			try {
				con.rollback();
				st.close();
				con.close();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			
			
		}
	}

	public int getUpdate(String pensionno, String intcalcdate) {
		String sqlQuery="update sbs_annuity_forms s set s.intcalcdate='"+intcalcdate+"' where s.pensionno="+pensionno;
		int n=0;
		Connection con=null;
		Statement st=null;
		try{
			con=DBUtils.getConnection();
			
			st=con.createStatement();
			n=st.executeUpdate(sqlQuery);
		}catch(Exception e){
			e.printStackTrace();
		
		}finally{
			try {
			
				st.close();
				con.close();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			
			
		}
		return n;
	}

	public ArrayList getFinalsettlementData(String fromdate, String todate,
			String region, String airport,String month,String year,String finyear) {
		ArrayList finalsettlementList = new ArrayList();
		Connection con = null;
		Statement st = null;
		ResultSet rs = null;
		String query = this.buildSBSFSQry(region, airport, fromdate, todate,month,year,finyear);

		try {

			con=DBUtils.getConnection();
			st = con.createStatement();
			log.info("getSBSFSEmpList: " + query);
			rs = st.executeQuery(query);
			LicBean fsbean = null;
			while (rs.next()) {
				fsbean = new LicBean();
				if(rs.getString("policyno")!=null){
					fsbean.setPolicyNo(rs.getString("policyno"));	
				}
				if(rs.getString("policystartdate")!=null){
					fsbean.setPolicyStartDate(rs.getString("policystartdate"));	
				}
				if(rs.getString("pensionamt")!=null){
					fsbean.setPolicyPensionAmt(rs.getString("pensionamt"));
				}
				
				fsbean.setEmployeeNo(rs.getString("pensionno"));
				fsbean.setNewEmpCode(rs.getString("newempcode"));
				fsbean.setMemberName(rs.getString("membername"));
				fsbean.setFormType(rs.getString("form_type"));
				fsbean.setRegion(rs.getString("region"));
				fsbean.setAirport(rs.getString("airport"));
				fsbean.setMonth(rs.getString("settlementmonth"));
				fsbean.setYear(rs.getString("settlemenYear"));
				fsbean.setFinYear(rs.getString("finyear"));
				if(rs.getString("edcpcorpusamt")!=null){
				fsbean.setEdcpCorpusAmt(rs.getString("edcpcorpusamt"));
				}else{
					fsbean.setEdcpCorpusAmt("0"	);
				}
				fsbean.setEdcpApproveDate(rs.getString("settlementdate"));
				fsbean.setPaymentMode(rs.getString("modeofpayment"));
				fsbean.setAaiEDCPSoptionDesc(rs.getString("aaiedcpsoptiondesc"));
				if(rs.getString("gst")!=null){
				fsbean.setEdcpCorpusint(rs.getString("gst"));
				}else{
					fsbean.setEdcpCorpusint("0");
				}
				finalsettlementList.add(fsbean);
			}

		} catch (SQLException e) {
			log.printStackTrace(e);
		} catch (Exception e) {
			log.printStackTrace(e);
		} finally {
			try {
				st.close();
				con.close();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			
		}

		return finalsettlementList;
	}

	private String buildSBSFSQry(String region, String airport,
			String fromdate, String todate,String month,String year,String finyear) {
		StringBuffer whereClause = new StringBuffer();
		StringBuffer query = new StringBuffer();
		String dynamicQuery = "", orderBy = "", sqlQuery = "";
		sqlQuery = "select s.pensionno,(select o.newempcode from employee_personal_info o where o.pensionno=s.pensionno) as newempcode,(select p.policyno from sbs_policydoc p where p.pensionno = s.pensionno) as policyno,(select to_char(p.policydate,'dd-Mon-yyyy') from sbs_policydoc p   where p.pensionno = s.pensionno) as policystartdate,(select p.policyamt from sbs_policydoc p where p.pensionno = s.pensionno) as pensionamt,s.membername,s.form_type,s.region,s.airport,s.edcpcorpusamt+s.edcpcorpusint as edcpcorpusamt,to_char(t.transdate,'dd-MM-yyyy')as settlementdate,to_char(t.transdate, 'Mon') as settlementmonth, to_char(t.transdate, 'YYYY') as settlemenYear,  (select distinct (case when ((transdate >= to_date('01/Apr/' || to_char(transdate, 'YYYY'),'dd/Mon/yyyy')) and (transdate <= to_date('31/Mar/' ||(to_number(to_char(transdate, 'YYYY')) + 1),'dd/Mon/yyyy'))) then (to_char(transdate, 'YYYY') || '-' ||(to_number(to_char(transdate, 'YYYY')) + 1)) when ((transdate >= to_date('01/Apr/' ||(to_number(to_char(transdate, 'YYYY')) - 1), 'dd/Mon/yyyy')) and (transdate <= to_date('31/Mar/' || to_char(transdate, 'YYYY'), 'dd/Mon/yyyy'))) then ((to_number(to_char(transdate, 'YYYY')) - 1) || '-' || to_char(transdate, 'YYYY')) end) from sbs_annuity_transations where  trim(transdate) = (select distinct trim(max(to_date(transdate, 'dd-Mon-yyyy HH:MI:SS'))) from sbs_annuity_transations where appid = t.appid)  and appid=t.appid )as finyear,s.modeofpayment,decode(s.aaiedcpsoption,'A','Life Annuity','B','Life Annuity With Return Of Purchase Price','C','Joint Life Annuity','D','Joint Life Annuity with Return of Purchase Price','E','Refund Application (fifth option)') as aaiedcpsoptiondesc,round(((s.edcpcorpusamt+s.edcpcorpusint)/1.018)*0.018,0) gst from sbs_annuity_forms s,sbs_annuity_transations t where s.appid=t.appid and t.approvedby='EDCPapprove3' ";

		if (!fromdate.equals("")) {
			
			whereClause.append(" to_date(to_char(t.transdate,'dd-Mon-yyyy'))>='" + fromdate + "'");
			whereClause.append(" AND ");
		}
		if (!todate.equals("")) {
			whereClause.append(" to_date(to_char(t.transdate,'dd-Mon-yyyy'))<='" + todate + "'");
			whereClause.append(" AND ");
		}
		if (!region.equals("")) {
			whereClause.append(" REGION ='" + region + "'");
			whereClause.append(" AND ");
		}
		System.out.println("month"+month);
		if (!month.equals("")) {
			whereClause.append(" to_char(t.transdate, 'Mon') ='" + month + "'");
			whereClause.append(" AND ");
		}
		System.out.println("year"+year);
		if (!year.equals("")) {
			whereClause.append(" to_char(t.transdate, 'yyyy')  ='" + year + "'");
			whereClause.append(" AND ");
		}
		System.out.println("finyear"+finyear);
		
		if (!finyear.equals("")) {
			String firstFourChars = finyear.substring(0, 4);
			String lastFourChars = finyear.substring(5, 9);
			String fromyear="01-Apr-"+firstFourChars;
			String toyear="31-Mar-"+lastFourChars;
			whereClause.append("t.transdate between '"+fromyear+"' and '"+toyear+"'");
			whereClause.append(" AND ");
		}


		if (!airport.equals("")) {
			whereClause.append(" AIRPORTCODE ='" + airport + "'");
			whereClause.append(" AND ");
		}

		query.append(sqlQuery);
		if ((region.equals("")) && (airport.equals(""))
				&& (fromdate.equals(""))&& (todate.equals(""))&& (month.equals(""))&& (year.equals(""))&& (finyear.equals(""))) {
log.info("if");
		} else {
			query.append(" and ");
			log.info("else");
				query.append(this.sTokenFormat(whereClause));
			
		}
		orderBy = " ORDER BY pensionno ASC";
		query.append(orderBy);
		dynamicQuery = query.toString();
		System.out.println("FinancialReportDAO::buildQueryPersonalFormPFID Leaving Method---"+dynamicQuery);
		return dynamicQuery;
	}
	private String sTokenFormat(StringBuffer stringBuffer) {

		StringBuffer whereStr = new StringBuffer();
		StringTokenizer st = new StringTokenizer(stringBuffer.toString());
		int count = 0;
		int stCount = st.countTokens();
		// && && count<=st.countTokens()-1st.countTokens()-1
		while (st.hasMoreElements()) {
			count++;
			if (count == stCount)
				break;
			whereStr.append(st.nextElement());
			whereStr.append(" ");
		}
		return whereStr.toString();
	}

	public ArrayList getAnnuityHelp(String empname, String pfId, String appid) {
		ArrayList finalsettlementList = new ArrayList();
		Connection con = null;
		Statement st = null;
		ResultSet rs = null;
		String query = this.buildSBSHelpQry(empname, pfId, appid);

		try {

			con=DBUtils.getConnection();
			st = con.createStatement();
			log.info("getSBSFSEmpList: " + query);
			rs = st.executeQuery(query);
			LicBean fsbean = null;
			while (rs.next()) {
				fsbean = new LicBean();
				fsbean.setAppId(rs.getString("appid"));
				fsbean.setEmployeeNo(rs.getString("pensionno"));
				fsbean.setNewEmpCode(rs.getString("newempcode"));
				fsbean.setMemberName(rs.getString("membername"));
				fsbean.setFormType(rs.getString("form_type"));
				fsbean.setRegion(rs.getString("region"));
				fsbean.setAirport(rs.getString("airport"));
				fsbean.setEdcpCorpusAmt(rs.getString("edcpcorpusamt"));
				fsbean.setEdcpApproveDate(rs.getString("settlementdate"));
				fsbean.setPaymentMode(rs.getString("modeofpayment"));
				fsbean.setAaiEDCPSoptionDesc(rs.getString("aaiedcpsoptiondesc"));
				fsbean.setEdcpCorpusint(rs.getString("gst"));
				finalsettlementList.add(fsbean);
			}
	} catch (SQLException e) {
		log.printStackTrace(e);
	} catch (Exception e) {
		log.printStackTrace(e);
	} finally {
		try {
			st.close();
			con.close();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	return finalsettlementList;
		
}
	

	private String buildSBSHelpQry(String empname, String pfId, String appid) {
		

		StringBuffer whereClause = new StringBuffer();
		StringBuffer query = new StringBuffer();
		String dynamicQuery = "", orderBy = "", sqlQuery = "";
		sqlQuery = "select s.pensionno,s.appid,(select o.newempcode from employee_personal_info o where o.pensionno=s.pensionno) as newempcode,s.membername,s.form_type,s.region,s.airport,s.edcpcorpusamt+s.edcpcorpusint as edcpcorpusamt,to_char(t.transdate,'dd-MM-yyyy')as settlementdate,s.modeofpayment,decode(s.aaiedcpsoption,'A','Life Annuity','B','Life Annuity With Return Of Purchase Price','C','Joint Life Annuity','D','Joint Life Annuity with Return of Purchase Price','E','Refund Application (fifth option)') as aaiedcpsoptiondesc,round(((s.edcpcorpusamt+s.edcpcorpusint)/1.018)*1.8/100,0) gst from sbs_annuity_forms s,sbs_annuity_transations t where s.appid=t.appid and t.approvedby='EDCPapprove3' ";

		if (!empname.equals("")) {
			
			whereClause.append(" s.membername like '%"+empname+"%'");
			whereClause.append(" AND ");
		}
	
		if (!pfId.equals("")) {
			whereClause.append(" s.pensionno='" + pfId + "'");
			whereClause.append(" AND ");
		}

		if (!appid.equals("")) {
			whereClause.append(" s.appid ='" + appid + "'");
			whereClause.append(" AND ");
		}

		query.append(sqlQuery);
		if ((empname.equals("")) && (pfId.equals(""))
				&& (appid.equals(""))) {
log.info("if");
		} else {
			query.append(" and ");
			log.info("else");
				query.append(this.sTokenFormat(whereClause));
			
		}
		orderBy = " ORDER BY pensionno ASC";
		query.append(orderBy);
		dynamicQuery = query.toString();
		log
				.info("FinancialReportDAO::buildQueryPersonalFormPFID Leaving Method");
		return dynamicQuery;
	
	}
	public ArrayList getJvHelp(String empname, String pfId, String appid) {
		ArrayList finalsettlementList = new ArrayList();
		Connection con = null;
		Statement st = null;
		ResultSet rs = null;
		String query = this.buildJvHelpQry(empname, pfId, appid);

		try {

			con=DBUtils.getConnection();
			st = con.createStatement();
			log.info("getSBSFSEmpList: " + query);
			rs = st.executeQuery(query);
			LicBean fsbean = null;
			while (rs.next()) {
				fsbean = new LicBean();
				fsbean.setAppId(rs.getString("appid"));
				fsbean.setEmployeeNo(rs.getString("pensionno"));
				fsbean.setNewEmpCode(rs.getString("newempcode"));
				fsbean.setMemberName(rs.getString("membername"));
				fsbean.setFormType(rs.getString("form_type"));
				fsbean.setRegion(rs.getString("region"));
				fsbean.setAirport(rs.getString("airport"));
				fsbean.setEdcpCorpusAmt(rs.getString("edcpcorpusamt"));
				fsbean.setEdcpApproveDate(rs.getString("settlementdate"));
				fsbean.setPaymentMode(rs.getString("modeofpayment"));
				fsbean.setAaiEDCPSoptionDesc(rs.getString("aaiedcpsoptiondesc"));
				fsbean.setEdcpCorpusint(rs.getString("gst"));
				finalsettlementList.add(fsbean);
			}
	} catch (SQLException e) {
		log.printStackTrace(e);
	} catch (Exception e) {
		log.printStackTrace(e);
	} finally {
		try {
			st.close();
			con.close();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	return finalsettlementList;
		
}
private String buildJvHelpQry(String empname, String pfId, String appid) {
		

		StringBuffer whereClause = new StringBuffer();
		StringBuffer query = new StringBuffer();
		String dynamicQuery = "", orderBy = "", sqlQuery = "";
		sqlQuery = "select s.pensionno,s.appid,(select o.newempcode from employee_personal_info o where o.pensionno=s.pensionno) as newempcode,s.membername,s.form_type,s.region,s.airport,s.edcpcorpusamt+s.edcpcorpusint as edcpcorpusamt,to_char(t.transdate,'dd-MM-yyyy')as settlementdate,s.modeofpayment,decode(s.aaiedcpsoption,'A','Life Annuity','B','Life Annuity With Return Of Purchase Price','C','Joint Life Annuity','D','Joint Life Annuity with Return of Purchase Price','E','Refund Application (fifth option)') as aaiedcpsoptiondesc,round(((s.edcpcorpusamt+s.edcpcorpusint)/1.018)*1.8/100,0) gst from sbs_annuity_forms s,sbs_annuity_transations t where s.appid=t.appid and s.formsubmit='Y' and s.edcpapproval3='A' and  t.approvedby='EDCPapprove3' and s.pensionno not in(select pensionno from sbs_journal_voucher) ";

		if (!empname.equals("")) {
			
			whereClause.append(" s.membername like '%"+empname+"%'");
			whereClause.append(" AND ");
		}
	
		if (!pfId.equals("")) {
			whereClause.append(" s.pensionno='" + pfId + "'");
			whereClause.append(" AND ");
		}

		if (!appid.equals("")) {
			whereClause.append(" s.appid ='" + appid + "'");
			whereClause.append(" AND ");
		}

		query.append(sqlQuery);
		if ((empname.equals("")) && (pfId.equals(""))
				&& (appid.equals(""))) {
log.info("if");
		} else {
			query.append(" and ");
			log.info("else");
				query.append(this.sTokenFormat(whereClause));
			
		}
		orderBy = " ORDER BY pensionno ASC";
		query.append(orderBy);
		dynamicQuery = query.toString();
		log
				.info("FinancialReportDAO::buildJvHelpQry Leaving Method");
		return dynamicQuery;
	
	}
	public int insertPolicydoc(String pfId, String appid,
			String annuityprovider, String purchaseamt, String gst,
			String policyno, String policydate, String policyamt, String debit,
			String credit) {
		Connection con = null;
		Statement st = null;
		ResultSet rs = null;
		int n=0;
		
		try {

			con=DBUtils.getConnection();
			st = con.createStatement();
			System.out.println("insert into sbs_policydoc(pensionno, appid,annuityprovider, annuitypuchaseamt, gst, policyno, policyamt, policydate,debit,credit) " +
					"values("+pfId+",'"+appid+"','"+annuityprovider+"','"+purchaseamt+"','"+gst+"','"+policyno+"','"+policyamt+"','"+policydate+"','"+debit+"','"+credit+"')");
			
			n=st.executeUpdate("insert into sbs_policydoc(pensionno, appid,annuityprovider, annuitypuchaseamt, gst, policyno, policyamt, policydate,debit,credit) " +
					"values("+pfId+",'"+appid+"','"+annuityprovider+"','"+purchaseamt+"','"+gst+"','"+policyno+"','"+policyamt+"','"+policydate+"','"+debit+"','"+credit+"')");
			
		} catch (SQLException e) {
			log.printStackTrace(e);
		} catch (Exception e) {
			log.printStackTrace(e);
		} finally {
			try {
				st.close();
				con.close();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		return n;
	}

	public ArrayList getPolicyDoc() {
		ArrayList list=new ArrayList();
	Connection con=null;
	Statement st=null;
	ResultSet rs=null;
	PolicyDocumentBean info=null;
	String sqlQuery="select d.pensionno,d.appid,d.annuityprovider,d.policyno from sbs_policydoc d";
	try{
	con=DBUtils.getConnection();
	st=con.createStatement();
	rs=st.executeQuery(sqlQuery);

	while (rs.next()){
		info=new PolicyDocumentBean();
		if(rs.getString("pensionno")!=null){
			info.setPensionno(rs.getString("pensionno"));
		}
		if(rs.getString("appid")!=null){
			info.setAppid(rs.getString("appid"));
		}
		if(rs.getString("annuityprovider")!=null){
			info.setAnnuityProvider(rs.getString("annuityprovider"));
		}
		
		
	
		list.add(info.toString());
		
	}
	
	}catch(Exception e){
		e.printStackTrace();
		
	}finally{
		DBUtils.closeConnection(rs, st, con);
	}
	
	return list;
}
	public ArrayList getPolicyDoc(String fromdate,String todate) {
		ArrayList list=new ArrayList();
	Connection con=null;
	Statement st=null;
	ResultSet rs=null;
	PolicyDocumentBean info=null;
	String sqlQuery="select d.pensionno,d.appid,d.annuityprovider,d.policyno,to_char(d.policydate,'dd-Mon-yyyy') as policydate,d.policyamt,d.gst,d.annuitypuchaseamt,d.debit,d.credit,o.region,o.airportcode,o.newempcode,o.employeename from sbs_policydoc d,employee_personal_info o where d.pensionno=o.pensionno";
	try{
	con=DBUtils.getConnection();
	st=con.createStatement();
	rs=st.executeQuery(sqlQuery);

	while (rs.next()){
		info=new PolicyDocumentBean();
		
		if(rs.getString("employeename")!=null){
			info.setEmployeeName(rs.getString("employeename"));
		}
		if(rs.getString("region")!=null){
			info.setRegion(rs.getString("region"));
		}
		if(rs.getString("airportcode")!=null){
			info.setAirport(rs.getString("airportcode"));
		}
		if(rs.getString("newempcode")!=null){
			info.setNewEmpCode(rs.getString("newempcode"));
		}
		if(rs.getString("pensionno")!=null){
			info.setPensionno(rs.getString("pensionno"));
		}
		if(rs.getString("appid")!=null){
			info.setAppid(rs.getString("appid"));
		}
		if(rs.getString("policyno")!=null){
			info.setPolicynumber(rs.getString("policyno"));
		}
		if(rs.getString("policydate")!=null){
			info.setPolicydate(rs.getString("policydate"));
		}
		if(rs.getString("policyamt")!=null){
			info.setPolicyAmount(rs.getString("policyamt"));
		}
		if(rs.getString("gst")!=null){
			info.setGst(rs.getString("gst"));
		}
		if(rs.getString("annuitypuchaseamt")!=null){
			info.setPurchaseamt(rs.getString("annuitypuchaseamt"));
		}
		if(rs.getString("annuityprovider")!=null){
			info.setAnnuityProvider(rs.getString("annuityprovider"));
		}
		if(rs.getString("debit")!=null){
			info.setDebit(rs.getString("debit"));
		}
		
		if(rs.getString("credit")!=null){
			info.setCredit(rs.getString("credit"));
		}
		
	
		list.add(info);
		
	}
	
	}catch(Exception e){
		e.printStackTrace();
		
	}finally{
		DBUtils.closeConnection(rs, st, con);
	}
	
	return list;
}

	public ArrayList getMisData(String region, String airport) {
		ArrayList list=new ArrayList();
		Connection con=null;
		Statement st=null;
		ResultSet rs=null;
		MisdataBean info=null;
		String condition="";
		if(!region.equals("")){
			condition=" and region='"+region+"'";
		}
		/*String sqlQuery="select count(pensionno) as totemp,(case when o.region='CHQNAD'then 'CHQ' else o.region end)as region,(select count(pensionno) from sbs_annuity_forms s  where s.edcpapproval3='A' and s.region=o.region) as lessfsdone,(select count(pensionno) from sbs_annuity_forms s  where s.approve1='A' and s.region=o.region) as hrassistant,(select count(pensionno) from sbs_annuity_forms s  where s.approve2='A' and s.region=o.region) as hrnodal," +
				"(select count(pensionno) from sbs_annuity_forms s  where s.approve3='A' and s.region=o.region) as fsofficer,(select count(pensionno) from sbs_annuity_forms s  where s.rhqhrapprove='A' and s.region=o.region) as rhqhr,(select count(pensionno) from sbs_annuity_forms s  where s.rhqfinapprove='A' and s.region=o.region) as rhqfin,(select count(pensionno) from sbs_annuity_forms s  where s.chqhrapprove='A' and s.region=o.region) as chqhr," +
				"(select count(pensionno) from sbs_annuity_forms s  where s.edcpapproval1='A' and s.region=o.region) as edcp1,(select count(pensionno) from sbs_annuity_forms s  where s.edcpapproval2='A' and s.region=o.region) as edcp2,(select count(pensionno) from sbs_annuity_forms s  where s.edcpapproval3='A' and s.region=o.region) as edcp3 from employee_personal_info o where o.sbsflag='Y' and  o.region !='CHQIAD' and o.dateofseperation_date is not null "+condition+" group by o.region "+
				" union  select count(pensionno) as totemp,decode(o.airportcode,'KOLKATA','Kolkata Airport','CHENNAI IAD','Chennai Airport') as airportcode,(select count(pensionno) from sbs_annuity_forms s  where s.edcpapproval3='A' and s.airport=o.airportcode) as lessfsdone,(select count(pensionno) from sbs_annuity_forms s  where s.approve1='A' and s.airport=o.airportcode) as hrassistant,(select count(pensionno) from sbs_annuity_forms s  where s.approve2='A' and s.airport=o.airportcode) as hrnodal,"+
        "(select count(pensionno) from sbs_annuity_forms s  where s.approve3='A' and s.airport=o.airportcode) as fsofficer,(select count(pensionno) from sbs_annuity_forms s  where s.rhqhrapprove='A' and s.airport=o.airportcode) as rhqhr,(select count(pensionno) from sbs_annuity_forms s  where s.rhqfinapprove='A' and s.airport=o.airportcode) as rhqfin,(select count(pensionno) from sbs_annuity_forms s  where s.chqhrapprove='A' and s.airport=o.airportcode) as chqhr,"+
        "(select count(pensionno) from sbs_annuity_forms s  where s.edcpapproval1='A' and s.airport=o.airportcode) as edcp1,(select count(pensionno) from sbs_annuity_forms s  where s.edcpapproval2='A' and s.airport=o.airportcode) as edcp2,(select count(pensionno) from sbs_annuity_forms s  where s.edcpapproval3='A' and s.airport=o.airportcode) as edcp3 from employee_personal_info o where o.sbsflag='Y' and o.dateofseperation_date is not null and o.region='CHQIAD' group by o.airportcode";
    */
		
		String sqlQuery="select count(pensionno) as totemp,       (case         when o.region = 'CHQNAD' then          'CHQ'         else          o.region       end) as region,       (select count(pensionno)          from sbs_annuity_forms s         where s.edcpapproval3 = 'A'           and s.region = o.region) as lessfsdone,       (select count(pensionno)          from sbs_annuity_forms s         where s.formsubmit='Y' and (s.approve1 is null  or s.approve1='R')         and s.region = o.region) as hrassistant,       (select count(pensionno)          from sbs_annuity_forms s         where s.approve1 = 'A' and (s.approve2 is null or s.approve2='R')          and s.region = o.region) as hrnodal,       (select count(pensionno)          from sbs_annuity_forms s         where s.approve2 = 'A' and (s.approve3 is null or s.approve3='R')          and s.region = o.region) as fsofficer,       (select count(pensionno)          from sbs_annuity_forms s         where s.approve3 = 'A'  and (s.rhqhrapprove is null  or s.rhqhrapprove='R')         and s.region = o.region and s.airport!='CHQNAD') as rhqhr,       (select count(pensionno)          from sbs_annuity_forms s         where s.rhqhrapprove = 'A' and (s.rhqfinapprove is null  or s.rhqfinapprove='R')         and s.region = o.region) as rhqfin,       (select count(pensionno)          from sbs_annuity_forms s         where rhqfinapprove='A' and (s.chqhrapprove is null or s.chqhrapprove='R')          and s.region = o.region) as chqhr,       ((select count(pensionno) from sbs_annuity_forms s where s.chqhrapprove = 'A' and (s.edcpapproval1 is null or s.edcpapproval1='R') and s.region = o.region) +(select count(pensionno)  from sbs_annuity_forms s where s.approve3 = 'A' and (s.edcpapproval1 is null or s.edcpapproval1='R') and s.region = o.region and o.Region='CHQNAD')) as edcp1,       (select count(pensionno)          from sbs_annuity_forms s         where s.edcpapproval1 = 'A' and (s.edcpapproval2 is null or  s.edcpapproval2='R' )         and s.region = o.region) as edcp2,       (select count(pensionno)          from sbs_annuity_forms s         where s.edcpapproval2 = 'R' and (s.edcpapproval3 is null or  s.edcpapproval3='R')          and s.region = o.region) as edcp3  from employee_personal_info o where o.sbsflag = 'Y'   and o.region != 'CHQIAD' "+condition+"  and o.dateofseperation_date is not null group by o.region union " +
				" select count(pensionno) as totemp,       decode(o.airportcode,              'KOLKATA',              'Kolkata Airport',              'CHENNAI IAD',              'Chennai Airport') as airportcode,       (select count(pensionno)          from sbs_annuity_forms s         where s.edcpapproval3 = 'A'           and s.airport = o.airportcode and s.region='CHQIAD') as lessfsdone,       (select count(pensionno)          from sbs_annuity_forms s         where  s.formsubmit='Y' and (s.approve1 is null  or s.approve1='R')         and s.airport = o.airportcode and s.region='CHQIAD') as hrassistant,       (select count(pensionno)          from sbs_annuity_forms s         where s.approve1 = 'A' and s.approve2 is null           and s.airport = o.airportcode and s.region='CHQIAD') as hrnodal,       (select count(pensionno)          from sbs_annuity_forms s         where s.approve2 = 'A' and s.approve3 is null           and s.airport = o.airportcode and s.region='CHQIAD') as fsofficer,       (select count(pensionno)          from sbs_annuity_forms s         where s.approve3 = 'A'  and s.rhqhrapprove is null           and s.airport = o.airportcode and s.region='CHQIAD') as rhqhr,       (select count(pensionno)          from sbs_annuity_forms s         where rhqhrapprove='A' and s.rhqfinapprove is null           and s.airport = o.airportcode and s.region='CHQIAD') as rhqfin,       (select count(pensionno)          from sbs_annuity_forms s         where s.rhqfinapprove = 'A' and s.chqhrapprove is null           and s.airport = o.airportcode and s.region='CHQIAD') as chqhr,       (select count(pensionno)          from sbs_annuity_forms s         where s.chqhrapprove = 'A' and s.edcpapproval1 is null           and s.airport = o.airportcode and s.region='CHQIAD') as edcp1,       (select count(pensionno)          from sbs_annuity_forms s         where s.edcpapproval1 = 'A' and s.edcpapproval2 is null           and s.airport = o.airportcode and s.region='CHQIAD') as edcp2,       (select count(pensionno)          from sbs_annuity_forms s         where s.edcpapproval2 = 'A' and s.edcpapproval3 is null           and s.airport = o.airportcode and s.region='CHQIAD') as edcp3  from employee_personal_info o where o.sbsflag = 'Y'   and o.dateofseperation_date is not null "+condition+"  and o.region = 'CHQIAD' group by o.airportcode ";
		
		
		
		log.info(sqlQuery);
		try{
		con=DBUtils.getConnection();
		st=con.createStatement();
		rs=st.executeQuery(sqlQuery);

		while (rs.next()){
			info=new MisdataBean();
			if(rs.getString("totemp")!=null){
				info.setEmpCount(rs.getString("totemp"));
			}
			if(rs.getString("region")!=null){
				info.setRegion(rs.getString("region"));
			}
			if(rs.getString("lessfsdone")!=null){
				info.setLessfsdone(rs.getString("lessfsdone"));
			}
			if(rs.getString("hrassistant")!=null){
				info.setHrasscount(rs.getString("hrassistant"));
			}
			if(rs.getString("hrnodal")!=null){
				info.setHrcount(rs.getString("hrnodal"));
			}
			if(rs.getString("fsofficer")!=null){
				info.setFincount(rs.getString("fsofficer"));
			}
			if(rs.getString("rhqhr")!=null){
				info.setRhqhrcnt(rs.getString("rhqhr"));
			}
			if(rs.getString("rhqfin")!=null){
				info.setRhqfincnt(rs.getString("rhqfin"));
			}
			if(rs.getString("chqhr")!=null){
				info.setChqhrcnt(rs.getString("chqhr"));
			}
			
			if(rs.getString("edcp1")!=null){
				info.setEdcp1count(rs.getString("edcp1"));
			}
			if(rs.getString("edcp2")!=null){
				info.setEdcp2cnt(rs.getString("edcp2"));
			}
			if(rs.getString("edcp3")!=null){
				info.setEdcp3cnt(rs.getString("edcp3"));
			}
			
		
			list.add(info);
			
		}
		
		}catch(Exception e){
			e.printStackTrace();
			
		}finally{
			DBUtils.closeConnection(rs, st, con);
		}
		
		return list;
	}
	public ArrayList getMISEmployee(String region, String airport) {
		ArrayList list=new ArrayList();
		Connection con=null;
		Statement st=null;
		ResultSet rs=null;
		MisdataBean info=null;
		String condition="";
		if(!region.equals("")){
			condition=" and s.region='"+region+"'";
		}
		if(!airport.equals("")){
			condition=condition+" and s.airport='"+airport+"'";
		}
		/*String sqlQuery="select count(pensionno) as totemp,(case when o.region='CHQNAD'then 'CHQ' else o.region end)as region,(select count(pensionno) from sbs_annuity_forms s  where s.edcpapproval3='A' and s.region=o.region) as lessfsdone,(select count(pensionno) from sbs_annuity_forms s  where s.approve1='A' and s.region=o.region) as hrassistant,(select count(pensionno) from sbs_annuity_forms s  where s.approve2='A' and s.region=o.region) as hrnodal," +
				"(select count(pensionno) from sbs_annuity_forms s  where s.approve3='A' and s.region=o.region) as fsofficer,(select count(pensionno) from sbs_annuity_forms s  where s.rhqhrapprove='A' and s.region=o.region) as rhqhr,(select count(pensionno) from sbs_annuity_forms s  where s.rhqfinapprove='A' and s.region=o.region) as rhqfin,(select count(pensionno) from sbs_annuity_forms s  where s.chqhrapprove='A' and s.region=o.region) as chqhr," +
				"(select count(pensionno) from sbs_annuity_forms s  where s.edcpapproval1='A' and s.region=o.region) as edcp1,(select count(pensionno) from sbs_annuity_forms s  where s.edcpapproval2='A' and s.region=o.region) as edcp2,(select count(pensionno) from sbs_annuity_forms s  where s.edcpapproval3='A' and s.region=o.region) as edcp3 from employee_personal_info o where o.sbsflag='Y' and  o.region !='CHQIAD' and o.dateofseperation_date is not null "+condition+" group by o.region "+
				" union  select count(pensionno) as totemp,decode(o.airportcode,'KOLKATA','Kolkata Airport','CHENNAI IAD','Chennai Airport') as airportcode,(select count(pensionno) from sbs_annuity_forms s  where s.edcpapproval3='A' and s.airport=o.airportcode) as lessfsdone,(select count(pensionno) from sbs_annuity_forms s  where s.approve1='A' and s.airport=o.airportcode) as hrassistant,(select count(pensionno) from sbs_annuity_forms s  where s.approve2='A' and s.airport=o.airportcode) as hrnodal,"+
        "(select count(pensionno) from sbs_annuity_forms s  where s.approve3='A' and s.airport=o.airportcode) as fsofficer,(select count(pensionno) from sbs_annuity_forms s  where s.rhqhrapprove='A' and s.airport=o.airportcode) as rhqhr,(select count(pensionno) from sbs_annuity_forms s  where s.rhqfinapprove='A' and s.airport=o.airportcode) as rhqfin,(select count(pensionno) from sbs_annuity_forms s  where s.chqhrapprove='A' and s.airport=o.airportcode) as chqhr,"+
        "(select count(pensionno) from sbs_annuity_forms s  where s.edcpapproval1='A' and s.airport=o.airportcode) as edcp1,(select count(pensionno) from sbs_annuity_forms s  where s.edcpapproval2='A' and s.airport=o.airportcode) as edcp2,(select count(pensionno) from sbs_annuity_forms s  where s.edcpapproval3='A' and s.airport=o.airportcode) as edcp3 from employee_personal_info o where o.sbsflag='Y' and o.dateofseperation_date is not null and o.region='CHQIAD' group by o.airportcode";
    */
		
		String sqlQuery="select s.appid, (case when s.edcpapproval3='A' then 'Approved' else'Pending Approval' end) as status,      o.pensionno,       o.employeename,       to_char(s.appdate,'dd-Mon-yyyy') as appdate,       s.region,       s.airport,       s.verfiedby,       (case         when (s.formsubmit = 'Y' and (s.approve1 is null or s.approve1='R') ) then          'HR Assisting Officer'         when (s.approve1 = 'A' and (s.approve2 is null or s.approve2='R') ) then          'HR Verification Officer'         when (s.approve2 = 'A' and (s.approve3 is null or s.approve3='R')) then          'Finance Nodal Officer'         when (s.approve3 = 'A' and (s.rhqhrapprove is null or s.rhqhrapprove='R') and s.region != 'CHQNAD') then 'Regional Sub-Committee-HR' when (s.rhqhrapprove = 'A' and (s.rhqfinapprove is null or s.rhqfinapprove='R') and s.region != 'CHQNAD') then 'Regional Sub-Committee-Finance' when ((s.rhqfinapprove = 'A' and (s.chqhrapprove is null or s.chqhrapprove='R')  and s.region != 'CHQNAD') or (s.approve2 = 'A' and (s.chqhrapprove is null or s.chqhrapprove='R')  and s.region = 'CHQNAD')) then 'CHQ SS Section' when ((s.chqhrapprove = 'A' and s.edcpapproval1 is null and s.region != 'CHQNAD') or (s.approve3='A' and s.edcpapproval1 is null and s.region = 'CHQNAD') ) then 'EDCP Trust'          when (s.edcpapproval1 = 'A' and s.edcpapproval2 is null) then          'CHQ Sub-Committee- Finance'          when (s.edcpapproval2 = 'A' and s.edcpapproval3 is null) then          'CHQ Sub-Committee- HR' when (s.edcpapproval3 = 'A' ) then          'All Levels Completed '        else          'Rejected cases'       end) as presentlevel  from sbs_annuity_forms s, employee_personal_info o where o.pensionno = s.pensionno and s.edcpapproval3 is null "+condition;
		
		
		log.info(sqlQuery);
		try{
		con=DBUtils.getConnection();
		st=con.createStatement();
		rs=st.executeQuery(sqlQuery);

		while (rs.next()){
			info=new MisdataBean();
			if(rs.getString("appid")!=null){
				info.setAppId(rs.getString("appid"));
			}
			if(rs.getString("status")!=null){
				info.setStatus(rs.getString("status"));
			}
			if(rs.getString("pensionno")!=null){
				info.setPensionno(rs.getString("pensionno"));
			}
			if(rs.getString("employeename")!=null){
				info.setEmployeeName(rs.getString("employeename"));
			}
			if(rs.getString("appdate")!=null){
				info.setAppdate(rs.getString("appdate"));
			}
			if(rs.getString("region")!=null){
				info.setRegion(rs.getString("region"));
			}
			if(rs.getString("airport")!=null){
				info.setAirport(rs.getString("airport"));
			}
			if(rs.getString("presentlevel")!=null){
				info.setPresentLevel(rs.getString("presentlevel"));
			}
			
			
		
			list.add(info);
			
		}
		
		}catch(Exception e){
			e.printStackTrace();
			
		}finally{
			DBUtils.closeConnection(rs, st, con);
		}
		
		return list;
	}
	public ArrayList getAnnuityApprovedReport(String fromdate,String todate,String airport,String region,String formType) {
		System.out.println("=== inside getSBIdata== dao==");
		ArrayList list=new ArrayList();
		Connection con=null;
		Statement st=null;
		ResultSet rs=null;
		LicBean info=null;
		
		String condition="";
		if(!fromdate.equals("")){
			condition=condition+" and to_char(t.TRANSDATE,'dd-Mon-yyyy') >='" +fromdate+"'";
		}
		
		if(!todate.equals("")){
			condition=condition+" and to_char(t.TRANSDATE,'dd-Mon-yyyy') <='"+todate+"'";
		}
		if(!region.equals("")){
			
			condition=condition+" and upper(s.region)=upper('"+region+"')";
			
		}
		if(!airport.equals("")){
			if(!airport.equals("Select One")){
			condition=condition+" and upper(s.airport)=upper('"+airport+"')";
			}
		}
		String sqlQuery="select s.appid appid,s.membername,o.desegnation,o.pensionno,o.newempcode,p.EMPSAPCODE,s.eligiblestatus ,to_char(s.intcalcdate,'dd-Mon-yyyy') as intcalcdate,to_char(o.dateofseperation_date,'dd-Mon-yyyy') as dateofseperation_date,to_char(s.RCFORMDATED, 'dd-Mon-yyyy') as RCFORMDATED, s.edcpcorpusamt,s.edcpcorpusint,s.edcptdsver, s.appid as applicationId,to_char(o.dateofseperation_date,'dd-Mon-yyyy') as dateofexit,to_char(o.dateofbirth,'dd-Mon-yyyy') as member_dob,to_char(o.dateofjoining,'dd-Mon-yyyy') as member_doj,s.causeofexit,s.form_type as formtype,s.pensionno,o.employeename,o.desegnation,s.approve1 as status,s.appdate,s.corpusobadjustment,s.obremarks,s.dep_aai_otherorg," +
				"to_char(s.rhqhrintdate,'dd-Mon-yyyy') as rhqhrintdate,s.rhqhr_purchaseamt,to_char(s.rhqfinintdate,'dd-Mon-yyyy') as rhqfinintdate,s.rhqfin_purchseamt,s.spousename,s.spouseaddress,to_char(s.spousedob,'dd-Mon-yyyy') as spousedob,s.spouserelation ,decode(s.aaiedcpsoption,'A','Life Annuity','B','Life Annuity With Return Of Purchase Price','C','Joint Life Annuity','D','Joint Life Annuity with Return of Purchase Price','E','Refund Application (fifth option)') as aaiedcpsoptiondesc,s.aaiedcpsoption,s.modeofpayment, s.servicebook,s.cpse,s.cad,s.crs,s.resign,s.vrs,s.deputation,s.arrear,s.totcorpus2lakhs,s.deathcertficate,s.notionalincrement,s.notionaldisplay,s.obadjustment," +
				"  p.address,p.permentaddress, p.nomineename,p.nominee2name,p.nominee3name,p.relation,p.PANNO,to_char(p.nomineedob,'dd-Mon-yyyy') as nomineedob,p.adharno,p.phoneno,p.email,p.alternatemobile, b.bankname,b.branch, b.ifsc,b.account_type,b.account_no,b.micrcode," + 
				"b.customername,b.customername2,b.accountno2,b.bankname2,b.micrcode2,b.branchaddr2,b.ifsccode2,s.claimform,s.identitycard,s.payslip,s.pancard,s.adharcard,s.cancelcheque,s.photograph,s.deceasedemployee,s.nominationdoc,s.nomineeproof,s.totcorpus2lakhs,s.deathcertficate,finNoIncrement,finArrear,finPreOBadj,obOtherReason,finOBadjCorpusCard,finCorpusVerified,town,state,pincode,p.nationality,fathersname,p.gender,s.region,s.airport,s.secannuitantgender,s.secannuitantpan," +
				"(select to_char(transdate,'dd-Mon-yyyy') from sbs_annuity_transations  where appid= s.appid and transdescription='HR Level1 Approval')as ackaprovedate,(select to_char(transdate,'dd-Mon-yyyy') from sbs_annuity_transations  where appid= s.appid and transdescription='HR Level2 Approval')as hraprovedate,(select to_char(transdate,'dd-Mon-yyyy') from sbs_annuity_transations  where appid= s.appid and transdescription='Finance Approval')as finaprovedate,(select to_char(transdate,'dd-Mon-yyyy') from sbs_annuity_transations  where appid= s.appid " +
				"and approvedby='EDCPapprove3')as edcpaprovedate,(select to_char(transdate,'dd-Mon-yyyy') from sbs_annuity_transations  where appid= s.appid " +
				"and approvedby='EDCPapprove2')as edcpaprovedate2,(select to_char(transdate,'dd-Mon-yyyy') from sbs_annuity_transations  where appid= s.appid and approvedby='EDCPapprove1')as edcpaprovedate1,(select to_char(transdate,'dd-Mon-yyyy') from sbs_annuity_transations  where appid= s.appid and approvedby='CHQHR')as chqhraprovedate,(select to_char(transdate,'dd-Mon-yyyy') from sbs_annuity_transations  where appid= s.appid and approvedby='RHQHR')as rhqhraprovedate,(select to_char(transdate,'dd-Mon-yyyy') from sbs_annuity_transations  where appid= s.appid and approvedby='RHQFIN')as rhqfinaprovedate, (select u.displayname from epis_user u where u.userid=(select approvedbyid  from sbs_annuity_transations  where appid = s.appid   and transcd = '18')) as edcpdisplayname1,(select u.displayname from epis_user u where u.userid=(select approvedbyid  from sbs_annuity_transations  where appid = s.appid   and transcd = '16')) as chqhrdisplayname,  (select u.designation from epis_user u where u.userid=(select approvedbyid   from sbs_annuity_transations  where appid = s.appid  and transcd = '18')) as edcpdesignation1,(select u.designation from epis_user u where u.userid=(select approvedbyid   from sbs_annuity_transations  where appid = s.appid  and transcd = '16')) as chqhrdesignation, (select u.designation from epis_user u where u.userid=(select approvedbyid   from sbs_annuity_transations  where appid = s.appid  and transcd = '14')) as rhqhrdesignation, (select u.designation from epis_user u where u.userid=(select approvedbyid   from sbs_annuity_transations  where appid = s.appid  and transcd = '15')) as rhqfindesignation, (select u.displayname from epis_user u where u.userid=(select approvedbyid from sbs_annuity_transations where appid = s.appid and transcd = '12')) as hr2displayname,(select u.displayname from epis_user u where u.userid=(select approvedbyid from sbs_annuity_transations  where appid = s.appid and transcd = '11')) as hr1displayname,  (select u.displayname from epis_user u where u.userid=(select approvedbyid  from sbs_annuity_transations  where appid = s.appid   and transcd = '13')) as findisplayname,  (select u.displayname from epis_user u where u.userid=(select approvedbyid  from sbs_annuity_transations  where appid = s.appid   and transcd = '14')) as rhqhrdisplayname,  (select u.displayname from epis_user u where u.userid=(select approvedbyid  from sbs_annuity_transations  where appid = s.appid   and transcd = '15')) as rhqfindisplayname,  (select u.designation from epis_user u where u.userid=(select approvedbyid   from sbs_annuity_transations  where appid = s.appid  and transcd = '11')) as hr1designation,  (select u.designation from epis_user u where u.userid=(select approvedbyid  from sbs_annuity_transations   where appid = s.appid  and transcd = '12')) as hr2designation,   (select u.designation from epis_user u where u.userid=(select approvedbyid  from sbs_annuity_transations  where appid = s.appid and transcd = '13')) as findesignation, (select u.designation from epis_user u where u.userid=(select approvedbyid  from sbs_annuity_transations  where appid = s.appid and transcd = '14')) as rhqhrdesignation, (select u.designation from epis_user u where u.userid=(select approvedbyid  from sbs_annuity_transations  where appid = s.appid and transcd = '15')) as rhqfindesignation from SBS_Annuity_Forms s,employee_personal_info o,sbs_annuity_personal p,sbs_annuity_bank b,sbs_annuity_transations t " +
				"where s.pensionno=o.pensionno  and s.appid=p.appid and s.appid=b.appid  and t.appid = s.appid  and t.APPROVEDBY='EDCPapprove3' and t.TRANSCD='20' and s.formsubmit='Y' and form_type='"+formType+"'   "+condition+" and  s.edcpapproval3='A'   order by s.pensionno ";
		
		
		try{
		con=DBUtils.getConnection();
		st=con.createStatement();
		System.out.println("sqlQuery===="+sqlQuery);
		rs=st.executeQuery(sqlQuery);
	
		while (rs.next()){
			info=new LicBean();
			//System.out.println("appid====="+rs.getString("appid"));
			
			if(rs.getString("appid")!=null){
				info.setAppId(rs.getString("appid"));
			}else {
				info.setAppId("");
			}
			
			if(rs.getString("edcpaprovedate2")!=null){
				info.setEdcpApproveDate2(rs.getString("edcpaprovedate2"));
			}else {
				info.setEdcpApproveDate2("");
			}
			
			if(rs.getString("chqhraprovedate")!=null){
				info.setChqHrApprovedate(rs.getString("chqhraprovedate"));
			}else {
				info.setChqHrApprovedate("");
			}
			if(rs.getString("chqhrdisplayname")!=null){
				info.setChqHrDisp(rs.getString("chqhrdisplayname"));
			}else {
				info.setChqHrDisp("");
			}
			if(rs.getString("chqhrdesignation")!=null){
				info.setChqhrDesig(rs.getString("chqhrdesignation"));
			}else {
				info.setChqhrDesig("");
			}
			if(rs.getString("newempcode")!=null){
				info.setNewEmpCode(rs.getString("newempcode"));
			}else {
				info.setNewEmpCode("");
			}
			if(rs.getString("RCFORMDATED")!=null){
				info.setPolicyStartDate(rs.getString("RCFORMDATED"));
			}else {
				info.setPolicyStartDate("");
			}
			
			
			
			if(rs.getString("rhqhrintdate")!=null){
				info.setRhqHrIntDate(rs.getString("rhqhrintdate"));
			}else {
				info.setRhqHrIntDate("");
			}
			if(rs.getString("rhqhr_purchaseamt")!=null){
				info.setRhqHrPurchaseAmt(rs.getString("rhqhr_purchaseamt"));
			}else {
				info.setRhqHrPurchaseAmt("");
			}
			if(rs.getString("rhqfinintdate")!=null){
				info.setRhqFinIntDate(rs.getString("rhqfinintdate"));
			}else {
				info.setRhqFinIntDate("");
			}
			if(rs.getString("rhqfin_purchseamt")!=null){
				info.setRhqFinPurchaseAmt(rs.getString("rhqfin_purchseamt"));
			}else {
				info.setRhqFinPurchaseAmt("");
			}
			if(rs.getString("eligiblestatus")!=null){
				info.setEligibleStatus(rs.getString("eligiblestatus"));
			}else {
				info.setEligibleStatus("");
			}
			if(rs.getString("edcpdesignation1")!=null){
				info.setEdcpDesignation1(rs.getString("edcpdesignation1"));
			}else {
				info.setEdcpDesignation1("");
			}
			if(rs.getString("rhqhrdesignation")!=null){
				info.setRhqHrDesignation(rs.getString("rhqhrdesignation"));
			}else {
				info.setRhqHrDesignation("");
			}
			if(rs.getString("rhqfindesignation")!=null){
				info.setRhqFinDesignation(rs.getString("rhqfindesignation"));
			}else {
				info.setRhqFinDesignation("");
			}
			if(rs.getString("edcpdesignation1")!=null){
				info.setEdcpDesignation1(rs.getString("edcpdesignation1"));
			}else {
				info.setEdcpDesignation1("");
			}
			if(rs.getString("edcpaprovedate1")!=null){
				info.setEdcpApproveDate1(rs.getString("edcpaprovedate1"));
			}else {
				info.setEdcpApproveDate1("");
			}
			if(rs.getString("edcpdisplayname1")!=null){
				info.setEdcpDisplayname1(rs.getString("edcpdisplayname1"));
			}else {
				info.setEdcpDisplayname1("");
			}
			if(rs.getString("rhqfindisplayname")!=null){
				info.setRhqFinDisplayname(rs.getString("rhqfindisplayname"));
			}else {
				info.setRhqFinDisplayname("");
			}
			if(rs.getString("rhqhrdisplayname")!=null){
				info.setRhqHrDisplayname(rs.getString("rhqhrdisplayname"));
			}else {
				info.setRhqHrDisplayname("");
			}
			if(rs.getString("rhqfindisplayname")!=null){
				info.setFindisplayname(rs.getString("rhqfindisplayname"));
			}else {
				info.setFindisplayname("");
			}
			if(rs.getString("findisplayname")!=null){
				info.setFindisplayname(rs.getString("findisplayname"));
			}else {
				info.setFindisplayname("");
			}
			if(rs.getString("hr2displayname")!=null){
				info.setHr2displayname(rs.getString("hr2displayname"));
			}else {
				info.setHr2displayname("");
			}
			if(rs.getString("hr1displayname")!=null){
				info.setHr1displayname(rs.getString("hr1displayname"));
			}else {
				info.setHr1displayname("");
			}
			if(rs.getString("findesignation")!=null){
				info.setFindesignation(rs.getString("findesignation"));
			}else {
				info.setFindesignation("");
			}
			if(rs.getString("hr2designation")!=null){
				info.setHr2designation(rs.getString("hr2designation"));
			}else {
				info.setHr2designation("");
			}
			if(rs.getString("hr1designation")!=null){
				info.setHr1designation(rs.getString("hr1designation"));
			}else {
				info.setHr1designation("");
			}
			
			if(rs.getString("aaiedcpsoptiondesc")!=null){
				info.setAaiEDCPSoptionDesc(rs.getString("aaiedcpsoptiondesc"));
			}else {
				info.setAaiEDCPSoptionDesc("");
			}
			if(rs.getString("ackaprovedate")!=null){
				info.setAckApproveDate(rs.getString("ackaprovedate"));
			}else {
				info.setAckApproveDate("");
			}
			if(rs.getString("hraprovedate")!=null){
				info.setHrApproveDate(rs.getString("hraprovedate"));
			}else {
				info.setHrApproveDate("");
			}
			if(rs.getString("finaprovedate")!=null){
				info.setFinApproveDate(rs.getString("finaprovedate"));
			}else {
				info.setFinApproveDate("");
			}
			if(rs.getString("rhqhraprovedate")!=null){
				info.setRhqHrApproveDate(rs.getString("rhqhraprovedate"));
			}else {
				info.setRhqHrApproveDate("");
			}
			if(rs.getString("rhqfinaprovedate")!=null){
				info.setRhqFinApproveDate(rs.getString("rhqfinaprovedate"));
			}else {
				info.setRhqFinApproveDate("");
			}
			if(rs.getString("edcpaprovedate")!=null){
				info.setEdcpApproveDate(rs.getString("edcpaprovedate"));
			}else {
				info.setEdcpApproveDate("");
			}
			if(rs.getString("desegnation")!=null){
				info.setDesignation(rs.getString("desegnation"));
			}
			
			if(rs.getString("intcalcdate")!=null){
				info.setIntcalcdate(rs.getString("intcalcdate"));
			}
			if(rs.getString("edcpcorpusamt")!=null){
				info.setEdcpCorpusAmt(rs.getString("edcpcorpusamt"));
			}else{
				info.setEdcpCorpusAmt("0");
			}
			if(rs.getString("edcpcorpusint")!=null){
				info.setEdcpCorpusint(rs.getString("edcpcorpusint"));
			}else{
				info.setEdcpCorpusint("0");
			}
			if(rs.getString("edcptdsver")!=null){
				info.setTdsrec(rs.getString("edcptdsver"));
			}
			if(rs.getString("region")!=null){
				info.setRegion(rs.getString("region"));
			}
			if(rs.getString("airport")!=null){
				info.setAirport(rs.getString("airport"));
			}
			
			if(rs.getString("applicationId")!=null){
				info.setAppId(rs.getString("applicationId"));
			}
			if(rs.getString("aaiedcpsoption")!=null){
				info.setAaiEDCPSoption(rs.getString("aaiedcpsoption"));
			}
			if(rs.getString("modeofpayment")!=null){
				info.setPaymentMode(rs.getString("modeofpayment"));
			}
			if(rs.getString("membername")!=null){
				info.setMemberName(rs.getString("membername"));
			}
			if(rs.getString("formtype")!=null){
				info.setFormType(rs.getString("formtype"));
			}
			if(rs.getString("dateofexit")!=null){
				info.setDateOfexit(rs.getString("dateofexit"));
			}
			if(rs.getString("member_dob")!=null){
				info.setDob(rs.getString("member_dob"));
			}
			if(rs.getString("member_doj")!=null){
				info.setDoj(rs.getString("member_doj"));
			}
			if(rs.getString("causeofexit")!=null){
				info.setExitReason(rs.getString("causeofexit"));
			}
			
		
			if(rs.getString("pensionno")!=null){
				info.setEmployeeNo(rs.getString("pensionno"));
				
			}
			
			if(rs.getString("status")!=null){
				info.setStatus(rs.getString("status"));
			}
			if(rs.getString("appdate")!=null){
			
				info.setAppDate(CommonUtil
						.converDBToAppFormat(rs.getDate("appdate")));
			}
			//spouse details
			if(rs.getString("spousename")!=null){
				info.setSpouseName(rs.getString("spousename"));
				
			}
			if(rs.getString("spouseaddress")!=null){
				info.setSpouseAdd(rs.getString("spouseaddress"));
				
			}
			if(rs.getString("spousedob")!=null){
				info.setSpouseDob(rs.getString("spousedob"));
				
			}
			if(rs.getString("spouserelation")!=null){
				info.setSpouseRelation(rs.getString("spouserelation"));
				
			}
			//System.out.println("personal");
			//personal
			if(rs.getString("address")!=null){
				info.setMemberAddress(rs.getString("address"));
			}
			if(rs.getString("permentaddress")!=null){
				info.setMemberPerAdd(rs.getString("permentaddress"));
			}
			if(rs.getString("nomineename")!=null){
				info.setNomineeName(rs.getString("nomineename"));
			}
			if(rs.getString("nominee2name")!=null){
				info.setNomineeName2(rs.getString("nominee2name"));
			}
			if(rs.getString("nominee3name")!=null){
				info.setNomineeName3(rs.getString("nominee3name"));
			}
			if(rs.getString("EMPSAPCODE")!=null){
				info.setEmpsapCode(rs.getString("EMPSAPCODE"));
			}
			
			
			
			if(rs.getString("nomineedob")!=null){
				info.setNomineeDob(rs.getString("nomineedob"));
			}
			if(rs.getString("adharno")!=null){
				info.setAdharno(rs.getString("adharno"));
			}
			if(rs.getString("relation")!=null){
				info.setRelationtoMember(rs.getString("relation"));
			}
			if(rs.getString("phoneno")!=null){
				info.setMobilNo(rs.getString("phoneno"));
			}
			if(rs.getString("PANNO")!=null){
				info.setPanNo(rs.getString("PANNO"));
			}
			if(rs.getString("email")!=null){
				info.setEmail(rs.getString("email"));
			}
			
			if(rs.getString("alternatemobile")!=null){
				info.setMobilNo1(rs.getString("alternatemobile"));
				
			}
			if(rs.getString("town")!=null){
				info.setCtv(rs.getString("town"));
			}
			if(rs.getString("state")!=null){
				info.setState(rs.getString("state"));
			}
			if(rs.getString("pincode")!=null){
				info.setPinCode(rs.getString("pincode"));
			}
			if(rs.getString("nationality")!=null){
				info.setNationality(rs.getString("nationality"));
			}
			if(rs.getString("fathersname")!=null){
				info.setFatherName(rs.getString("fathersname"));
			}
			if(rs.getString("gender")!=null){
				info.setGender(rs.getString("gender"));
			}
			if(rs.getString("secannuitantgender")!=null){
				info.setSecAnnuitantGender(rs.getString("secannuitantgender"));
			}
			if(rs.getString("secannuitantpan")!=null){
				info.setSecAnnuitantPAN(rs.getString("secannuitantpan"));
			}
			
			
			//System.out.println("bank");
			//bank
			if(rs.getString("bankname")!=null){
				info.setBankName(rs.getString("bankname"));
			}
			if(rs.getString("branch")!=null){
				info.setBranch(rs.getString("branch"));
			}
			if(rs.getString("ifsc")!=null){
				info.setIfscCode(rs.getString("ifsc"));
			}
			if(rs.getString("account_type")!=null){
				info.setAccType(rs.getString("account_type"));
			}
			if(rs.getString("account_no")!=null){
				info.setAccNo(rs.getString("account_no"));
			}
			if(rs.getString("micrcode")!=null){
				info.setMicrCode(rs.getString("micrcode"));
			}
			if(rs.getString("customername")!=null){
				info.setCustomerName(rs.getString("customername"));
			}
			
			if(rs.getString("customername2")!=null){
				info.setCustomerName2(rs.getString("customername2"));
			}
			
			if(rs.getString("bankname2")!=null){
				info.setBankName2(rs.getString("bankname2"));
			}
			
			if(rs.getString("accountno2")!=null){
				info.setAccNo2(rs.getString("accountno2"));
			}
			
			if(rs.getString("micrcode2")!=null){
				info.setMicrCode2(rs.getString("micrcode2"));
			}
			
			if(rs.getString("branchaddr2")!=null){
				info.setBranch2(rs.getString("branchaddr2"));
			}
			
			if(rs.getString("ifsccode2")!=null){
				info.setIfscCode2(rs.getString("ifsccode2"));
			}
			
			//System.out.println("checklist");
			//checklist
			if(rs.getString("claimform")!=null){
				info.setClaimForm(rs.getString("claimform"));
			}
			if(rs.getString("identitycard")!=null){
				info.setIdentityCard(rs.getString("identitycard"));
			}
			if(rs.getString("payslip")!=null){
				info.setPaySlip(rs.getString("payslip"));
			}
			if(rs.getString("pancard")!=null){
				info.setPanCard(rs.getString("pancard"));
			}
			if(rs.getString("adharcard")!=null){
				info.setAdharCard(rs.getString("adharcard"));
			}
			if(rs.getString("cancelcheque")!=null){
				info.setCancelCheque(rs.getString("cancelcheque"));
			}
			if(rs.getString("photograph")!=null){
				info.setPhotograph(rs.getString("photograph"));
			}
			if(rs.getString("deceasedemployee")!=null){
				info.setDeceasedemployee(rs.getString("deceasedemployee"));
			}
			if(rs.getString("nominationdoc")!=null){
				info.setNominationdoc(rs.getString("nominationdoc"));
			}
			if(rs.getString("nomineeproof")!=null){
				info.setNomineeproof(rs.getString("nomineeproof"));
			}
			
			
			//System.out.println("Eligibility List");
		//Eligibility List	
			if(rs.getString("servicebook")!=null){
				info.setServiceBook(rs.getString("servicebook"));
			}
			if(rs.getString("cpse")!=null){
				info.setCpse(rs.getString("cpse"));
			}
			if(rs.getString("cad")!=null){
				info.setCad(rs.getString("cad"));
			}
			if(rs.getString("crs")!=null){
				info.setCrs(rs.getString("crs"));
			}
			if(rs.getString("resign")!=null){
				info.setResign(rs.getString("resign"));
			}
			if(rs.getString("vrs")!=null){
				info.setVrs(rs.getString("vrs"));
			}
			if(rs.getString("deputation")!=null){
				info.setDeputation(rs.getString("deputation"));
			}
			if(rs.getString("totcorpus2lakhs")!=null){
				info.setTotcorpus2lakhs(rs.getString("totcorpus2lakhs"));
			}
			if(rs.getString("deathcertficate")!=null){
				info.setDeathcertficate(rs.getString("deathcertficate"));
			}
			if(rs.getString("arrear")!=null){
				info.setArrear(rs.getString("arrear"));
			}
			if(rs.getString("notionalincrement")!=null){
				info.setNotionalIncrement(rs.getString("notionalincrement"));
			}
			if(rs.getString("notionaldisplay")!=null){
				info.setNotionaldisplay(rs.getString("notionaldisplay"));
			}
			if(rs.getString("obadjustment")!=null){
				info.setObadjustment(rs.getString("obadjustment"));
			}
			
			
			
			
			//System.out.println("add Nominee List");
			//add Nominee List
			info.setNomineeList(this.getNomineeList(rs.getString("appid")));
			
			//System.out.println("add Nominee Appointee list");
			//add Nominee Appointee list
			info.setNomineeAppointeeList(this.getNomineeAppointeeList(rs.getString("appid")));
			
			//System.out.println("fin checklist");
			//fin checklist
			if(rs.getString("finNoIncrement")!=null){
				info.setFinNoIncrement(rs.getString("finNoIncrement"));
			}
			if(rs.getString("finArrear")!=null){
				info.setFinArrear(rs.getString("finArrear"));
			}
			if(rs.getString("finPreOBadj")!=null){
				info.setFinPreOBadj(rs.getString("finPreOBadj"));
			}
			if(rs.getString("obOtherReason")!=null){
				info.setObOtherReason(rs.getString("obOtherReason"));
			}
			if(rs.getString("finOBadjCorpusCard")!=null){
				info.setFinOBadjCorpusCard(rs.getString("finOBadjCorpusCard"));
			}
			if(rs.getString("finCorpusVerified")!=null){
				info.setFinCorpusVerified(rs.getString("finCorpusVerified"));
			}
			
			if(rs.getString("obremarks")!=null){
				info.setObRemarks(rs.getString("obremarks"));
			}
			if(rs.getString("corpusobadjustment")!=null){
				info.setCorpusOBAdjustment(rs.getString("corpusobadjustment"));
			}
			if(rs.getString("dep_aai_otherorg")!=null){
				info.setDepaaiToOtherorg(rs.getString("dep_aai_otherorg"));
			}
			if(rs.getString("dateofseperation_date")!=null){
				info.setDos(rs.getString("dateofseperation_date"));
			}
			
			//System.out.println("===ending bean===");
			list.add(info);
			//System.out.println("ghjghjghjg while dao"+list.size() );
		}
		
		}catch(Exception e){
			e.printStackTrace();
			
		}finally{
			DBUtils.closeConnection(rs, st, con);
		}
	//	System.out.println("ghjghjghjg in dao"+list.size() );
	return list;
		
		

	}

	public String addJournalVoucher(String pfid,String userName,String unitType) throws SBSException {
		String sqlQueryMainForm="";
		Connection con=null;
		Statement st=null;
		ResultSet rs=null;
		String Jvid="";
		String Jvnumber="";
		String appid="";
		String membername="";
		String finyear="";
		String formtype="";
		String EDCPCORPUSAMT="";
		String EDCPCORPUSINT="";
		String debitamount="";
		String creditamount="";
		String airport="";
		String region="";
		String Regionid="";
		System.out.println("Dao : addJournalVoucher");
		try{
			con=DBUtils.getConnection();
			con.setAutoCommit(false);
			st=con.createStatement();
			
			rs=st.executeQuery("select appid,membername,FORM_TYPE,EDCPCORPUSAMT,EDCPCORPUSINT,(EDCPCORPUSAMT+EDCPCORPUSINT) creditamount,(EDCPCORPUSAMT+EDCPCORPUSINT) debitamount, (select distinct (case when ((APPDATE >=to_date('01/Apr/' ||to_char(APPDATE, 'YYYY'),'dd/Mon/yyyy')) and(APPDATE <=to_date('31/Mar/' ||(to_number(to_char(APPDATE, 'YYYY')) + 1),'dd/Mon/yyyy'))) then (to_char(APPDATE, 'YYYY') || '-' ||(to_number(to_char(APPDATE, 'YYYY')) + 1)) when ((APPDATE >=to_date('01/Apr/' ||(to_number(to_char(APPDATE, 'YYYY')) - 1),'dd/Mon/yyyy')) and (APPDATE <=to_date('31/Mar/' || to_char(APPDATE, 'YYYY'),'dd/Mon/yyyy'))) then ((to_number(to_char(APPDATE, 'YYYY')) - 1) || '-' ||to_char(APPDATE, 'YYYY')) end) from sbs_annuity_forms where pensionno=s.pensionno) as finyear,airport,region,nvl(decode(Region,'CHQNAD','CHQ','South Region','RHQ','East Region','RHQ','North-East Region','RHQ',  'North Region', 'RHQ', 'RAUSAP','RAU','West Region','RHQ','CHQIAD','CHQ'),region) Regionid from sbs_annuity_forms s where pensionno='"+pfid+"'");
			if(rs.next()){
				appid=rs.getString("appid");
				membername=rs.getString("membername");
				formtype=rs.getString("FORM_TYPE");
				EDCPCORPUSAMT=rs.getString("EDCPCORPUSAMT");
				EDCPCORPUSINT=rs.getString("EDCPCORPUSINT");
				creditamount=rs.getString("creditamount");
				debitamount=rs.getString("debitamount");
				finyear=rs.getString("finyear");
				airport=rs.getString("airport");
				region=rs.getString("region");
				Regionid=rs.getString("Regionid");
			}
			if(rs!=null) {
				rs.close();
			}
			
			rs=st.executeQuery("select nvl(lpad((max(Jv_id)+1),5,0),'00001') ID from sbs_journal_voucher");
			if(rs.next()){
				Jvid=rs.getString("ID");
				Jvnumber="JV/"+Regionid+"/"+formtype+"/"+rs.getString("ID");
			}
			if(rs!=null) {
				rs.close();
			}
			
			sqlQueryMainForm="insert into sbs_journal_voucher(Jv_id,Jv_number,pensionno,appid,MEMBERNAME,form_type,Jv_type,Fin_year,EDCPCORPUSAMT,EDCPCORPUSINT,Debit_amount,credit_amount,Jvprep_date,prepared_by,Jventered_date,airport,region ) values ('"+Jvid+"','"+Jvnumber+"','"+pfid+"','"+appid+"','"+membername+"','"+formtype+"','Journal Voucher','"+finyear+"','"+EDCPCORPUSAMT+"','"+EDCPCORPUSINT+"','"+debitamount+"','"+creditamount+"',sysdate,'"+userName+"',sysdate,'"+airport+"','"+region+"')";
			System.out.println("sqlQueryMainForm"+sqlQueryMainForm);
			st.executeQuery(sqlQueryMainForm);
			con.setAutoCommit(true);
		}catch(Exception e){
		e.printStackTrace();
		try {
			con.rollback();
		} catch (SQLException e1) {
			throw new SBSException(e1.getMessage());
		}
		throw new SBSException(e.getMessage());
	}finally{
		DBUtils.closeConnection(rs, st, con);
	}
	return Jvid;
	}
	
public LicBean getJournalVoucher(String jvid) {
	System.out.println("jvid==="+jvid);
		
		String sqlQuery="select JV_ID,JV_NUMBER,V.PENSIONNO,V.APPID,V.MEMBERNAME,V.FORM_TYPE,JV_TYPE,FIN_YEAR,V.EDCPCORPUSAMT,V.EDCPCORPUSINT,DEBIT_AMOUNT,CREDIT_AMOUNT,to_char(JVPREP_DATE,'dd-Mon-yyyy') JVPREP_DATE, PREPARED_BY,to_char(JVENTERED_DATE,'dd-Mon-yyyy') JVENTERED_DATE,s.airport,s.region from sbs_journal_voucher  V,sbs_annuity_forms s where V.JV_ID = '"+jvid+"' and  v.pensionno=s.pensionno";
		
		Connection con=null;
		Statement st=null;
		ResultSet rs=null;
		LicBean info=null;
		try{
		con=DBUtils.getConnection();
		st=con.createStatement();
		System.out.println("sqlQuery===="+sqlQuery);
		rs=st.executeQuery(sqlQuery);
	
		if (rs.next()){
			info=new LicBean();
			
		    if(rs.getString("JV_ID")!=null){
				info.setJvId(rs.getString("JV_ID"));
			}else {
				info.setJvId("");
			}
			if(rs.getString("JV_NUMBER")!=null){
				info.setJvNumber(rs.getString("JV_NUMBER"));
			}else {
				info.setJvNumber("");
			}
			if(rs.getString("PENSIONNO")!=null){
				info.setEmpsapCode(rs.getString("PENSIONNO"));
			}else {
				info.setEmpsapCode("");
			}
			
			if(rs.getString("APPID")!=null){
				info.setAppId(rs.getString("APPID"));
			}else {
				info.setAppId("");
			}
			if(rs.getString("MEMBERNAME")!=null){
				info.setMemberName(rs.getString("MEMBERNAME"));
			}else {
				info.setMemberName("");
			}
			if(rs.getString("FORM_TYPE")!=null){
				info.setFormType(rs.getString("FORM_TYPE"));
			}else {
				info.setFormType("");
			}
			
			if(rs.getString("airport")!=null){
				info.setAirport(rs.getString("airport"));
			}else {
				info.setAirport("");
			}
			
			if(rs.getString("region")!=null){
				info.setRegion(rs.getString("region"));
			}else {
				info.setRegion("");
			}
			
			if(rs.getString("JV_TYPE")!=null){
				info.setJvType(rs.getString("JV_TYPE"));
			}else {
				info.setJvType("");
			}
			if(rs.getString("FIN_YEAR")!=null){
				info.setFinYear(rs.getString("FIN_YEAR"));
			}else {
				info.setFinYear("");
			}
			if(rs.getString("EDCPCORPUSAMT")!=null){
				info.setEdcpCorpusAmt(rs.getString("EDCPCORPUSAMT"));
			}else {
				info.setEdcpCorpusAmt("");
			}
			if(rs.getString("EDCPCORPUSINT")!=null){
				info.setEdcpCorpusint(rs.getString("EDCPCORPUSINT"));
			}else {
				info.setEdcpCorpusint("");
			}
			if(rs.getString("DEBIT_AMOUNT")!=null){
				info.setDebitAmount(rs.getString("DEBIT_AMOUNT"));
			}else {
				info.setDebitAmount("");
			}
			if(rs.getString("CREDIT_AMOUNT")!=null){
				info.setCreditAmount(rs.getString("CREDIT_AMOUNT"));
			}else {
				info.setCreditAmount("");
			}
			if(rs.getString("JVPREP_DATE")!=null){
				info.setJvPrepDate(rs.getString("JVPREP_DATE"));
			}else {
				info.setJvPrepDate("");
			}
			if(rs.getString("PREPARED_BY")!=null){
				info.setJvEnterdBy(rs.getString("PREPARED_BY"));
			}else {
				info.setJvEnterdBy("");
			}
			if(rs.getString("JVENTERED_DATE")!=null){
				info.setJvEnterdDt(rs.getString("JVENTERED_DATE"));
			}else {
				info.setJvEnterdDt("");
			}
			
		}
		
		}catch(Exception e){
			e.printStackTrace();
			
		}finally{
			DBUtils.closeConnection(rs, st, con);
		}
		
	return info;
		
	}
public ArrayList getJournalVocherSRCH(String unitcd,String unitType) {
	String sqlQuery="";
	//if(unitType.equals("C")){
		sqlQuery="select JV_ID,JV_NUMBER,PENSIONNO,APPID,MEMBERNAME,form_type,JVPREP_DATE from sbs_journal_voucher ";
	
	ArrayList list=new ArrayList();
	Connection con=null;
	Statement st=null;
	ResultSet rs=null;
	LicBean info=null;
	try{
	con=DBUtils.getConnection();
	st=con.createStatement();
	rs=st.executeQuery(sqlQuery);

	while (rs.next()){
		info=new LicBean();
		if(rs.getString("JV_ID")!=null){
			info.setJvId(rs.getString("JV_ID"));
		}
		if(rs.getString("APPID")!=null){
			info.setAppId(rs.getString("APPID"));
		}
		if(rs.getString("MEMBERNAME")!=null){
			info.setMemberName(rs.getString("MEMBERNAME"));
		}
		if(rs.getString("form_type")!=null){
			info.setFormType(rs.getString("form_type"));
		}
		
		if(rs.getString("PENSIONNO")!=null){
			info.setEmpsapCode(rs.getString("PENSIONNO"));
		}
		
		
			info.setStatus("A");
		
			if(rs.getString("JV_NUMBER")!=null){
				info.setJvNumber(rs.getString("JV_NUMBER"));
			}
		if(rs.getString("JVPREP_DATE")!=null){
		
			info.setAppDate(CommonUtil
					.converDBToAppFormat(rs.getDate("JVPREP_DATE")));
		}
		
		
		
		list.add(info.toString());
		
	}
	
	}catch(Exception e){
		e.printStackTrace();
		
	}finally{
		DBUtils.closeConnection(rs, st, con);
	}
	
	return list;
}
public ArrayList getJournalVocherReport(String region,String airport) {
	String sqlQuery="";
		sqlQuery="select JV_ID,JV_NUMBER,v.PENSIONNO,'Annuity/'||v.form_type||'/'||v.appid APPID,v.MEMBERNAME,v.form_type ,fin_year,v.EDCPCORPUSAMT,v.EDCPCORPUSINT,DEBIT_AMOUNT,CREDIT_AMOUNT,JVPREP_DATE,PREPARED_BY,JVENTERED_DATE,v.airport,v.Region from sbs_journal_voucher v,sbs_annuity_forms s where v.appid=s.appid ";
	
		if(!region.equals("")){
			sqlQuery+=" and s.region='"+region+"'";
		}
		if(!airport.equals("")){
			sqlQuery+=" and s.airport='"+airport+"'";
		}
		System.out.println("sqlQuery====="+sqlQuery);
	ArrayList list=new ArrayList();
	Connection con=null;
	Statement st=null;
	ResultSet rs=null;
	LicBean info=null;
	try{
	con=DBUtils.getConnection();
	st=con.createStatement();
	rs=st.executeQuery(sqlQuery);

	while (rs.next()){
		info=new LicBean();
		if(rs.getString("JV_ID")!=null){
			info.setJvId(rs.getString("JV_ID"));
		}
		if(rs.getString("APPID")!=null){
			info.setAppId(rs.getString("APPID"));
		}
		if(rs.getString("MEMBERNAME")!=null){
			info.setMemberName(rs.getString("MEMBERNAME"));
		}
		if(rs.getString("form_type")!=null){
			info.setFormType(rs.getString("form_type"));
		}
		if(rs.getString("fin_year")!=null){
			info.setFinYear(rs.getString("fin_year"));
		}
		
		if(rs.getString("PENSIONNO")!=null){
			info.setEmpsapCode(rs.getString("PENSIONNO"));
		}
		
		if(rs.getString("JV_NUMBER")!=null){
				info.setJvNumber(rs.getString("JV_NUMBER"));
			}
		
		if(rs.getString("DEBIT_AMOUNT")!=null){
			info.setDebitAmount(rs.getString("DEBIT_AMOUNT"));
		}else {
			info.setDebitAmount("");
		}
		if(rs.getString("CREDIT_AMOUNT")!=null){
			info.setCreditAmount(rs.getString("CREDIT_AMOUNT"));
		}else {
			info.setCreditAmount("");
		}
		if(rs.getString("JVPREP_DATE")!=null){
			info.setJvPrepDate(rs.getString("JVPREP_DATE"));
		}else {
			info.setJvPrepDate("");
		}
		if(rs.getString("PREPARED_BY")!=null){
			info.setJvEnterdBy(rs.getString("PREPARED_BY"));
		}else {
			info.setJvEnterdBy("");
		}
		if(rs.getString("JVENTERED_DATE")!=null){
			info.setJvEnterdDt(rs.getString("JVENTERED_DATE"));
		}else {
			info.setJvEnterdDt("");
		}
		if(rs.getString("region")!=null){
			info.setRegion(rs.getString("region"));
		}else {
			info.setRegion("");
		}
		if(rs.getString("airport")!=null){
			info.setAirport(rs.getString("airport"));
		}else {
			info.setAirport("");
		}
		list.add(info.toString());
		
	}
	
	}catch(Exception e){
		e.printStackTrace();
		
	}finally{
		DBUtils.closeConnection(rs, st, con);
	}
	System.out.println("list=DAO="+list.size());
	return list;

	
}
	
}

