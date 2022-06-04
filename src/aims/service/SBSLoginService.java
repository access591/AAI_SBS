package aims.service;

import aims.bean.LoginInfo;
import aims.common.SBSException;
import aims.dao.LoginDAO;



public class SBSLoginService {
	
	private SBSLoginService(){
		
	}
	private static SBSLoginService loginServiceInstance=new SBSLoginService();
	public static SBSLoginService getInstance(){
		return loginServiceInstance;
	}
	public LoginInfo loginValidation(String userId,String password,String loginType) throws Exception {
		return LoginDAO.getInstance().loginValidation(userId,password,loginType);
	}
	public void changePassword(LoginInfo loginInfo)throws SBSException{
		LoginDAO.getInstance().changePassword(loginInfo);
	}
	public String forgotpassword(String userName,String doj)throws Exception {
		return LoginDAO.getInstance().forgotpassword(userName,doj);
	}

}
