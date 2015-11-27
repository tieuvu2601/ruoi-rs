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
 * User: Vien Nguyen (vien.nguyen@banvien.com)
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
            Content content = contentService.findById(contentId);
            Map<String, List<String>> mapAttribute = PortalTagLib.parseContentXML(content.getXmlData());

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
            Content item = this.contentService.findEqualUnique("title", title);
            mav.addObject("item", item);
            getRightMenuByCategoryRootID(mav, item.getCategory().getParentRootID(), item.getCategory().getCategoryID());
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

    // PEOPLE CONTROLLER
    @RequestMapping(value = "/person/{parentCategory}/{title}.html")
    public ModelAndView viewSinglePeopleInfo(@PathVariable(value = "title")String title,
                                       @PathVariable(value = "parentCategory")String parentCategory){
        /* Authoring Template PERSON
        *      fullname
        *      role
        *      phonenumb
        *      email
        *      research <List title of research in content >
        *      about
        * */

        ModelAndView mav = new ModelAndView("/web/person/view");
        try{
            title = convertUrlToCategoryCode(title);
            Content item = this.contentService.findEqualUnique("title", title);
            mav.addObject("item", item);
            getRightMenuByCategoryRootID(mav, item.getCategory().getParentRootID(), item.getCategory().getCategoryID());
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

    @RequestMapping(value = "/new/{parentCategory}/{title}.html")
    public ModelAndView viewSingleNew(@PathVariable(value = "title")String title,
                                 @PathVariable(value = "parentCategory")String parentCategory){

        ModelAndView mav = new ModelAndView("/web/news/view");
        try{
            title = convertUrlToCategoryCode(title);
            Content item = this.contentService.findEqualUnique("title", title);
            mav.addObject("item", item);
            getRightMenuByCategoryRootID(mav, item.getCategory().getParentRootID(), item.getCategory().getCategoryID());

            List<Content> relations = getRelationNews(item.getCategory().getCode(), 6);
            mav.addObject("relations", relations);

        }catch (ObjectNotFoundException oe){
            mav = new ModelAndView("redirect:/404.html");
        }
        return  mav;
    }

    @RequestMapping(value = "/actions/{parentCategory}/{categoryCode}.html")
    public ModelAndView viewActions(@RequestParam(value = "page", required = false)Integer pageNumber,
                                 @PathVariable(value = "categoryCode")String categoryCode,
                                 @PathVariable(value = "parentCategory")String parentCategory){
        /* Authoring Template  NEWS
        *      header
        *      content
        *      person <List person of research in content >
        * */
        ModelAndView mav = new ModelAndView("/web/action/list");
        try{
            findByCategoryWithMaxItem(categoryCode, pageNumber, mav, -1);
        }catch (ObjectNotFoundException oe){
            mav = new ModelAndView("redirect:/404.html");
        }
        return  mav;
    }

    @RequestMapping(value = "/action/{parentCategory}/{title}.html")
    public ModelAndView viewSingleAction(@PathVariable(value = "title")String title,
                                      @PathVariable(value = "parentCategory")String parentCategory){

        ModelAndView mav = new ModelAndView("/web/action/view");
        try{
            title = convertUrlToCategoryCode(title);
            Content item = this.contentService.findEqualUnique("title", title);
            mav.addObject("item", item);
            getRightMenuByCategoryRootID(mav, item.getCategory().getParentRootID(), item.getCategory().getCategoryID());

            List<Content> relations = getRelationNews(item.getCategory().getCode(), 6);
            mav.addObject("relations", relations);

        }catch (ObjectNotFoundException oe){
            mav = new ModelAndView("redirect:/404.html");
        }
        return  mav;
    }


    // EVENT CONTROLLER
    @RequestMapping(value = "/upcoming/{parentCategory}/{categoryCode}.html")
    public ModelAndView viewUpComingEvents(@RequestParam(value = "page", required = false)Integer pageNumber,
                                   @PathVariable(value = "parentCategory")String parentCategory,
                                   @PathVariable(value = "categoryCode")String categoryCode) throws ObjectNotFoundException {
        /* Authoring Template   EVENTS
        beginTime
        endTime
        location
        header
        description
        content
        Category(events) English
        * */

        ModelAndView mav = new ModelAndView("/web/event/list");
        try{
            String eventsType = Constants.UP_COMING_EVENT;
            findByCategoryTypeWithMaxItem(eventsType, pageNumber, mav, categoryCode, Constants.EVENTS_CATEGORY_CODE);
        }catch (ObjectNotFoundException oe){
            mav = new ModelAndView("redirect:/404.html");
        }
        return  mav;
    }

    @RequestMapping(value = "/past/{parentCategory}/{categoryCode}.html")
    public ModelAndView viewPassEvents(@RequestParam(value = "page", required = false)Integer pageNumber,
                                      @PathVariable(value = "parentCategory")String parentCategory,
                                      @PathVariable(value = "categoryCode")String categoryCode) throws ObjectNotFoundException {
        /* Authoring Template   EVENTS
        beginTime
        endTime
        location
        header
        description
        content
        Category(events)
        * */

        ModelAndView mav = new ModelAndView("/web/event/list");
        try{
            String eventsType = Constants.PAST_EVENT;
            findByCategoryTypeWithMaxItem(eventsType, pageNumber, mav, categoryCode, Constants.EVENTS_CATEGORY_CODE);
        }catch (ObjectNotFoundException oe){
            mav = new ModelAndView("redirect:/404.html");
        }
        return  mav;
    }

    @RequestMapping(value = "/event/{parentCategory}/{title}.html")
    public ModelAndView viewEvents(@PathVariable(value = "parentCategory")String parentCategory,
                                   @PathVariable(value = "title")String title) throws ObjectNotFoundException {
        /* Authoring Template
        *     beginTime
        endTime
        location
        header
        description
        content
        * */
        ModelAndView mav = new ModelAndView("/web/event/view");
        try{
            title = convertUrlToCategoryCode(title);
            Content item = this.contentService.findEqualUnique("title", title);
            mav.addObject("item", item);
            java.util.Date toDate = new java.util.Date(System.currentTimeMillis());
            String currentCategory = "upcoming events";
            if(compareToDate(toDate, item.getBeginDate())){
                currentCategory = "past events";
            }
            Category currentCat = categoryService.findByCode(currentCategory);
            getRightMenuByCategoryRootID(mav, currentCat.getParentRootID(), currentCat.getCategoryID());

            String eventsType = Constants.UP_COMING_EVENT;

            Object [] obj = this.contentService.findByCategoryTypeWithMaxItem(eventsType, 0, 6, item.getCategory().getCode(), CommonUtil.isEnglishLanguage(), Constants.CONTENT_PUBLISH);
            List<Content> eventRelations = (List<Content>) obj[1];
            mav.addObject("eventRelations" , eventRelations);

        }catch (ObjectNotFoundException e){
            mav = new ModelAndView("redirect:/404.html");
        } catch (ParseException e) {
            mav = new ModelAndView("redirect:/404.html");
        }
        return mav;
    }

    // JOB RESOURCES CONTROLLER
    @RequestMapping(value = "/jobs/{parentCategory}/{categoryCode}.html")
    public ModelAndView viewJobsResource(@RequestParam(value = "page", required = false)Integer pageNumber,
                                         @PathVariable(value = "parentCategory")String parentCategory,
                                         @PathVariable(value = "categoryCode")String categoryCode){
        /* Authoring Template   EVENTS
        header
        description
        content
        company
        location
        salary
        position
        jobType
        applicationForm

        Category code : jobs resource
        prefixUrl     :  jobs
        * */

        ModelAndView mav = new ModelAndView("/web/job/list");
        try{
            findByCategoryWithMaxItem(categoryCode, pageNumber, mav, -1);
        }catch (ObjectNotFoundException oe){
            mav = new ModelAndView("redirect:/404.html");
        }
        return  mav;
    }

    @RequestMapping(value = "/job/{parentCategory}/{title}.html")
    public ModelAndView viewJob(@PathVariable(value = "parentCategory")String parentCategory,
                                   @PathVariable(value = "title")String title) throws ObjectNotFoundException {
        ModelAndView mav = new ModelAndView("/web/job/view");
        try{
            title = convertUrlToCategoryCode(title);
            Content item = this.contentService.findEqualUnique("title", title);
            mav.addObject("item", item);
            getRightMenuByCategoryRootID(mav, item.getCategory().getParentRootID(), item.getCategory().getCategoryID());

            List<Content> relations = getRelationNews(item.getCategory().getCode(), 6);
            mav.addObject("relations", relations);

        }catch (ObjectNotFoundException oe){
            mav = new ModelAndView("redirect:/404.html");
        }
        return mav;
    }


    // RESEARCH PROJECT CONTROLLER
    @RequestMapping(value = "/researches/{parentCategory}/{categoryCode}.html")
    public ModelAndView viewResearches(@RequestParam(value = "page", required = false)Integer pageNumber,
                                       @PathVariable(value = "categoryCode")String categoryCode,
                                       @PathVariable(value = "parentCategory")String parentCategory){
        /* Authoring Template RESEARCH PROJECT

        *      header
        *      description
        *      content
        *      researchgroup <List research group>
        *      product <List product of research in content >
        *     Category
        * */

        ModelAndView mav = new ModelAndView("/web/researchproject/list");
        try{
            findByCategoryWithMaxItem(categoryCode, pageNumber, mav, 1);
        }catch (ObjectNotFoundException oe){
            mav = new ModelAndView("redirect:/404.html");
        }
        return mav;
    }

    @RequestMapping(value = "/research/{parentCategory}/{title}.html")
    public ModelAndView viewResearchProjectInfo(@PathVariable(value = "title")String title,
                                                @PathVariable(value = "parentCategory")String parentCategory){

        ModelAndView mav = new ModelAndView("/web/researchproject/view");
        try{
            title = convertUrlToCategoryCode(title);
            Content item = this.contentService.findEqualUnique("title", title);

            Category currentCategory =  item.getCategory();
            mav.addObject("item", item);
            Map<String, List<String>> mapAttribute = PortalTagLib.parseContentXML(item.getXmlData());

            if(mapAttribute.get("researchgroup") != null && mapAttribute.get("researchgroup").size() > 0){
                List<Content> researchGroups = this.contentService.findByListTitle(mapAttribute.get("researchgroup"), Constants.CONTENT_PUBLISH);
                mav.addObject("researchGroups", researchGroups);
            }

            if(mapAttribute.get("products") != null && mapAttribute.get("products").size() > 0){
                List<Content> products = this.contentService.findByListTitle(mapAttribute.get("products"), Constants.CONTENT_PUBLISH);
                mav.addObject("products", products);
            }

            getRightMenuByCategoryRootID(mav, currentCategory.getParentRootID(), currentCategory.getCategoryID());
            mav.addObject("researchGroupPrefixUrl", Constants.RESEARCH_GROUP_PREFIX_URL);
        }catch (ObjectNotFoundException oe){
            mav = new ModelAndView("redirect:/404.html");
        }
        return  mav;
    }

    // RESEARCH GROUP CONTROLLER
    @RequestMapping(value = "/research-groups/{parentCategory}/{categoryCode}.html")
    public ModelAndView viewResearchGroup(@RequestParam(value = "page", required = false)Integer pageNumber,
                                       @PathVariable(value = "categoryCode")String categoryCode,
                                       @PathVariable(value = "parentCategory")String parentCategory){
         /* Authoring Template  RESEARCH GROUP
        *      header
        *      introduce
        *      content
        *      List<Research Project> researchProjects
        *      List<Gallery> galleryImages
        *      List<Person> members;
        * */

        ModelAndView mav = new ModelAndView("/web/researchgroup/list");

        try{
            findByCategoryWithMaxItem(categoryCode, pageNumber, mav, 1);
            // FIND ALL Research Produect
            List<Content> listResearchProject = this.contentService.findByPrefixUrl(Constants.RESEARCH_PROJECTS_PREFIX_URL, 0, -1, CommonUtil.isEnglishLanguage(), Constants.CONTENT_PUBLISH);
            HashMap<String, Content> researchProjects = getMapContentByTitle(listResearchProject);
            mav.addObject("researchProjects", researchProjects);
        }catch (ObjectNotFoundException oe){
            mav = new ModelAndView("redirect:/404.html");
        }
        return mav;
    }

    @RequestMapping(value = "/research-group/{categoryCode}/{title}.html")
    public ModelAndView viewResearchGroupDetail(@PathVariable(value = "title")String title,
                                                @PathVariable(value = "categoryCode")String categoryCode){
         /* Authoring Template  RESEARCH GROUP
        *      header
        *      introduce
        *      content
        *      List<Research Project> researchProjects
        *      List<Gallery> galleryImages
        *      List<Person> members;
        * */
        ModelAndView mav = new ModelAndView("/web/researchgroup/view");
        try{
            title = convertUrlToCategoryCode(title);
            Content item = this.contentService.findEqualUnique("title", title);
            mav.addObject("item", item);
            HashMap<String, Content> researchProjects = getMapContentByTitle(this.contentService.findByPrefixUrl(Constants.RESEARCH_PROJECTS_PREFIX_URL, 0, -1, CommonUtil.isEnglishLanguage(), Constants.CONTENT_PUBLISH));
            mav.addObject("researchProjects", researchProjects);

            HashMap<String, Content> members = getMapContentByTitle(this.contentService.findByAuthoringPrefixUrl(Constants.PERSON_AUTHORING_PREFIX_URL, 0, -1, CommonUtil.isEnglishLanguage(), Constants.CONTENT_PUBLISH));
            mav.addObject("members", members);

            mav.addObject("productPrefixUrl", Constants.PRODUCT_PREFIX_URL);

            getRightMenuByCategoryRootID(mav, item.getCategory().getParentRootID(), item.getCategory().getCategoryID());
        }catch (ObjectNotFoundException e){
            mav = new ModelAndView("redirect:/404.html");
        }
        return mav;
    }

    // PRODUCT OF RESEARCH PROJECT CONTROLLER

    @RequestMapping(value = "/product/{categoryCode}/{title}.html")
    public ModelAndView viewProduct(@PathVariable(value = "title")String title, @PathVariable(value = "categoryCode")String categoryCode){
        /* Authoring Template  STATIC HTML
        *      header
        *      introduce
        *      content
        *      List<Gallery> galleryImages
        *
        * */
        ModelAndView mav = new ModelAndView("/web/product/view");
        try{
            title = convertUrlToCategoryCode(title);
            Content item = this.contentService.findEqualUnique("title", title);
            mav.addObject("item", item);
            getRightMenuByCategoryRootID(mav, item.getCategory().getParentRootID(), item.getCategory().getCategoryID());
        }catch (ObjectNotFoundException e){
            mav = new ModelAndView("redirect:/404.html");
        }
        return mav;
    }

    // RESEARCH COLLABORATION CONTROLLER
    @RequestMapping(value = "/collaborations/{parentCategory}/{categoryCode}.html")
    public ModelAndView viewCollaborationResearch(@RequestParam(value = "page", required = false)Integer pageNumber,
                                       @PathVariable(value = "categoryCode")String categoryCode,
                                       @PathVariable(value = "parentCategory")String parentCategory){
          /* Authoring Template  COLLABORATION RESEARCH
        *      header
        *      description
        *      introduce
        *      content
        *      about
        * */

        ModelAndView mav = new ModelAndView("/web/collaboration/list");
        try{
            categoryCode = convertUrlToCategoryCode(categoryCode);
            findByCategoryWithMaxItem(categoryCode, pageNumber, mav, -1);
            mav.addObject("prefixUrl", Constants.COLLABORATION_PREFIX_URL);
        }catch (ObjectNotFoundException oe){
            mav = new ModelAndView("redirect:/404.html");
        }
        return mav;
    }

    @RequestMapping(value = "/collaboration/{parentCategory}/{title}.html")
    public ModelAndView viewSingleCollaboration(@PathVariable(value = "title")String title,
                                                  @PathVariable(value = "parentCategory")String parentCategory){
          /* Authoring Template  COLLABORATION RESEARCH
        *      header
        *      description
        *      introduce
        *      content
        *      about
        * */

        ModelAndView mav = new ModelAndView("/web/collaboration/view");
        try{
            title = convertUrlToCategoryCode(title);
            Content item = this.contentService.findEqualUnique("title", title);
            mav.addObject("item", item);
            getRightMenuByCategoryRootID(mav, item.getCategory().getParentRootID(), item.getCategory().getCategoryID());
        }catch (ObjectNotFoundException oe){
            mav = new ModelAndView("redirect:/404.html");
        }
        return mav;
    }




    @RequestMapping(value = "/experts/{parentCategory}/{categoryCode}.html")
    public ModelAndView viewExpertsCorner(@RequestParam(value = "page", required = false)Integer pageNumber,
                                                  @PathVariable(value = "categoryCode")String categoryCode,
                                                  @PathVariable(value = "parentCategory")String parentCategory){
          /* Authoring Template  experts-corner
        *      header
        *      description
        *      content
        *      youTubeUrls
        *
        * */

        ModelAndView mav = new ModelAndView("/web/expertscorner/list");
        try{
            categoryCode = convertUrlToCategoryCode(categoryCode);
            findByCategoryWithMaxItem(categoryCode, pageNumber, mav, -1);
        }catch (ObjectNotFoundException oe){
            mav = new ModelAndView("redirect:/404.html");
        }
        return mav;
    }

    @RequestMapping(value = "/expert/{parentCategory}/{title}.html")
    public ModelAndView viewSingleExpertsCorner(@PathVariable(value = "title")String title,
                                                @PathVariable(value = "parentCategory")String parentCategory){

        ModelAndView mav = new ModelAndView("/web/expertscorner/view");
        try{
            title = convertUrlToCategoryCode(title);
            Content item = this.contentService.findEqualUnique("title", title);
            mav.addObject("item", item);
            getRightMenuByCategoryRootID(mav, item.getCategory().getParentRootID(), item.getCategory().getCategoryID());
        }catch (ObjectNotFoundException oe){
            mav = new ModelAndView("redirect:/404.html");
        }
        return mav;
    }

    // ALBUM CONTROLLER
    @RequestMapping(value = "/gallery/{category}/{categoryCode}.html")
    public ModelAndView viewGallery(@RequestParam(value = "page", required = false)Integer pageNumber,
                                    @PathVariable(value = "category")String parentCategory,
                                    @PathVariable(value = "categoryCode")String categoryCode) throws ObjectNotFoundException {
        /* Authoring Template GALLERY
        *      title
        *      description
        *      imageUrls
        * */
        ModelAndView mav = new ModelAndView("/web/album/list");
        categoryCode = convertUrlToCategoryCode(categoryCode);
        List<Content> items = this.contentService.findByCategory(categoryCode, 0, -1, CommonUtil.isEnglishLanguage(), Constants.CONTENT_PUBLISH);
        mav.addObject("items", items);

        try{
            Category category = this.categoryService.findByCode(categoryCode);
            CategoryObjectDTO categoryObj = CategoryUtil.bindCategoryToCategoryObject(category.getParentCategory(), 0, null);
            CategoryObjectDTO currentCategory = CategoryUtil.bindCategoryToCategoryObject(category, 0, categoryObj);
            mav.addObject("categoryObj", categoryObj);
            mav.addObject("currentCategory", currentCategory);

        }catch (ObjectNotFoundException oe){
            mav = new ModelAndView("redirect:/404.html");
        }
        return  mav;
    }

    @RequestMapping(value = "/album/{categoryCode}/{title}.html")
    public ModelAndView viewAlbum(@PathVariable(value = "title")String title,
                                  @PathVariable(value = "categoryCode")String categoryCode){
        /* Authoring Template  ALBUM
        *      title
        *      description
        *      imagesUrl <List person of research in content >
        *      imagesAtt <List person of research in content >
        * */
        ModelAndView mav = new ModelAndView("/web/album/view");
        try{
            title = convertUrlToCategoryCode(title);
            Content item = this.contentService.findEqualUnique("title", title);
            mav.addObject("item", item);
            Map<String, List<String>> mapAttribute = PortalTagLib.parseContentXML(item.getXmlData());
            List<String> imageUrls = new ArrayList<String>();
            List<String> images = mapAttribute.get("imageUrls");
            for(int i = 0; i < 8; i++){
                if(i < images.size() && images.get(i) != null){
                    imageUrls.add(images.get(i));
                }
            }
            mav.addObject("imageUrls", imageUrls);
            getRightMenuByCategoryRootID(mav, item.getCategory().getParentRootID(), item.getCategory().getCategoryID());
        }catch (ObjectNotFoundException e){
            mav = new ModelAndView("redirect:/404.html");
        }
        return mav;
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
            List<Content> items = (List<Content>) obj[1];
            mav.addObject("items", items);
            Long totalItem = (Long) obj[0];
            Long maxPageNumber;
            if(totalItem % Constants.MAX_PAGE_ITEMS == 0){
                maxPageNumber = totalItem / Constants.MAX_PAGE_ITEMS;
            } else {
                maxPageNumber = (totalItem - (totalItem % Constants.MAX_PAGE_ITEMS))/Constants.MAX_PAGE_ITEMS + 1;
            }
            mav.addObject("maxPageNumber", maxPageNumber);
            Category currentCategory = new Category();
            if(items != null && items.size() > 0){
                currentCategory = items.get(0).getCategory();
                getRightMenuByCategoryRootID(mav, currentCategory.getParentRootID(), currentCategory.getCategoryID());
            } else {
                currentCategory = this.categoryService.findByCode(categoryCode);
                if(currentCategory != null){
                    getRightMenuByCategoryRootID(mav, currentCategory.getParentRootID(), currentCategory.getCategoryID());
                }
            }
        }
    }

    private List<Content> getRelationNews(String category, Integer numberItem){
        Object [] obj = this.contentService.findByCategoryWithMaxItem(category, 0, numberItem, CommonUtil.isEnglishLanguage(), -1, Constants.CONTENT_PUBLISH);
        List<Content> result = (List<Content>) obj[1];
        return  result;
    }

    private void getRightMenuByCategoryRootID(ModelAndView mav, Long categoryRootID, Long currentCategoryId) throws ObjectNotFoundException { // Parent Category Code, current Category.
        if(categoryRootID == null || categoryRootID < 0){
            categoryRootID = currentCategoryId;
        }
        Category categoryObj =  categoryService.findById(categoryRootID);
        CategoryObjectDTO categoryObjectDTO = CategoryUtil.bindCategoryToCategoryObject(categoryObj, 0, null);
        mav.addObject("categoryObj", categoryObjectDTO);

        if(categoryObj.getChildren() != null && categoryObj.getChildren().size() > 0){
            List<CategoryObjectDTO> categories = new ArrayList<CategoryObjectDTO>();
            categories = CategoryUtil.getListCategoryForBuildRightMenuForSite(categoryObj.getChildren(), categories, 0, categoryObjectDTO);
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
            List<Content> items = (List<Content>) obj[1];
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
                Category currentCategory = this.categoryService.findByCode(convertUrlToCategoryCode(categoryCode));
                getRightMenuByCategoryRootID(mav, currentCategory.getParentRootID(), currentCategory.getCategoryID());
            }catch (ObjectNotFoundException oe){

            }
        }
    }

    private String convertUrlToCategoryCode(String categoryUrl){
        return categoryUrl.replaceAll("-", " ");
    }

    private HashMap<String, Content> getMapContentByTitle(List<Content> contents){
        HashMap<String, Content> mapContent = new HashMap<String, Content>();
        for(Content content: contents){
            mapContent.put(content.getTitle().toLowerCase(), content);
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
