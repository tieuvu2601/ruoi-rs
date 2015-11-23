package com.banvien.portal.vms.service;

import com.banvien.portal.vms.domain.Content;
import com.banvien.portal.vms.exception.DuplicateException;
import com.banvien.portal.vms.exception.InvalidXMLException;
import com.banvien.portal.vms.util.ContentItemUtil;
import com.banvien.portal.vms.util.HttpClientHelper;
import com.banvien.portal.vms.xml.contentitem.ContentItem;
import com.banvien.portal.vms.xml.contentitem.Item;
import org.apache.log4j.Logger;
import org.xml.sax.SAXException;

import javax.xml.bind.JAXBException;
import java.io.IOException;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

/**
 * Copyright (c) by Ban Vien Co., Ltd.
 * User: MBP
 * Date: 4/2/13
 * Time: 6:45 AM
 * Author: vien.nguyen@banvien.com
 */
public class UpdateAdsJob {
    private transient final Logger logger = Logger.getLogger(getClass());
    private final String PREFIX_URL = "http://www.mobifone.com.vn/portal";
    private ContentService contentService;

    public void setContentService(ContentService contentService) {
        this.contentService = contentService;
    }

    public void updateAdsJob() {
        HttpClientHelper helper = new HttpClientHelper();
        try {
            String content = helper.get("http://www.mobifone.com.vn/portal/vn/");
            String idBanner = "id=\"Banner\"";
            String idMain = "id=\"main\"";
            int indexBanner = content.indexOf(idBanner);
            int indexMain = content.indexOf(idMain);
            content = content.substring(indexBanner, indexMain);
            String[] arrayContent = content.split("\r\n");
            List<String> resultContent = new ArrayList<String>();

            //remove comment and not contains .swf
            for(String line : arrayContent) {
                if(!line.contains("//") && line.contains(".swf")) {
                    line = line.substring(line.indexOf("../"), line.indexOf("\");"));
                    line = line.substring(2, line.indexOf(".swf"));
                    line = PREFIX_URL + line;
                    line = line + ".swf";
                    resultContent.add(line);
                }
            }
            List<Content> contentList = contentService.findByAuthoringTemplate("quang-cao-vms", 0, 1);
            if(contentList != null && contentList.size() > 0 && resultContent != null && resultContent.size() > 0) {
                Content contentObj = contentList.get(0);
                ContentItem contentItem = ContentItemUtil.parseXML(contentObj.getXmlData());
                for(Item item: contentItem.getItems().getItem()) {
                    if(item.getItemKey().equals("mainFlash")) {
                        item.getItemValue().set(0, resultContent.get(0));
                    } else if (item.getItemKey().equals("flashUrls")) {
                        item.getItemValue().clear();
                        for (int i = 1; i < resultContent.size(); i++) {
                            item.getItemValue().add(resultContent.get(i));
                        }

                    }
                }
                contentObj.setModifiedDate(new Timestamp(System.currentTimeMillis()));
                contentObj.setXmlData(ContentItemUtil.bean2Xml(contentItem));
                contentService.update(contentObj);
            }

        } catch (IOException e) {
            logger.error(e.getMessage());
        } catch (SAXException e) {
            logger.error(e.getMessage());
        } catch (InvalidXMLException e) {
            logger.error(e.getMessage());
        } catch (JAXBException e) {
            logger.error(e.getMessage());
        } catch (DuplicateException e) {
            logger.error(e.getMessage());
        }
    }
}
