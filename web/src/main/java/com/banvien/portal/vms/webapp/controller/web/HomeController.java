package com.banvien.portal.vms.webapp.controller.web;

import com.banvien.portal.vms.bean.CustomerBean;
import com.banvien.portal.vms.domain.ContentEntity;
import com.banvien.portal.vms.service.ContentService;
import com.banvien.portal.vms.util.Constants;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.support.ApplicationObjectSupport;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import java.util.List;

@Controller
public class HomeController extends ApplicationObjectSupport {

    @Autowired
    private ContentService contentService;

    @RequestMapping({"/index.html", "/"})
    public ModelAndView home() throws Exception{
        ModelAndView mav = new ModelAndView("web/home");
        mav.addObject("customerForm", new CustomerBean());
        return mav;
    }
}
