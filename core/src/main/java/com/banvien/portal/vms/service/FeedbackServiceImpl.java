package com.banvien.portal.vms.service;

import com.banvien.portal.vms.dao.DepartmentDAO;
import com.banvien.portal.vms.dao.FeedbackDAO;
import com.banvien.portal.vms.dao.GenericDAO;
import com.banvien.portal.vms.dao.SmsDAO;
import com.banvien.portal.vms.domain.Department;
import com.banvien.portal.vms.domain.Feedback;
import com.banvien.portal.vms.domain.Sms;
import com.banvien.portal.vms.domain.User;
import com.banvien.portal.vms.exception.DuplicateException;
import com.banvien.portal.vms.util.Constants;
import com.banvien.portal.vms.util.MyStringUtil;
import org.apache.commons.lang.StringUtils;

import java.sql.Timestamp;

/**
 * Copyright (c) by Ban Vien Co., Ltd.
 * User: MBP
 * Date: 4/25/13
 * Time: 12:15 AM
 * Author: vien.nguyen@banvien.com
 */
public class FeedbackServiceImpl extends GenericServiceImpl<Feedback, Long> implements FeedbackService {
    private FeedbackDAO feedbackDAO;

    private SmsDAO smsDAO;

    private DepartmentDAO departmentDAO;

    public void setFeedbackDAO(FeedbackDAO feedbackDAO) {
        this.feedbackDAO = feedbackDAO;
    }

    public void setSmsDAO(SmsDAO smsDAO) {
        this.smsDAO = smsDAO;
    }

    public void setDepartmentDAO(DepartmentDAO departmentDAO) {
        this.departmentDAO = departmentDAO;
    }

    @Override
    protected GenericDAO<Feedback, Long> getGenericDAO() {
        return feedbackDAO;
    }

    @Override
    public Integer deleteItems(String[] checkList) {
        Integer res = 0;
        for (String id : checkList) {
            feedbackDAO.delete(Long.valueOf(id));
            res++;
        }
        return res;
    }

    @Override
    public void saveItem(Feedback feedback) throws DuplicateException {
        feedback.setCreatedDate(new Timestamp(System.currentTimeMillis()));
        feedback.setStatus(Constants.FEEDBACK_NEW);
        feedback = feedbackDAO.save(feedback);

        Department department = departmentDAO.findById(feedback.getDepartment().getDepartmentID(), false);
        if (StringUtils.isNotBlank(department.getMobile())) {
            String phone = department.getMobile();
            Sms sms = new Sms();
            while(phone.startsWith("0")){
                phone = phone.substring(1);
            }
            sms.setFeedback(feedback);
            sms.setMobileNumber(phone);
            sms.setCreatedDate(new Timestamp(System.currentTimeMillis()));
            sms.setStatus(Constants.PENDING);
            sms.setSmsContent("Ban co yeu cau moi can xu ly [" + MyStringUtil.removeDiacritic(feedback.getTitle()) + "]");
            smsDAO.save(sms);
        }

    }
}
