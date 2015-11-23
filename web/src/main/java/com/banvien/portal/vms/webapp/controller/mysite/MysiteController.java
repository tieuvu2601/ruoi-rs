package com.banvien.portal.vms.webapp.controller.mysite;

import com.banvien.jcr.api.IJcrContent;
import com.banvien.portal.vms.bean.ContentBean;
import com.banvien.portal.vms.bean.FileItem;
import com.banvien.portal.vms.bean.UserBean;
import com.banvien.portal.vms.bean.XmlNodeDTO;
import com.banvien.portal.vms.domain.*;
import com.banvien.portal.vms.editor.CustomDateEditor;
import com.banvien.portal.vms.editor.FileItemMultipartFileEditor;
import com.banvien.portal.vms.editor.PojoEditor;
import com.banvien.portal.vms.exception.ObjectNotFoundException;
import com.banvien.portal.vms.jbpm.service.JbpmSpringService;
import com.banvien.portal.vms.security.SecurityUtils;
import com.banvien.portal.vms.service.AuthoringTemplateService;
import com.banvien.portal.vms.service.ContentService;
import com.banvien.portal.vms.service.UserService;
import com.banvien.portal.vms.util.*;
import com.banvien.portal.vms.webapp.jcr.JcrConstants;
import com.banvien.portal.vms.webapp.validator.ContentValidator;
import com.banvien.portal.vms.webapp.validator.UserValidator;
import com.banvien.portal.vms.xml.authoringtemplate.Node;
import com.banvien.portal.vms.xml.contentitem.ContentItem;
import com.banvien.portal.vms.xml.contentitem.Item;
import com.banvien.portal.vms.xml.contentitem.Items;
import org.apache.commons.lang.StringUtils;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.support.ApplicationObjectSupport;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import java.io.File;
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
public class MysiteController extends ApplicationObjectSupport {
	private transient final Logger logger = Logger.getLogger(getClass());

    @Autowired
    private ContentService contentService;

    @Autowired
    private ContentValidator contentValidator;

    @Autowired
    private UserService userService;

    @Autowired
    private IJcrContent jcrContent;

    @Autowired
    private AuthoringTemplateService authoringTemplateService;

    @Autowired
    private JbpmSpringService jbpmSpringService;

    @Autowired
    private UserValidator userValidator;
    

    @InitBinder
    public void initBinder(WebDataBinder binder) {
    	binder.registerCustomEditor(Date.class, new CustomDateEditor());
        binder.registerCustomEditor(Timestamp.class, new CustomDateEditor("dd/MM/yyyy"));
        binder.registerCustomEditor(AuthoringTemplate.class, new PojoEditor(AuthoringTemplate.class, "authoringTemplateID", Long.class));
        binder.registerCustomEditor(Comment.class, new PojoEditor(Comment.class, "commentID", Long.class));
        binder.registerCustomEditor(User.class, new PojoEditor(User.class, "userID", Long.class));
        binder.registerCustomEditor(FileItem.class, new FileItemMultipartFileEditor());
        binder.registerCustomEditor(Department.class, new PojoEditor(Department.class, "departmentID", Long.class));
        binder.registerCustomEditor(UserGroup.class, new PojoEditor(UserGroup.class, "userGroupID", Long.class));
	}


    @RequestMapping("/mysite/home.html")
    public ModelAndView home(ContentBean bean, HttpServletRequest request){
        ModelAndView mav = new ModelAndView("/mysite/mysite");

        if(StringUtils.isNotBlank(bean.getCrudaction()) && bean.getCrudaction().equals(Constants.ACTION_DELETE)) {
            Integer totalDeleted = 0;
            try {
                totalDeleted = contentService.deleteItems(bean.getCheckList());
            	mav.addObject("totalDeleted", totalDeleted);
                mav.addObject("messageResponse", this.getMessageSourceAccessor().getMessage("database.delete.successful", new String[]{totalDeleted.toString(), String.valueOf(bean.getCheckList().length)}));
            }catch (Exception e) {
                logger.error(e.getMessage(), e);
                mav.addObject(Constants.MESSAGE_RESPONSE_MODEL_KEY, this.getMessageSourceAccessor().getMessage("database.multipledelete.exception"));
            }
        }
        executeSearch(bean, request);
        try{
            AuthoringTemplate documentTemplate = authoringTemplateService.findByCode(Constants.DOCUMENT_AUTHORING_CODE);
            mav.addObject("authoringTemplateDocumentID", documentTemplate.getAuthoringTemplateID());
        }catch (ObjectNotFoundException ex) {
            //Never occurred
        }
        mav.addObject(Constants.LIST_MODEL_KEY, bean);
        return mav;
    }



