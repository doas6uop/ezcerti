package com.icerti.ezcerti.util;

import java.io.IOException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.jsp.JspException;
import javax.servlet.jsp.JspWriter;
import javax.servlet.jsp.PageContext;
import javax.servlet.jsp.tagext.SimpleTagSupport;

/**
 * 모바일용 pagination 커스텀태그
 * @author Administrator
 *
 */
public class PageGroupTagMobile extends SimpleTagSupport {

	@Override
	public void doTag() throws JspException, IOException {
		super.doTag();
		PageContext pageContext = (PageContext) getJspContext();
		HttpServletRequest request = (HttpServletRequest) pageContext.getRequest();

		PageBean<?> pb = (PageBean<?>) request.getAttribute("pageBean");
		
		JspWriter out = pageContext.getOut();
		
		if (pb.getStartPage() > 1) {
			out.print("<a href=\"javascript:paging(1"
					+ ")\">◀</a>&nbsp;");
			out.print("<a href=\"javascript:paging(" + (pb.getStartPage() - 1)
					+ ")\">◀</a>");
		}
		int i = pb.getStartPage();
		for (; i <= pb.getEndPage(); i++) {
			if (i == pb.getCurrentPage()) {
				out.print("<span class=\"paingbluefont\">&nbsp;&nbsp;" + i + "</span>");
			} else {
				out.print("<span class=\"painggrayfont\">&nbsp;&nbsp;<a href=\"javascript:paging(" + i + ")\">" + i + "</a>");
			}
		}
		if (pb.getTotalPage() > pb.getEndPage()) {
			out.print("&nbsp;&nbsp;<a href=\"javascript:paging(" + (pb.getEndPage() + 1) + ")\">▶</a>");
			out.print("&nbsp;<a href=\"javascript:paging(" + (pb.getTotalPage()) + ")\">▶</a>");
		}
	
	}

}
