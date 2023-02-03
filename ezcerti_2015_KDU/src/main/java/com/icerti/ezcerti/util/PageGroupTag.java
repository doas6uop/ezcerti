package com.icerti.ezcerti.util;

import java.io.IOException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.jsp.JspException;
import javax.servlet.jsp.JspWriter;
import javax.servlet.jsp.PageContext;
import javax.servlet.jsp.tagext.SimpleTagSupport;

/**
 * pagination 커스텀태그
 * @author Administrator
 *
 */
public class PageGroupTag extends SimpleTagSupport {

	@Override
	public void doTag() throws JspException, IOException {
		super.doTag();
		PageContext pageContext = (PageContext) getJspContext();
		HttpServletRequest request = (HttpServletRequest) pageContext.getRequest();

		PageBean<?> pb = (PageBean<?>) request.getAttribute("pageBean");
		
		JspWriter out = pageContext.getOut();
		
		if (pb.getStartPage() > 1) {
			out.print("<a href=\"javascript:paging(1" 
					+ ")\"><span class=\"pagingprev\"><img src=\""+request.getContextPath()+"/resources/images/admin/left_arrow.png\" width=\"5\" height=\"9\" style=\"margin-right:5px;\" alt=\"왼쪽화살표\" />처음</span></a>&nbsp;");
			out.print("<a href=\"javascript:paging(" + (pb.getStartPage() - 1)
					+ ")\"><span class=\"pagingprev\"><img src=\""+request.getContextPath()+"/resources/images/admin/left_arrow.png\" width=\"5\" height=\"9\" style=\"margin-right:5px;\" alt=\"왼쪽화살표\" />이전</span></a>");
		}
		int i = pb.getStartPage();
		for (; i <= pb.getEndPage(); i++) {
			if (i == pb.getCurrentPage()) {
				out.print("<span class=\"pagingbluefont\">&nbsp;" + i + "</span>");
			} else {
				out.print("&nbsp;<a href=\"javascript:paging(" + i + ")\">"+"<span class=\"pagingfont\">" + i +"</span>"+"</a>");
			}
		}
		if (pb.getTotalPage() > pb.getEndPage()) {
			out.print("&nbsp;<a href=\"javascript:paging(" + (pb.getEndPage() + 1) + ")\">" +
					"<span class=\"pagingnext\">다음<img src=\""+request.getContextPath()+"/resources/images/admin/right_arrow.png\" width=\"5\" height=\"9\" style=\"margin-left:5px;\" alt=\"오른쪽화살표\" /></span></a>");
			out.print("&nbsp;<a href=\"javascript:paging(" + (pb.getTotalPage()) + ")\">" +
					"<span class=\"pagingnext\">마지막<img src=\""+request.getContextPath()+"/resources/images/admin/right_arrow.png\" width=\"5\" height=\"9\" style=\"margin-left:5px;\" alt=\"오른쪽화살표\" /></span></a>");
		}
	
	}

}