    @RequestMapping("/mysite/edit.html")
    public ModelAndView edit(@ModelAttribute(Constants.FORM_MODEL_KEY) ContentBean bean, BindingResult bindingResult, HttpServletRequest request){
        ModelAndView mav = new ModelAndView("/mysite/editmysite");
        String crudaction = bean.getCrudaction();
        Content pojo = bean.getPojo();
        Content dbItem = null;
        ContentItem contentItem = new ContentItem();
        List<XmlNodeDTO> authoringTemplateNodes = new ArrayList<XmlNodeDTO>();
        try{
            dbItem = contentService.findById(bean.getPojo().getContentID());

            AuthoringTemplate authoringTemplateDB = dbItem.getAuthoringTemplate();
            String authoringTemplateXML = authoringTemplateDB.getTemplateContent();
            if (StringUtils.isNotBlank(authoringTemplateXML)) {
                com.banvien.portal.vms.xml.authoringtemplate.AuthoringTemplate authoringTemplate = AuthoringTemplateUtil.parseXML(authoringTemplateXML);

                int index = 0;
                for (Node node : authoringTemplate.getNodes().getNode()) {
                    XmlNodeDTO nodeDTO = xmlNode2Bean(node, index);
                    authoringTemplateNodes.add(nodeDTO);
                    index++;
                }
                mav.addObject("authoringTemplateNodes", authoringTemplateNodes);
            }
            mav.addObject("authoringTemplate", authoringTemplateDB);
            contentItem = ContentItemUtil.parseXML(dbItem.getXmlData());
        }catch (ObjectNotFoundException oe) {
            logger.error(oe.getMessage(), oe);
            mav.addObject("messageResponse", this.getMessageSourceAccessor().getMessage("database.exception.keynotfound"));
        }catch (Exception e) {
            logger.error("Error while parsing authoring template", e);
        }
        if(StringUtils.isNotBlank(crudaction) && crudaction.equals("insert-update")) {
            try{
                populateContentCommand2Bean(request, authoringTemplateNodes, bean);
                contentValidator.validate(bean, bindingResult);
                if(!bindingResult.hasErrors()){
                    String filepath = jcrContent.write(JcrConstants.CONTENT_PATH, BeanUtils.toJcrFileItem(bean.getThumbnailFile()) );
                    pojo.setThumbnail(filepath);
                    String xmlData = ContentItemUtil.bean2Xml(bean.getContentItem());
                    pojo.setXmlData(xmlData);
                    bean.setPojo(pojo);
                    if(pojo.getContentID() != null && pojo.getContentID() > 0){
                        pojo.setCreatedBy(dbItem.getCreatedBy());
                        pojo.setModifiedBy(userService.findById(SecurityUtils.getLoginUserId()));
                        this.contentService.updateItem(bean);
                        mav.addObject("messageResponse", this.getMessageSourceAccessor().getMessage("database.update.successful"));
                    }
                    mav.addObject("success", true);
                }
            }catch(Exception e) {
                logger.error(e.getMessage(), e);
                mav.addObject("messageResponse", this.getMessageSourceAccessor().getMessage("general.exception.msg"));
            }
        }
        if(StringUtils.isBlank(bean.getCrudaction()) && bean.getPojo().getContentID() != null){
            bean.setPojo(dbItem);
            bean.setContentItem(contentItem);
        }

        executeSearch(bean, request);
        mav.addObject(Constants.FORM_MODEL_KEY, bean);
        return mav;
    }


    private XmlNodeDTO xmlNode2Bean(Node node, Integer index) {
        XmlNodeDTO res = new XmlNodeDTO();
        res.setName(node.getAttributeName());
        res.setDisplayName(node.getDisplayName());
        res.setType(node.getType());
        res.setMinOccurs(node.getMinOccurs());
        res.setMaxOccurs(node.getMaxOccurs());
        res.setDefaultValue(node.getDefaultValue());
        res.setConstraintValues(node.getConstraintValues());
        res.setDisplayOrder(index);
        return res;
    }



