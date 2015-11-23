package com.banvien.portal.vms.service;

import com.banvien.portal.vms.dao.GenericDAO;
import com.banvien.portal.vms.dto.ThreadDTO;
import com.sun.syndication.feed.synd.SyndEntry;
import com.sun.syndication.feed.synd.SyndFeed;
import com.sun.syndication.io.SyndFeedInput;
import org.apache.log4j.Logger;
import org.apache.tools.ant.util.DateUtils;

import java.net.URL;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

/**
 * Copyright (c) by Ban Vien Co., Ltd.
 * User: MBP
 * Date: 11/13/12
 * Time: 4:59 PM
 * Author: vien.nguyen@banvien.com
 */
public class ThreadMobi8ServiceImpl extends GenericServiceImpl<ThreadDTO, Long> implements ThreadMobi8Service {
    private transient final Logger logger = Logger.getLogger(getClass());

    private String rss;

    public void setRss(String rss) {
        this.rss = rss;
    }

    @Override
    protected GenericDAO<ThreadDTO, Long> getGenericDAO() {
        return null;  //To change body of implemented methods use File | Settings | File Templates.
    }


    @Override
    public List<ThreadDTO> findThreadHotOnForum() throws Exception
    {
        List<ThreadDTO> lstThread = new ArrayList<ThreadDTO>();
        URL url  = new URL(rss);
        com.sun.syndication.io.XmlReader reader = null;

        try
        {
            reader = new com.sun.syndication.io.XmlReader(url);
            SyndFeed feed = new SyndFeedInput().build(reader);

            for (Iterator i = feed.getEntries().iterator(); i.hasNext();)
            {
                SyndEntry entry = (SyndEntry) i.next();
                ThreadDTO threadDTO = new ThreadDTO();

                String strInformation = entry.getTitle();
                StringBuffer temp = new StringBuffer("#");
                String arrInformation[] = strInformation.split(temp.toString());
                threadDTO.setTitle(arrInformation[0]);
                threadDTO.setAvatar(arrInformation[1]);
                threadDTO.setViewCount(arrInformation[2]);
                threadDTO.setReplyCount(arrInformation[3]);
                threadDTO.setLink(entry.getLink());
                threadDTO.setPubDate(DateUtils.format(entry.getPublishedDate(), "dd/MM/yyyy HH:mm"));

                lstThread.add(threadDTO);
            }
        }catch (Exception e) {

        }
        finally
        {
            if (reader != null)
                    reader.close();
        }
        return lstThread;
    }


}
