package com.banvien.portal.vms.webapp.controller.admin;

import com.banvien.jcr.api.IJcrContent;
import com.banvien.jcr.api.JcrContentImpl;
import com.banvien.portal.vms.bean.FileItem;
import com.banvien.portal.vms.bean.RoleBean;
import com.banvien.portal.vms.bean.UserBean;
import com.banvien.portal.vms.bean.UserDepartmentACLBean;
import com.banvien.portal.vms.domain.*;
import com.banvien.portal.vms.dto.C2UserDTO;
import com.banvien.portal.vms.dto.UserDTO;
import com.banvien.portal.vms.editor.CustomDateEditor;
import com.banvien.portal.vms.editor.FileItemMultipartFileEditor;
import com.banvien.portal.vms.editor.PojoEditor;
import com.banvien.portal.vms.exception.ObjectNotFoundException;
import com.banvien.portal.vms.service.*;
import com.banvien.portal.vms.util.BeanUtils;
import com.banvien.portal.vms.util.Constants;
import com.banvien.portal.vms.util.RequestUtil;
import com.banvien.portal.vms.webapp.jcr.JcrConstants;
import com.banvien.portal.vms.webapp.validator.UserValidator;
import org.apache.commons.lang.StringUtils;
import org.apache.log4j.Logger;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.support.ApplicationObjectSupport;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Date;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Created with IntelliJ IDEA.
 * User: NhuKhang
 * Date: 10/6/12
 * Time: 10:57 AM
 */
@Controller
public class UserController extends ApplicationObjectSupport {
	private transient final Logger logger = Logger.getLogger(getClass());

    @Autowired
    private UserService userService;

    @Autowired
    private RoleService roleService;

    @Autowired
    private UserValidator userValidator;

    @Autowired
    private DepartmentService departmentService;

    @Autowired
    private UserGroupService userGroupService;

    @Autowired
    private UserRoleService userRoleService;
    
    @Autowired
    private UserDepartmentACLService userDepartmentACLService;
    
    @Autowired
    private IJcrContent jcrContent; 

    @InitBinder
    public void initBinder(WebDataBinder binder) {
    	binder.registerCustomEditor(Date.class, new CustomDateEditor());
        binder.registerCustomEditor(Department.class, new PojoEditor(RenderingTemplate.class, "departmentID", Long.class));
        binder.registerCustomEditor(UserGroup.class, new PojoEditor(AuthoringTemplate.class, "userGroupID", Long.class));
        binder.registerCustomEditor(FileItem.class, new FileItemMultipartFileEditor());
	}

    @RequestMapping("/admin/user/edit.html")
    public ModelAndView edit(@ModelAttribute(Constants.FORM_MODEL_KEY) UserBean bean, BindingResult bindingResult){
        ModelAndView mav = new ModelAndView("/admin/user/edit");
        String crudaction = bean.getCrudaction();
        User pojo = bean.getPojo();
        if(StringUtils.isNotBlank(crudaction) && crudaction.equals("insert-update")) {
            try{
                userValidator.validate(bean, bindingResult);
                if(!bindingResult.hasErrors()){
                	try{
	                	String filepath = jcrContent.write(JcrConstants.AVATAR_PATH, BeanUtils.toJcrFileItem(bean.getFileItem()) );
	                    pojo.setAvatar(filepath);
                	}catch(Exception e){
                		logger.error("Could not save file to Jcr");
                	}
                    if(pojo.getUserID() != null && pojo.getUserID() >0 ){
                        this.userService.updateItem(pojo);
                        mav.addObject("messageResponse", this.getMessageSourceAccessor().getMessage("database.update.successful"));
                    }else{
                        pojo.setCreatedDate(new Timestamp(System.currentTimeMillis()));
                        this.userService.save(pojo);
                        mav.addObject("messageResponse", this.getMessageSourceAccessor().getMessage("database.add.successful"));
                    }
                    mav.addObject("success", true);
                }
            }catch(Exception e) {
                logger.error(e.getMessage(), e);
                mav.addObject("messageResponse", this.getMessageSourceAccessor().getMessage("general.exception.msg"));
            }
        }
        if(!bindingResult.hasErrors() && bean.getPojo().getUserID() != null){

            try{
                bean.setPojo(userService.findById(bean.getPojo().getUserID()));
            }catch (ObjectNotFoundException oe) {
                logger.error(oe.getMessage(), oe);
                mav.addObject("messageResponse", this.getMessageSourceAccessor().getMessage("database.exception.keynotfound"));
            }
        }
        referenceData(mav);
        mav.addObject(Constants.FORM_MODEL_KEY, bean);
        return mav;
    }