    private void populateContentCommand2Bean(HttpServletRequest request, List<XmlNodeDTO> authoringTemplateNodes, ContentBean bean) {
        ContentItem contentItem = new ContentItem();
        contentItem.setItems(new Items());
        for (XmlNodeDTO nodeDTO : authoringTemplateNodes) {
            Item item = new Item();
            item.setItemKey(nodeDTO.getName());
            item.setItemType(nodeDTO.getType());
            item.setMinOccurs(nodeDTO.getMinOccurs());
            item.setMaxOccurs(nodeDTO.getMaxOccurs());
            item.setDisplayName(nodeDTO.getDisplayName());
            if (nodeDTO.getType().equals(Constants.CONTENT_TYPE_BOOLEAN) || nodeDTO.getType().equals(Constants.CONTENT_TYPE_PLAIN_TEXT)
                    || nodeDTO.getType().equals(Constants.CONTENT_TYPE_RICH_TEXT) || nodeDTO.getType().equals(Constants.CONTENT_TYPE_NUMERIC)) {
                String[] values = request.getParameterValues(nodeDTO.getName());
                if (values != null && values.length > 0) {
                    for (String value : values) {
                        if (StringUtils.isNotBlank(value)) {
                            item.getItemValue().add(value);
                        }
                    }
                }

            }else if (nodeDTO.getType().equals(Constants.CONTENT_TYPE_IMAGE) || nodeDTO.getType().equals(Constants.CONTENT_TYPE_ATTACHMENT)) {
                MultipartHttpServletRequest multipartRequest = (MultipartHttpServletRequest) request;
                List<MultipartFile> files = multipartRequest.getFiles(nodeDTO.getName());
                if (files != null && files.size() > 0) {
                    for (MultipartFile file : files) {
                        com.banvien.jcr.api.FileItem fileItem = BeanUtils.multipartFile2FileItem(file);
                        try{
                            String path = jcrContent.write(JcrConstants.CONTENT_PATH, fileItem);
                            if (StringUtils.isNotBlank(path)) {
                                item.getItemValue().add(path);
                            }
                        }catch (Exception e) {
                            logger.error("Could not save file into DB", e);
                        }
                    }
                }
            }
            contentItem.getItems().getItem().add(item);
        }
        bean.setContentItem(contentItem);
    }


    @RequestMapping("/mysite/addmysite.html")
    public ModelAndView authoring(@RequestParam(value="authoringTemplateID", required = true) Long authoringTemplateID,@ModelAttribute(Constants.FORM_MODEL_KEY) ContentBean bean, BindingResult bindingResult, HttpServletRequest request){
        ModelAndView mav = new ModelAndView("/mysite/addmysite");
        String crudaction = bean.getCrudaction();
        Content pojo = bean.getPojo();
        List<XmlNodeDTO> authoringTemplateNodes = new ArrayList<XmlNodeDTO>();
        try{
            AuthoringTemplate authoringTemplateDB = authoringTemplateService.findById(authoringTemplateID);
            String authoringTemplateXML = authoringTemplateDB.getTemplateContent();
            if (StringUtils.isNotBlank(authoringTemplateXML)) {
                com.banvien.portal.vms.xml.authoringtemplate.AuthoringTemplate authoringTemplate = AuthoringTemplateUtil.parseXML(authoringTemplateXML);

                int index = 0;
                for (Node node : authoringTemplate.getNodes().getNode()) {
                    XmlNodeDTO nodeDTO = xmlNode2Bean(node, index);
                    authoringTemplateNodes.add(nodeDTO);
                    index++;
                }
                mav.addObject("authoringTemplateNodes", authoringTemplateNodes);
            }
            mav.addObject("authoringTemplate", authoringTemplateDB);
            pojo.setAuthoringTemplate(authoringTemplateDB);
        }catch (Exception e) {
            logger.error("Error while parsing authoring template", e);
        }

        if(StringUtils.isNotBlank(crudaction) && crudaction.equals("insert-update")) {
            try{
                populateContentCommand2Bean(request, authoringTemplateNodes, bean);
                contentValidator.validate(bean, bindingResult);
                if(!bindingResult.hasErrors()){
                    String xmlContent = ContentItemUtil.bean2Xml(bean.getContentItem());
                    pojo.setXmlData(xmlContent);

                    pojo.setCreatedDate(new Timestamp(System.currentTimeMillis()));
                    pojo.setModifiedDate(new Timestamp(System.currentTimeMillis()));
                    pojo.setCreatedBy(userService.findById(SecurityUtils.getLoginUserId()));
                    pojo.setModifiedBy(userService.findById(SecurityUtils.getLoginUserId()));
                    pojo.setStatus(Constants.CONTENT_WAITING_APPROVE);
                    bean.setPojo(pojo);
                    pojo = this.contentService.saveItem(bean);
                    jbpmSpringService.startProcess(Constants.CONTENT_PAGEFLOW_PROCESS_KEY, pojo.getContentID().toString());
                    mav.addObject("messageResponse", this.getMessageSourceAccessor().getMessage("database.add.successful"));

                    mav.addObject("success", true);
                    return new ModelAndView("redirect:/mysite/home.html");
                }
            }catch(Exception e) {
                logger.error(e.getMessage(), e);
                mav.addObject("messageResponse", this.getMessageSourceAccessor().getMessage("general.exception.msg"));
            }
        }
        if(!bindingResult.hasErrors() && bean.getPojo().getContentID() != null){
            try{
                bean.setPojo(contentService.findById(bean.getPojo().getContentID()));
            }catch (ObjectNotFoundException oe) {
                logger.error(oe.getMessage(), oe);
                mav.addObject("messageResponse", this.getMessageSourceAccessor().getMessage("database.exception.keynotfound"));
            }
        }
        mav.addObject(Constants.FORM_MODEL_KEY, bean);
        return mav;
    }



