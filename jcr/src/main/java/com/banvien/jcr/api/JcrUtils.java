package com.banvien.jcr.api;


import java.io.UnsupportedEncodingException;

public class JcrUtils {
	public static String createHrefPathWebdav(String webdavContextPath, String workspaceName, String path){
		//return "/repository/" + workspaceName + path;
		//return webdavContextPath + "/" + workspaceName + path;
		String en_path = "";
		try {
			en_path =  java.net.URLEncoder.encode(path, "UTF-8");
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}
		return webdavContextPath + "?path=" + en_path;
	}
}
