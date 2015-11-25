package com.banvien.portal.vms.webapp.controller.admin;

import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.servlet.http.HttpServletRequest;

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
import org.springframework.web.servlet.ModelAndView;

import com.banvien.portal.vms.bean.AuthoringTemplateBean;
import com.banvien.portal.vms.bean.XmlNodeDTO;
import com.banvien.portal.vms.domain.AuthoringTemplate;
import com.banvien.portal.vms.domain.User;
import com.banvien.portal.vms.domain.UserGroup;
import com.banvien.portal.vms.editor.CustomDateEditor;
import com.banvien.portal.vms.exception.ObjectNotFoundException;
import com.banvien.portal.vms.service.AuthoringTemplateService;
import com.banvien.portal.vms.service.UserGroupService;
import com.banvien.portal.vms.service.UserService;
import com.banvien.portal.vms.util.AuthoringTemplateUtil;
import com.banvien.portal.vms.util.Constants;
import com.banvien.portal.vms.util.RequestUtil;
import com.banvien.portal.vms.webapp.validator.AuthoringTemplateValidator;
import com.banvien.portal.vms.xml.authoringtemplate.Node;
import com.banvien.portal.vms.xml.authoringtemplate.Nodes;


@Controller
public class AuthoringTemplateController extends ApplicationObjectSupport {
	private transient final Logger logger = Logger.getLogger(getClass());

    @Autowired
    private AuthoringTemplateService authoringTemplateService;

    @Autowired
    private AuthoringTemplateValidator authoringTemplateValidator;

    @InitBinder
    public void initBinder(WebDataBinder binder) {
    	binder.registerCustomEditor(Date.class, new CustomDateEditor());
	}

    @RequestMapping("/admin/authoringtemplate/edit.html")
    public ModelAndView edit(@ModelAttribute(Constants.FORM_MODEL_KEY) AuthoringTemplateBean bean, BindingResult bindingResult, HttpServletRequest request){
        ModelAndView mav = new ModelAndView("/admin/authoringtemplate/edit");
        String crudaction = bean.getCrudaction();
        AuthoringTemplate pojo = bean.getPojo();
        if(StringUtils.isNotBlank(crudaction) && crudaction.equals("insert-update")) {
            try{
                authoringTemplateValidator.validate(bean, bindingResult);
                if(!bindingResult.hasErrors()){
                	if(bean.getAuthoringTemplateNodes() == null || bean.getAuthoringTemplateNodes().size() < 1){
                		mav.addObject("messageResponse", this.getMessageSourceAccessor().getMessage("authoringtemplate.designer.insertnode"));
                	}else{
	                    String xmlTemplateContent = convertIntoXMLTemplateContent(bean.getAuthoringTemplateNodes());
	                    pojo.setTemplateContent(xmlTemplateContent);
	                    if(pojo.getAuthoringTemplateID() != null && pojo.getAuthoringTemplateID() > 0 ){
	                        this.authoringTemplateService.updateItem(pojo);
	                        mav.addObject("messageResponse", this.getMessageSourceAccessor().getMessage("database.update.successful"));
	                    }else{
	                        pojo.setCreatedDate(new Timestamp(System.currentTimeMillis()));
	                        this.authoringTemplateService.save(pojo);
	                        mav.addObject("messageResponse", this.getMessageSourceAccessor().getMessage("database.add.successful"));
	                    }
                	}
                    mav.addObject("success", true);
                }
            }catch(Exception e) {
                logger.error(e.getMessage(), e);
                mav.addObject("messageResponse", this.getMessageSourceAccessor().getMessage("general.exception.msg"));
            }
        }
        if(!bindingResult.hasErrors() && bean.getPojo().getAuthoringTemplateID() != null){
            try{
                AuthoringTemplate authoringTemplate =  authoringTemplateService.findById(bean.getPojo().getAuthoringTemplateID());
                if (StringUtils.isNotBlank(authoringTemplate.getTemplateContent())) {
                    try{
                        com.banvien.portal.vms.xml.authoringtemplate.AuthoringTemplate xmlAuthoringTemplate = AuthoringTemplateUtil.parseXML(authoringTemplate.getTemplateContent());
                        List<XmlNodeDTO> authoringTemplateNodes = new ArrayList<XmlNodeDTO>();
                        int index = 0;
                        for (Node node : xmlAuthoringTemplate.getNodes().getNode()) {
                            XmlNodeDTO xmlNodeDTO = xmlNode2Bean(node, index);
                            authoringTemplateNodes.add(xmlNodeDTO);
                            index++;
                        }
                        bean.setAuthoringTemplateNodes(authoringTemplateNodes);
                    }catch (Exception e) {
                        logger.error(e);
                    }
                }
                bean.setPojo(authoringTemplate);
            }catch (ObjectNotFoundException oe) {
                logger.error(oe.getMessage(), oe);
                mav.addObject("messageResponse", this.getMessageSourceAccessor().getMessage("database.exception.keynotfound"));
            }
        }
        mav.addObject(Constants.FORM_MODEL_KEY, bean);
        return mav;
    }

