<%@ page import="java.util.*,java.lang.*,aims.dao.CommonDAO" %>
<%@ page language="java" 	pageEncoding="UTF-8"%>
<%@ page buffer="16kb"%>
<%@ page import="aims.bean.PensionBean"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
String[] year = {"2008","2009","2010","2011","2012","2013","2014","2015","2016","2017","2018","2019"};
String[] month = {"Jan","Feb","Mar","Apr","May","Jun","Jul","Aug","Sep","Oct","Nov","Dec"};
String region="",region1="",year1="",airportcode1="";
String userId = session.getAttribute("userid").toString();
//CommonDAO commonDAO = new CommonDAO();
//String currentdate=commonDAO.getdbDate();
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"
"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
<base href="<%=basePath%>">
<LINK rel="stylesheet" href="<%=basePath%>PensionView/css/aai.css"
	type="text/css">
<title>AAI</title>
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
<meta http-equiv="description" content="This is my page">

<!--
    <link rel="stylesheet" type="text/css" href="styles.css">
    -->
<script type="text/javascript"> 
function createXMLHttpRequest()
{
if (window.XMLHttpRequest) {    
	xmlHttp = new XMLHttpRequest();   
} else if(window.ActiveXObject) {    
      try {     
       xmlHttp = new ActiveXObject("Msxml2.XMLHTTP");    
       } catch (e) {     
       		try {      
       			xmlHttp = new ActiveXObject("Microsoft.XMLHTTP");     
       		} catch (e) {      
       			xmlHttp = false;     
       		}    
       	}          		
 } 
 }
		function getNodeValue(obj,tag)
		   {
			return obj.getElementsByTagName(tag)[0].firstChild.nodeValue;
		   }
		
		function getAirports()
	   { 
		var region=document.forms[0].select_region.value;
		createXMLHttpRequest();	
	    var url ="<%=basePath%>validatefinance?method=getAirports&region="+region;
		xmlHttp.open("post", url, true);
		xmlHttp.onreadystatechange = getAirportsList;
		xmlHttp.send(null);
	  }

		 function getMonth(){
			 formType=document.forms[0].select_proforma_type.value;
			 if(formType=='AAIEPF-1'){
              document.forms[0].select_month.value='04';
			 }else{
				  document.forms[0].select_month.value='';
			 }
		 }

	function getAirportsList()
	 {
		if(xmlHttp.readyState ==4)
		{
		 if(xmlHttp.status == 200)
			{ var stype = xmlHttp.responseXML.getElementsByTagName('ServiceType');
			  if(stype.length==0){
			 	var obj1 = document.getElementById("airPortCode");
			   	obj1.options.length=0; 
			   	obj1.options[obj1.options.length]=new Option('Select One','','true');
			  }else{
			   	var obj1 = document.getElementById("airPortCode");
			   	obj1.options.length = 0;
			  	for(i=0;i<stype.length;i++){
			  if(i==0){	obj1.options[obj1.options.length]=new Option('Select One','','true');
			}
		obj1.options[obj1.options.length] = new Option(getNodeValue(stype[i],'airPortName'),getNodeValue(stype[i],'airPortName'));
		  	}
			  
				  }
			}
		}
	}
	 function frmLoad()
	  {
	 process.style.display="none";
	 fade.style.display="none";
	  
	     <%			
				if (request.getAttribute("region") != null) {
					region1 =request.getAttribute("region").toString();
					region =request.getAttribute("region").toString();
					}
	            if (request.getAttribute("year") != null) {
				year1 =request.getAttribute("year").toString();;
				}
	           if (request.getAttribute("airportcode") != null) {
	        	   airportcode1 =request.getAttribute("airportcode").toString();;
					}
				%>
				var region1='<%=region%>';
				
				if(region1==""){
				region1="Select One" ;
				}
				var year1='<%=year1%>';
				if(year1==""){
				year1="Select One" ;
				}
			// document.forms[0].airPortCode[document.forms[0].airPortCode.options.selectedIndex].text="Select One";
			 document.forms[0].select_region[document.forms[0].select_region.options.selectedIndex].text=region1;
		     document.forms[0].select_year[document.forms[0].select_year.options.selectedIndex].text=year1;
	  } 
    function fnUpload(user){
   
   
           	var fileUploadVal="",region="",formType="",airPortCode="",year="";
		 	fileUploadVal=document.forms[0].uploadfile.value;
		 	formType=document.forms[0].select_proforma_type.value;
		 	region=document.forms[0].select_region[document.forms[0].select_region.options.selectedIndex].text;
		 	process.style.display="block";
		 	fade.style.display="block";
		 	airPortCode=document.forms[0].airPortCode.value;
		 	var submitObj = document.getElementById('sub');
		 	var cancelObj = document.getElementById('can');
	         submitObj.disabled = true;	
	         cancelObj.disabled = true;		 	
         	year=document.forms[0].select_year[document.forms[0].select_year.options.selectedIndex].text;
         	 //if(formType == 'AAIEPF-3'){
   // alert("uploading blocked due to amendment in the pension scheme, will be activated shortly");
    //return false;
    //}
         	if(formType == 'ARREARBREAKUP_UPLOAD'){         		
				 var fileNameWithpensionno=document.forms[0].uploadfile.value;	
				 fileNameWithpensionno=fileNameWithpensionno.substring(fileNameWithpensionno.lastIndexOf("\\")+1,fileNameWithpensionno.lastIndexOf("."));
				 
				var iChars="ARREARBREAKUP_UPLOAD_";
			  	for (var i = 0; i < iChars.length; i++) {
                 	if(iChars.charAt(i) != fileNameWithpensionno.charAt(i))
             		 {
             		 alert("The File Name should be "+formType+"_pensionno.xls");
             		 process.style.display="none";
             		 fade.style.display="none";
				submitObj.disabled = false;	
	         	cancelObj.disabled = false;
             		  return false;
             		 }		  	
			   }	
			  	//alert("fileNameWithpensionno "+fileNameWithpensionno);	
			    var pensionno=fileNameWithpensionno.substring(fileNameWithpensionno.lastIndexOf("_")+1,fileNameWithpensionno.length);
				 
					   if (isNaN(pensionno)) { 
						alert('Please Give Valid Pensionno'); 
						process.style.display="none";
						 fade.style.display="none";
				submitObj.disabled = false;	
	         	cancelObj.disabled = false;
		               	return false;
		            } else if(pensionno==""){
		            	 alert('Pensionno cant be blank'); 
		            	 process.style.display="none";
		            	  fade.style.display="none";
				submitObj.disabled = false;	
	         	cancelObj.disabled = false;
		            	 return false;
		            }		          
        	}
  	     	if(formType == 'AAIEPF-2' || formType == 'AAIEPF-2B'){         		
				 var fileNameWithpensionno=document.forms[0].uploadfile.value;
				 var tempcont="AAIEPF-2";	
					 if(formType == 'AAIEPF-2'){
				 	tempcont=tempcont+"_";
				 }else{
				  	tempcont=tempcont+"-Batch";
				 }
				 if(fileNameWithpensionno.indexOf(tempcont)==-1){
				 	alert('File name is incorrect');
				 	 process.style.display="none";
				 	  fade.style.display="none";
				 	    submitObj.disabled = false;	
	         			cancelObj.disabled = false;	
				 	return false;
				 }
        	}
        	if(formType!='OTHER' && formType != 'ARREARBREAKUP_UPLOAD' && formType != 'AAIEPF-2' && formType != 'AAIEPF-2B'){
        	//cheking the monthyear
		 	  var userId1='<%=userId%>'; 	  
 		 	if(document.forms[0].select_region[document.forms[0].select_region.options.selectedIndex].text=="Select One"){
		 		alert('Please Select The Region');
		 		document.forms[0].select_region.focus();
		 		process.style.display="none";
		 		 fade.style.display="none";
				submitObj.disabled = false;	
	         	cancelObj.disabled = false;
		 		return false;
		 	}
		 	if(document.forms[0].select_region[document.forms[0].select_region.options.selectedIndex].text=="Select One"){
		 		alert('Please Select The Region');
		 		document.forms[0].select_region.focus();
		 		process.style.display="none";
		 		 fade.style.display="none";
				submitObj.disabled = false;	
	         	cancelObj.disabled = false;
		 		return false;
		 	}
		 	// the below line is commented , now airportcode is mandatory for porting EPF-3 Recoveries Data
		 	//if(airPortCode=="" && (region=='CHQIAD' || region=='South Region')){
		 	if(airPortCode==""){
		 		alert('Please Select The Airport');
		 		document.forms[0].airPortCode.focus();
		 		process.style.display="none";
		 		 fade.style.display="none";
				submitObj.disabled = false;	
	         	cancelObj.disabled = false;
		 		return false;
		 	}
		 
			if(document.forms[0].select_year[document.forms[0].select_year.options.selectedIndex].text=="Select One"){
				alert("Please Select Year");
				document.forms[0].select_year.focus();
				process.style.display="none";
				 fade.style.display="none";
				submitObj.disabled = false;	
	         	cancelObj.disabled = false;
				return false;
			}
			var month=document.forms[0].select_month.value;
			if(month==""){
				alert("Please Select Month");
				document.forms[0].select_month.focus();
				process.style.display="none";
				 fade.style.display="none";
				submitObj.disabled = false;	
	         	cancelObj.disabled = false;
				return false;
			}
		 	if(fileUploadVal==''){
		 		alert('Please Select the File to Upload');
		 		document.forms[0].uploadfile.focus();
		 		process.style.display="none";
		 		 fade.style.display="none";
				submitObj.disabled = false;	
	         	cancelObj.disabled = false;
		 		return false;
		 	}else{
		 		var iChars = "!=*,";
		    var fileNameWithDrvieNm=document.forms[0].uploadfile.value;
		   
	        fileNameWithDrvieNm=fileNameWithDrvieNm.substring(fileNameWithDrvieNm.lastIndexOf("\\")+1,fileNameWithDrvieNm.lastIndexOf("."));
	      
          	for (var i = 0; i < fileNameWithDrvieNm.length; i++) {
		  	if (iChars.indexOf(fileNameWithDrvieNm.charAt(i)) != -1){
			   	alert("File Name like "+formType+"_REGIONNAME.xls");
			   	process.style.display="none";
			   	 fade.style.display="none";
				submitObj.disabled = false;	
	         	cancelObj.disabled = false;
		  		return false;
		  		}
			 }	
       
         
			var checkfileinfo=fileNameWithDrvieNm.split("_");
			var chckproformatype="",chckregioname="",selectedRegion="",chckAirportCode="",selectedAirportCode="";
			chckproformatype=checkfileinfo[0];
			chckregioname=checkfileinfo[1];
			if(checkfileinfo.length==5){
			chckAirportCode=checkfileinfo[2];
			
			}else if(checkfileinfo.length==3){
			 chckAirportCode=checkfileinfo[2];
			}else{
				chckAirportCode="";
			}
			var chckYear="",chckMonth="";
			if(checkfileinfo.length==5){
				chckYear=checkfileinfo[4];
			
				}else if(checkfileinfo.length==4){
					chckYear=checkfileinfo[3];
				}else{
					chckYear="";
				}
		
			if(checkfileinfo.length==5){
				chckMonth=checkfileinfo[3];
				}else if(checkfileinfo.length==4){
					chckMonth=checkfileinfo[2];
				}else{
					chckMonth="";
				}
			selectedRegion=region.replace(" ","");
			month=document.forms[0].select_month.value;
			selectedAirportCode=airPortCode.replace(" ","");
			   if(chckproformatype!=formType){
				   alert("File Name  like  '"+formType+"_"+selectedRegion+"_"+selectedAirportCode+"_"+month+"_"+year+"'");
					document.forms[0].select_proforma_type.focus();
					process.style.display="none";
					 fade.style.display="none";
				submitObj.disabled = false;	
	         	cancelObj.disabled = false;
		  		return false;
			   }
				
				if(chckregioname.toLowerCase()!=""){
					if(chckregioname.toLowerCase()!=selectedRegion.toLowerCase()){
					alert("selected Region and sheet Region name not equal please select the correct Region");
						alert("File Name  like  '"+formType+"_"+selectedRegion+"_"+selectedAirportCode+"_"+month+"_"+year+"'");
						document.forms[0].select_region.focus();
						process.style.display="none";
						 fade.style.display="none";
				submitObj.disabled = false;	
	         	cancelObj.disabled = false;
				  		return false;
					}
				}
				 
		
				if(chckMonth!=month){
				alert("selected month and sheet month name not equal please select the correct month");
			    	alert("File Name  like  '"+formType+"_"+selectedRegion+"_"+selectedAirportCode+"_"+month+"_"+year+"'");
					document.forms[0].select_proforma_type.focus();
					process.style.display="none";
					 fade.style.display="none";
				submitObj.disabled = false;	
	         	cancelObj.disabled = false;
		  		return false;
			   } 
				//alert("chckAirportCode "+chckAirportCode +"selectedAirportCode " +selectedAirportCode);
				if(chckAirportCode.toLowerCase()!=selectedAirportCode.toLowerCase()&& selectedAirportCode!="SelectOne"){
					//alert("File Name Like '"+formType+"_"+selectedRegion+"_"+selectedAirportCode+"_"+month+"_"+year+"'");
					alert("Please select the Airportcode");
					document.forms[0].airPortCode.focus();
					process.style.display="none";
					 fade.style.display="none";
				submitObj.disabled = false;	
	         	cancelObj.disabled = false;
			  		return false;
				}
				if(chckproformatype!=formType&&chckAirportCode.toLowerCase()!=selectedAirportCode.toLowerCase()&& selectedAirportCode!="SelectOne"){
				alert("selected airportcode and sheet airportcode name not equal please select the correct airportcode");
					alert("File Name  like  '"+formType+"_"+selectedRegion+"_"+selectedAirportCode+"_"+month+"_"+year+"'");
					document.forms[0].select_proforma_type.focus();
					process.style.display="none";
					 fade.style.display="none";
				submitObj.disabled = false;	
	         	cancelObj.disabled = false;
		  		return false;
			   }
				
				if(chckYear.toLowerCase()!=year.toLowerCase()&& selectedAirportCode!="SelectOne"){
				alert("selected year and sheet year name not equal please select the correct year");
				    alert("File Name Like  '"+formType+"_"+selectedRegion+"_"+selectedAirportCode+"_"+month+"_"+year+"'");
					document.forms[0].select_year.focus();
					process.style.display="none";
					 fade.style.display="none";
				submitObj.disabled = false;	
	         	cancelObj.disabled = false;
			  		return false;
				}else if(chckYear.toLowerCase()!=year.toLowerCase()&& selectedAirportCode=="SelectOne"){
				alert("selected year and sheet year name not equal please select the correct year");
				    alert("File Name Like  '"+formType+"_"+selectedRegion+"_"+month+"_"+year+"'");
					document.forms[0].select_year.focus();
					process.style.display="none";
					 fade.style.display="none";
				submitObj.disabled = false;	
	         	cancelObj.disabled = false;
			  		return false;
				}
		 	}
		 	 }
		 	if(fileUploadVal==''){
		 		alert('Please Select the File to Upload');
		 		document.forms[0].uploadfile.focus();
		 		process.style.display="none";
		 		 fade.style.display="none";
				submitObj.disabled = false;	
	         	cancelObj.disabled = false;
		 		return false;
		 	}
		 	/*if(user!='CAPFIN'&& user!='CAFIN'&&  user!='gsundaram'&& user!='navayuga' && user!='NSCBFIN'&& user!='NERFIN' && user!='CHQFIN' &&user!='TVMFIN' && user!='CSIFIN' && user!='BALWANT' && user!='NSCBPROJFIN' &&user!='SAPFIN'&&user!='ERFIN'&&user!='SEHGAL'&&user!='IGIFIN'&&user!='IGIFIN'&&user!='SWATI'&&user!='SRFIN'){
		          alert("' "+user+" ' Has no permissions to Import");
		          return false;
		         }*/
		     	if((formType == 'AAIEPF-3') && (userId1!='navayuga')){
       var cdate=new Date();
        	var selmonth=document.forms[0].select_month.value;
        	var selyear=document.forms[0].select_year.value;
           	var currmonth=cdate.getMonth()+1;           	
           	var curryear=cdate.getYear();
           	var prevmonth=cdate.getMonth();           	     
        	if(selmonth != currmonth){
            if(selmonth != prevmonth){ 	
        	if((selmonth != '12') || (prevmonth !='0')){ 
        	alert("Sorry...!You dont have previlizes to import the data rather than current month");
        	process.style.display="none";
        	 fade.style.display="none";
				submitObj.disabled = false;	
	         	cancelObj.disabled = false;
        	return false;
        	}
            }
        	}        	
        	if(selyear == '2008' || selyear == '2009' || selyear == '2010'|| selyear == '2011'){
        	alert("Sorry...!You dont have previlizes to import data for the years 2008 to Mar-2011");
        	process.style.display="none";
        	 fade.style.display="none";
				submitObj.disabled = false;	
	         	cancelObj.disabled = false;
        	return false;        	
        	}   
        	} 
			   	if((formType == 'AAIEPF-3-SUPPL') && (userId1!='navayuga')){
        	var cdate=new Date();
           	var selmonth=document.forms[0].select_month.value;
        	var selyear=document.forms[0].select_year.value;
           	var currmonth=cdate.getMonth()+2;
           	var curryear=cdate.getYear();
           	var prevmonth=cdate.getMonth();          
        	if(selmonth != currmonth){
            if(selmonth != prevmonth){ 	
        	if((selmonth != '12') || (prevmonth !='0')){ 
        	alert("Sorry...!You dont have previlizes to import the data rather than current/next month");
        	process.style.display="none";
        	 fade.style.display="none";
				submitObj.disabled = false;	
	         	cancelObj.disabled = false;
        	return false;
        	}
            }
        	}        	
        	if(selyear == '2008' || selyear == '2009' || selyear == '2010'){
        	alert("Sorry...!You dont have previlizes to import data for the years 2008 to Mar-2011");
        	process.style.display="none";
        	 fade.style.display="none";
				submitObj.disabled = false;	
	         	cancelObj.disabled = false;
        	return false;        	
        	}   
        	}    
        	if((formType == 'AAIEPF-3') && (userId1=='navayuga')){
        	var cdate=new Date();        	
           	var selmonth=document.forms[0].select_month.value;
        	var selyear=document.forms[0].select_year.value;
           	var currmonth=cdate.getMonth()+1;
           	var curryear=cdate.getYear();
           	var prevmonth=cdate.getMonth();            
           	if(selyear >= curryear){     
        	if(selmonth > currmonth){         	
           alert("Sorry...!You dont have previlizes to import the data rather than current month");
        	process.style.display="none";
        	 fade.style.display="none";
				submitObj.disabled = false;	
	         	cancelObj.disabled = false;
        	return false;
        	}
        	}
        	if(selyear == '2008' || selyear == '2009' || selyear == '2010' || selyear == '2011'){
        	alert("Sorry...!You dont have previlizes to import data for the years 2008 to Mar-2011");
        	process.style.display="none";
        	 fade.style.display="none";
				submitObj.disabled = false;	
	         	cancelObj.disabled = false;
        	return false;        	
        	}   
        	}
		    document.forms[0].action="<%=basePath%>PensionView/PensionFileUpload.jsp?frm_file="+fileUploadVal+"&frm_region="+region+"&frm_formtype="+formType+"&year="+year+"&month="+month+"&airPortCode="+airPortCode;
		  
           	document.forms[0].method="post";
			document.forms[0].submit();			
		 	}
 	function getDate(date){	 
 	
	  if(date.indexOf('-')!=-1){
		 elem = date.split('-'); 
	  }else{
		  elem = date.split('/'); 
	  }	  
		 day = elem[0];
		 mon1 = elem[1];
		 year = elem[2];
		 var month;
	   	 if((mon1 == "JAN") || (mon1 == "Jan")) month = 0;
        	else if(mon1 == "FEB" ||(mon1 == "Feb")) month = 1;
     	else if(mon1 == "MAR" || (mon1 == "Mar")) month = 2;
     	else if(mon1 == "APR" || (mon1 == "Apr")) month = 3;
     	else if(mon1 == "MAY" ||(mon1 == "May") ) month = 4;
     	else if(mon1 == "JUN" ||(mon1 == "Jun") ) month = 5;
     	else if(mon1 == "JUL"||(mon1 == "Jul")) month = 6;
     	else if(mon1 == "AUG" ||(mon1 == "Aug")) month = 7;
     	else if(mon1 == "SEP" ||(mon1 == "Sep")) month = 8;
     	else if(mon1 == "OCT"||(mon1 == "Oct")) month = 9;
     	else if(mon1 == "NOV" ||(mon1 == "Nov")) month = 10;
     	else if(mon1 == "DEC" ||(mon1 == "Dec")) month = 11;
	  var finaldate=new Date(year,month,day); 
	  return finaldate;	     	
  }
		 
   		 </script>
