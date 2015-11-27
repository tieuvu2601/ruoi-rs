package com.banvien.portal.vms.webapp.controller.web;

import java.sql.Timestamp;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import com.banvien.portal.vms.domain.ContentEntity;
import com.banvien.portal.vms.editor.CustomDateEditor;
import com.banvien.portal.vms.util.CommonUtil;
import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.support.ApplicationObjectSupport;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.banvien.portal.vms.bean.SearchBean;
import com.banvien.portal.vms.service.AuthoringTemplateService;
import com.banvien.portal.vms.service.CategoryService;
import com.banvien.portal.vms.service.ContentService;
import com.banvien.portal.vms.util.Constants;
import com.banvien.portal.vms.util.RequestUtil;

@Controller
public class SearchController extends ApplicationObjectSupport {

	@Autowired
	private AuthoringTemplateService authoringTemplateService;
	
	@Autowired
	private CategoryService categoryService;
	
	@Autowired
	private ContentService contentService;
	@InitBinder
    public void initBinder(WebDataBinder binder) {
        binder.registerCustomEditor(Timestamp.class, new CustomDateEditor("dd/MM/yyyy"));
	}
	@RequestMapping("/search.html")
	public ModelAndView search(@ModelAttribute SearchBean bean, HttpServletRequest request){
		ModelAndView mav = new ModelAndView("web/search");
        String crudaction = bean.getCrudaction();
        if(StringUtils.isNotBlank(crudaction) && "search".equals(crudaction) && StringUtils.isNotEmpty(bean.getKeyword())){
            RequestUtil.initSearchBean(request, bean);
            Integer pageNumber = 1;
            if(bean.getPageNumber() != null && bean.getPageNumber() > 0){
                pageNumber = bean.getPageNumber();
            }
            mav.addObject("pageNumber", pageNumber);
            Integer startRow;
            startRow = (pageNumber - 1) * bean.getMaxPageItems();
            bean.setFirstItem(startRow);

            Object[] objs = contentService.searchInSite(bean.getKeyword(), bean.getFromDate(), bean.getToDate(), bean.getFirstItem(), bean.getMaxPageItems(), CommonUtil.isEnglishLanguage(), Constants.CONTENT_PUBLISH);

            bean.setListResult((List<ContentEntity>) objs[1]);
//            bean.setTotalItems((Integer) objs[0]);


            Long totalItem = (Long) objs[0];
            Long maxPageNumber;
            if(totalItem % bean.getMaxPageItems() == 0){
                maxPageNumber = totalItem / bean.getMaxPageItems();
            } else {
                maxPageNumber = (totalItem - (totalItem % bean.getMaxPageItems()))/bean.getMaxPageItems() + 1;
            }
            mav.addObject("maxPageNumber", maxPageNumber);
        }
		mav.addObject(Constants.FORM_MODEL_KEY, bean);
		return mav;
	}
}
