package aims.action;

import java.io.DataInputStream;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.FileInputStream;
import java.io.PrintWriter;
import java.util.StringTokenizer;
import java.text.DateFormat;
import java.text.DecimalFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
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

import aims.bean.PensionBean;
import aims.bean.PensionContBean;
import aims.bean.EmpMasterBean;
import aims.bean.EmployeePensionCardInfo;
import aims.bean.TempPensionTransBean;


import aims.bean.EmployeePersonalInfo;
import aims.bean.LicBean;
import aims.bean.LoginInfo;
import aims.common.CommonUtil;
import aims.common.SBSException;
import aims.service.SBSAnnuityService;
import aims.service.SBSCardService;

import com.sun.tools.javac.util.Log;

public class SBSAnnuityServlet extends HttpServlet {
	
	
	SBSAnnuityService annuityService=new SBSAnnuityService();
	SBSCardService service=new SBSCardService();
	
	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		this.doPost(request, response);
	}

	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		
		RequestDispatcher rd = null;
		EmployeePersonalInfo empPerinfo=null;
		
		System.out.println("method===="+request.getParameter("method"));
		if (request.getParameter("method") != null
				&& request.getParameter("method").equals("getAirports")) {
			System.out.println("method==inside=="+request.getParameter("method"));
			String region = "";
			region = request.getParameter("region");
			System.out.println("region==inside=="+region);
			CommonUtil commonUtil = new CommonUtil();
			ArrayList ServiceType = null;
			ServiceType = commonUtil.sbsairports(region);
			StringBuffer sb = new StringBuffer();
			sb.append("<ServiceTypes>");

			for (int i = 0; ServiceType != null && i < ServiceType.size(); i++) {
				String name = "",unitcode="";
				EmpMasterBean bean = (EmpMasterBean) ServiceType.get(i);
				sb.append("<ServiceType>");
				sb.append("<airPortName>");
				if (bean.getStation() != null)
					name = bean.getStation().replaceAll("<", "&lt;")
							.replaceAll(">", "&gt;");
				sb.append(name);
				sb.append("</airPortName>");
				sb.append("<airPortCode>");
				if (bean.getStation() != null)
					unitcode = bean.getUnitCode().replaceAll("<", "&lt;")
							.replaceAll(">", "&gt;");
				sb.append(name);
				sb.append("</airPortCode>");
				sb.append("</ServiceType>");
			}
			sb.append("</ServiceTypes>");
			response.setContentType("text/xml");
			PrintWriter out = response.getWriter();
			//System.out.println(sb.toString());
			out.write(sb.toString());
		}else if (request.getParameter("method") != null
				&& request.getParameter("method").equals("getForms")) {
			
			String menu=request.getParameter("menu")!=null?request.getParameter("menu"):"";
			LoginInfo userinfo= (LoginInfo)request.getSession(false).getAttribute("user");
			LicBean bean=null;
			if(userinfo.getProfile().equals("M")){
				empPerinfo=annuityService.getPersonalInfo(userinfo.getPensionNo());
				 bean=annuityService.getAnniutyFormDraft(userinfo.getPensionNo(),"LIC");
			}
			request.setAttribute("empInfo", empPerinfo);
			request.setAttribute("licBean", bean);
			//request.setAttribute("nomineelist", bean.getNomineeList().equals(null)?new ArrayList():bean.getNomineeList());
			//request.setAttribute("nomineeAppointeelist", bean.getNomineeAppointeeList().equals(null)?new ArrayList():bean.getNomineeAppointeeList());

			rd = request.getRequestDispatcher("./PensionView/SBS/AnnuityForms.jsp?menu="+menu);
			rd.forward(request, response);
		}else if(request.getParameter("method") != null
				&& request.getParameter("method").equals("loadCorpus")){
			String menu=request.getParameter("menu")!=null?request.getParameter("menu"):"";
			
			String intcalcdate=request.getParameter("intcalcdate")!=null?request.getParameter("intcalcdate"):"";
			
			ArrayList list=new ArrayList();
			String pensionno=request.getParameter("pfId")!=null?request.getParameter("pfId"):"";
			int n=annuityService.getUpdate(pensionno,intcalcdate);
			String finYear=request.getParameter("finyear")!=null?request.getParameter("finyear"):"";
			System.out.print(pensionno+"::::pensionno"+finYear);
			list = service.getSBSCard(pensionno,finYear);
			
			//================================================
			
			  PensionContBean empBean=null;
			  
			  DecimalFormat df = new DecimalFormat("#########0");
			 
			  ArrayList pensionList=new ArrayList();
			  ArrayList obList=new ArrayList();
			  ArrayList adjobList=new ArrayList();
			 
			  
			    int sbsContriGrandTot=0,sbsNotationalGrandTot=0,sbsadjAAIEDCPGrandTot=0;
			    String intAdjCorpus="",intGrossCorpus="",obBalance="";
			   for(int i=0;i<list.size();i++){
			   
			   empBean=(PensionContBean)list.get(i);
			   pensionList=empBean.getEmpPensionList();
			   obList=empBean.getObList();
			   adjobList=empBean.getAdjOBList();
			   
			   
			   
									String obSbsContri="0",obNotational="0",obAdjSBSContri="0";
									TempPensionTransBean obBean=null;
										
										obBean=(TempPensionTransBean)obList.get(0);
										obSbsContri=obBean.getPensionContr();
										obNotational=obBean.getNoIncrement();
										obAdjSBSContri=obBean.getAdjSbsContri();
										
										
										
										String adjobSbsContri="0",adjobNotational="0",adjobAdjSBSContri="0";
										 String intMonth="";
										TempPensionTransBean adjobBean=null;
											adjobBean=new TempPensionTransBean();
											
											adjobBean=(TempPensionTransBean)adjobList.get(0);
											adjobSbsContri=adjobBean.getPensionContr();
											adjobNotational=adjobBean.getNoIncrement();
											adjobAdjSBSContri=adjobBean.getAdjSbsContri();			 
								
										
							
									
									int emolumentsTotal=0,aaiedcpTotal=0,notationalTotal=0,adjAAIEDCPTotal=0;
									double cumilativeTotal=0.0;
									
									if(pensionList.size()>0){
									for(int k=0;k<pensionList.size();k++){
									EmployeePensionCardInfo cardInfo =(EmployeePensionCardInfo)pensionList.get(k);
									
									emolumentsTotal=emolumentsTotal+Integer.parseInt(cardInfo.getEmoluments());
									aaiedcpTotal=aaiedcpTotal+Integer.parseInt(cardInfo.getAaiedcpContri());
									notationalTotal=notationalTotal+Integer.parseInt(cardInfo.getNotationaIncrement());
									adjAAIEDCPTotal=adjAAIEDCPTotal+Integer.parseInt(cardInfo.getAaiedcpContri())-Integer.parseInt(cardInfo.getNotationaIncrement());
									cumilativeTotal=cumilativeTotal+Double.parseDouble(cardInfo.getGrandCummulative());
									 
									 
									 }
									 
									 
									 
							
								
									
									
									 sbsContriGrandTot=sbsContriGrandTot+(aaiedcpTotal+Integer.parseInt(obSbsContri));
									  sbsadjAAIEDCPGrandTot=sbsadjAAIEDCPGrandTot+(adjAAIEDCPTotal+Integer.parseInt(obAdjSBSContri));
									   sbsNotationalGrandTot=sbsNotationalGrandTot+(notationalTotal+Integer.parseInt(obNotational));
									   
									 
									 
									 
									   double obInt=0.0,obintInt=0.0,cumilativeint=0.0;
									 double OBInt=Math.round((Double.parseDouble(obAdjSBSContri)-Double.parseDouble(adjobNotational)+Double.parseDouble(adjobSbsContri))*(0.07431));
									 OBInt=0;
									 double rateOfInt=6.431;
									 int intMonths=empBean.getNoOfMonths();
									 obInt=(Double.parseDouble(obAdjSBSContri)-Double.parseDouble(adjobNotational)+Double.parseDouble(adjobSbsContri))*rateOfInt/100*intMonths/12;
									 //obintInt=(Double.parseDouble(obAdjSBSContri)-Double.parseDouble(adjobNotational)+Double.parseDouble(adjobSbsContri))*(0.07431)*rateOfInt/100*intMonths/12;
									 if(pensionno.equals("3185")){
									 cumilativeint=cumilativeTotal*rateOfInt/100*(intMonths+1)/12;
									 }else{
				                     cumilativeint=cumilativeTotal*rateOfInt/100*intMonths/12;
									 }
									
									 
									 obBalance=df.format(Double.parseDouble(obAdjSBSContri)-Double.parseDouble(adjobNotational)+Double.parseDouble(adjobSbsContri)+OBInt);
									
									 intAdjCorpus=df.format(obInt+obintInt+cumilativeint) ;
									 intGrossCorpus=df.format(obInt+obintInt+cumilativeint);
								
									}			
								
			//=====================================================
			
			   }
			System.out.println("obBalance"+obBalance);
			   request.setAttribute("corpusamt", obBalance);
			   request.setAttribute("corpusintamt", intGrossCorpus);
			   request.setAttribute("intDate", intcalcdate);
			
			   String appId=request.getParameter("appid")!=null?request.getParameter("appid"):"";
				LicBean bean=annuityService.getAnniutyForm(appId);
				request.setAttribute("licBean", bean);
				rd = request.getRequestDispatcher("./PensionView/SBS/EDCPAnnuityApproveForm.jsp?menu="+menu);
				rd.forward(request, response);
		}
		else if(request.getParameter("method") != null
				&& request.getParameter("method").equals("annuityReport")){
			String menu=request.getParameter("menu")!=null?request.getParameter("menu"):"";
			String appId=request.getParameter("appid")!=null?request.getParameter("appid"):"";
			String approveLevel=request.getParameter("ApproveLevel")!=null?request.getParameter("ApproveLevel"):"";
			LicBean bean=annuityService.getAnniutyForm(appId);
			request.setAttribute("licBean", bean);
			request.setAttribute("approveLevel", approveLevel);
			if(approveLevel.equals("HRLevel1")){
			rd = request.getRequestDispatcher("./PensionView/SBS/AnnuityReport.jsp?menu="+menu);
			}else if(approveLevel.equals("HRLevel2")){
				rd = request.getRequestDispatcher("./PensionView/SBS/AnnuityReport2.jsp?menu="+menu);
			}else if(approveLevel.equals("Finance")){
				rd = request.getRequestDispatcher("./PensionView/SBS/AnnuityReport3.jsp?menu="+menu);
			}
			else if(approveLevel.equals("RHQHR")){
				rd = request.getRequestDispatcher("./PensionView/SBS/AnnuityReport4.jsp?menu="+menu);
			}
			else if(approveLevel.equals("RHQFin") ){
				rd = request.getRequestDispatcher("./PensionView/SBS/RHQFinAnnuityReport.jsp?menu="+menu);
			}else if(approveLevel.equals("chqHr")){
				rd = request.getRequestDispatcher("./PensionView/SBS/CHQHrAnnuityReport.jsp?menu="+menu);
			}
			else if(approveLevel.equals("edcpapprove1")){
				rd = request.getRequestDispatcher("./PensionView/SBS/EdcpApproveReport1.jsp?menu="+menu);
			}else if(approveLevel.equals("edcpapprove2")){
				rd = request.getRequestDispatcher("./PensionView/SBS/EdcpApproveReport2.jsp?menu="+menu);
			}else if(approveLevel.equals("edcpapprove3")){
				rd = request.getRequestDispatcher("./PensionView/SBS/EdcpApproveReport3.jsp?menu="+menu);
			}else if(approveLevel.equals("coveringletter")){
				rd = request.getRequestDispatcher("./PensionView/SBS/CoveringLetterReport.jsp?menu="+menu);
			}
			rd.forward(request, response);
		}
		else if(request.getParameter("method") != null
				&& request.getParameter("method").equals("annuityReportDownload")){
			String menu=request.getParameter("menu")!=null?request.getParameter("menu"):"";			
			String appId=request.getParameter("appid")!=null?request.getParameter("appid"):"";			
			LicBean bean=annuityService.getAnniutyForm(appId);
			request.setAttribute("licBean", bean);			
			if(bean.getFormType().equals("LIC")){
			rd = request.getRequestDispatcher("./PensionView/SBS/AnnuityReportDownload.jsp?menu="+menu);
			}else if(bean.getFormType().equals("SBI")){
				rd = request.getRequestDispatcher("./PensionView/SBS/SBIAnnuityReportDownload.jsp?menu="+menu);
			}else if(bean.getFormType().equals("HDFC")){
				rd = request.getRequestDispatcher("./PensionView/SBS/HDFCAnnuityReportDownload.jsp?menu="+menu);
			}else if(bean.getFormType().equals("BAJAJ")){
				rd = request.getRequestDispatcher("./PensionView/SBS/BAJAJAnnuityReportDownload.jsp?menu="+menu);
			}else if(bean.getFormType().equals("RCForm")) {
				rd = request.getRequestDispatcher("./PensionView/SBS/RCFORMAnnuityReportDownload.jsp?menu="+menu);
			}
			rd.forward(request, response);
		}
		
		else if(request.getParameter("method") != null
				&& request.getParameter("method").equals("Approve1")){
			System.out.println("Approve1::Servlet::1");
			String transCd="11",transDescreption="HR Level1 Approval";
			String menu=request.getParameter("menu").toString()!=null?request.getParameter("menu").toString():"";
			String appId=request.getParameter("appid").toString()!=null?request.getParameter("appid").toString():"";
			String remarks=request.getParameter("remarks").toString()!=null?request.getParameter("remarks").toString():"";
			String approveStatus=request.getParameter("approveStatus").toString()!=null?request.getParameter("approveStatus").toString():"";
			String rejectedRemarks=request.getParameter("rejectedremarks").toString()!=null?request.getParameter("rejectedremarks").toString():"";
			String rejectedType=request.getParameter("rejectedtype").toString()!=null?request.getParameter("rejectedtype").toString():"";
			
			String claimForm=request.getParameter("claimform")!=null?request.getParameter("claimform"):"";
			System.out.println("claimForm:::"+claimForm);
			claimForm=claimForm.equals("on")?"Y":"Y";
			String identityCard=request.getParameter("identitycard")!=null?request.getParameter("identitycard"):"";
			identityCard=identityCard.equals("on")?"Y":"Y";
			String paySlip=request.getParameter("payslip")!=null?request.getParameter("payslip"):"";
			paySlip=paySlip.equals("on")?"Y":"Y";
			String panCard=request.getParameter("pancard")!=null?request.getParameter("pancard"):"";
			panCard=panCard.equals("on")?"Y":"Y";
			String adharCard=request.getParameter("adharcard")!=null?request.getParameter("adharcard"):"";
			adharCard=adharCard.equals("on")?"Y":"Y";
			String cancelCheque=request.getParameter("cancelcheque")!=null?request.getParameter("cancelcheque"):"";
			cancelCheque=cancelCheque.equals("on")?"Y":"Y";
			String photograph=request.getParameter("photograph")!=null?request.getParameter("photograph"):"";
			photograph=photograph.equals("on")?"Y":"Y";
			System.out.println("deceasedemployeerequest==="+request.getParameter("deceasedemployee"));
			String deceasedemployee=request.getParameter("deceasedemployee")!=null?request.getParameter("deceasedemployee"):"";
			System.out.println("deceasedemployee==="+deceasedemployee);
			if(deceasedemployee.equals("on")) {
			deceasedemployee="Y";
			}else{
			deceasedemployee="N";	
			}
			
			String nominationdoc=request.getParameter("nominationdoc")!=null?request.getParameter("nominationdoc"):"";
			System.out.println("nominationdoc==="+nominationdoc);
			if(nominationdoc.equals("on")) {
				nominationdoc="Y";
				}else{
				nominationdoc="N";	
				}
			
			
			String nomineeproof=request.getParameter("nomineeproof")!=null?request.getParameter("nomineeproof"):"";
			System.out.println("nomineeproof==="+nomineeproof);
			if(nomineeproof.equals("on")) {
				nomineeproof="Y";
				}else{
				nomineeproof="N";	
				}
			
			/*String fileName="";
			if (request.getParameter("fileName") != null) {
				fileName = request.getParameter("fileName");
			}
			 	String contentType = request.getContentType();

					System.out.println("Content type is :: " + contentType);
					String saveFile = "", dir = "", file = "", filePath = "", slashsuffix = "";
					int start = 0, end = 0;

					ResourceBundle appbundle = ResourceBundle
							.getBundle("aims.resource.ApplicationResouces");
					//slashsuffix = appbundle
							//.getString("upload.folder.path.sbs");
					String folderPath = appbundle
							.getString("upload.folder.path.sbs");

					File filePath1 = new File(folderPath);
					if (!filePath1.exists()) {
						filePath1.mkdirs();
					}

					if ((contentType != null)
							&& (contentType.indexOf("multipart/form-data") >= 0)) {

						DataInputStream in = new DataInputStream(request
								.getInputStream());

						int formDataLength = request.getContentLength();

						byte dataBytes[] = new byte[formDataLength];
						int byteRead = 0;
						int totalBytesRead = 0;
						while (totalBytesRead < formDataLength) {
							byteRead = in.read(dataBytes, totalBytesRead,
									formDataLength);
							// log.info("byteRead"+byteRead);
							totalBytesRead += byteRead;
						}
						file = new String(dataBytes);
						// start = file.indexOf("filename=\"")+10;
						start = file.indexOf("filename=\"") + 10;
						System.out.println("=start=" + start);
						end = file.indexOf(".pdf");
						System.out.println("=end=" + end);

						if (file.indexOf(".mdb") != -1) {
							end = file.indexOf(".mdb");
							System.out.println("=end=" + end);
						}

						file = new String(dataBytes);
						saveFile = file
								.substring(file.indexOf("filename=\"") + 10);
						saveFile = saveFile
								.substring(0, saveFile.indexOf("\n"));
						saveFile = saveFile.substring(saveFile
								.lastIndexOf("\\") + 1, saveFile.indexOf("\""));
						// we are added datetime as suffix in the file name

						System.out.println("File Name" + saveFile);
						saveFile=appId+".pdf";
						int lastIndex = contentType.lastIndexOf("=");
						String boundary = contentType.substring(lastIndex + 1,
								contentType.length());
						// out.println(boundary);
						int pos;
						pos = file.indexOf("filename=\"");
						pos = file.indexOf("\n", pos) + 1;
						pos = file.indexOf("\n", pos) + 1;
						pos = file.indexOf("\n", pos) + 1;

						System.out.println("lastIndex==" + lastIndex + "=boundary="
								+ boundary + "pose" + pos);

						int boundaryLocation = file.indexOf(boundary, pos) - 4;

						int startPos = ((file.substring(0, pos)).getBytes()).length;
						int endPos = ((file.substring(0, boundaryLocation))
								.getBytes()).length;
						System.out.println("boundaryLocation==" + boundaryLocation
								+ "=startPos=" + startPos + "endPos" + endPos);
						// new code Start
						
						// new code end
						try {

							String lengths = "", xlsSize = "", insertedSize = "", txtFileSize = "", invalidTxtSize = "";
							String[] temp;

							System.out.println("saveFilePath" + folderPath);
							File saveFilePath = new File(folderPath);
							System.out.println("saveFilePath" + saveFilePath);
							if (!saveFilePath.exists()) {
								File saveDir = new File(folderPath);
								if (!saveDir.exists())
									saveDir.mkdirs();

							}

							// This is used for segregated folder struture
							// baseed on AAI EPF forms

							String fileName1 = folderPath + slashsuffix
									+ saveFile;

							System.out.println("fileName " + fileName);
							FileOutputStream fileOut = new FileOutputStream(
									fileName1);
							fileOut.write(dataBytes, startPos,
									(endPos - startPos));
							// fileOut.flush();
							// fileOut.close();

						} catch (Exception e) {
							System.out.println("in exception e " + e.getMessage());

						}
					}
			
			
			*/
			
			
			//System.out.print("claimForm"+claimForm+identityCard+paySlip+panCard+adharCard+cancelCheque+photograph);
			LoginInfo userinfo= (LoginInfo)request.getSession(false).getAttribute("user");
			String unitcd="";String unittype="",userid="",designation="";
			String airport="",region="";
			airport=userinfo.getUnitName();
			region=userinfo.getRegion();
			unitcd=userinfo.getUnitCd();
			unittype=userinfo.getUnitType();
			userid=userinfo.getUserId();
			designation=userinfo.getDesignation();
			
			annuityService.updateFormApprove1(appId,remarks,approveStatus,transCd,transDescreption,claimForm,identityCard,paySlip,panCard,adharCard,cancelCheque,photograph,deceasedemployee,nominationdoc,nomineeproof,rejectedRemarks,rejectedType,userid,designation);
			
			ArrayList list=annuityService.getAnniutyForms(unitcd,unittype,airport,region);
			request.setAttribute("list", list);
			rd = request.getRequestDispatcher("./PensionView/SBS/AnnuitySearhForm.jsp?menu="+menu);
			rd.forward(request, response);
		}else if(request.getParameter("method") != null
				&& request.getParameter("method").equals("Approve3")){
			String transCd="12",transDescreption="HR Level2 Approval";
			String menu=request.getParameter("menu").toString()!=null?request.getParameter("menu").toString():"";
			String appId=request.getParameter("appid").toString()!=null?request.getParameter("appid").toString():"";
			String remarks=request.getParameter("remarks").toString()!=null?request.getParameter("remarks").toString():"";
			String approveStatus=request.getParameter("approveStatus").toString()!=null?request.getParameter("approveStatus").toString():"";
			String rejectedRemarks=request.getParameter("rejectedremarks").toString()!=null?request.getParameter("rejectedremarks").toString():"";
			String rejectedType=request.getParameter("rejectedtype").toString()!=null?request.getParameter("rejectedtype").toString():"";
			String eligibleStatus=request.getParameter("eligibleStatus").toString()!=null?request.getParameter("eligibleStatus").toString():"";
			String serviceBook=request.getParameter("servicebook").toString()!=null?request.getParameter("servicebook").toString():"";
			serviceBook=serviceBook.equals("on")?"Y":"N";
			String cpse=request.getParameter("cpse").toString()!=null?request.getParameter("cpse").toString():"";
			cpse=cpse.equals("Y")?"Y":"N";
			String cad=request.getParameter("cad").toString()!=null?request.getParameter("cad").toString():"";
			cad=cad.equals("Y")?"Y":"N";
			String crs=request.getParameter("crs").toString()!=null?request.getParameter("crs").toString():"";
			crs=crs.equals("Y")?"Y":"N";
			String resign=request.getParameter("resign").toString()!=null?request.getParameter("resign").toString():"";
			resign=resign.equals("Y")?"Y":"N";
			String vrs=request.getParameter("vrs").toString()!=null?request.getParameter("vrs").toString():"";
			vrs=vrs.equals("Y")?"Y":"N";
			String deputation=request.getParameter("deputation").toString()!=null?request.getParameter("deputation").toString():"";
			deputation=deputation.equals("Y")?"Y":"N";
			System.out.println("request.getParametertotcorpus2lakhs==="+request.getParameter("totcorpus2lakhs"));
			String totcorpus2lakhs=request.getParameter("totcorpus2lakhs").toString()!=null?request.getParameter("totcorpus2lakhs").toString():"";
			deputation=deputation.equals("Y")?"Y":"N";
			System.out.println("request.getParameterdeathcertficate==="+request.getParameter("deathcertficate"));
			String deathcertficate=request.getParameter("deathcertficate").toString()!=null?request.getParameter("deathcertficate").toString():"";
			deputation=deputation.equals("Y")?"Y":"N";
			String notational=request.getParameter("notational").toString()!=null?request.getParameter("notational").toString():"";
			notational=notational.equals("Y")?"Y":"N";
			String notationalappearCard=request.getParameter("notationalappearCard").toString()!=null?request.getParameter("notationalappearCard").toString():"";
			notationalappearCard=notationalappearCard.equals("Y")?"Y":"N";
			String arrear=request.getParameter("arrear").toString()!=null?request.getParameter("arrear").toString():"";
			arrear=arrear.equals("Y")?"Y":"N";
			String obadjustment=request.getParameter("obadjustment").toString()!=null?request.getParameter("obadjustment").toString():"";
			String depAAItoOther=request.getParameter("deputationaaitoother").toString()!=null?request.getParameter("deputationaaitoother").toString():"";
			depAAItoOther=depAAItoOther.equals("Y")?"Y":"N";
			String obRemarks=request.getParameter("obremarks").toString()!=null?request.getParameter("obremarks").toString():"";
			String corpusOBAdj=request.getParameter("corpusobadj").toString()!=null?request.getParameter("corpusobadj").toString():"";
			String pfId=request.getParameter("pfId").toString()!=null?request.getParameter("pfId").toString():"";
			String fileName="";
			if (request.getParameter("fileName") != null) {
				fileName = request.getParameter("fileName");
			}
			 	String contentType = request.getContentType();

					System.out.println("Content type is :: " + contentType);
					String saveFile = "", dir = "", file = "", filePath = "", slashsuffix = "";
					int start = 0, end = 0;

					ResourceBundle appbundle = ResourceBundle
							.getBundle("aims.resource.ApplicationResouces");
					//slashsuffix = appbundle
							//.getString("upload.folder.path.sbs");
					String folderPath = appbundle
							.getString("upload.folder.path.sbs.hr");

					File filePath1 = new File(folderPath);
					if (!filePath1.exists()) {
						filePath1.mkdirs();
					}

					if ((contentType != null)
							&& (contentType.indexOf("multipart/form-data") >= 0)) {

						DataInputStream in = new DataInputStream(request
								.getInputStream());

						int formDataLength = request.getContentLength();

						byte dataBytes[] = new byte[formDataLength];
						int byteRead = 0;
						int totalBytesRead = 0;
						while (totalBytesRead < formDataLength) {
							byteRead = in.read(dataBytes, totalBytesRead,
									formDataLength);
							// log.info("byteRead"+byteRead);
							totalBytesRead += byteRead;
						}
						file = new String(dataBytes);
						// start = file.indexOf("filename=\"")+10;
						start = file.indexOf("filename=\"") + 10;
						System.out.println("=start=" + start);
						end = file.indexOf(".pdf");
						System.out.println("=end=" + end);

						if (file.indexOf(".mdb") != -1) {
							end = file.indexOf(".mdb");
							System.out.println("=end=" + end);
						}

						file = new String(dataBytes);
						saveFile = file
								.substring(file.indexOf("filename=\"") + 10);
						saveFile = saveFile
								.substring(0, saveFile.indexOf("\n"));
						saveFile = saveFile.substring(saveFile
								.lastIndexOf("\\") + 1, saveFile.indexOf("\""));
						// we are added datetime as suffix in the file name

						System.out.println("File Name" + saveFile);
						saveFile=appId+".pdf";
						int lastIndex = contentType.lastIndexOf("=");
						String boundary = contentType.substring(lastIndex + 1,
								contentType.length());
						// out.println(boundary);
						int pos;
						pos = file.indexOf("filename=\"");
						pos = file.indexOf("\n", pos) + 1;
						pos = file.indexOf("\n", pos) + 1;
						pos = file.indexOf("\n", pos) + 1;

						System.out.println("lastIndex==" + lastIndex + "=boundary="
								+ boundary + "pose" + pos);

						int boundaryLocation = file.indexOf(boundary, pos) - 4;

						int startPos = ((file.substring(0, pos)).getBytes()).length;
						int endPos = ((file.substring(0, boundaryLocation))
								.getBytes()).length;
						System.out.println("boundaryLocation==" + boundaryLocation
								+ "=startPos=" + startPos + "endPos" + endPos);
						// new code Start
						
						// new code end
						try {

							String lengths = "", xlsSize = "", insertedSize = "", txtFileSize = "", invalidTxtSize = "";
							String[] temp;

							System.out.println("saveFilePath" + folderPath);
							File saveFilePath = new File(folderPath);
							System.out.println("saveFilePath" + saveFilePath);
							if (!saveFilePath.exists()) {
								File saveDir = new File(folderPath);
								if (!saveDir.exists())
									saveDir.mkdirs();

							}

							// This is used for segregated folder struture
							// baseed on AAI EPF forms

							String fileName1 = folderPath + slashsuffix
									+ saveFile;

							System.out.println("fileName " + fileName);
							FileOutputStream fileOut = new FileOutputStream(
									fileName1);
							fileOut.write(dataBytes, startPos,
									(endPos - startPos));
							// fileOut.flush();
							// fileOut.close();

						} catch (Exception e) {
							System.out.println("in exception e " + e.getMessage());

						}
					}
			
			
			
			LoginInfo userinfo= (LoginInfo)request.getSession(false).getAttribute("user");
			String userid="",designation="";
			
			userid=userinfo.getUserId();
			designation=userinfo.getDesignation();
			annuityService.updateFormApprove2(appId,remarks,approveStatus,transCd,transDescreption,serviceBook,cpse,cad,crs,resign,vrs,deputation,notational,notationalappearCard,arrear,obadjustment,depAAItoOther,totcorpus2lakhs,deathcertficate,obRemarks,corpusOBAdj,rejectedRemarks,rejectedType,userid,designation,eligibleStatus);
			
			String depDetails[]=null;
			String fromDate="",toDate="";
			System.out.print("depDetails::"+request.getParameterValues("depDetails"));
			if(request.getParameterValues("depDetails")!=null) {     
				depDetails=request.getParameterValues("depDetails");
					System.out.print("depDetails::"+depDetails);		
				int l=0;
				for(int i=0;i<depDetails.length;i++) { 
							   
					StringTokenizer st1=new StringTokenizer(depDetails[i],"|");
					if(st1.hasMoreTokens()) {   
											
						l++;
						fromDate=st1.nextToken().trim();
						toDate=st1.nextToken().trim();
					
			
			 appId=annuityService.addDep(fromDate,toDate,l,appId,pfId);
			}
				}}
			
			
			String unitcd="";String unittype="";String unitname="",region="";
			unitcd=userinfo.getUnitCd();
			unittype=userinfo.getUnitType();
			unitname=userinfo.getUnitName();
			region=userinfo.getRegion();
			ArrayList list=annuityService.getAnniutySearchLevel2(unitcd,unittype,unitname,region);
			request.setAttribute("list", list);
			rd = request.getRequestDispatcher("./PensionView/SBS/AnnuitySearhForm2.jsp?menu="+menu);
			rd.forward(request, response);
		}
		else if(request.getParameter("method") != null
				&& request.getParameter("method").equals("Approve")){
			String menu=request.getParameter("menu")!=null?request.getParameter("menu"):"";
			String appId=request.getParameter("appid")!=null?request.getParameter("appid"):"";
			LicBean bean=annuityService.getAnniutyForm(appId);
			request.setAttribute("licBean", bean);
			rd = request.getRequestDispatcher("./PensionView/SBS/AnnuityApproveForm.jsp?menu="+menu);
			rd.forward(request, response);
		}
		else if(request.getParameter("method") != null
				&& request.getParameter("method").equals("finApprove")){
			String menu=request.getParameter("menu")!=null?request.getParameter("menu"):"";
			LoginInfo userinfo= (LoginInfo)request.getSession(false).getAttribute("user");
			String unitcd="";String unittype="";String airport="",region="";
			unitcd=userinfo.getUnitCd();
			unittype=userinfo.getUnitType();
			airport=userinfo.getUnitName();
			region=userinfo.getRegion();
			ArrayList list=annuityService.getAnniutySearchLevel3(unitcd,unittype,airport,region);
			request.setAttribute("list", list);
			rd = request.getRequestDispatcher("./PensionView/SBS/AnnuitySearhForm3.jsp?menu="+menu);
			rd.forward(request, response);
		}
		else if(request.getParameter("method") != null
				&& request.getParameter("method").equals("rhqHrApprove")){
			String menu=request.getParameter("menu")!=null?request.getParameter("menu"):"";
			LoginInfo userinfo= (LoginInfo)request.getSession(false).getAttribute("user");
			String unitcd="";String unittype="";String airport="",region="";
			unitcd=userinfo.getUnitCd();
			unittype=userinfo.getUnitType();
			airport=userinfo.getUnitName();
			region=userinfo.getRegion();
			ArrayList list=annuityService.getAnniutySearchRHQHR(unitcd,unittype,airport,region);
			request.setAttribute("list", list);
			rd = request.getRequestDispatcher("./PensionView/SBS/AnnuitySearhRhqHr.jsp?menu="+menu);
			rd.forward(request, response);
		}else if(request.getParameter("method") != null
				&& request.getParameter("method").equals("rhqFinApprove")){
			String menu=request.getParameter("menu")!=null?request.getParameter("menu"):"";
			LoginInfo userinfo= (LoginInfo)request.getSession(false).getAttribute("user");
			String unitcd="";String unittype="";String airport="",region="";
			unitcd=userinfo.getUnitCd();
			unittype=userinfo.getUnitType();
			airport=userinfo.getUnitName();
			region=userinfo.getRegion();
			ArrayList list=annuityService.getAnniutySearchRHQFin(unitcd,unittype,airport,region);
			request.setAttribute("list", list);
			rd = request.getRequestDispatcher("./PensionView/SBS/AnnuitySearhRhqFin.jsp?menu="+menu);
			rd.forward(request, response);
		}
		else if(request.getParameter("method") != null
				&& request.getParameter("method").equals("chqHrApprove")){
			String menu=request.getParameter("menu")!=null?request.getParameter("menu"):"";
			LoginInfo userinfo= (LoginInfo)request.getSession(false).getAttribute("user");
			String unitcd="";String unittype="";String airport="",region="";
			unitcd=userinfo.getUnitCd();
			unittype=userinfo.getUnitType();
			airport=userinfo.getUnitName();
			region=userinfo.getRegion();
			ArrayList list=annuityService.getAnniutySearchCHQHR(unitcd,unittype,airport,region);
			request.setAttribute("list", list);
			rd = request.getRequestDispatcher("./PensionView/SBS/AnnuitySearhChqHr.jsp?menu="+menu);
			rd.forward(request, response);
		}
		else if(request.getParameter("method") != null
				&& request.getParameter("method").equals("chqFinApprove")){
			String menu=request.getParameter("menu")!=null?request.getParameter("menu"):"";
			ArrayList list=annuityService.getAnniutySearchCHQFin();
			request.setAttribute("list", list);
			rd = request.getRequestDispatcher("./PensionView/SBS/AnnuitySearhChqFin.jsp?menu="+menu);
			rd.forward(request, response);
		}else if(request.getParameter("method") != null
				&& request.getParameter("method").equals("edcpApprove")){
			String menu=request.getParameter("menu")!=null?request.getParameter("menu"):"";
			LoginInfo userinfo= (LoginInfo)request.getSession(false).getAttribute("user");
			String unitcd="";String unittype="";
			unitcd=userinfo.getUnitCd();
			unittype=userinfo.getUnitType();
			ArrayList list=annuityService.getAnniutyEDCPApproval(unitcd,unittype);
			request.setAttribute("list", list);
			rd = request.getRequestDispatcher("./PensionView/SBS/AnnuitySearhEDCPApproval.jsp?menu="+menu);
			rd.forward(request, response);
		}
		else if(request.getParameter("method") != null
				&& request.getParameter("method").equals("edcpApprove2")){
			String menu=request.getParameter("menu")!=null?request.getParameter("menu"):"";
			LoginInfo userinfo= (LoginInfo)request.getSession(false).getAttribute("user");
			String unitcd="";String unittype="";
			unitcd=userinfo.getUnitCd();
			unittype=userinfo.getUnitType();
			System.out.println("unitcd===="+unitcd+"===unittype==="+unittype);
			ArrayList list=annuityService.getAnniutyEDCPApproval2(unitcd,unittype);
			//System.out.println("list======serveletprasanthi==="+list);
			request.setAttribute("list", list);
			rd = request.getRequestDispatcher("./PensionView/SBS/AnnuitySearchEDCPApprove2.jsp?menu="+menu);
			rd.forward(request, response);
		}
		else if(request.getParameter("method") != null
				&& request.getParameter("method").equals("edcpApprove3")){
			String menu=request.getParameter("menu")!=null?request.getParameter("menu"):"";
			LoginInfo userinfo= (LoginInfo)request.getSession(false).getAttribute("user");
			String unitcd="";String unittype="";
			unitcd=userinfo.getUnitCd();
			unittype=userinfo.getUnitType();
			ArrayList list=annuityService.getAnniutyEDCPApproval3(unitcd,unittype);
			request.setAttribute("list", list);
			rd = request.getRequestDispatcher("./PensionView/SBS/AnnuitySearchEDCPApprove3.jsp?menu="+menu);
			rd.forward(request, response);
		}
		else if(request.getParameter("method") != null
				&& request.getParameter("method").equals("coveringletter")){
			String menu=request.getParameter("menu")!=null?request.getParameter("menu"):"";
			LoginInfo userinfo= (LoginInfo)request.getSession(false).getAttribute("user");
			String unitcd="";String unittype="";
			unitcd=userinfo.getUnitCd();
			unittype=userinfo.getUnitType();
			ArrayList list=annuityService.getAnniutyCoverLetter(unitcd,unittype);
			request.setAttribute("list", list);
			rd = request.getRequestDispatcher("./PensionView/SBS/AnnuitySearchCoveringLetter.jsp?menu="+menu);
			rd.forward(request, response);
		}
		else if(request.getParameter("method") != null
				&& request.getParameter("method").equals("fundWithDrawal")){
			String menu=request.getParameter("menu")!=null?request.getParameter("menu"):"";
			ArrayList list=annuityService.getAnniutyFundWithDrawal();
			request.setAttribute("list", list);
			rd = request.getRequestDispatcher("./PensionView/SBS/AnnuityFundWithDrawalProess.jsp?menu="+menu);
			rd.forward(request, response);
		}
		else if(request.getParameter("method") != null
				&& request.getParameter("method").equals("rhqFinApproveForm")){
			String menu=request.getParameter("menu")!=null?request.getParameter("menu"):"";
			String appId=request.getParameter("appid")!=null?request.getParameter("appid"):"";
			LicBean bean=annuityService.getAnniutyForm(appId);
			request.setAttribute("licBean", bean);
			rd = request.getRequestDispatcher("./PensionView/SBS/RHQFinAnnuityApproveForm.jsp?menu="+menu);
			rd.forward(request, response);
		}
		else if(request.getParameter("method") != null
				&& request.getParameter("method").equals("chqApproveForm")){
			String menu=request.getParameter("menu")!=null?request.getParameter("menu"):"";
			String appId=request.getParameter("appid")!=null?request.getParameter("appid"):"";
			LicBean bean=annuityService.getAnniutyForm(appId);
			request.setAttribute("licBean", bean);
			rd = request.getRequestDispatcher("./PensionView/SBS/CHQAnnuityApproveForm.jsp?menu="+menu);
			rd.forward(request, response);
		}else if(request.getParameter("method") != null
				&& request.getParameter("method").equals("chqFinApproveForm")){
			String menu=request.getParameter("menu")!=null?request.getParameter("menu"):"";
			String appId=request.getParameter("appid")!=null?request.getParameter("appid"):"";
			LicBean bean=annuityService.getAnniutyForm(appId);
			request.setAttribute("licBean", bean);
			rd = request.getRequestDispatcher("./PensionView/SBS/CHQFinAnnuityApproveForm.jsp?menu="+menu);
			rd.forward(request, response);
		}
		else if(request.getParameter("method") != null
				&& request.getParameter("method").equals("edcpApproveForm")){
			String menu=request.getParameter("menu")!=null?request.getParameter("menu"):"";
			String appId=request.getParameter("appid")!=null?request.getParameter("appid"):"";
			LicBean bean=annuityService.getAnniutyForm(appId);
			request.setAttribute("licBean", bean);
			rd = request.getRequestDispatcher("./PensionView/SBS/EDCPAnnuityApproveForm.jsp?menu="+menu);
			rd.forward(request, response);
		}
		else if(request.getParameter("method") != null
				&& request.getParameter("method").equals("edcpApproveForm2")){
			String menu=request.getParameter("menu")!=null?request.getParameter("menu"):"";
			String appId=request.getParameter("appid")!=null?request.getParameter("appid"):"";
			LicBean bean=annuityService.getAnniutyForm(appId);
			request.setAttribute("licBean", bean);
			rd = request.getRequestDispatcher("./PensionView/SBS/EDCPAnnuityApproveForm2.jsp?menu="+menu);
			rd.forward(request, response);
		}
		else if(request.getParameter("method") != null
				&& request.getParameter("method").equals("edcpApproveForm3")){
			String menu=request.getParameter("menu")!=null?request.getParameter("menu"):"";
			String appId=request.getParameter("appid")!=null?request.getParameter("appid"):"";
			LicBean bean=annuityService.getAnniutyForm(appId);
			request.setAttribute("licBean", bean);
			rd = request.getRequestDispatcher("./PensionView/SBS/EDCPAnnuityApproveForm3.jsp?menu="+menu);
			rd.forward(request, response);
		}
		else if(request.getParameter("method") != null
				&& request.getParameter("method").equals("chqApproveUpdate")){
			String transCd="16",transDescreption="CHQ HR Approval";
			String menu=request.getParameter("menu")!=null?request.getParameter("menu"):"";
			String appId=request.getParameter("appid")!=null?request.getParameter("appid"):"";
			String remarks=request.getParameter("remarks")!=null?request.getParameter("remarks"):"";
			String approveStatus=request.getParameter("approveStatus")!=null?request.getParameter("approveStatus"):"";
			String formVerified=request.getParameter("chqHrVerified")!=null?request.getParameter("chqHrVerified"):"";
			formVerified=formVerified.equals("on")?"Y":"N";
			String rejectedType=request.getParameter("rejectedtype")!=null?request.getParameter("rejectedtype"):"";
			String rejectedRemarks=request.getParameter("rejectedremarks")!=null?request.getParameter("rejectedremarks"):"";
			
			LoginInfo userinfo= (LoginInfo)request.getSession(false).getAttribute("user");
			String userid="",designation="",region;
			region=userinfo.getRegion();
			userid=userinfo.getUserId();
			designation=userinfo.getDesignation();
			if(approveStatus.equals("R")){
				annuityService.updateFormReject(appId,rejectedRemarks,approveStatus,rejectedType,"CHQHR",region);
			}else{
			annuityService.chqUpdateFormApprove(appId,remarks,approveStatus,transCd,transDescreption,formVerified,userid,designation,region);
			}
			//ArrayList list=annuityService.getAnniutySearchCHQHR();
			//request.setAttribute("list", list);
			rd = request.getRequestDispatcher("SBSAnnuityServlet?method=chqHrApprove&&menu="+menu);
			rd.forward(request, response);
		}else if(request.getParameter("method") != null
				&& request.getParameter("method").equals("edcpApproveUpdate")){
			String transCd="18",transDescreption="EDCP Approval";
			String menu=request.getParameter("menu")!=null?request.getParameter("menu"):"";
			String appId=request.getParameter("appid")!=null?request.getParameter("appid"):"";
			String remarks=request.getParameter("remarks")!=null?request.getParameter("remarks"):"";
			String approveStatus=request.getParameter("approveStatus")!=null?request.getParameter("approveStatus"):"";
			String tdsrec=request.getParameter("tdsrec")!=null?request.getParameter("tdsrec"):"";
			
			String corpusamt=request.getParameter("corpusamt")!=null?request.getParameter("corpusamt"):"";
			String corpusint=request.getParameter("corpusint")!=null?request.getParameter("corpusint"):"";
			String rejectedType=request.getParameter("rejectedtype")!=null?request.getParameter("rejectedtype"):"";
			String rejectedRemarks=request.getParameter("rejectedremarks")!=null?request.getParameter("rejectedremarks"):"";
			
			LoginInfo userinfo= (LoginInfo)request.getSession(false).getAttribute("user");
			String userid="",designation="",region="";
			region=userinfo.getRegion();
			userid=userinfo.getUserId();
			designation=userinfo.getDesignation();
			if(approveStatus.equals("R")){
				annuityService.updateFormReject(appId,rejectedRemarks,approveStatus,rejectedType,"EDCP1",region);
			}else{
			annuityService.edcpUpdateFormApprove(appId,remarks,approveStatus,transCd,transDescreption,tdsrec,corpusamt,corpusint,userid,designation);
			}
			//ArrayList list=annuityService.getAnniutySearchCHQHR();
			//request.setAttribute("list", list);
			rd = request.getRequestDispatcher("SBSAnnuityServlet?method=edcpApprove&&menu="+menu);
			rd.forward(request, response);
		}
		else if(request.getParameter("method") != null
				&& request.getParameter("method").equals("edcpApproveUpdate2")){
			String transCd="19",transDescreption="EDCP Approval-II";
			String menu=request.getParameter("menu")!=null?request.getParameter("menu"):"";
			String appId=request.getParameter("appid")!=null?request.getParameter("appid"):"";
			String remarks=request.getParameter("remarks")!=null?request.getParameter("remarks"):"";
			String approveStatus=request.getParameter("approveStatus")!=null?request.getParameter("approveStatus"):"";
			String tdsrec=request.getParameter("tdsrec")!=null?request.getParameter("tdsrec"):"";
			LoginInfo userinfo= (LoginInfo)request.getSession(false).getAttribute("user");
			String userid="",designation="";
			
			userid=userinfo.getUserId();
			designation=userinfo.getDesignation();
			annuityService.edcpUpdateFormApprove2(appId,remarks,approveStatus,transCd,transDescreption,tdsrec,userid,designation);
			
			//ArrayList list=annuityService.getAnniutySearchCHQHR();
			//request.setAttribute("list", list);
			rd = request.getRequestDispatcher("SBSAnnuityServlet?method=edcpApprove2&&menu="+menu);
			rd.forward(request, response);
		}
		else if(request.getParameter("method") != null
				&& request.getParameter("method").equals("edcpApproveUpdate3")){
			String transCd="20",transDescreption="EDCP Approval";
			String menu=request.getParameter("menu")!=null?request.getParameter("menu"):"";
			String appId=request.getParameter("appid")!=null?request.getParameter("appid"):"";
			String remarks=request.getParameter("remarks")!=null?request.getParameter("remarks"):"";
			String approveStatus=request.getParameter("approveStatus")!=null?request.getParameter("approveStatus"):"";
			String tdsrec=request.getParameter("tdsrec")!=null?request.getParameter("tdsrec"):"";
			LoginInfo userinfo= (LoginInfo)request.getSession(false).getAttribute("user");
			String userid="",designation="";
			
			userid=userinfo.getUserId();
			designation=userinfo.getDesignation();
			annuityService.edcpUpdateFormApprove3(appId,remarks,approveStatus,transCd,transDescreption,tdsrec,userid,designation);
			
			//ArrayList list=annuityService.getAnniutySearchCHQHR();
			//request.setAttribute("list", list);
			rd = request.getRequestDispatcher("SBSAnnuityServlet?method=edcpApprove3&&menu="+menu);
			rd.forward(request, response);
		}
		else if(request.getParameter("method") != null
				&& request.getParameter("method").equals("chqFinApproveUpdate")){
			String transCd="17",transDescreption="CHQ Finance Approval";
			String menu=request.getParameter("menu")!=null?request.getParameter("menu"):"";
			String appId=request.getParameter("appid")!=null?request.getParameter("appid"):"";
			String remarks=request.getParameter("remarks")!=null?request.getParameter("remarks"):"";
			String approveStatus=request.getParameter("approveStatus")!=null?request.getParameter("approveStatus"):"";
			String formVerified=request.getParameter("chqFinVerified")!=null?request.getParameter("chqFinVerified"):"";
			formVerified=formVerified.equals("on")?"Y":"N";
			LoginInfo userinfo= (LoginInfo)request.getSession(false).getAttribute("user");
			String userid="",designation="";
			
			userid=userinfo.getUserId();
			designation=userinfo.getDesignation();
			annuityService.chqFinUpdateFormApprove(appId,remarks,approveStatus,transCd,transDescreption,formVerified,userid,designation);
			
			//ArrayList list=annuityService.getAnniutySearchCHQHR();
			//request.setAttribute("list", list);
			rd = request.getRequestDispatcher("SBSAnnuityServlet?method=chqFinApprove&&menu="+menu);
			rd.forward(request, response);
		}
		else if(request.getParameter("method") != null
				&& request.getParameter("method").equals("rhqFinApproveUpdate")){
			String transCd="15",transDescreption="RHQ Fin Approval";
			String menu=request.getParameter("menu")!=null?request.getParameter("menu"):"";
			String appId=request.getParameter("appid")!=null?request.getParameter("appid"):"";
			String purchaseAmt=request.getParameter("purchaseamt")!=null?request.getParameter("purchaseamt"):"";
			String intDate=request.getParameter("intcalcdate")!=null?request.getParameter("intcalcdate"):"";
			String remarks=request.getParameter("remarks")!=null?request.getParameter("remarks"):"";
			String approveStatus=request.getParameter("approveStatus")!=null?request.getParameter("approveStatus"):"";
			String formVerified=request.getParameter("rhqFinVerified")!=null?request.getParameter("rhqFinVerified"):"";
			String rejectedType=request.getParameter("rejectedtype")!=null?request.getParameter("rejectedtype"):"";
			String rejectedRemarks=request.getParameter("rejectedremarks")!=null?request.getParameter("rejectedremarks"):"";
			
			formVerified=formVerified.equals("on")?"Y":"N";
			LoginInfo userinfo= (LoginInfo)request.getSession(false).getAttribute("user");
			String userid="",designation="",region="";
			region=userinfo.getRegion();
			userid=userinfo.getUserId();
			designation=userinfo.getDesignation();
			if(approveStatus.equals("R")){
				annuityService.updateFormReject(appId,rejectedRemarks,approveStatus,rejectedType,"RHQFIN",region);
			}else{
			annuityService.rhqFinUpdateFormApprove(appId,remarks,approveStatus,transCd,transDescreption,formVerified,userid,designation,intDate,purchaseAmt);
			}
			//ArrayList list=annuityService.getAnniutySearchCHQHR();
			//request.setAttribute("list", list);
			rd = request.getRequestDispatcher("SBSAnnuityServlet?method=rhqFinApprove&&menu="+menu);
			rd.forward(request, response);
		}
		
		else if(request.getParameter("method") != null
				&& request.getParameter("method").equals("rhqApproveForm")){
			String menu=request.getParameter("menu")!=null?request.getParameter("menu"):"";
			String appId=request.getParameter("appid")!=null?request.getParameter("appid"):"";
			LicBean bean=annuityService.getAnniutyForm(appId);
			request.setAttribute("licBean", bean);
			ArrayList list=new ArrayList();
			String pensionno=bean.getEmployeeNo();
			
			Calendar aCalendar = Calendar.getInstance();
			// add -1 month to current month
			aCalendar.add(Calendar.MONTH, -1);
			// set DATE to 1, so first date of previous month
			aCalendar.set(Calendar.DATE, 1);

			//Date firstDateOfPreviousMonth = aCalendar.getTime();

			// set actual maximum date of previous month
			aCalendar.set(Calendar.DATE,     aCalendar.getActualMaximum(Calendar.DAY_OF_MONTH));
			//read it
			Date lastDateOfPreviousMonth = aCalendar.getTime();
			
			//Date date = Calendar.getInstance().getTime();
			DateFormat dateFormat = new SimpleDateFormat("dd-MMM-yyyy");
			String intcalcdate = dateFormat.format(lastDateOfPreviousMonth);
			String finYear=request.getParameter("finyear")!=null?request.getParameter("finyear"):"2021-2022";
			System.out.print(pensionno+"::::pensionno");
			list = service.getSBSCard(pensionno,finYear);
			
			//================================================
			
			  PensionContBean empBean=null;
			  
			  DecimalFormat df = new DecimalFormat("#########0");
			 
			  ArrayList pensionList=new ArrayList();
			  ArrayList obList=new ArrayList();
			  ArrayList adjobList=new ArrayList();
			 
			  
			    int sbsContriGrandTot=0,sbsNotationalGrandTot=0,sbsadjAAIEDCPGrandTot=0;
			    String intAdjCorpus="",intGrossCorpus="",obBalance="";
			   for(int i=0;i<list.size();i++){
			   
			   empBean=(PensionContBean)list.get(i);
			   pensionList=empBean.getEmpPensionList();
			   obList=empBean.getObList();
			   adjobList=empBean.getAdjOBList();
			   
			   
			   
									String obSbsContri="0",obNotational="0",obAdjSBSContri="0";
									TempPensionTransBean obBean=null;
										
										obBean=(TempPensionTransBean)obList.get(0);
										obSbsContri=obBean.getPensionContr();
										obNotational=obBean.getNoIncrement();
										obAdjSBSContri=obBean.getAdjSbsContri();
										
										
										
										String adjobSbsContri="0",adjobNotational="0",adjobAdjSBSContri="0";
										 String intMonth="";
										TempPensionTransBean adjobBean=null;
											adjobBean=new TempPensionTransBean();
											
											adjobBean=(TempPensionTransBean)adjobList.get(0);
											adjobSbsContri=adjobBean.getPensionContr();
											adjobNotational=adjobBean.getNoIncrement();
											adjobAdjSBSContri=adjobBean.getAdjSbsContri();			 
								
										
							
									
									int emolumentsTotal=0,aaiedcpTotal=0,notationalTotal=0,adjAAIEDCPTotal=0;
									double cumilativeTotal=0.0;
									
									if(pensionList.size()>0){
									for(int k=0;k<pensionList.size();k++){
									EmployeePensionCardInfo cardInfo =(EmployeePensionCardInfo)pensionList.get(k);
									
									emolumentsTotal=emolumentsTotal+Integer.parseInt(cardInfo.getEmoluments());
									aaiedcpTotal=aaiedcpTotal+Integer.parseInt(cardInfo.getAaiedcpContri());
									notationalTotal=notationalTotal+Integer.parseInt(cardInfo.getNotationaIncrement());
									adjAAIEDCPTotal=adjAAIEDCPTotal+Integer.parseInt(cardInfo.getAaiedcpContri())-Integer.parseInt(cardInfo.getNotationaIncrement());
									cumilativeTotal=cumilativeTotal+Double.parseDouble(cardInfo.getGrandCummulative());
									 
									 
									 }
									 
									 
									 
							
								
									
									
									 sbsContriGrandTot=sbsContriGrandTot+(aaiedcpTotal+Integer.parseInt(obSbsContri));
									  sbsadjAAIEDCPGrandTot=sbsadjAAIEDCPGrandTot+(adjAAIEDCPTotal+Integer.parseInt(obAdjSBSContri));
									   sbsNotationalGrandTot=sbsNotationalGrandTot+(notationalTotal+Integer.parseInt(obNotational));
									   
									 
									 
									 
									   double obInt=0.0,obintInt=0.0,cumilativeint=0.0;double OBInt=0.0;
									 // OBInt=Math.round((Double.parseDouble(obAdjSBSContri)-Double.parseDouble(adjobNotational)+Double.parseDouble(adjobSbsContri))*(0.07431));
										 
									 double rateOfInt=6.431;
									 int intMonths=empBean.getNoOfMonths();
									 obInt=(Double.parseDouble(obAdjSBSContri)-Double.parseDouble(adjobNotational)+Double.parseDouble(adjobSbsContri))*rateOfInt/100*intMonths/12;
									// obintInt=(Double.parseDouble(obAdjSBSContri)-Double.parseDouble(adjobNotational)+Double.parseDouble(adjobSbsContri))*(0.07431)*rateOfInt/100*intMonths/12;
									 cumilativeint=cumilativeTotal*rateOfInt/100*intMonths/12;
									 
									
									 
									 obBalance=df.format(Double.parseDouble(obAdjSBSContri)-Double.parseDouble(adjobNotational)+Double.parseDouble(adjobSbsContri)+OBInt);
									
									 intAdjCorpus=df.format(obInt+obintInt+cumilativeint) ;
									 intGrossCorpus=df.format(obInt+obintInt+cumilativeint);
								
									}			
								
			//=====================================================
			
			   }
			System.out.println("obBalance"+obBalance);
			   request.setAttribute("corpusamt", obBalance);
			   request.setAttribute("corpusintamt", intGrossCorpus);
			   request.setAttribute("intDate", intcalcdate);
		
			rd = request.getRequestDispatcher("./PensionView/SBS/RHQAnnuityApproveForm.jsp?menu="+menu);
			rd.forward(request, response);
		}
		
		else if(request.getParameter("method") != null
				&& request.getParameter("method").equals("finApproveForm")){
			String menu=request.getParameter("menu")!=null?request.getParameter("menu"):"";
			String appId=request.getParameter("appid")!=null?request.getParameter("appid"):"";
			LicBean bean=annuityService.getAnniutyForm(appId);
			request.setAttribute("licBean", bean);
			rd = request.getRequestDispatcher("./PensionView/SBS/FinAnnuityApproveForm.jsp?menu="+menu);
			rd.forward(request, response);
		}else if(request.getParameter("method") != null
				&& request.getParameter("method").equals("rhqApproveUpdate")){
			String transCd="14",transDescreption="RHQ HR Approval";
			String menu=request.getParameter("menu")!=null?request.getParameter("menu"):"";
			String appId=request.getParameter("appid")!=null?request.getParameter("appid"):"";
			String purchaseAmt=request.getParameter("purchaseamt")!=null?request.getParameter("purchaseamt"):"";
			String intDate=request.getParameter("intcalcdate")!=null?request.getParameter("intcalcdate"):"";
			String remarks=request.getParameter("remarks")!=null?request.getParameter("remarks"):"";
			String approveStatus=request.getParameter("approveStatus")!=null?request.getParameter("approveStatus"):"";
			String formVerified=request.getParameter("rhqHrVerified")!=null?request.getParameter("rhqHrVerified"):"";
			formVerified=formVerified.equals("on")?"Y":"N";
			String rejectedType=request.getParameter("rejectedtype")!=null?request.getParameter("rejectedtype"):"";
			String rejectedRemarks=request.getParameter("rejectedremarks")!=null?request.getParameter("rejectedremarks"):"";
			
			LoginInfo userinfo= (LoginInfo)request.getSession(false).getAttribute("user");
			String userid="",designation="";
			String unitcd="";String unittype="";
			String airport="",region="";
			userid=userinfo.getUserId();
			designation=userinfo.getDesignation();
			region=userinfo.getRegion();
			if(approveStatus.equals("R")){
				annuityService.updateFormReject(appId,rejectedRemarks,approveStatus,rejectedType,"RHQHR",region);
			}else{
			annuityService.rhqUpdateFormApprove(appId,remarks,approveStatus,transCd,transDescreption,formVerified,userid,designation,intDate,purchaseAmt);
			}
			
			airport=userinfo.getUnitName();
			
			unitcd=userinfo.getUnitCd();
			unittype=userinfo.getUnitType();
			ArrayList list=annuityService.getAnniutySearchRHQHR(unitcd,unittype,airport,region);
			request.setAttribute("list", list);
			rd = request.getRequestDispatcher("./PensionView/SBS/AnnuitySearhRhqHr.jsp?menu="+menu);
			rd.forward(request, response);
		}
		else if(request.getParameter("method") != null
				&& request.getParameter("method").equals("finApproveUpdate")){
			String transCd="13",transDescreption="Finance Approval";
			String menu=request.getParameter("menu").toString()!=null?request.getParameter("menu").toString():"";
			String appId=request.getParameter("appid").toString()!=null?request.getParameter("appid").toString():"";
			String remarks=request.getParameter("remarks").toString()!=null?request.getParameter("remarks").toString():"";
			String approveStatus=request.getParameter("approveStatus").toString()!=null?request.getParameter("approveStatus").toString():"";
			String finNoIncrement=request.getParameter("finincrement").toString()!=null?request.getParameter("finincrement").toString():"";
			finNoIncrement=finNoIncrement.equals("Y")?"Y":"N";
			String finArrear=request.getParameter("finarrear").toString()!=null?request.getParameter("finarrear").toString():"";
			finArrear=finArrear.equals("Y")?"Y":"N";
			String finPreOBadj=request.getParameter("finpreobadj").toString()!=null?request.getParameter("finpreobadj").toString():"";
			finPreOBadj=finPreOBadj.equals("Y")?"Y":finPreOBadj.equals("N")?"N":"Not Applicable";
			
			String obOtherReason=request.getParameter("obotherreason").toString()!=null?request.getParameter("obotherreason").toString():"";
			obOtherReason=obOtherReason.equals("Y")?"Y":"N";
			
			String finOBadjCorpusCard=request.getParameter("finobadjcorpuscard").toString()!=null?request.getParameter("finobadjcorpuscard").toString():"";
			finOBadjCorpusCard=finOBadjCorpusCard.equals("Y")?"Y":finOBadjCorpusCard.equals("N")?"N":"Not Applicable";
			
			String finCorpusVerified=request.getParameter("fincorpusverified").toString()!=null?request.getParameter("fincorpusverified").toString():"";
			finCorpusVerified=finCorpusVerified.equals("Y")?"Y":"N";
			String totsbscorps2lakhs=request.getParameter("totsbscorps2lakhs").toString()!=null?request.getParameter("totsbscorps2lakhs").toString():"";
			totsbscorps2lakhs=totsbscorps2lakhs.equals("Y")?"Y":"N";
			String tds=request.getParameter("tds").toString()!=null?request.getParameter("tds").toString():"";
			tds=tds.equals("Y")?"Y":"N";
			String rejectedType=request.getParameter("rejectedtype").toString()!=null?request.getParameter("rejectedtype").toString():"";
			String rejectedRemarks=request.getParameter("rejectedremarks").toString()!=null?request.getParameter("rejectedremarks").toString():"";
			
			String fileName="";
			if (request.getParameter("fileName") != null) {
				fileName = request.getParameter("fileName");
			}
			 	String contentType = request.getContentType();

					System.out.println("Content type is :: " + contentType);
					String saveFile = "", dir = "", file = "", filePath = "", slashsuffix = "";
					int start = 0, end = 0;

					ResourceBundle appbundle = ResourceBundle
							.getBundle("aims.resource.ApplicationResouces");
					//slashsuffix = appbundle
							//.getString("upload.folder.path.sbs");
					String folderPath = appbundle
							.getString("upload.folder.path.sbs.fin");

					File filePath1 = new File(folderPath);
					if (!filePath1.exists()) {
						filePath1.mkdirs();
					}

					if ((contentType != null)
							&& (contentType.indexOf("multipart/form-data") >= 0)) {

						DataInputStream in = new DataInputStream(request
								.getInputStream());

						int formDataLength = request.getContentLength();

						byte dataBytes[] = new byte[formDataLength];
						int byteRead = 0;
						int totalBytesRead = 0;
						while (totalBytesRead < formDataLength) {
							byteRead = in.read(dataBytes, totalBytesRead,
									formDataLength);
							// log.info("byteRead"+byteRead);
							totalBytesRead += byteRead;
						}
						file = new String(dataBytes);
						// start = file.indexOf("filename=\"")+10;
						start = file.indexOf("filename=\"") + 10;
						System.out.println("=start=" + start);
						end = file.indexOf(".pdf");
						System.out.println("=end=" + end);

						if (file.indexOf(".mdb") != -1) {
							end = file.indexOf(".mdb");
							System.out.println("=end=" + end);
						}

						file = new String(dataBytes);
						saveFile = file
								.substring(file.indexOf("filename=\"") + 10);
						saveFile = saveFile
								.substring(0, saveFile.indexOf("\n"));
						saveFile = saveFile.substring(saveFile
								.lastIndexOf("\\") + 1, saveFile.indexOf("\""));
						// we are added datetime as suffix in the file name

						System.out.println("File Name" + saveFile);
						saveFile=appId+".pdf";
						int lastIndex = contentType.lastIndexOf("=");
						String boundary = contentType.substring(lastIndex + 1,
								contentType.length());
						// out.println(boundary);
						int pos;
						pos = file.indexOf("filename=\"");
						pos = file.indexOf("\n", pos) + 1;
						pos = file.indexOf("\n", pos) + 1;
						pos = file.indexOf("\n", pos) + 1;

						System.out.println("lastIndex==" + lastIndex + "=boundary="
								+ boundary + "pose" + pos);

						int boundaryLocation = file.indexOf(boundary, pos) - 4;

						int startPos = ((file.substring(0, pos)).getBytes()).length;
						int endPos = ((file.substring(0, boundaryLocation))
								.getBytes()).length;
						System.out.println("boundaryLocation==" + boundaryLocation
								+ "=startPos=" + startPos + "endPos" + endPos);
						// new code Start
						
						// new code end
						try {

							String lengths = "", xlsSize = "", insertedSize = "", txtFileSize = "", invalidTxtSize = "";
							String[] temp;

							System.out.println("saveFilePath" + folderPath);
							File saveFilePath = new File(folderPath);
							System.out.println("saveFilePath" + saveFilePath);
							if (!saveFilePath.exists()) {
								File saveDir = new File(folderPath);
								if (!saveDir.exists())
									saveDir.mkdirs();

							}

							// This is used for segregated folder struture
							// baseed on AAI EPF forms

							String fileName1 = folderPath + slashsuffix
									+ saveFile;

							System.out.println("fileName " + fileName);
							FileOutputStream fileOut = new FileOutputStream(
									fileName1);
							fileOut.write(dataBytes, startPos,
									(endPos - startPos));
							// fileOut.flush();
							// fileOut.close();

						} catch (Exception e) {
							System.out.println("in exception e " + e.getMessage());

						}
					}
			
			
			
			
			
			LoginInfo userinfo= (LoginInfo)request.getSession(false).getAttribute("user");
			String userid="",designation="",region="";
			userid=userinfo.getUserId();
			designation=userinfo.getDesignation();
			region=userinfo.getRegion();
			if(approveStatus.equals("R")){
				annuityService.updateFormReject(appId,rejectedRemarks,approveStatus,rejectedType,"Finance",region);
			}else{
			annuityService.updateFormApprove3(appId,remarks,approveStatus,transCd,transDescreption,finNoIncrement,finArrear,finPreOBadj,obOtherReason,finOBadjCorpusCard,finCorpusVerified,tds,userid,designation,totsbscorps2lakhs);
			}
		
			String unitcd="";String unittype="";String unitname="";
			unitcd=userinfo.getUnitCd();
			unitname=userinfo.getUnitName();
			unittype=userinfo.getUnitType();
			
			System.out.println(unitname+"==="+region);
			ArrayList list=annuityService.getAnniutySearchLevel3(unitcd,unittype,unitname,region);
			request.setAttribute("list", list);
			rd = request.getRequestDispatcher("./PensionView/SBS/AnnuitySearhForm3.jsp?menu="+menu);
			rd.forward(request, response);
		}
		else if(request.getParameter("method") != null
				&& request.getParameter("method").equals("Approve2")){
			String menu=request.getParameter("menu")!=null?request.getParameter("menu"):"";
			String appId=request.getParameter("appid")!=null?request.getParameter("appid"):"";
			LicBean bean=annuityService.getAnniutyForm(appId);
			request.setAttribute("licBean", bean);
			rd = request.getRequestDispatcher("./PensionView/SBS/AnnuityApproveForm2.jsp?menu="+menu);
			rd.forward(request, response);
		}
		
		
		else if(request.getParameter("method") != null
				&& request.getParameter("method").equals("getAnnuitySearch")){
			String menu=request.getParameter("menu")!=null?request.getParameter("menu"):"";
			LoginInfo userinfo= (LoginInfo)request.getSession(false).getAttribute("user");
			String unitcd="";String unittype="";String airport="",region="";
			unitcd=userinfo.getUnitCd();
			unittype=userinfo.getUnitType();
			airport=userinfo.getUnitName();
			region=userinfo.getRegion();
			ArrayList list=annuityService.getAnniutyForms(unitcd,unittype,airport,region);
			request.setAttribute("list", list);
			rd = request.getRequestDispatcher("./PensionView/SBS/AnnuitySearhForm.jsp?menu="+menu);
			rd.forward(request, response);
		}else if(request.getParameter("method") != null
				&& request.getParameter("method").equals("getAnnuitySearch2")){
			String menu=request.getParameter("menu")!=null?request.getParameter("menu"):"";
			LoginInfo userinfo= (LoginInfo)request.getSession(false).getAttribute("user");
			String unitcd="";String unittype="";String unitname="",region="";
			unitcd=userinfo.getUnitCd();
			unitname=userinfo.getUnitName();
			unittype=userinfo.getUnitType();
			region=userinfo.getRegion();
			System.out.println(unitname+"==="+region);
			ArrayList list=annuityService.getAnniutySearchLevel2(unitcd,unittype,unitname,region);
			request.setAttribute("list", list);
			rd = request.getRequestDispatcher("./PensionView/SBS/AnnuitySearhForm2.jsp?menu="+menu);
			rd.forward(request, response);
		}
		else if(request.getParameter("method") != null
				&& request.getParameter("method").equals("getSBIForm")){
			String menu=request.getParameter("menu")!=null?request.getParameter("menu"):"";
			LoginInfo userinfo= (LoginInfo)request.getSession(false).getAttribute("user");
			//LicBean bean=null;
			if(userinfo.getProfile().equals("M")){
				empPerinfo=annuityService.getPersonalInfo(userinfo.getPensionNo());
				// bean=annuityService.getAnniutyFormDraft(userinfo.getPensionNo());
			}
			request.setAttribute("empInfo", empPerinfo);
			rd = request.getRequestDispatcher("./PensionView/SBS/SBIForm.jsp?menu="+menu);
			rd.forward(request, response);
		}else if(request.getParameter("method") != null
				&& request.getParameter("method").equals("getRefundofCorpus")){
			String menu=request.getParameter("menu")!=null?request.getParameter("menu"):"";
			LoginInfo userinfo= (LoginInfo)request.getSession(false).getAttribute("user");
			//LicBean bean=null;
			if(userinfo.getProfile().equals("M")){
				empPerinfo=annuityService.getPersonalInfo(userinfo.getPensionNo());
				// bean=annuityService.getAnniutyFormDraft(userinfo.getPensionNo());
			}
			CommonUtil commonUtil = new CommonUtil();
			ArrayList regionList = new ArrayList();
			String rgnName = "";
			HashMap map = new HashMap();
			String[] regionLst = null;
			HttpSession session=request.getSession();
			if (session.getAttribute("region") != null) {
				regionLst = (String[]) session.getAttribute("region");
			}
			
			for (int i = 0; i < regionLst.length; i++) {
				rgnName = regionLst[i];
				if (rgnName.equals("ALL-REGIONS")
						&& session.getAttribute("usertype").toString().equals(
								"SBSUser")) {
					map = new HashMap();
					map = commonUtil.getRegion();
					break;
				} else {
					map.put(new Integer(i), rgnName);
				}

			}

			request.setAttribute("regionHashmap", map);
			request.setAttribute("empInfo", empPerinfo);
			rd = request.getRequestDispatcher("./PensionView/SBS/RefundofCorpusForm.jsp?menu="+menu);
			rd.forward(request, response);
		}else if(request.getParameter("method") != null
				&& request.getParameter("method").equals("getBajajForm")){
			String menu=request.getParameter("menu")!=null?request.getParameter("menu"):"";
			LoginInfo userinfo= (LoginInfo)request.getSession(false).getAttribute("user");
			//LicBean bean=null;
			if(userinfo.getProfile().equals("M")){
				empPerinfo=annuityService.getPersonalInfo(userinfo.getPensionNo());
				// bean=annuityService.getAnniutyFormDraft(userinfo.getPensionNo());
			}
			rd = request.getRequestDispatcher("./PensionView/SBS/BajajForm.jsp?menu="+menu);
			rd.forward(request, response);
		}
		else if(request.getParameter("method") != null
				&& request.getParameter("method").equals("getHDFCForm")){
			String menu=request.getParameter("menu")!=null?request.getParameter("menu"):"";
			LoginInfo userinfo= (LoginInfo)request.getSession(false).getAttribute("user");
			//LicBean bean=null;
			if(userinfo.getProfile().equals("M")){
				empPerinfo=annuityService.getPersonalInfo(userinfo.getPensionNo());
				// bean=annuityService.getAnniutyFormDraft(userinfo.getPensionNo());
			}
			request.setAttribute("empInfo", empPerinfo);
			rd = request.getRequestDispatcher("./PensionView/SBS/HDFCForm.jsp?menu="+menu);
			rd.forward(request, response);
		}
		else if(request.getParameter("method") != null
				&& request.getParameter("method").equals("lic1")){
			System.out.print("::::::::lic1"+request.getParameter("formType"));
			//ArrayList nomineeList=null;
			//ArrayList nomineeAppointeeList=null;
			LoginInfo userinfo= (LoginInfo)request.getSession(false).getAttribute("user");
			if(userinfo.getProfile().equals("M")){
				empPerinfo=annuityService.getPersonalInfo(userinfo.getPensionNo());
				  //nomineeList=request.getAttribute("nomineelist")!=null?(ArrayList)request.getAttribute("nomineelist"):new ArrayList();
				  //nomineeAppointeeList=request.getAttribute("nomineeAppointeelist")!=null?(ArrayList)request.getAttribute("nomineeAppointeelist"):new ArrayList();
				 // request.setAttribute("nomineelist",nomineeList);
				  //request.setAttribute("nomineeAppointeelist",nomineeAppointeeList);
			}
			
			request.setAttribute("empInfo", empPerinfo);
			String appId="";
			String saveMode=request.getParameter("savemode")!=null?request.getParameter("savemode"):"";
			
			String menu=request.getParameter("menu")!=null?request.getParameter("menu"):"";
			String memberName="",employeeNo="",dob="",doj="",exitReason="",dateOfexit="",chosenOp="",aaiEDCPSoption="";
			String spouseName="",spouseAdd="",spouseDob="",spouseRelation="",paymentMode="",formType="";
			String memberAddress="",memberPerAdd="",nomineeName="",relationtoMember="",nomineeDob="",panNo="",adharno="",mobilNo="",email="";
			String bankName="",branch="",ifscCode="",accType="",accNo="",micrCode="",airport="",region="";
			LicBean bean=new LicBean();
			
			String userName="",unitType="";
			userName=userinfo.getUserName();
			unitType=userinfo.getUnitType();
			bean.setUnitType(unitType);
			bean.setUserName(userName);
			memberName=request.getParameter("memberName")!=null?request.getParameter("memberName"):"";
			employeeNo=request.getParameter("pfId")!=null?request.getParameter("pfId"):"";
			dob=request.getParameter("dob")!=null?request.getParameter("dob"):"";
			doj=request.getParameter("doj")!=null?request.getParameter("doj"):"";
			exitReason=request.getParameter("sepReason")!=null?request.getParameter("sepReason"):"";
			dateOfexit=request.getParameter("sepDate")!=null?request.getParameter("sepDate"):"";
			chosenOp=request.getParameter("Option")!=null?request.getParameter("Option"):"";
			aaiEDCPSoption=request.getParameter("aaiedcpsOption")!=null?request.getParameter("aaiedcpsOption"):"";
			formType=request.getParameter("formType")!=null?request.getParameter("formType"):"";
			
			
			airport=request.getParameter("airport")!=null?request.getParameter("airport"):"";
			region=request.getParameter("region")!=null?request.getParameter("region"):"";
			bean.setRegion(region);
			bean.setAirport(airport);
			bean.setMemberName(memberName);
			bean.setEmployeeNo(employeeNo);
			bean.setDob(dob);
			bean.setDoj(doj);
			bean.setExitReason(exitReason);
			bean.setDateOfexit(dateOfexit);
			bean.setChosenOp(chosenOp);
			bean.setAaiEDCPSoption(aaiEDCPSoption);
			bean.setFormType(formType);
			
			
			spouseName=request.getParameter("spouseName")!=null?request.getParameter("spouseName"):"";
			spouseAdd=request.getParameter("spouseAdd")!=null?request.getParameter("spouseAdd"):"";
			spouseDob=request.getParameter("spouseDob")!=null?request.getParameter("spouseDob"):"";
			spouseRelation=request.getParameter("spouseType")!=null?request.getParameter("spouseType"):"";
			paymentMode=request.getParameter("apaymentMode")!=null?request.getParameter("apaymentMode"):"";
			
			bean.setSpouseName(spouseName);
			bean.setSpouseAdd(spouseAdd);
			bean.setSpouseDob(spouseDob);
			bean.setSpouseRelation(spouseRelation);
			bean.setPaymentMode(paymentMode);
			
			memberAddress=request.getParameter("address")!=null?request.getParameter("address"):"";
			memberPerAdd=request.getParameter("paddress")!=null?request.getParameter("paddress"):"";
			nomineeName=request.getParameter("nominee")!=null?request.getParameter("nominee"):"";
			relationtoMember=request.getParameter("relation")!=null?request.getParameter("relation"):"";
			nomineeDob=request.getParameter("nomineeDob")!=null?request.getParameter("nomineeDob"):"";
			panNo=request.getParameter("pan")!=null?request.getParameter("pan"):"";
			adharno=request.getParameter("adhar")!=null?request.getParameter("adhar"):"";
			mobilNo=request.getParameter("phoneNo")!=null?request.getParameter("phoneNo"):"";
			email=request.getParameter("email")!=null?request.getParameter("email"):"";
			
			bean.setMemberAddress(memberAddress);
			bean.setMemberPerAdd(memberPerAdd);
			bean.setNomineeName(nomineeName);
			bean.setRelationtoMember(relationtoMember);
			bean.setNomineeDob(nomineeDob);
			bean.setPanNo(panNo);
			bean.setAdharno(adharno);
			bean.setMobilNo(mobilNo);
			bean.setEmail(email);
			
			bankName=request.getParameter("bankName")!=null?request.getParameter("bankName"):"";
			branch=request.getParameter("branchAdd")!=null?request.getParameter("branchAdd"):"";
			ifscCode=request.getParameter("ifsc")!=null?request.getParameter("ifsc"):"";
			accType=request.getParameter("accType")!=null?request.getParameter("accType"):"";
			accNo=request.getParameter("accNo")!=null?request.getParameter("accNo"):"";
			micrCode=request.getParameter("micrCode")!=null?request.getParameter("micrCode"):"";
			bean.setBankName(bankName);
			bean.setBranch(branch);
			bean.setIfscCode(ifscCode);
			bean.setAccType(accType);
			bean.setAccNo(accNo);
			bean.setMicrCode(micrCode);
			System.out.println(":::::"+bean.getFormType());
			try{
			appId=annuityService.addLic1(bean);
			
			request.getSession(false).setAttribute("lic1", bean);
			request.setAttribute("memberName",memberName);
			request.setAttribute("pfid", employeeNo);
			request.setAttribute("appId",appId);
			if(saveMode.equals("Draft")){
				
				rd = request.getRequestDispatcher("./SBSAnnuityServlet?method=getForms&&menu="+menu);
				
			}else{
			request.setAttribute("form", "dir");
			rd = request.getRequestDispatcher("./PensionView/SBS/AnnuityForms.jsp?menu="+menu);
			}
			}catch(Exception e){
				System.out.println(":::Exp:!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"+e.getMessage());
				e.printStackTrace();
				request.setAttribute("error", e.getMessage());
				rd = request.getRequestDispatcher("./SBSAnnuityServlet?method=getForms&&menu="+menu);
				//rd.forward(request, response);
			}
			
			rd.forward(request, response);
		}else if(request.getParameter("method") != null
				&& request.getParameter("method").equals("dir")){
			LoginInfo userinfo= (LoginInfo)request.getSession(false).getAttribute("user");
			LicBean bean=null;
			ArrayList nomineeList=null;
			ArrayList nomineeAppointeeList=null;
			String appId="",pfid="";
			if(userinfo.getProfile().equals("M")){
				
				
				 
			}
			pfid=request.getParameter("pfid")!=null?request.getParameter("pfid"):"";
			empPerinfo=annuityService.getPersonalInfo(pfid);
			
			 bean=annuityService.getAnniutyFormDraft(pfid,"LIC");
			nomineeList=request.getAttribute("nomineelist")!=null?(ArrayList)request.getAttribute("nomineelist"):new ArrayList();
			  nomineeAppointeeList=request.getAttribute("nomineeAppointeelist")!=null?(ArrayList)request.getAttribute("nomineeAppointeelist"):new ArrayList();
			  request.setAttribute("nomineelist",nomineeList);
			  request.setAttribute("nomineeAppointeelist",nomineeAppointeeList);
			request.setAttribute("empInfo", empPerinfo);
			request.setAttribute("licBean", bean);
			
			appId=request.getParameter("appId")!=null?request.getParameter("appId"):"";
			
			String menu=request.getParameter("menu")!=null?request.getParameter("menu"):"";
			String bname="";
			bname=request.getParameter("bname")!=null?request.getParameter("bname"):"";
			request.setAttribute("memberName",bname);
			request.setAttribute("appId",appId);
			request.setAttribute("pfid",pfid);
			request.setAttribute("form", "nomineeForm");
			rd = request.getRequestDispatcher("./PensionView/SBS/AnnuityForms.jsp?menu="+menu);
			rd.forward(request, response);
		}else if(request.getParameter("method") != null
				&& request.getParameter("method").equals("nominee")){
			ArrayList nomineeList=null;
			ArrayList nomineeAppointeeList=null;
			String pfid="";
			ArrayList al=new ArrayList();
			LoginInfo userinfo= (LoginInfo)request.getSession(false).getAttribute("user");
			if(userinfo.getProfile().equals("M")){
				
				 
			}
			pfid=request.getParameter("pfid")!=null?request.getParameter("pfid"):"";
			empPerinfo=annuityService.getPersonalInfo(pfid);
			 nomineeList=request.getAttribute("nomineelist")!=null?(ArrayList)request.getAttribute("nomineelist"):new ArrayList();
			  nomineeAppointeeList=request.getAttribute("nomineeAppointeelist")!=null?(ArrayList)request.getAttribute("nomineeAppointeelist"):new ArrayList();
			  request.setAttribute("nomineelist",nomineeList);
			  request.setAttribute("nomineeAppointeelist",nomineeAppointeeList);
			request.setAttribute("empInfo", empPerinfo);
			
			String menu=request.getParameter("menu")!=null?request.getParameter("menu"):"";
			String appId="";
			appId=request.getParameter("appId")!=null?request.getParameter("appId"):"";
			
			
			String nomineeName="",address="",relationShip="",nomineeDob="",percentage="";
			String appointeeNameAdress="",appointeeRelationShip="",appointeeDob="";
			String nomineeDetails[]=null;
			String nomineeDetailsChild[]=null;
		/*	nomineeName=request.getParameter("nomineeName")!=null?request.getParameter("nomineeName"):"";
			address=request.getParameter("address")!=null?request.getParameter("address"):"";
			relationShip=request.getParameter("relationShip")!=null?request.getParameter("relationShip"):"";
			nomineeDob=request.getParameter("nomineeDob")!=null?request.getParameter("nomineeDob"):"";
			percentage=request.getParameter("percentage")!=null?request.getParameter("percentage"):"";
			*/
			System.out.println("nomineeDetails"+request.getParameterValues("nomineeDetails"));	
			if(request.getParameterValues("nomineeDetails")!=null) {     
				nomineeDetails=request.getParameterValues("nomineeDetails");
					System.out.print("nomineeDetails"+nomineeDetails);		
				int l=0;
				for(int i=0;i<nomineeDetails.length;i++) { 
							   
					StringTokenizer st1=new StringTokenizer(nomineeDetails[i],"|");
					if(st1.hasMoreTokens()) {   
											
						l++;
						nomineeName=st1.nextToken().trim();
						address=st1.nextToken().trim();
						nomineeDob=st1.nextToken().trim();
						relationShip=st1.nextToken().trim();
						
						percentage=st1.nextToken().trim();
			
			 appId=annuityService.addNominee(nomineeName,address,relationShip,nomineeDob,percentage,appId,"");
			}
				}}
			if(request.getParameterValues("nomineeDetailsChild")!=null) {     
				nomineeDetailsChild=request.getParameterValues("nomineeDetailsChild");
					System.out.print("nomineeDetailsChild"+nomineeDetailsChild);		
				int n=0;
				for(int i=0;i<nomineeDetailsChild.length;i++) { 
							   
					StringTokenizer st2=new StringTokenizer(nomineeDetailsChild[i],"|");
					if(st2.hasMoreTokens()) {   
											
						n++;
						appointeeNameAdress=st2.nextToken().trim();
						appointeeRelationShip=st2.nextToken().trim();
						appointeeDob=st2.nextToken().trim();
						
			
			 appId=annuityService.addNomineeAppointee(n,appointeeNameAdress,appointeeRelationShip,appointeeDob,appId,"","","");
			}
				}}
			annuityService.updateFormSubmit(appId);
			request.setAttribute("appId",appId);
			System.out.println("nominee::nominee"+pfid);
			al=annuityService.getAnniutyStatus(pfid);
			request.setAttribute("al", al);
			rd = request.getRequestDispatcher("./PensionView/SBS/AnnuityApplicationStatus.jsp?menu="+menu);
			rd.forward(request, response);
		}else if(request.getParameter("method") != null
				&& request.getParameter("method").equals("getAppStatus")){
			ArrayList al=new ArrayList();
			LoginInfo userinfo= (LoginInfo)request.getSession(false).getAttribute("user");
			
			
			String menu=request.getParameter("menu")!=null?request.getParameter("menu"):"";
			
			al=annuityService.getAnniutyStatus(userinfo.getPensionNo());
			request.setAttribute("al", al);
			
			rd = request.getRequestDispatcher("./PensionView/SBS/AnnuityApplicationStatus.jsp?menu="+menu);
			rd.forward(request, response);
		}else if(request.getParameter("method")!=null && request.getParameter("method").equals("addSBI")){
			System.out.println("addSBI::addSBI");
			String employeenumber="",primaryAnnuitantName="",gender="",dob="",paymentMode="",annuityOption="",secAnnuitantName="",secAnnuitantDob="",secAnnuitantRelation="",secAnnuitantPAN="";
			String priAnnuitantaddress="",cityTownVillage="",state="",pinCode="",pan="",mobile="",email="",fatherName="",nationality="";
			String acNo="",bankName="",branchAdd="",ifscCode="",accountType="",corpusAmt="",airport="",region="";
			String nomineeDetails[]=null;
			String nomineeDetailsChild[]=null;
			String nomineeName="",nomineeGender="",relationShip="",nomineeDob="",percentage="";
			String appointeeNameAdress="",appointeeRelationShip="",appointeeDob="",appointeeMobileNo="",appointeeAdress="";
			
			String menu=request.getParameter("menu")!=null?request.getParameter("menu"):"";
			String appId="";
			LicBean bean=new LicBean();
			employeenumber=request.getParameter("memberempno")!=null?request.getParameter("memberempno"):"";
			primaryAnnuitantName=request.getParameter("priAnnuitName")!=null?request.getParameter("priAnnuitName"):"";
			airport=request.getParameter("airport")!=null?request.getParameter("airport"):"";
			region=request.getParameter("region")!=null?request.getParameter("region"):"";
			
			dob=request.getParameter("dob")!=null?request.getParameter("dob"):"";
			paymentMode=request.getParameter("apaymentMode")!=null?request.getParameter("apaymentMode"):"";
			annuityOption=request.getParameter("aaiedcpsOption")!=null?request.getParameter("aaiedcpsOption"):"";
			secAnnuitantName=request.getParameter("secannuityname")!=null?request.getParameter("secannuityname"):"";
			secAnnuitantDob=request.getParameter("secannuitydob")!=null?request.getParameter("secannuitydob"):"";
			secAnnuitantRelation=request.getParameter("secannuityrelation")!=null?request.getParameter("secannuityrelation"):"";
			secAnnuitantPAN=request.getParameter("secannuitypan")!=null?request.getParameter("secannuitypan"):"";

			bean.setAirport(airport);
			bean.setRegion(region);
			bean.setEmployeeNo(employeenumber);
			bean.setMemberName(primaryAnnuitantName);
			bean.setDob(dob);
			bean.setPaymentMode(paymentMode);
			bean.setAaiEDCPSoption(annuityOption);
			bean.setSpouseName(secAnnuitantName);
			bean.setSpouseDob(secAnnuitantDob);
			bean.setSpouseRelation(secAnnuitantRelation);
			bean.setSecAnnuitantPAN(secAnnuitantPAN);
			
			
			
			gender=request.getParameter("gender")!=null?request.getParameter("gender"):"";
			priAnnuitantaddress=request.getParameter("annuadd")!=null?request.getParameter("annuadd"):"";
			cityTownVillage=request.getParameter("ctv")!=null?request.getParameter("ctv"):"";
			state=request.getParameter("state")!=null?request.getParameter("state"):"";
			pinCode=request.getParameter("pc")!=null?request.getParameter("pc"):"";
			mobile=request.getParameter("mno")!=null?request.getParameter("mno"):"";
			email=request.getParameter("eid")!=null?request.getParameter("eid"):"";
			pan=request.getParameter("panno")!=null?request.getParameter("panno"):"";
			fatherName=request.getParameter("FName")!=null?request.getParameter("FName"):"";
			nationality=request.getParameter("nation")!=null?request.getParameter("nation"):"";
			
			bean.setGender(gender);
			bean.setMemberPerAdd(priAnnuitantaddress);
			bean.setCtv(cityTownVillage);
			bean.setState(state);
			bean.setPinCode(pinCode);
			bean.setMobilNo(mobile);
			bean.setEmail(email);
			bean.setPanNo(pan);
			bean.setFatherName(fatherName);
			bean.setNationality(nationality);

			

			acNo=request.getParameter("acno")!=null?request.getParameter("acno"):"";
			bankName=request.getParameter("bname")!=null?request.getParameter("bname"):"";
			branchAdd=request.getParameter("badd")!=null?request.getParameter("badd"):"";
			ifscCode=request.getParameter("ifscode")!=null?request.getParameter("ifscode"):"";
			accountType=request.getParameter("acctype")!=null?request.getParameter("acctype"):"";
			corpusAmt=request.getParameter("corpusamt")!=null?request.getParameter("corpusamt"):"";
			
			bean.setAccNo(acNo);
			bean.setBankName(bankName);
			bean.setBranch(branchAdd);
			bean.setIfscCode(ifscCode);
			bean.setAccType(accountType);
			bean.setCorpusAmt(corpusAmt);
			LoginInfo userinfo= (LoginInfo)request.getSession(false).getAttribute("user");
			String userName="",unitType="";
			userName=userinfo.getUserName();
			unitType=userinfo.getUnitType();
			bean.setUnitType(unitType);
			bean.setUserName(userName);
			
			
			String formType=request.getParameter("formType")!=null?request.getParameter("formType"):"";
			bean.setFormType(formType);
			try {
				appId=annuityService.addSbi(bean);
			} catch (SBSException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			
			ArrayList al=new ArrayList();
			if(request.getParameterValues("nomineeDetails")!=null) {     
				nomineeDetails=request.getParameterValues("nomineeDetails");
					System.out.print("nomineeDetails"+nomineeDetails);		
				int l=0;
				for(int i=0;i<nomineeDetails.length;i++) { 
							   
					StringTokenizer st1=new StringTokenizer(nomineeDetails[i],"|");
					if(st1.hasMoreTokens()) {   
											
						l++;
						nomineeName=st1.nextToken().trim();
						nomineeGender=st1.nextToken().trim();
						nomineeDob=st1.nextToken().trim();
						relationShip=st1.nextToken().trim();
						
						percentage=st1.nextToken().trim();
			
			 appId=annuityService.addNominee(nomineeName,"",relationShip,nomineeDob,percentage,appId,nomineeGender);
			}
				}}
			if(request.getParameterValues("nomineeDetailsChild")!=null) {     
				nomineeDetailsChild=request.getParameterValues("nomineeDetailsChild");
					System.out.print("nomineeDetailsChild"+nomineeDetailsChild);		
				int n=0;
				for(int i=0;i<nomineeDetailsChild.length;i++) { 
							   
					StringTokenizer st2=new StringTokenizer(nomineeDetailsChild[i],"|");
					if(st2.hasMoreTokens()) {   
											
						n++;
						nomineeName=st2.nextToken().trim();
						appointeeNameAdress=st2.nextToken().trim();
						appointeeDob=st2.nextToken().trim();
						appointeeRelationShip=st2.nextToken().trim();
						appointeeMobileNo=st2.nextToken().trim();
						appointeeAdress=st2.nextToken().trim();
			
			 appId=annuityService.addNomineeAppointee(n,appointeeNameAdress,appointeeRelationShip,appointeeDob,appId,nomineeName,appointeeAdress,appointeeMobileNo);
			}
				}}
			request.setAttribute("appId",appId);
			System.out.println("nominee::nominee");
			al=annuityService.getAnniutyStatus(bean.getEmployeeNo());
			request.setAttribute("al", al);
			rd = request.getRequestDispatcher("./PensionView/SBS/AnnuityApplicationStatus.jsp?menu="+menu);
			rd.forward(request, response);
		}else if(request.getParameter("method")!=null && request.getParameter("method").equals("addHDFC")){
			System.out.println("HDFC:");
			String employeenumber="",primaryAnnuitantName="",gender="",dob="",paymentMode="",annuityOption="",secAnnuitantName="",secAnnuitantDob="",secAnnuitantRelation="",secAnnuitantPAN="";
			String priAnnuitantaddress="",cityTownVillage="",state="",pinCode="",pan="",mobile="",mobile1="",email="",fatherName="",nationality="";
			String acNo="",bankName="",branchAdd="",ifscCode="",accountType="",corpusAmt="",secAnnuitantGenger="",micrCode="";
			String nomineeDetails[]=null;
			String nomineeDetailsChild[]=null;
			String nomineeName="",nomineeGender="",relationShip="",nomineeDob="",percentage="",airport="",region="";
			String appointeeNameAdress="",appointeeRelationShip="",appointeeDob="",appointeeAdress="",appointeeMobileNo="";
			
			String menu=request.getParameter("menu")!=null?request.getParameter("menu"):"";
			String appId="";
			LicBean bean=new LicBean();
			
			LoginInfo userinfo= (LoginInfo)request.getSession(false).getAttribute("user");
			String userName="",unitType="";
			userName=userinfo.getUserName();
			unitType=userinfo.getUnitType();
			bean.setUnitType(unitType);
			bean.setUserName(userName);
			
			employeenumber=request.getParameter("memberempno")!=null?request.getParameter("memberempno"):"";
			primaryAnnuitantName=request.getParameter("priAnnuitName")!=null?request.getParameter("priAnnuitName"):"";
			
			dob=request.getParameter("dob")!=null?request.getParameter("dob"):"";
			paymentMode=request.getParameter("apaymentMode")!=null?request.getParameter("apaymentMode"):"";
			annuityOption=request.getParameter("aaiedcpsOption")!=null?request.getParameter("aaiedcpsOption"):"";
			secAnnuitantName=request.getParameter("secannuityname")!=null?request.getParameter("secannuityname"):"";
			secAnnuitantDob=request.getParameter("secannuitydob")!=null?request.getParameter("secannuitydob"):"";
			secAnnuitantRelation=request.getParameter("secannuityrelation")!=null?request.getParameter("secannuityrelation"):"";
			secAnnuitantPAN=request.getParameter("secannuitypan")!=null?request.getParameter("secannuitypan"):"";
			secAnnuitantGenger=request.getParameter("gendersecann")!=null?request.getParameter("gendersecann"):"";
			airport=request.getParameter("airport")!=null?request.getParameter("airport"):"";
			region=request.getParameter("region")!=null?request.getParameter("region"):"";
			
			bean.setRegion(region);
			bean.setAirport(airport);

			bean.setSecAnnuitantGender(secAnnuitantGenger);
			bean.setEmployeeNo(employeenumber);
			bean.setMemberName(primaryAnnuitantName);
			bean.setDob(dob);
			bean.setPaymentMode(paymentMode);
			bean.setAaiEDCPSoption(annuityOption);
			bean.setSpouseName(secAnnuitantName);
			bean.setSpouseDob(secAnnuitantDob);
			bean.setSpouseRelation(secAnnuitantRelation);
			bean.setSecAnnuitantPAN(secAnnuitantPAN);
			
			
			
			gender=request.getParameter("gender")!=null?request.getParameter("gender"):"";
			priAnnuitantaddress=request.getParameter("annuadd")!=null?request.getParameter("annuadd"):"";
			cityTownVillage=request.getParameter("ctv")!=null?request.getParameter("ctv"):"";
			state=request.getParameter("state")!=null?request.getParameter("state"):"";
			pinCode=request.getParameter("pc")!=null?request.getParameter("pc"):"";
			mobile=request.getParameter("mno")!=null?request.getParameter("mno"):"";
			mobile1=request.getParameter("mno1")!=null?request.getParameter("mno1"):"";
			email=request.getParameter("eid")!=null?request.getParameter("eid"):"";
			pan=request.getParameter("panno")!=null?request.getParameter("panno"):"";
			fatherName=request.getParameter("FName")!=null?request.getParameter("FName"):"";
			nationality=request.getParameter("nation")!=null?request.getParameter("nation"):"";
			
			bean.setGender(gender);
			bean.setMemberPerAdd(priAnnuitantaddress);
			bean.setCtv(cityTownVillage);
			bean.setState(state);
			bean.setPinCode(pinCode);
			bean.setMobilNo(mobile);
			bean.setMobilNo1(mobile1);
			bean.setEmail(email);
			bean.setPanNo(pan);
			bean.setFatherName(fatherName);
			bean.setNationality(nationality);

			

			acNo=request.getParameter("acno")!=null?request.getParameter("acno"):"";
			bankName=request.getParameter("bname")!=null?request.getParameter("bname"):"";
			branchAdd=request.getParameter("badd")!=null?request.getParameter("badd"):"";
			ifscCode=request.getParameter("ifscode")!=null?request.getParameter("ifscode"):"";
			accountType=request.getParameter("acctype")!=null?request.getParameter("acctype"):"";
			micrCode=request.getParameter("micode")!=null?request.getParameter("micode"):"";
			corpusAmt=request.getParameter("corpusamt")!=null?request.getParameter("corpusamt"):"";
			
			bean.setAccNo(acNo);
			bean.setBankName(bankName);
			bean.setBranch(branchAdd);
			bean.setIfscCode(ifscCode);
			bean.setAccType(accountType);
			bean.setCorpusAmt(corpusAmt);
			bean.setMicrCode(micrCode);
			
			String formType=request.getParameter("formType")!=null?request.getParameter("formType"):"";
			bean.setFormType(formType);
			try {
				appId=annuityService.addHdfc(bean);
			} catch (SBSException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			
			ArrayList al=new ArrayList();
			System.out.print("nomineeDetails"+nomineeDetails);
			if(request.getParameterValues("nomineeDetails")!=null) {     
				nomineeDetails=request.getParameterValues("nomineeDetails");
					System.out.print("nomineeDetails"+nomineeDetails);		
				int l=0;
				for(int i=0;i<nomineeDetails.length;i++) { 
							   
					StringTokenizer st1=new StringTokenizer(nomineeDetails[i],"|");
					if(st1.hasMoreTokens()) {   
											
						l++;
						nomineeName=st1.nextToken().trim();
						nomineeGender=st1.nextToken().trim();
						nomineeDob=st1.nextToken().trim();
						relationShip=st1.nextToken().trim();
						
						percentage=st1.nextToken().trim();
			
			 appId=annuityService.addNominee(nomineeName,"",relationShip,nomineeDob,percentage,appId,nomineeGender);
			}
				}}
			System.out.print("nomineeDetailsChild"+nomineeDetailsChild);
			if(request.getParameterValues("nomineeDetailsChild")!=null) {     
				nomineeDetailsChild=request.getParameterValues("nomineeDetailsChild");
					System.out.print("nomineeDetailsChild"+nomineeDetailsChild);		
				int n=0;
				for(int i=0;i<nomineeDetailsChild.length;i++) { 
							   
					StringTokenizer st2=new StringTokenizer(nomineeDetailsChild[i],"|");
					if(st2.hasMoreTokens()) {   
											
						n++;
						nomineeName=st2.nextToken().trim();
						appointeeNameAdress=st2.nextToken().trim();
						appointeeDob=st2.nextToken().trim();
						appointeeRelationShip=st2.nextToken().trim();
						appointeeMobileNo=st2.nextToken().trim();
						appointeeAdress=st2.nextToken().trim();
						
			
			 appId=annuityService.addNomineeAppointee(n,appointeeNameAdress,appointeeRelationShip,appointeeDob,appId,nomineeName,appointeeAdress,appointeeMobileNo);
			}
				}}
			request.setAttribute("appId",appId);
			System.out.println("nominee::nominee");
			al=annuityService.getAnniutyStatus(bean.getEmployeeNo());
			request.setAttribute("al", al);
			rd = request.getRequestDispatcher("./PensionView/SBS/AnnuityApplicationStatus.jsp?menu="+menu);
			rd.forward(request, response);
		}else if(request.getParameter("method")!=null && request.getParameter("method").equals("addBajaj")){
			System.out.println("Bajaj:");
			
			String checkDDdate="",checkDDno="";
			String employeenumber="",primaryAnnuitantName="",gender="",dob="",paymentMode="",annuityOption="",secAnnuitantName="",secAnnuitantDob="",secAnnuitantRelation="",secAnnuitantPAN="";
			String priAnnuitantaddress="",cityTownVillage="",state="",pinCode="",pan="",mobile="",email="",fatherName="",nationality="";
			String acNo="",bankName="",branchAdd="",ifscCode="",accountType="",corpusAmt="",secAnnuitantGenger="",micrCode="";
			String nomineeDetails[]=null;
			String nomineeDetailsChild[]=null;
			String nomineeName="",nomineeGender="",relationShip="",nomineeDob="",percentage="",airport="",region="";
			String appointeeNameAdress="",appointeeRelationShip="",appointeeDob="",appointeeAdress="",appointeeMobileNo="";
			
			String menu=request.getParameter("menu")!=null?request.getParameter("menu"):"";
			String appId="";
			LicBean bean=new LicBean();
			
			employeenumber=request.getParameter("PFID")!=null?request.getParameter("PFID"):"";
			primaryAnnuitantName=request.getParameter("policyholdername")!=null?request.getParameter("policyholdername"):"";
			
			
			annuityOption=request.getParameter("aaiedcpsOption")!=null?request.getParameter("aaiedcpsOption"):"";
			corpusAmt=request.getParameter("purchaseprice")!=null?request.getParameter("purchaseprice"):"";
			checkDDdate=request.getParameter("checkdddate")!=null?request.getParameter("checkdddate"):"";
			paymentMode=request.getParameter("apaymentMode")!=null?request.getParameter("apaymentMode"):"";
			checkDDno=request.getParameter("checkddno")!=null?request.getParameter("checkddno"):"";
			airport=request.getParameter("airport")!=null?request.getParameter("airport"):"";
			region=request.getParameter("region")!=null?request.getParameter("region"):"";
			
			
			
			

			bean.setRegion(region);
			bean.setAirport(airport);
			bean.setDdDate(checkDDdate);
			bean.setDdNo(checkDDno);
		
			bean.setEmployeeNo(employeenumber);
			bean.setMemberName(primaryAnnuitantName);
			bean.setCorpusAmt(corpusAmt);
			bean.setPaymentMode(paymentMode);
			bean.setAaiEDCPSoption(annuityOption);
			
			
			/*dob=request.getParameter("dob")!=null?request.getParameter("dob"):"";
			
			secAnnuitantName=request.getParameter("secannuityname")!=null?request.getParameter("secannuityname"):"";
			secAnnuitantDob=request.getParameter("secannuitydob")!=null?request.getParameter("secannuitydob"):"";
			secAnnuitantRelation=request.getParameter("secannuityrelation")!=null?request.getParameter("secannuityrelation"):"";
			secAnnuitantPAN=request.getParameter("secannuitypan")!=null?request.getParameter("secannuitypan"):"";
			secAnnuitantGenger=request.getParameter("gendersecann")!=null?request.getParameter("gendersecann"):"";
			
			
			bean.setRegion(region);
			bean.setAirport(airport);

			bean.setSecAnnuitantGender(secAnnuitantGenger);
			bean.setEmployeeNo(employeenumber);
			bean.setMemberName(primaryAnnuitantName);
			bean.setDob(dob);
			bean.setPaymentMode(paymentMode);
			bean.setAaiEDCPSoption(annuityOption);
			bean.setSpouseName(secAnnuitantName);
			bean.setSpouseDob(secAnnuitantDob);
			bean.setSpouseRelation(secAnnuitantRelation);
			bean.setSecAnnuitantPAN(secAnnuitantPAN);
			
			
			
			gender=request.getParameter("gender")!=null?request.getParameter("gender"):"";
			priAnnuitantaddress=request.getParameter("annuadd")!=null?request.getParameter("annuadd"):"";
			cityTownVillage=request.getParameter("ctv")!=null?request.getParameter("ctv"):"";
			state=request.getParameter("state")!=null?request.getParameter("state"):"";
			pinCode=request.getParameter("pc")!=null?request.getParameter("pc"):"";
			mobile=request.getParameter("mno")!=null?request.getParameter("mno"):"";
			email=request.getParameter("eid")!=null?request.getParameter("eid"):"";
			pan=request.getParameter("panno")!=null?request.getParameter("panno"):"";
			fatherName=request.getParameter("FName")!=null?request.getParameter("FName"):"";
			nationality=request.getParameter("nation")!=null?request.getParameter("nation"):"";
			
			bean.setGender(gender);
			bean.setMemberPerAdd(priAnnuitantaddress);
			bean.setCtv(cityTownVillage);
			bean.setState(state);
			bean.setPinCode(pinCode);
			bean.setMobilNo(mobile);
			bean.setEmail(email);
			bean.setPanNo(pan);
			bean.setFatherName(fatherName);
			bean.setNationality(nationality);

			*/

			acNo=request.getParameter("acno")!=null?request.getParameter("acno"):"";
			bankName=request.getParameter("bankname")!=null?request.getParameter("bankname"):"";
			branchAdd=request.getParameter("branch")!=null?request.getParameter("branch"):"";
			ifscCode=request.getParameter("ifsc")!=null?request.getParameter("ifsc"):"";
			accountType=request.getParameter("acctype")!=null?request.getParameter("acctype"):"";
			micrCode=request.getParameter("micrcode")!=null?request.getParameter("micrcode"):"";
			
			
			bean.setAccNo(acNo);
			bean.setBankName(bankName);
			bean.setBranch(branchAdd);
			bean.setIfscCode(ifscCode);
			bean.setAccType(accountType);
			
			bean.setMicrCode(micrCode);
			
			String formType=request.getParameter("formType")!=null?request.getParameter("formType"):"";
			bean.setFormType(formType);
			try {
				appId=annuityService.addBajaj(bean);
			} catch (SBSException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			
			ArrayList al=new ArrayList();
			System.out.print("nomineeDetails"+nomineeDetails);
			if(request.getParameterValues("nomineeDetails")!=null) {     
				nomineeDetails=request.getParameterValues("nomineeDetails");
					System.out.print("nomineeDetails"+nomineeDetails);		
				int l=0;
				for(int i=0;i<nomineeDetails.length;i++) { 
							   
					StringTokenizer st1=new StringTokenizer(nomineeDetails[i],"|");
					if(st1.hasMoreTokens()) {   
											
						l++;
						nomineeName=st1.nextToken().trim();
						nomineeGender=st1.nextToken().trim();
						nomineeDob=st1.nextToken().trim();
						relationShip=st1.nextToken().trim();
						
						percentage=st1.nextToken().trim();
			
			 appId=annuityService.addNominee(nomineeName,"",relationShip,nomineeDob,percentage,appId,nomineeGender);
			}
				}}
			System.out.print("nomineeDetailsChild"+nomineeDetailsChild);
			if(request.getParameterValues("nomineeDetailsChild")!=null) {     
				nomineeDetailsChild=request.getParameterValues("nomineeDetailsChild");
					System.out.print("nomineeDetailsChild"+nomineeDetailsChild);		
				int n=0;
				for(int i=0;i<nomineeDetailsChild.length;i++) { 
							   
					StringTokenizer st2=new StringTokenizer(nomineeDetailsChild[i],"|");
					if(st2.hasMoreTokens()) {   
											
						n++;
						nomineeName=st2.nextToken().trim();
						appointeeNameAdress=st2.nextToken().trim();
						appointeeDob=st2.nextToken().trim();
						appointeeRelationShip=st2.nextToken().trim();
						appointeeMobileNo=st2.nextToken().trim();
						appointeeAdress=st2.nextToken().trim();
						
			
			 appId=annuityService.addNomineeAppointee(n,appointeeNameAdress,appointeeRelationShip,appointeeDob,appId,nomineeName,appointeeAdress,appointeeMobileNo);
			}
				}}
			request.setAttribute("appId",appId);
			System.out.println("nominee::nominee");
			al=annuityService.getAnniutyStatus(bean.getEmployeeNo());
			request.setAttribute("al", al);
			rd = request.getRequestDispatcher("./PensionView/SBS/AnnuityApplicationStatus.jsp?menu="+menu);
			rd.forward(request, response);
		}else if(request.getParameter("method")!=null && request.getParameter("method").equals("addRefundCurps")){
			System.out.println("addRefundCurps::addRefundCurps");
			String region="",airport="",memberempno="",priAnnuitName="",designation="",dos="",mobileno="",emailid="",nomineename="",empname="",accountno="",bankname="";
			String Micrcode="",branchaddr="",ifsccode="",cdate="",aaiEDCPSoption="";String annuityOption="";String nomineename2="";String nomineename3="";
			String menu=request.getParameter("menu")!=null?request.getParameter("menu"):"";
			String appId="",empsapcode="";
			LicBean bean=new LicBean();
			region=request.getParameter("select_region")!=null?request.getParameter("select_region"):"";
			System.out.println("region"+region);
			airport=request.getParameter("select_airport")!=null?request.getParameter("select_airport"):"";
			System.out.println("airport"+airport);
			memberempno=request.getParameter("memberempno")!=null?request.getParameter("memberempno"):"";
			System.out.println("memberempno"+memberempno);
			priAnnuitName=request.getParameter("priAnnuitName")!=null?request.getParameter("priAnnuitName"):"";
			System.out.println("priAnnuitName"+priAnnuitName);
		    designation=request.getParameter("designation")!=null?request.getParameter("designation"):"";
		    System.out.println("designation"+designation);
		    dos=request.getParameter("dos")!=null?request.getParameter("dos"):"";
		    System.out.println("dos"+dos);
		    empsapcode=request.getParameter("sapempcode")!=null?request.getParameter("sapempcode"):"";
		    mobileno=request.getParameter("mobileno")!=null?request.getParameter("mobileno"):"";
		    System.out.println("mobileno"+mobileno);
		    emailid=request.getParameter("emailid")!=null?request.getParameter("emailid"):"";
		    System.out.println("emailid"+emailid);
		    nomineename=request.getParameter("nomineename")!=null?request.getParameter("nomineename"):"";
		    System.out.println("nomineename"+nomineename);
		    nomineename2=request.getParameter("nomineename2")!=null?request.getParameter("nomineename2"):"";
		    System.out.println("nomineename1"+nomineename2);
		    nomineename3=request.getParameter("nomineename3")!=null?request.getParameter("nomineename3"):"";
		    System.out.println("nomineename"+nomineename);
		    empname=request.getParameter("empname")!=null?request.getParameter("empname"):"";
		    System.out.println("empname"+empname);
		    accountno=request.getParameter("accountno")!=null?request.getParameter("accountno"):"";
		    System.out.println("accountno"+accountno);
		    bankname=request.getParameter("bankname")!=null?request.getParameter("bankname"):"";
		    System.out.println("bankname"+bankname);
		    Micrcode=request.getParameter("Micrcode")!=null?request.getParameter("Micrcode"):"";
		    System.out.println("Micrcode"+Micrcode);
		    branchaddr=request.getParameter("branchaddr")!=null?request.getParameter("branchaddr"):"";
		    System.out.println("branchaddr"+branchaddr);
		    ifsccode=request.getParameter("ifsccode")!=null?request.getParameter("ifsccode"):"";
		    System.out.println("ifsccode"+ifsccode);
		    String empname1=request.getParameter("empname1")!=null?request.getParameter("empname1"):"";
		    String accountno1=request.getParameter("accountno1")!=null?request.getParameter("accountno1"):"";
		    String bankname1=request.getParameter("bankname1")!=null?request.getParameter("bankname1"):"";
		    String Micrcode1=request.getParameter("Micrcode1")!=null?request.getParameter("Micrcode1"):"";
		    String branchaddr1=request.getParameter("branchaddr1")!=null?request.getParameter("branchaddr1"):"";
		    String ifsccode1=request.getParameter("ifsccode1")!=null?request.getParameter("ifsccode1"):"";
		    cdate=request.getParameter("cdate")!=null?request.getParameter("cdate"):"";
		    System.out.println("cdate"+cdate);
		    annuityOption=request.getParameter("aaiedcpsOption")!=null?request.getParameter("aaiedcpsOption"):"";
		    bean.setAirport(airport);
			bean.setRegion(region);
			bean.setEmployeeNo(memberempno);
			bean.setMemberName(priAnnuitName);
			bean.setDesignation(designation);               
			bean.setDos(dos);
			bean.setEmpsapCode(empsapcode);
			bean.setMobilNo(mobileno);
			bean.setEmail(emailid);
			bean.setNomineeName(nomineename);
			bean.setNomineeName2(nomineename2);
			bean.setNomineeName3(nomineename3);
			bean.setFindisplayname(empname);
			bean.setAccNo(accountno);
			bean.setBankName(bankname);
			bean.setMicrCode(Micrcode);
			bean.setBranch(branchaddr);
			bean.setAaiEDCPSoption(annuityOption);
			bean.setIfscCode(ifsccode);
			bean.setCustomerName2(empname1);
			bean.setAccNo2(accountno1);
			bean.setBankName2(bankname1);
			bean.setMicrCode2(Micrcode1);
			bean.setBranch2(branchaddr1);
			bean.setIfscCode2(ifsccode1);
			bean.setAaiEDCPSoption(annuityOption);
			bean.setIfscCode(ifsccode);
			bean.setPolicyStartDate(cdate);
			LoginInfo userinfo= (LoginInfo)request.getSession(false).getAttribute("user");
			String userName="",unitType="";
			userName=userinfo.getUserName();
			unitType=userinfo.getUnitType();
			bean.setUnitType(unitType);
			bean.setUserName(userName);
			System.out.println("userName"+userName);
			System.out.println("unitType"+unitType);
			
			String formType=request.getParameter("formType")!=null?request.getParameter("formType"):"";
			bean.setFormType(formType);
			try {
				appId=annuityService.addRefundCurps(bean);
			} catch (SBSException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			ArrayList al=new ArrayList();
			request.setAttribute("appId",appId);
			System.out.println("nominee::nominee");
			al=annuityService.getAnniutyStatus(bean.getEmployeeNo());
			request.setAttribute("al", al);
			rd = request.getRequestDispatcher("./PensionView/SBS/AnnuityApplicationStatus.jsp?menu="+menu);
			rd.forward(request, response);
		}else if (request.getParameter("method").equals("finalsettlement")) {
			CommonUtil commonUtil = new CommonUtil();
			ArrayList regionList = new ArrayList();
			String rgnName = "";
			HashMap map = new HashMap();
			String[] regionLst = null;
			HttpSession session=request.getSession();
			if (session.getAttribute("region") != null) {
				regionLst = (String[]) session.getAttribute("region");
			}
			
			for (int i = 0; i < regionLst.length; i++) {
				rgnName = regionLst[i];
				if (rgnName.equals("ALL-REGIONS")
						&& session.getAttribute("usertype").toString().equals(
								"SBSUser")) {
					map = new HashMap();
					map = commonUtil.getRegion();
					break;
				} else {
					map.put(new Integer(i), rgnName);
				}

			}

			request.setAttribute("regionHashmap", map);
		
			if (request.getParameter("method").equals("finalsettlement")) {
				rd = request
						.getRequestDispatcher("./PensionView/SBS/SBSFinalSettlementParam.jsp");
			}
			rd.forward(request, response);

		}else if(request.getParameter("method") != null
				&& request.getParameter("method").equals(
				"finalsettlementreport")) {

	String region = "", airport = "", pfid = "", fromdate = "", todate = "",reportType="",month="",year="",finyear="";

	ArrayList sbsFinalsettlementList = new ArrayList();

	if (request.getParameter("fromdate") != null) {
		fromdate = request.getParameter("fromdate");
	}
	if (request.getParameter("todate") != null ) {
		todate = request.getParameter("todate");
	}
	//System.out.println(todate+todate);
	if (request.getParameter("region") != null && !request.getParameter("region").equals("[Select One]")) {
		region = request.getParameter("region");
	}
	
	if (request.getParameter("airPortCode") != null && !request.getParameter("airPortCode").equals("[Select One]")) {
		airport = request.getParameter("airPortCode");
	}
	if(request.getParameter("frm_reportType") != null){
		reportType=request.getParameter("frm_reportType");
	}
	if(request.getParameter("month") != null){
		month=request.getParameter("month");
	}
	
	if(request.getParameter("year") != null){
		year=request.getParameter("year");
	}
	
	if(request.getParameter("finyear") != null){
		finyear=request.getParameter("finyear");
	}
	
	
	

	sbsFinalsettlementList = annuityService.getFinalsettlementdata(fromdate,todate,region, airport,month,year,finyear
			);
	request.setAttribute("sbsList", sbsFinalsettlementList);
	
	request.setAttribute("region", region);
	request.setAttribute("airport", airport);
	request.setAttribute("reportType", reportType);

	 rd = request
			.getRequestDispatcher("./PensionView/SBS/SBSFinalSettlementReport.jsp?menu=M7L1");
	
	 rd.forward(request, response);
}else if(request.getParameter("method") != null
		&& request.getParameter("method").equals(
		"policydocument")) {

	String menu=request.getParameter("menu")!=null?request.getParameter("menu"):"";
	LoginInfo userinfo= (LoginInfo)request.getSession(false).getAttribute("user");
	//LicBean bean=null;
	if(userinfo.getProfile().equals("M")){
		empPerinfo=annuityService.getPersonalInfo(userinfo.getPensionNo());
		// bean=annuityService.getAnniutyFormDraft(userinfo.getPensionNo());
	}
	request.setAttribute("empInfo", empPerinfo);
	rd = request.getRequestDispatcher("./PensionView/SBS/PolicyDocument.jsp?menu="+menu);
	rd.forward(request, response);
}
else if(request.getParameter("method") != null && request.getParameter("method").equals( "RefundJV")) {

String menu=request.getParameter("menu")!=null?request.getParameter("menu"):"";
LoginInfo userinfo= (LoginInfo)request.getSession(false).getAttribute("user");
if(userinfo.getProfile().equals("M")){
empPerinfo=annuityService.getPersonalInfo(userinfo.getPensionNo());
}
request.setAttribute("empInfo", empPerinfo);
rd = request.getRequestDispatcher("./PensionView/SBS/RefundJV.jsp?menu="+menu);
rd.forward(request, response);
}else if(request.getParameter("method") != null && request.getParameter("method").equals( "RefundJournalVoucher")) {

	String  pfid = "",reportType="";

	
	//sbsFinalsettlementList = annuityService.getJournalVoucher(pfid);
	request.setAttribute("reportType", reportType);
	LicBean bean=new LicBean();
	String Jvid="";
	if (request.getParameter("empserialNO") != null) {
		pfid = request.getParameter("empserialNO");
	}
	if (request.getParameter("frm_reportType") != null) {
		reportType = request.getParameter("frm_reportType");
	}
	LoginInfo userinfo= (LoginInfo)request.getSession(false).getAttribute("user");
	String userName="",unitType="";
	userName=userinfo.getUserName();
	unitType=userinfo.getUnitType();

try {
		
		Jvid=annuityService.addJournalVoucher(pfid,userName,unitType);
	} catch (SBSException e) {
		// TODO Auto-generated catch block
		e.printStackTrace();
	}
 
 bean=annuityService.getJournalVoucher(Jvid);
request.setAttribute("licBean", bean);
request.setAttribute("Jvid",Jvid);

rd = request.getRequestDispatcher("./PensionView/SBS/RefundJVReport.jsp?menu=M8L1");
rd.forward(request, response);

}
else if(request.getParameter("method") != null && request.getParameter("method").equals( "JournalVoucherReport")) {

	String  jvid = "",reportType="";

	System.out.println("====JournalVoucherReport=====");
	
	request.setAttribute("reportType", reportType);
	LicBean bean=new LicBean();
	String Jvid="";
	System.out.println("request.getParameter JV Number====="+request.getParameter("jvno"));
	if (request.getParameter("jvno") != null) {
		jvid = request.getParameter("jvno");
	}
	System.out.println("Jvid==="+Jvid);
bean=annuityService.getJournalVoucher(request.getParameter("jvno"));
request.setAttribute("licBean", bean);
request.setAttribute("Jvid",Jvid);

rd = request.getRequestDispatcher("./PensionView/SBS/RefundJVReport.jsp?menu=M8L1");
rd.forward(request, response);
}
else if(request.getParameter("method") != null
&& request.getParameter("method").equals("JournalVocherSRCH")){
String menu=request.getParameter("menu")!=null?request.getParameter("menu"):"";
LoginInfo userinfo= (LoginInfo)request.getSession(false).getAttribute("user");
String unitcd="";String unittype="";
unitcd=userinfo.getUnitCd();
unittype=userinfo.getUnitType();
ArrayList list=annuityService.getJournalVocherSRCH(unitcd,unittype);
request.setAttribute("list", list);
rd = request.getRequestDispatcher("./PensionView/SBS/JournalVoucherSearch.jsp?menu="+menu);
rd.forward(request, response);
}
else if(request.getParameter("method") != null && request.getParameter("method").equals( "paymentvocher")) {

String menu=request.getParameter("menu")!=null?request.getParameter("menu"):"";
LoginInfo userinfo= (LoginInfo)request.getSession(false).getAttribute("user");
if(userinfo.getProfile().equals("M")){
empPerinfo=annuityService.getPersonalInfo(userinfo.getPensionNo());
}
request.setAttribute("empInfo", empPerinfo);
rd = request.getRequestDispatcher("./PensionView/SBS/paymentvocher.jsp?menu="+menu);
rd.forward(request, response);
}else if(request.getParameter("method") != null && request.getParameter("method").equals( "Refundpaymentvocher")) {

	String  pfid = "",reportType="";

	ArrayList sbsFinalsettlementList = new ArrayList();

	if (request.getParameter("empserialNO") != null) {
		pfid = request.getParameter("empserialNO");
	}
	if (request.getParameter("frm_reportType") != null) {
		reportType = request.getParameter("frm_reportType");
	}
	//sbsFinalsettlementList = annuityService.getJournalVoucher(pfid);
	request.setAttribute("sbsList", sbsFinalsettlementList);
	request.setAttribute("reportType", reportType);

	 rd = request
			.getRequestDispatcher("./PensionView/SBS/paymentvocherReport.jsp?menu=M8L1");
	 rd.forward(request, response);
}else if(request.getParameter("method") != null
		&& request.getParameter("method").equals(
		"getAnnuityHelp")) {
	String path = "", screen = "";
	
	String empName = request.getParameter("empName").toString().trim();
	String pfId = request.getParameter("pfId").toString().trim();
	String appid = request.getParameter("appid").toString().trim();

	ArrayList list = new ArrayList();
	

		list = annuityService.getAnnuityHelp( empName.trim(),
				 pfId, appid);
	
		request.setAttribute("MappedList", list);

				path = "./PensionView/SBS/SBSAnnuityAppHelp.jsp";	
			
		 rd = request.getRequestDispatcher(path);
		 rd.forward(request, response);
		
}
else if(request.getParameter("method") != null
&& request.getParameter("method").equals(
"getJvHelp")){
String path = "", screen = "";

String empName = request.getParameter("empName").toString().trim();
String pfId = request.getParameter("pfId").toString().trim();
String appid = request.getParameter("appid").toString().trim();

ArrayList list = new ArrayList();


list = annuityService.getJvHelp( empName.trim(),
		 pfId, appid);

request.setAttribute("MappedList", list);

		path = "./PensionView/SBS/JVEmployees.jsp";	
	
 rd = request.getRequestDispatcher(path);
 rd.forward(request, response);
}else if (request.getParameter("method").equals("JournalVocherRpt")) {
	ArrayList regionList = new ArrayList();
	String rgnName = "";
	HashMap map = new HashMap();
	String[] regionLst = null;
	HttpSession session = request.getSession();
	if (session.getAttribute("region") != null) {
		regionLst = (String[]) session.getAttribute("region");
	}
	System.out.println("Regions List" + regionLst.length);
	for (int i = 0; i < regionLst.length; i++) {
		rgnName = regionLst[i];
		if (rgnName.equals("ALL-REGIONS")
				&& session.getAttribute("usertype").toString().equals(
						"SBSUser")) {
			map = new HashMap();
			CommonUtil commonUtil = new CommonUtil();
			map = commonUtil.getRegion();
			break;
		} else {
			map.put(new Integer(i), rgnName);
		}

	}

	request.setAttribute("regionHashmap", map);
	
		rd = request
				.getRequestDispatcher("./PensionView/SBS/JournalVocherRptParam.jsp");
	
	rd.forward(request, response);

} else if (request.getParameter("method") != null
			&& request.getParameter("method").equals(
					"JournalVocherReport")) {

		String region = "", airport = "", reportType="";

		ArrayList sbsList = new ArrayList();

		
		
		if (request.getParameter("region") != null && !request.getParameter("region").equals("[Select One]")) {
			region = request.getParameter("region");
		}
		
		if (request.getParameter("airPortCode") != null && !request.getParameter("airPortCode").equals("[Select One]")) {
			airport = request.getParameter("airPortCode");
		}
		
		
		if(request.getParameter("frm_reportType") != null){
			reportType=request.getParameter("frm_reportType");
		}
		
		
		
		System.out.println("region:::::::"+region);

		ArrayList sbsFinalsettlementList = new ArrayList();

		sbsFinalsettlementList = annuityService.getJournalVocherReport(region,airport);
		request.setAttribute("sbsList", sbsFinalsettlementList);
		System.out.println("list=servlet="+sbsFinalsettlementList.size());
		request.setAttribute("region", region);
		request.setAttribute("airport", airport);
		request.setAttribute("reportType", reportType);

		 rd = request
				.getRequestDispatcher("./PensionView/SBS/JournalVocherReport.jsp?menu=M8L3");
		 rd.forward(request, response);
	}
else if(request.getParameter("method") != null
		&& request.getParameter("method").equals(
		"insertPolicydoc")){
	String pfId = request.getParameter("pfid").toString().trim();
	String appid = request.getParameter("appid").toString().trim();
	String annuityprovider = request.getParameter("formtype").toString().trim();
	String purchaseamt = request.getParameter("corpusamt").toString().trim();
	String gst = request.getParameter("gst").toString().trim();
	String policyno = request.getParameter("policyno").toString().trim();
	String policydate = request.getParameter("policydate").toString().trim();
	String policyamt = request.getParameter("policyamt").toString().trim();
	String debit = request.getParameter("debit").toString().trim();
	String credit = request.getParameter("credit").toString().trim();
	int n=0;
	String path="";
	String menu=request.getParameter("menu")!=null?request.getParameter("menu"):"";
	
	
	String fileName="";
	if (request.getParameter("fileName") != null) {
		fileName = request.getParameter("fileName");
	}
	 	String contentType = request.getContentType();

			System.out.println("Content type is :: " + contentType);
			String saveFile = "", dir = "", file = "", filePath = "", slashsuffix = "";
			int start = 0, end = 0;

			ResourceBundle appbundle = ResourceBundle
					.getBundle("aims.resource.ApplicationResouces");
			//slashsuffix = appbundle
					//.getString("upload.folder.path.sbs");
			String folderPath = appbundle
					.getString("upload.folder.path.sbs.policy");

			File filePath1 = new File(folderPath);
			if (!filePath1.exists()) {
				filePath1.mkdirs();
			}

			if ((contentType != null)
					&& (contentType.indexOf("multipart/form-data") >= 0)) {

				DataInputStream in = new DataInputStream(request
						.getInputStream());

				int formDataLength = request.getContentLength();

				byte dataBytes[] = new byte[formDataLength];
				int byteRead = 0;
				int totalBytesRead = 0;
				while (totalBytesRead < formDataLength) {
					byteRead = in.read(dataBytes, totalBytesRead,
							formDataLength);
					// log.info("byteRead"+byteRead);
					totalBytesRead += byteRead;
				}
				file = new String(dataBytes);
				// start = file.indexOf("filename=\"")+10;
				start = file.indexOf("filename=\"") + 10;
				System.out.println("=start=" + start);
				end = file.indexOf(".pdf");
				System.out.println("=end=" + end);

				if (file.indexOf(".mdb") != -1) {
					end = file.indexOf(".mdb");
					System.out.println("=end=" + end);
				}

				file = new String(dataBytes);
				saveFile = file
						.substring(file.indexOf("filename=\"") + 10);
				saveFile = saveFile
						.substring(0, saveFile.indexOf("\n"));
				saveFile = saveFile.substring(saveFile
						.lastIndexOf("\\") + 1, saveFile.indexOf("\""));
				// we are added datetime as suffix in the file name

				System.out.println("File Name" + saveFile);
				saveFile="Policy_"+pfId+".pdf";
				int lastIndex = contentType.lastIndexOf("=");
				String boundary = contentType.substring(lastIndex + 1,
						contentType.length());
				// out.println(boundary);
				int pos;
				pos = file.indexOf("filename=\"");
				pos = file.indexOf("\n", pos) + 1;
				pos = file.indexOf("\n", pos) + 1;
				pos = file.indexOf("\n", pos) + 1;

				System.out.println("lastIndex==" + lastIndex + "=boundary="
						+ boundary + "pose" + pos);

				int boundaryLocation = file.indexOf(boundary, pos) - 4;

				int startPos = ((file.substring(0, pos)).getBytes()).length;
				int endPos = ((file.substring(0, boundaryLocation))
						.getBytes()).length;
				System.out.println("boundaryLocation==" + boundaryLocation
						+ "=startPos=" + startPos + "endPos" + endPos);
				// new code Start
				
				// new code end
				try {

					String lengths = "", xlsSize = "", insertedSize = "", txtFileSize = "", invalidTxtSize = "";
					String[] temp;

					System.out.println("saveFilePath" + folderPath);
					File saveFilePath = new File(folderPath);
					System.out.println("saveFilePath" + saveFilePath);
					if (!saveFilePath.exists()) {
						File saveDir = new File(folderPath);
						if (!saveDir.exists())
							saveDir.mkdirs();

					}

					// This is used for segregated folder struture
					// baseed on AAI EPF forms

					String fileName1 = folderPath + slashsuffix
							+ saveFile;

					System.out.println("fileName " + fileName);
					FileOutputStream fileOut = new FileOutputStream(
							fileName1);
					fileOut.write(dataBytes, startPos,
							(endPos - startPos));
					// fileOut.flush();
					// fileOut.close();

				} catch (Exception e) {
					System.out.println("in exception e " + e.getMessage());

				}
			}
	
	
	
	n=annuityService.insertPolicyDoc(
			 pfId, appid,annuityprovider,purchaseamt,gst,policyno,policydate,policyamt,debit,credit);

	

		if(n<=0){
			path = "./PensionView/SBS/PolicyDocument.jsp?menu="+menu;	
		}else{
			ArrayList list=annuityService.getPolicySerch();
			request.setAttribute("list", list);
			path = "./PensionView/SBS/SBSPolicyDocumentSearch.jsp?menu="+menu;	
		}
		
	 rd = request.getRequestDispatcher(path);
	 rd.forward(request, response);
}else if(request.getParameter("method") != null
		&& request.getParameter("method").equals(
		"searchPolicydoc")){
	String path="";
	String menu=request.getParameter("menu")!=null?request.getParameter("menu"):"";
	ArrayList list=annuityService.getPolicySerch();
	request.setAttribute("list", list);
	path = "./PensionView/SBS/SBSPolicyDocumentSearch.jsp?menu="+menu;	


rd = request.getRequestDispatcher(path);
rd.forward(request, response);
}else if(request.getParameter("method") != null
		&& request.getParameter("method").equals(
		"policyDocReportParam")){
	String path="";
	String menu=request.getParameter("menu")!=null?request.getParameter("menu"):"";
	
	path = "./PensionView/SBS/PolictDocReportParam.jsp?menu="+menu;	


rd = request.getRequestDispatcher(path);
rd.forward(request, response);
}else if(request.getParameter("method") != null
		&& request.getParameter("method").equals(
		"policyDocReport")){
	String path="";
	//String menu=request.getParameter("menu")!=null?request.getParameter("menu"):"";
	
	String region = "", airport = "", pfid = "", fromdate = "", todate = "",reportType="";

		ArrayList policyList = new ArrayList();

		if (request.getParameter("fromdate") != null) {
			fromdate = request.getParameter("fromdate");
		}
		if (request.getParameter("todate") != null ) {
			todate = request.getParameter("todate");
		}
		
		if(request.getParameter("frm_reportType") != null){
			reportType=request.getParameter("frm_reportType");
		}
		policyList =annuityService.getPolicySerch(fromdate,todate);
		request.setAttribute("policylist", policyList);
		
		
		request.setAttribute("reportType", reportType);
		 rd = request
			.getRequestDispatcher("./PensionView/SBS/SBSPolicyDocumentReport.jsp?menu=M7L3");
		 rd.forward(request, response);	

	
}else if(request.getParameter("method") != null
		&& request.getParameter("method").equals(
		"MISStatusReportParam")){
	String path="";
	String menu=request.getParameter("menu")!=null?request.getParameter("menu"):"";
	CommonUtil commonUtil = new CommonUtil();
	ArrayList regionList = new ArrayList();
	String rgnName = "";
	HashMap map = new HashMap();
	String[] regionLst = null;
	HttpSession session=request.getSession();
	if (session.getAttribute("region") != null) {
		regionLst = (String[]) session.getAttribute("region");
	}
	
	/*for (int i = 0; i < regionLst.length; i++) {
		rgnName = regionLst[i];
		if (rgnName.equals("ALL-REGIONS")
				&& session.getAttribute("usertype").toString().equals(
						"SBSUser")) {*/
			map = new HashMap();
			map = commonUtil.getRegion();
			/*break;
		} else {
			map.put(new Integer(i), rgnName);
		}

	}*/

	request.setAttribute("regionHashmap", map);
	path = "./PensionView/SBS/SBSMISStatusReportParam.jsp?menu="+menu;	


rd = request.getRequestDispatcher(path);
rd.forward(request, response);
}else if(request.getParameter("method") != null
		&& request.getParameter("method").equals(
		"AnnuityApprovedReportParam")){
	String path="";
	String menu=request.getParameter("menu")!=null?request.getParameter("menu"):"";
	CommonUtil commonUtil = new CommonUtil();
	ArrayList regionList = new ArrayList();
	String rgnName = "";
	HashMap map = new HashMap();
	String[] regionLst = null;
	HttpSession session=request.getSession();
	if (session.getAttribute("region") != null) {
		regionLst = (String[]) session.getAttribute("region");
	}
	
	/*for (int i = 0; i < regionLst.length; i++) {
		rgnName = regionLst[i];
		if (rgnName.equals("ALL-REGIONS")
				&& session.getAttribute("usertype").toString().equals(
						"SBSUser")) {*/
			map = new HashMap();
			map = commonUtil.getRegion();
			/*break;
		} else {
			map.put(new Integer(i), rgnName);
		}

	}*/

	request.setAttribute("regionHashmap", map);
	path = "./PensionView/SBS/SBSAnnuityApprovedParam.jsp?menu="+menu;	


rd = request.getRequestDispatcher(path);
rd.forward(request, response);
}else if(request.getParameter("method") != null
		&& request.getParameter("method").equals(
		"MISReport")) {

String region = "", airport = "", pfid = "", fromdate = "", todate = "",reportType="",formType="";

ArrayList misList = new ArrayList();


//System.out.println(todate+todate);
if (request.getParameter("region") != null && !request.getParameter("region").equals("[Select One]")) {
region = request.getParameter("region");
}

if (request.getParameter("airPortCode") != null && !request.getParameter("airPortCode").equals("[Select One]")) {
airport = request.getParameter("airPortCode");
}
if(request.getParameter("frm_reportType") != null){
reportType=request.getParameter("frm_reportType");
}
if(request.getParameter("formType") != null){
	formType=request.getParameter("formType");
	}
System.out.println("formType::"+formType);
if(formType.equals("MIS Status Report")){
misList = annuityService.getMisdata(region, airport
	);
}else{
	misList = annuityService.getMISEmployee(region, airport
	);
}
request.setAttribute("misList", misList);

request.setAttribute("region", region);
request.setAttribute("airport", airport);
request.setAttribute("reportType", reportType);
if(formType.equals("MIS Status Report")){
rd = request
	.getRequestDispatcher("./PensionView/SBS/SBSMISReport.jsp?menu=M7L1");
}else{
	rd = request
	.getRequestDispatcher("./PensionView/SBS/SBSMISReportEmployeeWise.jsp?menu=M7L1");
}
rd.forward(request, response);
}else if(request.getParameter("method") != null
		&& request.getParameter("method").equals(
		"AnnuityApprovedReport")) {
	System.out.println("inside AnnuityApprovedReport");

String region = "", airport = "",  fromdate = "", todate = "",reportType="",formType="";

ArrayList approvedList = new ArrayList();



if (request.getParameter("fromdate") != null && !request.getParameter("fromdate").equals("[Select One]")) {
	fromdate = request.getParameter("fromdate");
}
if (request.getParameter("todate") != null && !request.getParameter("todate").equals("[Select One]")) {
	todate = request.getParameter("todate");
}

if (request.getParameter("region") != null && !request.getParameter("region").equals("[Select One]")) {
	region = request.getParameter("region");
}
if (request.getParameter("airPortCode") != null && !request.getParameter("airPortCode").equals("[Select One]")) {
	airport = request.getParameter("airPortCode");
}
if(request.getParameter("frm_reportType") != null){
	reportType=request.getParameter("frm_reportType");
}
if(request.getParameter("formType") != null){
	formType=request.getParameter("formType");
	}
System.out.println("formType::"+formType);

	approvedList = annuityService.getAnnuityApprovedReport(fromdate, todate, airport,region,formType);

System.out.println("ghjghjghjg in dao"+approvedList.size() );
request.setAttribute("approvedList", approvedList);

request.setAttribute("region", region);
request.setAttribute("airport", airport);
request.setAttribute("reportType", reportType);
request.setAttribute("formType", formType);


rd = request
	.getRequestDispatcher("./PensionView/SBS/SBSAnnuityApprovedReport.jsp?menu=M4L6  ");

rd.forward(request, response);
}else if (request.getParameter("method").equals("NodalOfficerReportParam")) {
	CommonUtil commonUtil = new CommonUtil();
	ArrayList regionList = new ArrayList();
	String rgnName = "";
	HashMap map = new HashMap();
	String[] regionLst = null;
	HttpSession session=request.getSession();
	if (session.getAttribute("region") != null) {
		regionLst = (String[]) session.getAttribute("region");
	}
	for (int i = 0; i < regionLst.length; i++) {
		rgnName = regionLst[i];
		if (rgnName.equals("ALL-REGIONS")
				&& session.getAttribute("usertype").toString().equals(
						"SBSUser")) {
			map = new HashMap();
			map = commonUtil.getRegion();
			break;
		} else {
			map.put(new Integer(i), rgnName);
		}

	}
 request.setAttribute("regionHashmap", map);
   
		rd = request
				.getRequestDispatcher("./PensionView/SBS/NodalOfficerReportParam.jsp");
		rd.forward(request, response);

}

		

	}
	

}
