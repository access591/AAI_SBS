package aims.dao;

import java.sql.Connection;
import aims.dao.*;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;


import aims.bean.EmployeePensionCardInfo;
import aims.bean.PensionContBean;
import aims.bean.SBSEmWiseTotBean;
import aims.bean.TempPensionTransBean;
import aims.common.DBUtils;
import aims.common.Log;

public class SBSCardDAO {
	Log log = new Log(SBSCardDAO.class);
	CommonDAO commonDAO=new CommonDAO();
	
public ArrayList getEmployeeWiseTotal(String pensionno,String finYear) {
		
		ArrayList emplist=new ArrayList();
		System.out.println("finYear==="+finYear);
		String firstFourChars = finYear.substring(0, 4);
		String lastFourChars = finYear.substring(5, 9);
		String fromyear="01-Apr-"+firstFourChars;
		String toyear="31-Mar-"+lastFourChars;
		String condition="";
		if(!pensionno.equals("")) {
			condition=" and x.pensionno='"+pensionno+"'";
		}
	String sqlQry="";
	//if(finYear.equals("2020-2021")) {
	 sqlQry="select (select nvl(edcpcorpusamt,0)+nvl(edcpcorpusint,0) from sbs_annuity_forms s,sbs_annuity_transations t where s.pensionno=o.pensionno and s.appid=t.appid and t.transcd='20' and  t.transdate between '"+fromyear+"' and '"+toyear+"')  as fscorpusamt,o.pensionno,o.employeename,o.desegnation,o.newempcode,o.pensionno,to_char(o.dateofbirth,'dd-Mon-yyyy') as dateofbirth,to_char(o.dateofjoining,'dd-Mon-yyyy') as dateofjoining,o.dateofseperation_reason,to_char(o.dateofseperation_date,'dd-Mon-yyyy') as dateofseperation_date,o.airportcode,o.region,x.adjsbscontri,(select aob.sbscontribution-aob.notationalincrement from sbs_adj_ob aob where aob.pensionno=o.pensionno and ADJOBYEAR='"+fromyear+"') as adjob," +
			"decode(nvl((select to_char(s.intcalcdate,'Mon') from sbs_annuity_forms s where s.pensionno=o.pensionno ),to_char(add_months(sysdate,-1),'Mon')),'Apr',1,'May',2,'Jun',3,'Jul',4,'Aug',5,'Sep',6,'Oct',7,'Nov',8,'Dec',9,'Jan',10,'Feb',11,'Mar',12) as intmonth from (select  a.pensionno,(b.sbscontri - (a.sbscont2017to20 + b.sbscontri2017 + nvl(b.noincrement2017,0)))-(b.noincrement - (a.ntincrement2017to20 + nvl(b.noincrement2017,0))) as adjsbscontri from" +
			" (select pensionno, sum(EMOLUMENTS) as EMOLUMENTS, sum(SBSCONTRI) as SBSCONTRI, sum(t.adjsbscontri2017) sbscontri2017, sum(notational_increment) as noincrement, sum(t.ntincrement2017) as noincrement2017, sum(INTEREST) as INTEREST, sum(t.taxval_withintt) as taxval_withintt, sum(t.taxval_withoutintt) as taxval_withoutintt from sbs_yearwise_total t group by pensionno) B,(select sum(sbscontri) as sbscont2017to20, sum(l.notational_increment) as ntincrement2017to20, pensionno from sbs_yearwise_total l where l.year_sno > 11  and finyear<='"+finYear+"'  group by pensionno) a where b.pensionno = a.pensionno ) x,employee_personal_info o where o.sbsflag='Y' and x.pensionno=o.pensionno   "+condition+" order by o.pensionno ";
	//}else {
		//sqlQry="select (select nvl(edcpcorpusamt,0)+nvl(edcpcorpusint,0) from sbs_annuity_forms s,sbs_annuity_transations t where s.pensionno=o.pensionno and s.appid=t.appid and t.transcd='20' and  t.transdate between '"+fromyear+"' and '"+toyear+"')  as fscorpusamt,o.pensionno,o.employeename,o.desegnation,o.newempcode,o.pensionno,to_char(o.dateofbirth,'dd-Mon-yyyy') as dateofbirth,to_char(o.dateofjoining,'dd-Mon-yyyy') as dateofjoining,o.dateofseperation_reason,to_char(o.dateofseperation_date,'dd-Mon-yyyy') as dateofseperation_date,o.airportcode,o.region,x.adjsbscontri,(select aob.sbscontribution-aob.notationalincrement from sbs_adj_ob aob where aob.pensionno=o.pensionno and ADJOBYEAR='"+fromyear+"') as adjob," +
			//	"decode(nvl((select to_char(s.intcalcdate,'Mon') from sbs_annuity_forms s where s.pensionno=o.pensionno ),to_char(add_months(sysdate,-1),'Mon')),'Apr',1,'May',2,'Jun',3,'Jul',4,'Aug',5,'Sep',6,'Oct',7,'Nov',8,'Dec',9,'Jan',10,'Feb',11,'Mar',12) as intmonth from (select pensionno,GROSS_CONTRI as adjsbscontri from sbs_ob  ) x,employee_personal_info o where o.sbsflag='Y' and x.pensionno=o.pensionno   "+condition+" order by o.pensionno ";
			
	//}
System.out.println("sqlQry==="+sqlQry);
	Connection con=null;
	Statement st=null;
	ResultSet rs=null;

	SBSEmWiseTotBean bean=null;
	 
	
	try{
	con=DBUtils.getConnection();
	st=con.createStatement();
	rs=st.executeQuery(sqlQry);
	
	

	while (rs.next()){
		bean=new SBSEmWiseTotBean();
		bean.setFinYear(finYear);
		bean.setEmpName(rs.getString("employeename"));
		bean.setDesignation(rs.getString("desegnation"));
		if(rs.getString("newempcode")!=null){
		bean.setSapEmpNo(rs.getString("newempcode"));
		}else{
		bean.setSapEmpNo("");	
		}
		bean.setPfId(rs.getString("pensionno"));
		//System.out.println("PfId===="+bean.getPfId());
		
		bean.setDob(rs.getString("dateofbirth"));
		bean.setDoj(rs.getString("dateofjoining"));
		if(rs.getString("dateofseperation_reason")!=null){
		bean.setDosReason(rs.getString("dateofseperation_reason"));
		}else{
			bean.setDosReason("");
		}
		if(rs.getString("dateofseperation_date")!=null){
		bean.setDosDate(rs.getString("dateofseperation_date"));
		}else{
			bean.setDosDate("");	
		}
		bean.setAirport(rs.getString("airportcode"));
		bean.setRegion(rs.getString("region"));
		if(rs.getString("adjsbscontri")!=null){
		bean.setOb(rs.getString("adjsbscontri"));
		}else{
			bean.setOb("0");	
		}
		if(rs.getString("adjob")!=null){
		bean.setAdjOb(rs.getString("adjob"));
		}else{
			bean.setAdjOb("0");
		}
		String proInt="0";
		 proInt=String.valueOf(Math.round((Double.parseDouble(bean.getOb())+Double.parseDouble(bean.getAdjOb()))*(0.07431)));
		 //System.out.println("proInt==="+proInt);
		bean.setProvInt(proInt);
		
		String prvInt="0";
		 prvInt=String.valueOf(Math.round((Double.parseDouble(bean.getOb())+Double.parseDouble(proInt)+Double.parseDouble(bean.getAdjOb()))*(0.06431)));
		
		//System.out.println("prvInt==="+prvInt);
		
		String monthlyInt="0";double rateOfInt=6.431;int intUToMonth=0;double closingBal=0.0;
		
		intUToMonth=Integer.parseInt(rs.getString("intmonth"));
		
		if(finYear.equals("2020-2021")) {
			System.out.println("finYear=inside=="+finYear);
		if(rs.getString("fscorpusamt")!=null){ 
		System.out.println("intUToMonth=inside=="+intUToMonth);
		monthlyInt=String.valueOf(Math.round((Double.parseDouble(bean.getOb())+Double.parseDouble(bean.getAdjOb())+Double.parseDouble(bean.getProvInt()))*(rateOfInt/100/12*intUToMonth)));
		}else {
		monthlyInt=String.valueOf(Math.round((Double.parseDouble(bean.getOb())+Double.parseDouble(bean.getAdjOb())+Double.parseDouble(bean.getProvInt()))*(rateOfInt/100)));
			}
		}else{
		monthlyInt=String.valueOf(Math.round((Double.parseDouble(bean.getOb())+Double.parseDouble(bean.getAdjOb()))*(rateOfInt/100/12*intUToMonth)));
		}
		bean.setCummilativeInt(monthlyInt);
		if(rs.getString("fscorpusamt")!=null){
		bean.setFsCorpusAmt(rs.getString("fscorpusamt"));
		}else{
			bean.setFsCorpusAmt("0");
		}
		if(finYear.equals("2020-2021")) {
		closingBal=Double.parseDouble(bean.getOb())+Double.parseDouble(bean.getAdjOb())+Double.parseDouble(bean.getProvInt())+Double.parseDouble(bean.getCummilativeInt());
		}else {
		closingBal=Double.parseDouble(bean.getOb())+Double.parseDouble(bean.getAdjOb())+Double.parseDouble(bean.getCummilativeInt());
		}
		bean.setClosingBal(String.valueOf(closingBal));
		emplist.add(bean);
		
		}
	
	}catch(Exception e){
		e.printStackTrace();
		
	}finally{
		DBUtils.closeConnection(rs, st, con);
	}
	
	
	
	return emplist;
	}
	public ArrayList getSBSReportCard(String pensionno,String finYear) {
		
		ArrayList emplist=new ArrayList();
		emplist=this.getEmployeeList(pensionno,finYear);
		
	
		
		
		
		return emplist;
	}
	
