package com.banvien.portal.vms.service;

import com.banvien.portal.vms.bean.ReportBean;
import com.banvien.portal.vms.domain.Content;


public interface ReportService extends GenericService<Content, Long> {
	public Object[] reportByPostTime(ReportBean bean);
	public Object[] reportByDepartment(ReportBean bean);
	public Object[] reportByAccessView(ReportBean bean);
	public Object[] reportByUserLike(ReportBean bean);
	public Object[] reportByComment(ReportBean bean);
}
