package com.banvien.portal.vms.webapp.controller.admin;

import com.banvien.portal.vms.bean.DepartmentBean;
import com.banvien.portal.vms.domain.Department;
import com.banvien.portal.vms.exception.ObjectNotFoundException;
import com.banvien.portal.vms.service.DepartmentService;
import com.banvien.portal.vms.util.Constants;
import com.banvien.portal.vms.util.RequestUtil;
import com.banvien.portal.vms.webapp.validator.DepartmentValidator;
import org.apache.commons.lang.StringUtils;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.support.ApplicationObjectSupport;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import java.sql.Timestamp;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Created with IntelliJ IDEA.
 * User: NhuKhang
 * Date: 10/6/12
 * Time: 10:57 AM
 */
@Controller
public class DepartmentController extends ApplicationObjectSupport {
	private transient final Logger logger = Logger.getLogger(getClass());

    @Autowired
    private DepartmentService departmentService;

    @Autowired
    private DepartmentValidator departmentValidator;

    @RequestMapping("/admin/department/edit.html")
    public ModelAndView edit(@ModelAttribute(Constants.FORM_MODEL_KEY) DepartmentBean bean, BindingResult bindingResult){
        ModelAndView mav = new ModelAndView("admin/department/edit");
        String crudaction = bean.getCrudaction();
        Department pojo = bean.getPojo();
        if(StringUtils.isNotBlank(crudaction) && crudaction.equals("insert-update")) {
            try{
                departmentValidator.validate(bean, bindingResult);
                if(!bindingResult.hasErrors()){
                    if(pojo.getDepartmentID() != null && pojo.getDepartmentID() >0 ){
                        this.departmentService.updateItem(pojo);
                        mav.addObject("messageResponse", this.getMessageSourceAccessor().getMessage("database.update.successful"));
                    }else{
                        pojo.setCreatedDate(new Timestamp(System.currentTimeMillis()));
                        pojo.setModifiedDate(new Timestamp(System.currentTimeMillis()));
                        if (pojo.getIsBranch() == null) {
                            pojo.setIsBranch(0);
                        }
                        this.departmentService.save(pojo);
                        mav.addObject("messageResponse", this.getMessageSourceAccessor().getMessage("database.add.successful"));
                    }
                    mav.addObject("success", true);
                }
            }catch(Exception e) {
                logger.error(e.getMessage(), e);
                mav.addObject("messageResponse", this.getMessageSourceAccessor().getMessage("general.exception.msg"));
            }
        }
        if(!bindingResult.hasErrors() && bean.getPojo().getDepartmentID() != null){

            try{
                bean.setPojo(departmentService.findById(bean.getPojo().getDepartmentID()));
            }catch (ObjectNotFoundException oe) {
                logger.error(oe.getMessage(), oe);
                mav.addObject("messageResponse", this.getMessageSourceAccessor().getMessage("database.exception.keynotfound"));
            }
        }
        mav.addObject(Constants.FORM_MODEL_KEY, bean);
        return mav;
    }

    @RequestMapping(value={"/admin/department/list.html"})
    public ModelAndView list(DepartmentBean bean, HttpServletRequest request) {
        ModelAndView mav = new ModelAndView("/admin/department/list");
        if(StringUtils.isNotBlank(bean.getCrudaction()) && bean.getCrudaction().equals(Constants.ACTION_DELETE)) {
            Integer totalDeleted = 0;
            try {
                totalDeleted = departmentService.deleteItems(bean.getCheckList());
            	mav.addObject("totalDeleted", totalDeleted);
                mav.addObject("messageResponse", this.getMessageSourceAccessor().getMessage("database.delete.successful", new String[]{totalDeleted.toString(), String.valueOf(bean.getCheckList().length)}));
            }catch (Exception e) {
                logger.error(e.getMessage(), e);
                mav.addObject(Constants.MESSAGE_RESPONSE_MODEL_KEY, this.getMessageSourceAccessor().getMessage("database.multipledelete.exception"));
            }
        }
        executeSearch(bean, request);
        mav.addObject(Constants.LIST_MODEL_KEY, bean);
        return mav;
    }

    private void executeSearch(DepartmentBean bean, HttpServletRequest request) {
        RequestUtil.initSearchBean(request, bean);
        Map<String, Object> properties = new HashMap<String, Object>();
        if(StringUtils.isNotBlank(bean.getPojo().getName())){
            properties.put("name", bean.getPojo().getName());
        }
        if(StringUtils.isNotBlank(bean.getPojo().getCode())){
            properties.put("code", bean.getPojo().getCode());
        }
        Object[] results = this.departmentService.searchByProperties(properties, bean.getSortExpression(), bean.getSortDirection(), bean.getFirstItem(), bean.getMaxPageItems());
        bean.setListResult((List<Department>)results[1]);
        bean.setTotalItems(Integer.valueOf(results[0].toString()));
    }
}
