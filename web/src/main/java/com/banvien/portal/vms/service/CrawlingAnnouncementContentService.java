package com.banvien.portal.vms.service;

import com.banvien.jcr.api.FileItem;
import com.banvien.jcr.api.IJcrContent;
import com.banvien.portal.vms.bean.ContentBean;
import com.banvien.portal.vms.bean.XmlNodeDTO;
import com.banvien.portal.vms.crawler.AnnouncementCrawler;
import com.banvien.portal.vms.crawler.ICrawler;
import com.banvien.portal.vms.domain.AnnouncementCategory;
import com.banvien.portal.vms.domain.AuthoringTemplate;
import com.banvien.portal.vms.domain.Content;
import com.banvien.portal.vms.domain.User;
import com.banvien.portal.vms.dto.ContentDTO;
import com.banvien.portal.vms.jbpm.service.JbpmSpringService;
import com.banvien.portal.vms.util.*;
import com.banvien.portal.vms.webapp.jcr.JcrConstants;
import com.banvien.portal.vms.xml.authoringtemplate.Node;
import com.banvien.portal.vms.xml.contentitem.ContentItem;
import com.banvien.portal.vms.xml.contentitem.Item;
import com.banvien.portal.vms.xml.contentitem.Items;
import org.apache.commons.lang.StringUtils;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;

import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

/**
 * Created by Ban Vien Co., Ltd.
 * User: viennh
 * Email: vien.nguyen@banvien.com
 * Date: 3/13/13
 * Time: 9:31 AM
 */
public class CrawlingAnnouncementContentService {
    private transient final Logger logger = Logger.getLogger(getClass());
    private static final String PREFIX_IMAGE_URL = "http://10.151.70.91";
    private String username;

    private AnnouncementCategoryService announcementCategoryService;

    private ContentService contentService;

    private JbpmSpringService jbpmSpringService;

    private AuthoringTemplateService authoringTemplateService;

    private UserService userService;

    private IJcrContent jcrContent;

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public void setAnnouncementCategoryService(AnnouncementCategoryService announcementCategoryService) {
        this.announcementCategoryService = announcementCategoryService;
    }

    public void setContentService(ContentService contentService) {
        this.contentService = contentService;
    }

    public void setJbpmSpringService(JbpmSpringService jbpmSpringService) {
        this.jbpmSpringService = jbpmSpringService;
    }

    public void setAuthoringTemplateService(AuthoringTemplateService authoringTemplateService) {
        this.authoringTemplateService = authoringTemplateService;
    }

    public void setUserService(UserService userService) {
        this.userService = userService;
    }

    public void setJcrContent(IJcrContent jcrContent) {
        this.jcrContent = jcrContent;
    }

    public void crawlContent() {
        List<AnnouncementCategory> announcementCategories = announcementCategoryService.findProperty("status", Constants.CRAWLER_NOT_START);
        if (announcementCategories.size() > 0) {
            try{
                AnnouncementCategory announcementCategory = announcementCategories.get(0);
                announcementCategory.setStatus(Constants.CRAWLER_IN_PROGRESS);
                announcementCategoryService.update(announcementCategory);
                AuthoringTemplate authoringTemplate = authoringTemplateService.findByCode("thong-bao");

                com.banvien.portal.vms.xml.authoringtemplate.AuthoringTemplate authoringTemplateXML = AuthoringTemplateUtil.parseXML(authoringTemplate.getTemplateContent());


                ICrawler crawler = new AnnouncementCrawler(announcementCategory.getUrl(), authoringTemplateXML, announcementCategory.getFromDate());
                List<ContentDTO> contentDTOs = crawler.extractContents();
                User onlineUser = userService.findByUserName(username);
                Long[] departmentIDs = new Long[1];
                if (announcementCategory.getDepartmentID() != null) {
                    departmentIDs[0] = announcementCategory.getDepartmentID();
                }
                if (contentDTOs != null && contentDTOs.size() > 0) {
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
                        contentBean.setDepartmentIDs(departmentIDs);
                        content = contentService.saveItem(contentBean);

                        JbpmUtils.startProcess(jbpmSpringService, onlineUser, content.getContentID());
                        String transition = "accept";
                        if(onlineUser.getUserGroup() == null || onlineUser.getUserGroup().getCode().equals(Constants.GROUP_AUTHOR)){
                            transition = "approve";
                        }
                        JbpmUtils.runProcess(jbpmSpringService, contentService, onlineUser, content, transition, content.getModifiedDate());
                    }
                }
                announcementCategory.setStatus(Constants.CRAWLER_DONE);
                announcementCategoryService.update(announcementCategory);
            }catch (Exception e) {

            }
        }

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

}
