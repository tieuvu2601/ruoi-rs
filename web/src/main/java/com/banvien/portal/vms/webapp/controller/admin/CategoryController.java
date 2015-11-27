package com.banvien.portal.vms.webapp.controller.admin;

import java.io.PrintWriter;
import java.sql.Date;
import java.sql.Timestamp;
import java.util.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.banvien.portal.vms.domain.CategoryEntity;
import com.banvien.portal.vms.util.CategoryUtil;
import org.apache.commons.lang.StringUtils;
import org.apache.log4j.Logger;
import org.json.JSONArray;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.support.ApplicationObjectSupport;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.banvien.portal.vms.bean.CategoryBean;
import com.banvien.portal.vms.domain.AuthoringTemplateEntity;
import com.banvien.portal.vms.editor.CustomDateEditor;
import com.banvien.portal.vms.editor.PojoEditor;
import com.banvien.portal.vms.exception.ObjectNotFoundException;
import com.banvien.portal.vms.service.AuthoringTemplateService;
import com.banvien.portal.vms.service.CategoryService;
import com.banvien.portal.vms.util.Constants;
import com.banvien.portal.vms.util.RequestUtil;
import com.banvien.portal.vms.webapp.validator.CategoryValidator;

@Controller
public class CategoryController extends ApplicationObjectSupport {
	private transient final Logger logger = Logger.getLogger(getClass());

    @Autowired
    private CategoryService categoryService;

    @Autowired
    private CategoryValidator categoryValidator;

    @Autowired
    private AuthoringTemplateService authoringTemplateService;

    @InitBinder
    public void initBinder(WebDataBinder binder) {
    	binder.registerCustomEditor(Date.class, new CustomDateEditor());
        binder.registerCustomEditor(AuthoringTemplateEntity.class, new PojoEditor(AuthoringTemplateEntity.class, "authoringTemplateID", Long.class));
	}

    @RequestMapping("/admin/category/edit.html")
    public ModelAndView edit(@ModelAttribute(Constants.FORM_MODEL_KEY) CategoryBean bean, BindingResult bindingResult){
        ModelAndView mav = new ModelAndView("/admin/category/edit");
        String crudaction = bean.getCrudaction();
        CategoryEntity pojo = bean.getPojo();
        if(StringUtils.isNotBlank(crudaction) && crudaction.equals("insert-update")) {
            try{
                categoryValidator.validate(bean, bindingResult);
                if(!bindingResult.hasErrors()){
                    if(pojo.getCategoryId() != null && pojo.getCategoryId() >0 ){
                        pojo.setModifiedDate(new Timestamp(System.currentTimeMillis()));
                        pojo = this.categoryService.updateItem(pojo);
                        mav.addObject("messageResponse", this.getMessageSourceAccessor().getMessage("database.update.successful"));
                    }else{
                        pojo.setCreatedDate(new Timestamp(System.currentTimeMillis()));
                        pojo.setModifiedDate(new Timestamp(System.currentTimeMillis()));
                        pojo = this.categoryService.save(pojo);
                        mav.addObject("messageResponse", this.getMessageSourceAccessor().getMessage("database.add.successful"));
                    }
                    bean.setPojo(pojo);
                    mav.addObject("success", true);
                }
            }catch(Exception e) {
                logger.error(e.getMessage(), e);
                mav.addObject("messageResponse", this.getMessageSourceAccessor().getMessage("general.exception.msg"));
            }
        }
        if(!bindingResult.hasErrors() && bean.getPojo().getCategoryId() != null){
            try{
                bean.setPojo(categoryService.findById(bean.getPojo().getCategoryId()));
            }catch (ObjectNotFoundException oe) {
                logger.error(oe.getMessage(), oe);
                mav.addObject("messageResponse", this.getMessageSourceAccessor().getMessage("database.exception.keynotfound"));
            }
        }
        referenceData(mav);
        mav.addObject(Constants.FORM_MODEL_KEY, bean);
        return mav;
    }

    @RequestMapping(value={"/admin/category/list.html"})
    public ModelAndView list(CategoryBean bean, HttpServletRequest request) {
        ModelAndView mav = new ModelAndView("/admin/category/list");
        if(StringUtils.isNotBlank(bean.getCrudaction()) && bean.getCrudaction().equals(Constants.ACTION_DELETE)) {
            Integer totalDeleted = 0;
            try {
                totalDeleted = categoryService.deleteItems(bean.getCheckList());
            	mav.addObject("totalDeleted", totalDeleted);
                mav.addObject("messageResponse", this.getMessageSourceAccessor().getMessage("database.delete.successful", new String[]{totalDeleted.toString(), String.valueOf(bean.getCheckList().length)}));
            }catch (Exception e) {
                logger.error(e.getMessage(), e);
                mav.addObject(Constants.MESSAGE_RESPONSE_MODEL_KEY, this.getMessageSourceAccessor().getMessage("database.multipledelete.exception"));
            }
        }
        executeSearch(bean, request);
        mav.addObject(Constants.LIST_MODEL_KEY, bean);
        referenceData(mav);
        return mav;
    }

    @RequestMapping("/ajax/loadCategoryByAuthoringTemplate.html")
	public void sendMessage(HttpServletRequest request, HttpServletResponse response) {
		try{
			response.setContentType("text/json; charset=UTF-8");
			PrintWriter out = response.getWriter();
			JSONObject object = new JSONObject();
			JSONArray array = new JSONArray();
			String authoringTemplateIDstr = request.getParameter("au");
			if(StringUtils.isNotBlank(authoringTemplateIDstr)){
				Long authoringTemplateID = Long.valueOf(authoringTemplateIDstr);
				List<CategoryEntity> categories = categoryService.findProperty("authoringTemplate.authoringTemplateID", authoringTemplateID);
				for(CategoryEntity categoryEntity : categories){
					array.put(new JSONArray(new Object[]{categoryEntity.getCategoryId(), categoryEntity.getName()}));
				}
			}
			object.put("array", array);
			object.put("success", true);
            out.print(object);
            out.flush();
            out.close();
		}catch(Exception e){
			logger.error(e.getMessage(), e);
		}
	}

    private void executeSearch(CategoryBean bean, HttpServletRequest request) {
        RequestUtil.initSearchBean(request, bean);
        Map<String, Object> properties = new HashMap<String, Object>();
        if(StringUtils.isNotBlank(bean.getPojo().getCode())){
            properties.put("code", bean.getPojo().getCode());
        }
        if(StringUtils.isNotBlank(bean.getPojo().getName())){
            properties.put("name", bean.getPojo().getName());
        }
        if(bean.getPojo().getParent() != null && bean.getPojo().getParent() != null && bean.getPojo().getParent().getCategoryId() > 0){
            properties.put("parentCategory.categoryID", bean.getPojo().getParent().getCategoryId());
        }
        Object[] results = this.categoryService.searchByProperties(properties, bean.getSortExpression(), bean.getSortDirection(), bean.getFirstItem(), bean.getMaxPageItems());
        bean.setListResult((List<CategoryEntity>)results[1]);
        bean.setTotalItems(Integer.valueOf(results[0].toString()));
    }
    private void referenceData(ModelAndView mav) {
        mav.addObject("authoringtemplates", authoringTemplateService.findAll());
        List<CategoryEntity> categories = this.categoryService.findAllCategoryParent();
        mav.addObject("categories", CategoryUtil.getAllCategoryObjectInSite(categories));
    }


}
