package com.banvien.portal.vms.webapp.controller.admin;

import java.io.File;
import java.sql.Date;
import java.sql.Timestamp;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.banvien.portal.vms.domain.Department;
import com.banvien.portal.vms.dto.CellDataType;
import com.banvien.portal.vms.dto.CellValue;
import com.banvien.portal.vms.util.ExcelUtil;
import jxl.Workbook;
import jxl.write.*;
import org.apache.commons.lang.StringUtils;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.support.ApplicationObjectSupport;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.banvien.portal.vms.bean.ReportBean;
import com.banvien.portal.vms.domain.Content;
import com.banvien.portal.vms.dto.ReportDTO;
import com.banvien.portal.vms.editor.CustomDateEditor;
import com.banvien.portal.vms.exception.ObjectNotFoundException;
import com.banvien.portal.vms.service.ContentService;
import com.banvien.portal.vms.service.DepartmentService;
import com.banvien.portal.vms.service.ReportService;
import com.banvien.portal.vms.util.Constants;
import com.banvien.portal.vms.util.RequestUtil;

@Controller
public class ReportController extends ApplicationObjectSupport {
	
	private transient final Logger logger = Logger.getLogger(getClass());
	
	@Autowired
	private ReportService reportService;
	
	@Autowired
	private DepartmentService departmentService;
	
	@Autowired
	private ContentService contentService;
	
	@InitBinder
    public void initBinder(WebDataBinder binder) {
    	binder.registerCustomEditor(Date.class, new CustomDateEditor());
        binder.registerCustomEditor(Timestamp.class, new CustomDateEditor("dd/MM/yyyy"));
	}
	
	@RequestMapping("/admin/report/posttime.html")
	public ModelAndView postTimeReport(@ModelAttribute(Constants.FORM_MODEL_KEY) ReportBean bean, HttpServletRequest request){
		ModelAndView mav = new ModelAndView("/admin/report/posttime");
		String crudaction = bean.getCrudaction();
		RequestUtil.initSearchBean(request, bean);
		if(!StringUtils.isEmpty(crudaction) && crudaction.equals("do-report")){
			Object[] objs = reportService.reportByPostTime(bean);
			bean.setListResult((List<ReportDTO>)objs[1]);
			bean.setTotalItems(Integer.valueOf(objs[0].toString()));
		}
		mav.addObject(Constants.LIST_MODEL_KEY, bean);
		return mav;
	}

    @RequestMapping("/admin/report/export/posttime.html")
	public void exportPostTimeReport(ReportBean bean, HttpServletRequest request, HttpServletResponse response){
        bean.setFirstItem(0);
        bean.setMaxPageItems(999999);
		Object[] objs = reportService.reportByPostTime(bean);
        try{
            String outputFileName = "/files/temp/thongkebaiviet" + System.currentTimeMillis() + ".xls";
            String reportTemplate = request.getSession().getServletContext().getRealPath("/files/reporttemplate/baocaodangbaitheothoigian.xls");
            String export2FileName = request.getSession().getServletContext().getRealPath(outputFileName);

            Workbook templateWorkbook = Workbook.getWorkbook(new File(reportTemplate));
            WritableWorkbook workbook = Workbook.createWorkbook(new File(export2FileName), templateWorkbook);
            WritableSheet sheet = workbook.getSheet(0);

            //Fill in report filter
            if (bean.getFromDate() != null) {
                Date from = new Date(bean.getFromDate().getTime());
                DateFormat customDateFormat = new DateFormat ("dd/MMM/yyyy");
                WritableCellFormat dateFormat = new WritableCellFormat (customDateFormat);
                DateTime dateCellFrom = new DateTime(3, 1, from, dateFormat);
                sheet.addCell(dateCellFrom);
            }

            if (bean.getToDate() != null) {
                Date from = new Date(bean.getToDate().getTime());
                DateFormat customDateFormat = new DateFormat ("dd/MMM/yyyy");
                WritableCellFormat dateFormat = new WritableCellFormat (customDateFormat);
                DateTime dateCellFrom = new DateTime(5, 1, from, dateFormat);
                sheet.addCell(dateCellFrom);
            }

            int startRow = 3;
            List<ReportDTO> items = (List<ReportDTO>)objs[1];
            String appURL = RequestUtil.getAppURL(request);
            for (ReportDTO reportDTO : items) {
                CellValue[] cellValues = toCellValue4PostTimeReport(reportDTO, appURL, startRow - 2);
                ExcelUtil.addRow(sheet, startRow, cellValues);
                startRow++;
            }
            workbook.write();
            workbook.close();

            response.sendRedirect(request.getSession().getServletContext().getContextPath() + outputFileName);
        }catch (Exception ex) {
            ex.printStackTrace();
        }
	}

