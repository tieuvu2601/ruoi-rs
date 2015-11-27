package com.banvien.portal.vms.bean;

import java.sql.Timestamp;
import java.util.List;

import com.banvien.portal.vms.dto.ReportDTO;

public class ReportBean extends AbstractBean<ReportDTO>{
	
	public ReportBean(){
		this.pojo = new ReportDTO();
	}
	
	public Timestamp getToDate() {
		return toDate;
	}

	public void setToDate(Timestamp toDate) {
		this.toDate = toDate;
	}

	public Timestamp getFromDate() {
		return fromDate;
	}

	public void setFromDate(Timestamp fromDate) {
		this.fromDate = fromDate;
	}

	public Long getDepartmentID() {
		return departmentID;
	}

	public void setDepartmentID(Long departmentID) {
		this.departmentID = departmentID;
	}
	
	public Integer getStatus() {
		return status;
	}

	public void setStatus(Integer status) {
		this.status = status;
	}

	public Integer getTop() {
		return top;
	}

	public void setTop(Integer top) {
		this.top = top;
	}
	
	public List<ReportDTO> getReportDTOs() {
		return reportDTOs;
	}

	public void setReportDTOs(List<ReportDTO> reportDTOs) {
		this.reportDTOs = reportDTOs;
	}

	private List<ReportDTO> reportDTOs;

	private Integer top;
	
	private Integer status; 

	private Timestamp fromDate;

    private Timestamp toDate;
    
    private Long departmentID;
}
