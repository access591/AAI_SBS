package aims.service.cashbook;

import java.util.List;

import aims.bean.cashbook.BankOpenBalInfo;
import aims.common.Log;
import aims.dao.cashbook.BankMasterDAO;
import aims.dao.cashbook.BankOpenBalDAO;

public class BankOpenBalService {
		
	Log log = new Log(BankOpenBalService.class);
	BankOpenBalDAO dao = new BankOpenBalDAO();
	
	public void addOpenBalRecord(BankOpenBalInfo info) throws Exception {
		log.info("BankOpenBalService : addOpenBalRecord : Entering Method");
		dao.addOpenBalRecord(info);		
		log.info("BankOpenBalService : addOpenBalRecord : Leaving Method");		
	}

	public List searchRecords(BankOpenBalInfo info) throws Exception {
		log.info("BankOpenBalService : searchRecords : Entering Method");
		List dataList = dao.searchRecords(info);		
		log.info("BankOpenBalService : searchRecords : Leaving Method");	
		return dataList;
	}

	public void deleteBankOpenBalRecord(BankOpenBalInfo info) throws Exception {
		log.info("BankOpenBalService : deleteBankOpenBalRecord : Entering Method");
		dao.deleteBankOpenBalRecord(info);		
		log.info("BankOpenBalService : deleteBankOpenBalRecord : Leaving Method");		
	}

	public BankOpenBalInfo getRecord(BankOpenBalInfo info) throws Exception {
		log.info("BankOpenBalService : getRecord : Entering Method");
		info = dao.getRecord(info);		
		log.info("BankOpenBalService : getRecord : Leaving Method");
		return info;
	}

	public void updateOpenBalRecord(BankOpenBalInfo info) throws Exception {
		log.info("BankOpenBalService : updateOpenBalRecord : Entering Method");
		dao.updateOpenBalRecord(info);		
		log.info("BankOpenBalService : updateOpenBalRecord : Leaving Method");		
	}

}