    @RequestMapping(value={"/admin/user/list.html"})
    public ModelAndView list(UserBean bean, HttpServletRequest request) {
        ModelAndView mav = new ModelAndView("/admin/user/list");
        if(StringUtils.isNotBlank(bean.getCrudaction()) && bean.getCrudaction().equals(Constants.ACTION_DELETE)) {
            Integer totalDeleted = 0;
            try {
                totalDeleted = userService.deleteItems(bean.getCheckList());
            	mav.addObject("totalDeleted", totalDeleted);
                mav.addObject("messageResponse", this.getMessageSourceAccessor().getMessage("database.delete.successful", new String[]{totalDeleted.toString(), String.valueOf(bean.getCheckList().length)}));
            }catch (Exception e) {
                logger.error(e.getMessage(), e);
                mav.addObject(Constants.MESSAGE_RESPONSE_MODEL_KEY, this.getMessageSourceAccessor().getMessage("database.multipledelete.exception"));
            }
        }
        executeSearch(bean, request);
        mav.addObject(Constants.LIST_MODEL_KEY, bean);
        mav.addObject("userGroups", userGroupService.findAll());
        return mav;
    }

    @RequestMapping(value={"/admin/user/access.html"})
    public ModelAndView access(@ModelAttribute(Constants.FORM_MODEL_KEY) UserBean bean, BindingResult bindingResult, HttpServletRequest request) {
        ModelAndView mav = new ModelAndView("/admin/user/access");

        String crudaction = bean.getCrudaction();
        if(StringUtils.isNotBlank(crudaction) && crudaction.equals("access")) {
            try{
                Integer res = 0;
                res = userRoleService.updateItemsByUserRole(bean);

            }catch(Exception e) {
                logger.error(e.getMessage(), e);
                mav.addObject("messageResponse", this.getMessageSourceAccessor().getMessage("general.exception.msg"));
            }
        }
        if(!bindingResult.hasErrors() && bean.getPojo().getUserID() != null){

            try{
                bean.setPojo(userService.findById(bean.getPojo().getUserID()));
            }catch (ObjectNotFoundException oe) {
                logger.error(oe.getMessage(), oe);
                mav.addObject("messageResponse", this.getMessageSourceAccessor().getMessage("database.exception.keynotfound"));
            }
        }

        //referenceDataContent(mav,roleBean);
        RoleBean roleBean = new RoleBean();
        executeSearchRole(roleBean, request);
        excutedSearchRole4User(bean,request);
        bean.setRoleBean(roleBean);
        mav.addObject(Constants.FORM_MODEL_KEY, bean);
        return mav;
    }

    @RequestMapping(value={"/admin/user/departmentACL.html"})
    public ModelAndView departmentAccessACL(@ModelAttribute(Constants.FORM_MODEL_KEY) UserDepartmentACLBean bean, BindingResult bindingResult, HttpServletRequest request) {
        ModelAndView mav = new ModelAndView("/admin/user/departmentACL");
        RequestUtil.initSearchBean(request, bean);
        String crudaction = bean.getCrudaction();
        if (StringUtils.isNotBlank(crudaction) && "update".equalsIgnoreCase(crudaction)) {
            userDepartmentACLService.updateUserACL(bean.getUserID(), bean.getDepartmentIDsInPage(), bean.getCheckList());
        }
        try{
            User user = userService.findById(bean.getUserID());
            mav.addObject("currentUser", user);

            List<UserDepartmentACL> userDepartmentACLs = userDepartmentACLService.findProperty("user.userID", bean.getUserID());
            Map<Long, UserDepartmentACL> userDepartmentACLMap = new HashMap<Long, UserDepartmentACL>();
            for (UserDepartmentACL userDepartmentACL : userDepartmentACLs) {
                userDepartmentACLMap.put(userDepartmentACL.getDepartment().getDepartmentID(), userDepartmentACL);
            }
            bean.setDepartmentACLMap(userDepartmentACLMap);

            Object[] objs = departmentService.searchByProperties(new HashMap<String, Object>(), bean.getSortExpression(), bean.getSortDirection(), bean.getFirstItem(), bean.getMaxPageItems());
            bean.setListResult((List<Department>)objs[1]);
            bean.setTotalItems(Integer.valueOf(objs[0].toString()));

        }catch (Exception e) {
            logger.error(e);
        }
        mav.addObject(Constants.FORM_MODEL_KEY, bean);
        return mav;
    }
    
