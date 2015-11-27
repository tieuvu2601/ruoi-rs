package com.banvien.portal.vms.service;

import com.banvien.portal.vms.bean.ReportBean;
import com.banvien.portal.vms.domain.ContentEntity;


public interface ReportService extends GenericService<ContentEntity, Long> {
	public Object[] reportByPostTime(ReportBean bean);
	public Object[] reportByDepartment(ReportBean bean);
	public Object[] reportByAccessView(ReportBean bean);
	public Object[] reportByUserLike(ReportBean bean);
	public Object[] reportByComment(ReportBean bean);
}
