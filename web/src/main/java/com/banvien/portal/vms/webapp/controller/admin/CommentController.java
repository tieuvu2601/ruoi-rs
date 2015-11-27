package com.banvien.portal.vms.webapp.controller.admin;

import com.banvien.portal.vms.bean.CommentBean;
import com.banvien.portal.vms.domain.Comment;
import com.banvien.portal.vms.domain.User;
import com.banvien.portal.vms.editor.CustomDateEditor;
import com.banvien.portal.vms.editor.PojoEditor;
import com.banvien.portal.vms.exception.ObjectNotFoundException;
import com.banvien.portal.vms.service.CommentService;
import com.banvien.portal.vms.service.UserService;
import com.banvien.portal.vms.util.Constants;
import com.banvien.portal.vms.util.RequestUtil;
import com.banvien.portal.vms.webapp.validator.CommentValidator;
import org.apache.commons.lang.StringUtils;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.support.ApplicationObjectSupport;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import java.util.Date;
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
public class CommentController extends ApplicationObjectSupport {
	private transient final Logger logger = Logger.getLogger(getClass());

    @Autowired
    private CommentService commentService;

    @Autowired
    private CommentValidator commentValidator;

    @Autowired
    private UserService userService;

    @InitBinder
    public void initBinder(WebDataBinder binder) {
    	binder.registerCustomEditor(Date.class, new CustomDateEditor());
        binder.registerCustomEditor(User.class, new PojoEditor(User.class, "userID", Long.class));
	}


    @RequestMapping("/admin/comment/edit.html")
    public ModelAndView edit(@ModelAttribute(Constants.FORM_MODEL_KEY) CommentBean bean, BindingResult bindingResult){
        ModelAndView mav = new ModelAndView("/admin/comment/edit");
        String crudaction = bean.getCrudaction();
        Comment pojo = bean.getPojo();
        if(StringUtils.isNotBlank(crudaction) && crudaction.equals("insert-update")) {
            try{
                commentValidator.validate(bean, bindingResult);
                if(!bindingResult.hasErrors()){
                    if(pojo.getCommentID() != null && pojo.getCommentID() >0 ){
                        this.commentService.update(pojo);
                        mav.addObject("messageResponse", this.getMessageSourceAccessor().getMessage("database.update.successful"));
                    }else{
                        this.commentService.save(pojo);
                        mav.addObject("messageResponse", this.getMessageSourceAccessor().getMessage("database.add.successful"));
                    }
                    mav.addObject("success", true);
                }
            }catch(Exception e) {
                logger.error(e.getMessage(), e);
                mav.addObject("messageResponse", this.getMessageSourceAccessor().getMessage("general.exception.msg"));
            }
        }
        if(!bindingResult.hasErrors() && bean.getPojo().getCommentID() != null){

            try{
                bean.setPojo(commentService.findById(bean.getPojo().getCommentID()));
            }catch (ObjectNotFoundException oe) {
                logger.error(oe.getMessage(), oe);
                mav.addObject("messageResponse", this.getMessageSourceAccessor().getMessage("database.exception.keynotfound"));
            }
        }
        referenceData(mav);
        mav.addObject(Constants.FORM_MODEL_KEY, bean);
        return mav;
    }

    private void executeSearch(CommentBean bean, HttpServletRequest request) {
        RequestUtil.initSearchBean(request, bean);
        Map<String, Object> properties = new HashMap<String, Object>();
//        if(StringUtils.isNotBlank(bean.getPojo().getName())){
//            properties.put("name", bean.getPojo().getName());
//        }
        Object[] results = this.commentService.searchByProperties(properties, bean.getSortExpression(), bean.getSortDirection(), bean.getFirstItem(), bean.getMaxPageItems());
        bean.setListResult((List<Comment>)results[1]);
        bean.setTotalItems(Integer.valueOf(results[0].toString()));
    }

    private void referenceData(ModelAndView mav) {
        mav.addObject("users", userService.findAll());
    }

}