    private void executeSearch(ContentBean bean, HttpServletRequest request) {
        RequestUtil.initSearchBean(request, bean);
        Map<String, Object> properties = new HashMap<String, Object>();

        properties.put("authoringTemplate.code", Constants.DOCUMENT_AUTHORING_CODE);
        if(bean.getPojo().getTitle() != null ){
            properties.put("title", bean.getPojo().getTitle());
        }
        if(bean.getPojo().getKeyword() != null){
            properties.put("keyword", bean.getPojo().getKeyword());
        }
        if (!SecurityUtils.userHasAuthority(Constants.ADMIN_ROLE)) {
            properties.put("createdBy.userID", SecurityUtils.getLoginUserId());
        }
        Object[] results = this.contentService.searchByProperties(properties, bean.getSortExpression(), bean.getSortDirection(), bean.getFirstItem(), bean.getMaxPageItems());
        List<Content> listContent = (List<Content>)results[1];

        bean.setListResult(listContent);
        bean.setTotalItems(Integer.valueOf(results[0].toString()));
    }
    
    @RequestMapping("/mysite/profile.html")
    public ModelAndView profile(@ModelAttribute(Constants.FORM_MODEL_KEY) UserBean bean, BindingResult bindingResult, HttpServletRequest request){
    	ModelAndView mav = new ModelAndView("/mysite/profile");
    	String crudaction = bean.getCrudaction();
    	User pojo = bean.getPojo();
    	Long userID = pojo.getUserID();
    	if(StringUtils.isNotBlank(crudaction) && crudaction.equals("insert-update")) {
    		try{
    			User userDB = userService.findById(userID);
            	pojo.setUsername(userDB.getUsername());
            	pojo.setStatus(userDB.getStatus());
            	pojo.setCreatedDate(userDB.getCreatedDate());
            	pojo.setModifiedDate(new Timestamp(System.currentTimeMillis()));
            	pojo.setDepartment(userDB.getDepartment());
            	pojo.setUserGroup(userDB.getUserGroup());
            	
                userValidator.validate(bean, bindingResult);
                if(!bindingResult.hasErrors()){
                	String filepath = jcrContent.write(JcrConstants.AVATAR_PATH, BeanUtils.toJcrFileItem(bean.getFileItem()) );
                	if(!StringUtils.isNotEmpty(filepath)){
                		if(StringUtils.isNotEmpty(bean.getAvatar())){
            				filepath = bean.getAvatar();
                		}
                	}
                	if(StringUtils.isNotEmpty(filepath)){
                		pojo.setAvatar(filepath);
                	}else{
                		pojo.setAvatar(userDB.getAvatar());
                	}
                	
                    if(userID != null && userID >0 ){
                        this.userService.updateItem(pojo);
                        mav.addObject("messageResponse", this.getMessageSourceAccessor().getMessage("profile.update.successful"));
                    }
                    mav.addObject("success", true);
                }
            }catch(Exception e) {
                logger.error(e.getMessage(), e);
                mav.addObject("messageResponse", this.getMessageSourceAccessor().getMessage("profile.update.fail"));
            }
    	}
    	
		try{
			if(userID == null){
				userID = SecurityUtils.getLoginUserId();
			}
            bean.setPojo(userService.findById(userID));
            
            String realPath = request.getSession().getServletContext().getRealPath("/themes/vms/images/avatar");
            File files = new File(realPath);
            List<String> avatars = new ArrayList<String>();
            for(File file : files.listFiles()){
            	avatars.add(file.getName());
            }
            mav.addObject("avatars", avatars);
        }catch (ObjectNotFoundException oe) {
            logger.error(oe.getMessage(), oe);
            mav.addObject("messageResponse", this.getMessageSourceAccessor().getMessage("database.exception.keynotfound"));
        }
		
    	return mav;
    }

}
