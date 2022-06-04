package aims.dao;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.Properties;
import java.util.Random;

import aims.bean.LoginInfo;
import aims.bean.RoleBean;
import aims.common.DBUtils;
import aims.common.Log;
import aims.common.SBSException;
import aims.common.StringUtility;
import aims.service.MailService;


public class LoginDAO {
	Properties prop=null;			
	
	Log log = new Log(LoginDAO.class);
	private static LoginDAO loginDaoInstance = new LoginDAO();
	public static LoginDAO getInstance() {
		return loginDaoInstance;
	}
	public LoginInfo loginValidation(String userId,String password,String loginType) throws Exception{		
		LoginInfo validUser = null;
		Connection connection=null;
		Statement statement=null;
		ResultSet resultSet=null;
		ArrayList accessRightsList = new ArrayList();
		String privilageStage="";
		String condition="";
		if(loginType.equals("M")){
			condition=" and usr.profile='M'";
		}else{
			condition=" and usr.profile!='M'";
		}
		try{
			connection = DBUtils.getConnection();	
			if(connection!=null){
				statement=connection.createStatement();
				if(statement!=null){			
						
						String selectQuery="select usr.USERNAME, USERID, nvl(EMPLOYEENO,'')EMPLOYEENO, nvl(EMAILID,'')EMAILID, PASSWORD,nvl(UNITCD,'')UNITCD,nvl(MODULES,' ')MODULES, nvl(USERTYPE,'') USERTYPE, nvl(PROFILE,'') PROFILE,to_char(EXPIREDATE,'dd/Mon/YYYY') EXPIREDATE, to_char(CREATEDON,'dd/Mon/YYYY') CREATEDON, nvl(GRIDLENGTH,10) GRIDLENGTH, nvl(DELETEFLAG,'N') DELETEFLAG,nvl( PASSWORDCHANGEFLAG,'N') PASSWORDCHANGEFLAG, nvl(STATUS,'Y') STATUS ,nvl(unitname,'') unitname,nvl(region,'') region,unittype,NVL(PENSIONNO,0) pensionno ,nvl(displayname,'') displayname, nvl(DESIGNATION,'') DESIGNATION, nvl(ADVACCTYPE,'') as ACCOUNTTYPE,nvl((select o.sbsflag from employee_personal_info o where pensionno=usr.pensionno),'N') as sbsOPtion,nvl((select 'Y' from employee_personal_info o where pensionno = usr.pensionno and (o.dateofseperation_date is not null or months_between(add_months(o.dateofbirth, 720), sysdate) <= 3)),'N') as enableAnnuityoption from epis_user usr , employee_unit_master unit where usr.unitcd=unit.unitcode(+) and PASSWORD=encrypt(nvl('"+password+"',' ')) and usr.USERNAME='"+userId+"' and DELETEFLAG='N' and STATUS='Y' and usertype='SBSUser' "+condition;
								//"and (profile='S' or profile='M' or profile='"+loginType+"' or profile='A')";
						log.info("LoginDao:loginValidation:selectQuery:"+selectQuery);
						resultSet =statement.executeQuery(selectQuery);			
						if(resultSet.next()){
							validUser=new LoginInfo();
							validUser.setEnableAnnuityOption(resultSet.getString("enableAnnuityoption"));
							validUser.setSbsOption(resultSet.getString("sbsOPtion"));
							validUser.setUserName(resultSet.getString("USERNAME"));
							validUser.setUserId(resultSet.getString("USERID"));
							validUser.setEmployeeNo(resultSet.getString("EMPLOYEENO"));
							validUser.setEmailId(resultSet.getString("EMAILID"));
							validUser.setPassword(resultSet.getString("PASSWORD"));
							validUser.setUnitCd(resultSet.getString("UNITCD"));
							validUser.setModules(resultSet.getString("MODULES"));
							validUser.setUserType(resultSet.getString("USERTYPE"));
							validUser.setProfile(resultSet.getString("PROFILE"));
							validUser.setExpiredOn(resultSet.getString("EXPIREDATE"));
							validUser.setCreatedOn(resultSet.getString("CREATEDON"));
							validUser.setGridLength(resultSet.getInt("GRIDLENGTH"));							
							validUser.setUnitName(resultSet.getString("unitname"));
							validUser.setUnitType(resultSet.getString("unittype"));
							validUser.setPensionNo(resultSet.getString("pensionno"));
							validUser.setRegion(resultSet.getString("region"));
							validUser.setAccountType(resultSet.getString("ACCOUNTTYPE"));
							validUser.setDeleted("Y".equals(resultSet.getString("DELETEFLAG"))?true:false);
							validUser.setPasswordChanged("Y".equals(resultSet.getString("PASSWORDCHANGEFLAG"))?true:false);
							validUser.setActive("Y".equals(resultSet.getString("STATUS"))?true:false);
							validUser.setDisplayName(resultSet.getString("displayname"));
							//if("ROLE".equals(Configurations.getAccessRightsType())){
							if("ROLE".equals("SBSUser")){
								RoleBean role=rolebasedModules(userId);
								validUser.setRoleCd(StringUtility.checknull( role.getRoleCd()));
								validUser.setRoleName(StringUtility.checknull(role.getRoleName()));
								validUser.setModules(StringUtility.checknull(role.getModules()));
							}
							validUser.setDesignation(resultSet.getString("DESIGNATION"));
							
							accessRightsList = this.getUserAccessRights(connection,userId);
							LoginInfo accessBean = null;
							String priv_Stage_Initial="",priv_Stage_Rec="",priv_Stage_Appr="";
							if(accessRightsList.size()>0){
							for(int i=0;i<accessRightsList.size();i++){
								accessBean =(LoginInfo)accessRightsList.get(i);
								if(accessBean.getScreenCode().equals("LA0204")) {
									priv_Stage_Initial ="true";
								}else if(accessBean.getScreenCode().equals("LA0801")){
									priv_Stage_Rec ="true";
								}else if (accessBean.getScreenCode().equals("LA0301")){
									priv_Stage_Appr ="true";
								}else{
									privilageStage ="Nothing";
								}
							}
							
							 
							if(priv_Stage_Initial.equals("true")){
								privilageStage ="Initial";
							}
							if(priv_Stage_Rec.equals("true")){
								privilageStage = "Recommendation";
							}
							if(priv_Stage_Appr.equals("true")){
								privilageStage = "Approval";
							}
							if(priv_Stage_Initial.equals("true") && priv_Stage_Rec.equals("true") && priv_Stage_Appr.equals("true")){
								privilageStage="All";
							} 
							validUser.setPrivilageStage(privilageStage);
							log.info("=======validUser=========="+privilageStage);
							}
						
						}
			
				}
			
				
			}
		}catch(Exception exp){
			log.error(exp.getMessage());
			throw exp;
		}finally {
			DBUtils.closeConnection(resultSet,statement,connection);
		}
		return validUser;	
	}
	public void changePassword(LoginInfo loginInfo) throws SBSException{
		try{
			String oldPassword=loginInfo.getOldPassword();
			String newPassword=loginInfo.getNewPassword();			
			String userId=loginInfo.getUserId();		
			String getdates="update epis_user set PASSWORD=encrypt('"+newPassword+"'), PASSWORDCHANGEFLAG='Y' where PASSWORD=encrypt('"+oldPassword+"') and USERNAME='"+userId+"' ";
		    
			int trans=DBUtils.executeUpdate(getdates);
			if(trans==0)
				throw  new SBSException("PLease Enter Old Password Correctly");
			}
		catch(SBSException exp){
			log.error(exp.getMessage());
			throw  exp;
			
		}catch(Exception exp){
			log.error(exp.getMessage());
			throw  new SBSException(exp);
			
		}
		
	}



private RoleBean rolebasedModules(String userId) throws Exception{		
	
	Connection connection=null;
	Statement statement=null;
	ResultSet resultSet=null;
	RoleBean role=new RoleBean();
	try{
		connection = DBUtils.getConnection();	
		if(connection!=null){
			statement=connection.createStatement();
			if(statement!=null){			
						
				String roleQuery="select nvl(rolecd,' ') rolecd,nvl(rolename,' ') rolename,nvl(modules,' ') modules from epis_role where rolecd=(select rolecd from epis_user where username='"+userId+"') ";
				log.info("LoginDao:loginValidation:roleQuery:"+roleQuery);
				resultSet =statement.executeQuery(roleQuery);			
					if(resultSet.next()){
						role.setRoleCd(resultSet.getString("rolecd"));
						role.setRoleName(resultSet.getString("rolename"));
						role.setModules(resultSet.getString("modules"));
					}
		
			}
				
			
		}
	}catch(Exception exp){
		log.error(exp.getMessage());
		throw exp;
	}finally {
		DBUtils.closeConnection(resultSet,statement,connection);
	}
	return role;
}
public ArrayList getUserAccessRights(Connection con,String userId) throws SBSException {
	ArrayList accessRightsList = new ArrayList(); 
	Statement st = null;
	ResultSet rs = null;
	LoginInfo validUser = null;
	try { 
		st = con.createStatement();	
		String getUserAccessRights="" ; 
		 
		  getUserAccessRights=" select code.screencode as screencode from epis_accesscodes_mt code,epis_accessrights right where  code.screencode like 'LA%'"
			  					+" and code.screencode = right.screencode  and  right.userid ='"+userId+"'" ;
			  							//" and right.screencode in('LA0101','LA0702','LA0204','LA0801','LA0301')";
		log.info("LoginDao::getUserAccessRights()===="+getUserAccessRights);
		rs = st.executeQuery(getUserAccessRights);			
		while(rs.next()){
			validUser = new LoginInfo();
			if(rs.getString("screencode")!=null){
				validUser.setScreenCode(rs.getString("screencode"));
			}else{
				validUser.setScreenCode("");
			}
							 
			accessRightsList.add(validUser); 
		} 
		
	}catch (Exception e) {
		log.printStackTrace(e);
		throw new SBSException(e);
	}finally{
		DBUtils.closeConnection(null,st,rs);
	}
	return accessRightsList;
}
public String forgotpassword(String userName,String doj) {
	String message="";
	log.info("-------fogot-------");
	Connection con=null;
	Statement stmt = null;
	ResultSet rs=null;
	String query="";
	String emailid="";
	query="select username,(select emailid from employee_personal_info where pensionno=u.username  and dateofjoining='"+doj+"' and sbsflag='Y' ) as emailid from epis_user u where usertype='SBSUser' and profile='M'  and username='"+userName+"'";
	try{
		con=DBUtils.getConnection();
		con.setAutoCommit(false);
		stmt=con.createStatement();
		rs=stmt.executeQuery(query);
		if(rs.next()){
			if(rs.getString("emailid")!=null){
				emailid=rs.getString("emailid");
			}else{
				emailid="";
			}
			if(emailid.equals("")){
				message="Email Id not mapped this User. Please contact epissupport@navayuga.com ";
			}
			Random rnd = new Random(); 
			int ran = 100000 + rnd. nextInt(900000);
			
			
			int reccount=stmt.executeUpdate("update epis_user u set u.password=encrypt('"+ran+"'),passwordchangeflag='N' where usertype='SBSUser' and profile='M' and username='"+userName+"'");
			if(reccount<1){
				message ="Mail not deliverd to your Email Id, Please Contact to epissupport@navayuga.com";
			}else{
			MailService mservice=new MailService();
			String mailstatus=mservice.sendMailString(emailid, ran);
			//mailstatus="N";
			//nochanges
			log.info("mailstatus:"+mailstatus);
			if(mailstatus.equals("Y")){
				
				con.commit();
				message="Password has been sent sucessfully to your MailId";
				
			}else{
				message ="Mail not deliverd to your Email Id, Please Contact to epissupport@navayuga.com";
				con.rollback();
				
			}
			}		
			
		}else{
			message="In valid User Name or Date of Joining";	
		}
		
	}catch(Exception e){
		e.printStackTrace();
		try{con.rollback();}
		catch(Exception e1){
			e1.printStackTrace();
		}
	}
	
	
	return message;
}


}