package com.banvien.portal.vms.webapp.controller.admin;

import com.banvien.portal.vms.bean.PageBean;
import com.banvien.portal.vms.domain.Page;
import com.banvien.portal.vms.exception.ObjectNotFoundException;
import com.banvien.portal.vms.service.PageService;
import com.banvien.portal.vms.util.Constants;
import com.banvien.portal.vms.util.PageXMLUtil;
import com.banvien.portal.vms.util.RequestUtil;
import com.banvien.portal.vms.webapp.validator.PageManagementValidator;
import com.banvien.portal.vms.xml.page.Column;
import com.banvien.portal.vms.xml.page.Columns;
import com.banvien.portal.vms.xml.page.Row;
import com.banvien.portal.vms.xml.page.Rows;
import org.apache.commons.lang.StringUtils;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.support.ApplicationObjectSupport;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import java.sql.Timestamp;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Created with IntelliJ IDEA.
 * User: NhuKhang
 * Date: 10/6/12
 * Time: 10:57 AM
 */
@Controller
public class PageManagementController extends ApplicationObjectSupport {
	private transient final Logger logger = Logger.getLogger(getClass());

    @Autowired
    private PageService pageService;

    @Autowired
    private PageManagementValidator pageValidator;


    @RequestMapping("/admin/page/edit.html")
    public ModelAndView edit(@ModelAttribute(Constants.FORM_MODEL_KEY) PageBean bean, BindingResult bindingResult, HttpServletRequest request){
        ModelAndView mav = new ModelAndView("/admin/page/edit");
        String crudaction = bean.getCrudaction();
        Page pojo = bean.getPojo();
        if(StringUtils.isNotBlank(crudaction) && crudaction.equals("insert-update")) {
            try{
                populateContentCommand2Bean(request, bean);
                pageValidator.validate(bean, bindingResult);
                if(!bindingResult.hasErrors()){
                    String pageXML = PageXMLUtil.bean2Xml(bean.getPageXML());
                    pojo.setXmlData(pageXML);
                    if(pojo.getPageID() != null && pojo.getPageID() > 0 ){
                        this.pageService.updateItem(pojo);
                        mav.addObject("messageResponse", this.getMessageSourceAccessor().getMessage("database.update.successful"));
                    }
                    else
                    {
                        bean.getPojo().setCreatedDate(new Timestamp(System.currentTimeMillis()));
                        bean.getPojo().setModifiedDate(new Timestamp(System.currentTimeMillis()));
                        this.pageService.save(bean.getPojo());
                  		mav.addObject("messageResponse", this.getMessageSourceAccessor().getMessage("database.add.successful"));
                    }
                    mav.addObject("success", true);
                }
            }catch(ObjectNotFoundException oe){
                logger.error(oe.getMessage(), oe);
                mav.addObject("messageResponse", this.getMessageSourceAccessor().getMessage("general.exception.msg"));
            }catch(Exception e) {
                logger.error(e.getMessage(), e);
                mav.addObject("messageResponse", this.getMessageSourceAccessor().getMessage("general.exception.msg"));
            }
        }
        if(!bindingResult.hasErrors() && pojo.getPageID() != null){
            try{
                bean.setPojo(pageService.findById(pojo.getPageID()));
            }catch (ObjectNotFoundException ex) {
                logger.error(ex.getMessage(), ex);
                mav.addObject("messageResponse", this.getMessageSourceAccessor().getMessage("database.exception.keynotfound"));
            }
        }
        mav.addObject(Constants.FORM_MODEL_KEY, bean);
        return mav;
    }