    private CellValue[] toCellValue4PostTimeReport(ReportDTO reportDTO, String appURL, int rowIndex) {
        return new CellValue[]{
                new CellValue(CellDataType.INT, rowIndex),
                new CellValue(CellDataType.STRING, reportDTO.getTitle()),
                new CellValue(CellDataType.STRING, appURL + "/admin/content/view.html?pojo.contentID=" + reportDTO.getContentID()),
                new CellValue(CellDataType.STRING, reportDTO.getAuthor()),
                new CellValue(CellDataType.INT, reportDTO.getViews() != null ? Integer.valueOf(reportDTO.getViews().toString()) : 0),
                new CellValue(CellDataType.INT, reportDTO.getLikes() != null ? Integer.valueOf(reportDTO.getLikes().toString()) : 0),
                new CellValue(CellDataType.INT, reportDTO.getComments() != null ? Integer.valueOf(reportDTO.getComments().toString()) : 0),
                new CellValue(CellDataType.DATE, reportDTO.getCreatedDate()),
                new CellValue(CellDataType.DATE, reportDTO.getPublishedDate())

        };
    }

    @RequestMapping("/admin/report/department.html")
	public ModelAndView departmentReport(@ModelAttribute(Constants.FORM_MODEL_KEY) ReportBean bean, HttpServletRequest request){
		ModelAndView mav = new ModelAndView("/admin/report/department");
		String crudaction = bean.getCrudaction();
		RequestUtil.initSearchBean(request, bean);
		if(!StringUtils.isEmpty(crudaction) && crudaction.equals("do-report")){
			Object[] objs = reportService.reportByDepartment(bean);
			bean.setListResult((List<ReportDTO>)objs[1]);
			bean.setTotalItems(Integer.valueOf(objs[0].toString()));
		}
		mav.addObject(Constants.LIST_MODEL_KEY, bean);
		mav.addObject("departments", departmentService.findAll());
		return mav;
	}

    @RequestMapping("/admin/report/export/department.html")
	public void exportDepartmentReport(ReportBean bean, HttpServletRequest request, HttpServletResponse response){
        bean.setFirstItem(0);
        bean.setMaxPageItems(999999);
		Object[] objs = reportService.reportByDepartment(bean);
        try{
            String outputFileName = "/files/temp/thong_ke_bai_viet_theo_phong_ban_" + System.currentTimeMillis() + ".xls";
            String reportTemplate = request.getSession().getServletContext().getRealPath("/files/reporttemplate/baocaodangbaitheophongban.xls");
            String export2FileName = request.getSession().getServletContext().getRealPath(outputFileName);

            Workbook templateWorkbook = Workbook.getWorkbook(new File(reportTemplate));
            WritableWorkbook workbook = Workbook.createWorkbook(new File(export2FileName), templateWorkbook);
            WritableSheet sheet = workbook.getSheet(0);

            //Fill in report filter
            if (bean.getDepartmentID() != null) {
                Department department = departmentService.findById(bean.getDepartmentID());
                Label label = new Label(3, 1, department.getName());
                sheet.addCell(label);
            }
            if (bean.getStatus() != null) {
                String statusText = "";
                if (bean.getStatus() == 1) {
                    statusText = getMessageSourceAccessor().getMessage("content.published");
                }else if (bean.getStatus() == 0) {
                    statusText = getMessageSourceAccessor().getMessage("content.waiting");
                }else if (bean.getStatus() == -1) {
                    statusText = getMessageSourceAccessor().getMessage("content.reject.option");
                }
                Label label = new Label(5, 1, statusText);
                sheet.addCell(label);
            }
            if (bean.getFromDate() != null) {
                Date from = new Date(bean.getFromDate().getTime());
                DateFormat customDateFormat = new DateFormat ("dd/MMM/yyyy");
                WritableCellFormat dateFormat = new WritableCellFormat (customDateFormat);
                DateTime dateCellFrom = new DateTime(3, 2, from, dateFormat);
                sheet.addCell(dateCellFrom);
            }

            if (bean.getToDate() != null) {
                Date from = new Date(bean.getToDate().getTime());
                DateFormat customDateFormat = new DateFormat ("dd/MMM/yyyy");
                WritableCellFormat dateFormat = new WritableCellFormat (customDateFormat);
                DateTime dateCellFrom = new DateTime(5, 2, from, dateFormat);
                sheet.addCell(dateCellFrom);
            }

            int startRow = 4;
            List<ReportDTO> items = (List<ReportDTO>)objs[1];
            String appURL = RequestUtil.getAppURL(request);
            for (ReportDTO reportDTO : items) {
                CellValue[] cellValues = toCellValue4PostTimeReport(reportDTO, appURL, startRow - 3);
                ExcelUtil.addRow(sheet, startRow, cellValues);
                startRow++;
            }
            workbook.write();
            workbook.close();

            response.sendRedirect(request.getSession().getServletContext().getContextPath() + outputFileName);
        }catch (Exception ex) {
            ex.printStackTrace();
        }
	}
	
