package com.banvien.portal.vms.webapp.controller.admin;

import com.banvien.jcr.api.FileItem;
import com.banvien.jcr.api.IJcrContent;
import com.banvien.portal.vms.bean.ContentBean;
import com.banvien.portal.vms.bean.XmlNodeDTO;
import com.banvien.portal.vms.crawler.AnnouncementCategoryCrawler;
import com.banvien.portal.vms.crawler.AnnouncementCrawler;
import com.banvien.portal.vms.crawler.NewsCrawler;
import com.banvien.portal.vms.domain.*;
import com.banvien.portal.vms.dto.ContentDTO;
import com.banvien.portal.vms.exception.ObjectNotFoundException;
import com.banvien.portal.vms.jbpm.service.JbpmSpringService;
import com.banvien.portal.vms.security.SecurityUtils;
import com.banvien.portal.vms.service.*;
import com.banvien.portal.vms.util.*;
import com.banvien.portal.vms.webapp.command.MigrationContentBean;
import com.banvien.portal.vms.webapp.jcr.JcrConstants;
import com.banvien.portal.vms.xml.authoringtemplate.Node;
import com.banvien.portal.vms.xml.contentitem.ContentItem;
import com.banvien.portal.vms.xml.contentitem.Item;
import com.banvien.portal.vms.xml.contentitem.Items;
import org.apache.commons.lang.StringUtils;
import org.apache.log4j.Logger;
import org.jbpm.api.task.Task;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.support.ApplicationObjectSupport;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

/**
 * Created by Ban Vien Co., Ltd.
 * User: viennh
 * Email: vien.nguyen@banvien.com
 * Date: 1/22/13
 * Time: 9:29 PM
 */
@Controller
public class MigrationContentController extends ApplicationObjectSupport {
    private transient final Logger logger = Logger.getLogger(getClass());
    private static final String MIGRATE_CONTENT_LIST_ID = "MIGRATE_CONTENT_LIST_ID";
    private static final String PREFIX_IMAGE_URL = "http://10.151.70.91";

    @Autowired
    private AuthoringTemplateService authoringTemplateService;

    @Autowired
    private CategoryService categoryService;

    @Autowired
    private UserService userService;

    @Autowired
    private ContentService contentService;

    @Autowired
    private DepartmentService departmentService;

    @Autowired
    private JbpmSpringService jbpmSpringService;

    @Autowired
    private IJcrContent jcrContent;

    @Autowired
    private AnnouncementCategoryService announcementCategoryService;

    @RequestMapping("/admin/migration/migrate.html")
    public ModelAndView migrate(@ModelAttribute(Constants.FORM_MODEL_KEY) MigrationContentBean bean, BindingResult bindingResult){
        ModelAndView mav = new ModelAndView("admin/migration/migrate");

        if (StringUtils.isNotBlank(bean.getCrudaction()) && ("migrate".equalsIgnoreCase(bean.getCrudaction()) || "geturl".equalsIgnoreCase(bean.getCrudaction()))) {
            try{
                AuthoringTemplate authoringTemplate = authoringTemplateService.findById(bean.getAuthoringTemplateID());
                List<ContentDTO> contentDTOs = new ArrayList<ContentDTO>();
                if (authoringTemplate.getCode().equals("tin-tuc")) {
                    NewsCrawler newsCrawler = new NewsCrawler(bean.getCrawlerUrl(), AuthoringTemplateUtil.parseXML(authoringTemplate.getTemplateContent()));
                    contentDTOs = newsCrawler.extractContents();
                }else{
                    if ("geturl".equalsIgnoreCase(bean.getCrudaction())) {
                        AnnouncementCategoryCrawler announcementCrawler = new AnnouncementCategoryCrawler(bean.getCrawlerUrl(), AuthoringTemplateUtil.parseXML(authoringTemplate.getTemplateContent()));
                        contentDTOs = announcementCrawler.extractContents();
                    }else{
                        AnnouncementCrawler announcementCrawler = new AnnouncementCrawler(bean.getCrawlerUrl(), AuthoringTemplateUtil.parseXML(authoringTemplate.getTemplateContent()), bean.getMaxCrawlItem());
                        contentDTOs = announcementCrawler.extractContents();
                    }
                }
                if (contentDTOs.size() > 0) {
                    CacheUtil.getInstance().putValue(MIGRATE_CONTENT_LIST_ID, contentDTOs);
                    StringBuilder url = new StringBuilder("redirect:/admin/migration/list.html?authoringTemplateID=");
                    url.append(bean.getAuthoringTemplateID());
                    if (bean.getCategoryID() != null) {
                        url.append("&categoryID=").append(bean.getCategoryID());
                    }
                    if (bean.getDepartmentID() != null) {
                        url.append("&departmentID=").append(bean.getDepartmentID());
                    }
                    if ("geturl".equalsIgnoreCase(bean.getCrudaction())) {
                        url.append("&geturl=true");
                    }
                    return new ModelAndView(url.toString());
                }
            }catch (Exception ex) {

            }
        }

        referenceData(mav, bean);
        return mav;
    }

