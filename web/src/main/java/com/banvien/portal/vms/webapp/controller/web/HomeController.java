package com.banvien.portal.vms.webapp.controller.web;

import com.banvien.portal.vms.util.Constants;
import org.springframework.context.support.ApplicationObjectSupport;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class HomeController extends ApplicationObjectSupport {

    @RequestMapping({"/index.html", "/"})
    public ModelAndView home() throws Exception{
        ModelAndView mav = new ModelAndView("web/body");

        mav.addObject("newsPrefixUrl", Constants.RESEARCH_PROJECT_PREFIX_URL);
        mav.addObject("eventPrefixUrl", Constants.RESEARCH_PROJECT_PREFIX_URL);
        mav.addObject("researchProjectPrefixUrl", Constants.RESEARCH_PROJECT_PREFIX_URL);
        return mav;
    }
}