	 public ArrayList getEmployeeList(String pensionno,String finYear){
		 log.info("+++++++++++++++++++++++++++++++"+pensionno);
		 ArrayList empList=null;
		 empList=new ArrayList();	 
		 Connection con=null;
			Statement st=null;
			ResultSet rs=null;
			String sqlQuery="";
			PensionContBean personalBean=null;
			System.out.println("********************************"+finYear);
			String firstFourChars = finYear.substring(0, 4);
			String lastFourChars = finYear.substring(5, 9);
			String fromyear="01-Apr-"+firstFourChars;
			String toyear="31-Mar-"+lastFourChars;
			
				log.info("if"+finYear);
			    sqlQuery="select pensionno,employeename,o.desegnation,o.gender,o.fhname,to_char(o.dateofbirth,'dd-Mon-yyyy') as dateofbirth,o.newempcode,to_char(o.dateofjoining,'dd-Mon-yyyy') as dateofjoining,o.dateofseperation_reason,to_char(o.dateofseperation_date,'dd-Mon-yyyy') as dateofseperation_date,(case when o.dateofjoining > '01-Jan-2007' then to_char(o.dateofjoining,'dd-Mon-yyyy')  else '01-Jan-2007' end) as dateofcommencement,o.sbs_ntincrement,10 as contripercentage," +
					"(select  to_char(add_months(s.intcalcdate,1),'dd-Mon-yyyy') from sbs_annuity_forms s where s.pensionno=o.pensionno and   s.intcalcdate between '"+fromyear+"' and '"+toyear+"') as intdate,(select  to_char(s.intcalcdate,'dd-Mon-yyyy') from sbs_annuity_forms s where s.pensionno=o.pensionno and   s.intcalcdate between '"+fromyear+"' and '"+toyear+"') as dispintdate,(select edcpapproval3  from sbs_annuity_forms s,sbs_annuity_transations t where s.pensionno=o.pensionno and s.appid=t.appid and t.transcd='20' and  t.transdate between '"+fromyear+"' and '"+toyear+"') as sactionflag,(select nvl(edcpcorpusamt,0)+nvl(edcpcorpusint,0) from sbs_annuity_forms s,sbs_annuity_transations t where s.pensionno=o.pensionno and s.appid=t.appid and t.transcd='20' and  t.transdate between '"+fromyear+"' and '"+toyear+"') as corpusamt from employee_personal_info o where SBSflag='Y' and pensionno="+pensionno;
			
				
			try{
			con=DBUtils.getConnection();
			st=con.createStatement();
			System.out.println("sqlQuery-==="+sqlQuery);
			rs=st.executeQuery(sqlQuery);
			String intDate="",sactionflag="",dispIntDate="";
		
			while (rs.next()){
				personalBean=new PensionContBean();
				if(rs.getString("corpusamt")!=null){
					personalBean.setPfSettled(rs.getString("corpusamt"));
					}
				personalBean.setPfID(rs.getString("pensionno"));
				personalBean.setEmployeeNM(rs.getString("employeename"));
				personalBean.setDesignation(rs.getString("desegnation"));
				personalBean.setGender(rs.getString("gender"));
				personalBean.setFhName(rs.getString("fhname"));
				personalBean.setEmpDOB(rs.getString("dateofbirth"));
				if(rs.getString("newempcode")!=null){
				personalBean.setNewEmpCode(rs.getString("newempcode"));
				}
				personalBean.setEmpDOJ(rs.getString("dateofjoining"));
				personalBean.setDateOfEntitle(rs.getString("dateofcommencement"));
				personalBean.setSbsNTIncrement(rs.getString("sbs_ntincrement"));
				personalBean.setContriPer(rs.getString("contripercentage"));
				personalBean.setSeparationReason(rs.getString("dateofseperation_reason"));
				personalBean.setDateofSeperationDt(rs.getString("dateofseperation_date"));
				
				if(rs.getString("intdate")!=null){
				intDate=rs.getString("intdate");
				}
				if(rs.getString("dispintdate")!=null){
					dispIntDate=rs.getString("dispintdate");
					}
				
				if(rs.getString("sactionflag")!=null){
					sactionflag=rs.getString("sactionflag");
					}
				personalBean.setInterestCalUpto(dispIntDate);
				
				personalBean.setSactionflag(sactionflag);
				personalBean.setEmpPensionList(this.getSBSList(personalBean.getPfID(),finYear));
				
				personalBean.setObList(this.getOBList(personalBean.getPfID(),finYear));
				
				personalBean.setAdjOBList(this.getAdjOBList(personalBean.getPfID(),finYear));
				
				if(finYear.equals("2020-2021")){
				
				personalBean.setNoOfMonths(commonDAO
						.getNoOfMonthsForPFID("01-Apr-2020", "31-Mar-2021",intDate));
				}else{

					personalBean.setNoOfMonths(commonDAO
							.getNoOfMonthsForPFID("01-Apr-2021", "31-Mar-2022",intDate));	
				}
				
				empList.add(personalBean);
				}
			
			}catch(Exception e){
				e.printStackTrace();
				
			}finally{
				DBUtils.closeConnection(rs, st, con);
			}
			
		 
		 
		 return empList;
		
	}

