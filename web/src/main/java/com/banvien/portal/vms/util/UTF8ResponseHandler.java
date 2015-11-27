package com.banvien.portal.vms.util;

import org.apache.http.HttpEntity;
import org.apache.http.HttpResponse;
import org.apache.http.StatusLine;
import org.apache.http.client.HttpResponseException;
import org.apache.http.client.ResponseHandler;
import org.apache.http.protocol.HTTP;
import org.apache.http.util.EntityUtils;

import java.io.IOException;

/**
 * Created by Ban Vien Co., Ltd.
 * UserEntity: viennh
 * Email: vien.nguyen@banvien.com
 * Date: 1/23/13
 * Time: 3:11 PM
 */
public class UTF8ResponseHandler implements ResponseHandler<String> {

    /**
     * Returns the response body as a String if the response was successful (a
     * 2xx status code). If no response body exists, this returns null. If the
     * response was unsuccessful (>= 300 status code), throws an
     * {@link org.apache.http.client.HttpResponseException}.
     */
    public String handleResponse(final HttpResponse response)
            throws HttpResponseException, IOException {
        StatusLine statusLine = response.getStatusLine();
        if (statusLine.getStatusCode() >= 300) {
            throw new HttpResponseException(statusLine.getStatusCode(),
                    statusLine.getReasonPhrase());
        }

        HttpEntity entity = response.getEntity();
        return entity == null ? null : EntityUtils.toString(entity, HTTP.UTF_8);
    }
}
