<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.text.*" %> 
<%@ page import="java.io.File" %>
<%
	System.gc();
	int TotalMemory = (int)(Runtime.getRuntime().totalMemory() / (1024*1024));
	int FreeMemory = (int)(Runtime.getRuntime().freeMemory() / (1024*1024));
	int usedMemory = (int)(TotalMemory - FreeMemory);
	float FreeRatio = (float)((Runtime.getRuntime().freeMemory()*1.0 / Runtime.getRuntime().totalMemory()) * 100.0);
	DecimalFormat formatter = new DecimalFormat("###,###M");
	DecimalFormat formatter2 = new DecimalFormat("#,###.#");
	String strStyle = null;
	if(FreeRatio > 80){
		strStyle = "background-color:white;color:black";
	}else if (FreeRatio <= 80 && FreeRatio> 60){
		strStyle = "background-color:white;color:blue";
	}else if (FreeRatio <= 60 && FreeRatio> 40){
		strStyle = "background-color:white;color:red";
	}else if (FreeRatio <= 40){
		strStyle = "background-color:red;color:white";
	}	
	String  drive, color;
	double  totalSize, usedSize, useableSize, ratio;        
	File[] roots = File.listRoots();
%>
<!DOCTYPE html>
<html>
<head>
	<meta http-equiv="X-UA-Compatible" content="IE=edge" />
	<meta charset="utf-8" />
</head>
<body style="font-size:12px">
<div style="<%=strStyle%>">
Heap : <%=formatter.format(TotalMemory)%> - <%=formatter.format(usedMemory)%> = <%=formatter.format(FreeMemory)%>(<%=formatter2.format(FreeRatio)%>%)<br/>
</div>
<%
for (File root : roots) {
	drive = root.getAbsolutePath();
	totalSize = root.getTotalSpace() / Math.pow(1024, 3);
	useableSize = root.getUsableSpace() / Math.pow(1024, 3);
	usedSize = totalSize - useableSize;
	
	if( totalSize > 0 ){
		ratio = Math.round((useableSize / totalSize) * 100.0);
		color = "black";
		if(ratio <= 50){
		  color = "blue";
		}
		if(ratio <= 10){
		  color = "red";
		}
		out.print("<font color='" + color + "'>");
		out.print(drive + " : " + (Math.round(totalSize*100)/100.0) + " - " + (Math.round(usedSize*100)/100.0) + " = " + (Math.round(useableSize*100)/100.0) + " GB(" + ratio + "%)<br/> \n");		
		out.println("</font>");
	}
} 
%>
</body>
</html>