	public ArrayList getOBList(String pfID,String finYear) {
		ArrayList obList=null;
		obList=new ArrayList();
		
		Connection con=null;
		Statement st=null;
		ResultSet rs=null;
		String sqlQuery="";
		TempPensionTransBean obBean=null;
		System.out.println("finYear===="+finYear);
		if(finYear.equals("2020-2021")){
		 sqlQuery = "select nvl(b.sbscontri - (a.sbscont2017to20 + b.sbscontri2017 + nvl(b.noincrement2017,0)),0) as sbscontri,(select region from employee_personal_info where pensionno="+pfID+") as remarks, b.noincrement - (a.ntincrement2017to20 + nvl(b.noincrement2017,0)) as notational_increment,nvl((b.sbscontri - (a.sbscont2017to20 + b.sbscontri2017 + nvl(b.noincrement2017,0)))-(b.noincrement - (a.ntincrement2017to20 + nvl(b.noincrement2017,0))),0) as adjsbscontri from (select pensionno, sum(EMOLUMENTS) as EMOLUMENTS, sum(SBSCONTRI) as SBSCONTRI, sum(t.adjsbscontri2017) sbscontri2017, sum(notational_increment) as noincrement, sum(t.ntincrement2017) as noincrement2017, sum(INTEREST) as INTEREST, sum(t.taxval_withintt) as taxval_withintt, sum(t.taxval_withoutintt) as taxval_withoutintt from sbs_yearwise_total t group by pensionno) B," +
		 		" (select sum(sbscontri) as sbscont2017to20, sum(l.notational_increment) as ntincrement2017to20, pensionno from sbs_yearwise_total l where l.year_sno > 11  group by pensionno) a where b.pensionno = a.pensionno and a.pensionno='"+pfID+"'";
		}else{
			sqlQuery="select (select region from employee_personal_info where pensionno="+pfID+") as remarks,nvl(notional_increment,0) as notational_increment,'0' as sbscontri,adj_aaiedcp_contri as adjsbscontri,gross_contri from  sbs_ob b where b.obyear='01-Apr-2021' and b.pensionno='"+pfID+"'";
		}
		
		try{
		con=DBUtils.getConnection();
		st=con.createStatement();
		System.out.println("sqlQuery=getOBList==="+sqlQuery);
		rs=st.executeQuery(sqlQuery);
		
		
	
		while (rs.next()){
			obBean=new TempPensionTransBean();
			obBean.setRemarks(rs.getString("remarks"));
			obBean.setPensionContr(rs.getString("sbscontri"));
			obBean.setNoIncrement(rs.getString("notational_increment"));
			obBean.setAdjSbsContri(rs.getString("adjsbscontri"));
		
			
			obList.add(obBean);
			
			}
		
		}catch(Exception e){
			e.printStackTrace();
			
		}finally{
			DBUtils.closeConnection(rs, st, con);
		}
		
		
		
		return obList;
	}
	public ArrayList getAdjOBList(String pfID,String finYear) {
		ArrayList obList=null;
		obList=new ArrayList();
		
		Connection con=null;
		Statement st=null;
		ResultSet rs=null;
		String sqlQuery="";
		TempPensionTransBean obBean=null;
		if(finYear.equals("2020-2021")){
			log.info("if ob adj"+finYear);
		 sqlQuery = "select b.pensionno,b.notationalincrement,b.sbscontribution,b.voluntaryedcpssub," +
		 		"b.remarks from sbs_adj_ob b where b.adjobyear='01-Apr-2020' and b.pensionno="+pfID;
		}else{
			 sqlQuery = "select b.pensionno,b.notationalincrement,b.sbscontribution,b.voluntaryedcpssub," +
		 		"b.remarks from sbs_adj_ob b where b.adjobyear='01-Apr-2021' and  b.pensionno="+pfID;	
		}
		try{
		con=DBUtils.getConnection();
		st=con.createStatement();
		rs=st.executeQuery(sqlQuery);
		
		obBean=new TempPensionTransBean();
	
		if (rs.next()){
			//obBean=new TempPensionTransBean();
			if(rs.getString("remarks")!=null){
				obBean.setRemarks(rs.getString("remarks"));	
			}else{
				obBean.setRemarks("--");		
			}
			if(rs.getString("sbscontribution")!=null){
				obBean.setPensionContr(rs.getString("sbscontribution"));
			}else{
				obBean.setPensionContr("0");
			}
			if(rs.getString("notationalincrement")!=null){
				obBean.setNoIncrement(rs.getString("notationalincrement"));
			}else{
				obBean.setNoIncrement("0");
			}
			
			if(rs.getString("voluntaryedcpssub")!=null){
				obBean.setEmpVPF(rs.getString("voluntaryedcpssub"));
			}else{
				obBean.setEmpVPF("0");
			}
			
			
		
			
			
			
			}else{
				obBean.setRemarks("");
				obBean.setPensionContr("0");
				obBean.setNoIncrement("0");	
			}
		obList.add(obBean);
		
		}catch(Exception e){
			e.printStackTrace();
			
		}finally{
			DBUtils.closeConnection(rs, st, con);
		}
		
		
		
		return obList;
	}
	public ArrayList getSBSList(String pfID,String finYear) {
		ArrayList sbsList=null;
		sbsList=new ArrayList();
		
		Connection con=null;
		Statement st=null;
		ResultSet rs=null;
		String sqlQuery="";
		int emolumentMonths=0;
		EmployeePensionCardInfo cardInfo=null;
		if(finYear.equals("2020-2021")){
			 sqlQuery = "select EMPMNTHYEAR,to_char(add_months(EMPMNTHYEAR,-1),'Mon-yyyy') as EMPMNTHYEAR1,max(a.monthyear) AS MONTHYEAR,to_char(add_months(max(a.monthyear),-1),'dd-MON-yyyy') AS MONTHYEAR1,add_months(max(EMPMNTHYEAR), -1) AS EMPMNTHYEAR1,sum(a.EMOLUMENTS) AS EMOLUMENTS,round(sum(a.EMOLUMENTS)*10/100) AS aaiedcpcontri, (case when (select o.sbs_ntincrement from employee_personal_info o where o.pensionno="+pfID+")='Y' then round(sum(a.EMOLUMENTS) * 1 / 100)  else  0  end) as notationalincrement,sum(a.EMPPFSTATUARY) AS EMPPFSTATUARY,sum(a.EMPVPF) AS EMPVPF,sum(a.EMPADVRECPRINCIPAL) AS EMPADVRECPRINCIPAL,sum(a.EMPADVRECINTEREST) AS EMPADVRECINTEREST,max(a.AIRPORTCODE) AS AIRPORTCODE,max(a.cpfaccno) AS CPFACCNO,max(a.region) as region,max(DUPFlag) as DUPFlag,sum(a.PENSIONCONTRI) as PENSIONCONTRI,max(a.DATAFREEZEFLAG) as DATAFREEZEFLAG,max(a.form7narration) as form7narration,sum(a.pcHeldAmt) as pcHeldAmt,"
				+ "sum(emolumentmonths) as emolumentmonths,max(PCCALCAPPLIED) as PCCALCAPPLIED,max(ARREARFLAG) as ARREARFLAG,max(DEPUTATIONFLAG) as DEPUTATIONFLAG,max(sbs_depflag) as sbs_depflag,max(editeddate) as editeddate,sum(a.OPCHANGEPENSIONCONTRI) as OPCHANGEPENSIONCONTRI,(SELECT EXTRACT(YEAR FROM ADD_MONTHS(empmnthyear, -4)) || '-' ||EXTRACT(YEAR FROM ADD_MONTHS(empmnthyear, 8))FROM DUAL) as finyear,max(signs) as signs from (select TO_DATE('01-' || SUBSTR(empdt.MONYEAR, 0, 3) || '-' ||SUBSTR(empdt.MONYEAR, 4, 4)) AS EMPMNTHYEAR,decode((sign(sysdate-add_months(to_date(TO_DATE('01-' || SUBSTR(empdt.MONYEAR, 0, 3) || '-' ||"
						+ "SUBSTR(empdt.MONYEAR, 4, 4))),1))),-1,0,1,1) as signs,emp.MONTHYEAR AS MONTHYEAR,"
				+ "emp.EMOLUMENTS AS EMOLUMENTS,emp.EMPPFSTATUARY AS EMPPFSTATUARY,emp.EMPVPF AS EMPVPF,emp.EMPADVRECPRINCIPAL AS EMPADVRECPRINCIPAL,emp.EMPADVRECINTEREST AS EMPADVRECINTEREST,emp.AIRPORTCODE AS AIRPORTCODE,emp.cpfaccno AS CPFACCNO,emp.region as region,'Single' DUPFlag,emp.PENSIONCONTRI as PENSIONCONTRI,emp.DATAFREEZEFLAG as DATAFREEZEFLAG,emp.form7narration as form7narration,nvl(emp.pcHeldAmt, 0) as pcHeldAmt,nvl(emp.emolumentmonths, '1') as emolumentmonths,PCCALCAPPLIED,ARREARFLAG,nvl(DEPUTATIONFLAG, 'N') AS DEPUTATIONFLAG,sbs_depflag,"
				+ "editeddate,emp.OPCHANGEPENSIONCONTRI as OPCHANGEPENSIONCONTRI from (select distinct to_char(to_date('01-May-2020', 'dd-mon-yyyy') +rownum - 1,'MONYYYY') monyear from Employee_pension_validate where empflag = 'Y'and rownum <= to_date('01-Apr-2021', 'dd-mon-yyyy') -to_date('01-May-2020', 'dd-mon-yyyy') + 1) empdt,(SELECT cpfaccno,to_char(MONTHYEAR, 'MONYYYY') empmonyear,TO_CHAR(MONTHYEAR, 'DD-MON-YYYY') AS MONTHYEAR,ROUND(EMOLUMENTS, 2) AS EMOLUMENTS,ROUND(EMPPFSTATUARY, 2) AS EMPPFSTATUARY,EMPVPF,EMPADVRECPRINCIPAL,"
				+ "EMPADVRECINTEREST,AIRPORTCODE,REGION,EMPFLAG,PENSIONCONTRI,DATAFREEZEFLAG,form7narration,pcHeldAmt,nvl(emolumentmonths, '1') as emolumentmonths,PCCALCAPPLIED,ARREARFLAG,nvl(DEPUTATIONFLAG, 'N') AS DEPUTATIONFLAG,sbs_depflag,editeddate,OPCHANGEPENSIONCONTRI FROM sbs_pension_validate WHERE empflag = 'Y'and pensionno ="
				+ pfID
				+ " AND MONTHYEAR >= TO_DATE('01-May-2020', 'DD-MON-YYYY')and empflag = 'Y' ORDER BY TO_DATE(MONTHYEAR, 'dd-Mon-yy')) emp where empdt.monyear = emp.empmonyear(+)) a where to_date(to_char(Empmnthyear, 'dd-Mon-yyyy')) >=to_date('01-May-2020') group by EMPMNTHYEAR order by EMPMNTHYEAR ";
		System.out.println("sqlQuery==2020-21=="+sqlQuery);
		}else{
			 sqlQuery = "select EMPMNTHYEAR,to_char(add_months(EMPMNTHYEAR,-1),'Mon-yyyy') as EMPMNTHYEAR1,max(a.monthyear) AS MONTHYEAR,to_char(add_months(max(a.monthyear),-1),'dd-MON-yyyy') AS MONTHYEAR1,add_months(max(EMPMNTHYEAR), -1) AS EMPMNTHYEAR1,sum(a.EMOLUMENTS) AS EMOLUMENTS,round(sum(a.EMOLUMENTS)*10/100) AS aaiedcpcontri, (case when (select o.sbs_ntincrement from employee_personal_info o where o.pensionno="+pfID+")='Y' then round(sum(a.EMOLUMENTS) * 1 / 100)  else  0  end) as notationalincrement,sum(a.EMPPFSTATUARY) AS EMPPFSTATUARY,sum(a.EMPVPF) AS EMPVPF,sum(a.EMPADVRECPRINCIPAL) AS EMPADVRECPRINCIPAL,sum(a.EMPADVRECINTEREST) AS EMPADVRECINTEREST,max(a.AIRPORTCODE) AS AIRPORTCODE,max(a.cpfaccno) AS CPFACCNO,max(a.region) as region,max(DUPFlag) as DUPFlag,sum(a.PENSIONCONTRI) as PENSIONCONTRI,max(a.DATAFREEZEFLAG) as DATAFREEZEFLAG,max(a.form7narration) as form7narration,sum(a.pcHeldAmt) as pcHeldAmt,"
				+ "sum(emolumentmonths) as emolumentmonths,max(PCCALCAPPLIED) as PCCALCAPPLIED,max(ARREARFLAG) as ARREARFLAG,max(DEPUTATIONFLAG) as DEPUTATIONFLAG,max(sbs_depflag) as sbs_depflag,max(editeddate) as editeddate,sum(a.OPCHANGEPENSIONCONTRI) as OPCHANGEPENSIONCONTRI,(SELECT EXTRACT(YEAR FROM ADD_MONTHS(empmnthyear, -4)) || '-' ||EXTRACT(YEAR FROM ADD_MONTHS(empmnthyear, 8))FROM DUAL) as finyear,max(signs) as signs from (select TO_DATE('01-' || SUBSTR(empdt.MONYEAR, 0, 3) || '-' ||SUBSTR(empdt.MONYEAR, 4, 4)) AS EMPMNTHYEAR,decode((sign(sysdate-add_months(to_date(TO_DATE('01-' || SUBSTR(empdt.MONYEAR, 0, 3) || '-' ||"
						+ "SUBSTR(empdt.MONYEAR, 4, 4))),1))),-1,0,1,1) as signs,emp.MONTHYEAR AS MONTHYEAR,"
				+ "emp.EMOLUMENTS AS EMOLUMENTS,emp.EMPPFSTATUARY AS EMPPFSTATUARY,emp.EMPVPF AS EMPVPF,emp.EMPADVRECPRINCIPAL AS EMPADVRECPRINCIPAL,emp.EMPADVRECINTEREST AS EMPADVRECINTEREST,emp.AIRPORTCODE AS AIRPORTCODE,emp.cpfaccno AS CPFACCNO,emp.region as region,'Single' DUPFlag,emp.PENSIONCONTRI as PENSIONCONTRI,emp.DATAFREEZEFLAG as DATAFREEZEFLAG,emp.form7narration as form7narration,nvl(emp.pcHeldAmt, 0) as pcHeldAmt,nvl(emp.emolumentmonths, '1') as emolumentmonths,PCCALCAPPLIED,ARREARFLAG,nvl(DEPUTATIONFLAG, 'N') AS DEPUTATIONFLAG,sbs_depflag,"
				+ "editeddate,emp.OPCHANGEPENSIONCONTRI as OPCHANGEPENSIONCONTRI from (select distinct to_char(to_date('01-May-2021', 'dd-mon-yyyy') +rownum - 1,'MONYYYY') monyear from Employee_pension_validate where empflag = 'Y'and rownum <= to_date('01-Apr-2022', 'dd-mon-yyyy') -to_date('01-May-2021', 'dd-mon-yyyy') + 1) empdt,(SELECT cpfaccno,to_char(MONTHYEAR, 'MONYYYY') empmonyear,TO_CHAR(MONTHYEAR, 'DD-MON-YYYY') AS MONTHYEAR,ROUND(EMOLUMENTS, 2) AS EMOLUMENTS,ROUND(EMPPFSTATUARY, 2) AS EMPPFSTATUARY,EMPVPF,EMPADVRECPRINCIPAL,"
				+ "EMPADVRECINTEREST,AIRPORTCODE,REGION,EMPFLAG,PENSIONCONTRI,DATAFREEZEFLAG,form7narration,pcHeldAmt,nvl(emolumentmonths, '1') as emolumentmonths,PCCALCAPPLIED,ARREARFLAG,nvl(DEPUTATIONFLAG, 'N') AS DEPUTATIONFLAG,sbs_depflag,editeddate,OPCHANGEPENSIONCONTRI FROM sbs_pension_validate WHERE empflag = 'Y'and pensionno ="
				+ pfID
				+ " AND MONTHYEAR >= TO_DATE('01-May-2021', 'DD-MON-YYYY')and empflag = 'Y' ORDER BY TO_DATE(MONTHYEAR, 'dd-Mon-yy')) emp where empdt.monyear = emp.empmonyear(+)) a where to_date(to_char(Empmnthyear, 'dd-Mon-yyyy')) >=to_date('01-May-2021') group by EMPMNTHYEAR order by EMPMNTHYEAR ";
			 System.out.println("sqlQuery==else=="+sqlQuery);
		}
		
		
		try{
		con=DBUtils.getConnection();
		st=con.createStatement();
		rs=st.executeQuery(sqlQuery);
		
		double grandAAiEDCPContri=0.0,aaiEDCPContri=0.0,notationalincrement=0.0;
	
		while (rs.next()){
			cardInfo=new EmployeePensionCardInfo();
			
			cardInfo.setMonthyear(rs.getString("EMPMNTHYEAR1"));
			
			if(rs.getString("EMOLUMENTS")!=null){
			cardInfo.setEmoluments(rs.getString("EMOLUMENTS"));
			}else{
				cardInfo.setEmoluments("0");
			}
			System.out.println("setEmoluments==else=="+cardInfo.getEmoluments());
			if(rs.getString("aaiedcpcontri")!=null){
				cardInfo.setAaiedcpContri(rs.getString("aaiedcpcontri"));
				aaiEDCPContri=Double.parseDouble(cardInfo.getAaiedcpContri());
			}else{
				aaiEDCPContri=0;
				cardInfo.setAaiedcpContri("0");
			}
			if(rs.getString("notationalincrement")!=null){
				cardInfo.setNotationaIncrement(rs.getString("notationalincrement"));
				notationalincrement=Double.parseDouble(cardInfo.getNotationaIncrement());
			}else{
				notationalincrement=0;
				cardInfo.setNotationaIncrement("0");
			}
			if(rs.getString("AIRPORTCODE")!=null){
				cardInfo.setStation("");
			}else{
				cardInfo.setStation("");
			}
			if(rs.getString("sbs_depflag")!=null){
				cardInfo.setDeputation(rs.getString("sbs_depflag"));
			}else{
				cardInfo.setDeputation("N");
			}
			
			//emolumentMonths=emolumentMonths+rs.getInt("signs");
			System.out.println("emolumentMonths==="+emolumentMonths);
			cardInfo.setEmolumentMonths(String.valueOf(rs.getInt("signs")));
			if (rs.getInt("signs") == 1) {
				
				grandAAiEDCPContri = grandAAiEDCPContri + (notationalincrement);
				
			System.out.println("grandAAiEDCPContri==="+grandAAiEDCPContri);
			cardInfo.setGrandCummulative(Double.toString(Math
					.round(grandAAiEDCPContri)));
			
			
			
		} else {
			cardInfo.setGrandCummulative(Double.toString(Math
					.round(0)));
		}
			aaiEDCPContri=0;	
			notationalincrement=0;
			
			sbsList.add(cardInfo);
			
			}
		
		}catch(Exception e){
			e.printStackTrace();
			
		}finally{
			DBUtils.closeConnection(rs, st, con);
		}
		
		
		
		return sbsList;
	}

}