    @RequestMapping("/admin/migration/list.html")
    public ModelAndView list(MigrationContentBean bean, HttpServletRequest request){
        ModelAndView mav = new ModelAndView("admin/migration/list");
        RequestUtil.initSearchBean(request, bean);
        List<ContentDTO> contentDTOs = (List<ContentDTO>)CacheUtil.getInstance().getValue(MIGRATE_CONTENT_LIST_ID);
        if (contentDTOs == null || contentDTOs.size() == 0) {
            return new ModelAndView("redirect:/admin/migration/migrate.html");
        }
        AuthoringTemplate authoringTemplate = null;
        Long[] categoryIDs = null;
        Long[] departmentIDs = null;
        try{
            authoringTemplate = authoringTemplateService.findById(bean.getAuthoringTemplateID());
            mav.addObject("authoringTemplate", authoringTemplate);

            if (bean.getCategoryID() != null && bean.getCategoryID() > 0) {
                categoryIDs = new Long[]{bean.getCategoryID()};
            }
            if (bean.getDepartmentID() != null && bean.getDepartmentID() > 0)  {
                departmentIDs = new Long[] {bean.getDepartmentID()};
            }
        }catch (ObjectNotFoundException ex) {
            return new ModelAndView("redirect:/admin/migration/migrate.html");
        }
        if (StringUtils.isNotBlank(bean.getCrudaction()) && "import".equalsIgnoreCase(bean.getCrudaction())) {
            Integer res = 0;
            Integer totalItem = contentDTOs.size();
            if (StringUtils.isNotBlank(bean.getGeturl()) && bean.getGeturl().equalsIgnoreCase("true")) {
                try{
                    for (ContentDTO contentDTO : contentDTOs)  {
                        AnnouncementCategory announcementCategory = new AnnouncementCategory();
                        announcementCategory.setAuthoringTemplateID(bean.getAuthoringTemplateID());
                        announcementCategory.setDepartmentID(bean.getDepartmentID());
                        announcementCategory.setUrl(contentDTO.getDetailURL());
                        announcementCategory.setStatus(Constants.CRAWLER_NOT_START);
                        announcementCategoryService.save(announcementCategory);
                        res++;
                    }
                }catch (Exception ex) {
                    ex.printStackTrace();
                }

                CacheUtil.getInstance().remove(MIGRATE_CONTENT_LIST_ID);
                String message = getMessageSourceAccessor().getMessage("migration.message", new Object[]{res, totalItem});
                mav = new ModelAndView("redirect:/admin/migration/migrate.html");
                mav.addObject("messageResponse", message);
                return mav;
            }else{
                try{
                    User onlineUser = null;
                    try{
                        onlineUser = userService.findById(SecurityUtils.getLoginUserId());
                    }catch (ObjectNotFoundException onf) {
                        //Never throw
                        return new ModelAndView("redirect:/admin/migration/migrate.html");
                    }

                    com.banvien.portal.vms.xml.authoringtemplate.AuthoringTemplate authoringTemplateXML = AuthoringTemplateUtil.parseXML(authoringTemplate.getTemplateContent());
                    List<XmlNodeDTO> authoringTemplateNodes = new ArrayList<XmlNodeDTO>();
                    int index = 0;
                    for (Node node : authoringTemplateXML.getNodes().getNode()) {
                        XmlNodeDTO nodeDTO = xmlNode2Bean(node, index);
                        authoringTemplateNodes.add(nodeDTO);
                        index++;
                    }
                    for (ContentDTO contentDTO : contentDTOs) {
                        downloadAndNormalizeImages(contentDTO);
                        Content content = buildContentDBItem(contentDTO, authoringTemplate, authoringTemplateNodes, onlineUser);
                        ContentBean contentBean = new ContentBean();
                        contentBean.setPojo(content);
                        contentBean.setCategoryIDs(categoryIDs);
                        contentBean.setDepartmentIDs(departmentIDs);
                        content = contentService.saveItem(contentBean);

                        JbpmUtils.startProcess(jbpmSpringService, onlineUser, content.getContentID());
                        String transition = "accept";
                        if(onlineUser.getUserGroup() == null || onlineUser.getUserGroup().getCode().equals(Constants.GROUP_AUTHOR)){
                            transition = "approve";
                        }
                        JbpmUtils.runProcess(jbpmSpringService, contentService, onlineUser, content, transition, content.getModifiedDate());
                        res++;
                    }
                    CacheUtil.getInstance().remove(MIGRATE_CONTENT_LIST_ID);
                    String message = getMessageSourceAccessor().getMessage("migration.message", new Object[]{res, totalItem});
                    mav = new ModelAndView("redirect:/admin/migration/migrate.html");
                    mav.addObject("messageResponse", message);
                    return mav;
                }catch (Exception e) {
                    mav.addObject("messageResponse", e.getMessage());
                    logger.error(e.getMessage(), e);
                }
            }
        }

        Integer lastIndex = bean.getPage() * bean.getMaxPageItems();
        if (lastIndex > contentDTOs.size()) {
            lastIndex = contentDTOs.size();
        }
        if (bean.getFirstItem() > contentDTOs.size()) {
            bean.setFirstItem(0);
        }

        bean.setListResult(contentDTOs.subList(bean.getFirstItem(), lastIndex));
        bean.setTotalItems(contentDTOs.size());
        mav.addObject(Constants.LIST_MODEL_KEY, bean);
        if (bean.getAuthoringTemplateID() != null && bean.getAuthoringTemplateID() > 0) {
            List<Category> categories = categoryService.findByAuthoringTemplateID(bean.getAuthoringTemplateID());
            mav.addObject("categories", categories);
            mav.addObject("departments", departmentService.findAll());

        }
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

    private Content buildContentDBItem(ContentDTO contentDTO, AuthoringTemplate authoringTemplate, List<XmlNodeDTO> authoringTemplateNodes, User onlineUser) {
        Timestamp now = new Timestamp(System.currentTimeMillis());
        Content res = new Content();
        res.setTitle(contentDTO.getTitle());
        res.setKeyword(contentDTO.getTitle());
        res.setThumbnail(contentDTO.getThumbnailURL());
        res.setAuthoringTemplate(authoringTemplate);
        res.setAccessPolicy(Constants.CONTENT_NOT_ALLOW_SHARE);
        res.setStatus(Constants.CONTENT_WAITING_APPROVE);
        if (StringUtils.isNotBlank(contentDTO.getPostDate())) {
            String s = contentDTO.getPostDate();
            s = s.replace("CH", "PM").replace("SA", "AM");
            Timestamp d = new Timestamp(DateUtils.convertFromString2Date(s, "dd/MM/yyyy hh:mm a").getTime());
            res.setCreatedDate(d);
            res.setModifiedDate(d);
        }else{
            res.setCreatedDate(now);
            res.setModifiedDate(now);
        }
        if (authoringTemplate.getCode().equals("tin-tuc")) {
            ContentItem contentItem = new ContentItem();
            contentItem.setItems(new Items());
            for (XmlNodeDTO nodeDTO : authoringTemplateNodes) {
                Item item = new Item();
                item.setItemKey(nodeDTO.getName());
                item.setItemType(nodeDTO.getType());
                item.setMinOccurs(nodeDTO.getMinOccurs());
                item.setMaxOccurs(nodeDTO.getMaxOccurs());
                item.setDisplayName(nodeDTO.getDisplayName());
                if (nodeDTO.getName().equals("brief")) {
                    item.getItemValue().add(contentDTO.getBrief());
                }else if (nodeDTO.getName().equals("detail")) {
                    item.getItemValue().add(contentDTO.getDetail());
                }else if (nodeDTO.getName().equals("code")) {
                    item.getItemValue().add(contentDTO.getCode());
                }
                contentItem.getItems().getItem().add(item);
            }
            try{
                res.setXmlData(ContentItemUtil.bean2Xml(contentItem));
            }catch (Exception e) {
                logger.error("Could not parse content", e);
            }

        }else if (authoringTemplate.getCode().equals("thong-bao")) {
            ContentItem contentItem = new ContentItem();
            contentItem.setItems(new Items());
            for (XmlNodeDTO nodeDTO : authoringTemplateNodes) {
                Item item = new Item();
                item.setItemKey(nodeDTO.getName());
                item.setItemType(nodeDTO.getType());
                item.setMinOccurs(nodeDTO.getMinOccurs());
                item.setMaxOccurs(nodeDTO.getMaxOccurs());
                item.setDisplayName(nodeDTO.getDisplayName());


                if (nodeDTO.getName().equals("content")) {
                    item.getItemValue().add(contentDTO.getBrief());
                }else if (nodeDTO.getName().equals("detail")) {
                    item.getItemValue().add(contentDTO.getBrief());

                } else if (nodeDTO.getName().equals("attachments")) {
                    if (contentDTO.getAttachmentURLs() != null && contentDTO.getAttachmentURLs().size() > 0) {
                        for (String attURL : contentDTO.getAttachmentURLs())  {
                            String newURL = downloadAndStoreIntoRepository(attURL, "portalcenter2", "portalcenter21016");
                            if (StringUtils.isNotBlank(newURL))  {
                                item.getItemValue().add(newURL);
                            }
                        }
                    }
                }
                contentItem.getItems().getItem().add(item);
            }
            try{
                res.setXmlData(ContentItemUtil.bean2Xml(contentItem));
            }catch (Exception e) {
                logger.error("Could not parse content", e);
            }
        }


        res.setCreatedBy(onlineUser);
        res.setModifiedBy(onlineUser);
        return res;
    }

    private void downloadAndNormalizeImages(ContentDTO contentDTO) {
        //Thumbnail
        if (StringUtils.isNotBlank(contentDTO.getThumbnailURL())) {
            String filename = downloadAndStoreIntoRepository(contentDTO.getThumbnailURL(), null, null);
            contentDTO.setThumbnailURL(filename);
        }

        String detail = contentDTO.getDetail();
        if (StringUtils.isNotBlank(detail)) {
            String imgReg = "<img.*?src=\"(.*?)\"";
            Pattern imgPattern = Pattern.compile(imgReg, Pattern.DOTALL + Pattern.CASE_INSENSITIVE);
            Matcher imgMatcher = imgPattern.matcher(detail);
            while(imgMatcher.find()) {
                String imgText= imgMatcher.group(0);
                String imgURL = imgMatcher.group(1);
                if (StringUtils.isNotBlank(imgURL)) {
                    String newImgURL = downloadAndStoreIntoRepository(imgURL, null, null);
                    if (StringUtils.isNotBlank(newImgURL)) {
                        String newImgText = imgText.replace(imgURL, "/repository" + newImgURL);
                        detail = detail.replace(imgText, newImgText);
                    }
                }
            }
        }
        contentDTO.setDetail(detail);
    }



    private String downloadAndStoreIntoRepository(String url, String username, String password) {
        String originalFilename = getFilename(url);
        String res = null;
        try{
            HttpClientHelper httpClientHelper = new HttpClientHelper(username, password);
            String fileURL = PREFIX_IMAGE_URL;
            if (!url.startsWith("/")) {
                fileURL += "/";
            }
            if (url.startsWith("http")) {
                fileURL = url;
            }else{
                fileURL += url;
            }
            fileURL = normalizeURL(fileURL);

            byte[] data = httpClientHelper.getByte(fileURL);
            FileItem fileItem = new FileItem();
            fileItem.setOriginalFilename(originalFilename);
            fileItem.setData(data);
            res = jcrContent.write(JcrConstants.MIGRATION_CONTENT_PATH, fileItem);
        }catch (Exception e) {
            e.printStackTrace();
        }
        return res;
    }

    private String normalizeURL(String url) {
        String res = url;
        int index = res.lastIndexOf("/");
        if (index >= 0) {
            String prefix = res.substring(0, index);
            String suffix = res.substring(index + 1);
            res = prefix + "/" + CommonUtil.encodeURIComponent(suffix);
        }
        return res;
    }


    private String getFilename(String fileURL) {
        String res = fileURL;
        int index = fileURL.lastIndexOf("/");
        if (index >= 0) {
            res = fileURL.substring(index + 1);
        }
        int dotIndex = res.lastIndexOf(".");
        if (dotIndex >= 0) {
            String filename = res.substring(0, dotIndex);
            String ext = res.substring(dotIndex + 1);
            res = CommonUtil.removeDiacritic(filename) + "." + ext;
        }else{
            res = CommonUtil.removeDiacritic(res);
        }
        res = res.replace(" ", "-");
        return res;
    }

    private void referenceData(ModelAndView mav, MigrationContentBean bean) {
        List<AuthoringTemplate> authoringTemplates = authoringTemplateService.findAll();
        mav.addObject("authoringTemplates", authoringTemplates);

        if (bean.getAuthoringTemplateID() != null && bean.getAuthoringTemplateID() > 0) {
            List<Category> categories = categoryService.findByAuthoringTemplateID(bean.getAuthoringTemplateID());
            mav.addObject("categories", categories);
        }else if (authoringTemplates.size() > 0){
            List<Category> categories = categoryService.findByAuthoringTemplateID(authoringTemplates.get(0).getAuthoringTemplateID());
            mav.addObject("categories", categories);
        }

        mav.addObject("departments", departmentService.findAll());

    }
}
