package com.banvien.portal.vms.webapp.controller.web;

import com.banvien.portal.vms.bean.CommentBean;
import com.banvien.portal.vms.bean.TrackingBean;
import com.banvien.portal.vms.domain.*;
import com.banvien.portal.vms.dto.TrackingDTO;
import com.banvien.portal.vms.exception.DuplicateException;
import com.banvien.portal.vms.exception.ObjectNotFoundException;
import com.banvien.portal.vms.security.SecurityUtils;
import com.banvien.portal.vms.service.*;
import com.banvien.portal.vms.util.Constants;
import com.banvien.portal.vms.util.DateUtils;
import com.banvien.portal.vms.webapp.command.PageCommand;

import org.apache.commons.lang.StringUtils;
import org.apache.log4j.Logger;
import org.displaytag.tags.TableTagParameters;
import org.displaytag.util.ParamEncoder;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import java.io.File;
import java.io.PrintWriter;
import java.sql.Timestamp;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

/**
 * Created by Ban Vien Ltd.
 * User: Vien Nguyen (vien.nguyen@banvien.com)
 * Date: 11/29/12
 * Time: 6:19 AM
 */
@Controller
public class PageDetailController {
    private static final String TRACKING_CONTENT_PREFIX = "TRACKING_CONTENT_ID_";
    private transient final Logger logger = Logger.getLogger(getClass());
    @Autowired
    private ContentService contentService;

    @Autowired
    private CommentService commentService;

    @Autowired
    private TrackingService trackingService;

    @Autowired
    private AuthoringTemplateService authoringTemplateService;

    @Autowired
    private DepartmentService departmentService;

