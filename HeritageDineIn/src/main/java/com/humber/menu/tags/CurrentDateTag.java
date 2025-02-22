package com.humber.menu.tags;

import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;
import jakarta.servlet.jsp.JspException;
import jakarta.servlet.jsp.tagext.TagSupport;

public class CurrentDateTag extends TagSupport {
    public int doStartTag() throws JspException {
        SimpleDateFormat formatter = new SimpleDateFormat("MMMM dd, yyyy");
        Date date = new Date();
        String currentDate = formatter.format(date);
        String copyrightContent = "&copy; " + new SimpleDateFormat("yyyy").format(date) + " HeritageDineIn. All rights reserved.";
        
        try {
            pageContext.getOut().print("<br>" + copyrightContent + " " + currentDate);
        } catch (IOException e) {
            e.printStackTrace();
        }
        return SKIP_BODY;
    }
}