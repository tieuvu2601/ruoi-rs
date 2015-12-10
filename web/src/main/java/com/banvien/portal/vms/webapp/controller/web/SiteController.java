package com.banvien.portal.vms.webapp.controller.web;

import org.springframework.context.support.ApplicationObjectSupport;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class SiteController extends ApplicationObjectSupport {

    @RequestMapping(value = "/products/{productTypeId}/{productType}.html")
    public ModelAndView viewProducts(@PathVariable(value = "productTypeId")Long productTypeId, @PathVariable(value = "productType")String productType){
        ModelAndView mav = new ModelAndView("/web/product/list");
//        try{
//            title = convertUrlToCategoryCode(title);
//            Content item = this.contentService.findEqualUnique("title", title);
//            mav.addObject("item", item);
//            getRightMenuByCategoryRootID(mav, item.getCategory().getParentRootID(), item.getCategory().getCategoryID());
//        }catch (ObjectNotFoundException e){
//            mav = new ModelAndView("redirect:/404.html");
//        }
        return mav;
    }

    @RequestMapping(value = "/product/{productId}/{productTitle}.html")
    public ModelAndView viewProduct(@PathVariable(value = "productId")Long productId, @PathVariable(value = "productTitle")String productTitle){
        ModelAndView mav = new ModelAndView("/web/product/view");

        return mav;
    }
}
