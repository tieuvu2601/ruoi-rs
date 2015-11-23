package com.banvien.jcr.taglib;


/**
 * 
 * Copyright (c) 2007 Hoang Hac Solutions Team. All rights reserved.
 *
 * The copyright to the computer software herein is the property of
 * Hoang Hac Solutions Team. The software may be used and/or copied only
 * with the written permission of Hoang Hac Solutions Team. or in accordance
 * with the terms and conditions stipulated in the agreement/contract
 * under which the software has been supplied.
 * HighLightTag.java
 *
 */

import java.io.IOException;

import javax.servlet.jsp.JspException;
import javax.servlet.jsp.tagext.TagSupport;

import org.apache.commons.lang.StringUtils;

/**
 * @author nhvien
 * @email Vien Nguyen [vien.ly.hhac@gmail.com]
 */
public class RepositoryFileTag extends TagSupport {
	private String value;
	private boolean fullDisplay;
	private String servletName;
	private String cssStyle;
	private String cssClass;
	private String displayName;
    private String var;

	/**
	 * @return the displayName
	 */
	public String getDisplayName() {
		return displayName;
	}

	/**
	 * @param displayName the displayName to set
	 */
	public void setDisplayName(String displayName) {
		this.displayName = displayName;
	}

	/**
	 * @return the fullDisplay
	 */
	public boolean isFullDisplay() {
		return fullDisplay;
	}

	/**
	 * @param fullDisplay the fullDisplay to set
	 */
	public void setFullDisplay(boolean fullDisplay) {
		this.fullDisplay = fullDisplay;
	}

	/**
	 * @return the servletName
	 */
	public String getServletName() {
		return servletName;
	}

	/**
	 * @param servletName the servletName to set
	 */
	public void setServletName(String servletName) {
		this.servletName = servletName;
	}

	/**
	 * @return the cssStyle
	 */
	public String getCssStyle() {
		return cssStyle;
	}

	/**
	 * @param cssStyle the cssStyle to set
	 */
	public void setCssStyle(String cssStyle) {
		this.cssStyle = cssStyle;
	}

	/**
	 * @return the cssClass
	 */
	public String getCssClass() {
		return cssClass;
	}

	/**
	 * @param cssClass the cssClass to set
	 */
	public void setCssClass(String cssClass) {
		this.cssClass = cssClass;
	}

	/**
	 * @return the value
	 */
	public String getValue() {
		return value;
	}

	/**
	 * @param value the value to set
	 */
	public void setValue(String value) {
		this.value = value;
	}

    public String getVar() {
        return var;
    }

    public void setVar(String var) {
        this.var = var;
    }

    public int doStartTag() throws JspException {
		try{
			String res = "";
            String url = "";
			if (StringUtils.isBlank(servletName)) {
				servletName = "repository";
                url = "/"  + servletName + value;
				res = "<a href='" + url + "'";
			}else {
                url = "/" +  servletName + value;
				res = "<a href='" + url  + "'";
			}

			if (StringUtils.isNotBlank(cssStyle)) {
				res += " style='" + cssStyle + "'";
			}
			if (StringUtils.isNotBlank(cssClass)) {
				res += " class='" + cssClass + "'";
			}
			res += ">";
			
			if (fullDisplay) {
				res += value;
			}else{
				if (StringUtils.isNotBlank(displayName)) {
					res += displayName;
				}else{
					res += getFilename(value);
				}
			}
			res += "</a>";
            if (StringUtils.isNotBlank(var)) {
                pageContext.setAttribute(var, url);
            }else{
			    pageContext.getOut().write(res);
            }
		}catch(IOException e) {
			
		}
		return SKIP_BODY;
	}
	
	private String getFilename(String fileName) {
		String[] tmp = fileName.split("/");
		if (tmp != null && tmp.length > 0) {
			return tmp[tmp.length - 1];
		}
		return fileName;
	}

	public int doEndTag() {
		return EVAL_PAGE;
	}

}