    private String convertIntoXMLTemplateContent(List<XmlNodeDTO> authoringTemplateNodes) {
        String res = "";
        com.banvien.portal.vms.xml.authoringtemplate.AuthoringTemplate authoringTemplate = new com.banvien.portal.vms.xml.authoringtemplate.AuthoringTemplate();
        authoringTemplate.setNodes(new Nodes());
        for (XmlNodeDTO xmlNodeDTO : authoringTemplateNodes) {
            if (xmlNodeDTO != null && StringUtils.isNotBlank(xmlNodeDTO.getName())) {
                Node node = new Node();
                node.setAttributeName(xmlNodeDTO.getName());
                node.setDisplayName(xmlNodeDTO.getDisplayName());
                node.setType(xmlNodeDTO.getType());
                node.setDefaultValue(xmlNodeDTO.getDefaultValue());
                node.setConstraintValues(xmlNodeDTO.getConstraintValues());
                node.setMinOccurs(xmlNodeDTO.getMinOccurs());
                node.setMaxOccurs(xmlNodeDTO.getMaxOccurs());
                authoringTemplate.getNodes().getNode().add(node);
            }
        }
        try{
            res = AuthoringTemplateUtil.bean2Xml(authoringTemplate);
        }catch (Exception e) {
            logger.error(e);
        }
        return res;
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

    @RequestMapping(value={"/admin/authoringtemplate/list.html"})
    public ModelAndView list(AuthoringTemplateBean bean, HttpServletRequest request) {
        ModelAndView mav = new ModelAndView("/admin/authoringtemplate/list");
        if(StringUtils.isNotBlank(bean.getCrudaction()) && bean.getCrudaction().equals(Constants.ACTION_DELETE)) {
            Integer totalDeleted = 0;
            try {
                totalDeleted = authoringTemplateService.deleteItems(bean.getCheckList());

            	mav.addObject("totalDeleted", totalDeleted);
                mav.addObject("messageResponse", this.getMessageSourceAccessor().getMessage("database.delete.successful", new String[]{totalDeleted.toString(), String.valueOf(bean.getCheckList().length)}));
            }catch (Exception e) {
                logger.error(e.getMessage(), e);
                mav.addObject(Constants.MESSAGE_RESPONSE_MODEL_KEY, this.getMessageSourceAccessor().getMessage("database.multipledelete.exception"));
            }
        }
        executeSearch(bean, request);
        mav.addObject(Constants.LIST_MODEL_KEY, bean);
        return mav;
    }

    private void executeSearch(AuthoringTemplateBean bean, HttpServletRequest request) {
        RequestUtil.initSearchBean(request, bean);
        Map<String, Object> properties = new HashMap<String, Object>();
        if(StringUtils.isNotBlank(bean.getPojo().getName())){
            properties.put("name", bean.getPojo().getName());
        }
        if(StringUtils.isNotBlank(bean.getPojo().getCode())){
            properties.put("code", bean.getPojo().getCode());
        }
        Object[] results = this.authoringTemplateService.searchByProperties(properties, bean.getSortExpression(), bean.getSortDirection(), bean.getFirstItem(), bean.getMaxPageItems());
        bean.setListResult((List<AuthoringTemplate>)results[1]);
        bean.setTotalItems(Integer.valueOf(results[0].toString()));
    }
}
