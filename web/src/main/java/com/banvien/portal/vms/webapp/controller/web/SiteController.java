package com.banvien.portal.vms.webapp.controller.web;

import com.banvien.portal.vms.domain.ContentEntity;
import com.banvien.portal.vms.service.ContentService;
import com.banvien.portal.vms.util.Constants;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.support.ApplicationObjectSupport;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import java.util.List;

@Controller
public class SiteController extends ApplicationObjectSupport {

    @Autowired
    private ContentService contentService;


    @RequestMapping(value = "/products/{categoryCode}.html")
    public ModelAndView viewProducts(@PathVariable(value = "categoryCode")String categoryCode){
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

    @RequestMapping(value = "/products/{productId}/{productTitle}.html")
    public ModelAndView viewProduct(@PathVariable(value = "productId")Long productId, @PathVariable(value = "productTitle")String productTitle){
        ModelAndView mav = new ModelAndView("/web/product/view");
        try{
            ContentEntity dbItem = this.contentService.findById(productId);
            mav.addObject(Constants.FORM_MODEL_KEY, dbItem);
            getRelationProduct(dbItem, mav);
        } catch (Exception e){

        }
        getRecentNews(mav);

        return mav;
    }

    private void getRelationProduct(ContentEntity content, ModelAndView mav){
        mav.addObject("relativeProducts", "relativeProducts");
    }

    private void getRecentNews(ModelAndView mav){
        List<ContentEntity> recentNews = this.contentService.findByCategory(Constants.CATEGORY_RECENT_NEWS, 0, 6, Constants.CONTENT_PUBLISH);
        mav.addObject("recentNews", recentNews);

    }

    @RequestMapping(value = "/news/{categoryCode}.html")
    public ModelAndView viewNews(){
        ModelAndView mav = new ModelAndView("/web/news/list");

        return mav;
    }

    @RequestMapping(value = "/news/{newId}/{newTitle}.html")
    public ModelAndView viewNew(@PathVariable(value = "newId")Long newId, @PathVariable(value = "newTitle")String newTitle){
        ModelAndView mav = new ModelAndView("/web/news/view");

        return mav;
    }
}
