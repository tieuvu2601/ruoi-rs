package com.banvien.portal.vms.webapp.controller.admin;

import java.io.IOException;
import java.sql.Date;
import java.sql.Timestamp;
import java.util.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.banvien.portal.vms.domain.AuthoringTemplateEntity;
import com.banvien.portal.vms.domain.CategoryEntity;
import com.banvien.portal.vms.domain.ContentEntity;
import com.banvien.portal.vms.domain.UserEntity;
import com.banvien.portal.vms.dto.XmlNodeDTO;
import com.banvien.portal.vms.editor.CustomDateEditorSQL;
import com.banvien.portal.vms.service.*;
import com.banvien.portal.vms.util.*;
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

import com.banvien.jcr.api.IJcrContent;
import com.banvien.portal.vms.bean.ContentBean;
import com.banvien.portal.vms.bean.FileItem;
import com.banvien.portal.vms.editor.CustomDateEditor;
import com.banvien.portal.vms.editor.FileItemMultipartFileEditor;
import com.banvien.portal.vms.editor.PojoEditor;
import com.banvien.portal.vms.exception.ObjectNotFoundException;
import com.banvien.portal.vms.security.SecurityUtils;
import com.banvien.portal.vms.webapp.jcr.JcrConstants;
import com.banvien.portal.vms.webapp.validator.ContentValidator;
import com.banvien.portal.vms.xml.authoringtemplate.Node;
import com.banvien.portal.vms.xml.contentitem.ContentItem;
import com.banvien.portal.vms.xml.contentitem.Item;
import com.banvien.portal.vms.xml.contentitem.Items;

@Controller
public class ContentController extends ApplicationObjectSupport {
	private transient final Logger logger = Logger.getLogger(getClass());
	private final String AUTHORING_FILE_MAP = "AUTHORING_FILE_MAP";
	private final String CONTENT_FILE_MAP = "CONTENT_FILE_MAP";

    @Autowired
    private ContentService contentService;

    @Autowired
    private ContentValidator contentValidator;

    @Autowired
    private AuthoringTemplateService authoringTemplateService;

    @Autowired
    private CategoryService categoryService;

    @Autowired
    private IJcrContent jcrContent;
    
    @Autowired
    private UserService userService;
    
    @Autowired
    private MailEngine mailEngine;

    
    @InitBinder
    public void initBinder(WebDataBinder binder) {
    	binder.registerCustomEditor(Date.class, new CustomDateEditorSQL());
        binder.registerCustomEditor(Timestamp.class, new CustomDateEditor("dd/MM/yyyy"));
        binder.registerCustomEditor(AuthoringTemplateEntity.class, new PojoEditor(AuthoringTemplateEntity.class, "authoringTemplateId", Long.class));
        binder.registerCustomEditor(UserEntity.class, new PojoEditor(UserEntity.class, "userId", Long.class));
        binder.registerCustomEditor(FileItem.class, new FileItemMultipartFileEditor());
	}

