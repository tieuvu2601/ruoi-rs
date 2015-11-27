package com.banvien.portal.vms.taglibs;

import com.banvien.portal.vms.util.CommonUtil;

import javax.servlet.jsp.JspException;
import javax.servlet.jsp.JspWriter;
import javax.servlet.jsp.tagext.TagSupport;
import java.io.IOException;

/**
 * Created by viennh
 * UserEntity: Nguyen Hai Vien
 * Date: 11/21/11
 * Time: 3:56 PM
 * To change this template use File | Settings | File Templates.
 */
public class SEOTag extends TagSupport {
	private String value;
    private String prefix;
	private String var;

	public int doStartTag() throws JspException {
		String t = (this.value != null) ? this.value.trim().toLowerCase() : "";
		if(t.length() > 0) {
			t = CommonUtil.removeDiacritic(t);
		}
		String[] strs = t.split(" ");
		StringBuilder textBuilder = new StringBuilder();
        if (prefix != null) {
            textBuilder.append(prefix);
        }
        int i = 0;
		for(String str : strs){
			if(str.length() > 0) {
				if(i > 0) {
					textBuilder.append("-");
				}
				textBuilder.append(str);
                i++;
			}
		}
        textBuilder.append(".html");
		String text = textBuilder.toString();
		if (this.var == null) {
	        JspWriter writer = this.pageContext.getOut();
	        try {
	          writer.print(text);
	        } catch (IOException e) {
	          throw new JspException(e.toString());
	        }
	      } else {
	        this.pageContext.setAttribute(this.var, text);
	      }
		return SKIP_BODY;
	}

	public int doEndTag() throws JspException {
		return EVAL_PAGE;
	}

	public String getValue() {
		return value;
	}

	public void setValue(String value) {
		this.value = value;
	}

	public String getVar() {
		return var;
	}

	public void setVar(String var) {
		this.var = var;
	}

    public String getPrefix() {
        return prefix;
    }

    public void setPrefix(String prefix) {
        this.prefix = prefix;
    }
}