    @RequestMapping(value="/ajax/searchLanId.html")
    public void searchLanId(@RequestParam("lanid") String lanid, HttpServletRequest request, HttpServletResponse response) throws IOException{
    	PrintWriter out = response.getWriter();
		try{
			response.setContentType("text/json; charset=UTF-8");
	        JSONObject obj = new JSONObject();
	        C2UserDTO userDTO = userService.findC2UserByUsername(lanid.toUpperCase());
	        if(userDTO != null) {
	        	obj.put("displayName", userDTO.getFullname());
	        	obj.put("email", "");
	        	obj.put("success", true);
	        }else {
	        	obj.put("success", false);
	        }
            out.print(obj);
           
		}catch (Exception e) {
			logger.error(e.getMessage(), e);
		}finally {
			 out.flush();
             out.close();
		}
    }
    
    private void executeSearchRole(RoleBean bean, HttpServletRequest request) {
        RequestUtil.initSearchBean(request, bean);
        Map<String, Object> properties = new HashMap<String, Object>();

        Object[] results = this.roleService.searchByProperties(properties, bean.getSortExpression(), bean.getSortDirection(), bean.getFirstItem(), bean.getMaxPageItems());
        bean.setListResult((List<Role>)results[1]);
        bean.setTotalItems(Integer.valueOf(results[0].toString()));
    }

    private void executeSearch(UserBean bean, HttpServletRequest request) {
        RequestUtil.initSearchBean(request, bean);
        Map<String, Object> properties = new HashMap<String, Object>();
        if(StringUtils.isNotBlank(bean.getPojo().getFirstName())){
        	properties.put("firstName", bean.getPojo().getFirstName());
        }
        if(StringUtils.isNotBlank(bean.getPojo().getLastName())){
        	properties.put("lastName", bean.getPojo().getLastName());
        }
        if(StringUtils.isNotBlank(bean.getPojo().getUsername())){
            properties.put("username", bean.getPojo().getUsername());
        }
        UserGroup userGroup = bean.getPojo().getUserGroup(); 
        if(userGroup != null && userGroup.getUserGroupID() != null){
        	properties.put("userGroup.userGroupID", userGroup.getUserGroupID());
        }
        Object[] results = this.userService.searchByProperties(properties, bean.getSortExpression(), bean.getSortDirection(), bean.getFirstItem(), bean.getMaxPageItems());
        bean.setListResult((List<User>)results[1]);
        bean.setTotalItems(Integer.valueOf(results[0].toString()));
    }

    private void referenceData(ModelAndView mav) {
        mav.addObject("departments", departmentService.findAll());
        mav.addObject("userGroups", userGroupService.findAll());
    }

    private void excutedSearchRole4User(UserBean bean, HttpServletRequest request) {
        RequestUtil.initSearchBean(request, bean);
        Map<String, Object> properties = new HashMap<String, Object>();
        if(bean.getPojo().getUserID() != null && bean.getPojo().getUserID() > 0)
        {
            properties.put(UserRole.FIELD_USER, bean.getPojo().getUserID());
        }
        Object[] results = this.userRoleService.searchByProperties(properties, bean.getSortExpression(), bean.getSortDirection(), 0, -1);
        List<UserRole> lst = new ArrayList<UserRole>();
        lst = (List<UserRole>)results[1];
        Map<Long, Boolean> published = new HashMap<Long, Boolean>();
        if(lst.size() > 0){
        	for(UserRole userrole: lst){
        		published.put(userrole.getRole().getRoleID(), true);
        	}
        }
        bean.setRoleMap(published);
        bean.setTotalItems(Integer.valueOf(results[0].toString()));
    }
    
    /**
     * used support for access role AuthoringTemplate and Category
     */
    @RequestMapping(value="/ajax/filterUserByGroup.html")
    public ModelAndView searchByGroup(@RequestParam(value="id", required=false) List<Long> groupIDs, 
    		@RequestParam(value="uid", required=false) List<Long> userIDs,
    		HttpServletRequest request, HttpServletResponse response) throws IOException{
    	ModelAndView mav = new ModelAndView("/admin/user/ajax");
    	List<User> users = userService.findAll();
    	mav.addObject("users", users);
    	mav.addObject("success", true);
    	Map<Long, String> mapCheckedUser = new HashMap<Long, String>();
    	if(groupIDs != null && groupIDs.size() > 0){
	    	for(Long ID : groupIDs){
	    		mapCheckedUser.put(ID, "disabled");
	    	}
    	}
    	if(userIDs != null && userIDs.size() > 0){
	    	for(Long uid : userIDs){
	    		mapCheckedUser.put(uid, "edit");
	    	}
    	}
    	mav.addObject("mapCheckedUser", mapCheckedUser);
    	return mav;
    }

}
