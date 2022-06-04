package ajeet.test;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import aims.common.DBUtils;

public class AjeetTest {

	public Statement getConnection() {
		
		Connection con = null;
		Statement st = null;
		try {		
			con = DBUtils.getConnection();
			st = con.createStatement();
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return st;
	}
	
	public static void main(String[] args) {
		new AjeetTest().checkQuery();

	}
	
	public void checkQuery() {
		String query = "select s.pensionno,(select o.newempcode from employee_personal_info o where o.pensionno=s.pensionno) as newempcode,"
				+ "(select p.policyno from sbs_policydoc p where p.pensionno = s.pensionno) as policyno,"
				+ "(select to_char(p.policydate,'dd-Mon-yyyy') from sbs_policydoc p where p.pensionno = s.pensionno) as policystartdate,"
				+ "(select p.policyamt from sbs_policydoc p where p.pensionno = s.pensionno) as pensionamt,"
				+ "s.membername,s.form_type,s.region,s.airport,s.edcpcorpusamt+s.edcpcorpusint as edcpcorpusamt,to_char(t.transdate,'dd-MM-yyyy')as settlementdate,"
				+ "to_char(t.transdate, 'Mon') as settlementmonth, to_char(t.transdate, 'YYYY') as settlemenYear,  "
				+ "(select distinct (case when ((transdate >= to_date('01/Apr/' || to_char(transdate, 'YYYY'),'dd/Mon/yyyy')) and "
				+ "(transdate <= to_date('31/Mar/' ||(to_number(to_char(transdate, 'YYYY')) + 1),'dd/Mon/yyyy'))) then "
				+ "(to_char(transdate, 'YYYY') || '-' ||(to_number(to_char(transdate, 'YYYY')) + 1)) when ((transdate >= to_date('01/Apr/' ||(to_number(to_char(transdate, 'YYYY')) - 1), "
				+ "'dd/Mon/yyyy')) and (transdate <= to_date('31/Mar/' || to_char(transdate, 'YYYY'), 'dd/Mon/yyyy'))) then "
				+ "((to_number(to_char(transdate, 'YYYY')) - 1) || '-' || to_char(transdate, 'YYYY')) end) from sbs_annuity_transations"
				+ " where  trim(transdate) = (select distinct trim(max(to_date(transdate, 'dd-m-yyyy HH:MI:SS'))) from sbs_annuity_transations where appid = t.appid)  and appid=t.appid )as finyear,"
				+ "s.modeofpayment,decode(s.aaiedcpsoption,'A','Life Annuity','B','Life Annuity With Return Of Purchase Price','C','Joint Life Annuity','D','Joint Life Annuity with Return of Purchase Price','E','Refund Application (fifth option)') as aaiedcpsoptiondesc,"
				+ "round(((s.edcpcorpusamt+s.edcpcorpusint)/1.018)*0.018,0) gst from sbs_annuity_forms s,sbs_annuity_transations t "
				+ "where s.appid=t.appid and t.approvedby='EDCPapprove3'  and to_date(to_char(t.transdate,'dd-Mon-yyyy'))>='01-Jan-2021' AND to_date(to_char(t.transdate,'dd-Mon-yyyy'))<='31-Mar-2021' "
				+ "AND REGION ='West Region' AND to_char(t.transdate, 'Mon') ='Mar' AND to_char(t.transdate, 'yyyy') ='2021' AND t.transdate between '01-Apr-2020' and '31-Mar-2021' "
				+ "AND AIRPORT ='MUMBAI'  ORDER BY pensionno ASC";
		
		String query1 = "select s.pensionno,(select o.newempcode from employee_personal_info o where o.pensionno=s.pensionno) as newempcode,"
				+ "(select p.policyno from sbs_policydoc p where p.pensionno = s.pensionno) as policyno,"
				+ "(select to_char(p.policydate,'dd-Mon-yyyy') from sbs_policydoc p where p.pensionno = s.pensionno) as policystartdate,"
				+ "(select p.policyamt from sbs_policydoc p where p.pensionno = s.pensionno) as pensionamt,"
				+ "s.membername,s.form_type,s.region,s.airport,s.edcpcorpusamt+s.edcpcorpusint as edcpcorpusamt,to_char(t.transdate,'dd-MM-yyyy')as settlementdate,"
				+ "to_char(t.transdate, 'Mon') as settlementmonth, to_char(t.transdate, 'YYYY') as settlemenYear,  "
				+ "(select distinct (case when ((transdate >= to_date('01/Apr/' || to_char(transdate, 'YYYY'),'dd/Mon/yyyy')) and "
				+ "(transdate <= to_date('31/Mar/' ||(to_number(to_char(transdate, 'YYYY')) + 1),'dd/Mon/yyyy'))) then "
				+ "(to_char(transdate, 'YYYY') || '-' ||(to_number(to_char(transdate, 'YYYY')) + 1)) when ((transdate >= to_date('01/Apr/' ||(to_number(to_char(transdate, 'YYYY')) - 1), "
				+ "'dd/Mon/yyyy')) and (transdate <= to_date('31/Mar/' || to_char(transdate, 'YYYY'), 'dd/Mon/yyyy'))) then "
				+ "((to_number(to_char(transdate, 'YYYY')) - 1) || '-' || to_char(transdate, 'YYYY')) end) from sbs_annuity_transations"
				+ " where  trim(transdate) = (select distinct trim(max(to_date(transdate, 'dd-mm-yyyy HH:MI:SS'))) from sbs_annuity_transations where appid = t.appid)  and appid=t.appid )as finyear,"
				+ "s.modeofpayment,decode(s.aaiedcpsoption,'A','Life Annuity','B','Life Annuity With Return Of Purchase Price','C','Joint Life Annuity','D','Joint Life Annuity with Return of Purchase Price','E','Refund Application (fifth option)') as aaiedcpsoptiondesc,"
				+ "round(((s.edcpcorpusamt+s.edcpcorpusint)/1.018)*0.018,0) gst from sbs_annuity_forms s,sbs_annuity_transations t ";
		try {
			ResultSet rs = getConnection().executeQuery(query1);
			
			while(rs.next()) {
				System.out.println("Result ::: "+rs.getString(1));
			}
		} catch (SQLException e) {
			
			e.printStackTrace();
		}
	}

}
