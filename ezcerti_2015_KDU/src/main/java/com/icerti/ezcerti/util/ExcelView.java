package com.icerti.ezcerti.util;

import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.poi.hssf.usermodel.HSSFCellStyle;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.hssf.util.HSSFColor;
import org.springframework.web.servlet.view.document.AbstractExcelView;


public class ExcelView extends AbstractExcelView{

    @SuppressWarnings("null")
	@Override

    protected void buildExcelDocument(Map<String,Object> ModelMap,HSSFWorkbook workbook, HttpServletRequest request, HttpServletResponse response) throws Exception{

          String excelName = ModelMap.get("target").toString();

          HSSFSheet worksheet = null;

          HSSFRow row = null;
          
          HSSFCellStyle titleCellStyle = workbook.createCellStyle();
          titleCellStyle.setBorderBottom(HSSFCellStyle.BORDER_THIN);
          titleCellStyle.setBorderLeft(HSSFCellStyle.BORDER_THIN);
          titleCellStyle.setBorderRight(HSSFCellStyle.BORDER_THIN);
          titleCellStyle.setBorderTop(HSSFCellStyle.BORDER_THIN);
          titleCellStyle.setFillPattern(HSSFCellStyle.SOLID_FOREGROUND);
          titleCellStyle.setFillForegroundColor(HSSFColor.GREY_25_PERCENT.index);
          
          if(excelName.equals("attendStatus")){

                 excelName=URLEncoder.encode("AttendStatus","UTF-8");

                 worksheet = workbook.createSheet("출결처리현황");
                 worksheet.setColumnWidth(0, 5000);
                 worksheet.setColumnWidth(1, 2800);
                 worksheet.setColumnWidth(2, 6000);
                 worksheet.setColumnWidth(3, 3800);
                 worksheet.setColumnWidth(4, 4500);
                 worksheet.setColumnWidth(5, 2500);
                 worksheet.setColumnWidth(6, 2500);
                 worksheet.setColumnWidth(7, 2500);
                 worksheet.setColumnWidth(8, 2500);
                 @SuppressWarnings("unchecked")

                 List<Map<String, Object>> list = (List<Map<String, Object>>)ModelMap.get("excelList");

                 row = worksheet.createRow(0);
                 
                 row.createCell(0).setCellValue("교수명");
                 row.createCell(1).setCellValue("사번");
                 row.createCell(2).setCellValue("학과명");
                 row.createCell(3).setCellValue("전화번호");
                 row.createCell(4).setCellValue("이메일");
                 row.createCell(5).setCellValue("정상강의수");
                 row.createCell(6).setCellValue("처리강의수");
                 row.createCell(7).setCellValue("미처리강의수");
                 row.createCell(8).setCellValue("사용률");
                 
                 row.getCell(0).setCellStyle(titleCellStyle);
                 row.getCell(1).setCellStyle(titleCellStyle);
                 row.getCell(2).setCellStyle(titleCellStyle);
                 row.getCell(3).setCellStyle(titleCellStyle);
                 row.getCell(4).setCellStyle(titleCellStyle);
                 row.getCell(5).setCellStyle(titleCellStyle);
                 row.getCell(6).setCellStyle(titleCellStyle);
                 row.getCell(7).setCellStyle(titleCellStyle);
                 row.getCell(8).setCellStyle(titleCellStyle);
                 
                 for(int i=1;i<list.size()+1;i++){
                        row = worksheet.createRow(i);
                        row.createCell(0).setCellValue(list.get(i-1).get("PROF_NAME").toString());
                        row.createCell(1).setCellValue(list.get(i-1).get("PROF_NO").toString());
                        row.createCell(2).setCellValue(list.get(i-1).get("DEPT_NAME").toString());
                        if(list.get(i-1).get("HP_NO")!=null){
                        	row.createCell(3).setCellValue(list.get(i-1).get("HP_NO").toString());
                        }
                        if(list.get(i-1).get("EMAIL_ADDR")!=null){
                        	row.createCell(4).setCellValue(list.get(i-1).get("EMAIL_ADDR").toString());
                        }
                        row.createCell(5).setCellValue(list.get(i-1).get("ALLCNT").toString());
                        row.createCell(6).setCellValue(list.get(i-1).get("PROCCNT").toString());
                        row.createCell(7).setCellValue(list.get(i-1).get("CNT").toString());
                        row.createCell(8).setCellValue(list.get(i-1).get("PER_USAGE").toString()+"%");
                 }

          }
          if(excelName.equals("studentStatus")){
        	  
        	  excelName=URLEncoder.encode("StudentStatus","UTF-8");
        	  
        	  worksheet = workbook.createSheet("출결처리현황");
        	  worksheet.setColumnWidth(0, 5000);
        	  worksheet.setColumnWidth(1, 2800);
        	  worksheet.setColumnWidth(2, 3800);
        	  worksheet.setColumnWidth(3, 4500);
        	  worksheet.setColumnWidth(4, 4500);
        	  worksheet.setColumnWidth(5, 4500);
        	  worksheet.setColumnWidth(6, 2500);
        	  worksheet.setColumnWidth(7, 2500);
        	  worksheet.setColumnWidth(8, 2500);
        	  worksheet.setColumnWidth(9, 2500);
        	  worksheet.setColumnWidth(10, 2500);
        	  @SuppressWarnings("unchecked")
        	  
        	  List<Map<String, Object>> list = (List<Map<String, Object>>)ModelMap.get("excelList");
        	  
        	  row = worksheet.createRow(0);
        	  
        	  row.createCell(0).setCellValue("학생명");
        	  row.createCell(1).setCellValue("학번");
        	  row.createCell(2).setCellValue("전화번호");
        	  row.createCell(3).setCellValue("이메일");
        	  row.createCell(4).setCellValue("단과");
        	  row.createCell(5).setCellValue("학과");
        	  row.createCell(6).setCellValue("총강의수");
        	  row.createCell(7).setCellValue("출결전");
        	  row.createCell(8).setCellValue("출석");
        	  row.createCell(9).setCellValue("지각");
        	  row.createCell(10).setCellValue("결석");
        	  
        	  row.getCell(0).setCellStyle(titleCellStyle);
        	  row.getCell(1).setCellStyle(titleCellStyle);
        	  row.getCell(2).setCellStyle(titleCellStyle);
        	  row.getCell(3).setCellStyle(titleCellStyle);
        	  row.getCell(4).setCellStyle(titleCellStyle);
        	  row.getCell(5).setCellStyle(titleCellStyle);
        	  row.getCell(6).setCellStyle(titleCellStyle);
        	  row.getCell(7).setCellStyle(titleCellStyle);
        	  row.getCell(8).setCellStyle(titleCellStyle);
        	  row.getCell(9).setCellStyle(titleCellStyle);
        	  row.getCell(10).setCellStyle(titleCellStyle);
        	  
        	  for(int i=1;i<list.size()+1;i++){
        		  row = worksheet.createRow(i);
        		  row.createCell(0).setCellValue(list.get(i-1).get("STUDENT_NAME").toString());
        		  row.createCell(1).setCellValue(list.get(i-1).get("STUDENT_NO").toString());
        		  if(list.get(i-1).get("HP_NO")!=null){
        			  row.createCell(2).setCellValue(list.get(i-1).get("HP_NO").toString());
        		  }
        		  if(list.get(i-1).get("EMAIL_ADDR")!=null){
        			  row.createCell(3).setCellValue(list.get(i-1).get("EMAIL_ADDR").toString());
        		  }
        		  row.createCell(4).setCellValue(list.get(i-1).get("COLL_NAME").toString());
        		  row.createCell(5).setCellValue(list.get(i-1).get("DEPT_NAME").toString());
        		  row.createCell(6).setCellValue(list.get(i-1).get("ATTEND_ALL").toString());
        		  row.createCell(7).setCellValue(list.get(i-1).get("ATTEND_BEFORE").toString());
        		  row.createCell(8).setCellValue(list.get(i-1).get("ATTEND_PRESENT").toString());
        		  row.createCell(9).setCellValue(list.get(i-1).get("ATTEND_LATE").toString());
        		  row.createCell(10).setCellValue(list.get(i-1).get("ATTEND_ABSENT").toString());
        	  }
        	  
          }
          if(excelName.equals("adminStatsProf")){
        	  
        	  excelName=URLEncoder.encode("AdminStatsProf","UTF-8");
        	  
        	  worksheet = workbook.createSheet("교수별통계");
        	  worksheet.setColumnWidth(0, 5000);
        	  worksheet.setColumnWidth(1, 2500);
        	  worksheet.setColumnWidth(2, 3500);
        	  worksheet.setColumnWidth(3, 3000);
        	  worksheet.setColumnWidth(4, 4500);
        	  worksheet.setColumnWidth(5, 4500);
        	  worksheet.setColumnWidth(6, 4500);
        	  worksheet.setColumnWidth(7, 2500);
        	  worksheet.setColumnWidth(8, 2500);
        	  worksheet.setColumnWidth(9, 2500);
        	  worksheet.setColumnWidth(10, 2500);
        	  @SuppressWarnings("unchecked")
        	  
        	  List<Map<String, Object>> list = (List<Map<String, Object>>)ModelMap.get("excelList");
        	  
        	  row = worksheet.createRow(0);
        	  
        	  row.createCell(0).setCellValue("사번");
        	  row.createCell(1).setCellValue("교수명");
        	  row.createCell(2).setCellValue("학과명");
        	  row.createCell(3).setCellValue("학기상태");
        	  row.createCell(4).setCellValue("총강의");
        	  row.createCell(5).setCellValue("보강수");
        	  row.createCell(6).setCellValue("휴강수");
        	  row.createCell(7).setCellValue("출석");
        	  row.createCell(8).setCellValue("지각");
        	  row.createCell(9).setCellValue("결석");
        	  row.createCell(10).setCellValue("기타");
        	  
        	  row.getCell(0).setCellStyle(titleCellStyle);
        	  row.getCell(1).setCellStyle(titleCellStyle);
        	  row.getCell(2).setCellStyle(titleCellStyle);
        	  row.getCell(3).setCellStyle(titleCellStyle);
        	  row.getCell(4).setCellStyle(titleCellStyle);
        	  row.getCell(5).setCellStyle(titleCellStyle);
        	  row.getCell(6).setCellStyle(titleCellStyle);
        	  row.getCell(7).setCellStyle(titleCellStyle);
        	  row.getCell(8).setCellStyle(titleCellStyle);
        	  row.getCell(9).setCellStyle(titleCellStyle);
        	  row.getCell(10).setCellStyle(titleCellStyle);
        	  
        	  for(int i=1;i<list.size()+1;i++){
        		  row = worksheet.createRow(i);
        		  row.createCell(0).setCellValue(list.get(i-1).get("PROF_NO").toString());
        		  row.createCell(1).setCellValue(list.get(i-1).get("PROF_NAME").toString());
    			  row.createCell(2).setCellValue(list.get(i-1).get("PROF_DEPT_NAME").toString());
    			  row.createCell(3).setCellValue(list.get(i-1).get("PROF_ADM_NAME").toString());
    			  row.createCell(4).setCellValue(list.get(i-1).get("ALL_CLASS").toString());
        		  if(list.get(i-1).get("ADD_CLASS")!=null){    			  
        			  row.createCell(5).setCellValue(list.get(i-1).get("ADD_CLASS").toString());
        		  }
        		  if(list.get(i-1).get("OFF_CLASS")!=null){
        			  row.createCell(6).setCellValue(list.get(i-1).get("OFF_CLASS").toString());
        		  }
        		  if(list.get(i-1).get("ATTEND_PRESENT")!=null){
        			  row.createCell(7).setCellValue(list.get(i-1).get("ATTEND_PRESENT").toString()+"%");
        		  }
        		  if(list.get(i-1).get("ATTEND_LATE")!=null){
        			  row.createCell(8).setCellValue(list.get(i-1).get("ATTEND_LATE").toString()+"%");
        		  }
        		  if(list.get(i-1).get("ATTEND_ABSENT")!=null){
        			  row.createCell(9).setCellValue(list.get(i-1).get("ATTEND_ABSENT").toString()+"%");
        		  }
        		  if(list.get(i-1).get("ATTEND_ETC")!=null){
        			  row.createCell(10).setCellValue(list.get(i-1).get("ATTEND_ETC").toString()+"%");
        		  }
        	  }
        	  
          }
          if(excelName.equals("statsProfTerm")){
        	  
        	  
        	  @SuppressWarnings("unchecked")
        	  List<Map<String, Object>> list = (List<Map<String, Object>>)ModelMap.get("excelList");
        	  
        	  excelName=URLEncoder.encode("statsProfTerm_"+list.get(0).get("PROF_NO"),"UTF-8");
        	  
        	  worksheet = workbook.createSheet("교수과목별통계");
        	  worksheet.setColumnWidth(0, 3000);
        	  worksheet.setColumnWidth(1, 5500);
        	  worksheet.setColumnWidth(2, 2000);
        	  worksheet.setColumnWidth(3, 2000);
        	  worksheet.setColumnWidth(4, 2000);
        	  worksheet.setColumnWidth(5, 2500);
        	  worksheet.setColumnWidth(6, 2500);
        	  worksheet.setColumnWidth(7, 2500);
        	  worksheet.setColumnWidth(8, 2500);
        	  worksheet.setColumnWidth(9, 2500);
        	  worksheet.setColumnWidth(10, 2500);
        	  worksheet.setColumnWidth(11, 2500);
     
        	  
        	  row = worksheet.createRow(0);
        	  
        	  row.createCell(0).setCellValue("강의번호");
        	  row.createCell(1).setCellValue("강의명");
        	  row.createCell(2).setCellValue("수업일");
        	  row.createCell(3).setCellValue("보강일");
        	  row.createCell(4).setCellValue("휴강일");
        	  row.createCell(5).setCellValue("수강생");
        	  row.createCell(6).setCellValue("출석률");
        	  row.createCell(7).setCellValue("지각률");
        	  row.createCell(8).setCellValue("결석률");
        	  row.createCell(9).setCellValue("기타");
        	  row.createCell(10).setCellValue("휴학생수");
        	  row.createCell(11).setCellValue("제적생수");
        	  
        	  row.getCell(0).setCellStyle(titleCellStyle);
        	  row.getCell(1).setCellStyle(titleCellStyle);
        	  row.getCell(2).setCellStyle(titleCellStyle);
        	  row.getCell(3).setCellStyle(titleCellStyle);
        	  row.getCell(4).setCellStyle(titleCellStyle);
        	  row.getCell(5).setCellStyle(titleCellStyle);
        	  row.getCell(6).setCellStyle(titleCellStyle);
        	  row.getCell(7).setCellStyle(titleCellStyle);
        	  row.getCell(8).setCellStyle(titleCellStyle);
        	  row.getCell(9).setCellStyle(titleCellStyle);
        	  row.getCell(10).setCellStyle(titleCellStyle);
        	  row.getCell(11).setCellStyle(titleCellStyle);
        	  
        	  for(int i=1;i<list.size()+1;i++){
        		  row = worksheet.createRow(i);
        		  row.createCell(0).setCellValue(list.get(i-1).get("SUBJECT_CD")+"-"+list.get(i-1).get("SUBJECT_DIV_CD"));
     		  
        		  row.createCell(1).setCellValue(list.get(i-1).get("CLASS_NAME").toString());
    			  row.createCell(2).setCellValue(list.get(i-1).get("ALL_CLASS").toString());
        		  if(list.get(i-1).get("ADD_CLASS")!=null){
        			  row.createCell(3).setCellValue(list.get(i-1).get("ADD_CLASS").toString());
        		  }
        		  if(list.get(i-1).get("OFF_CLASS")!=null){
        			  row.createCell(4).setCellValue(list.get(i-1).get("OFF_CLASS").toString());
        		  }
        		  if(list.get(i-1).get("ATTENDEE_CNT")!=null){
        			  row.createCell(5).setCellValue(list.get(i-1).get("ATTENDEE_CNT").toString());
        		  }
        		  if(list.get(i-1).get("PER_PRESENT")!=null){
        			  row.createCell(6).setCellValue(list.get(i-1).get("PER_PRESENT").toString()+"%");
        		  }
        		  if(list.get(i-1).get("PER_LATE")!=null){
        			  row.createCell(7).setCellValue(list.get(i-1).get("PER_LATE").toString()+"%");
        		  }
        		  if(list.get(i-1).get("PER_ABSENT")!=null){
        			  row.createCell(8).setCellValue(list.get(i-1).get("PER_ABSENT").toString()+"%");
        		  }
        		  if(list.get(i-1).get("PER_ETC")!=null){
        			  row.createCell(9).setCellValue(list.get(i-1).get("PER_ETC").toString()+"%");
        		  }
        		  if(list.get(i-1).get("ATTEND_OFF_CNT")!=null){
        			  row.createCell(10).setCellValue(list.get(i-1).get("ATTEND_OFF_CNT").toString());
        		  }
        		  if(list.get(i-1).get("ATTEND_QUIT_CNT")!=null){
        			  row.createCell(11).setCellValue(list.get(i-1).get("ATTEND_QUIT_CNT").toString());
        		  }
        	  }
        	  
          }
          if(excelName.equals("statsProfDaily")){
        	  
        	  
        	  @SuppressWarnings("unchecked")
        	  List<Map<String, Object>> list = (List<Map<String, Object>>)ModelMap.get("excelList");
        	  excelName=URLEncoder.encode("statsProfDaily_"+list.get(0).get("PROF_NO"),"UTF-8");
        	  
        	  worksheet = workbook.createSheet("교수과목일별통계");
        	  worksheet.setColumnWidth(0, 2000);
        	  worksheet.setColumnWidth(1, 2500);
        	  worksheet.setColumnWidth(2, 3000);
        	  worksheet.setColumnWidth(3, 3000);
        	  worksheet.setColumnWidth(4, 3000);
        	  worksheet.setColumnWidth(5, 2500);
        	  worksheet.setColumnWidth(6, 2500);
        	  worksheet.setColumnWidth(7, 2500);
        	  worksheet.setColumnWidth(8, 2500);
        	  worksheet.setColumnWidth(9, 2500);
        	  worksheet.setColumnWidth(10, 2500);
        	  worksheet.setColumnWidth(11, 2500);
        	  
        	  
        	  row = worksheet.createRow(0);
        	  
        	  row.createCell(0).setCellValue("강의형태");
        	  row.createCell(1).setCellValue("강의상태");
        	  row.createCell(2).setCellValue("강의번호");
        	  row.createCell(3).setCellValue("강의일");
        	  row.createCell(4).setCellValue("강의요일");
        	  row.createCell(5).setCellValue("시작시간");
        	  row.createCell(6).setCellValue("종료시간");
        	  row.createCell(7).setCellValue("수강생");
        	  row.createCell(8).setCellValue("출석");
        	  row.createCell(9).setCellValue("지각");
        	  row.createCell(10).setCellValue("결석");
        	  row.createCell(11).setCellValue("휴학");
        	  row.createCell(12).setCellValue("제적");
        	  
        	  row.getCell(0).setCellStyle(titleCellStyle);
        	  row.getCell(1).setCellStyle(titleCellStyle);
        	  row.getCell(2).setCellStyle(titleCellStyle);
        	  row.getCell(3).setCellStyle(titleCellStyle);
        	  row.getCell(4).setCellStyle(titleCellStyle);
        	  row.getCell(5).setCellStyle(titleCellStyle);
        	  row.getCell(6).setCellStyle(titleCellStyle);
        	  row.getCell(7).setCellStyle(titleCellStyle);
        	  row.getCell(8).setCellStyle(titleCellStyle);
        	  row.getCell(9).setCellStyle(titleCellStyle);
        	  row.getCell(10).setCellStyle(titleCellStyle);
        	  row.getCell(11).setCellStyle(titleCellStyle);
        	  row.getCell(12).setCellStyle(titleCellStyle);
        	  
        	  for(int i=1;i<list.size()+1;i++){
        		  row = worksheet.createRow(i);
        		  row.createCell(0).setCellValue(list.get(i-1).get("CLASS_TYPE_NAME").toString());
        		  row.createCell(1).setCellValue(list.get(i-1).get("CLASS_STS_NAME").toString());
        		  row.createCell(2).setCellValue(list.get(i-1).get("SUBJECT_CD")+"-"+list.get(i-1).get("SUBJECT_DIV_CD"));
        		  row.createCell(3).setCellValue(list.get(i-1).get("CLASSDAY").toString().substring(0, 10));
        		  row.createCell(4).setCellValue(list.get(i-1).get("CLASSDAY_NAME").toString()+"요일");
        		  row.createCell(5).setCellValue(list.get(i-1).get("CLASSHOUR_START_TIME").toString());
        		  row.createCell(6).setCellValue(list.get(i-1).get("CLASSHOUR_END_TIME").toString());
        		  if(list.get(i-1).get("ATTENDEE_CNT")!=null){
        			  row.createCell(7).setCellValue(list.get(i-1).get("ATTENDEE_CNT").toString());
        		  }
        		  if(list.get(i-1).get("ATTEND_PRESENT_CNT")!=null){
        			  row.createCell(8).setCellValue(list.get(i-1).get("ATTEND_PRESENT_CNT").toString());
        		  }
        		  if(list.get(i-1).get("ATTEND_LATE_CNT")!=null){
        			  row.createCell(9).setCellValue(list.get(i-1).get("ATTEND_LATE_CNT").toString());
        		  }
        		  if(list.get(i-1).get("ATTEND_ABSENT_CNT")!=null){
        			  row.createCell(10).setCellValue(list.get(i-1).get("ATTEND_ABSENT_CNT").toString());
        		  }
        		  if(list.get(i-1).get("ATTEND_OFF_CNT")!=null){
        			  row.createCell(11).setCellValue(list.get(i-1).get("ATTEND_OFF_CNT").toString());
        		  }
        		  if(list.get(i-1).get("ATTEND_QUIT_CNT")!=null){
        			  row.createCell(12).setCellValue(list.get(i-1).get("ATTEND_QUIT_CNT").toString());
        		  }
        	  }
        	  
          }
          if(excelName.equals("statsAttendee")){
        	  
        	  
        	  @SuppressWarnings("unchecked")
        	  List<Map<String, Object>> list = (List<Map<String, Object>>)ModelMap.get("excelList");
        	  
        	  String temp1 = list.get(0).get("CDAY").toString();
        	  String[] temp2 = temp1.split(",");
        	  ArrayList<String[]> attend = new ArrayList<String[]>();
        	  for (int i = 0; i < list.size(); i++) {
        		String[] temp3 = list.get(i).get("ATTEND_STS").toString().split(",");
					attend.add(i, temp3);
        	  }
        	  
        	  
        	  excelName=URLEncoder.encode("statsAttendee","UTF-8");
        	  
        	  worksheet = workbook.createSheet("수강생별통계");
        	  worksheet.setColumnWidth(0, 2800);
        	  worksheet.setColumnWidth(1, 2300);
        	  worksheet.setColumnWidth(2, 5000);
        	  worksheet.setColumnWidth(3, 3000);
        	  worksheet.setColumnWidth(4, 2000);
        	  worksheet.setColumnWidth(5, 2000);
        	  worksheet.setColumnWidth(6, 2000);
        	  worksheet.setColumnWidth(7, 2000);
        	  worksheet.setColumnWidth(8, 2000);
        	  worksheet.setColumnWidth(9, 2000);
        	  
        	  for (int j = 0; j < temp2.length; j++) {
				worksheet.setColumnWidth(10+j, 2500);
			}

        	  
        	  
        	  row = worksheet.createRow(0);
        	  
        	  row.createCell(0).setCellValue("학번");
        	  row.createCell(1).setCellValue("학생명");
        	  row.createCell(2).setCellValue("학과명");
        	  row.createCell(3).setCellValue("과목코드");
        	  row.createCell(4).setCellValue("출결전");
        	  row.createCell(5).setCellValue("출석");
        	  row.createCell(6).setCellValue("지각");
        	  row.createCell(7).setCellValue("결석");
        	  row.createCell(8).setCellValue("휴학");
        	  row.createCell(9).setCellValue("제적");
        	  for (int j = 0; j < temp2.length; j++) {
        		  row.createCell(10+j).setCellValue(temp2[j]);
  			}

        	  
        	  row.getCell(0).setCellStyle(titleCellStyle);
        	  row.getCell(1).setCellStyle(titleCellStyle);
        	  row.getCell(2).setCellStyle(titleCellStyle);
        	  row.getCell(3).setCellStyle(titleCellStyle);
        	  row.getCell(4).setCellStyle(titleCellStyle);
        	  row.getCell(5).setCellStyle(titleCellStyle);
        	  row.getCell(6).setCellStyle(titleCellStyle);
        	  row.getCell(7).setCellStyle(titleCellStyle);
        	  row.getCell(8).setCellStyle(titleCellStyle);
        	  row.getCell(9).setCellStyle(titleCellStyle);
        	  for (int j = 0; j < temp2.length; j++) {
        		  row.getCell(10+j).setCellStyle(titleCellStyle);
  				}
        	  
        	  for(int i=1;i<list.size()+1;i++){
        		  row = worksheet.createRow(i);
        		  row.createCell(0).setCellValue(list.get(i-1).get("STUDENT_NO").toString());
        		  row.createCell(1).setCellValue(list.get(i-1).get("STUDENT_NAME").toString());
        		  row.createCell(2).setCellValue(list.get(i-1).get("STUDENT_DEPT_NAME").toString());
        		  row.createCell(3).setCellValue(list.get(i-1).get("SUBJECT_CD")+"-"+list.get(i-1).get("SUBJECT_DIV_CD"));
        		  row.createCell(4).setCellValue(list.get(i-1).get("BEFORE_CNT").toString());
        		  row.createCell(5).setCellValue(list.get(i-1).get("PRESENT_CNT").toString());
        		  row.createCell(6).setCellValue(list.get(i-1).get("LATE_CNT").toString());
        		  row.createCell(7).setCellValue(list.get(i-1).get("ABSENT_CNT").toString());
        		  row.createCell(8).setCellValue(list.get(i-1).get("OFF_CNT").toString());
        		  row.createCell(9).setCellValue(list.get(i-1).get("QUIT_CNT").toString());

        		  //for (int j = 0; j < temp2.length; j++) {
               	  for (int j = 0; j < attend.get(i-1).length; j++) {
            		  System.out.println("["+i+"]["+j+"]list.size():["+list.size()+"],temp2.length:["+temp2.length+"]");
            		  System.out.println("["+i+"]["+j+"]attend.get(i-1):["+attend.get(i-1).length+"]");
            		  System.out.println("["+i+"]["+j+"]temp2.length:["+temp2.length+"],STUDENT_NAME:["+list.get(i-1).get("STUDENT_NAME")+"]sts:["+attend.get(i-1)[j]+"]");
            		  String[] temp = attend.get(i-1);
            		  if(temp[j].equals("G023C001")){
            			  row.createCell(10+j).setCellValue("출결전");
            		  }else if(temp[j].equals("G023C002")){
               			  row.createCell(10+j).setCellValue("출석");
            		  }else if(temp[j].equals("G023C003")){
               			  row.createCell(10+j).setCellValue("지각");
            		  }else if(temp[j].equals("G023C004")){
               			  row.createCell(10+j).setCellValue("결석");
            		  }else if(temp[j].equals("G023C005")){
               			  row.createCell(10+j).setCellValue("휴학");
            		  }else if(temp[j].equals("G023C007")){
               			  row.createCell(10+j).setCellValue("제적");
            		  }
      			  }        		  
        	  }
          }

          response.setContentType("Application/Msexcel");

          response.setHeader("Content-Disposition", "ATTachment; Filename="+excelName+".xls");

    }

}
