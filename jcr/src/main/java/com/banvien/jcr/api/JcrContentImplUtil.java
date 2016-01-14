package com.banvien.jcr.api;


import java.io.ByteArrayInputStream;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

import javax.activation.MimetypesFileTypeMap;
import javax.jcr.*;
import javax.jcr.query.Query;
import javax.jcr.query.Row;
import javax.jcr.query.RowIterator;

import org.apache.commons.io.IOUtils;
import org.apache.commons.lang.StringUtils;
import org.apache.commons.lang.time.DateFormatUtils;
import org.apache.jackrabbit.JcrConstants;
import org.apache.log4j.Logger;

import com.banvien.jcr.util.Utils;

public class JcrContentImplUtil {

	private final static Logger logger = Logger.getLogger(JcrContentImplUtil.class);

    public static void removeFileItem(Session session, final String fullpath) throws JcrException{
    	try {
	    	Node file = (Node) session.getItem(fullpath);
	    	file.remove();
	        session.save();
    	} catch (Exception e) {
    		throw new JcrException(e);
    	}
    }
    public static FileItem getFileItem(Session session, String webdavContextPath, final String fullpath) throws JcrException{
    	try {
	    	String wspName = session.getWorkspace().getName();
	    	Node file = (Node) session.getItem(fullpath);
	    	FileItem fileItem = nodeFile2FileItem(webdavContextPath, wspName, file);
	        
	    	return fileItem;
    	} catch (Exception e) {
    		throw new JcrException(e);
    	}
    }
    
	public static Object search(Session session, String webdavContextPath, final String path
			, final String str1, final long offset, final long limit) throws JcrException {
		final long to = offset + limit;
    	long total = 0;
    	String wspName = session.getWorkspace().getName();
    	String str = str1;
        if (str == null) {
            str = "";
        }
        RowIterator rows = null;
        if (str != null && str.length() > 0) {
        	str = str.replaceAll("'", "''");
            //String stmt = "//element(*, nt:file)[jcr:contains(jcr:content, '" + str + "')]/rep:excerpt(.)";
        	String stmt = "//element(*, nt:file)";
            if(StringUtils.isNotBlank(path)) {
            	stmt = "/jcr:root/" + path + stmt;
            }
            
            try {
	            Query query = session.getWorkspace().getQueryManager().createQuery(stmt, Query.XPATH);
	            rows = query.execute().getRows();
            } catch (Exception e) {
        		throw new JcrException(e);
        	}
            //total = rows.getSize();
            //logger.info("search jcr totalResults -----------" + rows.getSize());
        }
        if(rows != null) {
        	 try {
        		 rows.skip(offset);
             } catch (Exception e) {                        
             } 
        }
        List fileItems = new ArrayList();
        if(rows != null){
        	while (rows.hasNext() && rows.getPosition() < to) {
                Row r = rows.nextRow();
                try {
                	Node file = (Node) session.getItem(r.getValue("jcr:path").getString());
                	FileItem fileItem = nodeFile2FileItem(webdavContextPath, wspName, file);
                	fileItems.add(fileItem);
                	total++;
                } catch (Exception e) {
            		throw new JcrException(e);
            	}	
            }
        }
        return new Object[] {total, fileItems};
            
    }

    public static Object getAllFileInPath(Session session, String webdavContextPath, String path) {
        String currentPath = "/" + path;
        String wspName = session.getWorkspace().getName();
        List<FileItem> fileItems = new ArrayList<FileItem>();
        try {
            Node node = (Node)session.getItem(currentPath);
            NodeIterator nodeIterator = node.getNodes();
            while(nodeIterator.hasNext()) {
                Node file = nodeIterator.nextNode();
                if(file.getPrimaryNodeType().getName().equals("nt:file")) {
                    FileItem fileItem = nodeFile2FileItem(webdavContextPath, wspName, file);
                    fileItems.add(fileItem);
                }
            }
        } catch (RepositoryException e) {
        }

        return new Object[] {fileItems.size(), fileItems};
    }


	public static Object getAll(Session session, String webdavContextPath, final String path){
		String wspName = session.getWorkspace().getName();
    	
        RowIterator rows = null;
        
    	String stmt = "//element(*, nt:file)";
        if(StringUtils.isNotBlank(path)) {
        	stmt = "/jcr:root/" + path + stmt;
        }
        try {
            Query query = session.getWorkspace().getQueryManager().createQuery(stmt, Query.XPATH);
            rows = query.execute().getRows();
        } catch (Exception e) {
    		throw new JcrException(e);
    	}
        
        int total = 0;
        List fileItems = new ArrayList();
        if(rows != null){
        	while (rows.hasNext()) {
                Row r = rows.nextRow();
                try {
                	Node file = (Node) session.getItem(r.getValue("jcr:path").getString());
                	FileItem fileItem = nodeFile2FileItem(webdavContextPath, wspName, file);
                	fileItems.add(fileItem);
                	total++;
                } catch (Exception e) {
            		throw new JcrException(e);
            	}	
            }
        }
        return new Object[] {total, fileItems};
	}
	
