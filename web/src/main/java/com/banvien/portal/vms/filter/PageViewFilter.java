package com.banvien.portal.vms.filter;

import com.banvien.portal.vms.domain.Content;
import com.banvien.portal.vms.domain.Tracking;
import com.banvien.portal.vms.exception.DuplicateException;
import com.banvien.portal.vms.service.TrackingService;
import com.banvien.portal.vms.util.DateUtils;
import org.apache.commons.lang.StringUtils;
import org.springframework.web.filter.OncePerRequestFilter;

import javax.servlet.FilterChain;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.Timestamp;
import java.util.Calendar;
import java.util.Date;

public class PageViewFilter extends OncePerRequestFilter {

    private TrackingService trackingService;

    /**
     * This method calculate page view for each content item
     *
     * @param request the current request
     * @param response the current response
     * @param chain the chain
     * @throws java.io.IOException when something goes wrong
     * @throws javax.servlet.ServletException when a communication failure happens
     */
    @Override
    public void doFilterInternal(HttpServletRequest request, HttpServletResponse response,
                                 FilterChain chain)
            throws IOException, ServletException {
        HttpSession session = request.getSession(false);
        if(session != null) {
            String strContentID = request.getParameter("contentID");
            if(StringUtils.isNotBlank(strContentID)) { //contentID
                try {
                    Long contentID = Long.parseLong(strContentID);
                    //contentID is already checked
                    String code = DateUtils.date2String(new Date(), "yyyyMMdd");
                    if(session != null && session.getAttribute(contentID.toString()) == null) {
                        Tracking tracking = trackingService.findTrackingByContentIDAndCode(contentID, code);

                        if(tracking != null) { //update
                            tracking.setViews(tracking.getViews() + 1);
                            trackingService.update(tracking);
                        }
                        else { // add new
                            Tracking newTracking = new Tracking();
                            newTracking.setViews(1);
                            newTracking.setTrackingDate(new Timestamp(System.currentTimeMillis()));
                            Content content = new Content();
                            content.setContentID(contentID);
                            newTracking.setContent(content);
                            newTracking.setCode(code);
                            trackingService.save(newTracking);
                        }

                        session.setAttribute(contentID.toString(),contentID);
                    }
                } catch (DuplicateException e) {
                    logger.error(e.getMessage());
                }
            }
        }
        chain.doFilter(request, response);
    }

    public void setTrackingService(TrackingService trackingService) {
        this.trackingService = trackingService;
    }
}
