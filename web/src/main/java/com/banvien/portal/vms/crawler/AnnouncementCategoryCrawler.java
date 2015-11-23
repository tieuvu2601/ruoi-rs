package com.banvien.portal.vms.crawler;

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
public class AnnouncementCategoryCrawler extends AbstractCrawler {

    public AnnouncementCategoryCrawler(String crawlerURL, AuthoringTemplate authoringTemplate) {
        super(crawlerURL, authoringTemplate);
    }

    @Override
    public List<ContentDTO> extractContents() {
        HttpClientHelper helper = new HttpClientHelper("portalcenter2", "portalcenter21016");
        List<ContentDTO> res = new ArrayList<ContentDTO>();
        try{
            String html = helper.get(this.crawlerURL);
            String regNextPage = "<A HREF=\"javascript:\" OnClick='javascript:SubmitFormPost\\(\"(.*?)\"\\);javascript:return false;'>";

            Pattern outPNextPage = Pattern.compile(regNextPage, Pattern.DOTALL + Pattern.CASE_INSENSITIVE);

            Matcher outMGetNextPage = outPNextPage.matcher(html);
            if (outMGetNextPage.find()) {
                if (outMGetNextPage.find()) {
                    String nextURL = outMGetNextPage.group(1);
                    nextURL = nextURL.replace("\\u002f", "/").replace("\\u0026", "&").replace("\\u002520", " ").replace("\\u00253a", ":").replace("\\u00257b", "{").replace("\\u00252d", "-").replace("\\u00257d", "}");
                    nextURL = normalizeURL(nextURL);
                    ContentDTO contentDTO = new ContentDTO();
                    contentDTO.setDetailURL(nextURL);
                    this.crawlerURL = nextURL;
                    res.addAll(extractContents());
                }
            }

        }catch (Exception e) {
            e.printStackTrace();

        }
        return res;
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
