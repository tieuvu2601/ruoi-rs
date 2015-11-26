package com.banvien.portal.vms.webapp.controller.web;

import com.banvien.portal.vms.domain.*;
import com.banvien.portal.vms.service.*;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.support.ApplicationObjectSupport;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.banvien.portal.vms.exception.ObjectNotFoundException;

@Controller
public class HomeController extends ApplicationObjectSupport {
    private transient final Logger logger = Logger.getLogger(getClass());

    @Autowired
    private ContentService contentService;


    @RequestMapping(value = "/comment/{category}/{title}.html")
    public ModelAndView comment(@PathVariable(value = "category")String category,
                                @PathVariable(value = "title")String title){
        ModelAndView mav = new ModelAndView("redirect:/dong-gop-y-kien.html");
        return mav;
    }

//    PAGE CONTROLLER
    @RequestMapping(value = "/page/{categoryCode}/{title}.html")
    public ModelAndView viewPage(@PathVariable(value = "title")String title, @PathVariable(value = "categoryCode")String categoryCode){
        /* Authoring Template  STATIC HTML
        *      header
        *      content
        * */
        ModelAndView mav = new ModelAndView("/web/page/view");
        try{
//            title = convertUrlToCategoryCode(title);
            Content item = this.contentService.findEqualUnique("title", title);
            mav.addObject("item", item);
//            getRightMenuByCategoryRootID(mav, item.getCategory().getParentRootID(), item.getCategory().getCategoryID());
        }catch (ObjectNotFoundException e){
            mav = new ModelAndView("redirect:/404.html");
        }
        return mav;
    }


}
