package com.banvien.portal.vms.service;

import com.banvien.portal.vms.bean.ReportBean;
import com.banvien.portal.vms.dao.ContentDAO;
import com.banvien.portal.vms.dao.GenericDAO;
import com.banvien.portal.vms.domain.Content;

public class ReportServiceImpl extends GenericServiceImpl<Content, Long> implements ReportService {

	private ContentDAO contentDAO;
	
	@Override
	protected GenericDAO<Content, Long> getGenericDAO() {
		return contentDAO;
	}

	public void setContentDAO(ContentDAO contentDAO) {
		this.contentDAO = contentDAO;
	}

	@Override
	public Object[] reportByPostTime(ReportBean bean) {
		return contentDAO.reportByPublishedDate(bean.getFromDate(), bean.getToDate(), bean.getFirstItem(), bean.getMaxPageItems(), bean.getSortExpression(), bean.getSortDirection());
	}
    
	@Override
	public Object[] reportByDepartment(ReportBean bean) {
		return contentDAO.reportByDepartment(bean.getFromDate(), bean.getToDate(), bean.getDepartmentID(), bean.getStatus(), bean.getFirstItem(), bean.getMaxPageItems(), bean.getSortExpression(), bean.getSortDirection());
	}

	@Override
	public Object[] reportByAccessView(ReportBean bean) {
		return contentDAO.reportByAccessViewOrUserLike(bean.getFromDate(), bean.getToDate(), bean.getTop(), bean.getFirstItem(), bean.getMaxPageItems(), bean.getSortExpression(), bean.getSortDirection(), true);
	}

	@Override
	public Object[] reportByUserLike(ReportBean bean) {
		return contentDAO.reportByAccessViewOrUserLike(bean.getFromDate(), bean.getToDate(), bean.getTop(), bean.getFirstItem(), bean.getMaxPageItems(), bean.getSortExpression(), bean.getSortDirection(), false);
	}

	@Override
	public Object[] reportByComment(ReportBean bean) {
		return contentDAO.reportByComment(bean.getFromDate(), bean.getToDate(), bean.getTop(), bean.getFirstItem(), bean.getMaxPageItems(), bean.getSortExpression(), bean.getSortDirection());
	}
}
