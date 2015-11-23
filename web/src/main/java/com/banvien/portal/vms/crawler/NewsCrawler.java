package com.banvien.portal.vms.crawler;

import com.banvien.portal.vms.domain.Content;
import com.banvien.portal.vms.dto.ContentDTO;
import com.banvien.portal.vms.util.CommonUtil;
import com.banvien.portal.vms.util.HttpClientHelper;
import com.banvien.portal.vms.xml.authoringtemplate.AuthoringTemplate;
import org.apache.commons.lang.StringUtils;

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
public class NewsCrawler extends AbstractCrawler {

    public NewsCrawler(String crawlerURL, AuthoringTemplate authoringTemplate) {
        super(crawlerURL, authoringTemplate);
    }

    @Override
    public List<ContentDTO> extractContents() {
        HttpClientHelper helper = new HttpClientHelper();
        List<ContentDTO> res = new ArrayList<ContentDTO>();
        try{
            String html = helper.get(this.crawlerURL);
            String regContent = "(<tr class=\"ms-alternating\"><td class=\"ms-vb2\">|<tr class=\"\"><td class=\"ms-vb2\">)+<img src=\"(.*?)\".*?></td><td class=\"ms-vb2\">(.*?)</td><td class=\"ms-vb2\"><div dir=\"\">(.*?)</div></td></tr>";
            String regTitle = "<a onfocus=\"OnLink.*?\" href=\"(.*?)\".*?>(.*?)</a>";
            String regDetailContent ="id=\"WebPartWPQ1\".*?><table.*?>(.*?)</table></div>";
            String regDetailContent2 = "<div class=ExternalClass.*?>(.*?)</div></td></tr>";

            Pattern outPGetTitle = Pattern.compile(regTitle, Pattern.DOTALL + Pattern.CASE_INSENSITIVE);
            Pattern outPGetContents = Pattern.compile(regContent, Pattern.DOTALL + Pattern.CASE_INSENSITIVE);
            Pattern outPGetDetail = Pattern.compile(regDetailContent, Pattern.DOTALL + Pattern.CASE_INSENSITIVE);
            Pattern outPGetDetail2 = Pattern.compile(regDetailContent2, Pattern.DOTALL + Pattern.CASE_INSENSITIVE);

            Matcher outMGetContents= outPGetContents.matcher(html);

            while(outMGetContents.find()) {
                if (outMGetContents.groupCount() >= 4) {
                    ContentDTO contentDTO = new ContentDTO();
                    String thumbnailImg = outMGetContents.group(2);
                    String titleContent = outMGetContents.group(3);
                    String brief = outMGetContents.group(4);

                    Matcher outMGetTitle = outPGetTitle.matcher(titleContent);
                    if (outMGetTitle.find()) {
                        if (outMGetTitle.groupCount() >= 2) {
                            contentDTO.setTitle(CommonUtil.cleanHtmlTags(outMGetTitle.group(2)));
                            contentDTO.setDetailURL(outMGetTitle.group(1));
                        }
                    }

                    contentDTO.setThumbnailURL(thumbnailImg);
                    contentDTO.setBrief(brief);

                    if (StringUtils.isNotBlank(contentDTO.getDetailURL())) {
                        String htmlDetail = helper.get("http://10.151.70.91" + contentDTO.getDetailURL());//helper.get("http://118.69.192.29/vms/detail.html");

                        Matcher outMGetDetail = outPGetDetail.matcher(htmlDetail);
                        if (outMGetDetail.find()) {
                            String detail = outMGetDetail.group(1);
                            Matcher outMGetDetail2 = outPGetDetail2.matcher(detail);
                            if (outMGetDetail2.find()) {
                                contentDTO.setDetail(outMGetDetail2.group(1));
                            } else{
                                contentDTO.setDetail(detail);
                            }
                        }
                    }

                    res.add(contentDTO);
                }
            }

        }catch (Exception e) {

        }
        return res;
    }
}
