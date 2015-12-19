package com.banvien.portal.vms.webapp.controller.web;

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
        getRecentNews(mav);
        getHotProduct(mav);
        return mav;
    }

    private void getRecentNews(ModelAndView mav){
        List<ContentEntity> recentNews = this.contentService.findByCategory(Constants.CATEGORY_RECENT_NEWS, 0, 5, Constants.CONTENT_PUBLISH);
        mav.addObject("recentNews", recentNews);

    }

    private void getHotProduct(ModelAndView mav){
        List<ContentEntity> hotProducts = this.contentService.getHotProduct(0, 10, Constants.CONTENT_PUBLISH);
        mav.addObject("hotProducts", hotProducts);
    }

}
