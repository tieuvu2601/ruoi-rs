package com.banvien.portal.vms.taglibs;

import com.banvien.portal.vms.util.ContentItemUtil;
import com.banvien.portal.vms.xml.contentitem.ContentItem;
import com.banvien.portal.vms.xml.contentitem.Item;
import org.apache.commons.lang.StringUtils;
import java.util.HashMap;
import java.util.List;
import java.util.Map;


public class PortalTagLib {
    public static Map<String, List<String>> parseContentXML(String xml) {
        Map<String, List<String>>  res = new HashMap<String, List<String>>();
        try{
            ContentItem contentItem = ContentItemUtil.parseXML(xml);
            if (contentItem.getItems() != null && contentItem.getItems().getItem().size() > 0) {
                for (Item item : contentItem.getItems().getItem()) {
                    res.put(item.getItemKey(), item.getItemValue());
                }
            }
        }catch (Exception e) {

        }
        return res;
    }

    public static String convertStringToUrl(String input) {
        if (StringUtils.isNotBlank(input)) {
            input = input.trim().toLowerCase().replaceAll("\\s+","-");
        }
        return input;
    }

}
