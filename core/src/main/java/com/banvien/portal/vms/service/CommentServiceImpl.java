package com.banvien.portal.vms.service;

import com.banvien.portal.vms.bean.CommentBean;
import com.banvien.portal.vms.dao.CommentDAO;
import com.banvien.portal.vms.dao.GenericDAO;
import com.banvien.portal.vms.domain.Comment;
import com.banvien.portal.vms.exception.DuplicateException;
import com.banvien.portal.vms.exception.ObjectNotFoundException;
import com.banvien.portal.vms.util.Constants;
import org.apache.tools.ant.util.DateUtils;

import java.sql.Timestamp;
import java.util.*;

/**
 * Copyright (c) by Ban Vien Co., Ltd.
 * User: MBP
 * Date: 11/13/12
 * Time: 4:47 PM
 * Author: vien.nguyen@banvien.com
 */
public class CommentServiceImpl extends GenericServiceImpl<Comment, Long> implements CommentService {
    private CommentDAO commentDAO;

    public void setCommentDAO(CommentDAO commentDAO) {
        this.commentDAO = commentDAO;
    }

    @Override
    protected GenericDAO<Comment, Long> getGenericDAO() {
        return commentDAO;
    }
    
    @Override
    public void updateItem(Comment pojo) throws ObjectNotFoundException, DuplicateException {

        Comment dbItem = this.commentDAO.findByIdNoAutoCommit(pojo.getCommentID());
        if (dbItem == null) throw new ObjectNotFoundException("Not found account " + pojo.getCommentID());

        dbItem.setStatus(pojo.getStatus());
        //dbItem.setCreatedDate(dbItem.getCreatedDate());
        dbItem.setModifiedDate(new Timestamp(System.currentTimeMillis()));
        this.commentDAO.detach(dbItem);
        this.commentDAO.update(dbItem);
    }


    @Override
    public Integer deleteItems(String[] checkList) {
        Integer res = 0;
        if (checkList != null && checkList.length > 0) {
            res = checkList.length;
            for (String id : checkList) {
                commentDAO.delete(Long.parseLong(id));
            }
        }
        return res;
    }

    @Override
    public Integer updatePublishItems(String[] checkList) {
        Integer res = 0;
        if (checkList != null && checkList.length > 0) {
            //res = checkList.length;
            for (String id : checkList) {
                try
                {
                    Comment dbItem = this.commentDAO.findByIdNoAutoCommit(Long.parseLong(id));
                    if (dbItem == null) throw new ObjectNotFoundException("Not found account " + id);
                    dbItem.setStatus(Constants.COMMENT_PUBLISH);
                    dbItem.setModifiedDate(new Timestamp(System.currentTimeMillis()));
                    this.commentDAO.update(dbItem);
                    res = res + 1;
                }
                catch(Exception ex)
                {
                    //tod
                }

            }
        }
        return res;
    }

    @Override
    public Integer updateRejectItems(String[] checkList)  {
        Integer res = 0;
        if (checkList != null && checkList.length > 0) {
            //res = checkList.length;
            for (String id : checkList) {
                try
                {
                    Comment dbItem = this.commentDAO.findByIdNoAutoCommit(Long.parseLong(id));
                    if (dbItem == null) throw new ObjectNotFoundException("Not found account " + id);
                    dbItem.setStatus(Constants.COMMENT_REJECT);
                    dbItem.setModifiedDate(new Timestamp(System.currentTimeMillis()));
                    this.commentDAO.update(dbItem);
                    res = res + 1;
                }
                catch(Exception ex)
                {
                    //tod
                }

            }
        }
        return res;
    }


    @Override
    public Object[] find4Content(CommentBean commentBean) {
        Map<String, Object> properties = new HashMap<String, Object>();
        StringBuffer whereClause = new StringBuffer(" 1 = 1 ");

        if (commentBean.getPojo().getContent().getContentID() != null) {
            properties.put("content.contentID", commentBean.getPojo().getContent().getContentID());
        }
        if (commentBean.getFromDate() != null) {

            Calendar calStart = new GregorianCalendar();
            Date date = new Date(commentBean.getFromDate().getYear(), commentBean.getFromDate().getMonth(), commentBean.getFromDate().getDate());
            calStart.setTime(date);
            calStart.add(Calendar.DATE, 1);
            date = calStart.getTime();

            String datimeStr = DateUtils.format(date ,"dd-MMM-yyyy"); //df.format(now);
            whereClause.append(" AND to_date(createdDate) >= '").append(datimeStr).append("'");
        }
        if (commentBean.getToDate() != null) {
            Calendar calStart = new GregorianCalendar();
            Date date = new Date(commentBean.getToDate().getYear(), commentBean.getToDate().getMonth(), commentBean.getToDate().getDate());
            calStart.setTime(date);
            calStart.add(Calendar.DATE, 1);
            date = calStart.getTime();

            String datimeStr = DateUtils.format(date ,"dd-MMM-yyyy"); //df.format(now);
            whereClause.append(" AND to_date(createdDate) <= '").append(datimeStr).append("'");
        }

        return commentDAO.searchByProperties(properties, commentBean.getFirstItem(), commentBean.getMaxPageItems() , commentBean.getSortExpression(),commentBean.getSortDirection() ,true, whereClause.toString());
    }

    @Override
    public Object[] findApprovedCommentsByContentID(Long contentID,Integer startRow, Integer pageSize) {
        Map<String, Object> properties = new HashMap<String, Object>();
        if (contentID != null) {
            properties.put("content.contentID", contentID);
        }
        properties.put("status", Constants.COMMENT_PUBLISH);
        return commentDAO.searchByProperties(properties, startRow, pageSize, "createdDate","DESC" ,true, "");

    }
}
