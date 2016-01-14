package com.banvien.jcr.api;


import java.io.IOException;

import javax.jcr.RepositoryException;
import javax.jcr.Session;

import com.banvien.jcr.api.struts.JcrPlugin;
import org.apache.log4j.Logger;
import org.springmodules.jcr.JcrCallback;
import org.springmodules.jcr.JcrTemplate;

public class JcrContentImpl implements IJcrContent {

	private final Logger logger = Logger.getLogger(getClass());

    private JcrTemplate template = null;
    private String webdavContextPath = "";
    
    public void removeFileItem(final String fullpath) {
    	template.execute(new JcrCallback() {
            public Object doInJcr(Session session) throws RepositoryException,IOException {
            	JcrContentImplUtil.removeFileItem(session, fullpath);
            	
            	return null;
            }
    	});     
    }
    public FileItem getFileItem(final String fullpath) throws JcrException{
    	Object ofile = template.execute(new JcrCallback() {
            public Object doInJcr(Session session) throws RepositoryException,IOException {
            	return JcrContentImplUtil.getFileItem(session, webdavContextPath, fullpath);
            }
    	});     
    	return (FileItem)ofile;
    }
    
	public Object search(final String path, final String str1, final long offset, final long limit) {
		Object totalandlist = template.execute(new JcrCallback() {
            public Object doInJcr(Session session) throws RepositoryException,IOException {
            	return JcrContentImplUtil.search(session, webdavContextPath, path, str1, offset, limit);
            }
        });
   		return totalandlist;
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
    public String write(final String path, final FileItem fileItem) {
       Object fileName = template.execute(new JcrCallback() {
            public Object doInJcr(Session session) throws RepositoryException, IOException {
            	return JcrContentImplUtil.write(session, path, fileItem);
            }
        });
       return (String)fileName;
    }
    public String write(final FileItem fileItem) {
    	return write(null, fileItem);
    	
    }

    public void setTemplate(JcrTemplate template) {
		this.template = template;
	}

	public void setWebdavContextPath(String webdavContextPath) {
		this.webdavContextPath = webdavContextPath;
	}
	
	public Object getAll(final String path) {
		Object totalandlist = template.execute(new JcrCallback() {
            public Object doInJcr(Session session) throws RepositoryException,IOException {
            	return JcrContentImplUtil.getAll(session, webdavContextPath, path);
            }
        });
   		return totalandlist;
	}

    @Override
    public Object getAllFileInPath(final String path) {
        Object totalandlist = template.execute(new JcrCallback() {
            public Object doInJcr(Session session) throws RepositoryException,IOException {
                return JcrContentImplUtil.getAllFileInPath(session, webdavContextPath, path);
            }
        });
        return totalandlist;
    }
}
