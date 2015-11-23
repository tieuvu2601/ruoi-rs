package com.banvien.portal.vms.webapp.controller.admin;

import java.io.PrintWriter;
import java.sql.Date;
import java.sql.Timestamp;
import java.util.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.banvien.portal.vms.dto.CategoryDTO;
import com.banvien.portal.vms.util.CategoryUtil;
import org.apache.commons.lang.StringUtils;
import org.apache.log4j.Logger;
import org.json.JSONArray;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.support.ApplicationObjectSupport;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.banvien.portal.vms.bean.CategoryBean;
import com.banvien.portal.vms.domain.AuthoringTemplate;
import com.banvien.portal.vms.domain.Category;
import com.banvien.portal.vms.domain.CategoryShowAll;
import com.banvien.portal.vms.domain.CategoryUser;
import com.banvien.portal.vms.domain.CategoryUserGroup;
import com.banvien.portal.vms.domain.RenderingTemplate;
import com.banvien.portal.vms.domain.User;
import com.banvien.portal.vms.domain.UserGroup;
import com.banvien.portal.vms.editor.CustomDateEditor;
import com.banvien.portal.vms.editor.PojoEditor;
import com.banvien.portal.vms.exception.ObjectNotFoundException;
import com.banvien.portal.vms.service.AuthoringTemplateService;
import com.banvien.portal.vms.service.CategoryService;
import com.banvien.portal.vms.service.CategoryShowAllService;
import com.banvien.portal.vms.service.CategoryUserGroupService;
import com.banvien.portal.vms.service.CategoryUserService;
import com.banvien.portal.vms.service.RenderingTemplateService;
import com.banvien.portal.vms.service.UserGroupService;
import com.banvien.portal.vms.service.UserService;
import com.banvien.portal.vms.util.Constants;
import com.banvien.portal.vms.util.RequestUtil;
import com.banvien.portal.vms.webapp.validator.CategoryValidator;

/**
 * Created with IntelliJ IDEA.
 * User: NhuKhang
 * Date: 10/6/12
 * Time: 10:57 AM
 */
@Controller
public class CategoryController extends ApplicationObjectSupport {
	private transient final Logger logger = Logger.getLogger(getClass());

    @Autowired
    private CategoryService categoryService;

    @Autowired
    private CategoryValidator categoryValidator;

    @Autowired
    private RenderingTemplateService renderingTemplateService;

    @Autowired
    private AuthoringTemplateService authoringTemplateService;
    
    @Autowired
    private CategoryUserService categoryUserService;
    
    @Autowired
    private CategoryUserGroupService categoryUserGroupService;
    
    @Autowired
    private CategoryShowAllService categoryShowAllService;
    
    @Autowired
    private UserService userService;
    
    @Autowired
    private UserGroupService userGroupService;

    @InitBinder
    public void initBinder(WebDataBinder binder) {
    	binder.registerCustomEditor(Date.class, new CustomDateEditor());
        binder.registerCustomEditor(RenderingTemplate.class, new PojoEditor(RenderingTemplate.class, "renderingTemplateID", Long.class));
        binder.registerCustomEditor(AuthoringTemplate.class, new PojoEditor(AuthoringTemplate.class, "authoringTemplateID", Long.class));
	}

    @RequestMapping("/admin/category/edit.html")
    public ModelAndView edit(@ModelAttribute(Constants.FORM_MODEL_KEY) CategoryBean bean, BindingResult bindingResult){
        ModelAndView mav = new ModelAndView("/admin/category/edit");
        String crudaction = bean.getCrudaction();
        Category pojo = bean.getPojo();
        if(StringUtils.isNotBlank(crudaction) && crudaction.equals("insert-update")) {
            try{
                categoryValidator.validate(bean, bindingResult);
                if(!bindingResult.hasErrors()){
                    if(pojo.getCategoryID() != null && pojo.getCategoryID() >0 ){
                        pojo.setModifiedDate(new Timestamp(System.currentTimeMillis()));
                        pojo = this.categoryService.updateItem(pojo);
                        mav.addObject("messageResponse", this.getMessageSourceAccessor().getMessage("database.update.successful"));
                    }else{
                        pojo.setCreatedDate(new Timestamp(System.currentTimeMillis()));
                        pojo.setModifiedDate(new Timestamp(System.currentTimeMillis()));
                        pojo = this.categoryService.save(pojo);
                        if(pojo.getParentRootID() == null || pojo.getParentRootID() < 0){
                            pojo.setParentRootID(pojo.getCategoryID());
                            pojo = this.categoryService.updateItem(pojo);
                        }
                        mav.addObject("messageResponse", this.getMessageSourceAccessor().getMessage("database.add.successful"));
                    }
                    bean.setPojo(pojo);
                    mav.addObject("success", true);
                }
            }catch(Exception e) {
                logger.error(e.getMessage(), e);
                mav.addObject("messageResponse", this.getMessageSourceAccessor().getMessage("general.exception.msg"));
            }
        }
        if(!bindingResult.hasErrors() && bean.getPojo().getCategoryID() != null){
            try{
                bean.setPojo(categoryService.findById(bean.getPojo().getCategoryID()));
            }catch (ObjectNotFoundException oe) {
                logger.error(oe.getMessage(), oe);
                mav.addObject("messageResponse", this.getMessageSourceAccessor().getMessage("database.exception.keynotfound"));
            }
        }
        referenceData(mav);
        mav.addObject(Constants.FORM_MODEL_KEY, bean);
        return mav;
    }

