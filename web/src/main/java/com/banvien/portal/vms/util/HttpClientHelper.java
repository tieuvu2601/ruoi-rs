/**
 * 
 */
package com.banvien.portal.vms.util;

import org.apache.commons.lang.StringUtils;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.apache.http.HttpResponse;
import org.apache.http.NameValuePair;
import org.apache.http.auth.AuthScope;
import org.apache.http.auth.NTCredentials;
import org.apache.http.client.CredentialsProvider;
import org.apache.http.client.HttpClient;
import org.apache.http.client.ResponseHandler;
import org.apache.http.client.entity.UrlEncodedFormEntity;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.client.methods.HttpRequestBase;
import org.apache.http.client.protocol.ClientContext;
import org.apache.http.impl.client.BasicCredentialsProvider;
import org.apache.http.impl.client.BasicResponseHandler;
import org.apache.http.impl.client.DefaultHttpClient;
import org.apache.http.message.BasicNameValuePair;
import org.apache.http.params.CoreProtocolPNames;
import org.apache.http.params.DefaultedHttpParams;
import org.apache.http.params.HttpParams;
import org.apache.http.protocol.BasicHttpContext;
import org.apache.http.protocol.HTTP;
import org.apache.http.protocol.HttpContext;

import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

/**
 * @author Nguyen Hai Vien
 *
 */
public class HttpClientHelper {
	private transient final Log log = LogFactory.getLog(HttpClientHelper.class);
	
	private String user;
	private String password;
	private String userAgent;
	
	public HttpClientHelper() {
		this.userAgent = "Mozilla/5.0 (Macintosh; Intel Mac OS X 10.7; rv:18.0) Gecko/20100101 Firefox/18.0";

	}
	public HttpClientHelper(String userAgent) {
		if (StringUtils.isNotBlank(userAgent)) {
			this.userAgent = userAgent;
		}
	}
	
	/**
	 * prepare the HTTP connection
	 * @param httpRequest
	 * @throws java.io.IOException
	 */
	private void configureConncetion(HttpRequestBase httpRequest) throws IOException {
		httpRequest.addHeader(HTTP.USER_AGENT, userAgent);
	}
	
	public HttpClientHelper(String user, String password) {
        this.userAgent = "Mozilla/5.0 (Macintosh; Intel Mac OS X 10.7; rv:18.0) Gecko/20100101 Firefox/18.0";
		this.user = user;
		this.password = password;
	}
	
	public String get(String url) throws IOException {
		log.debug("URL: " + url);
		String content = "";

		HttpClient httpclient = new DefaultHttpClient();
		try{
			HttpGet httpGet = new HttpGet(url);
			configureConncetion(httpGet);

			HttpContext localContext = new BasicHttpContext();
            if (StringUtils.isNotBlank(this.user)) {
                CredentialsProvider credsProvider = new BasicCredentialsProvider();
                credsProvider.setCredentials(new AuthScope("10.151.70.91",80), new NTCredentials(this.user, this.password, "", "vms.com.vn"));
                localContext.setAttribute(ClientContext.CREDS_PROVIDER, credsProvider);
            }
			ResponseHandler<String> responseHandler = new UTF8ResponseHandler();
			content = httpclient.execute(httpGet, responseHandler, localContext);
		}finally {
			httpclient.getConnectionManager().shutdown();
		}
		return content;
	}

    public byte[] getByte(String url) throws IOException {
		log.debug("URL: " + url);
        byte[] content = null;
		HttpClient httpclient = new DefaultHttpClient();
		try{
			HttpGet httpGet = new HttpGet(url);
			configureConncetion(httpGet);
			HttpContext localContext = new BasicHttpContext();
            if (StringUtils.isNotBlank(this.user)) {
                CredentialsProvider credsProvider = new BasicCredentialsProvider();
                credsProvider.setCredentials(new AuthScope("10.151.70.91",80), new NTCredentials(this.user, this.password, "", "vms.com.vn"));
                localContext.setAttribute(ClientContext.CREDS_PROVIDER, credsProvider);
            }
			HttpResponse responseHandler = httpclient.execute(httpGet, localContext);
            InputStream in = responseHandler.getEntity().getContent();
            ByteArrayOutputStream byteArrayOutputStream = new ByteArrayOutputStream();
            int ch;
            while ((ch = in.read()) != -1) {
                byteArrayOutputStream.write(ch);
            }
            content = byteArrayOutputStream.toByteArray();
		}catch (Exception e){
            e.printStackTrace();
        }finally {
			httpclient.getConnectionManager().shutdown();
		}
		return content;
	}
	
	public String post(String url, Map<String, String> params) throws IOException {
		String content = "";
		HttpClient httpclient = new DefaultHttpClient();
		try{
			List<NameValuePair> formparams = new ArrayList<NameValuePair>();
			populateFormParams(params, formparams);
			
			UrlEncodedFormEntity entity= new UrlEncodedFormEntity(formparams, "UTF-8");
			HttpPost httpPost = new HttpPost(url);
			configureConncetion(httpPost);
			httpPost.setEntity(entity);
			
			HttpContext localContext = new BasicHttpContext();
			ResponseHandler<String> responseHandler = new BasicResponseHandler();
			content = httpclient.execute(httpPost, responseHandler, localContext);
		}finally{
			httpclient.getConnectionManager().shutdown();
		}
		return content;
	}
	private void populateFormParams(Map<String, String> params,
			List<NameValuePair> formparams) {
		if (params != null) {
			for (String key : params.keySet()) {
				String value = params.get(key);
				formparams.add(new BasicNameValuePair(key, value));
			}
		}
	}

}