	@RequestMapping("/admin/report/accessview.html")
	public ModelAndView accessViewReport(@ModelAttribute(Constants.FORM_MODEL_KEY) ReportBean bean, HttpServletRequest request){
		ModelAndView mav = new ModelAndView("/admin/report/accessview");
		String crudaction = bean.getCrudaction();
		RequestUtil.initSearchBean(request, bean);
		if(!StringUtils.isEmpty(crudaction) && crudaction.equals("do-report")){
			Object[] objs = reportService.reportByAccessView(bean);
			bean.setListResult((List<ReportDTO>)objs[1]);
			bean.setTotalItems(Integer.valueOf(objs[0].toString()));
		}
		mav.addObject(Constants.LIST_MODEL_KEY, bean);
		return mav;
	}
	@RequestMapping("/admin/report/export/accessview.html")
	public void exportAccessViewReport(ReportBean bean, HttpServletRequest request, HttpServletResponse response){
        bean.setFirstItem(0);
        bean.setMaxPageItems(999999);
		Object[] objs = reportService.reportByAccessView(bean);
        try{
            String outputFileName = "/files/temp/thongkebaiviet" + System.currentTimeMillis() + ".xls";
            String reportTemplate = request.getSession().getServletContext().getRealPath("/files/reporttemplate/baocaodangbaitheoluotxem.xls");
            String export2FileName = request.getSession().getServletContext().getRealPath(outputFileName);

            Workbook templateWorkbook = Workbook.getWorkbook(new File(reportTemplate));
            WritableWorkbook workbook = Workbook.createWorkbook(new File(export2FileName), templateWorkbook);
            WritableSheet sheet = workbook.getSheet(0);

            //Fill in report filter
            if (bean.getFromDate() != null) {
                Date from = new Date(bean.getFromDate().getTime());
                DateFormat customDateFormat = new DateFormat ("dd/MMM/yyyy");
                WritableCellFormat dateFormat = new WritableCellFormat (customDateFormat);
                DateTime dateCellFrom = new DateTime(3, 1, from, dateFormat);
                sheet.addCell(dateCellFrom);
            }

            if (bean.getToDate() != null) {
                Date from = new Date(bean.getToDate().getTime());
                DateFormat customDateFormat = new DateFormat ("dd/MMM/yyyy");
                WritableCellFormat dateFormat = new WritableCellFormat (customDateFormat);
                DateTime dateCellFrom = new DateTime(5, 1, from, dateFormat);
                sheet.addCell(dateCellFrom);
            }

            int startRow = 3;
            List<ReportDTO> items = (List<ReportDTO>)objs[1];
            String appURL = RequestUtil.getAppURL(request);
            for (ReportDTO reportDTO : items) {
                CellValue[] cellValues = toCellValue4PostTimeReport(reportDTO, appURL, startRow - 2);
                ExcelUtil.addRow(sheet, startRow, cellValues);
                startRow++;
            }
            workbook.write();
            workbook.close();

            response.sendRedirect(request.getSession().getServletContext().getContextPath() + outputFileName);
        }catch (Exception ex) {
            ex.printStackTrace();
        }
	}
	@RequestMapping("/admin/report/userlike.html")
	public ModelAndView userLikeReport(@ModelAttribute(Constants.FORM_MODEL_KEY) ReportBean bean, HttpServletRequest request){
		ModelAndView mav = new ModelAndView("/admin/report/userlike");
		String crudaction = bean.getCrudaction();
		RequestUtil.initSearchBean(request, bean);
		if(!StringUtils.isEmpty(crudaction) && crudaction.equals("do-report")){
			Object[] objs = reportService.reportByUserLike(bean);
			bean.setListResult((List<ReportDTO>)objs[1]);
			bean.setTotalItems(Integer.valueOf(objs[0].toString()));
		}
		mav.addObject(Constants.LIST_MODEL_KEY, bean);
		return mav;
	}