	public static Object search(Session session, String webdavContextPath
			, final String str1, final long offset, final long limit) throws JcrException {
	   return search(session, webdavContextPath, "", str1, offset, limit);
    }
    /**
     * 
     * @param path ex: images/gif
     * @param fileItem
     * @return
     */
    public static String write(Session session, final String path, final FileItem fileItem) throws JcrException {
        if (fileItem.getData().length == 0) {
            return null;
        }
    	SimpleCredentials cred = new SimpleCredentials("admin", "admin".toCharArray());
        MimetypesFileTypeMap mt = new MimetypesFileTypeMap();
    	String mimeType = mt.getContentType(fileItem.getOriginalFilename());
    	try {
	    	Node rt = session.getRootNode();
	    	Node contextNode = rt;
	    	Node prNode = null;//parent node
	    	
	    	if(path == null) {
	    		prNode = contextNode;
	    	}else {
	    		String[] strs = path.split("/");
	    		prNode = contextNode;
	    		Node child = null;
	    		for(String str : strs) {
	    			child = null;
	    			if(StringUtils.isNotBlank(str)) {
	        			if(prNode.hasNode(str)) {
	        				child = prNode.getNode(str);
	                	}else {
	                		child =  prNode.addNode(str);	
	                	}
	        			if(child != null) {
	        				prNode = child;
	        			}	
	    			}
	    			
	    		}
	    	}
	    	String fileNodeName = fileItem.getOriginalFilename();
	    	fileNodeName = Utils.normalize(fileNodeName);
	    	fileNodeName = fileNodeName.replaceAll(" ", "");
	    	String oriFileNodeName = fileNodeName;
	    	while(prNode.hasNode(fileNodeName)) {
	    		fileNodeName = oriFileNodeName;
	    		String now = DateFormatUtils.format(new Date(), "yyyyMMddHHmmss");
	    		int atDot =  fileNodeName.lastIndexOf(".");
	    		if(atDot >= 0) {
	    			fileNodeName = fileNodeName.substring(0, atDot) + "-" + now 
	    							+ fileNodeName.substring(atDot);
	    		 }else {
	    			 fileNodeName += "_" + now;
	    		 }
	    	}
	    	Node fileNode = prNode.addNode(fileNodeName, "nt:file");
	    	Node resNode = fileNode.addNode("jcr:content", "nt:resource");
	    	//logger.info("mimeType----------------" + mimeType);
	    	if (mimeType == null || fileNodeName.endsWith(".swf")) {
	            if (fileNodeName.endsWith(".doc")) {
	                mimeType = "application/msword";
	            } else if (fileNodeName.endsWith(".xls")) {
	                mimeType = "application/vnd.ms-excel";
	            } else if (fileNodeName.endsWith(".ppt")) {
	                mimeType = "application/mspowerpoint";
	            } else if(fileNodeName.endsWith(".swf")){
	            	mimeType = "application/x-shockwave-flash";
	            } else {
	                mimeType = "application/octet-stream";
	            }
	        }
	    	
	    	resNode.setProperty(JcrConstants.JCR_MIMETYPE, mimeType);
	    	resNode.setProperty(JcrConstants.JCR_ENCODING, "UTF-8");
	    	resNode.setProperty(JcrConstants.JCR_DATA, new ByteArrayInputStream(fileItem.getData()));
	    	Calendar lastModified = Calendar.getInstance();
	    	lastModified.setTimeInMillis(fileItem.getLastModified());
	    	resNode.setProperty(JcrConstants.JCR_LASTMODIFIED, lastModified);
	    	session.save();
	    	
	    	return fileNode.getPath();
    	} catch (Exception e) {
    		throw new JcrException(e);
    	} 
    }
    public static String write(Session session, final FileItem fileItem) throws JcrException{
    	return write(session, null, fileItem);
    	
    }

	private static FileItem nodeFile2FileItem(String webdavContextPath, String wspName, Node file)
			throws PathNotFoundException, RepositoryException, ValueFormatException {
		Node resource = file.getNode(JcrConstants.JCR_CONTENT);
		
		FileItem fileItem = new FileItem();
		if (resource.hasProperty(JcrConstants.JCR_DATA)) {
			try {
				fileItem.setData(IOUtils.toByteArray(resource.getProperty(JcrConstants.JCR_DATA).getStream()));
			} catch (IOException e) {
				logger.error(e + "");
			}
		    fileItem.setLastModified(resource.getProperty(JcrConstants.JCR_LASTMODIFIED).getDate().getTimeInMillis());
		    fileItem.setMimeType(resource.getProperty(JcrConstants.JCR_MIMETYPE).getString());
		}
		fileItem.setHrefPath(JcrUtils.createHrefPathWebdav(webdavContextPath, wspName, file.getPath()));
		fileItem.setOriginalFilename(file.getName());
		fileItem.setPath(file.getPath());
				
		return fileItem;
	}
	
}
