package com.banvien.portal.vms.webapp.controller.web;

import com.banvien.portal.vms.bean.SearchBean;
import com.banvien.portal.vms.domain.CategoryEntity;
import com.banvien.portal.vms.domain.ContentEntity;
import com.banvien.portal.vms.editor.CustomDateEditor;
import com.banvien.portal.vms.exception.ObjectNotFoundException;
import com.banvien.portal.vms.service.CategoryService;
import com.banvien.portal.vms.service.ContentService;
import com.banvien.portal.vms.util.Constants;
import com.banvien.portal.vms.util.RequestUtil;
import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.support.ApplicationObjectSupport;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import java.sql.Timestamp;
import java.util.*;

@Controller
public class SiteController extends ApplicationObjectSupport {

    @Autowired
    private ContentService contentService;

    @Autowired
    private CategoryService categoryService;

    @InitBinder
    public void initBinder(WebDataBinder binder) {
        binder.registerCustomEditor(Timestamp.class, new CustomDateEditor("dd/MM/yyyy"));
    }


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


    @RequestMapping("/search.html")
    public ModelAndView search(@ModelAttribute SearchBean bean, HttpServletRequest request){
        ModelAndView mav = new ModelAndView("web/search");
        String crudaction = bean.getCrudaction();
        if(StringUtils.isNotBlank(crudaction) && "search".equals(crudaction) && StringUtils.isNotEmpty(bean.getKeyword())){
            RequestUtil.initSearchBean(request, bean);
            Integer maxPageSize = 20;
            Integer currentPage = bean.getPageNumber();
            if(currentPage == null ){
                currentPage = 1;
            }
            Integer startRow = (currentPage - 1) * maxPageSize;

            Object[] objs = contentService.searchInSite(bean.getKeyword(), bean.getFromDate(), bean.getToDate(), startRow, maxPageSize, Constants.CONTENT_PUBLISH);

            bean.setListResult((List<ContentEntity>) objs[1]);

            Map<String, List<ContentEntity>> mapResult = new HashMap<String, List<ContentEntity>>();
            for(ContentEntity content : (List<ContentEntity>) objs[1]){
                String authoringTemplateName = content.getAuthoringTemplate().getName();
                if(mapResult.get(authoringTemplateName) == null){
                    List<ContentEntity> contents = new ArrayList<ContentEntity>();
                    contents.add(content);
                    mapResult.put(authoringTemplateName, contents);
                } else {
                    List<ContentEntity> contents = mapResult.get(authoringTemplateName);
                    contents.add(content);
                    mapResult.put(authoringTemplateName, contents);
                }
            }

            mav.addObject("mapResult", mapResult);

            Long totalItem = (Long) objs[0];

            getMaxPageNumber(currentPage, totalItem, maxPageSize, mav);
        }
        mav.addObject(Constants.FORM_MODEL_KEY, bean);
        return mav;
    }

    @RequestMapping("/sitemap.html")
    public ModelAndView siteMap(@ModelAttribute SearchBean bean, HttpServletRequest request){
        ModelAndView mav = new ModelAndView("web/sitemap");
        List<Long> listCategoryId = new ArrayList<Long>();
        List<CategoryEntity>  categoryResult = new ArrayList<CategoryEntity>();
        HashMap<Long, List<ContentEntity>> mapContentResult = new HashMap<Long, List<ContentEntity>>();

        List<CategoryEntity>  categoryObjects = categoryService.findAllCategoryParent();

        for(CategoryEntity category : categoryObjects){
            categoryResult.add(category);
            listCategoryId.add(category.getCategoryId());
            if(category.getChildren() != null && category.getChildren().size() > 0){
                for(CategoryEntity child: category.getChildren()){
                    categoryResult.add(child);
                    listCategoryId.add(child.getCategoryId());
                }
            }
        }

        List<ContentEntity> contentList = this.contentService.findByListCategory(listCategoryId, Constants.CONTENT_PUBLISH);

        for (ContentEntity content: contentList){
            Long categoryId = content.getCategory().getCategoryId();
            if(mapContentResult.get(categoryId) != null){
                mapContentResult.get(categoryId).add(content);
            } else {
                List<ContentEntity> contents = new ArrayList<ContentEntity>();
                contents.add(content);
                mapContentResult.put(categoryId, contents);
            }
        }
        mav.addObject("categoryResult", categoryResult);
        mav.addObject("mapContentResult", mapContentResult);
        mav.addObject("totalContent", contentList.size());
        return mav;
    }

}