    @RequestMapping("/admin/report/export/userlike.html")
	public void exportUserLikeReport(ReportBean bean, HttpServletRequest request, HttpServletResponse response){
        bean.setFirstItem(0);
        bean.setMaxPageItems(999999);
		Object[] objs = reportService.reportByUserLike(bean);
        try{
            String outputFileName = "/files/temp/thongkebaiviet" + System.currentTimeMillis() + ".xls";
            String reportTemplate = request.getSession().getServletContext().getRealPath("/files/reporttemplate/baocaodangbaitheoyeuthich.xls");
            String export2FileName = request.getSession().getServletContext().getRealPath(outputFileName);

            Workbook templateWorkbook = Workbook.getWorkbook(new File(reportTemplate));
            WritableWorkbook workbook = Workbook.createWorkbook(new File(export2FileName), templateWorkbook);
            WritableSheet sheet = workbook.getSheet(0);

            //Fill in report filter
            if (bean.getFromDate() != null) {
                Date from = new Date(bean.getFromDate().getTime());
                DateFormat customDateFormat = new DateFormat ("dd/MMM/yyyy");
                WritableCellFormat dateFormat = new WritableCellFormat (customDateFormat);
                DateTime dateCellFrom = new DateTime(3, 1, from, dateFormat);
                sheet.addCell(dateCellFrom);
            }

            if (bean.getToDate() != null) {
                Date from = new Date(bean.getToDate().getTime());
                DateFormat customDateFormat = new DateFormat ("dd/MMM/yyyy");
                WritableCellFormat dateFormat = new WritableCellFormat (customDateFormat);
                DateTime dateCellFrom = new DateTime(5, 1, from, dateFormat);
                sheet.addCell(dateCellFrom);
            }

            int startRow = 3;
            List<ReportDTO> items = (List<ReportDTO>)objs[1];
            String appURL = RequestUtil.getAppURL(request);
            for (ReportDTO reportDTO : items) {
                CellValue[] cellValues = toCellValue4PostTimeReport(reportDTO, appURL, startRow - 2);
                ExcelUtil.addRow(sheet, startRow, cellValues);
                startRow++;
            }
            workbook.write();
            workbook.close();

            response.sendRedirect(request.getSession().getServletContext().getContextPath() + outputFileName);
        }catch (Exception ex) {
            ex.printStackTrace();
        }
	}
	
	@RequestMapping("/admin/report/comment.html")
	public ModelAndView commentReport(@ModelAttribute(Constants.FORM_MODEL_KEY) ReportBean bean, HttpServletRequest request){
		ModelAndView mav = new ModelAndView("/admin/report/comment");
		String crudaction = bean.getCrudaction();
		RequestUtil.initSearchBean(request, bean);
		if(!StringUtils.isEmpty(crudaction) && crudaction.equals("do-report")){
			Object[] objs = reportService.reportByComment(bean);
			bean.setListResult((List<ReportDTO>)objs[1]);
			bean.setTotalItems(Integer.valueOf(objs[0].toString()));
		}
		mav.addObject(Constants.LIST_MODEL_KEY, bean);
		return mav;
	}

    @RequestMapping("/admin/report/export/comment.html")
	public void exportCommentReport(ReportBean bean, HttpServletRequest request, HttpServletResponse response){
        bean.setFirstItem(0);
        bean.setMaxPageItems(999999);
		Object[] objs = reportService.reportByComment(bean);
        try{
            String outputFileName = "/files/temp/thongkebaiviet" + System.currentTimeMillis() + ".xls";
            String reportTemplate = request.getSession().getServletContext().getRealPath("/files/reporttemplate/baocaodangbaitheobinhluan.xls");
            String export2FileName = request.getSession().getServletContext().getRealPath(outputFileName);

            Workbook templateWorkbook = Workbook.getWorkbook(new File(reportTemplate));
            WritableWorkbook workbook = Workbook.createWorkbook(new File(export2FileName), templateWorkbook);
            WritableSheet sheet = workbook.getSheet(0);

            //Fill in report filter
            if (bean.getFromDate() != null) {
                Date from = new Date(bean.getFromDate().getTime());
                DateFormat customDateFormat = new DateFormat ("dd/MMM/yyyy");
                WritableCellFormat dateFormat = new WritableCellFormat (customDateFormat);
                DateTime dateCellFrom = new DateTime(3, 1, from, dateFormat);
                sheet.addCell(dateCellFrom);
            }

            if (bean.getToDate() != null) {
                Date from = new Date(bean.getToDate().getTime());
                DateFormat customDateFormat = new DateFormat ("dd/MMM/yyyy");
                WritableCellFormat dateFormat = new WritableCellFormat (customDateFormat);
                DateTime dateCellFrom = new DateTime(5, 1, from, dateFormat);
                sheet.addCell(dateCellFrom);
            }

            int startRow = 3;
            List<ReportDTO> items = (List<ReportDTO>)objs[1];
            String appURL = RequestUtil.getAppURL(request);
            for (ReportDTO reportDTO : items) {
                CellValue[] cellValues = toCellValue4PostTimeReport(reportDTO, appURL, startRow - 2);
                ExcelUtil.addRow(sheet, startRow, cellValues);
                startRow++;
            }
            workbook.write();
            workbook.close();

            response.sendRedirect(request.getSession().getServletContext().getContextPath() + outputFileName);
        }catch (Exception ex) {
            ex.printStackTrace();
        }
	}
}
