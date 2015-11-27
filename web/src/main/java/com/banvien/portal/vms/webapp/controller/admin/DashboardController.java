package com.banvien.portal.vms.webapp.controller.admin;

import com.banvien.portal.vms.bean.RoleBean;
import com.banvien.portal.vms.domain.RoleEntity;
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
 * UserEntity: NhuKhang
 * Date: 10/6/12
 * Time: 10:57 AM
 */
@Controller
public class DashboardController extends ApplicationObjectSupport {
	private transient final Logger logger = Logger.getLogger(getClass());

    @Autowired
    private RoleService roleService;

    @Autowired
    private RoleValidator roleValidator;

    @RequestMapping("/admin/dashboard.html")
    public ModelAndView dashboard(@ModelAttribute(Constants.FORM_MODEL_KEY) RoleBean bean, BindingResult bindingResult){
        ModelAndView mav = new ModelAndView("/admin/dashboard/dashboard");

        mav.addObject(Constants.FORM_MODEL_KEY, bean);
        return mav;
    }
}
