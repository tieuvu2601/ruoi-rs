package com.banvien.portal.vms.webapp.controller.web;

import com.banvien.portal.vms.domain.Content;
import com.banvien.portal.vms.dto.ThreadDTO;
import com.banvien.portal.vms.exception.DuplicateException;
import com.banvien.portal.vms.exception.InvalidXMLException;
import com.banvien.portal.vms.exception.ObjectNotFoundException;
import com.banvien.portal.vms.security.SecurityUtils;
import com.banvien.portal.vms.service.CommentService;
import com.banvien.portal.vms.service.ContentService;
import com.banvien.portal.vms.service.ThreadMobi8Service;
import com.banvien.portal.vms.service.TrackingService;
import com.banvien.portal.vms.util.CacheUtil;
import com.banvien.portal.vms.util.Constants;
import com.banvien.portal.vms.util.ContentItemUtil;
import com.banvien.portal.vms.webapp.command.PollDisplayCommand;
import com.banvien.portal.vms.xml.contentitem.ContentItem;
import com.banvien.portal.vms.xml.contentitem.Item;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationContext;
import org.springframework.context.i18n.LocaleContextHolder;
import org.springframework.context.support.ApplicationObjectSupport;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;
import org.xml.sax.SAXException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.xml.bind.JAXBException;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
public class HomeController extends ApplicationObjectSupport {

    @Autowired
    private ContentService contentService;

    @Autowired
    private CommentService commentService;

    @Autowired
    private TrackingService trackingService;

    @Autowired
    private ThreadMobi8Service threadMobi8Service;

    private final String VOTE_CONTENT_KEY = "content";
    private final String RESULT_KEY = "results";
    private final String OPTION_KEY = "options";

    @RequestMapping("/ajax/poll.html")
    public ModelAndView viewPage(@RequestParam("optionID") String optionID,@RequestParam("pollID") String pollID,  HttpServletRequest request){
        ModelAndView mav = new ModelAndView("web/page/poll");
        if(pollID != null && !pollID.equals("")) {
            try {
                Content content = contentService.findById(Long.parseLong(pollID));
                ContentItem contentItem = ContentItemUtil.parseXML(content.getXmlData());

                List<Item> resultItems =  contentItem.getItems().getItem();
                String userPoll = request.getSession().getId() + pollID;
                if(optionID != null && !optionID.equals("") && request.getSession().getAttribute(userPoll) == null) {
                    calculatePoll(mav, resultItems, optionID);
                    //set session
                    request.getSession().setAttribute(userPoll,"polled");
                }
                else {
                    showPoll(mav, resultItems);
                }

                content.setXmlData(ContentItemUtil.bean2Xml(contentItem));
                contentService.update(content);


            } catch (ObjectNotFoundException e) {
                logger.error(e.getMessage());
            } catch (SAXException e) {
                logger.error(e.getMessage());
            } catch (InvalidXMLException e) {
                logger.error(e.getMessage());
            } catch (JAXBException e) {
                logger.error(e.getMessage());
            } catch (IOException e) {
                logger.error(e.getMessage());
            } catch (DuplicateException e) {
                logger.error(e.getMessage());
            }
        }
        return mav;
    }

    private void calculatePoll(ModelAndView mav, List<Item> resultItems,String optionID) {
        Integer optID = Integer.parseInt(optionID);
        List<PollDisplayCommand> displayResultItems = new ArrayList<PollDisplayCommand>();
        for(Item item : resultItems) {
            if(item.getItemKey().toLowerCase().equals(OPTION_KEY)) {
                for(String val : item.getItemValue()) {
                    PollDisplayCommand command = new PollDisplayCommand();
                    command.setDisplayName(val);

                    displayResultItems.add(command);
                }
            }
            if (item.getItemKey().equalsIgnoreCase(VOTE_CONTENT_KEY)) {
                mav.addObject("content", item.getItemValue() != null && item.getItemValue().size() > 0 ? item.getItemValue().get(0) : "");
            }
        }
        for(Item item : resultItems) {
            if(item.getItemKey().toLowerCase().equals(RESULT_KEY)) {
                String oldResultString = item.getItemValue().get(optID);

                if(!oldResultString.equals("")) {
                    Integer value = Integer.parseInt(oldResultString);
                    value ++;
                    item.getItemValue().set(optID, value.toString());
                }

                //calculate total poll
                Integer totalPoll = 0;
                for(int i = 0; i < displayResultItems.size(); i++) {
                    Integer val =  Integer.parseInt(item.getItemValue().get(i));
                    totalPoll = totalPoll + val;
                    displayResultItems.get(i).setPollValue(val);
                }
                if (totalPoll != 0) {
                    for(int i=0; i<displayResultItems.size(); i++) {
                        Double dVal = displayResultItems.get(i).getPollValue() * 344.0 / totalPoll ;
                        displayResultItems.get(i).setPollValue(dVal.intValue());
                    }
                }

                mav.addObject("displayResultItems", displayResultItems);
                mav.addObject("itemValues", item.getItemValue());

            }
        }

    }

    private void showPoll(ModelAndView mav, List<Item> resultItems) {
        List<PollDisplayCommand> displayResultItems = new ArrayList<PollDisplayCommand>();
        for(Item item : resultItems) {
            if(item.getItemKey().toLowerCase().equals(OPTION_KEY)) {
                for(String val : item.getItemValue()) {
                    PollDisplayCommand command = new PollDisplayCommand();
                    command.setDisplayName(val);

                    displayResultItems.add(command);
                }
            }
            if (item.getItemKey().equalsIgnoreCase(VOTE_CONTENT_KEY)) {
                mav.addObject("content", item.getItemValue() != null && item.getItemValue().size() > 0 ? item.getItemValue().get(0) : "");
            }
        }
        for(Item item : resultItems) {
            if(item.getItemKey().toLowerCase().equals(RESULT_KEY)) {

                Integer totalPoll = 0;
                for(int i = 0; i < displayResultItems.size(); i++) {
                    Integer val =  Integer.parseInt(item.getItemValue().get(i));
                    totalPoll = totalPoll + val;
                    displayResultItems.get(i).setPollValue(val);
                }
                if (totalPoll != 0) {
                    for(int i=0; i<displayResultItems.size(); i++) {
                        Double dVal = displayResultItems.get(i).getPollValue() * 344.0 / totalPoll ;
                        displayResultItems.get(i).setPollValue(dVal.intValue());
                    }
                }

                mav.addObject("displayResultItems", displayResultItems);
                mav.addObject("itemValues", item.getItemValue());

            }
        }
    }

    @RequestMapping({"/index.html", "/"})
    public ModelAndView home() throws Exception{
        ModelAndView mav = new ModelAndView("web/newHome");

        mav.addObject("newsPrefixUrl", Constants.RESEARCH_PROJECT_PREFIX_URL);
        mav.addObject("eventPrefixUrl", Constants.RESEARCH_PROJECT_PREFIX_URL);
        mav.addObject("researchProjectPrefixUrl", Constants.RESEARCH_PROJECT_PREFIX_URL);
        return mav;
    }

    @RequestMapping(value="/serverinfo.html")
    public ModelAndView serverInfo(HttpServletRequest request, HttpServletResponse response) {
        return new ModelAndView("info");
	}

}
