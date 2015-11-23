package com.banvien.portal.vms.webapp.controller.admin;

import com.banvien.portal.vms.bean.RoleBean;
import com.banvien.portal.vms.domain.Role;
import com.banvien.portal.vms.exception.ObjectNotFoundException;
import com.banvien.portal.vms.service.RoleService;
import com.banvien.portal.vms.util.Constants;
import com.banvien.portal.vms.util.RequestUtil;
import com.banvien.portal.vms.webapp.validator.RoleValidator;
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
public class RoleController extends ApplicationObjectSupport {
	private transient final Logger logger = Logger.getLogger(getClass());

    @Autowired
    private RoleService roleService;

    @Autowired
    private RoleValidator roleValidator;

    @RequestMapping("/admin/role/edit.html")
    public ModelAndView edit(@ModelAttribute(Constants.FORM_MODEL_KEY) RoleBean bean, BindingResult bindingResult){
        ModelAndView mav = new ModelAndView("/admin/role/edit");
        String crudaction = bean.getCrudaction();
        Role pojo = bean.getPojo();
        if(StringUtils.isNotBlank(crudaction) && crudaction.equals("insert-update")) {
            try{
                roleValidator.validate(bean, bindingResult);
                if(!bindingResult.hasErrors()){
                    if(pojo.getRoleID() != null && pojo.getRoleID() >0 ){
                        this.roleService.updateItem(pojo);
                        mav.addObject("messageResponse", this.getMessageSourceAccessor().getMessage("database.update.successful"));
                    }
                    else
                    {
                        bean.getPojo().setCreatedDate(new Timestamp(new java.util.Date().getTime()));
                        bean.getPojo().setModifiedDate(new Timestamp(new java.util.Date().getTime()));
                        this.roleService.save(bean.getPojo());
                  		mav.addObject("messageResponse", this.getMessageSourceAccessor().getMessage("database.add.successful"));
                    }
                    mav.addObject("success", true);
                }
            }catch(ObjectNotFoundException oe){
                logger.error(oe.getMessage(), oe);
                mav.addObject("messageResponse", this.getMessageSourceAccessor().getMessage("general.exception.msg"));
            }catch(Exception e) {
                logger.error(e.getMessage(), e);
                mav.addObject("messageResponse", this.getMessageSourceAccessor().getMessage("general.exception.msg"));
            }
        }
        if(!bindingResult.hasErrors() && pojo.getRoleID() != null){
            try{
                bean.setPojo(roleService.findById(pojo.getRoleID()));
            }catch (ObjectNotFoundException ex) {
                logger.error(ex.getMessage(), ex);
                mav.addObject("messageResponse", this.getMessageSourceAccessor().getMessage("database.exception.keynotfound"));
            }
        }
        mav.addObject(Constants.FORM_MODEL_KEY, bean);
        return mav;
    }

    @RequestMapping(value={"/admin/role/list.html"})
    public ModelAndView list(RoleBean bean, HttpServletRequest request) {
    	ModelAndView mav = new ModelAndView("/admin/role/list");

        if(StringUtils.isNotBlank(bean.getCrudaction()) && bean.getCrudaction().equals(Constants.ACTION_DELETE)) {
            Integer totalDeleted = 0;
            try {
                totalDeleted = roleService.deleteItems(bean.getCheckList());
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

    private void executeSearch(RoleBean bean, HttpServletRequest request) {
        RequestUtil.initSearchBean(request, bean);
        Map<String, Object> properties = new HashMap<String, Object>();
        if(StringUtils.isNotBlank(bean.getPojo().getName())){
            properties.put(Role.FIELD_NAME, bean.getPojo().getName());
        }
        if(StringUtils.isNotBlank(bean.getPojo().getRole())){
            properties.put(Role.FIELD_ROLE, bean.getPojo().getRole());
        }
        Object[] results = this.roleService.searchByProperties(properties, bean.getSortExpression(), bean.getSortDirection(), bean.getFirstItem(), bean.getMaxPageItems());
        bean.setListResult((List<Role>)results[1]);
        bean.setTotalItems(Integer.valueOf(results[0].toString()));
    }
}
