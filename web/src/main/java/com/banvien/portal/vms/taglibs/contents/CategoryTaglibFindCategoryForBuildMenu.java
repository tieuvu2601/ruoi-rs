package com.banvien.portal.vms.taglibs.contents;

import com.banvien.portal.vms.domain.CategoryObject;
import com.banvien.portal.vms.service.CategoryService;
import com.banvien.portal.vms.util.CommonUtil;
import org.springframework.context.ApplicationContext;
import org.springframework.web.context.support.WebApplicationContextUtils;

import javax.servlet.jsp.JspException;
import javax.servlet.jsp.tagext.TagSupport;
import java.util.ArrayList;
import java.util.List;

/**
 * Created by IntelliJ IDEA.
 * User: viennh
 * Date: 12/18/12
 * Time: 4:40 PM
 * To change this template use File | Settings | File Templates.
 */
public class CategoryTaglibFindCategoryForBuildMenu extends TagSupport {

    public int doStartTag() throws JspException {
        ApplicationContext context = WebApplicationContextUtils.getWebApplicationContext(this.pageContext.getServletContext());

        if(context != null) {
            List<CategoryObject> resultList = new ArrayList<CategoryObject>();
            CategoryService categoryService = context.getBean(CategoryService.class);
            List<CategoryObject>  categoryObjects = categoryService.findCategoryForBuildMenu(CommonUtil.isEnglishLanguage());
            for(CategoryObject categoryObject : categoryObjects){
                if(categoryObject.getNodeLevel() != null && categoryObject.getNodeLevel() <= nodeLevel && categoryObject.getDisplayOrder() > 0){
                    resultList.add(categoryObject);
                }
            }

            if(resultList != null) {
                this.pageContext.setAttribute(this.var, resultList);
            }
        }
        return SKIP_BODY;
    }

    public int doEndTag() throws JspException {
        return EVAL_PAGE;
    }

    private Integer nodeLevel;


    private String var;

    public Integer getNodeLevel() {
        return nodeLevel;
    }

    public void setNodeLevel(Integer nodeLevel) {
        this.nodeLevel = nodeLevel;
    }

    public String getVar() {
        return var;
    }

    public void setVar(String var) {
        this.var = var;
    }
}
