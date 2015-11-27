package com.banvien.portal.vms.taglibs.contents;

import com.banvien.portal.vms.util.CommonUtil;
import org.springframework.context.ApplicationContext;
import org.springframework.web.context.support.WebApplicationContextUtils;

import javax.servlet.jsp.JspException;
import javax.servlet.jsp.tagext.TagSupport;

/**
 * Created with IntelliJ IDEA.
 * UserEntity: HauKute
 * Date: 10/20/15
 * Time: 11:35 AM
 * To change this template use File | Settings | File Templates.
 */
public class LocaleTagLib extends TagSupport {
    public int doStartTag() throws JspException {
        ApplicationContext context = WebApplicationContextUtils.getWebApplicationContext(this.pageContext.getServletContext());
        String currentLanguage = "vi";
        if(CommonUtil.isEnglishLanguage()){
            currentLanguage = "en";
        }
        this.pageContext.setAttribute(this.var, currentLanguage);
        return SKIP_BODY;
    }

    public int doEndTag() throws JspException {
        return EVAL_PAGE;
    }

    private String var;

    public String getVar() {
        return var;
    }

    public void setVar(String var) {
        this.var = var;
    }
}