    private void populateContentCommand2Bean(HttpServletRequest request, PageBean bean) {
        /**
         * TODO: For home
         */
        com.banvien.portal.vms.xml.page.Page page = new com.banvien.portal.vms.xml.page.Page();
        page.setCode(bean.getPojo().getCode());
        page.setTitle(bean.getPojo().getTitle());
        page.setLayout(bean.getLayout());
        page.setTheme(bean.getTheme());

        page.setColumns(new Columns());

        //Left
        Column left = new Column();
        left.setRows(new Rows());

        Row row1 = new Row();
        Column hotNews = new Column();
        hotNews.setSkin("hot_news_skin");
        hotNews.setDisplayItem(6);
        hotNews.setTitle("Hot News");
        hotNews.setRenderingTemplate("hot-news");
        row1.setColumns(new Columns());
        row1.getColumns().getColumn().add(hotNews);
        left.getRows().getRow().add(row1);


        Row row2 = new Row();
        Column left1 = new Column();
        left1.setRows(new Rows());

        Row tin_cong_ty = generateCell("tin-cong-ty", "small_blue_skin", "Tin cong ty", 3, "news-vertical-scroll");
        left1.getRows().getRow().add(tin_cong_ty);

        Row kinh_doanh = generateCell("tin-kinh-doanh", "small_red_skin", "Tin kinh doanh", 3, "news-vertical-scroll");
        left1.getRows().getRow().add(kinh_doanh);

        Row cong_nghe_ky_thuat = generateCell("cong-nghe-ky-thuat", "small_red_skin", "Cong nghe ky thuat", 3, "news-vertical-scroll");
        left1.getRows().getRow().add(cong_nghe_ky_thuat);

        Row cham_soc_khach_hang = generateCell("cham-soc-khach-hang", "small_red_skin", "Cham soc khach hang", 3, "news-vertical-scroll");
        left1.getRows().getRow().add(cham_soc_khach_hang);


        Column right1 = new Column();
        right1.setRows(new Rows());

        Row giai_tri = generateCell("tin-giai-tri", "giaitri_skin", "Giai tri", 3, "news-horizontal-scroll");
        right1.getRows().getRow().add(giai_tri);

        Row chan_dung = generateCell("chan-dung", "giaitri_skin", "Chan dung", 3, "chan-dung-template");
        right1.getRows().getRow().add(chan_dung);

        Row mobi_8 = generateCell("mobi_8", "giaitri_skin", "Mobi 8", 3, "mobi8-template");
        right1.getRows().getRow().add(mobi_8);

        Row cong_doan = generateCell("cong-doan", "giaitri_skin", "Cong doan", 3, "news-horizontal-scroll");
        right1.getRows().getRow().add(cong_doan);

        Row dang_uy = generateCell("dang-uy", "medium_blue_skin", "Dang uy", 4, "news-dang-uy");
        right1.getRows().getRow().add(dang_uy);

        row2.setColumns(new Columns());
        row2.getColumns().getColumn().add(left1);

        row2.getColumns().getColumn().add(right1);
        left.getRows().getRow().add(row2);
        page.getColumns().getColumn().add(left);
        //Right
        Column right = new Column();

        right.setRows(new Rows());
        Row quang_cao = generateCell("quang-cao", "no_skin", "Quang Cao", 1, "quang-cao-template");
        right.getRows().getRow().add(quang_cao);
        Row ungdung = generateCell("ung_dung", "no_skin", "Ung dung", -1, "ung-dung-template");
        right.getRows().getRow().add(ungdung);
        Row thong_bao = generateCell("thong_bao", "thongbao_skin", "Thong bao", 5, "thong-bao-template");
        right.getRows().getRow().add(thong_bao);
        Row collaborate_link = generateCell("cong-tac", "no_skin", "Cong tac", -1, "cong-tac-template");
        right.getRows().getRow().add(collaborate_link);
        Row tai_lieu = generateCell("cong-tac", "document_skin", "Tai lieu tham khao", 10, "tai-lieu-template");
        right.getRows().getRow().add(tai_lieu);
        Row online_widget = generateCell("online-widget", "no-skin", "Thong ke truy cap", 10, "online-template");
        right.getRows().getRow().add(online_widget);


        page.getColumns().getColumn().add(right);
        bean.setPageXML(page);

    }

    private Row generateCell(String category, String skin, String title, Integer displayItem, String renderingTemplate) {
        Row row = new Row();
        Column column = new Column();
        column.setCategory(category);
        column.setSkin(skin);
        column.setTitle(title);
        column.setDisplayItem(displayItem);
        column.setRenderingTemplate(renderingTemplate);
        row.setColumns(new Columns());
        row.getColumns().getColumn().add(column);
        return row;
    }

    @RequestMapping(value={"/admin/page/list.html"})
    public ModelAndView list(PageBean bean, HttpServletRequest request) {
    	ModelAndView mav = new ModelAndView("/admin/page/list");

        if(StringUtils.isNotBlank(bean.getCrudaction()) && bean.getCrudaction().equals(Constants.ACTION_DELETE)) {
            Integer totalDeleted = 0;
            try {
                totalDeleted = pageService.deleteItems(bean.getCheckList());
            	mav.addObject("totalDeleted", totalDeleted);
                mav.addObject("messageResponse", this.getMessageSourceAccessor().getMessage("database.delete.successful", new String[]{totalDeleted.toString(), String.valueOf(bean.getCheckList().length)}));
            }catch (Exception e) {
                logger.error(e.getMessage(), e);
                mav.addObject(Constants.MESSAGE_RESPONSE_MODEL_KEY, this.getMessageSourceAccessor().getMessage("database.multipledelete.exception"));
            }
        }

        executeSearch(bean, request);
        mav.addObject(Constants.LIST_MODEL_KEY, bean);
        return mav;
    }

    private void executeSearch(PageBean bean, HttpServletRequest request) {
        RequestUtil.initSearchBean(request, bean);
        Map<String, Object> properties = new HashMap<String, Object>();
        if(StringUtils.isNotBlank(bean.getPojo().getCode())){
            properties.put("code", bean.getPojo().getCode());
        }
        if(StringUtils.isNotBlank(bean.getPojo().getTitle())){
            properties.put("title", bean.getPojo().getTitle());
        }
        Object[] results = this.pageService.searchByProperties(properties, bean.getSortExpression(), bean.getSortDirection(), bean.getFirstItem(), bean.getMaxPageItems());
        bean.setListResult((List<Page>)results[1]);
        bean.setTotalItems(Integer.valueOf(results[0].toString()));
    }
}
