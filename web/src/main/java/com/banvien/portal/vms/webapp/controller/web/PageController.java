package com.banvien.portal.vms.webapp.controller.web;

import java.io.IOException;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.*;

import com.banvien.portal.vms.domain.*;
import com.banvien.portal.vms.dto.CategoryObjectDTO;
import com.banvien.portal.vms.service.*;
import com.banvien.portal.vms.taglibs.PortalTagLib;
import com.banvien.portal.vms.util.CategoryUtil;
import com.banvien.portal.vms.util.CommonUtil;
import org.apache.commons.lang.StringUtils;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.support.ApplicationObjectSupport;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.banvien.portal.vms.exception.ObjectNotFoundException;
import com.banvien.portal.vms.util.Constants;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Created by Ban Vien Ltd.
 * UserEntity: Vien Nguyen (vien.nguyen@banvien.com)
 * Date: 11/28/12
 * Time: 9:57 AM
 */
@Controller
public class PageController extends ApplicationObjectSupport {
    private transient final Logger logger = Logger.getLogger(getClass());

    @Autowired
    private ContentService contentService;

    @Autowired
    private CategoryService categoryService;

    @RequestMapping(value="/ajax/get-image-by-index-in-content.html")
    public ModelAndView getImage(@RequestParam(value="contentId", required=true) Long contentId,
                                 @RequestParam(value="index", required=true) int index,
                                 @RequestParam(value="number", required=true) int number,
                                      HttpServletRequest request, HttpServletResponse response) throws IOException{
        ModelAndView mav = new ModelAndView("/web/album/image");
        List<String> imageUrls = new ArrayList<String>();
        Boolean isEnd = true;
        try{
            ContentEntity contentEntity = contentService.findById(contentId);
            Map<String, List<String>> mapAttribute = PortalTagLib.parseContentXML(contentEntity.getXmlData());

            List<String> images = mapAttribute.get("imageUrls");
            if(images.size() >= (index + number)){
                isEnd = false;
            }
            for(int i = index; i < number + index; i++){
                if(images.size() > i){
                    imageUrls.add(images.get(i));
                }
            }
        }catch (ObjectNotFoundException e) {
            e.getMessage();
        }
        mav.addObject("imageUrls", imageUrls);
        mav.addObject("isEnd", isEnd);
        return mav;
    }

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
            title = convertUrlToCategoryCode(title);
            ContentEntity item = this.contentService.findEqualUnique("title", title);
            mav.addObject("item", item);
//            getRightMenuByCategoryRootID(mav, item.getCategory().getParentRootID(), item.getCategoryEntity().getCategoryID());
        }catch (ObjectNotFoundException e){
            mav = new ModelAndView("redirect:/404.html");
        }
        return mav;
    }

    // PEOPLE CONTROLLER
    @RequestMapping(value = "/persons/{parentCategory}/{categoryCode}.html")
    public ModelAndView viewPeopleInfo(@RequestParam(value = "page", required = false)Integer pageNumber,
                                       @PathVariable(value = "categoryCode")String categoryCode,
                                       @PathVariable(value = "parentCategory")String parentCategory){
        /* Authoring Template PERSON
        *      fullname
        *      role
        *      phonenumb
        *      email
        *      research <List title of research in content >
        *      about
        * */

        ModelAndView mav = new ModelAndView("/web/person/list");
        try{
            findByCategoryWithMaxItem(categoryCode, pageNumber, mav, 1);
        }catch (ObjectNotFoundException oe){
            mav = new ModelAndView("redirect:/404.html");
        }
        return  mav;
    }




    // NEWS CONTROLLER

    @RequestMapping(value = "/news/{parentCategory}/{categoryCode}.html")
    public ModelAndView viewNews(@RequestParam(value = "page", required = false)Integer pageNumber,
                                 @PathVariable(value = "categoryCode")String categoryCode,
                                 @PathVariable(value = "parentCategory")String parentCategory){
        /* Authoring Template  NEWS
        *      header
        *      content
        *      person <List person of research in content >
        * */
        ModelAndView mav = new ModelAndView("/web/news/list");
        try{
            findByCategoryWithMaxItem(categoryCode, pageNumber, mav, -1);
        }catch (ObjectNotFoundException oe){
            mav = new ModelAndView("redirect:/404.html");
        }
        return  mav;
    }



    private void findByCategoryWithMaxItem(String categoryCode, Integer pageNumber, ModelAndView mav, Integer oderByDisplayOrder) throws ObjectNotFoundException {
        Integer startRow;
        if(pageNumber == null){
            pageNumber = 1;
        }
        mav.addObject("pageNumber", pageNumber);
        startRow = (pageNumber - 1) * Constants.MAX_PAGE_ITEMS;

        if(StringUtils.isNotBlank(categoryCode)){
            Object [] obj = this.contentService.findByCategoryWithMaxItem(categoryCode, startRow, Constants.MAX_PAGE_ITEMS, CommonUtil.isEnglishLanguage(), oderByDisplayOrder, Constants.CONTENT_PUBLISH);
            List<ContentEntity> items = (List<ContentEntity>) obj[1];
            mav.addObject("items", items);
            Long totalItem = (Long) obj[0];
            Long maxPageNumber;
            if(totalItem % Constants.MAX_PAGE_ITEMS == 0){
                maxPageNumber = totalItem / Constants.MAX_PAGE_ITEMS;
            } else {
                maxPageNumber = (totalItem - (totalItem % Constants.MAX_PAGE_ITEMS))/Constants.MAX_PAGE_ITEMS + 1;
            }
            mav.addObject("maxPageNumber", maxPageNumber);
            CategoryEntity currentCategoryEntity = new CategoryEntity();

        }
    }

    private List<ContentEntity> getRelationNews(String category, Integer numberItem){
        Object [] obj = this.contentService.findByCategoryWithMaxItem(category, 0, numberItem, CommonUtil.isEnglishLanguage(), -1, Constants.CONTENT_PUBLISH);
        List<ContentEntity> result = (List<ContentEntity>) obj[1];
        return  result;
    }

    private void getRightMenuByCategoryRootID(ModelAndView mav, Long categoryRootID, Long currentCategoryId) throws ObjectNotFoundException { // Parent CategoryEntity Code, current CategoryEntity.
        if(categoryRootID == null || categoryRootID < 0){
            categoryRootID = currentCategoryId;
        }
        CategoryEntity categoryEntityObj =  categoryService.findById(categoryRootID);
        CategoryObjectDTO categoryObjectDTO = CategoryUtil.bindCategoryToCategoryObject(categoryEntityObj, 0, null);
        mav.addObject("categoryObj", categoryObjectDTO);

        if(categoryEntityObj.getChildren() != null && categoryEntityObj.getChildren().size() > 0){
            List<CategoryObjectDTO> categories = new ArrayList<CategoryObjectDTO>();
            categories = CategoryUtil.getListCategoryForBuildRightMenuForSite(categoryEntityObj.getChildren(), categories, 0, categoryObjectDTO);
            mav.addObject("categories", categories);

            for(CategoryObjectDTO categoryObjectDTO1 : categories){
                if(categoryObjectDTO1.getCategoryID().equals(currentCategoryId)){
                    mav.addObject("currentCategory", categoryObjectDTO1);
                }
            }
        }
    }

    private void findByCategoryTypeWithMaxItem(String categoryType, Integer pageNumber, ModelAndView mav, String categoryCode, String categorySearch) throws ObjectNotFoundException {
        Integer startRow;
        if(pageNumber == null){
            pageNumber = 1;
        }
        mav.addObject("pageNumber", pageNumber);
        startRow = (pageNumber - 1) * Constants.MAX_PAGE_ITEMS;

        if(StringUtils.isNotBlank(categoryType)){
            Object [] obj = this.contentService.findByCategoryTypeWithMaxItem(categoryType, startRow, Constants.MAX_PAGE_ITEMS, categorySearch, CommonUtil.isEnglishLanguage(), Constants.CONTENT_PUBLISH);
            List<ContentEntity> items = (List<ContentEntity>) obj[1];
            mav.addObject("items", items);
            Long totalItem = (Long) obj[0];
            Long maxPageNumber;
            if(totalItem % Constants.MAX_PAGE_ITEMS == 0){
                maxPageNumber = totalItem / Constants.MAX_PAGE_ITEMS;
            } else {
                maxPageNumber = (totalItem - (totalItem % Constants.MAX_PAGE_ITEMS))/Constants.MAX_PAGE_ITEMS + 1;
            }
            mav.addObject("maxPageNumber", maxPageNumber);

            try{
                CategoryEntity currentCategoryEntity = this.categoryService.findByCode(convertUrlToCategoryCode(categoryCode));
            }catch (ObjectNotFoundException oe){

            }
        }
    }

    private String convertUrlToCategoryCode(String categoryUrl){
        return categoryUrl.replaceAll("-", " ");
    }

    private HashMap<String, ContentEntity> getMapContentByTitle(List<ContentEntity> contentEntities){
        HashMap<String, ContentEntity> mapContent = new HashMap<String, ContentEntity>();
        for(ContentEntity contentEntity : contentEntities){
            mapContent.put(contentEntity.getTitle().toLowerCase(), contentEntity);
        }
        return mapContent;
    }

    private boolean compareToDate(java.util.Date date1, java.sql.Date date2) throws ParseException {
        SimpleDateFormat dt = new SimpleDateFormat("dd-MM-yyyy");
        DateFormat df = new SimpleDateFormat("dd-MM-yyyy");

        date1 = dt.parse(df.format(date1));
        long milliseconds1 = date1.getTime();
        long milliseconds2 = date2.getTime();
        if(milliseconds1 >= milliseconds2){
            return true;
        } else {
            return false;
        }
    }

}