    @Autowired
    private CategoryService categoryService;

//    @RequestMapping("/detail/addComment.html")
//    public void addComment(CommentBean commentBean, HttpServletRequest request){
//        User createdUser = new User();
//        createdUser.setUserID(SecurityUtils.getLoginUserId());
//
//        commentBean.getPojo().setCreatedBy(createdUser);
//        commentBean.getPojo().setCreatedDate(new Timestamp(Calendar.getInstance().getTimeInMillis()));
//        commentBean.getPojo().setStatus(Constants.COMMENT_REJECT);
//
//        try {
//            commentService.save(commentBean.getPojo());
//        } catch (DuplicateException e) {
//            logger.error(e.getMessage());
//        }
//    }
//
//    @RequestMapping("/detail/tracking.html")
//    public void tracking(TrackingBean trackingBean, HttpServletRequest request, HttpServletResponse response){
//        Integer like = 1;
//        //get tracking by contentID in today
//        if(trackingBean.getPojo().getContent() != null && trackingBean.getPojo().getContent().getContentID() != null) {
//            String code = DateUtils.date2String(new Date(), "yyyyMMdd");
//            Tracking tracking = trackingService.findTrackingByContentIDAndCode(trackingBean.getPojo().getContent().getContentID(), code);
//            try {
//                if (request.getSession() != null && request.getSession().getAttribute(TRACKING_CONTENT_PREFIX + trackingBean.getPojo().getContent().getContentID()) == null) {
//                    if(tracking != null) { //update
//                        if(trackingBean.getIsLiked()) {
//                            if(tracking.getLikes() == null) {
//                                tracking.setLikes(0);
//                            }
//                            tracking.setLikes(tracking.getLikes() + 1);
//                        } else {
//                            tracking.setLikes(tracking.getLikes() - 1);
//                        }
//                        if(tracking.getLikes() < 0) {
//                            tracking.setLikes(0);
//                        }
//
//                        trackingService.update(tracking);
//                    }
//                    else { // add new
//                        Tracking newTracking = new Tracking();
//                        newTracking.setLikes(1);
//                        newTracking.setTrackingDate(new Timestamp(Calendar.getInstance().getTimeInMillis()));
//                        newTracking.setContent(trackingBean.getPojo().getContent());
//                        newTracking.setCode(code);
//                        trackingService.save(newTracking);
//                    }
//                    request.getSession().setAttribute(TRACKING_CONTENT_PREFIX + trackingBean.getPojo().getContent().getContentID(), "1");
//                }
//
//                TrackingDTO trackingDTO = trackingService.findTotalTrackingByContentID(trackingBean.getPojo().getContent().getContentID());
//                like = Integer.valueOf(trackingDTO.getLikes().toString());
//            } catch (Exception ex){
//                logger.error(ex.getMessage());
//            }
//        }
//        try{
//            response.setContentType("text/json; charset=UTF-8");
//			PrintWriter out = response.getWriter();
//			JSONObject object = new JSONObject();
//            object.put("success", true);
//            object.put("like", like);
//            out.print(object);
//            out.flush();
//            out.close();
//        }catch (Exception e) {
//
//        }
//    }
//
//    @RequestMapping("/detail.html")
//    public ModelAndView viewPage(@ModelAttribute PageCommand pageCommand, HttpServletRequest request){
//    	String viewName = "web/detail/" + pageCommand.getAuthoringTemplate();
//        File viewFile = new File(request.getRealPath("WEB-INF/pages/" + viewName + ".jsp"));
//        if(!viewFile.exists()){
//        	viewName = "web/detail/default" ;
//        }
//        ModelAndView mav = new ModelAndView(viewName);
//        try{
//            Content currentContentItem = contentService.findById(pageCommand.getContentID());
//            mav.addObject("currentContentItem", currentContentItem);
//            List<Content> relatedItems = contentService.findRelatedItems(pageCommand.getAuthoringTemplate(), pageCommand.getCategory(), pageCommand.getDepartmentID(), currentContentItem.getModifiedDate(), 0, 10);
//            mav.addObject("relatedItems", relatedItems);
//
//            if(currentContentItem != null && currentContentItem.getAuthoringTemplate() != null && currentContentItem.getAuthoringTemplate().getStatus().equals(Constants.FLAG_YES)){
//	            String sPage = request.getParameter(new ParamEncoder(pageCommand.getTableId()).encodeParameterName(TableTagParameters.PARAMETER_PAGE));
//	            int index = 0;
//	            if(StringUtils.isNotEmpty(sPage)){
//	            	try{
//	            		index = (Integer.valueOf(sPage.trim()) - 1) * pageCommand.getMaxPageItems();
//	            	}catch(Exception e){
//	            		logger.error(e.getMessage(), e);
//	            	}
//	            }
//	            Object[] approvedCommentsResult = commentService.findApprovedCommentsByContentID(pageCommand.getContentID(), index, pageCommand.getMaxPageItems());
//	            if(approvedCommentsResult != null && approvedCommentsResult.length > 0) {
//	                pageCommand.setTotalItems(Integer.valueOf(approvedCommentsResult[0].toString()));
//	                pageCommand.setListResults((List<Comment>)approvedCommentsResult[1]);
//	            }
//            }
//
//            AuthoringTemplate authoringTemplate = authoringTemplateService.findByCode(pageCommand.getAuthoringTemplate());
//            mav.addObject("currentAuthoringTemplate", authoringTemplate);
//            if (StringUtils.isNotBlank(pageCommand.getCategory())) {
//                try{
//                    Category category = categoryService.findByCode(pageCommand.getCategory());
//                    mav.addObject("currentCategory", category);
//                }catch (ObjectNotFoundException ex) {
//                    logger.error("Not found category " + pageCommand.getCategory());
//                }
//            }
//            if (pageCommand.getDepartmentID() != null) {
//                try{
//                    Department department = departmentService.findById(pageCommand.getDepartmentID());
//                    mav.addObject("department", department);
//                    if (department.getIsBranch() != null && department.getIsBranch() == 1) {
//                        mav.addObject("prefixDepartmentURL", "chi-nhanh");
//                    }else{
//                        mav.addObject("prefixDepartmentURL", "phong-ban");
//                    }
//                }catch (ObjectNotFoundException ex) {
//
//                }
//            }
//
//            TrackingDTO trackingDTO = trackingService.findTotalTrackingByContentID(pageCommand.getContentID());
//            mav.addObject("trackingDetail", trackingDTO);
//        }catch (ObjectNotFoundException ex) {
//            logger.error("Could not found content with ID " + pageCommand.getContentID());
//        }
//        mav.addObject(Constants.FORM_MODEL_KEY, pageCommand);
//        return mav;
//    }
}
