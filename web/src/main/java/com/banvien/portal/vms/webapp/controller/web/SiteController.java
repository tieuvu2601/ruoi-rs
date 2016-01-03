package com.banvien.portal.vms.webapp.controller.web;

import com.banvien.portal.vms.domain.CategoryEntity;
import com.banvien.portal.vms.domain.ContentEntity;
import com.banvien.portal.vms.exception.ObjectNotFoundException;
import com.banvien.portal.vms.service.CategoryService;
import com.banvien.portal.vms.service.ContentService;
import com.banvien.portal.vms.util.Constants;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.support.ApplicationObjectSupport;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

@Controller
public class SiteController extends ApplicationObjectSupport {

    @Autowired
    private ContentService contentService;

    @Autowired
    private CategoryService categoryService;


    @RequestMapping(value = "/products/{categoryCode}.html")
    public ModelAndView viewProducts(@RequestParam(value = "pg", required = false)Integer currentPage,
                                     @PathVariable(value = "categoryCode")String categoryCode){
        ModelAndView mav = new ModelAndView("/web/product/list");
        categoryCode = categoryCode.replaceAll("-", " ");
        Integer maxPageSize = 10;
        if(currentPage == null){
            currentPage = 1;
        }
        Integer startRow = (currentPage - 1) * maxPageSize;
        Object [] objs = this.contentService.findByCategoryWithPage(categoryCode, startRow , maxPageSize, Constants.CONTENT_PUBLISH);
        List<ContentEntity> contents = (List<ContentEntity> ) objs[0];
        Long totalItem = (Long) objs [1];

        getMaxPageNumber(currentPage, totalItem, maxPageSize, mav);

        if(contents != null && contents.size() > 0){
            mav.addObject("category", contents.get(0).getCategory());
        } else {
            try{
                CategoryEntity category = this.categoryService.findByCode(categoryCode);
                mav.addObject("category", category);
            }catch (ObjectNotFoundException oe){

            }
        }
        mav.addObject(Constants.LIST_MODEL_KEY, contents);
        return mav;
    }

    @RequestMapping(value = "/products/{productId}/{productTitle}.html")
    public ModelAndView viewProduct(@PathVariable(value = "productId")Long productId, @PathVariable(value = "productTitle")String productTitle){
        ModelAndView mav = new ModelAndView("/web/product/view");
        try{
            ContentEntity dbItem = this.contentService.findById(productId);
            mav.addObject(Constants.FORM_MODEL_KEY, dbItem);
            mav.addObject("category", dbItem.getCategory());
            getRelationProduct(dbItem, mav);
        } catch (Exception e){

        }
        return mav;
    }

    @RequestMapping(value = "/news/{categoryCode}.html")
    public ModelAndView viewNews(@RequestParam(value = "pg", required = false)Integer currentPage){
        ModelAndView mav = new ModelAndView("/web/news/list");
        Integer maxPageSize = 20;
        if(currentPage == null){
            currentPage = 1;
        }
        Integer startRow = (currentPage - 1) * maxPageSize;
        Object [] objs = this.contentService.findByCategoryWithPage(Constants.CATEGORY_RECENT_NEWS, startRow , maxPageSize, Constants.CONTENT_PUBLISH);
        List<ContentEntity> listResult = (List<ContentEntity> ) objs[0];
        Long totalItem = (Long) objs [1];

        getMaxPageNumber(currentPage, totalItem, maxPageSize, mav);

        if(listResult != null && listResult.size() > 0){
            mav.addObject("category", listResult.get(0).getCategory());
        } else {
            try{
                CategoryEntity category = this.categoryService.findByCode(Constants.CATEGORY_RECENT_NEWS);
                mav.addObject("category", category);
            } catch (ObjectNotFoundException oe){

            }
        }
        mav.addObject(Constants.LIST_MODEL_KEY, listResult);
        return mav;
    }

    private void getMaxPageNumber(Integer currentPage, Long totalItem, Integer maxPageSize, ModelAndView mav){
        mav.addObject("pageNumber", currentPage);
        Long maxPageNumber;
        if(totalItem % maxPageSize == 0){
            maxPageNumber = totalItem / maxPageSize;
        } else {
            maxPageNumber = (totalItem - (totalItem % maxPageSize))/maxPageSize + 1;
        }
        mav.addObject("maxPageNumber", maxPageNumber);
    }

    @RequestMapping(value = "/news/{newId}/{newTitle}.html")
    public ModelAndView viewNew(@PathVariable(value = "newId")Long newId, @PathVariable(value = "newTitle")String newTitle){
        ModelAndView mav = new ModelAndView("/web/news/view");
        try{
            ContentEntity dbItem = this.contentService.findById(newId);
            mav.addObject(Constants.FORM_MODEL_KEY, dbItem);
            mav.addObject("category", dbItem.getCategory());

        } catch (Exception e){

        }
        return mav;
    }

    @RequestMapping(value = "/page/{pageTitle}.html")
    public ModelAndView viewPage(@PathVariable(value = "pageTitle")String pageTitle){
        ModelAndView mav = new ModelAndView("/web/page/view");
        try{
            pageTitle = pageTitle.replaceAll("-", " ");
            ContentEntity dbItem = this.contentService.findByTitle(pageTitle, Constants.CONTENT_PUBLISH);
            mav.addObject(Constants.FORM_MODEL_KEY, dbItem);
            mav.addObject("category", dbItem.getCategory());

        } catch (Exception e){

        }
        return mav;
    }


    private void getRelationProduct(ContentEntity content, ModelAndView mav){
        mav.addObject("relativeProducts", "relativeProducts");
    }

}
