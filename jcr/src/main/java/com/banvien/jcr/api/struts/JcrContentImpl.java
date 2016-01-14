package com.banvien.jcr.api.struts;


import javax.jcr.RepositoryException;
import javax.jcr.Session;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.banvien.jcr.api.FileItem;
import com.banvien.jcr.api.IJcrContent;
import com.banvien.jcr.api.JcrContentImplUtil;
import com.banvien.jcr.api.JcrException;
import org.springmodules.jcr.JcrCallback;

import java.io.IOException;

public class JcrContentImpl implements IJcrContent {

    final Logger logger = LoggerFactory.getLogger(JcrContentImpl.class);

    private String webdavContextPath = "";
    public JcrContentImpl(){
    	webdavContextPath = JcrPlugin.getWebdavContextPath();
    }
    public void removeFileItem(final String fullpath) {
    	Session session = JcrPlugin.getSession();
    	JcrContentImplUtil.removeFileItem(session, fullpath);   
    }
    public FileItem getFileItem(final String fullpath) throws JcrException{
    	Session session = JcrPlugin.getSession();
    	return JcrContentImplUtil.getFileItem(session, webdavContextPath, fullpath);
    }
    
	public Object search(final String path, final String str1, final long offset, final long limit) {
		Session session = JcrPlugin.getSession();
		return JcrContentImplUtil.search(session, webdavContextPath, str1, offset, limit);
    }
	public Object search(final String str1, final long offset, final long limit) {
	   return search("", str1, offset, limit);
    }
    /**
     * 
     * @param path ex: images/gif
     * @param fileItem
     * @return
     */
    public String write(final String path, final FileItem fileItem)  throws JcrException{
    	Session session = JcrPlugin.getSession();
    	return JcrContentImplUtil.write(session, path, fileItem);
    }
    public String write(final FileItem fileItem) {
    	return write(null, fileItem);
    }

	public void setWebdavContextPath(String webdavContextPath) {
		this.webdavContextPath = webdavContextPath;
	}
	public Object getAll(String path) {
		Session session = JcrPlugin.getSession();
		return JcrContentImplUtil.getAll(session, webdavContextPath, path);
	}

    @Override
    public Object getAllFileInPath(final String path) {
        Session session = JcrPlugin.getSession();
        return JcrContentImplUtil.getAllFileInPath(session, webdavContextPath, path);
    }
}