    @RequestMapping(value={"/admin/category/list.html"})
    public ModelAndView list(CategoryBean bean, HttpServletRequest request) {
        ModelAndView mav = new ModelAndView("/admin/category/list");
        if(StringUtils.isNotBlank(bean.getCrudaction()) && bean.getCrudaction().equals(Constants.ACTION_DELETE)) {
            Integer totalDeleted = 0;
            try {
                totalDeleted = categoryService.deleteItems(bean.getCheckList());
            	mav.addObject("totalDeleted", totalDeleted);
                mav.addObject("messageResponse", this.getMessageSourceAccessor().getMessage("database.delete.successful", new String[]{totalDeleted.toString(), String.valueOf(bean.getCheckList().length)}));
            }catch (Exception e) {
                logger.error(e.getMessage(), e);
                mav.addObject(Constants.MESSAGE_RESPONSE_MODEL_KEY, this.getMessageSourceAccessor().getMessage("database.multipledelete.exception"));
            }
        }
        executeSearch(bean, request);
        mav.addObject(Constants.LIST_MODEL_KEY, bean);
        referenceData(mav);
        return mav;
    }
    
    @RequestMapping(value={"/admin/category/access.html"})
    public ModelAndView accessRole(CategoryBean bean, HttpServletRequest request) {
    	ModelAndView mav = new ModelAndView("/admin/category/access");
    	Long categoryID = bean.getPojo().getCategoryID();
    	if(categoryID != null){
    		if(StringUtils.isNotEmpty(bean.getCrudaction()) && "insert-update".equals(bean.getCrudaction())){
    			Boolean displayAll = bean.getDisplayAll();
    			List<Long> users = bean.getCheckUserList();
    			List<Long> groups = bean.getCheckGroupList();
    			try{
    				List<CategoryUser> categoryUsers = categoryUserService.findProperty("categoryID", categoryID);
    				categoryUserService.deleteAll(categoryUsers);
    				List<CategoryUserGroup> categoryUserGroups = categoryUserGroupService.findProperty("categoryID", categoryID);
    				categoryUserGroupService.deleteAll(categoryUserGroups);
	    			List<CategoryShowAll> categoryShowAlls = categoryShowAllService.findProperty("categoryID", categoryID);
	    			categoryShowAllService.deleteAll(categoryShowAlls);
	    			
    				if(displayAll != null && displayAll){
    					CategoryShowAll categoryShowAll = new CategoryShowAll();
    					categoryShowAll.setCategoryID(categoryID);
    					categoryShowAll.setDisplayAll(Constants.FLAG_YES);
    					categoryShowAllService.save(categoryShowAll);
    				}else{
    					if(users != null && users.size() > 0){
		    				for(Long userID : users){
		    					CategoryUser categoryUser = new CategoryUser();
		    					categoryUser.setCategoryID(categoryID);
		    					categoryUser.setUserID(userID);
		    					categoryUserService.save(categoryUser);
		    				}
		    			}
		    			if(groups != null && groups.size() > 0){
		    				for(Long userGroupID : groups){
		    					CategoryUserGroup categoryUserGroup = new CategoryUserGroup();
		    					categoryUserGroup.setCategoryID(categoryID);
		    					categoryUserGroup.setUserGroupID(userGroupID);
		    					categoryUserGroupService.save(categoryUserGroup);
		    				}
		    			}
    				}
	    			mav.addObject("messageResponse", this.getMessageSourceAccessor().getMessage("database.update.successful"));
                    mav.addObject("success", true);
    			}catch(Exception e){
    				logger.error(e.getMessage(), e);
                    mav.addObject("messageResponse", this.getMessageSourceAccessor().getMessage("error.occurred"));
    			}
    		}
    		referenceData(mav, bean, categoryID);
    	}
    	return mav;
    }
    
