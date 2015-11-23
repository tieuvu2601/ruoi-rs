package com.banvien.portal.vms.crawler;

import com.banvien.portal.vms.dto.ContentDTO;
import com.banvien.portal.vms.util.CommonUtil;
import com.banvien.portal.vms.util.DateUtils;
import com.banvien.portal.vms.util.HttpClientHelper;
import com.banvien.portal.vms.xml.authoringtemplate.AuthoringTemplate;
import org.apache.commons.lang.StringUtils;
import org.apache.http.protocol.HTTP;

import java.net.URLDecoder;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

/**
 * Created by Ban Vien Co., Ltd.
 * User: viennh
 * Email: vien.nguyen@banvien.com
 * Date: 1/23/13
 * Time: 10:36 AM
 */
public class AnnouncementCrawler extends AbstractCrawler {
    protected Integer maxCrawItem = Integer.MAX_VALUE;
    protected Timestamp fromDate;
    public AnnouncementCrawler(String crawlerURL, AuthoringTemplate authoringTemplate, Timestamp fromDate) {
        super(crawlerURL, authoringTemplate);
        this.fromDate = fromDate;
    }

    public AnnouncementCrawler(String crawlerURL, AuthoringTemplate authoringTemplate, Integer maxCrawlItem) {
        super(crawlerURL, authoringTemplate);
        if (maxCrawlItem != null) {
            this.maxCrawItem = maxCrawlItem;
        }
    }

    @Override
    public List<ContentDTO> extractContents() {
        HttpClientHelper helper = new HttpClientHelper("portalcenter2", "portalcenter21016");
        List<ContentDTO> res = new ArrayList<ContentDTO>();
        try{
            String html = helper.get(this.crawlerURL);
            String regContent = "(<tr class=\"ms-alternating\"><td class=\"ms-vb2\">|<tr class=\"\"><td class=\"ms-vb2\">)+(.*?)</td><td class=\"ms-vb-title\" height=\"100%\">(.*?)</td><td class=\"ms-vb2\"><nobr>(.*?)</nobr></td><td class=\"ms-vb2\">(<img.*?alt=\"Attachment\".*?>)*</td>(<td class=\"ms-vb2\">.*?</td>)*</tr>";
            String regTitle = "<a onfocus=\"OnLink.*?\" href=\"(.*?)\".*?>(.*?)</a>";
            String regDetailContent ="id=\"WebPartWPQ1\".*?><table.*?>(.*?)</table></div>";
            String regDetailContent2 = "<div class=ExternalClass.*?>(.*?)</div>(<script.*?</script>)*</td></tr>";
            String regAttachment = "<a.*?onclick=\"DispDocItemEx.*?\" href=\"(.*?)\">(.*?)</a>";
            String regNextPage = "<A HREF=\"javascript:\" OnClick='javascript:SubmitFormPost\\(\"(.*?)\"\\);javascript:return false;'";

            Pattern outPGetTitle = Pattern.compile(regTitle, Pattern.DOTALL + Pattern.CASE_INSENSITIVE);
            Pattern outPGetContents = Pattern.compile(regContent, Pattern.DOTALL + Pattern.CASE_INSENSITIVE);
            Pattern outPGetDetail = Pattern.compile(regDetailContent, Pattern.DOTALL + Pattern.CASE_INSENSITIVE);
            Pattern outPGetDetail2 = Pattern.compile(regDetailContent2, Pattern.DOTALL + Pattern.CASE_INSENSITIVE);
            Pattern outPGetAttachment = Pattern.compile(regAttachment, Pattern.DOTALL + Pattern.CASE_INSENSITIVE);

            Matcher outMGetContents= outPGetContents.matcher(html);
            int i = 0;
            while(outMGetContents.find()) {
                if (outMGetContents.groupCount() >= 4) {
                    ContentDTO contentDTO = new ContentDTO();
                    String code = outMGetContents.group(2);
                    String titleContent = outMGetContents.group(3);
                    String postDate = outMGetContents.group(4);

                    if (StringUtils.isNotBlank(postDate) && fromDate != null) {
                        Timestamp postedDate = convertToTimestamp(postDate);
                        if (postedDate != null && fromDate.compareTo(postedDate) > 0) {
                            continue;
                        }
                    }

                    Matcher outMGetTitle = outPGetTitle.matcher(titleContent);
                    if (outMGetTitle.find()) {
                        if (outMGetTitle.groupCount() >= 2) {
                            contentDTO.setTitle(CommonUtil.cleanHtmlTags(outMGetTitle.group(2)));
                            contentDTO.setDetailURL(outMGetTitle.group(1));
                        }
                    }

                    contentDTO.setCode(code);
                    contentDTO.setPostDate(postDate);

                    if (StringUtils.isNotBlank(contentDTO.getDetailURL())) {
                        String htmlDetail = helper.get("http://10.151.70.91" + contentDTO.getDetailURL());//helper.get("http://118.69.192.29/vms/detail.html");

                        Matcher outMGetDetail = outPGetDetail.matcher(htmlDetail);
                        if (outMGetDetail.find()) {
                            String brief = outMGetDetail.group(1);
                            Matcher outMGetDetail2 = outPGetDetail2.matcher(brief);
                            if (outMGetDetail2.find()) {
                                contentDTO.setBrief(outMGetDetail2.group(1));

                            } else{
                                contentDTO.setBrief(brief);
                            }

                            Matcher outMGetAttachment = outPGetAttachment.matcher(htmlDetail);
                            List<String> attachments = new ArrayList<String>();
                            while (outMGetAttachment.find()) {
                                attachments.add(outMGetAttachment.group(1));
                            }
                            contentDTO.setAttachmentURLs(attachments);
                        }
                    }

                    res.add(contentDTO);
                }
                i++;
            }

        }catch (Exception e) {
            e.printStackTrace();

        }
        return res;
    }

    private Timestamp convertToTimestamp(String s) {
        s = s.replace("CH", "PM").replace("SA", "AM");
        return new Timestamp(DateUtils.convertFromString2Date(s, "dd/MM/yyyy hh:mm a").getTime());
    }

    private String normalizeURL(String nextURL) {
        String[] arr = nextURL.split("&");
        StringBuilder str = new StringBuilder(arr[0]);
        for (int i = 1; i < arr.length; i++) {
            String s = arr[i];
            String[] par = s.split("=");
            str.append("&").append(par[0]).append(CommonUtil.encodeURIComponent(par[1]));
        }

        return str.toString();
    }
}