    @RequestMapping(value={"/admin/content/list.html"})
    public ModelAndView list(ContentBean bean, HttpServletRequest request) {
        ModelAndView mav = new ModelAndView("/admin/content/list");
        String crudaction = bean.getCrudaction();

        Boolean isEnglishLanguage  = CommonUtil.isEnglishLanguage();

        if(StringUtils.isNotBlank(crudaction) && crudaction.equals(Constants.ACTION_DELETE)) {
            Integer totalDeleted = 0;
            try {
                String [] checkList = bean.getCheckList();
                if(checkList != null && checkList.length > 0){
                    List<Long> contentIds = new ArrayList<Long>();
                    for(String id : checkList){
                        contentIds.add(Long.valueOf(id.trim()));
                    }
                }
                totalDeleted = contentService.deleteItems(checkList);
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

    private void executeSearch(ContentBean bean, HttpServletRequest request) {
        RequestUtil.initSearchBean(request, bean);
        if (StringUtils.isBlank(bean.getSortExpression())) {
            bean.setSortExpression("createdDate");
            bean.setSortDirection(Constants.SORT_DESC);
        }

        Map<String, Object> properties = new HashMap<String, Object>();
        if(StringUtils.isNotBlank(bean.getPojo().getTitle())){
            properties.put("title", bean.getPojo().getTitle().trim());
        }

        if(StringUtils.isNotBlank(bean.getPojo().getKeyword())){
            properties.put("keyword", bean.getPojo().getKeyword());
        }

        if (bean.getPojo().getAuthoringTemplate() != null && bean.getPojo().getAuthoringTemplate().getAuthoringTemplateId() > 0) {
            properties.put("authoringTemplate.authoringTemplateID", bean.getPojo().getAuthoringTemplate().getAuthoringTemplateId());
        }

        if(bean.getPojo().getCategory() != null && bean.getPojo().getCategory().getCategoryId() != null && bean.getPojo().getCategory().getCategoryId() > 0){
            properties.put("category.categoryID", bean.getPojo().getCategory().getCategoryId());
        }

        StringBuilder whereClause = new StringBuilder();

        if(bean.getPojo().getStatus() == null){
            if(SecurityUtils.userHasAuthority("AUTHOR")){
                bean.getPojo().setStatus(Constants.CONTENT_SAVE);
                properties.put("status", bean.getPojo().getStatus());
            } else if(SecurityUtils.userHasAuthority("APPROVER")){
                bean.getPojo().setStatus(Constants.CONTENT_WAITING_APPROVE);
                properties.put("status", bean.getPojo().getStatus());
            } else if(SecurityUtils.userHasAuthority("PUBLISHER")){
                bean.getPojo().setStatus(Constants.CONTENT_APPROVE);
                properties.put("status", bean.getPojo().getStatus());
            }
        } else if(bean.getPojo().getStatus() != null && bean.getPojo().getStatus() > -10){
            if(bean.getPojo().getStatus() == Constants.CONTENT_SAVE){
                properties.put("createdBy.userID", SecurityUtils.getLoginUserId());
            }
            properties.put("status", bean.getPojo().getStatus());
        }

        Object[] results = this.contentService.searchByProperties(properties, bean.getSortExpression(), bean.getSortDirection(), bean.getFirstItem(), bean.getMaxPageItems(), whereClause.toString());
        List<ContentEntity> listContent = (List<ContentEntity>)results[1];

        bean.setListResult(listContent);
        bean.setTotalItems(Integer.valueOf(results[0].toString()));
    }

    private void referenceData(ModelAndView mav) {
        List<CategoryEntity> categories = this.categoryService.findAllCategoryParent();
        mav.addObject("categories", CategoryUtil.getAllCategoryObjectInSite(categories));
        mav.addObject("authoringTemplates", authoringTemplateService.findAll());
        mav.addObject("currentUserID", SecurityUtils.getLoginUserId());
    }

    @RequestMapping("/admin/content/add.html")
    public ModelAndView add(@ModelAttribute(Constants.FORM_MODEL_KEY) ContentBean bean, BindingResult bindingResult){
        ModelAndView mav = new ModelAndView("/admin/content/add");
        String crudaction = bean.getCrudaction();
        if(StringUtils.isNotBlank(crudaction) && crudaction.equals("insert-update")) {
            if (bean.getPojo().getAuthoringTemplate() == null || bean.getPojo().getAuthoringTemplate().getAuthoringTemplateId() == null) {
                mav.addObject("messageResponse", getMessageSourceAccessor().getMessage("content.authoringtemplate.required"));
            }else{
                return new ModelAndView("redirect:/admin/content/authoring.html?authoringTemplateID="
                        + bean.getPojo().getAuthoringTemplate().getAuthoringTemplateId()
                        + "&categoryID=" + bean.getPojo().getCategory().getCategoryId() );
            }
        }
        referenceData(mav);
        mav.addObject(Constants.FORM_MODEL_KEY, bean);
        return mav;
    }

    @RequestMapping("/admin/content/authoring.html")
    public ModelAndView authoring(@RequestParam(value="authoringTemplateID", required = true) Long authoringTemplateID,
                                  @RequestParam(value="categoryID", required = true) Long categoryID,
                                  ContentBean bean, BindingResult bindingResult, HttpServletRequest request){
        ModelAndView mav = new ModelAndView("/admin/content/authoring");
        String crudaction = bean.getCrudaction();
        ContentEntity pojo = bean.getPojo();
        List<XmlNodeDTO> authoringTemplateNodes = new ArrayList<XmlNodeDTO>();
        AuthoringTemplateEntity authoringTemplateDB = null;
        try{
            authoringTemplateDB = authoringTemplateService.findById(authoringTemplateID);
            if(authoringTemplateDB != null){
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
                CategoryEntity category = new CategoryEntity();
                category.setCategoryId(categoryID);
                pojo.setCategory(category);
            }
        }catch (Exception e) {
            logger.error("Error while parsing authoring template", e);
        }

        if(StringUtils.isNotBlank(crudaction) && (crudaction.equals("insert-update") || crudaction.equals("insert-submit-content"))) {
            try{
            	bean.setAuthoringTemplateID(authoringTemplateID);
            	populateContentCommand2Bean(request, authoringTemplateNodes, bean, false);
                contentValidator.validate(bean, bindingResult);
                if(!bindingResult.hasErrors()){
                    UserEntity user = userService.findById(SecurityUtils.getLoginUserId());
                    if (bean.getThumbnailFile() != null) {
                        String filepath = jcrContent.write(JcrConstants.CONTENT_PATH, BeanUtils.toJcrFileItem(bean.getThumbnailFile()) );
                        pojo.setThumbnails(filepath);
                    }
                    String xmlContent = ContentItemUtil.bean2Xml(bean.getContentItem());
                    pojo.setXmlData(xmlContent);
                    pojo.setCreatedBy(user);
                    if(crudaction.equals("insert-update")){
                        pojo.setStatus(Constants.CONTENT_SAVE);
                    }else if(crudaction.equals("insert-submit-content")){
                        pojo.setStatus(Constants.CONTENT_WAITING_APPROVE);
                    }
                    bean.setPojo(pojo);
                    pojo = this.contentService.saveItem(bean);
                    mav = new ModelAndView("redirect:/admin/content/list.html");
                    mav.addObject("success", true);
                    if(crudaction.equals("insert-submit-content")){
                    	String transition = "accept";
                    	if(user.getUserGroup() == null || user.getUserGroup().getCode().equals(Constants.GROUP_AUTHOR)){
                    		transition = "approve";
                    	}
                    	mav.addObject("messageResponse", this.getMessageSourceAccessor().getMessage("database.add.successful"));
                    }else{
                    	mav.addObject("messageResponse", this.getMessageSourceAccessor().getMessage("database.add.successful"));
                    }
                    return mav;
                }else {
                	removeSessionFilesFromJCR(authoringTemplateID, AUTHORING_FILE_MAP, request);
                }
            }catch(Exception e) {
                logger.error(e.getMessage(), e);
                mav.addObject("messageResponse", this.getMessageSourceAccessor().getMessage("general.exception.msg"));
            }
        }
        if(!bindingResult.hasErrors() && bean.getPojo().getContentId() != null){
            try{
                bean.setPojo(contentService.findById(bean.getPojo().getContentId()));
            }catch (ObjectNotFoundException oe) {
                logger.error(oe.getMessage(), oe);
                mav.addObject("messageResponse", this.getMessageSourceAccessor().getMessage("database.exception.keynotfound"));
            }
        }
        removeSessionFileMap(authoringTemplateID, AUTHORING_FILE_MAP, request);
        mav.addObject(Constants.FORM_MODEL_KEY, bean);
        referenceData(mav);
        return mav;
    }

    @RequestMapping("/admin/content/edit.html")
    public ModelAndView edit(@ModelAttribute(Constants.FORM_MODEL_KEY) ContentBean bean, BindingResult bindingResult, HttpServletRequest request){
        ModelAndView mav = new ModelAndView("/admin/content/edit");
        String crudaction = bean.getCrudaction();
        ContentEntity pojo = bean.getPojo();
        ContentEntity dbItem = null;
        ContentItem contentItem = new ContentItem();
        List<XmlNodeDTO> authoringTemplateNodes = new ArrayList<XmlNodeDTO>();
        try{
            dbItem = contentService.findById(bean.getPojo().getContentId());
            AuthoringTemplateEntity authoringTemplateDB = dbItem.getAuthoringTemplate();
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
            referenceData(mav);
        }catch (ObjectNotFoundException oe) {
            logger.error(oe.getMessage(), oe);
            mav.addObject("messageResponse", this.getMessageSourceAccessor().getMessage("database.exception.keynotfound"));
        }catch (Exception e) {
            logger.error("Error while parsing authoring template", e);
        }
        if(StringUtils.isNotBlank(crudaction) && (crudaction.equals("update") || crudaction.equals("send")
                || crudaction.equals("approve") || crudaction.equals("public") || crudaction.equals("reject"))) {
            try{
                populateContentCommand2Bean(request, authoringTemplateNodes, bean, true);
                contentValidator.validate(bean, bindingResult);
                if(!bindingResult.hasErrors()){
                    if (bean.getThumbnailFile() != null) {
                        String filepath = jcrContent.write(JcrConstants.CONTENT_PATH, BeanUtils.toJcrFileItem(bean.getThumbnailFile()) );
                        pojo.setThumbnails(filepath);
                    }
                    String xmlData = ContentItemUtil.bean2Xml(bean.getContentItem());
                    pojo.setXmlData(xmlData);
                    bean.setPojo(pojo);
                    if(pojo.getContentId() != null && pojo.getContentId() > 0){
                        UserEntity user = userService.findById(SecurityUtils.getLoginUserId());
                        pojo.setCreatedBy(dbItem.getCreatedBy());
                        if(crudaction.equals("update")){
                            pojo.setStatus(Constants.CONTENT_SAVE);
                        }else if(crudaction.equals("send")){
                            pojo.setStatus(Constants.CONTENT_WAITING_APPROVE);
                        }
                        this.contentService.updateItem(bean);
                        mav = new ModelAndView("redirect:/admin/content/list.html");
                        return mav;
                    }
                    if(bean.getDeletedAttchments() != null && bean.getDeletedAttchments().size() > 0) {
                        deleteFromJCR(bean.getDeletedAttchments());
                    }
                    mav.addObject("success", true);
                }else {
                    removeSessionFilesFromJCR(bean.getPojo().getContentId(), CONTENT_FILE_MAP, request);
                }
            }catch(Exception e) {
                logger.error(e.getMessage(), e);
                mav.addObject("messageResponse", this.getMessageSourceAccessor().getMessage("general.exception.msg"));
            }
        }
        if(StringUtils.isBlank(bean.getCrudaction()) && bean.getPojo().getContentId() != null){
            bean.setPojo(dbItem);
            bean.setContentItem(contentItem);
        }
        mav.addObject("listCategories", CategoryUtil.getAllCategoryObjectInSite(categoryService.findAllCategoryParent()));
        mav.addObject(Constants.FORM_MODEL_KEY, bean);
        mav.addObject("currentUserID", SecurityUtils.getLoginUserId());
        referenceData(mav);
        return mav;
    }

    @RequestMapping("/admin/content/view.html")
    public ModelAndView contentView(@ModelAttribute(Constants.FORM_MODEL_KEY) ContentBean bean, HttpServletRequest request){
        ModelAndView mav = new ModelAndView("/admin/content/view");
        Long contentID = bean.getPojo().getContentId();
        String crudaction = bean.getCrudaction();

        if(contentID != null){
            if(StringUtils.isNotBlank(crudaction) && (crudaction.equals("send") || crudaction.equals("approve") || crudaction.equals("public") || crudaction.equals("reject"))){
                try{
                    ContentEntity content = bean.getPojo();
                    if(crudaction.equals("send")){
                        content.setStatus(Constants.CONTENT_WAITING_APPROVE);
                    }else if(crudaction.equals("approve")){
                        content.setStatus(Constants.CONTENT_APPROVE);
                    } else if(crudaction.equals("public")){
                        content.setStatus(Constants.CONTENT_PUBLISH);
                    } else if(crudaction.equals("reject")){
                        content.setStatus(Constants.CONTENT_REJECT);
                    }
                    this.contentService.updateStatusItem(content);
                    mav = new ModelAndView("redirect:/admin/content/list.html");
                    return mav;
                } catch (Exception e){
                    mav = new ModelAndView("redirect:/admin/content/list.html");
                    return mav;
                }
            } else {
                try {
                    ContentEntity content = contentService.findById(contentID);
                    bean.setPojo(content);
                    ContentItem contentItem = ContentItemUtil.parseXML(content.getXmlData());
                    bean.setContentItem(contentItem);
                } catch (Exception e) {
                    logger.error("Content not found id = "+contentID, e);
                    mav = new ModelAndView("redirect:/admin/content/list.html");
                    return mav;
                }
            }
        }
        mav.addObject("currentUserID", SecurityUtils.getLoginUserId());
        mav.addObject(Constants.FORM_MODEL_KEY, bean);
        return mav;
    }

    @RequestMapping("/ajax/crop.html")
    public ModelAndView viewCropPage(@RequestParam("contentID") String contentID, HttpServletRequest request){
        ModelAndView mav = new ModelAndView("web/page/crop");
        if (contentID != null && StringUtils.isNotEmpty(contentID)) {
            try {
                ContentEntity content = contentService.findById(Long.parseLong(contentID));
                mav.addObject("item", content);
            } catch (ObjectNotFoundException e) {
                logger.error("Content not found with id: " + contentID);
            }
        }
        return mav;
    }

    private void populateContentCommand2Bean(HttpServletRequest request, List<XmlNodeDTO> authoringTemplateNodes, ContentBean bean, boolean isEdit) {
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
            	try {
            		Map<Long, Map<String, List<String>>> fileMap = null;
            		if(isEdit) {
            			 fileMap = (Map<Long, Map<String, List<String>>>)request.getSession().getAttribute(CONTENT_FILE_MAP);
            		}else {
            			fileMap = (Map<Long, Map<String, List<String>>>)request.getSession().getAttribute(AUTHORING_FILE_MAP);
            		}
	            	if(fileMap != null && fileMap.size() > 0) {
	            		Map<String, List<String>> uploadedNodeFiles = null;
	            		if(isEdit) {
	            			uploadedNodeFiles = fileMap.get(bean.getPojo().getContentId());
	            		}else {
	            			uploadedNodeFiles = fileMap.get(bean.getAuthoringTemplateID());
	            		}
		            	if(uploadedNodeFiles != null && uploadedNodeFiles.size() > 0) {
		            		List<String> nodeFiles = uploadedNodeFiles.get(nodeDTO.getName());
		            		if(nodeFiles != null && nodeFiles.size() > 0) {
		            			for(String filePath : nodeFiles)  {
                                    if (StringUtils.isNotBlank(filePath)) {
		            				    item.getItemValue().add(filePath);
                                    }
		            			}
		            		}

                            List<String> oldFileUpdate = bean.getOldNodeAttachementValues().get(nodeDTO.getName());
                            Integer indexFile = 1;
                            if(item.getItemValue().size() < nodeDTO.getMaxOccurs() && oldFileUpdate != null && oldFileUpdate.size() > 0){
                                for(int i = item.getItemValue().size(); i < nodeDTO.getMaxOccurs(); i++){
                                    item.getItemValue().add(oldFileUpdate.get(oldFileUpdate.size() - indexFile));
                                    indexFile++;
                                }
                            }
		            	}
	            	}else if(isEdit && bean.getOldNodeAttachementValues() != null && bean.getOldNodeAttachementValues().size() > 0){
	            		List<String> oldNodeAttachmentValues = bean.getOldNodeAttachementValues().get(nodeDTO.getName());
	            		if(oldNodeAttachmentValues != null && oldNodeAttachmentValues.size() > 0) {
	            			item.getItemValue().addAll(oldNodeAttachmentValues);
	            		}
	            		
	            	}
            	}catch (Exception e) {
            		logger.error("Could not save file into DB", e);
				}
            }
            contentItem.getItems().getItem().add(item);
        }
        bean.setContentItem(contentItem);
    }

    @RequestMapping(value={"/ajax/content/uploadfile.html"})
    public void uploadfile(@RequestParam("nodename") String nodeName, @RequestParam(value="authoringTemplateID", required=false) Long authoringTemplateID, @RequestParam(value="contentID", required=false) Long contentID, HttpServletRequest request, HttpServletResponse response) throws IOException {
        Map<Long, Map<String, List<String>>> fileMap = null;
        Long lKey = null;
        if(authoringTemplateID != null && authoringTemplateID > 0) {
            lKey = authoringTemplateID;
            fileMap = (Map<Long, Map<String, List<String>>>)request.getSession().getAttribute(AUTHORING_FILE_MAP);
        }else if(contentID != null && contentID > 0) {
            lKey = contentID;
            fileMap = (Map<Long, Map<String, List<String>>>)request.getSession().getAttribute(CONTENT_FILE_MAP);
        }
        if(fileMap == null) {
            fileMap = new HashMap<Long, Map<String,List<String>>>();
            fileMap.put(lKey, new HashMap<String, List<String>>());
        }
        Map<String, List<String>> files = fileMap.get(lKey);
        if(files == null) {
            files = new HashMap<String, List<String>>();
        }
        List<String> nodeFiles = files.get(nodeName);
        if(nodeFiles == null) {
            nodeFiles = new ArrayList<String>();
        }

        MultipartHttpServletRequest multipartRequest = (MultipartHttpServletRequest) request;
        Map<String, MultipartFile> multipartFiles = multipartRequest.getFileMap();
        if (multipartFiles != null && multipartFiles.size() > 0) {
            for (String filename : multipartFiles.keySet()) {
                MultipartFile file = multipartFiles.get(filename);
                com.banvien.jcr.api.FileItem fileItem = BeanUtils.multipartFile2FileItem(file);
                try{
                    String path = jcrContent.write(JcrConstants.CONTENT_PATH, fileItem);
                    if (StringUtils.isNotBlank(path)) {
                        nodeFiles.add(path);
                    }
                }catch (Exception e) {
                    logger.error("Could not save file into DB", e);
                }
            }
            files.put(nodeName, nodeFiles);
            fileMap.put(lKey, files);
            if(authoringTemplateID != null && authoringTemplateID > 0) {
                request.getSession().setAttribute(AUTHORING_FILE_MAP, fileMap);
            }else if(contentID != null && contentID > 0) {
                request.getSession().setAttribute(CONTENT_FILE_MAP, fileMap);
            }

        }
        response.flushBuffer();
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

    private void removeSessionFilesFromJCR(Long key, String  sessionKey, HttpServletRequest request) {
    	try {
    		Map<Long, Map<String, List<String>>> fileMap = (Map<Long, Map<String, List<String>>>)request.getSession().getAttribute(sessionKey);
        	if(fileMap != null && fileMap.size() > 0) {
            	Map<String, List<String>> uploadedNodeFiles = fileMap.get(key);
            	if(uploadedNodeFiles != null && uploadedNodeFiles.size() > 0) {
            		for(String nodeName : uploadedNodeFiles.keySet()) {
            			List<String> nodeFiles = uploadedNodeFiles.get(nodeName);
                		if(nodeFiles != null && nodeFiles.size() > 0) {
                			for(String filePath : nodeFiles) {
                	    		try{
                	    			jcrContent.removeFileItem(filePath);
                	    		}catch (Exception e) {
                	    			logger.warn("Could not remove file " + filePath, e);
                				}
                	    	}
                		}
            		}
            		fileMap.remove(key);
            	}
        	}
    	}catch (Exception e) {
    		logger.error("Could not remove authoring files", e);
		}
    }
    private void removeSessionFileMap(Long key, String sessionKey, HttpServletRequest request) {
    	Map<Long, Map<String, List<String>>> fileMap = (Map<Long, Map<String, List<String>>>)request.getSession().getAttribute(sessionKey);
    	if(fileMap != null && fileMap.size() > 0 && key != null) {
    		fileMap.remove(key);
    	}
    }
    private void deleteFromJCR(List<String> paths) {
		for(String filePath : paths) {
    		try{
    			jcrContent.removeFileItem(filePath);
    		}catch (Exception e) {
    			logger.warn("Could not remove file " + filePath, e);
			}
    	}
    }
}