    @RequestMapping("/ajax/loadCategoryByAuthoringTemplate.html")
	public void sendMessage(HttpServletRequest request, HttpServletResponse response) {
		try{
			response.setContentType("text/json; charset=UTF-8");
			PrintWriter out = response.getWriter();
			JSONObject object = new JSONObject();
			JSONArray array = new JSONArray();
			String authoringTemplateIDstr = request.getParameter("au");
			if(StringUtils.isNotBlank(authoringTemplateIDstr)){
				Long authoringTemplateID = Long.valueOf(authoringTemplateIDstr);
				List<Category> categories = categoryService.findProperty("authoringTemplate.authoringTemplateID", authoringTemplateID);
				for(Category category : categories){
					array.put(new JSONArray(new Object[]{category.getCategoryID(), category.getName()}));
				}
			}
			object.put("array", array);
			object.put("success", true);
            out.print(object);
            out.flush();
            out.close();
		}catch(Exception e){
			logger.error(e.getMessage(), e);
		}
	}
    
    private void referenceData(ModelAndView mav, CategoryBean bean, Long categoryID){
    	try {
			Category category = categoryService.findById(categoryID);
			List<UserGroup> userGroups = userGroupService.findAll();
			List<User> users = userService.findAll();
			mav.addObject("userGroups", userGroups);
			mav.addObject("users", users);
			
			List<CategoryUser> categoryUsers = categoryUserService.findProperty("categoryID", categoryID);
			Map<Long, String> mapCheckedUser = new HashMap<Long, String>();
			for(CategoryUser categoryUser : categoryUsers){
				mapCheckedUser.put(categoryUser.getUserID(), "edit");
			}
			
			List<CategoryUserGroup> categoryUserGroups = categoryUserGroupService.findProperty("categoryID", categoryID);
			Map<Long, Boolean> mapCheckedGroup = new HashMap<Long, Boolean>();
			for(CategoryUserGroup categoryUserGroup : categoryUserGroups){
				mapCheckedGroup.put(categoryUserGroup.getUserGroupID(), true);
			}
			
			Set<Long> groupCheckedIDs = mapCheckedGroup.keySet();
			Iterator<Long> iterator = groupCheckedIDs.iterator();
			while(iterator.hasNext()){
				Long groupID = (Long)iterator.next();
				for(User user : users){
					if(user.getUserGroup().getUserGroupID().equals(groupID)){
						mapCheckedUser.put(user.getUserID(), "disabled");
					}
				}
			}
			mav.addObject("mapCheckedGroup", mapCheckedGroup);
			mav.addObject("mapCheckedUser", mapCheckedUser);
			try{
				CategoryShowAll categoryShowAll = categoryShowAllService.findEqualUnique("categoryID", categoryID);
				mav.addObject("displayAll", categoryShowAll.getDisplayAll());
			}catch(ObjectNotFoundException oe){}
			
			bean.setPojo(category);
			mav.addObject(Constants.FORM_MODEL_KEY, bean);
		} catch (ObjectNotFoundException oe) {
			logger.error(oe.getMessage(), oe);
            mav.addObject("messageResponse", this.getMessageSourceAccessor().getMessage("database.exception.keynotfound"));
		}
    }

    private void executeSearch(CategoryBean bean, HttpServletRequest request) {
        RequestUtil.initSearchBean(request, bean);
        Map<String, Object> properties = new HashMap<String, Object>();
        if(StringUtils.isNotBlank(bean.getPojo().getCode())){
            properties.put("code", bean.getPojo().getCode());
        }
        if(StringUtils.isNotBlank(bean.getPojo().getName())){
            properties.put("name", bean.getPojo().getName());
        }
        if(bean.getPojo().getParentCategory() != null && bean.getPojo().getParentCategory() != null && bean.getPojo().getParentCategory().getCategoryID() > 0){
            properties.put("parentCategory.categoryID", bean.getPojo().getParentCategory().getCategoryID());
        }
        Object[] results = this.categoryService.searchByProperties(properties, bean.getSortExpression(), bean.getSortDirection(), bean.getFirstItem(), bean.getMaxPageItems());
        bean.setListResult((List<Category>)results[1]);
        bean.setTotalItems(Integer.valueOf(results[0].toString()));
    }
    private void referenceData(ModelAndView mav) {
        mav.addObject("authoringtemplates", authoringTemplateService.findAll());
        mav.addObject("renderingtemplates", renderingTemplateService.findAll());
        List<Category> categories = this.categoryService.findAllCategoryParent();
        mav.addObject("categories", CategoryUtil.getAllCategoryObjectInSite(categories));
    }


}
