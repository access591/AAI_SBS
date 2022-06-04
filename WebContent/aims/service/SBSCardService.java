package aims.service;

import java.util.ArrayList;

import aims.dao.SBSCardDAO;

public class SBSCardService {
SBSCardDAO dao=new SBSCardDAO();
	 

	public ArrayList getSBSCard(String pensionno,String finYear) {
		
		return dao.getSBSReportCard(pensionno,finYear);
	}
public ArrayList getEmployeeWiseTotal(String pensionno,String finYear) {
		
		return dao.getEmployeeWiseTotal(pensionno,finYear);
	}
	
}