</head>
<%
    String monthID="",monthNM="";
    String formID="",formNM="";
  	Iterator regionIterator=null;
  	Iterator monthIterator=null;
  	HashMap hashmap=new HashMap();
  	Iterator formIterator=null;
  	String fileName="";
  	if(request.getAttribute("regionHashmap")!=null){
  	hashmap=(HashMap)request.getAttribute("regionHashmap");
  	Set keys = hashmap.keySet();
	regionIterator = keys.iterator();
  	}
  	if(request.getAttribute("monthIterator")!=null){
  	  	monthIterator=(Iterator)request.getAttribute("monthIterator");
  	  	}
	if(request.getAttribute("formsListMap")!=null){
  		formIterator=(Iterator)request.getAttribute("formsListMap");
  	  	}
  	
  	if(request.getAttribute("fileName")!=null){
  		fileName=request.getAttribute("fileName").toString();
  		System.out.println("fileName" +fileName);
  	  	}

  
  	%>
<body class="BodyBackground" onload="frmLoad();getAirports()">
<form enctype="multipart/form-data">
<table width="100%" border="0" align="center" cellpadding="0"
	cellspacing="0">
	<tr>
		<td><jsp:include page="/PensionView/PensionMenu.jsp" /></td>
	</tr>

	<tr>
		<td>&nbsp;</td>
	</tr>
	<tr>
		<td>
		<table align="center" width="70%" align="center" cellpadding="0"
			cellspacing="0" class="tbborder">
			<tr>

				<td height="5%" align="center" class="ScreenMasterHeading">Import
				CPF Data</td>
			</tr>
			<tr>
				<td>&nbsp;</td>
			</tr>
			<tr>
				<td colspan="8">
				<table align="center" border="0" width="100%" align="center"
					cellpadding="1" cellspacing="0">
					<tr>

						<td class="label" align="right">AAIEPF FORMAT:<font
							color="red">&nbsp;*</font>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
						<td><SELECT NAME="select_proforma_type" style="width: 210px"
							onchange="getMonth()">
							<%
				 while (formIterator.hasNext()) {
				 Map.Entry mapEntry = (Map.Entry) formIterator.next();
				 formID = mapEntry.getKey().toString();
				 formNM = mapEntry.getValue().toString();
				 if(formID.equalsIgnoreCase(fileName)) {
				 %>  
							<option value="<%=fileName%>" <% out.println("selected");%>>
							<%=formNM%></option>


							<%} else {%>
							<option value="<%=formID%>"><%=formNM%></option>
							<%}
             	%>
				
							<%}%>
						</SELECT></td>
					</tr>
					<tr>
						<td class="label" align="right">Region:<font color="red">&nbsp;*</font>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
						<td><SELECT NAME="select_region" style="width: 130px"
							onchange="getAirports()">
							<option value="">Select One</option>
							<%int k = 0;
			boolean exist = false;
            while (regionIterator.hasNext()) {
			region = hashmap.get(regionIterator.next()).toString();
			k++;
				
				if (region.equalsIgnoreCase(region1)) {

					%>
							<option value="<%=region1%>" <% out.println("selected");%>>
							<%=region1%></option>


							<%} else {%>
							<option value="<%=region%>"><%=region%></option>
							<%}

			                %>

							<%}	%>
						</SELECT></td>
					</tr>
					<tr>
						<td class="label" align="right">Airport
						Name:<font color="red">&nbsp;*</font>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
						<td><select name="airPortCode" id="airPortCode">
							<option value="">Select One</option>

							<% try{if (request.getAttribute("airportList") != null) {
							ArrayList airpors = (ArrayList) request
							.getAttribute("airportList");
						for (int i = 0; i < airpors.size(); i++) {
						PensionBean airportBean = (PensionBean) airpors
								.get(i);
								System.out.println(airportBean.getAirportCode());

						%>
							<option value="<%=airportBean.getAirportCode()%>"><%=airportBean.getAirportCode()%></option>
							<%} }						
							}   catch (Exception e){
                  out.println("An exception occurred: " + e.getMessage());
                 }
							%>
						</select></td>
					</tr>
					<tr>
						<td class="label" align="right">Year:<font color="red">&nbsp;*</font>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						</td>
						<td><Select name='select_year' Style='width: 100px'>
							<option value="">Select One</option>
                <%for (int j = 0; j < year.length; j++)  {
			     String year2 = year[j].toString();
			    	if (year2.equalsIgnoreCase(year1)) {
				%>   
							<option value="<%=year1%>" <% out.println("selected");%>>
							<%=year1%></option>


							<%} else {%>
							<option value="<%=year2%>"><%=year2%></option>
							<%}

			%>

							<%}	%>
							
						</SELECT></td>
					</tr>
					<tr>
						<td class="label" align="right">Salary Month:<font
							color="red">&nbsp;*</font>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
						<td><Select name='select_month' Style='width: 100px'>
							<option value="">Select One</option>
							<%while (monthIterator.hasNext()) {
				Map.Entry mapEntry = (Map.Entry) monthIterator.next();
				monthID = mapEntry.getKey().toString();
				monthNM = mapEntry.getValue().toString();

				%>
				<option value="<%=monthID%>"><%=monthNM%></option>
							<%}%>
						</SELECT></td>
					</tr>
					<tr>
						<td class="label" align="right">File to Upload:<font
							color="red">&nbsp;*</font>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
						<td><input type="file"  name="uploadfile" size="50"></td>
					</tr>
					<tr>
						<td class="label"></td>
						<td><input type="button" class="btn" name="Submit" id="sub"
							value="Upload"
							onclick="javascript:fnUpload('<%=session.getAttribute("userid")%>')">
							<input type="button" class="btn" name="Submit" id="can" value="Cancel" onclick="javascript:history.back(-1)">
							</td>
					</tr>
				</table>
				</td>
			</tr>
			<tr>
				<td>&nbsp;</td>
			</tr>
			<tr>
				<td algin="center">
				<%if (request.getAttribute("message") != null) {%> 
				<font color="red"><%=request.getAttribute("message")%></font>
				<%}%>
				<%if (request.getAttribute("errorMessage") != null) {
				String message=request.getAttribute("errorMessage").toString();
				String[] temp;
				temp = message.split("-->");
				for(int i =0; i < temp.length ; i++){%>
                  <b><ul><font color="red"><li><%=temp[i]%><br></li></font></ul></b> 
                  <%}}%>
				</td>
			</tr>
		</table>
		</td>
	</tr>


	<%
  //System.out.println("xlsSize=================="+request.getAttribute("xlsSize"));
  String updateMessage="",invalidTxtFileSize="",invalidDataSize="";
  if(request.getAttribute("lengths")!=null  ){
  	if(request.getAttribute("lengths")!=null){
  updateMessage = request.getAttribute("lengths").toString();
   }
  else {
  updateMessage="";
  }
 
  %>
	<td align="center" class="Data"><font color="red"> <%=request.getAttribute("lengths")%>
	<br>

	</font></td>
	<%}%>
	</tr>
</table>
</form>
	<div id="process" class="white_content" align="center">
	<img src="<%=basePath%>PensionView/images/Indicator.gif" border="0" align="center" />
	<span class="label">Processing.......</span>
     </div>
		<div id="fade" class="black_overlay" align="center"></div>
</body>
</html>
